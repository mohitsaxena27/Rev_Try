package core;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.gson.JsonElement;
import io.restassured.http.ContentType;
import io.restassured.http.Method;

import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.xml.bind.JAXBException;
import javax.xml.parsers.ParserConfigurationException;

import io.restassured.response.Response;
import org.dom4j.DocumentException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.xml.sax.SAXException;

public interface apiHelper {


	int RESPONSE_CODE_200 = 200;
	int RESPONSE_CODE_201 = 201;
	int RESPONSE_CODE_400 = 400;
	int RESPONSE_CODE_401 = 401;
	int RESPONSE_CODE_204 = 204;
	int RESPONSE_CODE_404 = 404;
	int RESPONSE_CODE_405 = 405;
	int RESPONSE_CODE_202 = 202;
	int RESPONSE_CODE_500 = 500;

	/**
	 * Method to Authenticate the Requests.
	 *
	 * @param type     - This the type of Authentication used by Service. for Example <b>"Basic"</b>,<b>"preemptive"</b> etc.
	 * @param username - This user name.
	 * @param password - This password or any secret key ot Token key which required to authenticate.
	 */
	void authentication(String type, String username, String password);

	/**
	 * Method to update the Request Header Attributes.
	 *
	 * @param HeaderKey - This is the name of the header key needs to be updated.
	 * @param Value     - This is the new value which needs to be updated for the Header key.
	 */
	void updateRequestHeader(String HeaderKey, String Value);

	/**
	 * This method is to read the input requests template which latter used to generate the pay load.
	 *
	 * @param paramsMap - Path of the Input template file
	 * @throws IOException
	 */

	void addRequestParameters(Map<String, String> paramsMap);

	/**
	 * This method is to read the input requests from parameter.
	 *
	 * @param contentType - Map of parameters.
	 * @throws IOException
	 */

	void setContentType(String contentType);

	void setContentTypeRestAssured(ContentType contentType);

	/**
	 * This method is to set contentType.
	 *
	 * @param path - Set contentType
	 * @throws IOException
	 */


	String readRequestTemplate(String path) throws IOException;

	/**
	 * This method is update the attribute of the a key into the Request template.
	 *
	 * @param Filename - Path of the Input template file
	 * @param Key      - Name of the Key/NODE in case of JSON and XML.<b> "Customer.Name. FirstName"</b>
	 * @param Value    - Updated value of the Attribute.
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 * @throws Exception
	 */
	void updateAttributeInRequestBody(String Filename, String Key, String Value) throws IOException, SAXException, ParserConfigurationException, Exception;
	void newUpdateAttributeInRequestBodyInSamePayload(String payLoad, String Key, String value) throws Exception;

	/**
	 * @param Filename
	 * @param values   : hashmap with xml node as key and values
	 * @throws IOException
	 * @throws SAXException
	 * @throws ParserConfigurationException
	 * @throws Exception
	 */
	void updateAttributeInRequestBody(String Filename, HashMap<String, String> values) throws IOException, SAXException, ParserConfigurationException, Exception;

	/**
	 * Generate the Final Pay load with the updated input data.
	 * Nothing to Return
	 */

	void generatePayLoad();
	/** Submit the Request to Server with Specified Resource and Method.
	 * @param method - Name of the Methode to be used. for Example <b> GET</B>, <b> POST</B> etc.
	 * @param URI - Service URI. For Example - <b>"/Create"</b>
	 * Nothing to Return
	 */

	/**
	 * Validate Response Structure
	 *
	 * @param path
	 * @author chirag.s
	 */
	void validateResponseJsonSchema(String path);

	/**
	 * Validate Response Structure
	 *
	 * @param path
	 * @author chirag.s
	 */
	void validateResponseXMLSchema(String path);

	void submitRequest(Method method, String URI);

	/**
	 * Assert an string to be contains on the response Body
	 *
	 * @param ExpectedData - Expected String to contains in response body.
	 *                     Nothing to Return
	 */
	void assertStringInResponceBody(String ExpectedData);

	/**
	 * Assert Status code of the Response
	 *
	 * @param ExpectedStatusCode - Expected Status code return by Service call.
	 *                           Nothing to Return
	 */
	void assertStatusCode(int ExpectedStatusCode);

	/**
	 * Assert Status line of the Response
	 *
	 * @param ExpectedStatusLine - Expected Status line return by Service call.
	 *                           Nothing to Return
	 */
	void assertStatusLine(String ExpectedStatusLine);

	/**
	 * Assert specific header key value in the response.
	 *
	 * @param HeaderName          - Name of the HeaderKey to be Verified.
	 * @param ExpectedheaderValue - Expected value for the HeaderKey return by Service call.
	 *                            Nothing to Return
	 */
	void assertHeaderattribute(String HeaderName, String ExpectedheaderValue);

	/**
	 * Assert specific Body Key value in the response.
	 *
	 * @param Node          - Name of the Body Key to be Verified.
	 * @param Expectedvalue - Expected value for the Body Key return by Service call.
	 *                      Nothing to Return
	 * @throws ParserConfigurationException
	 * @throws IOException
	 * @throws SAXException
	 * @throws DocumentException
	 */
	void assertResponceBodyAttribute(String Node, String Expectedvalue) throws SAXException, IOException, ParserConfigurationException, DocumentException;

	/**
	 * Store specific Body Key returned in response.
	 *
	 * @param Node - Name of the Body Key to be Verified.
	 * @return a String value which conatns the Value of Node in s
	 */
	String SaveAttributevalue(String Node) throws DocumentException;

