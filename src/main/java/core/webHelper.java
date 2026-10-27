package core;
import java.awt.*;
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.*;

public interface webHelper {

	/** Close all the Child Windows if any open excepts the parent Window/Default window.
	 * Nothing to be returned here.
	*/
    void CloseAllWindows();
	/** Switch to the last open browser tab. If no addition tab opened, Driver will be remain on the Default Tab
	 * Nothing to be returned here.
	*/
    void SwitchToLastTab();
	/** Wait till IFrame/Frame on the page get loaded
	 * Nothing to be returned here.
	 * @param framelocator Web element locator for the iframe/frame. For example: CSS selector/XPATH etc.
	*/
    void GetIframeLoaded(String framelocator);
	/** Waiting for the Page to be ready. This method is looking of the Ready State of the Current Page using Java script commands.
	 * Nothing to be returned here.
	 * @throws Exception
	*/
    void WaitforPageToBeReady() throws Exception;
	/** Get the Title of the current opened page.
	 * @return Page title as String.
	*/
    String GetTitle();
	/** Open the URL using get method of WebDriver. The URL read from Configuration file as Key value pair.
	 * @param environment Name of the Environment mentioned into the Configuration file.
	 * Nothing to be returned here.
	*/
    void OpenURL(String environment);
	/** Open the URL using get method of WebDriver. This is the Updated version OpenURL which includes timeout for the page to be loaded
	 * @param environment Name of the Environment mentioned into the Configuration file.
	 * Nothing to be returned here.
	 * @throws Exception
	*/
    void OpenURLV2(String environment) throws Exception;
	/** Open the URL using get method of WebDriver. Here the URL can be passed as string at the time of calling this function
	 * @param URL Complete Web address(URL)
	 * Nothing to be returned here.
	*/
    void GetURL(String URL);
	/** Refreshes/Reload the current page
	 * Nothing to be returned here.
	 * @throws Exception 
	*/
    void PageRefresh() throws Exception;
	/**This method returns the Current Page URL
	 * @return the URL of the Current page as String
	*/
    String CurrentURL();
	/** Capture the Screenshot of Web Element and Returned as Base64 String.
	 * @param ele Web Element which Screenshot needs to be captured
	 * @return the URL of the Current page as String
	*/
    String CaptureScreenShotForElement(WebElement ele);
	/** Capture the Screenshot ofFull screen even with Scroll on the page and Returned as Base64 String.
	 * @param driver WebDriver instance active.
	 * @return the URL of the Current page as String
	*/
    String CaptureFullScreenShot(WebDriver driver);
	/** Click on an Web element. 
	 * @param ele Web element instance need to be clicked on
	 * Nothing to be returned here.
	 * @throws Exception 
	*/
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
    WebElement getwebelement(String locator) throws InterruptedException;
	String getAdsOnPage(String string);
	String Getattribute(WebElement el, String attributename);
	boolean validateDataTrackResearchPage();
	String getText(String locator);
	void javascriptButtonClick(WebElement webElement);
	boolean isElementPresent(String locator);
	void SendkeaboardKeys(WebElement el, Keys k) throws InterruptedException;
	String pollCurrentTime(String className, String timeStamp, String timeOut) throws InterruptedException;
	void Moveon(WebElement el);
	void HandleAngularwait();
	void HandleAngularmain();
	void Stringcomparator(String actual, String expected);
	void WaitforElementtobeclickable(String locator) throws InterruptedException;
	void waitForElementLoad(int x);
	int getwebelementscount(String locator) throws InterruptedException;
	List getWebElements(String locator) throws InterruptedException;
	String GetText(WebElement el);
	void ScrollToBottom();
	void ScrollToTop();
	void ScrollToElement(WebElement element) ;
	void verifyElementNotToBePresent(String Locators) throws InterruptedException;
	void verifyElementToBePresent(String Locators) throws InterruptedException;
	void Partialstringcomparator(String actual, String expected);
	void navigateBack();
	void javascriptexecutor(WebElement el) throws InterruptedException;

