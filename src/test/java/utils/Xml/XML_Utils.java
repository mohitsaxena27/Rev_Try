package utils.Xml;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.*;
import java.io.StringReader;

public class XML_Utils {
    public static String getValue(String xml, String xpathExpression) {
        try {
            Document document = DocumentBuilderFactory
                    .newInstance()
                    .newDocumentBuilder()
                    .parse(new InputSource(new StringReader(xml)));
            XPath xpath = XPathFactory.newInstance().newXPath();
            return xpath.evaluate(xpathExpression, document);
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse XML", e);
        }
    }
}
