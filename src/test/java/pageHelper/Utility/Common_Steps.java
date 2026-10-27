package pageHelper.Utility;

import Listner.ToastContext;
import com.aventstack.extentreports.MediaEntityBuilder;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang.StringUtils;
import org.dom4j.DocumentException;
import org.openqa.selenium.*;
import org.openqa.selenium.support.Color;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.*;
import utils.MailUtility.maiUtility;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Log4j
public class Common_Steps {
    public webHelper webDriver;
    public apiHelper apiDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader iframexml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Apis ca;

    public Common_Steps(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver = new baseDriverHelper(DriverInstance.getApiDriver(), DriverInstance.API_RESPONCE_THREAD_LOCAL.get());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_Summary.xml");
        iframexml = new xmlreader("Generics" + File.separator + "CommonFrame.xml");
        ca = new Common_Apis(DriverInstance);
    }

    @When("Login into Salesforce")
    public void loginIntoSalesforce() throws Exception {
        String UserName = PropReader.get("UserName");
        String Password = PropReader.get("Password");
        webDriver.waitForElementLoad(2);
        if (!webDriver.GetTitle().equalsIgnoreCase("Home | Salesforce")) {
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("UserName")), UserName);

            if(webDriver.getwebelementscount(xml.getlocator("Passwordxpath"))>0) {
                webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("Password")), Password);
                webDriver.waitForElementLoad(2);
            }
            else{
                webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LoginButton")));
                webDriver.waitForElementLoad(1);
                webDriver.waitUntilElementIsVisible(xml.getlocator("Passwordxpath"));
                webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("Password")), Password);
                webDriver.waitForElementLoad(2);
            }
            System.out.println(11);
            try {
                System.out.println(12);
                webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LoginButton")));
                webDriver.waitForElementLoad(3);
                System.out.println(13);
            } catch (Exception e) {
                System.out.println(4);
            }
        } else {
            webDriver.waitForElementLoad(3);
        }
        boolean flag = webDriver.waitForUrlContains("/lightning/page/home");
        if (!flag) {
            openFromAppLauncher("Transportation");
            webDriver.waitForElementLoad(3);
        }
        String Text = webDriver.getText(webDriver.passwebelement(xml.getlocator("VerifyAppName")));
        if (!Text.contains("Transportation")) {
            openFromAppLauncher("Transportation");
            webDriver.waitForElementLoad(3);
        }
        File file = new File(System.getProperty("user.dir") + File.separator + "DownloadedFiles");
        DriverInstance.setVariable("DownloadDirectory", file.getAbsolutePath());
//        DriverInstance.setVariable("TestCaseTimeZoneDSTEnabled", "NA");
        maiUtility.startTest();
    }

    @When("Reset Time to get New Email")
    public void ResetTime() throws Exception {
        maiUtility.startTest();
    }

    @When("Go to Home Page")
    public void Homepage() throws Exception {
        String url = PropReader.get("application_url");
        webDriver.GetURL(url + "/lightning/page/home");
    }

    @Then("Click on Partial Link Text {string} on Page")
    public void clickOnLinkPartialTextOnPage(String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.waitForElementLoad(1);
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("*", "span").replace("{paramlink}", arg1)));

    }