	void Select(WebElement el, String value)throws IOException, InterruptedException;
	void windowhandle() throws InterruptedException;
	void switchToParentWindow();
	void Clear(WebElement el) throws IOException, InterruptedException;
	void myClear(String xpath);
	void mouseOver(String locator);
	void mouseOver(WebElement el);
	void clearTextBox(WebElement el);
	String getAttributeValueUsingJavascript(WebElement el);
	void enableWebElement(String xpath);
	void disableWebElement(String xpath);

	WebElement getWebElementWithRelative(String locator, WebElement wl, String relative) throws InterruptedException;

	void safeJavaScriptClick(WebElement element) throws Exception;
	WebElement getShadowWebElement(String locator);
	void waitforElementtobeclickable(String locator) throws InterruptedException;
	void waitForElementNotToBeVisible(String wl);
	void waitForElementToBeClickable(WebElement element);
	void waitUntilTheElementIsVisible(WebElement wl);
	void verifyCurrentURL(String ExpectedURL);
	String returnElementAttrubuteValue(WebElement el, String AttributeName);
	void selectOptionByValue(WebElement el, String value);
	void selectOptionByText(WebElement el, String Text);
	void SwitchWindowByIndex(String index);
	void SwitchToParentWindod();
    void CloseCurrentWindows();
	void CloseWindowByIndex(String index);
	void GOto(String url);
	void SwitchToParentFrame();
	void SwitchToFrameByIndex(String index);
	void SwitchToFrameByElement(WebElement wl);
	void Refresh();
	void Back();
	void ScrollIntoView(WebElement el) throws InterruptedException;
	void waitforTitleContains(String Title);

	WebElement getWebElementById(String locator) throws InterruptedException;
	void SwitchToNextTab();
	void EnterTextUsingAction() throws InterruptedException;
	void EnterTextUsingActions(String s);
	void move_to_element() throws InterruptedException;

	void dragAndDrop(WebElement sourceElement, WebElement TargetElement);
	void acceptAlert();
	boolean isAlertPresent();
	void move_to_element(WebElement wl) throws InterruptedException ;
	void ScrollLast();
	void ClickUsingActions(WebElement wl) throws InterruptedException;
	void SendKeysUsingActions(WebElement wl, String typeLetter) throws InterruptedException;
	void EnterdownkeyUsingAction(int num) throws InterruptedException;
	void EnterUsingActions() throws InterruptedException;
	void ClearAndEnterDate(WebElement wl, String Date) ;
	void EnterTabUsingActions() throws InterruptedException;
	String getAttrubuteOfFocusedElement(String attribute);
	void ClickUsingActions() throws InterruptedException;
	void SendKeysUsingActions(String text) throws InterruptedException;
	WebElement getFocusedElement();
	void Send_CTRL_S();
	void OpenUrlInNewTab(int TabNumber, String Url);
	void CloseActiveWindows();
	void ImplicitlyWait(int Time);
	String  getWindowHandle();
	void returnToWindow(String windowname);
	void OpenNewTab(int TabNumber);
	String getText(WebElement wl);
	public void ClickOnElement(WebElement element);
	public void SelectComboBoxOption(WebElement wl,WebElement wl1);
	public WebElement passwebelement(String locator) throws InterruptedException;
	public String returAttrubuteValue(WebElement el, String AttributeName);
	public String ExpectedDate(String P_Expected_Date);
	public void ScrollIntoComplexView(String Locator) throws InterruptedException;
	public String returAttrubuteValueusingJs(WebElement el);
	public String returnDOMAttrubuteValue(WebElement el);
    public String ReturnDate(String P_Expected_Date);
//	public  void UploadFile(String filePath) throws InterruptedException, AWTException;

