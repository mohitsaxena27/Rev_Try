package core;

import com.google.gson.JsonElement;
import io.appium.java_client.android.nativekey.AndroidKey;
import io.restassured.http.ContentType;
import io.restassured.http.Method;
import org.dom4j.DocumentException;
import org.json.simple.JSONObject;
import org.openqa.selenium.WebElement;
import org.xml.sax.SAXException;

import javax.xml.bind.JAXBException;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public interface mobileHelper {


	void Clickon(WebElement ele) throws Exception;

	/** Enter the value in an input field.
	 * @param el Web element instance need to be be enter
	 * @param value is the value which needs to be entered i the input field
	 * Nothing to be returned here.
	 * @throws IOException
	 * @throws InterruptedException
	 *
	 */
    void SendKeys(WebElement el, String value) throws InterruptedException, IOException;
	/** Verify the page title
	 * @param Expectedtitle expected title should be of the current web page
	 * Nothing to be returned here.
	 * @throws IOException
	 * @throws InterruptedException
	 *
	 */
    void VerifyTitle(String Expectedtitle);
	/** Verify the visual text for the element
	 * @param el Webelement under test
	 * @param Expectedtext expected text should displayed
	 * Nothing to be returned here.
	 * @throws IOException
	 * @throws InterruptedException
	 *
	 */
    void VerifyText(WebElement el, String Expectedtext);
	/** Get the Web elemment based on the locator
	 * @param locator Locotor of the element
	 * @return Webelement instance
	 * Nothing to be returned here.
	 * @throws IOException
	 * @throws InterruptedException
	 *
	 */

    WebElement getMobileelement(String locator) throws InterruptedException;
	void SendKeys(AndroidKey key) throws InterruptedException, IOException;
}