//    @Given("Open {string} from App Launcher")
//    public void openFromAppLauncher(String arg0) throws Exception {
//        try {
//            webDriver.WaitforElementtobeclickable(xml.getlocator("AppLauncher"));
//            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("AppLauncher")));
//            Thread.sleep(1000);
//            int count = webDriver.getwebelementscount(xml.getlocator("SearchApp"));
//            if (!(count > 0)) {
//                webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("AppLauncher")));
//            }
//            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SearchApp")));
//            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("SearchApp")), arg0);
//            Thread.sleep(1000);
//            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("AppLink").replace("{paramlink}", arg0)));
//            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("AppLink").replace("{paramlink}", arg0)));
//            Thread.sleep(500);
//        } catch (Exception e) {
//            webDriver.PageRefresh();
//            webDriver.waitForElementLoad(2);
//            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("AppLauncher")));
//            Thread.sleep(1000);
//            webDriver.verifyElementToBePresent(xml.getlocator("SearchApp"));
//            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("SearchApp")), arg0);
//            Thread.sleep(1000);
//            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("AppLink").replace("{paramlink}", arg0)));
//            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("AppLink").replace("{paramlink}", arg0)));
//            Thread.sleep(500);
//
//        }
//    }



    @Given("Open {string} from App Launcher")
    public void openFromAppLauncher(String appName) throws Exception {

        Exception lastException = null;

        for (int attempt = 1; attempt <= 3; attempt++) {
            try {
                System.out.println(
                        "Opening " + appName + " - Attempt " + attempt
                );

                String launcher = xml.getlocator("AppLauncher");
                String search = xml.getlocator("SearchApp");
                String appLink = xml.getlocator("AppLink")
                        .replace("{paramlink}", appName);

                // Open the App Launcher if the search field is not present.
                if (webDriver.getwebelementscount(search) == 0) {
                    webDriver.WaitforElementtobeclickable(launcher);
                    webDriver.ClickOnElement(
                            webDriver.getwebelement(launcher)
                    );
                }

                webDriver.waitUntilTheElementIsVisible(
                        webDriver.getwebelement(search)
                );

                // Re-fetch the search element for each attempt.
                webDriver.SendKeys(
                        webDriver.getwebelement(search),
                        appName
                );

                webDriver.waitUntilTheElementIsVisible(
                        webDriver.getwebelement(appLink)
                );

                webDriver.safeJavaScriptClick(
                        webDriver.getwebelement(appLink)
                );

                System.out.println(
                        "Successfully opened " + appName
                );
                return;

            } catch (Exception e) {
                lastException = e;

                System.err.println(
                        "Attempt " + attempt + " failed: " +
                                e.getClass().getSimpleName() + " - " +
                                e.getMessage()
                );

                if (attempt < 3) {
                    try {
                        webDriver.PageRefresh();
                        webDriver.waitForElementLoad(2);
                    } catch (Exception recoveryException) {
                        System.err.println(
                                "Recovery failed: " +
                                        recoveryException.getMessage()
                        );
                    }
                }
            }
        }

        throw new Exception(
                "Unable to open " + appName +
                        " after 3 attempts.", lastException
        );
    }


    @Then("Go to {string} Object")
    public void goToModule(String arg0) throws Exception {
        Thread.sleep(1000);
        webDriver.waitforElementtobeclickable(xml.getlocator("SpanTextObject").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SpanTextObject").replace("{paramlink}", arg0)));
        if (arg0.equalsIgnoreCase("Loads")) {
            webDriver.Refresh();
        }

    }

    @Then("Go to {string} via {string} Menu")
    public void goToViaMenu(String arg0, String arg1) throws Exception {
        Thread.sleep(1000);
        webDriver.waitforElementtobeclickable(xml.getlocator("SpanTextTab").replace("{paramlink}", arg1));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SpanTextTab").replace("{paramlink}", arg1)));
        Thread.sleep(1000);
        webDriver.waitforElementtobeclickable(xml.getlocator("MenuObject").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("MenuObject").replace("{paramlink}", arg0)));

    }


    @Then("Logout from Applications")
    public void logoutFromApplications() throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ProfileIcon")));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ProfileIcon")));
        Thread.sleep(2000);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", "Log Out")));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", "Log Out")));
        webDriver.waitforTitleContains("Login | Salesforce");
    }

    @Then("Go to {string} Tab")
    public void goToTab(String arg0) throws Exception {
        Thread.sleep(1000);
        if (webDriver.getwebelementscount(xml.getlocator("LinkText").replace("{paramlink}", arg0)) > 0) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
            webDriver.waitforElementtobeclickable(xml.getlocator("LinkText").replace("{paramlink}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
        } else {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
            webDriver.waitforElementtobeclickable(xml.getlocator("LinkText").replace("{paramlink}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));

        }
    }

    @Then("Search and Select {string} from List")
    public void searchAndSelectTP(String arg0) throws Exception {

        try {
            if (arg0.equalsIgnoreCase("Global Default")) {
                searchAndSelectRecordsUsingAPI("rtms__TransportationProfile__c", "Global Default");
            }
            else {
                try {
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ButtonIconTitleContains").replace("{paramlink}", "Select a List View:")));
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("ButtonIconTitleContains").replace("{paramlink}", "Select a List View:")));
                    webDriver.waitForElementLoad(1);
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "All")));
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "All")));
                } catch (Exception e) {
                }
                webDriver.waitForElementLoad(1);
                webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")));
                if (arg0.contains("SysData")) {
                    String Value = arg0.split("=>")[1];
                    webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")), DriverInstance.getVariable(Value));
                    webDriver.waitForElementLoad(1);
                    clickOnButton("refreshButton");
                    webDriver.waitForElementLoad(3);
                    webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", DriverInstance.getVariable(Value)));
                    webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", DriverInstance.getVariable(Value))));
                    webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", DriverInstance.getVariable(Value))));
                } else {
                    webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")), arg0);
                    webDriver.waitForElementLoad(1);
                    clickOnButton("refreshButton");
                    webDriver.waitForElementLoad(4);
                    int count = webDriver.getwebelementscount(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0));
                    if (count > 0) {
                        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                    } else {
                        clickOnButton("refreshButton");
                        webDriver.waitForElementLoad(4);
                        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));

                    }
                }
            }
        } catch (Exception e) {
            webDriver.Refresh();
            webDriver.waitForElementLoad(2);
            if (arg0.equalsIgnoreCase("Global Default")) {
                searchAndSelectRecordsUsingAPI("rtms__TransportationProfile__c", "Global Default");
            }
            else {
                try {
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ButtonIconTitleContains").replace("{paramlink}", "Select a List View:")));
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("ButtonIconTitleContains").replace("{paramlink}", "Select a List View:")));
                    webDriver.waitForElementLoad(1);
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "All")));
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "All")));
                } catch (Exception e1) {
                }
                webDriver.waitForElementLoad(1);
                webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")));
                if (arg0.contains("SysData")) {
                    String Value = arg0.split("=>")[1];
                    webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")), DriverInstance.getVariable(Value));
                    webDriver.waitForElementLoad(1);
                    clickOnButton("refreshButton");
                    webDriver.waitForElementLoad(3);
                    webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", DriverInstance.getVariable(Value)));
                    webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", DriverInstance.getVariable(Value))));
                    webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", DriverInstance.getVariable(Value))));
                } else {
                    webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")), arg0);
                    webDriver.waitForElementLoad(1);
                    clickOnButton("refreshButton");
                    webDriver.waitForElementLoad(4);
                    int count = webDriver.getwebelementscount(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0));
                    if (count > 0) {
                        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                    } else {
                        clickOnButton("refreshButton");
                        webDriver.waitForElementLoad(4);
                        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));

                    }
                }
            }
        }
    }

    @Then("Search {string} from List")
    public void searchResult(String arg0) throws Exception {
        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        try {
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ButtonIconTitleContains").replace("{paramlink}", "Select a List View:")));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("ButtonIconTitleContains").replace("{paramlink}", "Select a List View:")));
            webDriver.waitForElementLoad(1);
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "All")));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "All")));
        } catch (Exception e) {

        }
        webDriver.waitForElementLoad(1);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")));
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")), arg0);
        webDriver.waitForElementLoad(1);
        clickOnButton("refreshButton");
        webDriver.waitForElementLoad(3);

    }

    @Then("Search Records {string} from List")
    public void searchRecordsResult(String arg0) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")));
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Search this list...")), arg0);
        webDriver.waitForElementLoad(1);
        clickOnButton("refreshButton");
        webDriver.waitForElementLoad(3);
    }

    @Then("Select {string} from List")
    public void SelectList(String arg0) throws Exception {

        int count = webDriver.getwebelementscount(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0));
        if (count > 0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
        } else {
            clickOnButton("refreshButton");
            webDriver.waitForElementLoad(4);
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));

        }
    }

    @Then("Select Multiple Records from List")
    public void SelectMultiple(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {

                if (entry.getValue().contains("SysData")) {
                    String Value = entry.getValue().split("=>")[1];

                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("SelectRowOnSearchResult").replace("{paramlink}", DriverInstance.getVariable(Value))));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("SelectRowOnSearchResult").replace("{paramlink}", DriverInstance.getVariable(Value))));
                    webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("SelectRowOnSearchResult").replace("{paramlink}", DriverInstance.getVariable(Value))));
                    webDriver.waitForElementLoad(1);
                } else {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("SelectRowOnSearchResult").replace("{paramlink}", entry.getValue())));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("SelectRowOnSearchResult").replace("{paramlink}", entry.getValue())));
                    webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("SelectRowOnSearchResult").replace("{paramlink}", entry.getValue())));
                    webDriver.waitForElementLoad(1);
                }
            }
        }
    }

    @Then("Recently Viewed to All")
    public void RecentlyViewToAll() throws Exception {
        webDriver.waitForElementLoad(3);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ButtonIconTitleContains").replace("{paramlink}", "Select a List View:")));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("ButtonIconTitleContains").replace("{paramlink}", "Select a List View:")));
        webDriver.waitForElementLoad(1);
        webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text").replace("{paramlink}", "All"));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "All")));

    }

    @Then("Select Records {string} from List")
    public void SelectTPFromRecentlyView(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));

    }

    @Then("Click on {string} Link Text {string} on Page")
    public void clickOnLinkTextOnPage(String arg0, String arg1) throws Exception {
        DriverInstance.setVariable(arg0, arg1);
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.waitForElementLoad(2);
    }

    @Then("Scroll into Section {string}")
    public void scrollIntoSection(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("Global_Text").replace("{paramlink}", arg0));
    }

    @Then("Scroll into Section with Title {string}")
    public void scrollIntoSectionWithTitle(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("ButtonIconTitle").replace("*", "span").replace("{paramlink}", arg0));
    }

    //Edit Icon methods
    @Then("Click on Edit icon on {string}")
    public void clickOnEditIconOn(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("Label_Button").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Move hover on Tooltip for {string}")
    public void MoveToElement(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("Label_Button").replace("{paramlink}", arg0));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Move hover on Tooltip")
    public void MoveToElement() throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("ToolTip"));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ToolTip")));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ToolTip")));
        webDriver.waitForElementLoad(1);
    }

    @Then("Move hover on Tooltip for Text {string}")
    public void MoveToElementHover1(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("ToolTipAriaDescription").replace("{paramlink}", arg0));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ToolTipAriaDescription").replace("{paramlink}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ToolTipAriaDescription").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Hover over on {string} icon")
    public void HoverOverOnIcon(String arg0) throws Exception {
        if (arg0.equalsIgnoreCase("Thumbsup")) {
            arg0 = "Arrival/Departure = Expected";
        }
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("ButtonIcon").replace("{paramlink}", arg0)));
        webDriver.mouseOver(pageObject.getlocator("ButtonIcon").replace("{paramlink}", arg0));
        webDriver.waitForElementLoad(3);
    }

    @Then("Hover over on {string} {string} link")
    public void HoverOverOnLink(String arg0, String arg1) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SpanText2").replace("{paramlink}", arg1).replace("{index}", arg0)));
        webDriver.mouseOver(xml.getlocator("SpanText2").replace("{paramlink}", arg1).replace("{index}", arg0));
        webDriver.waitForElementLoad(3);
    }

    @Then("Move hover on Tooltip for Second {string}")
    public void MoveToElement2(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("Label_Button_2").replace("{paramlink}", arg0));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Label_Button_2").replace("{paramlink}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Label_Button_2").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Click on div text {string}")
    public void clickOnDivText(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("DivText").replace("{paramlink}", arg0));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Click on Edit icon on Label {string}")
    public void clickOnEditIconOnLabel(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Label_Edit_Icon").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("Label_Edit_Icon").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Label_Edit_Icon").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    //Enter Label Text
    @Then("Enter Label {string} Text as {string}")
    public void enterLabelText(String arg0, String arg1) throws Exception {
        if (arg1.equalsIgnoreCase("Company Email")) {
            arg1 = propertyReader.readproperty("Company_Email");
        }
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)), arg1);
        webDriver.waitForElementLoad(1);
    }

    //Enter Label Text on Modal
    @Then("Enter Label {string} Text as {string} on Modal")
    public void enterLabelTextOnModal(String arg0, String arg1) throws Exception {
        if(arg1.contains("SysData"))
        {
            arg1=DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LabelFieldInput").replace("{paramlink}", arg0)));
        webDriver.waitUntilElementIsVisible(xml.getlocator("LabelFieldInput").replace("{paramlink}", arg0));
        webDriver.EnterTimeUsingJS(webDriver.getwebelement(xml.getlocator("LabelFieldInput").replace("{paramlink}", arg0)),arg1);
        webDriver.waitForElementLoad(1);
    }


    @Then("Enter Label {string} TextArea as {string}")
    public void enterLabelTextArea(String arg0, String arg1) throws Exception {
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xml.getlocator("InputFieldTextArea").replace("{paramlink}", arg0)), arg1);
        webDriver.waitForElementLoad(1);
    }

    @Then("Enter Label {string} TextArea with {string}")
    public void enterLabelTextAreaWith(String arg0, String arg1) throws Exception {
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.EnterJsonText(webDriver.getwebelement(xml.getlocator("InputFieldTextArea").replace("{paramlink}", arg0)), arg1);
        webDriver.waitForElementLoad(1);
    }


    //Click button with name attribute
    @Then("Click on {string} button")
    public void clickOnButton(String arg0) throws Exception {
        try {

            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
        } catch (Exception e) {
            webDriver.Clickon(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));

        }
    }

    //Verify Some field having value
    @Then("Verify {string} having value of {string}")
    public void verifyIsSetTo(String arg0, String arg1) throws DocumentException, InterruptedException {
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.waitUntilElementIsVisible(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
        webDriver.verifyElementToBePresent(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
    }

    @Then("Verify {string} having not contains value of {string}")
    public void verifyNotContains(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
    }

    @Then("Verify Message displaying as {string}")
    public void verifyMessageAreDisplaying(String arg0) throws DocumentException, InterruptedException {
        if(arg0.contains("SysData"))
        {
            arg0= DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        webDriver.waitUntilElementIsVisible(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        closeToastMessage();
    }

    @Then("Verify and Close visible Message displaying as {string}")
    public void verifyMessageAreDisplaying1(String arg0) throws DocumentException, InterruptedException {
        Thread.sleep(200);
        webDriver.waitUntilElementIsVisible(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        closeToastMessage();

    }

    @Then("Verify Message displaying with Text {string}")
    public void verifyMessageAreDisplayingWithText(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(xml.getlocator("VerifyMessage1").replace("{paramlink}", arg0));
        closeToastMessage1(arg0);
    }

    @Then("Verify Message not displaying with {string}")
    public void verifyMessageAreNotDisplayingWithText(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));

    }


    @Then("Verify Message displaying with {string}")
    public void verifyMessageAreDisplayingWith(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
    }

    @Then("Verify Error Message displaying as {string}")
    public void verifyErrorMessageAreDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.Errorwebelement(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        if (webDriver.getwebelementscount(xml.getlocator("ErrorMessage")) > 0) {
            String errorText = webDriver.getText(webDriver.Errorwebelement(xml.getlocator("ErrorMessage")));
            ToastContext.addExpected(errorText);
        }
        closeErrorToastMessage(arg0);
    }
    @Then("Verify Error Message contains as {string}")
    public void verifyErrorMessageArecontains(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.Errorwebelement(xml.getlocator("VerifyMessage1").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage1").replace("{paramlink}", arg0));
        if (webDriver.getwebelementscount(xml.getlocator("ErrorMessage")) > 0) {
            String errorText = webDriver.getText(webDriver.Errorwebelement(xml.getlocator("ErrorMessage")));
            ToastContext.addExpected(errorText);
        }
        closeErrorToastMessage(arg0);
    }
    @Then("Verify Error Message displaying with {string}")
    public void verifyErrorMessageAreDisplaying1(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.Errorwebelement(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        if (webDriver.getwebelementscount(xml.getlocator("ErrorMessage")) > 0) {
            String errorText = webDriver.getText(webDriver.Errorwebelement(xml.getlocator("ErrorMessage")));
            ToastContext.addExpected(errorText);
        }

    }

    @Then("Verify Title displaying as {string}")
    public void verifyTitle(String arg0) throws DocumentException, InterruptedException {

        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("TitleContains").replace("{paramlink}", DriverInstance.getVariable(Value))));
            webDriver.verifyElementToBePresent(xml.getlocator("TitleContains").replace("{paramlink}", DriverInstance.getVariable(Value)));

        } else {
            webDriver.waitUntilElementIsVisible(xml.getlocator("TitleContains").replace("{paramlink}", arg0));
            webDriver.verifyElementToBePresent(xml.getlocator("TitleContains").replace("{paramlink}", arg0));
        }
    }

    @Then("Verify Text displaying as {string}")
    public void verifyMessageAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {

        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(Value)));
            webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(Value)));
        } else {
            webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
            webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
        }
    }

    @Then("Verify Text not displaying as {string}")
    public void verifyMessageAreNotDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.verifyElementNotToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", Value));
        }
        else {
            webDriver.verifyElementNotToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
        }
        }

    @Then("Verify Exact Text not displaying as {string}")
    public void verifyExactMessageAreNotDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.verifyElementNotToBePresent(xml.getlocator("TextField").replace("{paramlink}", Value));
        }
        else {
            webDriver.verifyElementNotToBePresent(xml.getlocator("TextField").replace("{paramlink}", arg0));
        }
    }

    @Then("Verify Modal Heading Text displaying as {string}")
    public void verifyHeadingAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("//*", "//h2//*").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
    }

    //Verify Link Text
    @Then("Verify {string} Link value displaying as {string}")
    public void verifyTextValueDisplayingAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        String Act_Result = webDriver.GetText(webDriver.getwebelement(xml.getlocator("Global_Text_Link").replace("{paramlink}", arg0)));
        webDriver.Partialstringcomparator(Act_Result, arg1);
    }

    //Get Label Input Attribute
    @Then("Verify {string} Attribute {string} displaying as {string}")
    public void verifyAttributeDisplayingAs(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        String Act_Result;
        if (arg2.equalsIgnoreCase("")) {
            Act_Result = webDriver.returnElementAttrubuteValue(webDriver.passwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)), arg1);

        } else {
            Act_Result = webDriver.returAttrubuteValue(webDriver.passwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)), arg1);
        }
        if (arg0.contains("Date") || arg0.contains("date")) {
            webDriver.Partialstringcomparator(Act_Result, webDriver.ExpectedDate(arg2));
        }
        {
            webDriver.Partialstringcomparator(Act_Result, arg2);
        }
    }

    //Verify Field are displaying on page
    @Then("Verify Label {string} is displaying on Page")
    public void verifyLabelIsDisplayingOnPage(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("InputField").replace("{paramlink}", arg0));
    }

    //Verify Field are displaying on page and Required
    @Then("Verify Label {string} is Required and displaying on Page")
    public void verifyLabelIsDisplayingOnPageRequired(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputFiledRequired").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("InputFiledRequired").replace("{paramlink}", arg0));
    }

    @Then("Verify Picklist {string} is Required and displaying on Page")
    public void verifyPickListIsDisplayingOnPageRequired(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("PickListRequired").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("PickListRequired").replace("{paramlink}", arg0));
    }

    //Verify Field are not displaying on page
    @Then("Verify Label {string} not displaying on Page")
    public void verifyNotDisplayingOnPage(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("Global_Text").replace("{paramlink}", arg0));
    }

    //Select Yes ot No under Legend
    @Then("Within the Legend select {string} as {string}")
    public void withinTheModalSelectAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.waitForElementLoad(1);
    }

    //Verify X button with Some Field
    @Then("Verify {string} Clear Icon button is displaying")
    public void verifyClearSectionButtonIsDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("LabelClearIcon").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("LabelClearIcon").replace("{paramlink}", arg0));

    }

    //Click on Button Icon
    @Then("Click on PickList {string}")
    public void clickOnPickList(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("Label_Button").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }


    @Then("Click on {string} with Text")
    public void clickOn(String arg0) throws Exception {
        if(arg0.contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        try {
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("{paramlink}", arg0)));
            webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Global_Text").replace("{paramlink}", arg0)));
        } catch (Exception e) {
            webDriver.waitForElementLoad(10);
            webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Global_Text").replace("{paramlink}", arg0)));

        }
        }

    @Then("Click on container {string} with SCAC {string}")
    public void clickOnContainerWithScac(String containerNumber, String scac) throws Exception {
        String locator = xml.getlocator("ContainerLinkWithScac")
                .replace("{paramlink1}", containerNumber)
                .replace("{paramlink2}", scac);

        WebElement containerLink = webDriver.getwebelement(locator);
        webDriver.ScrollIntoView(containerLink);
        webDriver.waitforElementtobeclickable(locator);
        webDriver.safeJavaScriptClick(containerLink);
    }

    @Then("Click on {string} with Contains Text")
    public void clickOnContainsText(String arg0) throws Exception {
        if(arg0.contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0)));
    }

    @Then("Click on {string} with href")
    public void clickOnhref(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitforElementtobeclickable(xml.getlocator("Global_href").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_href").replace("{paramlink}", arg0)));
    }

    @Then("Click on button {string}")
    public void clickOnButton1(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("//*", "//button").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("//*", "//button").replace("{paramlink}", arg0));
        Thread.sleep(2000);
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text").replace("//*", "//button").replace("{paramlink}", arg0)));
    }

    @Then("Select on {string} as value {string}")
    public void selectOnAsValue(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}", arg0)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}", arg0)));
        webDriver.SelectComboBoxOption(webDriver.getwebelement(xml.getlocator("Div_aria_Label").replace("{paramlink}", arg0)), webDriver.getwebelement(xml.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
    }

    @Then("{string} field highlights red as required")
    public void fieldHighlightsRedAsRequired(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(xml.getlocator("CheckRequiredLabel").replace("{paramlink}", arg0));

    }

    @Then("Remove {string} from {string} Field")
    public void removeFromField(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LabelClearIcon").replace("{paramlink}", arg1)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("LabelClearIcon").replace("{paramlink}", arg1));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("LabelClearIcon").replace("{paramlink}", arg1)));
    }

//    @Then("Select {string} from List")
//    public void selectFromList(String arg0) throws DocumentException, InterruptedException {
//        webDriver.waitforElementtobeclickable(xml.getlocator("ButtonIconTitle").replace("{paramlink}",arg0));
//        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ButtonIconTitle").replace("{paramlink}",arg0)));
//
//    }

    @Then("Wait for {string} Seconds")
    public void waitForSeconds(String arg0) {
        webDriver.waitForElementLoad(Integer.parseInt(arg0));
    }

    @Then("Click on  Checkbox {string}")
    public void clickOnCheckbox(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitforElementtobeclickable(xml.getlocator("SpanCheckbox").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("SpanCheckbox").replace("{paramlink}", arg0)));
    }

    @Then("Verify Details {string} displaying as {string}")
    public void verifyDetailsDisplayingAs(String arg0, String arg1) throws DocumentException, InterruptedException {

        if (arg1.contains(" or ")) {
            String value1 = arg1.split(" or ")[0];
            String value2 = arg1.split(" or ")[1];
            System.out.println("Verified value1: " + value1);
            System.out.println("Verified value2: " + value2);

            try {
                if(value1.contains("SysData"))
                {
                    value1=value1.split("=>")[1];
                    value1 = DriverInstance.getVariable("value1");
                }
                webDriver.verifyElementToBePresent(xml.getlocator("Verify_Deatils_Field").replace("{paramlink1}", arg0).replace("{paramlink2}", value1));
                System.out.println("Verified value: " + value1);
            } catch (Throwable t) {
                if (value2.contains("SysData")) {
                    value2 = value2.split("=>")[1];
                    value2 = DriverInstance.getVariable("value2");
                }
                webDriver.verifyElementToBePresent(xml.getlocator("Verify_Deatils_Field").replace("{paramlink1}", arg0).replace("{paramlink2}", value2));
                System.out.println("Verified value: " + value2);
            }
        }
        else {
            webDriver.verifyElementToBePresent(xml.getlocator("Verify_Deatils_Field").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
        }
    }

    @Then("Select {string} from {string} list and click on {string}")
    public void selectFromList(String optiontoselect, String listname, String buttonToClick) throws Exception {
//        webDriver.SwitchToFrameByIndex("0");
        webDriver.SwitchToFrameByElement(webDriver.getwebelement("//div[contains(@class,'active')]//iframe"));
        String selectName = webDriver.getwebelement(xml.getlocator("SectionName").replace("{paramlink}", listname)).getAttribute("id");
        System.out.println("optiontoselect is:" + optiontoselect);
        webDriver.Select(webDriver.getwebelement(xml.getlocator("Selectlist").replace("{paramlink}", selectName)), optiontoselect);
        webDriver.Clickon(webDriver.getwebelement(iframexml.getlocator("InputValue").replace("{paramlink}", buttonToClick)));
        Thread.sleep(1000);
        webDriver.SwitchToParentFrame();
    }

    @Then("Select Multiple {string} from {string} list and click on {string}")
    public void selectMultipleFromList(String optiontoselect, String listname, String buttonToClick) throws Exception {
//        webDriver.SwitchToFrameByIndex("0");
        webDriver.SwitchToFrameByElement(webDriver.getwebelement("//div[contains(@class,'active')]//iframe"));
        String selectName = webDriver.getwebelement(xml.getlocator("SectionName").replace("{paramlink}", listname)).getAttribute("id");
        System.out.println("optiontoselect is:" + optiontoselect);
        String[] value = optiontoselect.split(",,");
        for (String s : value) {
            webDriver.Select(webDriver.getwebelement(xml.getlocator("Selectlist").replace("{paramlink}", selectName)), s);
            webDriver.waitForElementLoad(2);
        }
        webDriver.Clickon(webDriver.getwebelement(iframexml.getlocator("InputValue").replace("{paramlink}", buttonToClick)));
        Thread.sleep(1000);
        webDriver.SwitchToParentFrame();
    }

    @Then("Set {string} value")
    public void setValue(String arg0) {
        DriverInstance.setVariable(arg0, "");
    }

    @Then("Verify the button Colors")
    public void verifyTheButtonColors(DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                WebElement element = webDriver.getwebelement(xml.getlocator("ButtonTitle").replace("{paramlink}", entry.getKey()));
//                Color c = Color.decode("#ff0000");
//                System.out.println(c);
                String backgroundcolor = element.getCssValue("background-color");
                String BGhex = Color.fromString(backgroundcolor).asHex();
                java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
                System.out.println("Background Color is: " + bgcolor);

                String textcolor = element.getCssValue("color");
                String Thex = Color.fromString(textcolor).asHex();
                java.awt.Color tcolor = java.awt.Color.decode(Thex);
                System.out.println("Text Color is: " + tcolor);
            }
        }
    }

    @And("Click on Native {string} icon")
    public void clickOnNativeIcon(String arg0) throws Exception {

        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("ButtonTitle").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("ButtonTitle").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ButtonTitle").replace("{paramlink}", arg0)));
    }

    @And("Click on link {string}")
    public void clickOnLink(String arg0) throws Exception {
        //  webDriver.scrollDownWithJS(10);
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            String Act = DriverInstance.getVariable(Value);
            webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", Act));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", Act)));
            webDriver.waitforElementtobeclickable(xml.getlocator("SpanTitle").replace("{paramlink}", Act));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SpanTitle").replace("{paramlink}", Act)));
        } else {
            webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0));
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SpanTitle").replace("{paramlink}", arg0.trim())));
            webDriver.waitforElementtobeclickable(xml.getlocator("SpanTitle").replace("{paramlink}", arg0.trim()));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SpanTitle").replace("{paramlink}", arg0.trim())));
        }
    }

    @Then("Verify details for all Enabled fields")
    public void verifyDetailsForEnabledService(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.validateServicesData(dt, Boolean.TRUE, Boolean.FALSE);
    }
    @Then("Verify details for all Enabled fields With data-field-name")
    public void verifyDetailsForEnabledServiceWithDataFieldName(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.validateServicesDataWithDataFieldNae(dt, Boolean.TRUE, Boolean.FALSE);
    }

    @Then("Verify {string} details")
    public void verifyDetailsForFieldsUnderSections(String SectionName, DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.validateServicesDataUnderSection(SectionName, dt);
    }

    @Then("Verify details for all Required Enabled fields")
    public void verifyDetailsForEnabledRequiredService(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.validateServicesData(dt, Boolean.TRUE, Boolean.FALSE);
    }

    @Then("Verify details for all Disabled or Readonly fields")
    public void verifyDetailsForDisabledService(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.validateServicesData(dt, Boolean.FALSE, Boolean.FALSE);
    }

    @Then("Get details for {string} Disabled or Readonly fields and store in {string}")
    public void getDetailsForDisabledOrReadonlyFields(String fieldName, String variableName) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.getDetailsForDisabledOrReadonlyFields(fieldName, variableName);
    }


    @Then("Verify details for all Disabled or Readonly fields for {string} grid")
    public void verifyDetailsForDisabledServiceFirGrid(String gridName, DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.validateServicesDataGrid(dt, Boolean.FALSE, Boolean.FALSE, gridName);
    }


    @Then("Update details")
    public void updateDetailsForenabledService(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.updateServicesDataWithCount(dt);
    }

    @Then("Click on Label {string}")
    public void updateServicesDataWithCount(String Key) throws Exception {

        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("LabelText").replace("{paramlink}", Key)));
        String fieldName = webDriver.passwebelement(xml.getlocator("LabelText").replace("{paramlink}", Key)).getAttribute("for");
        System.out.println(fieldName);
        System.out.println(xml.getlocator("LabelText").replace("{paramlink}", Key));
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.Clickon(element);
    }
    @Then("Update HazMat Details for {string} Line Items")
    public void updateDetailsForenabledService(String arg0,DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.updateHazmatDetails(arg0,dt);
    }
    @Then("Update {string} details")
    public void updateDetailsunderSections(String sectionName, DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.updateServicesDataForSections(sectionName, dt);
    }

    @Then("Update Lightning Layout Item details")
    public void updateDetailsForEnabledLightningLayoutItemService(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.updateServicesLayoutDetails(dt);
    }

    @Then("Update details With Set Value")
    public void updateDetailsForenabledServiceWithSetValur(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.updateDataWithSetValue(dt);
    }

    @Then("Update Legend details")
    public void updateLegendDetailsForenabledService(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.updateServicesDataWithLegend(dt);
    }

    @Then("Verify Legend details")
    public void VerifyLegendDetailsForenabledService(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.VerifyServicesDataWithLegend(dt);
    }

    @Then("Enter {string} Text as {string} from List")
    public void selectTextAs(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)));
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)), arg1);
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("ButtonIconTitle").replace("{paramlink}", arg1));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ButtonIconTitle").replace("{paramlink}", arg1)));

    }

    @Then("Click on {string} Field info")
    public void clickOnFieldInfo(String arg0) throws DocumentException, InterruptedException {
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("InputInfoButton").replace("{paramlink}", arg0)));

    }

    @Then("Verify details for")
    public void verifyDetailsFor(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.VerifyLabelDataFieldValue(dt);
    }

    @Then("Verify details with Text")
    public void verifyDetailswithText(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.VerifyLabelDataFieldValue2(dt);
    }

    @Then("Navigate Back & Refresh")
    public void BrowserBackandRefresh() throws Exception {
        webDriver.navigateBack();
        webDriver.waitForElementLoad(2);
        webDriver.Refresh();
    }

    @Then("Navigate Browser Back")
    public void BrowserBack() throws Exception {
        webDriver.navigateBack();
        webDriver.waitForElementLoad(2);

    }

    @Then("Refresh current Page")
    public void refreshCurrentPage() {
        webDriver.Refresh();
        webDriver.waitForElementLoad(1);
    }

    @Then("Wait for Email to Receive On Email")
    public void waitForEmailToRecieveOnEmail() {
        System.out.println("Waiting for Email to sent");
        webDriver.waitForElementLoad(120);
    }

    @Then("Verify {string} Table details with following Details")
    public void verifyTableDetailsWithFollowingDetails(String arg0, DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.HandingTabularData(arg0, dt);
    }


    @Then("Switch Window by index {string}")
    public void switchWindowByIndex(String arg0) {
        webDriver.waitForElementLoad(2);
        webDriver.SwitchWindowByIndex(arg0);
        webDriver.waitForElementLoad(1);
    }

    @Then("Switch to new Window")
    public void switchWindow() {
        webDriver.waitForElementLoad(2);
        webDriver.switchToLatestWindow();
        webDriver.waitForElementLoad(1);
    }


    @Then("Close and Switch to Previous Window")
    public void switchWindowRemaining() {
        webDriver.CloseCurrentWindows();
        webDriver.waitForElementLoad(2);
        webDriver.SwitchBackToMainWindow();
        webDriver.waitForElementLoad(1);
    }

    @Then("Switch to Parent Frame")
    public void switchToParentFrame() {
        webDriver.SwitchToParentFrame();
    }

    @Then("Close Tab by Index {string}")
    public void closeTabByIndex(String arg0) {
        webDriver.CloseWindowByIndex(arg0);
    }

    @Then("Verify Details")
    public void verifyDetails(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.ValidateDetails(dt);
    }


    @Then("Get Details")
    public void getDetails(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.GetDetails(dt);
    }

    @Then("Get Label Value")
    public void LabelValue(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.getLabelValue(dt);
    }

    @Then("Close Current Tab")
    public void closeCurrentTab() {
        webDriver.CloseCurrentWindows();
    }

    @Then("Switch to Parent Window")
    public void switchToParentWindow() {
        webDriver.SwitchToParentWindod();
    }

    @Then("Click on {string} button on Details Page")
    public void clickOnButtonOnDetailsPage(String arg0) throws Exception {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(1);
            if (webDriver.getwebelementscount(xml.getlocator("HitSnag")) > 0) {
                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
                webDriver.waitForElementLoad(1);
            }

        } catch (Exception e) {
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));

        }
        webDriver.waitForElementLoad(2);

    }

    @Then("Switch to Frame by Index {string}")
    public void switchToFrameByIndex(String arg0) {
        webDriver.SwitchToFrameByIndex(arg0);
    }

    @Then("Switch to Frame by Title {string}")
    public void switchToFrameByTitle(String arg0) throws DocumentException, InterruptedException {
        webDriver.SwitchToParentFrame();
        webDriver.SwitchToFrameByElement(webDriver.getwebelement(xml.getlocator("IframeTitle").replace("{paramlink}", arg0)));
    }

    @Then("Verify Banner Details")
    public void verifyBannerDetails(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.ValidateBanner(dt);
    }

    @Then("Verify Banner details For Checkbox")
    public void verifyBannerDetailsForCheckbox(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.validateBannerCheckbox(dt);
    }

    @Then("Verify details For Checkbox")
    public void verifyDetailsForCheckbox(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.VerifyBannerCheckbox(dt);
    }

    @Then("Click on {string} button on {string} Page")
    public void clickOnButtonOnPage(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitforElementtobeclickable(xml.getlocator("BtnClickOnPage").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("BtnClickOnPage").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
    }

    @And("Click on Button with Value {string}")
    public void clickOnButtonWithValue(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("ValueInput").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("ValueInput").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ValueInput").replace("{paramlink}", arg0)));
    }

    @Then("Switch to {int} Frame")
    public void switchToFrame(int arg0) {
        webDriver.SwitchToFrameByIndex(String.valueOf(arg0 - 1));
    }

    @Then("Search And Select {string} from Quick Search")
    public void searchAndSelectFromQuickSearch(String arg0) throws Exception {
        CommonFunction cm = new CommonFunction(DriverInstance);
        webDriver.waitForElementLoad(1);
        cm.updateServicesData1("Quick Find", arg0);
        clickOn(arg0);
    }

    @Then("Search And Select {string} from Search List")
    public void searchAndSelectFromSearchList(String arg0) throws Exception {
        CommonFunction cm = new CommonFunction(DriverInstance);
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        cm.updateServicesData1("Search this list...", arg0);
        webDriver.waitForElementLoad(1);
        clickOnButton("refreshButton");
        waitForSeconds("2");

        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
    }

    @Then("Search {string} And Select Href {string} from Quick Search")
    public void searchAndSelectHrefFromQuickSearch(String arg0, String arg1) throws Exception {
        CommonFunction cm = new CommonFunction(DriverInstance);
        webDriver.waitForElementLoad(1);
        cm.updateServicesData1("Quick Find", arg0);
        clickOnhref(arg1);
    }


    @Then("Set Key {string} page Record Id with {string}")
    public void setKeyPageRecordIdWith(String arg0, String arg1) {
        webDriver.waitForUrlContains(arg1);
        String url = webDriver.CurrentURL();
        String recordId = StringUtils.substringBetween(url, "/" + arg1 + "/", "/view");
        System.out.println("Record_Id: " + recordId);
        DriverInstance.setVariable(arg0, recordId);
        System.out.println("Record_url: " + url);
        ExtentCucumberAdapter.addTestStepLog("Record_Id: " + recordId);

    }

    @Then("Click on {string} Button in normal mode")
    public void clickOnWindowButton(String arg0) throws Exception {
        webDriver.verifyElementToBePresent(xml.getlocator("UploadSuccess"));
        webDriver.waitForElementLoad(5);
//        webDriver.waitForElementToBePresent("//*[@icon-name='utility:success']", 10);
        String locator = xml.getlocator("UploadDoneButton").replace("{paramlink}", arg0);
        webDriver.safeJavaScriptClick(webDriver.getwebelement(locator));
    }

    @And("Verify {string} {string} with {string}")
    public void verifyWith(String arg0, String arg1, String arg2) throws Exception {
        String request_Actual = DriverInstance.getVariable(arg0 + "_" + arg1);
        String scenarioName = DriverInstance.getScenarioName();
        XmlComparator.SoapXmlCompare(scenarioName, arg2, request_Actual);
    }

    @Then("Close Toast message")
    public void closeToastMessage() throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(xml.getlocator("CloseToastMsg"));
        if (count > 0) {
            try {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("CloseToastMsg")));
                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("CloseToastMsg")));
            } catch (Exception e) {
                System.out.println("Toast message looks like already closed");
            }
        }
    }

    @Then("Close All Success message")
    public void closeSuccessToastMessage1() throws DocumentException, InterruptedException {

        int maxAttempts = 5;
        int attempts = 0;

        while (attempts < maxAttempts) {

            int count = webDriver.getwebelementscount(
                    xml.getlocator("CloseSuccessToastMsg"));

            if (count == 0) {
                break;
            }

            try {
                webDriver.ScrollIntoView(
                        webDriver.getwebelement(xml.getlocator("CloseSuccessToastMsg")));

                webDriver.safeJavaScriptClick(
                        webDriver.getwebelement(xml.getlocator("CloseSuccessToastMsg")));

                Thread.sleep(300);

            } catch (Exception e) {
                System.out.println("Unable to close toast message: " + e.getMessage());
                break;
            }

            attempts++;
        }

        System.out.println("Toast message cleanup completed.");
    }


    @Then("Close All message")
    public void closeToastMessageAll1() throws DocumentException, InterruptedException {

        int maxAttempts = 5;
        int attempts = 0;

        while (attempts < maxAttempts) {

            int count = webDriver.getwebelementscount(
                    xml.getlocator("CloseToastMsg"));

            if (count == 0) {
                break;
            }

            try {
                webDriver.ScrollIntoView(
                        webDriver.getwebelement(xml.getlocator("CloseToastMsg")));

                webDriver.safeJavaScriptClick(
                        webDriver.getwebelement(xml.getlocator("CloseToastMsg")));

                Thread.sleep(300);

            } catch (Exception e) {
                System.out.println("Unable to close toast message: " + e.getMessage());
                break;
            }

            attempts++;
        }

        System.out.println("Toast message cleanup completed.");
    }

    @Then("Close Toast message {string}")
    public void closeToastMessage1(String message) throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(xml.getlocator("CloseToastActMsg").replace("{paramlink}", message));
        if (count > 0) {
            try {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("CloseToastActMsg").replace("{paramlink}", message)));
                webDriver.WaitforElementtobeclickable(xml.getlocator("CloseToastActMsg").replace("{paramlink}", message));
                webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("CloseToastActMsg").replace("{paramlink}", message)));
            } catch (Exception e) {
                System.out.println("Toast message looks like already closed");
            }
        }
    }

    @Then("Verify Message {string} displaying stored during enabled logging")
    public void verifyMessageDuringLog(String arg0) throws DocumentException, InterruptedException {
        try {
            webDriver.Partialstringcomparator(DriverInstance.getVariable("SuccessMessage"), arg0);
        } catch (Exception e) {
            webDriver.Partialstringcomparator(DriverInstance.getVariable("SuccessMessageBeforeDebug"), arg0);
        }
        }

    @Then("Verify Warning Message {string} not stored during enabled logging")
    public void verifyMessageNotDuringLog(String arg0) throws DocumentException, InterruptedException {
        String Value=DriverInstance.getVariable("WarningMessage");
        if(Value==null)
        {
           Value="";
        }
        webDriver.Stringcomparator(Value,"");
    }

    @Then("Store Toast message during Debugging Log")
    public void StoreSuccessMessage() throws DocumentException, InterruptedException {
         if(!DriverInstance.getVariable("CapturedMessage").equalsIgnoreCase("Yes"))
         {
        int count = webDriver.getwebelementscount2(xml.getlocator("ToastLabel"));
        if (count > 0) {
            System.out.println("Count is Man" + count);
            try {
                String label = webDriver.GetText(webDriver.passwebelement(xml.getlocator("ToastLabel")));
                String labDescription = webDriver.GetText(webDriver.passwebelement(xml.getlocator("ToastDescription")));
                System.out.println("Count is Ma1" + label);
                System.out.println("Count is Ma2" + labDescription);
                DriverInstance.setVariable("SuccessMessage", label + "-" + labDescription);
                DriverInstance.setVariable("CapturedMessage","Yes");

            } catch (Exception e) {
                System.out.println("Toast message looks like already closed");
            }
        }
         }
    }
    @Then("Try to Capture Success message before Debugging Log")
    public void StoreSuccessMessageBeforeDebug() throws DocumentException, InterruptedException {
            webDriver.waitUntilElementIsVisible(xml.getlocator("ToastMessagesList"));
            webDriver.waitForElementLoad(1);
            int count = webDriver.getwebelementscount2(xml.getlocator("ToastLabel"));
            if (count > 0) {
                System.out.println("Count is Man" + count);
                try {
                    String label = webDriver.GetText(webDriver.passwebelement(xml.getlocator("ToastLabel")));
                    String labDescription = webDriver.GetText(webDriver.passwebelement(xml.getlocator("ToastDescription")));
                    System.out.println("Count is Ma1" + label);
                    System.out.println("Count is Ma2" + labDescription);
                    DriverInstance.setVariable("SuccessMessageBeforeDebug", label + "-" + labDescription);
                } catch (Exception e) {
                    System.out.println("Toast message looks like already closed");
                }
            }

    }

    @Then("Store Warning Toast message during Debugging Log")
    public void StoreWarningMessage() throws DocumentException, InterruptedException {

        int count = webDriver.getwebelementscount2(xml.getlocator("warningToastLabel"));

        if (count > 0) {
            System.out.println("Count is Man" + count);
            try {
                String label = webDriver.GetText(webDriver.passwebelement(xml.getlocator("warningToastLabel")));
                String labDescription = webDriver.GetText(webDriver.passwebelement(xml.getlocator("warningToastDescription")));
                System.out.println("Count is Ma1" + label);
                System.out.println("Count is Ma2" + labDescription);
                DriverInstance.setVariable("WarningMessage", label + "-" + labDescription);
                String sourcePath = "data:image/png;base64," + ((TakesScreenshot) bddDriver.WEB_DRIVER_THREAD_LOCAL.get()).
                        getScreenshotAs(OutputType.BASE64);
                ExtentCucumberAdapter.getCurrentStep().log(Status.WARNING, label + "-" + labDescription, MediaEntityBuilder.createScreenCaptureFromBase64String(sourcePath).build());

            } catch (Exception e) {
                System.out.println("Toast message looks like already closed");
            }
        }
    }


    @Then("Close Error {string} message")
    public void closeErrorToastMessage(String arg0) throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(xml.getlocator("ErrorCloseToastMsg").replace("{paramlink}", arg0));
        if (count > 0) {
            try {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("ErrorCloseToastMsg").replace("{paramlink}", arg0)));
                webDriver.WaitforElementtobeclickable(xml.getlocator("ErrorCloseToastMsg").replace("{paramlink}", arg0));
                webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ErrorCloseToastMsg").replace("{paramlink}", arg0)));
            } catch (Exception e) {
                System.out.println("Toast message looks like already closed");
            }
        }
    }

    @Then("Close Modal")
    public void closeModal() throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(xml.getlocator("CloseModal"));
        if (count > 0) {
            try {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("CloseModal")));
                webDriver.WaitforElementtobeclickable(xml.getlocator("CloseModal"));
                webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("CloseModal")));
            } catch (Exception e) {
                System.out.println("Close Modal looks like already closed");
            }
        }
    }

    public void displayComparisionDetails(String Expected, String Actual) {
        ExtentCucumberAdapter.addTestStepLog("<table border='1' style='border-collapse:collapse;width:100%'>" + "<tr style='background-color:#f2f2f2'>" + "<th style='padding:8px;text-align:left'>Expected</th>" + "<th style='padding:8px;text-align:left'>Actual</th>" + "</tr>" + "<tr>" + "<td style='padding:8px'>" + Expected + "</td>" + "<td style='padding:8px'>" + Actual + "</td>" + "</tr>" + "</table>");
    }

    @Then("Scroll into Last of Webpage")
    public void scrollIntoLastOfWebpage() {
        // Write code here that turns the phrase above into concrete actions
        webDriver.ScrollLast();
    }

    @Then("Capture the current URL for {string}")
    public void captureCurrentURL(String arg0) throws Exception {
        DriverInstance.setVariable(arg0, webDriver.GetCurrentURL());
    }

    @Then("Navigate to stored URL for {string}")
    public void navigateStoredURL(String arg0) throws Exception {
        webDriver.GOto(DriverInstance.getVariable(arg0));
        webDriver.waitForElementLoad(1);
    }

    @Then("Scroll Up with {string} Times")
    public void scrollUpWithTimes(String arg0) throws InterruptedException {
        webDriver.scrollUpWithJS(Integer.parseInt(arg0));
    }

    @Then("Capture the attribute {string} for {string}")
    public void captureAttributeValue(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("InputField").replace("{paramlink}", arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("InputField").replace("{paramlink}", arg1)));
        System.out.println("Locator :" + webDriver.passwebelement(xml.getlocator("InputField").replace("{paramlink}", arg1)));
        String Act_Result = webDriver.returnElementAttrubuteValue(webDriver.passwebelement(xml.getlocator("InputField").replace("{paramlink}", arg1)), arg0);
        Thread.sleep(2000);

        if (!Act_Result.contains(":")) {
            String Load_id = Act_Result.split("/")[0];
            String Quote_id = Act_Result.split("/")[1];
            System.out.println("Carrier Quote Reference : " + Act_Result);
            System.out.println("Load id : " + Load_id);
            System.out.println("Quote Id : " + Quote_id);
            if (arg1.equalsIgnoreCase("Carrier Quote Reference")) {
                DriverInstance.setVariable("Load id", Load_id);
                DriverInstance.setVariable("Quote Id", Quote_id);
//                DriverInstance.setVariable(arg1, Act_Result);
            }
        } else {
            String shipmentOfferId = Act_Result.split(":")[0].trim();
            String shipmentProductTransactionId = Act_Result.split(":")[1].trim();
            System.out.println("Carrier Quote Reference : " + Act_Result);
            System.out.println("Shipment Offer Id : " + shipmentOfferId);
            System.out.println("Shipment Product TransactionId : " + shipmentProductTransactionId);
            if (arg1.equalsIgnoreCase("Carrier Quote Reference")) {
                DriverInstance.setVariable("Shipment Offer Id", shipmentOfferId);
                DriverInstance.setVariable("Shipment Product Transaction Id", shipmentProductTransactionId);
//                DriverInstance.setVariable(arg1, Act_Result);
            }
        }
        DriverInstance.setVariable(arg1, Act_Result);