    public void EnterTextUsingJS(WebElement wl, String Value);
    public void scrollDownWithJS(int Key) throws InterruptedException;
    public void setPermission( String permission, boolean enable);
    public void enablePermissionSet(String First, String Second, String operators, String permissionSetName);
	public void Scrolltobottom()throws InterruptedException;
    public WebElement HandlingMultipleElements(String locators, int index) throws InterruptedException;
//    public void WaitforURLUPdate()throws InterruptedException;
     public void dragAndDropWithOffset(WebElement sourceElement, WebElement TargetElement);
    public void dragAndDropWithJS(String script, String sourceField, String targetField);
    public void scrollUpWithJS(int Key) throws InterruptedException;
	public String GetCurrentURL();
    public int NumberOfWindow();
    public void scrollAndSelectRecord(String recordName) throws InterruptedException;
    public void ScrollUsingJSUntilElementIsNotFound(String locator) throws InterruptedException;
    public void scrollRecordFromList(String recordName);
    public void EnterTimeUsingJS(WebElement wl, String Value);

    public  String getJsonValue(String jsonString, String attributePath);
    public void scrollHorizontal(WebElement wl);
    public String GetDomAttribute(WebElement el, String attributeName);
    public void ScrollToHelpText(WebElement el);
    public String getRoundedTimeBeforeNow(long minutes);
    public List<WebElement> getwebelements(String locator);
	public String ReturnCurrentDateAndTime(String P_Expected_Date, String pattern);
    public WebElement Errorwebelement(String locator);
    public void openNewTab(String url);
    public void switchWindowRemaining();
    public void SwitchBackToMainWindow();
    public String ReturnDateTime(String P_Expected_Date);
    public String ReturnDateInSpecifiedFormat(String P_Expected_Date , String format);
    public void BrowserZoom(String number);
    public void waitUntilTheElementIsNotVisible(String  element);
    public String waitForAttributeValue(WebElement element, String attribute, int timeout);
	public String getOverlayText(WebElement element);
    public void waitUntilElementIsVisible(String locator);
    public WebElement getWebElementWithVisibility(String locator);
    public void switchToLatestWindow();
    public void SwitchToLastWindow();
    public  void closeAndSwitchToPrevious();
    public boolean checkSelectedUsingJS(WebElement checkbox);
    public int getwebelementscount2(String locator) throws InterruptedException;
    public void getSalesforceSearchInput(String value) ;
    public void dragAndDropWithJS(String script, WebElement sourceField, WebElement targetField);
    public void dragFromParentToIframe(String sourcelocator, String locator);
    public void scrollRecordFromList2(String recordName) throws InterruptedException;
    public String getBackgroundColorUsingJs(WebElement el);
    public void move_to_element_With_JS(WebElement element);
    public void ScrollPageUsingJs() throws InterruptedException;
    public String getTextUsingJS(WebElement wl);
    public WebElement NavigateChildWelElement(WebElement el, String xpathString);
    public void VerifyChildElementDisplayed(WebElement el, String xpathString);
    public String ReturnDateInSpecifiedTimeZoneAndFormat(String P_Expected_Date ,String TimeZone, String format);
    public void WaitForCurrentURLChange(String OldURL);
    public int NumOfTab();
    public void EnterJsonText(WebElement el, String Value) throws Exception;
    public void WaitForLongElementClickable(String locators);
    public void ToleranceTime(String Actaul, String Expected, String Format);
    public  boolean waitForUrlContains(String UrlPart);
    public String ReturnDateTimeInSpecifiedFormat(String P_Expected_Date , String format);
    public void ClickAndHoldWithMoveOffset(WebElement el);
    public void ScrollOnModal();
	public List<WebElement> waitUntilVisibleAndReturnElements(String locator);
    public void HandleWindowsAndClickOnLinkText(String Frame, String Text) throws InterruptedException;
    public void scrollHeight(WebElement wl);
	public List<String> returnAllOptions(WebElement wl);
    public String getPaySettlementPdfCookies();
    public void selectOptionByIndex(WebElement el, String index);
}

