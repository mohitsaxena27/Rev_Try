package utils;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.*;
import org.dom4j.io.SAXReader;
import org.xml.sax.SAXException;


public class xmlreader {
	public String fileloaction;
	public static String name;
	public static Document doc;
	public xmlreader(String filepath)
	{
		String dir = System.getProperty("user.dir")+File.separator+"src"+File.separator+"test"+File.separator+"resources"+File.separator+"locators"+File.separator;
		fileloaction=dir+filepath;
		System.out.println(fileloaction);
	}
	
public String getlocator(String nodepath) throws DocumentException, InterruptedException
{
	String locator=null;
//	String locator1=null;
	File Inputfile=new File(fileloaction);
	SAXReader xmlreader=new SAXReader();
	Document doc=xmlreader.read(Inputfile);
	name=doc.selectSingleNode("//locators/" + nodepath).valueOf("@name");
	System.out.println(name);
	locator=doc.selectSingleNode("//locators/" + nodepath).getText();
//	locator1=doc.getNodeTypeName();
//	System.out.println(locator1);
	//Log.info(locator);
	return locator;

}

	public Node getlocator1(String nodepath) throws DocumentException, InterruptedException, SAXException {


		Node locator=null;
//	String locator1=null;
		File Inputfile=new File(fileloaction);
		SAXReader xmlreader=new SAXReader();
		doc=xmlreader.read(Inputfile);
		xmlreader.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
		xmlreader.setFeature("http://xml.org/sax/features/external-general-entities", false);
		xmlreader.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
		name=doc.selectSingleNode(nodepath).valueOf("@name");
		System.out.println(name);
		locator=doc.selectSingleNode(nodepath);
		System.out.println(locator.getText());
Map<Node,String> data=new HashMap<>();
data.put(locator,fileloaction);
//		doc.
//	locator1=doc.getNodeTypeName();
//	System.out.println(locator1);
		//Log.info(locator);

		return locator;

	}

	public void updateAttribute(Node nodepath) throws DocumentException, InterruptedException, SAXException {
		{
			((Element) nodepath).addAttribute("image", "Testing");
		}


	}




	}
