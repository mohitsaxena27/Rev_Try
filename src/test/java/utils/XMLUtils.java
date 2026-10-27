package utils;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

//import org.dom4j.Document;
//import org.dom4j.DocumentException;
//import org.dom4j.Node;
//import org.dom4j.io.SAXReader;

import io.restassured.response.Response;

import org.w3c.dom.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;

public class XMLUtils {
		
//	public static List<String> getNodeValues(Response response, String nodePath) throws DocumentException {
//		SAXReader xmlreader=new SAXReader();
//		Document doc = xmlreader.read(response.asInputStream());
//		@SuppressWarnings("unchecked")
//		List<Node> nodes = doc.selectNodes(nodePath);
//		List<String> nodeValues = new ArrayList<String>();
//		for(Node node : nodes ) {
//			String value = node.getText();
//			nodeValues.add(value);
//		}
//		return nodeValues;
//	}
//
//	public static String getNodeValue(Response response, String nodePath) throws DocumentException {
//		SAXReader xmlreader=new SAXReader();
//		Document doc = xmlreader.read(response.asInputStream());
//		Node node = doc.selectSingleNode(nodePath);
//		String value = node.getText();
//		return value;
//	}

	public static String removeAuthNode(String xml, String node) throws Exception {
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			factory.setNamespaceAware(true);

			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));

			NodeList nodes = doc.getElementsByTagNameNS("*", "auth");  // namespace-safe
			System.out.println("Auth nodes found: " + nodes.getLength());

			if (nodes.getLength() > 0) {
				Node authNode = nodes.item(0);
				authNode.getParentNode().removeChild(authNode);
			} else {
				System.out.println("❌ <auth> node NOT found");
			}

			Transformer transformer = TransformerFactory.newInstance().newTransformer();
			transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");

			StringWriter writer = new StringWriter();
			transformer.transform(new DOMSource(doc), new StreamResult(writer));

			String result = writer.toString();
			System.out.println("Updated XML:\n" + result);

			return result;

		} catch (Exception e) {
			throw new RuntimeException("Failed to remove <auth> node", e);
		}
	}

}
