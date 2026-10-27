package utils.Xml;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xmlunit.builder.DiffBuilder;
import org.xmlunit.diff.DefaultNodeMatcher;
import org.xmlunit.diff.Diff;
import org.xmlunit.diff.ElementSelectors;
import org.xmlunit.util.Convert;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class XmlComparisonUtil {
    public static Diff compareXml(String expected, String actual) {

        XmlToleranceConfig config = new XmlToleranceConfig();

        return DiffBuilder.compare(sortReferenceNums(sanitizeXml(expected)))
                .withTest(sortReferenceNums(sanitizeXml(actual)))
                .ignoreWhitespace()
                .checkForSimilar()
                .withNodeMatcher(new DefaultNodeMatcher(
                        ElementSelectors.conditionalBuilder()
                                .whenElementIsNamed("referenceNum")
                                .thenUse(
                                        ElementSelectors.byXPath("./type/text() | ./value/text()",
                                                ElementSelectors.byNameAndText)
                                )
                                .elseUse(ElementSelectors.byName)
                                .build()))
                .withDifferenceEvaluator(new CustomDifferenceEvaluator(config))
                .build();
    }

    public static String sanitizeXml(String xml) {
        if (xml == null) return "";

        return xml
                .replace("\uFEFF", "")   // Remove BOM
                .replaceAll("^[^<]+", "") // Remove anything before first <
                .trim();
    }

    public static String sortReferenceNums(String xml) {
        try {

            Document doc = Convert.toDocument(new StreamSource(new StringReader(xml)));

            NodeList referenceNumsList = doc.getElementsByTagName("referenceNums");

            if (referenceNumsList.getLength() == 0) {
                return xml; // no referenceNums in this XML
            }

            Node referenceNums = referenceNumsList.item(0);
            NodeList nodes = referenceNums.getChildNodes();

            List<Element> refs = new ArrayList<>();

            for (int i = 0; i < nodes.getLength(); i++) {
                if (nodes.item(i) instanceof Element) {
                    refs.add((Element) nodes.item(i));
                }
            }

            refs.sort(Comparator.comparing(e ->
                    e.getElementsByTagName("type").item(0).getTextContent()
                            + e.getElementsByTagName("value").item(0).getTextContent()
            ));

            referenceNums.setTextContent("");

            for (Element e : refs) {
                referenceNums.appendChild(e);
            }

            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            StringWriter writer = new StringWriter();

            transformer.transform(new DOMSource(doc), new StreamResult(writer));

            return writer.toString();

        } catch (Exception e) {
            return xml; // fallback to original XML if anything fails
        }
    }
}