	/**
	 * JSON input generator
	 *
	 * @param templatefile - JSON input file Template file path.
	 * @param Node         - Name of the node needs to be updated into Input Body
	 * @param Value        - New Value of the Node.
	 */
	JSONObject Inputgenerator(JSONObject templatefile, String Node, String Value);

	/**
	 * Append URI with parameters
	 *
	 * @param uri
	 * @param headerMap for uri
	 * @author chirag.s
	 */
	String appendUriWithParameters(String uri, Map<String, String> headerMap);

	/**
	 * Get Base URI
	 *
	 * @param uri
	 * @author chirag.s
	 */
	String getBaseURI(String uri);

	/**
	 * Validate Response Structure
	 *
	 * @param path
	 * @throws IOException
	 * @throws JAXBException
	 * @author Dipesh.Jain
	 */
	void validateResponseXMLSchemaWithoutSoapEnvelope(String path) throws IOException, JAXBException;

	/**
	 * Read Pay load from file
	 *
	 * @param Requestpath
	 * @author chirag.s
	 */
	void readPayload(String Requestpath);

	/**
	 * @param node
	 * @author chirag.s
	 */
	String getSingleValueFromResponse(String node);

	/**
	 * @param actual
	 * @param expected
	 * @author ashwani.s
	 */
	void Stringcomparator(String actual, String expected);

	/**
	 * @param Node
	 * @param Value
	 * @author ashwani.s
	 */
	void UpdatedAttributeinxmlPayload(String Node, String Value) throws DocumentException, IOException, SAXException, ParserConfigurationException;

	/**
	 * @param Node
	 * @param Value
	 * @author ashwani.s
	 */
	void UpdatedAttributeinJsonPayload(String Node, String Value, boolean isstring) throws DocumentException, IOException, SAXException, ParserConfigurationException;
	void UpdatedAttributeinJsonPayload1(String Node, String Value, boolean isstring) throws DocumentException, IOException, SAXException, ParserConfigurationException;

	void removeAttribureinJsonPayload(String pathToRemove) throws JsonProcessingException;

	void UpdatedAttributeinJsonPayloadGeneric(String Node, String Value, boolean isstring) throws DocumentException, IOException, SAXException, ParserConfigurationException;
	void updateAttributeInJsonBody(String Filename, String inventorySource, String availabilityType, String sku, String storeNumbers) throws org.json.simple.parser.ParseException, IOException ;
	void addJsonArrayAttributesInJsonBody(String pincode, String availabilityType, String vendor, String partNumber, String skuId) throws org.json.simple.parser.ParseException, IOException ;
	void DeleteRequest();
	void payloadFromPOJOClass(String PayloadValue);
	/**
	 * @param method
	 * @param URI
	 * @author dipesh.j
	 */
	void submitRequestWithHeader(Method method, String URI);

	/**
	 * @param Node
	 * @param expected
	 * @throws SAXException
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @throws DocumentException
	 * @author chirag.s
	 */
	void assertNodeIsPresent(String Node, boolean expected) throws SAXException, IOException, ParserConfigurationException, DocumentException;

	/**
	 * Compait two strings
	 *
	 * @param actual   Actual boolean need to to validate
	 * @param expected expected bollean againt which validation need to be perform
	 * @author ashwnai.S
	 */
	void Booleancomparator(Boolean actual, Boolean expected);

	/**
	 * Returns the Encoded Data into Base64Formate
	 *
	 * @param data Data to be encoded
	 * @return encoded data
	 * @author ashwnai.S
	 */

	String Base64Encoder(String data) throws SAXException, IOException, ParserConfigurationException, DocumentException;

	/**
	 * Returns the Current Payload
	 *
	 * @return Retuns the current payload
	 * @author ashwnai.s
	 */
	String ReturnPaylod() throws SAXException, IOException, ParserConfigurationException, DocumentException;
	/**
	 * @author Dipesh.J
	 * @param dateStr
	 * @param dateFormat
	 */
    boolean isValidDateFormat(String dateStr, String dateFormat);
	/**
	 * Parial Compairison two strings
	 *
	 * @param actual   Actual String need to to validate
	 * @param expected expected String againt which validation need to be perform
	 * @author ashwnai.S
	 */
    void Partialstringcomparator(String actual, String expected);
	 /**
			 * Exact Compair two Json object
	 *
			 * @param actual   Actual String need to to validate
	 * @param expected expected String againt which validation need to be perform
	 * @author ashwnai.S
	 */
     void Jsoncomparator(JsonElement actual, JsonElement expected);
	/**
	 * Submit a Form Data into the Request
	 *
	 * @param key   Name of the Key needs to be passed as form data
	 * @param Value Value of the form key
	 * @author ashwnai.S
	 */
    void generatemultipart(String key, String Value);
	/**
	 * Return the Current Responce
	 *
	 *
	 * @author ashwnai.S
	 */
    String RetrurnResponce();
  
  /**
	 * @author Dipesh.J
	 * @param dateFormat
	 */
  String getTodaysDateinFormat(String dateFormat);
	/**
	 * @author Dipesh.J
	 * @return orderNumber
	 */
    public void updateMultipart(String HeaderKey, String value, String ContentType);
    public void clearRequestHeaders();
    public void setRequestBody(String json);
	public String generateAccessToken(String Baseurl,String Granttype,String clientId, String clientSecret,String tokenurl);
    public void addQueryParameters(String key, String value);
}