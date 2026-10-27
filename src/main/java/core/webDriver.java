package core;

import org.openqa.selenium.WebDriver;
import org.zaproxy.clientapi.core.ClientApi;
import org.zaproxy.clientapi.core.ClientApiException;

import java.io.IOException;

public interface webDriver {
	/** Initialized the URL on specified Browser and the Also run the Selenium Grid and Node if Grid Mode is set as true
	 * Nothing to be returned here.
	 * @param browser - Name of the browser <b> Crome,FireFox,IE, Edge etc.</b>
	 * @param BaseURL - Url of the application to be tested <b> https://360logica.com.</b>
	 * @param Grid - Boolian option to enable the Grid Mod <b> True </b>OR <b>False</b>. by Default value is False
	 * @throws Exception 
	*/
    WebDriver webinit(String browser, String BaseURL, Boolean Grid, Boolean proxy, boolean HeadlessMode) throws Exception;
    public WebDriver LaunchBrowserWithLink(String Link,Boolean HeadlessMode) throws InterruptedException;

//	public WebDriver webinit(String browser, String BaseURL, Boolean Grid,Boolean proxy,Boolean headless) throws Exception;
ClientApi ReturnZapScanner();
	/** Get the Web elemment based on the locator
	 * @param locator Locotor of the element
	 * @return Webelement instance
	 * Nothing to be returned here.
	 * @throws IOException
	 * @throws InterruptedException
	 *
	 */


}