//        System.out.println("Value of Attribute Stored: "+arg1+" is :"+DriverInstance.getVariable(arg1));
    }

    @Then("Click on button with Title {string}")
    public void clickOnButtonWithTitle(String arg0) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
        } catch (Exception e1) {
            webDriver.waitForElementLoad(2);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));

        }
    }

    @Then("Click If button with Title {string} is enabled")
    public void clickOnMoreTabs(String arg) throws Exception {
        if (webDriver.getwebelementscount(xml.getlocator("WithTitle").replace("{paramlink}", arg)) > 0) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg)));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg)));
        }


    }

    @Then("Click on button with Title Contains {string}")
    public void clickOnButtonWithTitleContains(String arg0) throws DocumentException, InterruptedException {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0)));
        } catch (Exception e1) {
            webDriver.waitForElementLoad(2);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0)));

        }
    }

    @Then("Select {string} as {string} from Dueling List")
    public void selectAsFromDuelingList(String arg0, String arg1) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.moveOptionToChosen(arg0, arg1);
    }

    @Then("De-Select {string} as {string} from Dueling List")
    public void DeselectAsFromDuelingList(String arg0, String arg1) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.moveOptionToAvailable(arg0, arg1);
    }

    @Then("Verify {string} selected as {string} on Dueling List -")
    public void verifySelectedAsOnDuelingList(String arg0, String arg1) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.VerifyChosen(arg0, arg1);
    }

    @Then("Scroll down with {string} Times")
    public void scrollDownWithTimes(String arg0) throws InterruptedException {
        webDriver.scrollDownWithJS(Integer.parseInt(arg0));
    }

    @Then("Wait until {string} is not visible")
    public void waitUntilIsNotVisible(String arg0) throws DocumentException, InterruptedException {
        if (webDriver.getwebelementscount(xml.getlocator(arg0)) > 0) {
            webDriver.waitForElementNotToBeVisible(xml.getlocator(arg0));
        }
    }

    @Then("Wait until {string} is visible -")
    public void waitUntilIsVisible(String arg0) throws DocumentException, InterruptedException {
        webDriver.getwebelement(iframexml.getlocator("SpanTextObject").replace("{paramlink}", arg0));
        webDriver.waitUntilElementIsVisible(iframexml.getlocator("SpanTextObject").replace("{paramlink}", arg0));
    }

    @Then("Verify {string} in not displaying on Page")
    public void verifyInNotDisplayingOnPage(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
    }

    @Then("Verify Table {string} row count is {string}")
    public void verifyTableRowCountIs(String arg0, String arg1) throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(xml.getlocator("TableRowCount").replace("{paramlink}", arg0));
        webDriver.Stringcomparator(String.valueOf(count), arg1);
    }

    @Then("Click on Edit icon with Field Name {string}")
    public void clickOnEditIconWithFieldName(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Field_Edit_Icon").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Field_Edit_Icon").replace("{paramlink}", arg0)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Field_Edit_Icon").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Click on {string} Button with Type {string}")
    public void clickOnButtonWithType(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("ButtonwithType").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("ButtonwithType").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ButtonwithType").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));

    }

    @Then("Set Key {string} with value {string} from Config File")
    public void setKeyWithValueFromConfigFile(String arg0, String arg1) throws IOException {
        DriverInstance.setVariable(arg0, propertyReader.readproperty(arg1));
    }

    @Then("List View Control")
    public void listViewControl(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.ListViewControl(dt);
    }

    @Then("Edit the following to {string}")
    public void EditFollowingDual(String arg0, DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.ListViewControlDual(arg0, dt);
    }

    @Then("Edit the following to De-Select {string}")
    public void EditFollowingDualSelected(String arg0, DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.ListViewControlDualSelected(arg0, dt);
    }


    @Then("Click on {string} for {string} Records")
    public void clickOnForRecords(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("RelatedButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("RelatedButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("RelatedButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
    }

    @Then("Click on row dropdown for Table {string}")
    public void clickOnRowDropdownForTable(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("TableRowDropDown").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("TableRowDropDown").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("TableRowDropDown").replace("{paramlink}", arg0)));

    }


    @Then("Verify Tooltip message are displaying as {string}")
    public void verifyTooltipMessageAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("TooltipMessage").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("TooltipMessage").replace("{paramlink}", arg0));
    }

    @Then("Clear {string} value from comboBox")
    public void clearValueFromCombobox(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LabelClearIcon").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("LabelClearIcon").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("LabelClearIcon").replace("{paramlink}", arg0)));

    }

    @Then("Verify Label Checkbox")
    public void verifyLabelCheckbox(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.VerifyLabelCheckboxValue(dt);
    }

    @Then("Click on button with Title {string} on Modal")
    public void clickOnButtonWithTitleOnModal(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleModal").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleModal").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleModal").replace("{paramlink}", arg0)));

    }

    @Then("Click on button with Title {string} on Modal Footer")
    public void clickOnButtonWithTitleOnModalFooter(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleModalFooter").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleModalFooter").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleModalFooter").replace("{paramlink}", arg0)));

    }

    @Then("Click on button with Text {string} on Modal")
    public void clickOnButtonWithTextOnModal(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTextModal").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("WithTextModal").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTextModal").replace("{paramlink}", arg0)));

    }

    @Then("Verify Text {string} on Modal")
    public void verifyButtonWithTextOnModal(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(xml.getlocator("WithTextModal").replace("{paramlink}", arg0));

    }

    @Then("Search and Select {string} Account from the Global search")
    public void searchAndSelectFromTheGlobalSearch(String AccountName) throws Exception {
        String ID = ca.getAccountID(AccountName);
        System.out.println("AccountID: " + ID);
        webDriver.GOto(PropReader.get("application_url") + "/lightning/r/Account/" + ID + "/view");
    }


    @Then("Search and Select {string} {string} from the Global search")
    public void searchAndSelectRecordsUsingAPI(String Object, String Name) throws Exception {
        if (Name.contains("SysData")) {
            Name = DriverInstance.getVariable(Name.split("=>")[1]);
        }
        String ID = ca.GetIDUsingName(Name + "_" + Object, Object, Name);
        System.out.println("ID: " + ID);
        webDriver.GOto(PropReader.get("application_url") + "/lightning/r/" + Object + "/" + ID + "/view");
    }

    @Then("Search and Select {string} With ID {string} from the Global search")
    public void searchAndSelectRecordsUsingAPIID(String Object, String ID) throws Exception {
        if (ID.contains("SysData")) {
            ID = DriverInstance.getVariable(ID.split("=>")[1]);
        }
        System.out.println("ID: " + ID);
        webDriver.GOto(PropReader.get("application_url") + "/lightning/r/" + Object + "/" + ID + "/view");
    }

    @Then("Store SFID for {string} {string} on {string}")
    public void StoreSFIDForRecordsUsingAPI(String Object, String Name, String Key) throws Exception {
        String ID = ca.GetIDUsingName(Name + "_" + Object, Object, Name);
        System.out.println("ID: " + ID);
        DriverInstance.setVariable(Key, ID);
    }

    @Then("Note the current Date and Time")
    public void noteTheCurrentDateAndTime() {
        String DateAndTime = webDriver.ReturnCurrentDateAndTime("0", "MM/dd/yyyy hh:mm:ss");
        DriverInstance.setVariable("DateAndTime", DateAndTime);
    }

    @Then("Open New Tab with url {string}")
    public void openNewTabWithUrl(String arg0) {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.openNewTab(DriverInstance.getVariable(Value));
        } else {
            webDriver.openNewTab(arg0);
        }
    }

    @Then("Verify {string} button is not longer displaying")
    public void verifyButtonIsNotLongerDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
    }

    @Then("Verify {string} button is displaying")
    public void verifyButtonIsDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
    }

    @Then("Select CheckBox for {string}")
    public void selectAndAddFilesToLibrary(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SpanCheckBoxInput").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("SpanCheckBoxInput").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("SpanCheckBoxInput").replace("{paramlink}", arg0)));

    }

    @Then("Verify No Records found with this Text")
    public void verifyNoRecordsFoundWithThisText() throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("VerifyNoRecords")));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyNoRecords"));

    }


    @Then("Click on link for label {string}")
    public void clickOnLinkForLabel(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LabelLink").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("LabelLink").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LabelLink").replace("{paramlink}", arg0)));
    }

    @Then("Click on link for label {string} -")
    public void clickOnLinkForLabel1(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LabelLink1").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("LabelLink1").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LabelLink1").replace("{paramlink}", arg0)));
    }

    @Then("Click on button with Title {string} if already pressed")
    public void clickOnButtonWithTitleIfAlreadyPressed(String arg0) throws DocumentException, InterruptedException {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
            if (webDriver.Getattribute(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)), "aria-pressed").equalsIgnoreCase("true")) {
                webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
            }
        } catch (Exception e1) {
            webDriver.waitForElementLoad(2);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
            if (webDriver.Getattribute(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)), "aria-pressed").equalsIgnoreCase("true")) {
                webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
            }
        }
    }

    @And("Set {string} from stored value {string} with replace of {string} with {string}")
    public void setFromStoredValueWithReplaceOfWith(String UpdatedName, String ExistingName, String replacevalue, String expReplaceable) {
        if (ExistingName.contains("Distance")) {
            ExistingName = DriverInstance.getVariable(ExistingName).replace(",", "").split("\\.")[0];
            DriverInstance.setVariable(UpdatedName, ExistingName);
        } else if (ExistingName.contains("Charges")) {
            ExistingName = DriverInstance.getVariable(ExistingName).replace("USD ", "");
            if (!ExistingName.isEmpty()) {
                char lastChar = ExistingName.charAt(ExistingName.length() - 1);

                if (lastChar == '0') {
                    ExistingName = ExistingName.substring(0, ExistingName.length() - 1);
                }
            }
            DriverInstance.setVariable(UpdatedName, ExistingName);
        } else {
            String Key = DriverInstance.getVariable(ExistingName);
            DriverInstance.setVariable(UpdatedName, Key.replace(replacevalue, expReplaceable));
        }
    }

    @Then("Verify Icon {string} is displaying with background color {string}")
    public void verifyIconIsDisplayingWithBackgroundColor(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(xml.getlocator("IconName").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("IconName").replace("{paramlink}", arg0));
        WebElement wl = webDriver.getwebelement(xml.getlocator("IconName").replace("{paramlink}", arg0));
        String imgbackgroundcolor = wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg1);
    }

    @Then("Verify Class Contains {string} is displaying with color {string}")
    public void verifyClassIsDisplayingWithBackgroundColor(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(xml.getlocator("IconClassName").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("IconClassName").replace("{paramlink}", arg0));
        WebElement wl = webDriver.getwebelement(xml.getlocator("IconClassName").replace("{paramlink}", arg0));
        String imgbackgroundcolor = wl.getCssValue("color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg1);
    }


    @Then("Verify Class Contains {string} is displaying for Row text {string}")
    public void verifyClassContainsIsDisplayingForRowText(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(xml.getlocator("IconClassNameWithRow").replace("{paramlink}", arg0).replace("{paramlink1}", arg1));
        webDriver.verifyElementToBePresent(xml.getlocator("IconClassNameWithRow").replace("{paramlink}", arg0).replace("{paramlink1}", arg1));
    }



@Then("Verify box-shadow color is {string} for Column {string} and Row text {string}")
public void verifyBoxShadowColorIsForColomnAndRowText(String arg0, String arg1, String arg2)
        throws DocumentException, InterruptedException {

    String locator = xml.getlocator("ColumnBorderColor")
            .replace("{paramlink}", arg2)
            .replace("{paramlink1}", arg1);

    webDriver.waitUntilElementIsVisible(locator);
    webDriver.verifyElementToBePresent(locator);

    WebElement wl = webDriver.getwebelement(locator);

    // Get complete box-shadow CSS value
    String imgbackgroundcolor = wl.getCssValue("box-shadow");

    System.out.println("Box Shadow CSS: " + imgbackgroundcolor);

    // Extract only rgb(...) from the box-shadow value
    int rgbStart = imgbackgroundcolor.indexOf("rgb");
    int rgbEnd = imgbackgroundcolor.indexOf(")", rgbStart) + 1;

    if (rgbStart == -1 || rgbEnd == 0) {
        throw new AssertionError(
                "Unable to extract RGB color from box-shadow: " + imgbackgroundcolor);
    }

    String rgbColor = imgbackgroundcolor.substring(rgbStart, rgbEnd);

    System.out.println("Extracted RGB Color: " + rgbColor);

    // Convert RGB color to HEX
    String BGhex1 = org.openqa.selenium.support.Color
            .fromString(rgbColor)
            .asHex();

    java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);

    System.out.println("Color is: " + bgcolor1);
    System.out.println("RGB: "
            + bgcolor1.getRed() + ","
            + bgcolor1.getGreen() + ","
            + bgcolor1.getBlue());

    // Get closest color name
    String colorName1 = ColorUtils.getClosestColorName(
            bgcolor1.getRed(),
            bgcolor1.getGreen(),
            bgcolor1.getBlue());

    System.out.println("Color Name: " + colorName1);

    // Compare expected vs actual
    webDriver.Stringcomparator(colorName1, arg0);
}


    @Then("Verify Title {string} is displaying with background color {string}")
    public void verifyTitleIsDisplayingWithBackgroundColor(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
        WebElement wl = webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
        String imgbackgroundcolor = wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg1);
    }

    @Then("Verify {string} backGround Color with Text of {string} Button is {string}")
    public void verifyColorWithTextOfButtonIs(String arg0, String arg2, String arg3) throws DocumentException, InterruptedException {
        String Locators;
        if (arg2.charAt(arg2.length() - 2) == '_') {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = "(" + xml.getlocator("VerifyButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "true") + ")[" + arg2.charAt(arg2.length() - 1) + "]";
            } else {
                Locators = "(" + xml.getlocator("VerifyButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "false") + ")[" + arg2.charAt(arg2.length() - 1) + "]";
            }
        } else {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = xml.getlocator("VerifyButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "true");
            } else {
                Locators = xml.getlocator("VerifyButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "false");
            }
        }
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(Locators));
        webDriver.verifyElementToBePresent(Locators);
        System.out.println(Locators);
        WebElement wl = webDriver.getwebelement(Locators);
        String imgbackgroundcolor = wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg0);
    }

    @Then("Enter value {string} with Input having {string} as {string}")
    public void enterValueWithInputHavingAs(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException, IOException {
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("InputFieldValue").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2)));
        webDriver.waitUntilElementIsVisible(xml.getlocator("InputFieldValue").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2));
        webDriver.SendKeys(webDriver.passwebelement(xml.getlocator("InputFieldValue").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2)), arg0);
    }

    @Then("Select Search Result {string}")
    public void selectSearchResult(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(xml.getlocator("Search_Result").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Search_Result").replace("{paramlink}", arg0)));
    }

    @Then("Click on {string} for value {string} within table")
    public void clickOnForValueWithinTable(String ColumnName, String Value) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(xml.getlocator("TableRowValue").replace("{paramlink1}", ColumnName).replace("{paramlink2}", Value));
        webDriver.waitforElementtobeclickable(xml.getlocator("TableRowValue").replace("{paramlink1}", ColumnName).replace("{paramlink2}", Value));

        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("TableRowValue").replace("{paramlink1}", ColumnName).replace("{paramlink2}", Value)));

    }

    @Then("Sort {string} column in {string} Order")
    public void sortColumnInOrder(String arg0, String arg1) throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(xml.getlocator("SortRow").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
        if (count == 0) {
            do {
                clickOnButtonWithTitle(arg0);
                webDriver.waitForElementLoad(2);
                count = webDriver.getwebelementscount(xml.getlocator("SortRow").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
            }
            while (count == 0);
        }
    }

    @Then("verify {string} dropdown options")
    public void verifyTrackingProviderDropdownOptions(String arg0, DataTable dataTable) throws Exception {
        List<String> expectedOptions = dataTable.asList(String.class);

        // Call your reusable method
        verifyDropdownOptions(arg0, expectedOptions);
    }

    public void verifyDropdownOptions(String arg0, List<String> expectedOptions) throws Exception {

        // Wait until dropdown is visible
        webDriver.waitUntilElementIsVisible(xml.getlocator("DropdownLabel").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.passwebelement(xml.getlocator("DropdownLabel").replace("{paramlink}", arg0)));

        // Capture all options
        List<WebElement> options = webDriver.getwebelements(xml.getlocator("DropdownList").replace("{paramlink}", arg0));

        List<String> actualOptions = options.stream()
                .map(e -> e.getText().trim())
                .toList();

        System.out.println("Expected: " + expectedOptions);
        System.out.println("Actual  : " + actualOptions);

        // ✅ Validation
        if (!actualOptions.containsAll(expectedOptions)) {
            throw new AssertionError("Dropdown missing values.\nExpected: "
                    + expectedOptions + "\nActual: " + actualOptions);
        }

        System.out.println("✅ Dropdown options verified successfully");
    }

    @Then("Verify {string} value is not empty")
    public void verifyValueIsNotEmpty(String arg0) {
           if (arg0.contains("SysData")) {
            String key = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(key);

        }
        Assert.assertTrue(arg0 != null && !arg0.trim().isEmpty(),
                "Expected value is empty for field: " + arg0);
    }

    @Then("Verify Text displaying either {string} or {string}")
    public void verifyTextDisplayingEitherOr(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitForElementLoad(5);
        if (webDriver.getwebelementscount(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(arg0.split("=>")[1]))) > 0) {
            if (arg0.contains("SysData")) {
                String Value = arg0.split("=>")[1];
                webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(Value)));
                webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(Value)));
                DriverInstance.setVariable("Valid_" + Value.replace("_1", "").replace("_2", ""), DriverInstance.getVariable(Value));
            } else {
                webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
                webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
                DriverInstance.setVariable("Valid_" + arg0.replace("_1", "").replace("_2", ""), arg0);
            }

        } else {
            if (arg1.contains("SysData")) {
                String Value = arg1.split("=>")[1];
                webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(Value)));
                webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(Value)));
                DriverInstance.setVariable("Valid_" + Value.replace("_1", "").replace("_2", ""), DriverInstance.getVariable(Value));
            } else {
                webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg1));
                webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg1));
                DriverInstance.setVariable("Valid_" + arg1.replace("_1", "").replace("_2", ""), arg1);
            }
        }
    }

    @Then("Set Current Hour in {string} and store in {string}")
    public void setWith(String arg0, String arg1) throws IOException {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);
        LocalTime time = LocalTime.parse(arg0, formatter);
        String currentHour = time.withMinute(0)
                .withSecond(0)
                .withNano(0)
                .format(formatter);
        DriverInstance.setVariable(arg1, currentHour);
    }


    @Then("Verify {string} is under value of {string}")
    public void verifyIsUnderValueOf(String arg0, String arg1) throws Exception {
        String value = DriverInstance.getVariable(arg0).replace("%", "");
        double actualValue = Double.parseDouble(value);
        double expectedValue = Double.parseDouble(arg1);
        Assert.assertTrue(actualValue >= 0 && actualValue < expectedValue, "Expected value " + actualValue + " to be greater than and equal 0 and less than " + expectedValue);
    }

    @Then("Verify {string} is positive value")
    public void verifyIsPositiveValue(String arg0) throws DocumentException, InterruptedException {
        String value = DriverInstance.getVariable(arg0);
        String numericValue = value.replaceAll("[^0-9.-]", "");
        double actualValue = Double.parseDouble(numericValue);
        Assert.assertTrue(actualValue >= 0, "Expected value to be positive, but found: " + actualValue);
    }

    @And("Close All Toast message")
    public void closeAllToastMessage() throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(xml.getlocator("CloseToastMsg"));
        while (count > 0) {
            try {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("CloseToastMsg")));
                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("CloseToastMsg")));
            } catch (Exception e) {
                System.out.println("Toast message looks like already closed");
            }
            count = webDriver.getwebelementscount(xml.getlocator("CloseToastMsg"));
        }
    }

    @Then("Select {string} value from Div Dropdown")
    public void selectValueFromDivDropdown(String arg0) throws DocumentException, InterruptedException {
        if(arg0.contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        webDriver.waitForElementLoad(2);
        List<WebElement> values=webDriver.waitUntilVisibleAndReturnElements(xml.getlocator("Div_Dropdown").replace("{paramlink}",arg0));
        for(WebElement value: values){
            if(value.isDisplayed()) {
                webDriver.ScrollIntoView(value);
                webDriver.waitForElementToBeClickable(value);
                webDriver.ClickOnElement(value);
                break;
            }
        }
    }

    @Then("Convert {string} into specific Number Format")
    public void convertIntoSpecificNumberFormat(String arg0) {
        String formatted = String.format("%,.2f", Double.parseDouble(DriverInstance.getVariable(arg0)));
        DriverInstance.setVariable(arg0,formatted);
    }

    @Then("Hover over on {string} icon and verify icon text is {string}")
    public void hoverOverOnIconAndVerifyIconTextIs(String arg0, String arg1) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        if (arg1.contains("SysData")) {
            String Value = arg1.split("=>")[1];
            arg1 = DriverInstance.getVariable(Value);
        }
        String iconXpath = pageObject.getlocator("ButtonIcon").replace("{paramlink}", arg0);
        List<WebElement> icons = webDriver.getwebelements(iconXpath);
        for (WebElement icon : icons) {
            webDriver.waitUntilTheElementIsVisible(icon);
            webDriver.ScrollIntoView(icon);
            webDriver.mouseOver(icon);
            String actual = icon.getDomAttribute("title");
            Assert.assertEquals(actual, arg1, "Expected tooltip/title: " + arg1 + " but found: " + actual);
        }
    }

    @Then("Verify Table {string} row count is equal or greater than {string}")
    public void verifyTableRowCountIsEqualOrGreaterThan(String arg0, String arg1) throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(xml.getlocator("TableRowCount").replace("{paramlink}", arg0));
        int expectedCount = Integer.parseInt(arg1);
        if (count >= expectedCount) {
            webDriver.Stringcomparator(String.valueOf(count), String.valueOf(count));
        } else {
            webDriver.Stringcomparator(String.valueOf(count), arg1);
        }
    }
    @Then("click on {string} epayments and select {string} from Show More Dropdown")
    public void clickOnEpaymentsAndSelectFromShowMoreDropdown(String arg0, String arg1) throws Exception {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        String epaymetsDropdown=xml.getlocator("EpaymetsDropdown").replace("{paramlink}",arg0);
        String edit=xml.getlocator("EpaymetEditRow").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1);
        webDriver.waitUntilElementIsVisible(epaymetsDropdown);
        WebElement element = webDriver.getwebelement(epaymetsDropdown);
       /* webDriver.ScrollIntoView(element);
        webDriver.waitForElementToBeClickable(element);*/
        webDriver.Clickon(element);
        webDriver.waitForElementLoad(2);
        WebElement element1 = webDriver.getwebelement(edit);
        webDriver.Clickon(element1);
    }

    @Then("Calculate value by {string} {string} and {string} and store in {string}")
    public void calculateValue(String operation, String value1, String value2, String resultVariable) {
        if (value1.contains("SysData=>")) {
            value1 = DriverInstance.getVariable(value1.split("=>", 2)[1]);
        } else {
            value1 = DriverInstance.getVariable(value1);
        }
        if (value2.contains("SysData=>")) {value2 = DriverInstance.getVariable(value2.split("=>", 2)[1]);
        } else {
            value2 = DriverInstance.getVariable(value2);
        }
        String cleanValue1 = value1.replace("$", "").replace(",", "").trim();

        String cleanValue2 = value2.replace("$", "").replace(",", "").trim();

        double num1 = Double.parseDouble(cleanValue1);
        double num2 = Double.parseDouble(cleanValue2);
        double result;

        if (operation.equalsIgnoreCase("Add")) {
            result = num1 + num2;
        }
        else if (operation.equalsIgnoreCase("Subtract")) {
            result = num1 - num2;
        }
        else {
            throw new IllegalArgumentException("Unsupported operation: " + operation + ". Supported operations are Add and Subtract.");
        }
        DriverInstance.setVariable(resultVariable, String.valueOf(result));
        System.out.println("Calculation: " + num1 + " " + operation + " " + num2 + " = " + result);
    }

    @Then("Store current Time with timezone in format of {string} on to {string}")
    public void storeCurrentTimeWithTimezoneInFormatOfOnTo(String arg0, String arg1) {
        String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern(arg0, Locale.ENGLISH));
        System.out.println(time);
        DriverInstance.setVariable(arg1, time);
    }

    @Then("Verify {string} Table Details In Order")
    public void verifyTableWithDetailsInOrder(String tableName, DataTable dataTable) throws Exception {
        List<Map<String, String>> expectedRows = dataTable.asMaps(String.class, String.class);
        pageHelper.Utility.TableVerifier tv = new pageHelper.Utility.TableVerifier(DriverInstance);
        tv.verifyTableInOrder(tableName, expectedRows);
    }

    @Then("Verify {string} Table Column Order")
    public void verifyTableColumnOrder(String tableName, DataTable dataTable) throws Exception {
        List<String> expectedColumns = dataTable.asList(String.class);
        pageHelper.Utility.TableVerifier tv = new pageHelper.Utility.TableVerifier(DriverInstance);
        tv.verifyColumnOrder(tableName, expectedColumns);
    }

    @Then("Verify {string} Table Column {string} is {string}")
    public void verifyTableColumn(String tableName, String columnName, String presence) throws Exception {
        pageHelper.Utility.TableVerifier tv = new pageHelper.Utility.TableVerifier(DriverInstance);
        tv.verifyColumnPresence(tableName, columnName, presence);
    }

    @Then("Click on Checkbox {string} to {string}")
    public void clickOnCheckbox(String checkboxName, String expectedState) throws Exception {
        String locator = xml.getlocator("SpanCheckbox").replace("{paramlink}", checkboxName);
        WebElement checkbox = webDriver.getwebelement(locator);
        webDriver.ScrollIntoView(checkbox);
        webDriver.waitforElementtobeclickable(locator);
        boolean shouldBeChecked = Boolean.parseBoolean(expectedState);
        // Determine the current checkbox state
        boolean isChecked = checkbox.isSelected();
        // Only click when the current state differs from the desired state
        if (isChecked != shouldBeChecked) {
            webDriver.safeJavaScriptClick(checkbox);
        }
    }

    @Then("Close Error {string} messages")
    public void closeErrorToastMessage2(String arg0) throws DocumentException, InterruptedException {
        String locator = xml.getlocator("ErrorCloseToastMsg").replace("{paramlink}", arg0);
        try {
            List<WebElement> closeButtons = webDriver.getWebElements(locator);
            if (!closeButtons.isEmpty()) {
                closeButtons.get(0).click();
                System.out.println("Closed error banner for: " + arg0);
            } else {
                System.out.println("Error banner already disappeared for: " + arg0);
            }
        } catch (Exception e) {
            System.out.println("Unable to close error banner for " + arg0 + ": " + e.getMessage());
        }
    }

    @Then("Close multiple Toast messages")
    public void closeToastMessage2() throws DocumentException, InterruptedException {
        String locator = xml.getlocator("CloseToastMsg");
        try {
            List<WebElement> closeButtons = webDriver.getWebElements(locator);
            for (int i = closeButtons.size() - 1; i >= 0; i--) {
                try {
                    closeButtons.get(i).click();
                } catch (Exception e) {
                    System.out.println("Success toast already disappeared.");
                }
            }
        } catch (Exception e) {
            System.out.println(
                    "Unable to close success banners: " + e.getMessage());
        }
    }
}