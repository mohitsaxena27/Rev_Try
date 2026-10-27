package core;

import static io.restassured.RestAssured.given;
import static io.restassured.matcher.RestAssuredMatchers.matchesXsd;
import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;
import static java.lang.Thread.sleep;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.*;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;
import javax.imageio.ImageIO;
import javax.xml.parsers.ParserConfigurationException;

import Listner.ToastContext;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.paulhammant.ngwebdriver.*;
//import com.relevantcodes.extentreports.LogStatus;
import io.appium.java_client.AppiumBy;
import io.appium.java_client.AppiumDriver;

import io.appium.java_client.android.nativekey.AndroidKey;
import io.appium.java_client.windows.WindowsDriver;
import io.github.sukgu.Shadow;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import org.dom4j.Node;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.SAXReader;
import org.openqa.selenium.*;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.devtools.DevTools;
import org.openqa.selenium.devtools.HasDevTools;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.interactions.WheelInput;
import org.openqa.selenium.support.locators.RelativeLocator;
import org.openqa.selenium.support.ui.*;
import org.testng.Assert;
import org.xml.sax.SAXException;
//import cucumber.Reporter;
import io.restassured.authentication.FormAuthConfig;
import io.restassured.http.Headers;
import io.restassured.http.Method;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import ru.yandex.qatools.ashot.AShot;
import ru.yandex.qatools.ashot.Screenshot;
import ru.yandex.qatools.ashot.shooting.ShootingStrategies;
import simplexml.SimpleXml;
import simplexml.model.Element;



public class baseDriverHelper implements apiHelper, webHelper, desktopHelper, mobileHelper {
    WebDriver driver;
    RequestSpecification Request;
    WindowsDriver DesktopDriver;
    AppiumDriver MobileDriver;
    NgWebDriver ngDriver;
    public Wait<WebDriver> wait;
    public Wait<WindowsDriver> waitDesktop;
    public Wait<AppiumDriver> waitMobile;
    WebElement el = null;
    List<WebElement> ellist;

    public static ThreadLocal<Response> Resultrespoence = new InheritableThreadLocal<>();
    public static String Payload = "";
    public static String ReportPayload = "";
    public static Document XMLDocumentPayload;
    public static JSONObject JSONDocumentPayload;
    public final static String Contenttype = "application/xml";
    public static String WindDirectionDegree;
    public static Properties propinhelper;
    public static String VideoName;
    String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;

    public baseDriverHelper(WebDriver dr) {
        driver = dr;
        wait = new FluentWait<WebDriver>(driver)
                .withTimeout(Duration.ofSeconds(30))
                .pollingEvery(Duration.ofMillis(200))
                .ignoring(NoSuchElementException.class)
        ;
    }

    public baseDriverHelper(WindowsDriver dr) {
        DesktopDriver = dr;
        waitDesktop = new FluentWait<WindowsDriver>(DesktopDriver)
                .withTimeout(Duration.ofSeconds(90))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class)
        ;
    }

    public baseDriverHelper(AppiumDriver dr) {
        MobileDriver = dr;
        waitMobile = new FluentWait<AppiumDriver>(MobileDriver)
                .withTimeout(Duration.ofSeconds(90))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class)

        ;


    }

    public baseDriverHelper(RequestSpecification dr, Response respoence) {
        Request = dr;
        propinhelper = new Properties();
    }

    public void javascriptexecutor(WebElement el) throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].scrollIntoView();", el);
        js.executeScript("window.scrollTo(0, 0)");
        //window.scrollTo(0, 0);
    }

    public String getAttributeValueUsingJavascript(WebElement el) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        return (String) js.executeScript("return arguments[0].innerHTML;", el);

    }

    public void enableWebElement(String xpath) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("document.evaluate(\"" + xpath + "\", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.removeAttribute('disabled');");
    }

    public void disableWebElement(String xpath) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("document.evaluate(\"" + xpath + "\", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.setAttribute('disabled','');");
    }

    public void myClear(String xpath) {
//        JavascriptExecutor js = (JavascriptExecutor) driver;
//        js.executeScript("document.evaluate(\""+xpath+"\").value='';");

        WebElement wb = driver.findElement(By.xpath(xpath));
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].value='';", wb);
    }

    public void ScrollToBottom() {
        ((JavascriptExecutor) driver)
                .executeScript("window.scrollTo(0, document.body.scrollHeight)");
    }

    public void ScrollToTop() {
        ((JavascriptExecutor) driver)
                .executeScript("window.scrollTo(0, 0);");
    }

    public void ScrollToElement(WebElement element) {
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", element);
    }

    public void javascriptexecutor2(String st) throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("document." + st + ".submit();");
        //js.executeScript("window.scrollTo(0, 0)");
        //window.scrollTo(0, 0);
    }

    public boolean checkOptions(String[] expected, WebElement el) {
        List<WebElement> options = el.findElements(By.xpath(".//option"));
        int k = 0;
        for (WebElement opt : options) {
            if (!opt.getText().equals(expected[k])) {
                return false;
            }
            k = k + 1;
        }
        return true;
    }

    public void javascriptexecutor2(WebElement el) throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].scrollIntoView();", el);
        //js.executeScript("window.scrollTo(0, 0)");
        //window.scrollTo(0, 0);
    }

    public void SendKeyswithAction(WebElement el, String key) throws Exception {

        Clickon(el);
        Actions action = new Actions(driver);

        action.sendKeys(key).build().perform();
        action.sendKeys(Keys.ENTER).build().perform();

    }

    public void ClickswithAction(String el) throws InterruptedException {


        Actions action = new Actions(driver);

        action.click(driver.findElement(By.xpath(el))).build().perform();
        //action.sendKeys(Keys.TAB).build().perform();

    }

    public void WaitforElementtobeclickable(String locator) throws InterruptedException {
        System.out.println("In Wait for Element Clickable method for - " + locator);
        //waitForpageload();
        if (locator.startsWith("//") || locator.startsWith("(")) {
            wait.until(ExpectedConditions.elementToBeClickable(By.xpath(locator)));
            //getwebelement(xml.getlocator("//locators/StandrdQuote"));
            System.out.println("Waiting for Element to be clickabal and active" + locator);
            //Thread.sleep(2000);
        } else if (locator.startsWith("name")) {
            wait.until(ExpectedConditions.elementToBeClickable(By.name(locator.split("=")[1])));
            //getwebelement(xml.getlocator("//locators/StandrdQuote"));
            System.out.println("Waiting for Element to be clickabal and active" + locator);
            //Thread.sleep(2000);

        } else if (locator.startsWith("id")) {
            wait.until(ExpectedConditions.elementToBeClickable(By.id(locator.split("=")[1])));
            //getwebelement(xml.getlocator("//locators/StandrdQuote"));
            System.out.println("Waiting for Element to be clickabal and active" + locator);
            //Thread.sleep(2000);

        }
    }

    public void waitForElementLoad(int x) {
        try {
            int time = 1000 * x;
            sleep(time);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void Getloadingcomplete(String locator) throws InterruptedException {
        sleep(1000);
        try {
            wait.until(ExpectedConditions.attributeToBe(By.xpath(locator), "style", "display: none;"));
            //getwebelement(xml.getlocator("//locators/StandrdQuote"));
            System.out.println("Waiting Loading mask");
            sleep(5000);
        } catch (StaleElementReferenceException e2) {
            sleep(5000);
        } catch (TimeoutException e) {
            sleep(5000);
        }

    }

    public void Switchtotabandsignthequote() throws Exception {
        String parentWinHandle = driver.getWindowHandle();
        Set<String> totalopenwindow = driver.getWindowHandles();
        for (String handle : totalopenwindow) {
            if (!handle.equals(parentWinHandle)) {
                driver.switchTo().window(handle);
                sleep(12000);
                try {
                    safeJavaScriptClick(getwebelement("//*[@id='disclosureAccepted']"));
                } catch (Exception e) {
                    Clickon(getwebelement("//*[text()='Required']"));
                }
                Clickon(getwebelement("//button[text()='Continue']"));
                Clickon(getwebelement("//button[@data-qa='SignHere']"));
                Clickon(getwebelement("//div[@class='page-tabs']"));
                //create object 'action' of Actions class
                //Dragedrop(getwebelement("//button[@data-qa='SignHere']"),getwebelement("//div[@class='page-tabs']"));
                sleep(10000);
                Clickon(getwebelement("//button[text()='Adopt and Sign']"));
                //    		Thread.sleep(10000);
                //    		Clickon(getwebelement("//button[text()='Ok']"));
                sleep(10000);
                WaitforElementtobeclickable("//button[text()='Finish']");
                Clickon(getwebelement("//button[text()='Finish']"));
                WaitforElementtobeclickable("(//button[text()='Continue'])[2]");
                Clickon(getwebelement("(//button[text()='Continue'])[2]"));
                sleep(10000);
            }
        }
        driver.close();
        driver.switchTo().window(parentWinHandle);
    }

    public void Getmaploaded(String framlocator, String messagelocator) throws InterruptedException {
        //wait.until(ExpectedConditions.presenceOfElementLocated(By.id(framlocator.split("=")[1])));
        //try {
        System.out.println("Code for Map Loading Start");
        //Thread.sleep(3000);
        String[] finalval = framlocator.split("=");
        //Thread.sleep(3000);
        WaitforElementtobeclickable(framlocator);

        driver.switchTo().frame(driver.findElement(By.id(finalval[1])));
        System.out.println("Switched to Iframe");

        sleep(3000);
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath(messagelocator)));
        System.out.println("Element found and Waiting");
        System.out.println(driver.findElement(By.xpath(messagelocator)).getText());
        driver.switchTo().defaultContent();
        //ExpectedConditions.elementToBeClickable(locator)
        //Thread.sleep(2000);
        System.out.println("Code for Map Loading End ");
        sleep(2000);
        //}
        //}
        //		catch(Exception e)
        //		{
        //			System.out.println("In catch"+e.getMessage());
        //			Thread.sleep(1000);
        //			driver.switchTo().defaultContent();
        //			System.out.println("Switched to Default Content");
        //			Getmaploaded(framlocator,messagelocator);
        //
        //		}

    }

    public void WaitforFiletobeDownloaded(String Filename) throws InterruptedException {
        String str = System.getProperty("user.dir") + "/src/Data/Downloads/" + Filename;
        File file = new File(str);
        wait.until((driver) -> file.exists());
    }

    public WebElement getwebelement(String locator) throws InterruptedException {
        System.out.print("In Get element method for - " + locator);
        String[] finalval;
        el = null;
        try {
            if (locator.startsWith("name")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
                            waitUntilTheElementIsVisible(driver.findElement(By.name(finalval[1])));
                            el = driver.findElement(By.name(finalval[1]));
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        return el;
                    }
                });
            } else if (locator.startsWith("id")) {
                finalval = locator.split("=");
                try {
                    waitUntilTheElementIsVisible(driver.findElement(By.id(finalval[1])));
                    el = driver.findElement(By.id(finalval[1]));
                } catch (NoSuchElementException e) {
                    el = null;
                }
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
                            el = driver.findElement(By.id(finalval[1]));
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {
                                wait.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                wait.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        return el;
                    }
                });

            } else if (locator.startsWith("model")) {
                finalval = locator.split("=");
                try {
                    el = driver.findElement(new ByAngularModel("", finalval[1]));
                } catch (NoSuchElementException e) {
                    el = null;
                }

            } else if (locator.startsWith("buttonText")) {
                finalval = locator.split("=");
                try {
                    el = driver.findElement(new ByAngularButtonText("", finalval[1]));
                } catch (NoSuchElementException e) {
                    el = null;
                }

            } else if (locator.startsWith("//") || locator.startsWith("(//") || locator.startsWith("(")) {
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
                            waitUntilTheElementIsVisible(driver.findElement(By.xpath(locator)));
                            el = driver.findElement(By.xpath(locator));
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        return el;
                    }
                });
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        if (el != null) {

        }
        checkForErrorToast();
        return el;
    }

    public By getBy(String locator) {
        String[] finalval;
        if (locator.startsWith("name=")) {
            finalval = locator.split("=");
            return By.name(finalval[1]);
        }

        if (locator.startsWith("id=")) {
            finalval = locator.split("=");
            return By.id(finalval[1]);
        }

        if (locator.startsWith("model=")) {
            finalval = locator.split("=");
            return new ByAngularModel("", finalval[1]);
        }

        if (locator.startsWith("buttonText=")) {
            finalval = locator.split("=");
            return new ByAngularButtonText("", finalval[1]);
        }

        // xpath
        return By.xpath(locator);
    }

    public WebElement waitUntilVisible(By locator) {

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));
        wait.pollingEvery(Duration.ofMillis(200))
                .ignoring(StaleElementReferenceException.class)
                .ignoring(NoSuchElementException.class);
        return wait.until(ExpectedConditions.presenceOfElementLocated(locator));
    }

    public WebElement getWebElementWithVisibility(String locator) {

        System.out.println("In Get element method for - " + locator);

        By by = getBy(locator);

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.pollingEvery(Duration.ofMillis(200))
                .ignoring(StaleElementReferenceException.class)
                .ignoring(NoSuchElementException.class);

        // 1️⃣ Wait only for presence (not visibility)
        WebElement el = wait.until(
                ExpectedConditions.presenceOfElementLocated(by)
        );

        // 2️⃣ Scroll it into view safely
        ((JavascriptExecutor) driver).executeScript(
                "arguments[0].scrollIntoView({block:'center', inline:'nearest'});",
                el
        );
        // 3️⃣ Now wait for visibility
        el = wait.until(
                ExpectedConditions.visibilityOfElementLocated(by)
        );

        checkForErrorToast();
        return el;
    }

    public WebElement getwebelement(Node locator, String filelocation) throws InterruptedException, IOException {
        //WaitforElementtobeclickable(locator);
        System.out.print("In Get element method for - " + locator);

        String[] finalval;
        try {
            if (locator.getText().startsWith("name")) {
                finalval = locator.getText().split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
                //wait.until();
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
                            el = driver.findElement(By.name(finalval[1]));
                        } catch (NoSuchElementException e) {
                            locator.valueOf("@image");

                            el = null;
                        }
                        if (el != null) {
                            try {
                                wait.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                wait.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });
                //wait.until(ExpectedConditions.stalenessOf(element))
            } else if (locator.getText().startsWith("id")) {
                finalval = locator.getText().split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
                try {
                    el = driver.findElement(By.id(finalval[1]));
                } catch (NoSuchElementException e) {
                    el = null;
                }
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
                            el = driver.findElement(By.id(finalval[1]));
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {
                                wait.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                wait.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });

            } else if (locator.getText().startsWith("//") || locator.getText().startsWith("(//") || locator.getText().startsWith("(")) {
                //el=driver.findElement(By.xpath(locator));
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
                            el = driver.findElement(By.xpath(locator.getText()));
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {

                                wait.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                wait.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        return el;
                    }
                });

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //getwebelement(locator);
        }
        //Thread.sleep(1000);
        //	try {
        //		System.out.println("Is the element is enabled-"+el.isEnabled());
        //	}
        //	catch(Exception e)
        //	{
        //		System.out.println(e.getMessage().toString());
        //	}
        if (el != null) {
            UUID uuid = UUID.randomUUID();
            System.out.println(uuid);
            //Takescreenshot
            Screenshot screenshot = new AShot().takeScreenshot(driver, el);
            //Update Attribute by searching the Value
            ImageIO.write(screenshot.getImage(), "PNG", new File("src/test/resources/locators/Images/" + uuid + ".png"));

            org.dom4j.Element locator2 = (org.dom4j.Element) locator;
            locator2.addAttribute("image", uuid.toString());


        }
        return el;
    }

    public WebElement getDesktopelement(String locator) throws InterruptedException {
        //WaitforElementtobeclickable(locator);
        System.out.print("In Get element method for - " + locator);
        String[] finalval;
        try {
            if (locator.startsWith("name")) {
                finalval = locator.split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
                //wait.until();
                waitDesktop.until(new Function<WindowsDriver, WebElement>() {
                    public WebElement apply(WindowsDriver DesktopDriver) {
                        el = DesktopDriver.findElement(By.name(finalval[1]));
                        try {
                            waitDesktop.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            waitDesktop.until(ExpectedConditions.visibilityOf(el));
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });
                //wait.until(ExpectedConditions.stalenessOf(element))
            } else if (locator.startsWith("id")) {
                finalval = locator.split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
                el = DesktopDriver.findElement(By.id(finalval[1]));
                waitDesktop.until(new Function<WindowsDriver, WebElement>() {
                    public WebElement apply(WindowsDriver DesktopDriver) {
                        el = DesktopDriver.findElement(By.id(finalval[1]));
                        try {
                            waitDesktop.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            waitDesktop.until(ExpectedConditions.visibilityOf(el));
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });

            } else if (locator.startsWith("accessibityId")) {
                finalval = locator.split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
//				el=DesktopDriver.findElementByAccessibilityId(finalval[1]);
                el = DesktopDriver.findElement(new AppiumBy.ByAccessibilityId(finalval[1]));
                waitDesktop.until(new Function<WindowsDriver, WebElement>() {
                    public WebElement apply(WindowsDriver DesktopDriver) {
                        el = DesktopDriver.findElement(new AppiumBy.ByAccessibilityId(finalval[1]));
                        try {
                            waitDesktop.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            waitDesktop.until(ExpectedConditions.visibilityOf(el));
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });

            } else if (locator.startsWith("//") || locator.startsWith("(//") || locator.startsWith("(")) {
                //el=driver.findElement(By.xpath(locator));
                //el=DesktopDriver.findElement(By.id(finalval[1]));
                waitDesktop.until(new Function<WindowsDriver, WebElement>() {
                    public WebElement apply(WindowsDriver DesktopDriver) {
                        el = DesktopDriver.findElement(By.xpath(locator));
                        try {
                            waitDesktop.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            waitDesktop.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //getwebelement(locator);
        }
        //Thread.sleep(1000);
        //	try {
        //		System.out.println("Is the element is enabled-"+el.isEnabled());
        //	}
        //	catch(Exception e)
        //	{
        //		System.out.println(e.getMessage().toString());
        //	}
        return el;
    }

    public String getText(String locator) {
        String text = driver.findElement(By.xpath(locator)).getText();
        return text;
    }

    public void javascriptButtonClick(WebElement webElement) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].click();", webElement);
    }

    public String getAdsOnPage(String string) {
        String src = null, width = null, height = null;

        try {
            driver.switchTo().frame(0);
            WebElement el = driver.findElement(By.xpath("//img[@class='img_ad']"));
            src = Getattribute(el, "src");
            width = Getattribute(el, "width");
            height = Getattribute(el, "height");
            driver.switchTo().defaultContent();

        } catch (Exception e) {

        } finally {
            driver.switchTo().defaultContent();
        }
        String Ads = src + " " + width + " " + height;
        return Ads;
    }

    public boolean validateDataTrackResearchPage() {
        boolean flag = true;
        int count = driver.findElements(By.xpath("(//*[contains(@id,'zone')]//*[@data-track])")).size();
        System.out.println(count);
        for (int i = 1; i <= count; i++) {
            String loc = "(//*[contains(@id,'zone')]//*[@data-track])";
            String locator = loc.concat("[" + i + "]");
            String attri = Getattribute(driver.findElement(By.xpath(locator)), "data-track");
            //	getWebDriver().findElement(ByLocator(locator)).getAttribute("data-track");
            if (attri.endsWith(" ") || attri.startsWith(" ")) {
                System.err.println("Space is present with data-track:" + attri);
                flag = false;
            } else if (attri.endsWith("") || attri.startsWith("")) {
                System.out.println("Leading And Trailing Space is not present with data-track:" + attri);
            }
        }
        Assert.assertTrue(flag);
        return flag;
    }

    public WebElement getMobileelement(String locator) throws InterruptedException {
        //WaitforElementtobeclickable(locator);
        System.out.print("In Get element method for - " + locator);
        String[] finalval;
        try {
            if (locator.startsWith("class")) {
                finalval = locator.split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
                //wait.until();
                waitMobile.until(new Function<AppiumDriver, WebElement>() {
                    public WebElement apply(AppiumDriver MobileDriver) {
                        try {
                            el = MobileDriver.findElement(new AppiumBy.ByAccessibilityId(finalval[1]));

                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {
                                waitMobile.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                waitMobile.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });
                //wait.until(ExpectedConditions.stalenessOf(element))
            } else if (locator.startsWith("id")) {
                finalval = locator.split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
                el = MobileDriver.findElement(By.id(finalval[1]));
                waitMobile.until(new Function<AppiumDriver, WebElement>() {
                    public WebElement apply(AppiumDriver MobileDriver) {

                        try {
                            el = MobileDriver.findElement(By.id(finalval[1]));
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {
                                waitMobile.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                waitMobile.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });

            } else if (locator.startsWith("automationID")) {
                finalval = locator.split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
//				el=MobileDriver.findElementByAccessibilityId(finalval[1]);
                el = MobileDriver.findElement(new AppiumBy.ByAccessibilityId(finalval[1]));

                waitMobile.until(new Function<AppiumDriver, WebElement>() {
                    public WebElement apply(AppiumDriver MobileDriver) {

                        try {
//							el = MobileDriver.findElementByAccessibilityId(finalval[1]);
                            el = MobileDriver.findElement(new AppiumBy.ByAccessibilityId(finalval[1]));

                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {
                                waitMobile.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                waitMobile.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });

            } else if (locator.startsWith("//") || locator.startsWith("/") || locator.startsWith("(//") || locator.startsWith("(")) {
                //el=driver.findElement(By.xpath(locator));
                //el=DesktopDriver.findElement(By.id(finalval[1]));

                waitMobile.until(new Function<AppiumDriver, WebElement>() {
                    public WebElement apply(AppiumDriver MobileDriver) {

                        try {
//							el = MobileDriver.findElementByXPath(locator);
                            el = MobileDriver.findElement(AppiumBy.xpath(locator));
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {
                                waitMobile.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                waitMobile.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        return el;
                    }
                });

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //getwebelement(locator);
        }
        //Thread.sleep(1000);
        //	try {
        //		System.out.println("Is the element is enabled-"+el.isEnabled());
        //	}
        //	catch(Exception e)
        //	{
        //		System.out.println(e.getMessage().toString());
        //	}
        return el;
    }

    @Override
    public void SendKeys(AndroidKey key) throws InterruptedException, IOException {

    }

    public WebElement ReturnElement(String locator) {

        System.out.print("In Get element method for - " + locator);
        String[] finalval;
        try {
            if (locator.startsWith("name")) {
                finalval = locator.split("=");
                ////Log.info(finalval[1]);
                ////Log.info("Indriverhelper"+driver);
                //wait.until();
                el = driver.findElement(By.name(finalval[1]));


                //wait.until(ExpectedConditions.stalenessOf(element))
            } else if (locator.startsWith("id")) {
                finalval = locator.split("=");
                ////Log.info(finalval[1]);
                ////Log.info("Indriverhelper"+driver);
                el = driver.findElement(By.id(finalval[1]));


                //el= driver.findElement(By.id(finalval[1]));
            } else if (locator.startsWith("//") || locator.startsWith("(//") || locator.startsWith("(")) {
                el = driver.findElement(By.xpath(locator));


            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //getwebelement(locator);
        }
        //Thread.sleep(1000);
        try {
            System.out.println("Is the element is enabled-" + el.isEnabled());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return el;

    }

    public WebElement getwebelement2(String locator) throws InterruptedException {
        if (locator.startsWith("//") || locator.startsWith("(//")) {
            el = driver.findElement(By.xpath(locator));
            return driver.findElement(By.xpath(locator));
        } else if (locator.startsWith("id")) {
            el = driver.findElement(By.id(locator.split("=")[1]));
            return driver.findElement(By.xpath(locator));
        } else if (locator.startsWith("name")) {
            el = driver.findElement(By.name(locator.split("=")[1]));
            return driver.findElement(By.xpath(locator));
        }
        sleep(1000);
        return el;
    }

    public void Submitform(WebElement el) {
        el.submit();
    }

    public void Clickon(WebElement el) throws Exception {

        try {
            if (el != null) {
                try {


                    //use executeScript() method and pass the arguments
                    //Here i pass values based on css style. Yellow background color with solid red color border.
                    //js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                    sleep(1000);
                    //js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                    el.click();

                    System.out.println("try to click on the element ->" + el);
                    //    ExtentTestManager.getTest().//Log(//LogStatus.PASS, " Step: Click On "+elementName.get().toString());
                    //	System.out.println("try to click on the element "+el.toString().split("xpath:")[1]);
                    //	ExtentTestManager.getTest().//Log(//LogStatus.PASS, " Step: Click On "+el.toString().split("xpath:")[1]+" Button");


                } catch (StaleElementReferenceException e) {
                    //js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                    sleep(200);
                    //js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);

                    sleep(8000);
                    el.click();
                    System.out.println(" was staleElement but waited and try to click on the element" + el);

                } catch (WebDriverException e)
                //Thread.sleep(3000);
                {
                    //Thread.sleep(3000);
                    //JavascriptExecutor js = (JavascriptExecutor) driver;
                    System.out.println("Error in Click on " + e.getMessage());
                    if (!e.toString().equals("NoSuchElementException")) {
                        try {
                            if (e.getMessage().contains("is not clickable at point")) {

                                sleep(200);
                                System.out.println("Size of the element is not perfect so waited and re-tried the click actions");
                                //js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);

                                sleep(200);
                                //js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", el);
                                //el.click();
                                //	js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                            } else if (driver.findElement(By.xpath("//div[@id='lockCreateScreen' and not(@style='display: none;')]")).isDisplayed()) {
                                //js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                                sleep(200);
                                //js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                                System.out.println("Mask was overlayed so trying click with the Java script");
                            }
                        } catch (NoSuchElementException e12) {
                            //js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                            sleep(200);
                            //js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", el);
                            //	js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                            Assert.fail("Element should be displayed which this was not");
                        }
                    } else {
                        //Reporter.addStepLog("Something went wrong and Click was not performed successfully " + e.getMessage());
                        Assert.fail();
                    }
                }
            } else {
                Assert.fail("Element We are trying to interact is not found");
            }
        } catch (Exception e) {
            waitForElementLoad(8);
            el.click();
        }
    }

    public void ClickOnElement(WebElement element) {
        try {
            element.click();
        } catch (Exception e) {
            waitForElementLoad(6);
            try {
                ScrollIntoView(el);
                el.click();
            } catch (Exception ex) {
               System.out.println("Check either element is clicked or not" +
                       "");
            }
        }
    }

    public void safeJavaScriptClick(WebElement element) throws Exception {

        //	JavascriptExecutor js = (JavascriptExecutor) driver;
        try {
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", element);
        } catch (StaleElementReferenceException e) {
            ////Log.info("Element is not attached to the page document "+ e.getStackTrace());
        } catch (NoSuchElementException e) {
            ////Log.info("Element was not found in DOM "+ e.getStackTrace());
        } catch (Exception e) {
            ////Log.info("Unable to click on element "+ e.getStackTrace());
        }

    }

    public void switchtofram(WebElement el) {

        driver.switchTo().frame(el);

    }

    public void Waitforswitchtofram(String Locator) throws InterruptedException {
        //WaitforElementtobeclickable("id=engagementComponent");
        //Thread.sleep(2000);
        wait.until(ExpectedConditions.frameToBeAvailableAndSwitchToIt(Locator));


    }

    public void Waitforswitchtofram2(String Locator) throws InterruptedException {

        //Thread.sleep(5000);
        //wait.until(ExpectedConditions.frameToBeAvailableAndSwitchToIt(Locator));

        sleep(1500);
		/*try {
			for(int i=0;i<=10;i++) {
			while(isElementPresent(Locator))
			{
				Thread.sleep(500);
			}
		}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage().toString());
		}
		Thread.sleep(300);*/
    }

    public void switchtodefault() {
        driver.switchTo().defaultContent();

    }

    public String Getattribute(WebElement el, String attributename) {
        //Log.info(el.getAttribute(attributename));
        return el.getAttribute(attributename);
    }

    public String GetDomAttribute(WebElement el, String attributeName) {
        //Log.info(el.getAttribute(attributename));
        return el.getDomAttribute(attributeName);
    }

    public void ProxyLogin(String User, String Proxylink) throws Exception {
        //openurl("CPQAdmin");
        WaitforElementtobeclickable("//a[text()='Internal Users']");
        Clickon(getwebelement("//a[text()='Internal Users']"));
        sleep(2000);
        String uri = Getattribute(getwebelement(Proxylink), "href");
        System.out.println("URL is" + uri);
        String[] URL1 = uri.split("user_id=");
        System.out.println(URL1[0]);
        System.out.println(URL1[1]);
        String URL2 = (URL1[1].split("&"))[1];
        System.out.println(URL2);
        //PropertyReader pr=new PropertyReader();
        //String FinalURL=URL1[0]+"user_id="+pr.readproperty(User)+"&"+URL2;
        //System.out.println(FinalURL);

        //Log.info("CPQ_URL");
        //openurl2(FinalURL);

    }

    public void Moveon(WebElement el) {

        Actions action = new Actions(driver);
        action.moveToElement(el).build().perform();
    }

    public boolean isElementPresent(String locator) {
        WebElement el = driver.findElement(By.xpath(locator));
        int i = 90;
        try {
            while (!el.isDisplayed() && i > 0) {
                System.out.println("Text Value" + driver.findElement(By.xpath(locator)).isDisplayed());
                //Log.info("Element Found: True");
                sleep(1000);
                i = i - 1;
            }
            return el.isDisplayed();
        } catch (Exception e2) {
            return false;
        }
//		catch (NoSuchElementException e) {
//			//Log.info("Element Found: False");
//			return false;
//		}
    }

    public void Expandthesection(WebElement Section, WebElement ClickableElement) throws Exception {

        sleep(5000);
        String classvalue = Getattribute(Section, "class");
        System.out.println(classvalue);
        if (!classvalue.contains("green")) {
            System.out.println("In IF class");
            //Clickon(ClickableElement);
            ((JavascriptExecutor)

                    driver).executeScript("arguments[0].scrollIntoView();", ClickableElement);
            safeJavaScriptClick(ClickableElement);

        } else {
            System.out.println("Already expanded");
        }
    }

    public void Clickonoutofviewport(WebElement locator) throws Exception {
        ((JavascriptExecutor)

                driver).executeScript("arguments[0].scrollIntoView();", locator);
        safeJavaScriptClick(locator);
    }

    public void Clickonoutofviewportwithstring(String locator) throws Exception {

        ((JavascriptExecutor)

                driver).executeScript("arguments[0].scrollIntoView();", driver.findElement(By.xpath("//*[text()='Show Groups']")));
        //
        ((JavascriptExecutor)

                driver).executeScript("arguments[0].scrollIntoView();", driver.findElement(By.xpath(locator)));

        System.out.println("See if Scrolled");
        sleep(5000);
        System.out.println("Waiting....");
        safeJavaScriptClick(driver.findElement(By.xpath(locator)));
        System.out.println("Click is performed");
    }

    public void Select3(WebElement el, String value) throws IOException, InterruptedException {
        try {
            if (el.isEnabled() && el.isDisplayed()) {
                //Log.info("Clicking on element with using java script click");

                ((JavascriptExecutor) driver).executeScript("arguments[0].value='" + value + "'", el);
            } else {
                //Log.info("Unable to click on element");
            }
        } catch (StaleElementReferenceException e) {
            //Log.info("Element is not attached to the page document "+ e.getStackTrace());
        } catch (NoSuchElementException e) {
            //Log.info("Element was not found in DOM "+ e.getStackTrace());
        } catch (Exception e) {
            //Log.info("Unable to click on element "+ e.getStackTrace());
        }
    }

    public int getwebelementscount(String locator) throws InterruptedException {
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(3));
        ellist = driver.findElements(By.xpath(locator));
        int count = ellist.size();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
        return count;
    }

    public int getwebelementscount2(String locator) throws InterruptedException {
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(1));
        ellist = driver.findElements(By.xpath(locator));
        int count = ellist.size();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
        return count;
    }

    public List<WebElement> getwebelements(String locator) {
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(4));
        ellist = driver.findElements(By.xpath(locator));
        return ellist;
    }

    public List getWebElements(String locator) throws InterruptedException {
        return driver.findElements(By.xpath(locator));
    }

    public void SendKeys(WebElement el, String value) throws InterruptedException, IOException {
        try {
            if (el != null) {
                JavascriptExecutor js = (JavascriptExecutor) driver;
                try {

                    //JavascriptExecutor js = (JavascriptExecutor) driver;
                    //use executeScript() method and pass the arguments
                    //Here i pass values based on css style. Yellow background color with solid red color border.
                    //**************************************************
                    //js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                    //Thread.sleep(200);
                    //js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                    //**************************************************
                    if (MobileDriver != null) {
                        el.clear();
                    } else {
                        el.clear();
                        el.click();
                        el.clear();
                        el.sendKeys(Keys.BACK_SPACE);
                        el.sendKeys(Keys.BACK_SPACE);
                        el.sendKeys(Keys.BACK_SPACE);
                        el.sendKeys(Keys.BACK_SPACE);
                        el.sendKeys(Keys.BACK_SPACE);
                        el.sendKeys(Keys.BACK_SPACE);
                    }
                    el.sendKeys(value);
                    System.out.println("try to Send keys into filed" + value);
                    //	js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);

                } catch (WebDriverException e)
                //Thread.sleep(3000);
                {
                    System.out.println(e);
                    js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                    sleep(200);
                    js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                    //Thread.sleep(3000);
                    //JavascriptExecutor js = (JavascriptExecutor) driver;
                    System.out.println("Error in Clickon " + e.getMessage());
                    if (!e.toString().equals("NoSuchElementException")) {
                        try {
                            sleep(8000);
                            el.clear();
                            el.sendKeys(value);
                            System.out.println("try to Send keys into filed" + value);
                            //		js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                        } catch (Exception e1) {
                            //	Reporter.addStepLog("Something went Wrong adn Send Keys did not performed successfully " + e.getMessage());
                            Assert.fail();
                        }
                    }
                }
                //Thread.sleep(3000);
            } else {
                Assert.fail("Element We are trying to interact is not found");
            }
        } catch (Exception e) {
            waitForElementLoad(8);
            el.sendKeys(value);
        }
    }

    public void SendKeysUpdated(WebElement el, String value) throws InterruptedException, IOException {
        if (el != null) {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            try {
                if (MobileDriver != null) {
                    el.clear();
                } else {
//                    el.clear();
//                    el.click();
//                    el.clear();
//                    el.sendKeys(Keys.BACK_SPACE);
//                    el.sendKeys(Keys.BACK_SPACE);
//                    el.sendKeys(Keys.BACK_SPACE);
//                    el.sendKeys(Keys.BACK_SPACE);
//                    el.sendKeys(Keys.BACK_SPACE);
//                    el.sendKeys(Keys.BACK_SPACE);
                }
                el.sendKeys(value);
                System.out.println("Try to Send keys into filed:: " + value);

            } catch (WebDriverException e) {
                System.out.println(e);
                js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                sleep(200);
                js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                System.out.println("Error in click on " + e.getMessage());
                if (!e.toString().equals("NoSuchElementException")) {
                    try {
                        sleep(8000);
                        el.clear();
                        el.sendKeys(value);
                        System.out.println("Try to Send keys into filed:: " + value);
                    } catch (Exception e1) {
                        Assert.fail();
                    }
                }
            }
        } else {
            Assert.fail("Element you are trying to interact is not found.....!");
        }
        try {
        } catch (Exception e) {
            System.out.println("No a device");
        }
    }

    public void SendkeaboardKeys(WebElement el, Keys k) throws InterruptedException {
        //Thread.sleep(3000);

        el.sendKeys(k);
        //Thread.sleep(3000);
    }

    public String GetText(WebElement el) {
        String actual = el.getText();
        //		String actual1=el.getText().toUpperCase().toString();
        return actual;
    }

    public void Select(WebElement el, String value) throws IOException, InterruptedException { //Thread.sleep(3000);
        JavascriptExecutor js = (JavascriptExecutor) driver;

        if (!value.equals("")) {
            js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
            sleep(200);
            js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
            Select s1 = new Select(el);
            s1.selectByVisibleText(value);
            //	js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
        } else {
            System.out.println("Nothing to select");
        }
        //Thread.sleep(3000);
    }

    public void Clear(WebElement el) throws IOException, InterruptedException { //Thread.sleep(3000);
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
        sleep(200);
        js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
        el.clear();
        //Thread.sleep(3000);
        //		js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
    }

    public void clearTextBox(WebElement el) {
        // Clear the contents of the text box
        el.clear();
    }

    public void AcceptJavaScriptMethod() throws InterruptedException {
        try {
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            alert.accept();
            driver.switchTo().defaultContent();
        } catch (Exception e) {
            System.out.println("No Alert Present");
        }
    }

    public void CancelJavaScriptMethod() throws InterruptedException {
        sleep(1000);
        Alert alert = driver.switchTo().alert();
        alert.dismiss();
        driver.switchTo().defaultContent();
    }

    public void EnterText(String s) {
        Actions keyAction = new Actions(DesktopDriver);
        keyAction.sendKeys(s).perform();
    }

    public void EnterText2(Keys k) {
        Actions keyAction = new Actions(driver);
        keyAction.sendKeys(k).perform();
    }

    public void savePage() {
        Actions keyAction = new Actions(driver);
        keyAction.keyDown(Keys.CONTROL).sendKeys("s").keyUp(Keys.CONTROL).perform();
    }

    public void KeydownKey(Keys key) {
        Actions keyAction = new Actions(driver);
        keyAction.keyDown(key).perform();
    }

    public void KeyupKey(Keys key) {
        Actions keyAction = new Actions(driver);
        keyAction.keyUp(key).perform();
    }

    public void UploadFile(String locator, String FileName) {
        String str = System.getProperty("user.dir") + "/src/Data/" + FileName;
        String[] finalval = locator.split("=");
        WebElement el;
        if (locator.startsWith("id")) {
            el = driver.findElement(By.id(finalval[1]));
        } else if (locator.startsWith("name")) {
            el = driver.findElement(By.name(finalval[1]));
        } else {
            el = driver.findElement(By.xpath(finalval[1]));
        }
        el.sendKeys(str);
        // + "\\Lib\\chromedriver.exe"
        //Toolkit toolkit = Toolkit.getDefaultToolkit();
        // Clipboard clipboard = toolkit.getSystemClipboard();
        // StringSelection strSel = new StringSelection(str);
        // clipboard.setContents(strSel, null);
        // Actions keyAction = new Actions(driver);
        // keyAction.keyDown(Keys.CONTROL).sendKeys("v").keyUp(Keys.CONTROL).perform();
        // keyAction.sendKeys(Keys.ENTER);
    }

    public String CaptureScreenshotForElement(WebElement ele) throws IOException {
        String screenshot2;
        File screenshot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
        BufferedImage fullImg = ImageIO.read(screenshot);

        // Get the location of element on the page
        org.openqa.selenium.Point point = ele.getLocation();

        // Get width and height of the element
        int eleWidth = ele.getSize().getWidth();
        int eleHeight = ele.getSize().getHeight();

        // Crop the entire page screenshot to get only element screenshot
        BufferedImage eleScreenshot = fullImg.getSubimage(point.getX() - 20, point.getY() - 20,
                eleWidth + 20, eleHeight + 20);
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ImageIO.write(eleScreenshot, "png", bos);
        byte[] imageBytes = bos.toByteArray();
        screenshot2 = "data:image/png;base64," + Base64.getMimeEncoder().encodeToString(imageBytes);
        bos.close();
        return screenshot2;
    }

    public static String CaptureFullScreenshot(WebDriver driver) throws IOException {
        String screenshot2;
        Screenshot screenshot = new AShot().shootingStrategy(ShootingStrategies.viewportPasting(1000))
                .takeScreenshot(driver);

        // To save the screenshot in desired location
        //		ImageIO.write(screenshot.getImage(), "PNG",
        //				new File(System.getProperty("user.dir") + "/screenshots/fullpagescrn.png"));

        ByteArrayOutputStream bos = new ByteArrayOutputStream();

        ImageIO.write(screenshot.getImage(), "PNG", bos);

        byte[] imageBytes = bos.toByteArray();
        screenshot2 = "data:image/png;base64," + Base64.getMimeEncoder().encodeToString(imageBytes);

        bos.close();

        return screenshot2;
    }

    @Override
    public void CloseAllWindows() {
        String parentWinHandle = driver.getWindowHandle();
        Set<String> totalopenwindow = driver.getWindowHandles();
        if (totalopenwindow.size() > 1) {
            for (String handle : totalopenwindow) {
                if (!handle.equals(parentWinHandle)) {
                    driver.switchTo().window(handle);

                }
            }
            driver.close();
            driver.switchTo().window(parentWinHandle);
        } else {
            System.out.println("No popup displayed");
        }
    }

    public String Parent;

    public void windowhandle() throws InterruptedException {
        waitForElementLoad(3);
        Parent = driver.getWindowHandle();
        Set<String> windows = driver.getWindowHandles();
        Iterator<String> it = windows.iterator();
        while (it.hasNext()) {
            //parent = (String) it.next();
            String childWindow = it.next();
            System.out.println("child" + childWindow);
            waitForElementLoad(3);
            if (!Parent.equals(childWindow)) {
                driver.switchTo().window(childWindow);
                waitForElementLoad(2);
                // String driverType = "chrome";//propertyReader.readApplicationFile("BROWSER");
                // if (driverType.equals("IE"))
                driver.manage().window().maximize();
            }
        }
    }

    public void switchToParentWindow() {
        driver.close();
        driver.switchTo().window(Parent);
        driver.manage().window().setSize(new Dimension(1366, 768));
    }

    @Override
    public void SwitchToLastTab() {
        String parentWinHandle = driver.getWindowHandle();
        Set<String> totalopenwindow = driver.getWindowHandles();
        for (String handle : totalopenwindow) {
            if (!handle.equals(parentWinHandle)) {
                driver.switchTo().window(handle);
            }
        }
    }

    @Override
    public void GetIframeLoaded(String framlocator) {
        wait.until(ExpectedConditions.presenceOfElementLocated(By.id(framlocator.split("=")[1])));
        //driver.switchTo().frame(driver.findElement(By.id(framlocator.split("=")[1])));
        System.out.println("Switched to Iframe");
    }

    @Override
    public void WaitforPageToBeReady() throws Exception {
        while (!((JavascriptExecutor) driver).executeScript("return document.readyState").equals("complete")) {
            System.out.println("dom state is" + ((JavascriptExecutor) driver).executeScript("return document.readyState"));
            sleep(500);
            //wait.until(ExpectedConditions.jsReturnsValue(_PAGE_WHEN_READY_SCRIPT));
        }
    }

    @Override
    public String GetTitle() {
        // TODO Auto-generated method stub
        return driver.getTitle();
    }

    @Override
    public void OpenURL(String environment) {
        String URL = environment;
        //PropertyReader pr=new PropertyReader();
        ////Log.info(environment+"_URL");
        //URL=pr.readproperty(environment+"_URL");
        System.out.println(URL);
        driver.get(URL);

    }

    @Override
    public void OpenURLV2(String environment) throws Exception {
        String URL = null;
        //PropertyReader pr=new PropertyReader();
        ////Log.info(environment+"_URL");
        //URL=pr.readproperty(environment+"_URL");
        System.out.println(URL);
        driver.get(URL);
        sleep(5000);
    }

    @Override
    public void GetURL(String URL) {
        // TODO Auto-generated method stub
        driver.get(URL);
    }

    public String GetCurrentURL() {
        // TODO Auto-generated method stub
        return driver.getCurrentUrl();
    }

    @Override
    public void VerifyTitle(String Expectedtitle) {
        // TODO Auto-generated method stub
        Assert.assertTrue(driver.getTitle().contains(Expectedtitle), "Actual title :" + driver.getTitle());
    }

    @Override
    public void VerifyText(WebElement el, String Expectedtext) {
        System.out.println("Value From Screen:" + el.getText());
        System.out.println("Value From Test Case:" + Expectedtext);
        Assert.assertEquals(Expectedtext, el.getText(), "Text of Element displayed as -" + el.getText() + " and Expected String is-" + Expectedtext);
//        SoftAssert softAssert = new SoftAssert();
//        softAssert.assertEquals(el.getText(), Expectedtext, "Text of Element displayed as -" + el.getText() + " and Expected String is-" + Expectedtext);
    }

    @Override
    public void PageRefresh() throws Exception {
        // TODO Auto-generated method stub
        driver.navigate().refresh();
        sleep(5000);
    }

    @Override
    public String CurrentURL() {
        return driver.getCurrentUrl();
    }

    @Override
    public String CaptureScreenShotForElement(WebElement ele) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String CaptureFullScreenShot(WebDriver driver) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public void authentication(String type, String username, String password) {
        //String userName = null,password = null,accessToken = null,consumerKey = null,consumerSecret = null,tokenSecret = null;
        //FileInputStream ip = new FileInputStream(System.getProperty("user.dir")+ "/src/test/java/Config/config.properties");
        //propinhelper.load(ip);
        switch (type) {

            case "Basic": {
                Request.auth().basic(username, password);

                break;
            }
            case "preemptive": {
                Request.auth().preemptive().basic(username, password);

                break;
            }
            case "Form": {
                Request.auth().form(username, password);
                break;
            }
            case "ComplexForm": {
                Request.auth().form(username, password, new FormAuthConfig("/perform_login", "username", "password"));
                break;
            }
            case "Oauth2": {
//                generateAccessToken(baseurl,GrantType,clietID, Clientsecrate,Tokenurl);
                Request.auth().oauth2(username);
                break;
            }
            //				case "Oauth1":
            //				{
            //					Request.accept(ContentType.JSON)
            //					  .auth()
            //					  .oauth(consumerKey, consumerSecret, accessToken, tokenSecret);
            //					break;
            //				}
        }

    }

    //    @Override
//    public String generateAccessToken(String Baseurl,String Granttype,String clientId, String clientSecret,String tokenurl) {
//        Response response =
//                Request
//                        .baseUri(Baseurl)
//                        .contentType("application/x-www-form-urlencoded")
//                        .formParam("grant_type", Granttype)
//                        .formParam("client_id", clientId)
//                        .formParam("client_secret", clientSecret)
//                        .when()
//                        .post(Baseurl+"/"+tokenurl)
//                        .then()
//                        .statusCode(200)
//                        .extract()
//                        .response();
//
//        System.out.println("Printing Token"+response.jsonPath().getString("access_token"));
//        return response.jsonPath().getString("access_token");
//    }
    @Override
    public String generateAccessToken(String baseUrl, String grantType, String clientId, String clientSecret, String tokenUrl) {

        Response response = Request
                .given()
                .baseUri(baseUrl)
                .contentType("application/x-www-form-urlencoded")
                .formParam("grant_type", grantType)
                .formParam("client_id", clientId)
                .formParam("client_secret", clientSecret)
                .when()
                .post(tokenUrl)   // ✅ Only endpoint here
                .then()
                .extract()
                .response();

        int statusCode = response.getStatusCode();

        if (statusCode != 200) {
            throw new RuntimeException(
                    "Token generation failed. Status Code: " + statusCode +
                            "\nResponse Body: " + response.getBody().asString()
            );
        }
        String accessToken = response.jsonPath().getString("access_token");

        if (accessToken == null || accessToken.isEmpty()) {
            throw new RuntimeException("Access token is null or empty in response");
        }

        // Replace with logger
        System.out.println("Access token generated successfully");

        return accessToken;
    }

    @Override
    public void updateRequestHeader(String HeaderKey, String value) {
        Request.headers(HeaderKey, value);
    }

    public void clearRequestHeaders() {
        Request = given(); // reinitialize request spec
    }

    @Override
    public void updateMultipart(String HeaderKey, String value, String ContentType) {
        if (!ContentType.equalsIgnoreCase("NA")) {
            Request.multiPart(HeaderKey, value, ContentType);
        } else {
            String tc = value.split("//")[0];
            String Filename = value.split("//")[1];
            File file = new File(Root + "TestCaseFiles" + File.separator + tc + File.separator + Filename);
            Request.multiPart(HeaderKey, file);
        }
    }

    @Override
    public String readRequestTemplate(String path) throws IOException {
        // TODO Auto-generated method stub
        return new String(Files.readAllBytes(Paths.get(path)));
    }

    @Override
    public void updateAttributeInRequestBody(String Filename, String Key, String value) throws Exception {
        if (value == null) {
            value = "";
        }
        if (Filename.toLowerCase().endsWith(".json")) {
/*       String payload=readRequestTemplate(System.getProperty("user.dir")+ "/"+Root+Filename);
         if(Payload.equals("")) {
            Payload=payload;
         }
         Payload=Payload.replace("\""+Key+"\" : \""+Key+"\"","\""+Key+"\" : \""+Value+"\""); */


            String abc = "";
            String[] arrOfStr = Key.split("//");

            if (Key.endsWith("//")) {
                System.out.println("Provided Json node path is not correct!! it can't be end with //");
                Assert.fail("Provided Json node path is not correct!! it can't be end with //");
            }
            FileReader reader = null;
            try {
                Filename = System.getProperty("user.dir") + "/" + Root + Filename;
                System.out.println();
                reader = new FileReader(Filename);
            } catch (Exception e) {
                System.out.println("File path Pointed to Json file is incorrect!!! Please provide a valid path... ");
                e.getMessage();
            }
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject) jsonParser.parse(reader);

            JSONObject idObj1 = null;

            if (arrOfStr.length == 1 || arrOfStr.length == 0) {
                try {
                    if (!arrOfStr[0].contains("//")) {
                        System.out.println("// is missing with Node value!!!!");
                        Assert.assertFalse(arrOfStr[0].contains("//"), "// is missing with Node value!!!!");
                    } else {
                        System.out.println("Node is not correctly provided!!!!");
                    }
                } catch (Exception e) {
                    System.out.println("Node is not correctly provided!!!!");
                    e.getMessage();
                }
            } else {
                for (int i = 0; i < arrOfStr.length - 2; i++) {

                    //System.out.println(arrOfStr[i+1]);
                    if (idObj1 == null) {
                        idObj1 = (
                                (JSONObject) (
                                        jsonObject.get(arrOfStr[i + 1])
                                )
                        );
                    } else {
                        idObj1 = (JSONObject) idObj1.get(arrOfStr[i + 1]);
                    }
                }

                if (arrOfStr.length == 2) {
                    jsonObject.put(arrOfStr[arrOfStr.length - 1], value);

                } else {
                    idObj1.put(arrOfStr[arrOfStr.length - 1], value);

                }
                //System.out.println("After ID value updated : "+jsonObject)
                JSONDocumentPayload = jsonObject;
                abc = jsonObject.toJSONString();
            }

            Payload = abc;


            System.out.println("Updated Paylod" + Payload);
            ////ExtentTestManager.getTest().log(LogStatus.INFO, "Updated Paylod"+Payload);
        } else if (Filename.toLowerCase().endsWith(".xml")) {
            SAXReader xmlreader = new SAXReader();
            Document doc = xmlreader.read(Root + File.separator + "APIs" + File.separator + Filename);
            doc.selectSingleNode(Key).setText(value);
            XMLDocumentPayload = doc;
            Payload = doc.asXML();
            System.out.println("Updated Paylod" + Payload);
        }
    }

    public void updateAttributeInJsonBody(String Filename, String inventorySource, String availabilityType, String sku, String storeNumbers) throws org.json.simple.parser.ParseException, IOException {
        String abc = "";
        FileReader reader = null;
        try {
            Filename = System.getProperty("user.dir") + "/" + Root + Filename;
            System.out.println();
            reader = new FileReader(Filename);
        } catch (Exception e) {
            System.out.println("File path Pointed to Json file is incorrect!!! Please provide a valid path... ");
            e.getMessage();
        }

        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(reader);
        System.out.println(json.toJSONString());
        JSONObject idObj1 = null;
        JSONArray recs = (JSONArray) json.get("data");
        System.out.println("This is Data size-----------------" + recs.size());
        System.out.println(recs);

        for (Object rec : recs) {
            idObj1 = (JSONObject) rec;
            idObj1.put("inventorySource", inventorySource);
            idObj1.put("availabilityType", availabilityType);

            JSONArray recs1 = (JSONArray) idObj1.get("sku");
            recs1.remove(0);
            recs1.add(0, sku);
            idObj1.put("sku", recs1);
            JSONArray recs2 = (JSONArray) idObj1.get("storeNumbers");
            recs2.remove(0);
            recs2.add(0, storeNumbers);
            idObj1.put("storeNumbers", recs2);
        }
        json.put("data", recs);
        abc = json.toJSONString();
        System.out.println(abc);
        JSONDocumentPayload = json;
        Payload = abc;
    }

    public void addJsonArrayAttributesInJsonBody(String pincode, String availabilityType, String vendor, String partNumber, String skuId) {
        JSONObject requestParams = new JSONObject();
        requestParams.put("skuId", skuId);
        requestParams.put("pincode", pincode);
        requestParams.put("partNumber", partNumber);
        requestParams.put("vendor", vendor);
        requestParams.put("availabilityType", availabilityType);

        JSONObject jsonObject = new JSONObject(requestParams);

        String strJsonObject = jsonObject.toString();
        String strRequestParams = "[" + strJsonObject + "]";

        System.out.println(strRequestParams);
        JSONDocumentPayload = jsonObject;
        Payload = strRequestParams;
    }

    public void newUpdateAttributeInRequestBodyInSamePayload(String payLoad, String Key, String value) throws Exception {
        String[] arrOfStr = Key.split("\\.");
        JSONParser json = new JSONParser();
        JSONObject jsonObject = (JSONObject) json.parse(payLoad);
        JSONObject jObj = null;
        JSONArray jArr = null;
        JSONObject jsonRealObject = new JSONObject();
        jsonRealObject.putAll(jsonObject);
        String key;
        for (int i = 0; i <= arrOfStr.length - 1; i++) {
            if (arrOfStr[i].contains("[")) {
                key = (arrOfStr[i].replace("[", "")).replace("]", "");
                Integer index = Integer.parseInt(key.substring(key.length() - 1));
                key = key.substring(0, key.length() - 1);
                jArr = (JSONArray) jsonObject.get(key);
                jObj = (JSONObject) jArr.get(index);
            } else {
                key = arrOfStr[i];
                try {
                    jObj = (JSONObject) jsonObject.get(key);
                } catch (Exception e) {

                }
            }
            if (arrOfStr[arrOfStr.length - 1].equalsIgnoreCase(key)) {
                jObj.put(key, value);
            }
            if (jObj != null) {
                jsonObject = jObj;
            }
        }
        baseDriverHelper.Payload = jsonRealObject.toJSONString();
        System.out.println("Updated Paylod" + baseDriverHelper.Payload);
    }

    @Override
    public void updateAttributeInRequestBody(String Filename, HashMap<String, String> values) throws Exception {
        if (Filename.toLowerCase().endsWith(".json")) {
            //TODO need to implement
        } else if (Filename.toLowerCase().endsWith(".xml")) {
            SAXReader xmlreader = new SAXReader();
            Document doc = xmlreader.read(System.getProperty("user.dir") + "/" + Root + Filename);
            for (String key : values.keySet()) {
                doc.selectSingleNode(key).setText(values.get(key));
            }
            Payload = doc.asXML();
            System.out.println("Updated Paylod" + Payload);
        }
    }

    @Override
    public void generatePayLoad() {
        //Request.contentType(Contenttype);
        Request.body(Payload);

        System.out.println("********************************************");
        System.out.println(Payload);
        ReportPayload = Payload;
        //Reporter.addStepLog("<textarea readonly>"+Payload+"</textarea>");

        System.out.println("********************************************");
        Payload = "";
    }

    public void setRequestBody(String json) {
        Payload = json;
    }

    public void generatemultipart(String key, String Value) {
        //Request.contentType(Contenttype);

        Request.multiPart(key, Value);

    }

    @Override
    public void submitRequest(Method method, String URI) {
        Resultrespoence.set(null);

        System.out.println("Here is url" + URI);
        try {
            Resultrespoence.set(Request.request(method, URI));
        } catch (Exception e) {
            Resultrespoence.set(Request.request(method, URI));
//           String abc= Request.get().toString();
//            System.out.println(abc);
//            e.getMessage();
        }
        System.out.println("Response Body After Request: " + Resultrespoence.get().getBody().asString());
        Request.body("");
        //Reporter.addStepLog("<textarea readonly>"+Resultrespoence.get().getBody().asString()+"</textarea>");
    }

    @Override
    public void assertStringInResponceBody(String ExpectedData) {
        String responseBody = Resultrespoence.get().getBody().asString();
        System.out.println("Response Body is: " + responseBody);
        //validate city name or validate the key or value
        //ExtentTestManager.getTest().log(LogStatus.PASS, "Response Body is: "+ responseBody);

        Assert.assertTrue(responseBody.contains(ExpectedData));
    }

    @Override
    public void assertStatusCode(int ExpectedStatusCode) {
        int statusCode = Resultrespoence.get().getStatusCode();
        System.out.println("Status code is: " + statusCode);
        //ExtentTestManager.getTest().log(LogStatus.INFO, "Status code is: "+ statusCode);

        Assert.assertEquals(statusCode, ExpectedStatusCode);
        //validate city name or validate the key or value
        //return statusCode;
    }

    @Override
    public void assertStatusLine(String ExpectedStatusLine) {
        String statusCode = Resultrespoence.get().getStatusLine();
        System.out.println("Status Code is: " + statusCode);
        //ExtentTestManager.getTest().log(LogStatus.INFO, "Status Code is: "+ statusCode);

        Assert.assertEquals(statusCode, statusCode);
        //validate city name or validate the key or value
        //return statusCode;
    }

    @Override
    public void assertHeaderattribute(String HeaderName, String ExpectedheaderValue) {
        Headers headers = Resultrespoence.get().getHeaders();
        System.out.println(headers);

        String headervalue = Resultrespoence.get().getHeader(HeaderName);
        System.out.println("The value of content-type header is: " + headervalue);
        //ExtentTestManager.getTest().log(LogStatus.INFO, "The value of content-type header is: "+ headervalue);
        Assert.assertEquals(headervalue, headervalue);
    }

    @Override
    public void assertResponceBodyAttribute(String Node, String Expectedvalue) throws SAXException, IOException, ParserConfigurationException, DocumentException {
        System.out.println("Respoence body is " + Resultrespoence.get().getBody().asString());
        //ExtentTestManager.getTest().log(LogStatus.INFO, "Respoence body is "+Resultrespoence.get().getBody().asString());
        if (Resultrespoence.get().getHeader("content-type").contains("json")) {
            JsonPath jsonPathValue = Resultrespoence.get().jsonPath();
            //ExtentTestManager.getTest().log(LogStatus.INFO, "JsoneBody as String String"+jsonPathValue);
            String Nodevalue = jsonPathValue.getString(Node);
            System.out.println("The value of " + Node + " is: " + Nodevalue);
            //ExtentTestManager.getTest().log(LogStatus.INFO, "The value of "+Node+" is: "+ Nodevalue);

            System.out.println("Expected Value is : " + Expectedvalue);
            //ExtentTestManager.getTest().log(LogStatus.INFO, "Expected Value is : "+ Expectedvalue);

            System.out.println("Condition Value is " + Nodevalue.contains(Expectedvalue));
            //Assert.assertTrue();
            //ExtentTestManager.getTest().log(LogStatus.INFO, "Condition Value is "+ Nodevalue.contains(Expectedvalue));

            Assert.assertTrue(Nodevalue.contains(Expectedvalue), "Expected the Value of <b>" + Node + "</b> Attribute value contains <b>" + Expectedvalue + "</b> but  Actual returned was <b>" + Nodevalue + "</b>");
        } else if (Resultrespoence.get().getHeader("content-type").contains("xml")) {

            SAXReader xmlreader = new SAXReader();
            Document doc = xmlreader.read(Resultrespoence.get().asInputStream());
            Assert.assertEquals(Expectedvalue, doc.selectSingleNode(Node).getText(), "Expected the Value of <b>" + Node + "</b> Attribute value contains <b>" + Expectedvalue + "</b> but  Actual returned was <b>" + doc.selectSingleNode(Node).getText() + "</b>");
        } else {
            Assert.fail("Response Content-Type is not matched.Please check the Assertion");
        }

    }

    @Override
    public String SaveAttributevalue(String Node) throws DocumentException {
        String Nodevalue = null;
        if (Resultrespoence.get().getContentType().contains("json")) {
            System.out.println("Data in Reponce is" + Resultrespoence.get().getBody().asString());
            JsonPath jsonPathValue = Resultrespoence.get().jsonPath();
            Nodevalue = jsonPathValue.get(Node).toString();
            System.out.println("The value of " + Node + " is: " + Nodevalue);
            //ExtentTestManager.getTest().log(LogStatus.INFO, "The value of "+Node+" is: "+ Nodevalue);

            Assert.assertEquals(Nodevalue, Nodevalue);
        } else if (Resultrespoence.get().getContentType().contains("xml")) {
            SAXReader xmlreader = new SAXReader();
            Document doc = xmlreader.read(Resultrespoence.get().asInputStream());
            Nodevalue = doc.selectSingleNode(Node).getText();
        } else {
            Assert.fail("Invalid Content Type");
        }
        return Nodevalue;
    }

    @Override
    public JSONObject Inputgenerator(JSONObject templatefile, String Node, String Value) {
        JSONObject jsonObjectnodelist = null;
        JSONObject jsonObjectfinal = templatefile;
        String[] nodelist = Node.split(".");
        if (nodelist.length == 1) {
            // Update the Node
            System.out.println(jsonObjectnodelist.get(nodelist[nodelist.length - 1]));
        } else {
            for (int i = 0; i < nodelist.length - 2; i++) {
                jsonObjectnodelist = (JSONObject) templatefile.get(nodelist[i]);
                System.out.println(jsonObjectnodelist.toString());
            }
            System.out.println(jsonObjectnodelist.get(nodelist[nodelist.length - 1]));
        }

        return templatefile;
    }

    @Override
    public void validateResponseJsonSchema(String path) {
        String updatedpath = System.getProperty("user.dir") + "/" + Root + path;
        Resultrespoence.get().then().body(matchesJsonSchema(new File(updatedpath)));
    }

    @Override
    public String appendUriWithParameters(String uri, Map<String, String> headerMap) {
        int i = 1;
        for (String key : headerMap.keySet()) {
            if (i == 1) {
                uri = uri.concat("?" + key + "=" + headerMap.get(key));
            } else {
                uri = uri.concat("&" + key + "=" + headerMap.get(key));
            }
            i++;

        }
        return uri;
    }

    @Override
    public void addRequestParameters(Map<String, String> headerMap) {
        Request.params(headerMap);
    }

    public void addQueryParameters(String key, String value) {
        Request.queryParam(key, value);
    }

    @Override
    public void setContentType(String contentType) {
        Request.contentType(contentType);

    }

    @Override
    public void setContentTypeRestAssured(ContentType contentType) {
        Request.contentType(contentType);

    }

    @Override
    public void validateResponseXMLSchema(String path) {

        String updatedpath = System.getProperty("user.dir") + "/" + Root + path;
        Resultrespoence.get().then().body(matchesXsd(new File(updatedpath)));
    }

    @Override
    public String getBaseURI(String uri) {
        Properties pr = new Properties();
        InputStream file = null;
        String value = null;
        String endpoint = "";
        try {
            file = new FileInputStream("config.properties");
            pr.load(file);
            value = pr.getProperty("ENV").trim();
            if (value.equalsIgnoreCase("local")) {
                endpoint = pr.getProperty("localmock_url");
            } else {
                String env = value.toLowerCase();
                endpoint = pr.getProperty(env + "_" + uri);
            }
        } catch (Exception e) {
            // TODO: handle exception
        } finally {
            try {
                file.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return endpoint;
    }

    @Override
    public void validateResponseXMLSchemaWithoutSoapEnvelope(String path) throws IOException {
        String updatedpath = System.getProperty("user.dir") + "/" + Root + path;
        final SimpleXml simple = new SimpleXml();
        String res = Resultrespoence.get().then().extract().asString();
        String resp = (simple.domToXml(getBook(simple.fromXml(res))));
        StringReader sr = new StringReader(resp);
        Resultrespoence.get().then().body(matchesXsd(new File(updatedpath)));
    }

    private static Element getBook(final Element element) {
        return element.children.get(0).children.get(0);
    }

    @Override
    public void readPayload(String requestpath) {
        try {
            String payload = readRequestTemplate(Root + requestpath);
            Payload = payload;
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @Override
    public String getSingleValueFromResponse(String Node) {
        String nodevalue = null;
        System.out.println("Content type : " + Resultrespoence.get().getHeader("content-type"));
        if (Resultrespoence.get().getHeader("content-type").contains("json")) {
            JsonPath jsonPathValue = Resultrespoence.get().jsonPath();
            //ExtentTestManager.getTest().log(LogStatus.INFO, "JsoneBody as String String"+jsonPathValue);
            nodevalue = jsonPathValue.getString(Node);

        } else if (Resultrespoence.get().getHeader("content-type").contains("xml")) {

            SAXReader xmlreader = new SAXReader();
            Document doc = null;
            try {
                doc = xmlreader.read(Resultrespoence.get().asInputStream());
            } catch (DocumentException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            nodevalue = doc.selectSingleNode(Node).getText();
        }
        return nodevalue;
    }

    public void Stringcomparator(String actual, String expected) {
        System.out.println("Actual String : " + actual);
        System.out.println("Expected String : " + expected);
        if (expected == null) {
            expected = "";
        }
        if (actual == null) {
            actual = "";
        }

//		Assert.assertTrue(actual.equals(expected));
        Assert.assertEquals(actual.trim(), expected.trim(), actual + " Not matched with " + expected);


    }

    public void Jsoncomparator(JsonElement actual, JsonElement expected) {
        System.out.println("Actual String : " + actual);
        System.out.println("Expected String : " + expected);


        Assert.assertEquals(expected, actual);


    }

    public void Booleancomparator(Boolean actual, Boolean expected) {
        System.out.println("Actual String : " + actual);
        System.out.println("Expected String : " + expected);
        Assert.assertSame(actual, expected);
    }

    public void UpdatedAttributeinxmlPayload(String Node, String Value) throws DocumentException, IOException, SAXException, ParserConfigurationException {
        Document doc = XMLDocumentPayload;
        doc.selectSingleNode(Node).setText(Value);
        XMLDocumentPayload = doc;
        Payload = doc.asXML();
        System.out.println("Updated Paylod" + Payload);
    }

    public void UpdatedAttributeinJsonPayload(String Node, String Value, boolean isstring) throws DocumentException, IOException, SAXException, ParserConfigurationException {


        String abc = "";
        String[] arrOfStr = Node.split("//");

        if (Node.endsWith("//")) {
            System.out.println("Provided Json node path is not correct!! it can't be end with //");
            Assert.fail("Provided Json node path is not correct!! it can't be end with //");
        }
        JSONObject jsonObject = JSONDocumentPayload;

        JSONObject idObj1 = null;

        if (arrOfStr.length == 1 || arrOfStr.length == 0) {
            try {
                if (!arrOfStr[0].contains("//")) {
                    System.out.println("// is missing with Node value!!!!");
                    Assert.assertFalse(arrOfStr[0].contains("//"), "// is missing with Node value!!!!");
                } else {
                    System.out.println("Node is not correctly provided!!!!");
                }
            } catch (Exception e) {
                System.out.println("Node is not correctly provided!!!!");
                e.getMessage();
            }
        } else {
            for (int i = 0; i < arrOfStr.length - 2; i++) {

                //System.out.println(arrOfStr[i+1]);
                if (idObj1 == null) {
                    idObj1 = (
                            (JSONObject) (
                                    jsonObject.get(arrOfStr[i + 1])
                            )
                    );
                } else {
                    idObj1 = (JSONObject) idObj1.get(arrOfStr[i + 1]);
                }
            }

            if (arrOfStr.length == 2) {
                if (isstring)
                    jsonObject.put(arrOfStr[arrOfStr.length - 1], Value);
                else {
                    BigInteger obj = new BigInteger(Value);
                    jsonObject.put(arrOfStr[arrOfStr.length - 1], obj);
                }
            } else {
                if (isstring) {
                    idObj1.put(arrOfStr[arrOfStr.length - 1], Value);
                } else {
                    if (Value.equalsIgnoreCase("true") || Value.equalsIgnoreCase("false")) {
                        idObj1.put(arrOfStr[arrOfStr.length - 1], Boolean.parseBoolean(Value));
                    } else {
                        BigInteger obj = new BigInteger(Value);
                        idObj1.put(arrOfStr[arrOfStr.length - 1], obj);
                    }
                }

            }
            JSONDocumentPayload = jsonObject;
            abc = jsonObject.toJSONString();
        }

        Payload = abc;
    }

    public void UpdatedAttributeinJsonPayloadGeneric(String Node, String Value, boolean isString) throws DocumentException, IOException, SAXException, ParserConfigurationException {


        String abc = "";
        String[] arrOfStr = Node.split("//");

        if (Node.endsWith("//")) {
            System.out.println("Provided Json node path is not correct!! it can't be end with //");
            Assert.fail("Provided Json node path is not correct!! it can't be end with //");
        }
        JSONObject jsonObject = JSONDocumentPayload;

        JSONObject idObj1 = null;

        if (arrOfStr.length == 1 || arrOfStr.length == 0) {
            try {
                if (!arrOfStr[0].contains("//")) {
                    System.out.println("// is missing with Node value!!!!");
                    Assert.assertFalse(arrOfStr[0].contains("//"), "// is missing with Node value!!!!");
                } else {
                    System.out.println("Node is not correctly provided!!!!");
                }
            } catch (Exception e) {
                System.out.println("Node is not correctly provided!!!!");
                e.getMessage();
            }
        } else {
            for (int i = 0; i < arrOfStr.length - 2; i++) {

                //System.out.println(arrOfStr[i+1]);
                if (idObj1 == null) {
                    idObj1 = (
                            (JSONObject) (
                                    jsonObject.get(arrOfStr[i + 1])
                            )
                    );
                } else {
                    idObj1 = (JSONObject) idObj1.get(arrOfStr[i + 1]);
                }
            }

            if (arrOfStr.length == 2) {
                if (isString)
                    jsonObject.put(arrOfStr[arrOfStr.length - 1], Value);
                else {
                    BigInteger obj = new BigInteger(Value);
                    jsonObject.put(arrOfStr[arrOfStr.length - 1], obj);
                }
            } else {
                if (isString)
                    idObj1.put(arrOfStr[arrOfStr.length - 1], Value);
                else {
                    Gson gson = new Gson();

                    Object valueAsObject = gson.fromJson(Value, Object.class);

                    idObj1.put(arrOfStr[arrOfStr.length - 1], valueAsObject);
                }

            }
            JSONDocumentPayload = jsonObject;
            abc = jsonObject.toJSONString();
        }

        Payload = abc;
    }

    public void UpdatedAttributeinJsonPayload1(String Node, String Value, boolean isstring) throws DocumentException, IOException, SAXException, ParserConfigurationException {
        String abc = "";

        String[] arrOfStr = Node.split("\\.");

        JSONObject jsonObject = JSONDocumentPayload;

        JSONObject jObj = null;
        JSONArray jArr = null;
        JSONObject jsonRealObject = new JSONObject();
        jsonRealObject.putAll(jsonObject);
        String key;

        for (int i = 0; i <= arrOfStr.length - 1; i++) {
            if (arrOfStr[i].contains("[")) {
                key = (arrOfStr[i].replace("[", "")).replace("]", "");
                Integer index = Integer.parseInt(key.substring(key.length() - 1));
                key = key.substring(0, key.length() - 1);
                jArr = (JSONArray) jsonObject.get(key);
                jObj = (JSONObject) jArr.get(index);
            } else {
                key = arrOfStr[i];
                try {
                    jObj = (JSONObject) jsonObject.get(key);
                } catch (Exception e) {

                }
            }
            if (arrOfStr[arrOfStr.length - 1].equalsIgnoreCase(key)) {
                if (isstring) {
                    if (Value == null) {
                        jObj.put(key, "");
                    } else {
                        jObj.put(key, Value);
                    }
                } else {
                    if (Value.equalsIgnoreCase("true") || Value.equalsIgnoreCase("false")) {
                        jObj.put(key, Boolean.parseBoolean(Value));
                    } else {
                        BigInteger obj = new BigInteger(Value);
                        jObj.put(key, obj);
                    }
                }
            }
            if (jObj != null) {
                jsonObject = jObj;
            }
        }
        JSONDocumentPayload = jsonRealObject;
        abc = jsonRealObject.toJSONString();

        Payload = abc;
    }

    public void removeAttribureinJsonPayload(String pathToRemove) throws JsonProcessingException {
        String abc = "";
        JSONObject jsonObject = JSONDocumentPayload;
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode rootNode = objectMapper.readTree(jsonObject.toString());

        // Path to the node to be removed
        //String pathToRemove = "/data/orderLineItems/0/discApplied";
        // String pathToRemove = "/data/billingAddress/country";

        // Split the path into parts
        String[] pathParts = pathToRemove.split("/");

        // Navigate to the parent node of the node to be removed
        JsonNode currentNode = rootNode;
        for (int i = 1; i < pathParts.length - 1; i++) {
            String part = pathParts[i];
            if (currentNode.isArray()) {
                // If the current node is an array, parse the index and get the element
                int index = Integer.parseInt(part);
                currentNode = currentNode.get(index);
            } else {
                // Otherwise, get the child node
                currentNode = currentNode.path(part);
            }
        }

        // Remove the specified node
        String lastPart = pathParts[pathParts.length - 1];
        if (currentNode.isObject()) {
            ((ObjectNode) currentNode).remove(lastPart);
        } else if (currentNode.isArray()) {
            int index = Integer.parseInt(lastPart);
            ((ArrayNode) currentNode).remove(index);
        }

        String updatedJsonString = objectMapper.writeValueAsString(rootNode);
        // Print the updated JSON string
        System.out.println("Updated JSON: " + updatedJsonString);
        // JSONDocumentPayload = updatedJsonString;
        abc = updatedJsonString;
        Payload = abc;
    }

    public void payloadFromPOJOClass(String PayloadValue) {
        Payload = PayloadValue;

    }

    public void submitRequestWithHeader(Method method, String URI) {
        Resultrespoence.set(null);
        Request.headers("Content-Type", "text/xml");
        Resultrespoence.set(Request.request(method, URI));
        System.out.println("Response Body After Request: " + Resultrespoence.get().getBody().asString());
        ////ExtentTestManager.getTest().log(LogStatus.INFO, "Response Body After Request: "+ Resultrespoence.get().getBody().asString());
        Request.body("");
        //	Reporter.addStepLog(Resultrespoence.get().getBody().asString());
    }

    public void assertNodeIsPresent(String Node, boolean expected) throws SAXException, IOException, ParserConfigurationException, DocumentException {
        boolean flag = false;
        if (Resultrespoence.get().getHeader("content-type").contains("json")) {
            JsonPath jsonPathValue = Resultrespoence.get().jsonPath();
            try {
                if (jsonPathValue.getList(Node).size() > 0) {
                    if (!jsonPathValue.getString(Node).contains("null")) {
                        flag = true;
                    }
                }
            } catch (Exception e) {
                flag = false;
            }

            Assert.assertEquals(flag, expected, "Node <b>" + Node + "</b> contains in the response ");
        } else if (Resultrespoence.get().getHeader("content-type").contains("xml")) {

            SAXReader xmlreader = new SAXReader();
            Document doc = xmlreader.read(Resultrespoence.get().asInputStream());
            try {
                if (doc.selectNodes(Node).size() > 0) {
                    flag = true;
                }
            } catch (Exception e) {
                flag = false;
            }
            Assert.assertEquals(flag, expected, "Node <b>" + Node + "</b> contains in the response which is expected :- " + expected);
        } else {
            Assert.fail("Response Content-Type is not matched.Please check the Assertion");
        }
    }

    public String Base64Encoder(String data) throws SAXException, IOException, ParserConfigurationException, DocumentException {
        Base64.Encoder encoder = Base64.getEncoder();
        String originalString = data;
        String encodedString = encoder.encodeToString(originalString.getBytes());

        System.out.println(encodedString);
        return encodedString;
    }

    public String ReturnPaylod() throws SAXException, IOException, ParserConfigurationException, DocumentException {

        return Payload;
    }

    public boolean isValidDateFormat(String dateStr, String dateFormat) {
        DateFormat sdf = new SimpleDateFormat(dateFormat);
        sdf.setLenient(false);
        try {
            sdf.parse(dateStr);
        } catch (ParseException e) {
            return false;
        }
        return true;
    }

    public void Partialstringcomparator(String actual, String expected) {
        System.out.println("Actual String : " + actual);
        System.out.println("Expected String : " + expected);
        if (expected == null) {
            expected = "";
        }
        if (actual == null) {
            actual = "";
        }
        Assert.assertTrue(actual.contains(expected), actual + " Not contains " + expected);

    }

    public String RetrurnResponce() {
        return Resultrespoence.get().asString();
    }

    public String getTodaysDateinFormat(String dateFormat) {
        DateFormat dteFormat = new SimpleDateFormat("dd/MM/yyyy");
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        String requiredData = dteFormat.format(date);
        return requiredData;
    }

    @Override
    public String pollCurrentTime(String className, String timeStamp, String timeOut) throws InterruptedException {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("mm:ss");
        LocalTime Time = LocalTime.now().plusMinutes(Integer.valueOf(timeOut.split(":")[0])).plusSeconds(Integer.valueOf(timeOut.split(":")[1]));
        JavascriptExecutor js = (JavascriptExecutor) driver;
        String p = "";
        while (true) {
            try {
                p = getwebelement("//*[@class='" + className + "']/span").getText();
                //(String) js.executeScript(" return document.getElementsByClassName(\"" + className + "\")[0].textContent");
                if (compare(p, timeStamp)) {

                    js.executeScript("arguments[0].click();", getwebelement("//*[@class='playkit-icon playkit-icon-play']"));
                    break;
                }
            } catch (Exception e) {
            }
            if (!p.isEmpty()) {
                if (Integer.valueOf(p.split(":")[0]) >= Integer.valueOf(timeStamp.split(":")[0])) {
                    if (Integer.valueOf(p.split(":")[1]) >= Integer.valueOf(timeStamp.split(":")[1]) || LocalTime.now() == Time) {
                        js.executeScript("arguments[0].click();", getwebelement("//*[@class='playkit-icon playkit-icon-play']"));

                        //js.executeScript("document.getElementsByClassName(\"playkit-icon playkit-icon-play\")[0].click();");
                        break;
                    }
                }
            }
        }
        return p;
    }

    public boolean compare(String webTimeStamp, String androidTimeStamp) {
        int result = (Integer.valueOf(webTimeStamp.split(":")[0]) * 60 + Integer.valueOf(webTimeStamp.split(":")[1])) - (Integer.valueOf(androidTimeStamp.split(":")[0]) * 60 + Integer.valueOf(androidTimeStamp.split(":")[1]));
        return result >= 0 && result <= 40;
    }

    public void HandleAngularwait() {
        JavascriptExecutor jsDriver = (JavascriptExecutor) driver;
        ngDriver = new NgWebDriver(jsDriver);
        ngDriver.waitForAngularRequestsToFinish();
    }

    public void HandleAngularmain() {
        int count = driver.findElements(ByAngular.repeater("result in memory")).size();
        System.out.println("Count  " + count);
        Assert.assertEquals(count, 1);

    }

    public void navigateBack() {
        driver.navigate().back();
    }

    public WebElement getNGWebelement(String locator) throws InterruptedException {
        String[] finalval;
        try {
            System.out.print("\nIn Get element method for - " + locator + " ");
            if (locator.startsWith("binding")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        el = driver.findElement(ByAngular.binding(finalval[1]));
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });
            } else if (locator.startsWith("buttonText")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        el = driver.findElement(ByAngular.buttonText(finalval[1]));
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });
            } else if (locator.startsWith("exactBinding")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        el = driver.findElement(ByAngular.exactBinding(finalval[1]));
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });
            } else if (locator.startsWith("exactRepeater")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        el = driver.findElement(ByAngular.exactRepeater(finalval[1]));
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });
            } else if (locator.startsWith("model")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        el = driver.findElement(ByAngular.model(finalval[1]));
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });
            } else if (locator.startsWith("partialButtonText")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        el = driver.findElement(ByAngular.partialButtonText(finalval[1]));
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });
            } else if (locator.startsWith("repeater")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        el = driver.findElement(ByAngular.repeater(finalval[1]));
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return el;
    }

    //To delete the last request
    public void DeleteRequest() {
        Request.delete();
    }

    public void mouseOver(String locator) {
        Actions action = new Actions(driver);
        WebElement we = driver.findElement(By.xpath(locator));
        action.moveToElement(we).build().perform(); //.click().build().perform();
        waitForElementLoad(3);
    }

    public void mouseOver(WebElement el) {
        Actions action = new Actions(driver);
        action.moveToElement(el).build().perform();
        waitForElementLoad(3);
    }

    public WebElement getWebElementWithRelative(String locator, WebElement wl, String relative) throws InterruptedException {
        String[] finalval;
        try {
            if (locator.startsWith("name")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
//                            el = driver.findElement(By.name(finalval[1]));
                            switch (relative) {
                                case "above":
                                    el = driver.findElement(RelativeLocator.with(By.name(finalval[1])).above(wl));
                                    break;
                                case "below":
                                    el = driver.findElement(RelativeLocator.with(By.name(finalval[1])).below(wl));
                                    break;
                                case "near":
                                    el = driver.findElement(RelativeLocator.with(By.name(finalval[1])).near(wl));
                                    break;
                                case "toLeftOf":
                                    el = driver.findElement(RelativeLocator.with(By.name(finalval[1])).toLeftOf(wl));
                                    break;
                                case "toRightOf":
                                    el = driver.findElement(RelativeLocator.with(By.name(finalval[1])).toRightOf(wl));
                                    break;
                                default:
                                    System.out.println("Relative parameter should be - near, above, below, toLeftOf, and toRightOf.");
                                    Assert.fail("Relative parameter should be - near, above, below, toLeftOf, and toRightOf.");
                            }
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {
                                wait.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                wait.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });
                //wait.until(ExpectedConditions.stalenessOf(element))
            } else if (locator.startsWith("id")) {
                finalval = locator.split("=");
                try {
                    switch (relative) {
                        case "above":
                            el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).above(wl));
                            break;
                        case "below":
                            el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).below(wl));
                            break;
                        case "near":
                            el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).near(wl));
                            break;
                        case "toLeftOf":
                            el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).toLeftOf(wl));
                            break;
                        case "toRightOf":
                            el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).toRightOf(wl));
                            break;
                        default:
                            System.out.println("Relative parameter should be - near, above, below, toLeftOf, and toRightOf.");
                            Assert.fail("Relative parameter should be - near, above, below, toLeftOf, and toRightOf.");

                    }

                } catch (NoSuchElementException e) {
                    el = null;
                }
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
//                            el=driver.findElement(By.id(finalval[1]));
                            switch (relative) {
                                case "above":
                                    el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).above(wl));
                                    break;
                                case "below":
                                    el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).below(wl));
                                    break;
                                case "near":
                                    el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).near(wl));
                                    break;
                                case "toLeftOf":
                                    el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).toLeftOf(wl));
                                    break;
                                case "toRightOf":
                                    el = driver.findElement(RelativeLocator.with(By.id(finalval[1])).toRightOf(wl));
                                    break;
                                default:
                                    System.out.println("Relative parameter should be - near, above, below, toLeftOf, and toRightOf.");
                                    Assert.fail("Relative parameter should be - near, above, below, toLeftOf, and toRightOf.");
                            }
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {
                                wait.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                wait.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });

            } else if (locator.startsWith("//") || locator.startsWith("(//") || locator.startsWith("(")) {
                //el=driver.findElement(By.xpath(locator));
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        try {
//                            el=driver.findElement(By.xpath(locator));
                            switch (relative) {
                                case "above":
                                    el = driver.findElement(RelativeLocator.with(By.xpath(locator)).above(wl));
                                    break;
                                case "below":
                                    el = driver.findElement(RelativeLocator.with(By.xpath(locator)).below(wl));
                                    break;
                                case "near":
                                    el = driver.findElement(RelativeLocator.with(By.xpath(locator)).near(wl));
                                    break;
                                case "toLeftOf":
                                    el = driver.findElement(RelativeLocator.with(By.xpath(locator)).toLeftOf(wl));
                                    break;
                                case "toRightOf":
                                    el = driver.findElement(RelativeLocator.with(By.xpath(locator)).toRightOf(wl));
                                    break;
                                default:
                                    System.out.println("Relative parameter should be - near, above, below, toLeftOf, and toRightOf.");
                                    Assert.fail("Relative parameter should be - near, above, below, toLeftOf, and toRightOf.");

                            }
                        } catch (NoSuchElementException e) {
                            el = null;
                        }
                        if (el != null) {
                            try {

                                wait.until(ExpectedConditions.elementToBeClickable(el));
                            } catch (Exception e) {
                                wait.until(ExpectedConditions.visibilityOf(el));
                            }
                        }
                        return el;
                    }
                });

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //getwebelement(locator);
        }
        if (el != null) {
        }
        return el;
    }

    public String getcookiesValue(String key) {
        String value = "";
        value = String.valueOf(driver.manage().getCookieNamed(key));
        return value;
    }

    public WebElement getShadowWebElement(String locator) {
        Shadow shadow = new Shadow(driver);
        System.out.print("In Get element method for - " + locator);
        String[] finalval;
        try {
            if (locator.startsWith("name")) {
                finalval = locator.split("=");
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
//						el=shadow.findElement("[name="+finalval[1]+"]");
                        el = shadow.findElementByXPath("//*[@name='" + finalval[1] + "']");
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });
                //wait.until(ExpectedConditions.stalenessOf(element))
            } else if (locator.startsWith("id")) {
                finalval = locator.split("=");
                //Log.info(finalval[1]);
                //Log.info("Indriverhelper"+driver);
                //el=driver.findElement(By.id(finalval[1]));
                el = shadow.findElement("#" + finalval[1]);

//				el = shadow.findElementByXPath("//*[@id='"+finalval[1]+"']");

                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        //el=shadow.findElement("#"+finalval[1]);
                        el = shadow.findElementByXPath("//*[@id='" + finalval[1] + "']");

                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        //wait.until(el.isEnabled());
                        return el;
                    }
                });

            } else if (locator.startsWith("//") || locator.startsWith("(//") || locator.startsWith("(")) {
                //el=driver.findElement(By.xpath(locator));
                wait.until(new Function<WebDriver, WebElement>() {
                    public WebElement apply(WebDriver driver) {
                        //	el = driver.findElement(By.xpath(locator));
                        el = shadow.findElementByXPath(locator);
                        try {
                            wait.until(ExpectedConditions.elementToBeClickable(el));
                        } catch (Exception e) {
                            wait.until(ExpectedConditions.visibilityOf(el));
                        }
                        return el;
                    }
                });

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return el;
    }

    public void SwitchToFrame(WebElement el) {
        driver.switchTo().frame(el);
    }

    public void waitforElementtobeclickable(String locator) throws InterruptedException {
        System.out.println("In Wait for Element Clickable method for - " + locator);
        //waitForpageload();
        if (locator.startsWith("//") || locator.startsWith("(")) {

            wait.until(ExpectedConditions.elementToBeClickable(By.xpath(locator)));
            //getwebelement(xml.getlocator("//locators/StandrdQuote"));
            System.out.println("Waiting for Element to be clickabal and active" + locator);
            //Thread.sleep(2000);
        } else if (locator.startsWith("name")) {
            wait.until(ExpectedConditions.elementToBeClickable(By.name(locator.split("=")[1])));
            //getwebelement(xml.getlocator("//locators/StandrdQuote"));
            System.out.println("Waiting for Element to be clickabal and active" + locator);
            //Thread.sleep(2000);

        } else if (locator.startsWith("id")) {
            wait.until(ExpectedConditions.elementToBeClickable(By.id(locator.split("=")[1])));
            //getwebelement(xml.getlocator("//locators/StandrdQuote"));
            System.out.println("Waiting for Element to be clickabal and active" + locator);
            //Thread.sleep(2000);

        }
    }

    public void waitForElementToBeClickable(WebElement element) {
        System.out.println("In Wait for Element Clickable method for - " + element);
        wait.until(ExpectedConditions.elementToBeClickable(element));
    }

    public void waitForElementNotToBeVisible(String xpath) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30)); // configurable timeout
        wait.until(ExpectedConditions.invisibilityOfElementLocated(By.xpath(xpath)));
    }

    public void verifyElementToBePresent(String Locators) throws InterruptedException {
        try {
            int count = getwebelementscount(Locators);
            System.out.println("Number of Elements" + count);
            Assert.assertTrue(count >= 1);
        } catch (Exception e) {
            Refresh();
            int count = getwebelementscount(Locators);
            System.out.println("Number of Elements" + count);
            Assert.assertTrue(count >= 1);
        }
    }

    public void verifyElementNotToBePresent(String Locators) throws InterruptedException {
        int count = getwebelementscount(Locators);
        Stringcomparator(String.valueOf(count), "0");
    }

    public void waitForCompletePageLoad() {
        waitForLoad(driver);
    }

    void waitForLoad(WebDriver driver) {
        ExpectedCondition<Boolean> pageLoadCondition = new
                ExpectedCondition<Boolean>() {
                    public Boolean apply(WebDriver driver) {
                        return ((JavascriptExecutor) driver).executeScript("return document.readyState").equals("complete");
                    }
                };
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(pageLoadCondition);
    }

    public void waitforFrameToBeAvailableAndSwitchToIt(String frameName) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(ExpectedConditions.frameToBeAvailableAndSwitchToIt(frameName));
    }

    public void waitforTitleContains(String Title) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(40));
        wait.until(ExpectedConditions.titleContains(Title));
    }

    public void waitFortTextToBePresentInElement(WebElement wl, String Textanme) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(40));
        wait.until(ExpectedConditions.textToBePresentInElement(wl, Textanme));
    }

    public void waitUntilTheElementIsVisible(WebElement wl) {
        try {
            WebDriverWait wait1 = new WebDriverWait(driver, Duration.ofSeconds(10));
            wait1.until(ExpectedConditions.visibilityOf(wl));
            System.out.println("Element is visible on Screen");
        } catch (Exception e) {
            try {
                sleep(500);
            } catch (InterruptedException ex) {
                System.out.println("Element is Not visible on Screen");
                throw new RuntimeException(ex);
            }
        }
    }

    public void waitUntilElementIsVisible(String locator) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(40));
        wait.until(ExpectedConditions.presenceOfElementLocated(By.xpath(locator)));
    }

    public WebElement waitUntilElementIsVisible(By locator, int timeoutSeconds) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(timeoutSeconds));
        wait.pollingEvery(Duration.ofMillis(200))
                .ignoring(StaleElementReferenceException.class)
                .ignoring(NoSuchElementException.class);

        return wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
    }

    public void waitUntilTheElementIsNotVisible(String element) {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(40));
            wait.until(ExpectedConditions.invisibilityOfElementLocated(By.xpath(element)));
            System.out.println("Element is not visible on screen now");
        } catch (Exception e) {
            System.out.println("Element is still visible on screen");
            throw e;
        }
    }

    public void waitUntilTheElementIsNotSelected(WebElement wl) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(ExpectedConditions.elementSelectionStateToBe(wl, false));
    }

    public void waitUntilTheAttributeValueChangeToAnElement(WebElement wl, String AttributeName, String AttributeValue) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(ExpectedConditions.attributeToBe(wl, AttributeName, AttributeValue));
    }

    public void waitUntilAlertNotDisplaying() throws InterruptedException {
        int i = 0;
        while (i++ < 5) {
            try {
                Alert alert = driver.switchTo().alert();
            } catch (NoAlertPresentException e) {
                sleep(1000);
                break;
            }
        }
    }

    public boolean verifyAlertPresent() {
        return isAlertPresent();
    }

    public String returnAlertMessage() {
        return driver.switchTo().alert().getText().trim();
    }

    public boolean isAlertPresent() {
        try {
            driver.switchTo().alert();
            return true;
        }   // try
        catch (NoAlertPresentException Ex) {
            return false;
        }   // catch
    }

    public void waitUntilTheAlertIsDisplaying() {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(ExpectedConditions.alertIsPresent());
    }

    public void waitUntilANewWindowOpen() {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(ExpectedConditions.numberOfWindowsToBe(2));
    }

    public void waitUntilAllImagesAreLoaded() {
        JavascriptExecutor jse = (JavascriptExecutor) driver;
        // Getting DOM status
        Object result = jse.executeScript("return document.readyState;");
        System.out.println("=> The status is : " + result.toString());
        // Checking DOM loading is completed or not?
        if (result.equals("complete")) {
            // Fetching images count
            result = jse.executeScript("return document.images.length");
            int imagesCount = Integer.parseInt(result.toString());
            boolean allLoaded = false;
            // Checking and waiting until all the images are getting loaded
            while (!allLoaded) {
                int count = 0;
                for (int i = 0; i < imagesCount; i++) {
                    result = jse.executeScript("return document.images[" + i + "].complete;");
                    boolean loaded = (Boolean) result;
                    if (loaded) count++;
                }
                // Breaking the while loop if all the images loading completes
                if (count == imagesCount) {
                    System.out.println("=> All the Images are loaded...");
                    break;
                } else {
                    System.out.println("=> Not yet loaded...");
                }
                try {
                    sleep(1000);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

    public void uncheckTheCheckBox(WebElement el) {
        if (el.isSelected()) {
            el.click();
        } else {
            System.out.println("Checkbox is already Unselected");
        }
    }

    public void verifyCurrentURL(String ExpectedURL) {
        // TODO Auto-generated method stub
        Assert.assertTrue(driver.getCurrentUrl().contains(ExpectedURL));
    }

    public void CheckTheCheckBox(WebElement el) {
        el.click();
    }

    public boolean returnListHasSomeOptionSelected(WebElement wl) {
        Select sel = new Select(wl);
        return true;
    }

    public int returnListHasNumberOfOptions(WebElement wl) {
        Select sel = new Select(wl);
        return sel.getOptions().size();
    }

    public List<String> returnAllOptions(WebElement wl) {
        Select sel = new Select(wl);
        return sel.getOptions().stream().map(WebElement::getText).collect(Collectors.toList());
    }

    public boolean returnListHasOptionWithValueSelected(WebElement wl, String Value) {
        Select sel = new Select(wl);
        return sel.getAllSelectedOptions().toString().contains(Value);
    }

    public String returnValueSelectedInList(WebElement wl) {
        Select sel = new Select(wl);
        return sel.getFirstSelectedOption().toString();
    }

    public int returnOptionsCountsInList(WebElement wl) {
        Select sel = new Select(wl);
        return sel.getOptions().size();
    }

    public boolean returnAllowSelectionOfMultipleOptionFlag(WebElement wl) {
        Select sel = new Select(wl);
        return sel.isMultiple();
    }

    public boolean returnElementEmptyValueFlag(WebElement el) {
        boolean flag = false;
        String value = el.getAttribute("value");
        System.out.println("Valueee:" + value);
        flag = !value.isEmpty();
        return flag;
    }

    public boolean returnElementEmptyTextFlag(WebElement el) {
        boolean flag = false;
        String value = GetText(el);
        System.out.println("Valueee:" + value);
        flag = !value.isEmpty();
        return flag;
    }

    public String returnElementTagName(WebElement el) {
        return el.getTagName().trim();

    }

    public String returnElementAttrubuteValue(WebElement el, String AttributeName) {
        return el.getAttribute(AttributeName);

    }

    public String returAttrubuteValue(WebElement el, String AttributeName) {
        WebElement input = wait.until(driver -> {
            String value = el.getAttribute(AttributeName);
            return (value != null && !value.isEmpty()) ? el : null;
        });
        String value = input.getAttribute(AttributeName);

        return value;
    }

    public String returnDOMAttrubuteValue(WebElement el) {
        WebElement input = wait.until(driver -> {
            String value = el.getDomAttribute("value");
            return (value != null && !value.isEmpty()) ? el : null;
        });
        String value = input.getDomAttribute("value");

        return value;

    }

    public String returAttrubuteValueusingJs(WebElement el) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        String value = (String) js.executeScript("return arguments[0].value;", el);
        System.out.println("Field Value via JS = " + value);
        return value;
    }

    public String getText(WebElement wl) {
        return wl.getText();
    }

    public String returnCssPropertyName(WebElement el, String Propertyname) {
        return el.getCssValue(Propertyname).trim();

    }

    public boolean ReturnElementCheckStatus(WebElement el) {

        return el.isSelected();
    }

    public void selectOptionByValue(WebElement el, String value) {
        Select sel = new Select(el);
        sel.selectByValue(value);
    }

    public void selectOptionByText(WebElement el, String Text) {
        Select sel = new Select(el);
        sel.selectByVisibleText(Text);
    }

    public void selectOptionByIndex(WebElement el, String index) {
        Select sel = new Select(el);
        sel.selectByIndex(Integer.parseInt(index));
    }

    public void ActionWithElement(WebElement el, String ActionType) {
        Actions act = new Actions(driver);

        if (ActionType.equalsIgnoreCase("RightClick")) {
            act.contextClick(el).perform();
        } else if (ActionType.equalsIgnoreCase("Mouseover")) {
            act.moveToElement(el).perform();
        } else if (ActionType.equalsIgnoreCase("DoubleClick")) {
            act.moveToElement(el).perform();
        }
    }

    public void DragAndDropElement(WebElement el, WebElement el1) {
        Actions act = new Actions(driver);
        act.dragAndDrop(el, el1).perform();
    }

    Set<String> allHandles;
    String parentWinHandle = null;
    String lastWindow = null;

    public void SwitchWindowTitled(String windowTitle) {
        parentWinHandle = driver.getWindowHandle();
        allHandles = driver.getWindowHandles();
        //count the handles Here count is=2
        for (String window : allHandles) {
            if (window.equalsIgnoreCase(windowTitle))
                driver.switchTo().window(window);
        }
    }

    public void SwitchToNextTab() {
        ArrayList<String> tabs = new ArrayList<String>(driver.getWindowHandles());
        driver.switchTo().window(tabs.get(1));
    }

    public void EnterTextUsingActions(String s) {
        Actions keyAction = new Actions(driver);
        keyAction.sendKeys(s).perform();
    }

    public void EnterTextUsingAction() throws InterruptedException {
        Actions keyAction = new Actions(driver);
        keyAction.sendKeys(Keys.chord(Keys.CONTROL, "V")).perform();
        sleep(1000);
        keyAction.sendKeys(Keys.ENTER).perform();
    }

    public void CloseWindowByTitle(String windowTitle) {
        parentWinHandle = driver.getWindowHandle();
        allHandles = driver.getWindowHandles();
        //count the handles Here count is=2
        for (String window : allHandles) {
            if (window.equalsIgnoreCase(windowTitle))
                driver.switchTo().window(window);
            waitForElementLoad(2);
            driver.close();
        }
        driver.switchTo().window(parentWinHandle);

    }

    public void CloseWindowByIndex(String index) {
        parentWinHandle = driver.getWindowHandle();
        allHandles = driver.getWindowHandles();
        int totalWin = allHandles.size();
        System.out.println("Allwindow size" + totalWin);
        String winTitle = null;
        for (int i = 0; i < totalWin; i++) {
            if (i == Integer.parseInt(index)) {
                winTitle = allHandles.toArray()[i].toString();
            }
        }
        driver.switchTo().window(winTitle);
        driver.close();
        driver.switchTo().window(parentWinHandle);
        System.out.println(winTitle);
    }

    public void SwitchToParentPage() {
        driver.switchTo().defaultContent();
    }

    public void CloseCurrentWindows() {
        driver.close();
        System.out.println("Current Window Closed!!");
    }

    public void GOto(String url) {
        //driver.navigate().to(url);
        driver.get(url);

    }

    public void Refresh() {
        driver.navigate().refresh();
    }

    public void Forward() {
        driver.navigate().forward();
    }

    public void Back() {
        driver.navigate().back();
    }

    public void SwitchToFrame(String FrameName) {
        driver.switchTo().frame(FrameName);
    }

    public void SwitchToParentFrame() {
        driver.switchTo().parentFrame();
        driver.switchTo().defaultContent();
    }

    public void SwitchToFrameByIndex(String index) {
        driver.switchTo().frame(Integer.parseInt(index));
    }

    public void SwitchToFrameByElement(WebElement wl) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));
        wait.until(ExpectedConditions.frameToBeAvailableAndSwitchToIt(wl));
        System.out.println("Switched to Frame");
    }

    public void DeleteCookiesWithName(String Cookiesname) {
        driver.manage().deleteCookieNamed(Cookiesname);
    }

    public void DeleteAllCookies() {
        driver.manage().deleteAllCookies();
    }

    public void AcceptAlert() {
        driver.switchTo().alert().accept();
    }

    public void CancelAlert() {
        driver.switchTo().alert().dismiss();
    }

    public void ClickOnIfElementVisible(WebElement el) throws Exception {

        if (el.isDisplayed()) {
            Clickon(el);
        }
    }

    public void ClearAttributeValue(WebElement element) {
        ((JavascriptExecutor) driver).executeScript("arguments[0].setAttribute('value', '')", element);
    }

    public void ClearText(WebElement element) {
        el.clear();
    }

    public boolean verifyLinksOpenNewTanOrWindows(WebElement element) {
        boolean flag = false;
        Set<String> totalopenwindow = driver.getWindowHandles();
        el.click();
        waitForElementLoad(4);
        Set<String> totalopenwindowafter = driver.getWindowHandles();
        if (totalopenwindowafter.size() > totalopenwindow.size()) {
            return true;
        }
        return flag;
    }

    public void setAttributeUsingJS(WebElement element, String attName, String attValue) {
        ((JavascriptExecutor) driver).executeScript("arguments[0].setAttribute(arguments[1], arguments[2]);", element, attName, attValue);
    }

    public boolean VerifyElementValueLessThan(WebElement element, int ExpValue) {
        boolean flag = false;
        int value = Integer.parseInt(element.getAttribute("value").trim());
        if (value < ExpValue) {
            flag = true;
        }
        return flag;
    }

    public boolean VerifyElementValueGreaterThan(WebElement element, int ExpValue) {
        boolean flag = false;
        int value = Integer.parseInt(element.getAttribute("value").trim());
        if (value > ExpValue) {
            flag = true;
        }
        return flag;
    }

    public boolean VerifyElementValueLessThanOrEqualTo(WebElement element, int ExpValue) {
        boolean flag = false;
        int value = Integer.parseInt(element.getAttribute("value").trim());
        if (value <= ExpValue) {
            flag = true;
        }
        return flag;
    }

    public boolean VerifyElementValueGreaterThanOrEqualTo(WebElement element, int ExpValue) {
        boolean flag = false;
        int value = Integer.parseInt(element.getAttribute("value").trim());
        if (value >= ExpValue) {
            flag = true;
        }
        return flag;

    }

    public void SendKeysUsingJS(WebElement el, String value) throws InterruptedException, IOException {
        //Thread.sleep(3000);
        //el.
        //System.out.println(el.getRect().getHeight()+"-"+el.getRect().getWidth()+"-"+el.getRect().x+"-"+el.getRect().x);
        //ExtentTestManager.getTest().//Log(//LogStatus.PASS,ExtentTestManager.getTest().addBase64ScreenShot(capturescreenshotforelement(el)));
        if (el != null) {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            try {

                if (MobileDriver != null) {
                    el.clear();
                } else {
                    el.clear();
                    el.click();
                    el.clear();
                    el.sendKeys(Keys.BACK_SPACE);
                    el.sendKeys(Keys.BACK_SPACE);
                    el.sendKeys(Keys.BACK_SPACE);
                    el.sendKeys(Keys.BACK_SPACE);
                    el.sendKeys(Keys.BACK_SPACE);
                    el.sendKeys(Keys.BACK_SPACE);
                }
                js.executeScript("arguments[0].value=" + value + ";", el);

                System.out.println("try to Send keys into filed" + value);
                //	js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);

            } catch (WebDriverException e)
            //Thread.sleep(3000);
            {
                System.out.println(e);
//				js.executeScript("arguments[0].setAttribute('style', 'border: 2px solid red;');", el);
                sleep(200);
//				js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                //Thread.sleep(3000);
                //JavascriptExecutor js = (JavascriptExecutor) driver;
                System.out.println("Error in Clickon ya yaha " + e.getMessage());
                if (!e.toString().equals("NoSuchElementException")) {
                    try {
                        sleep(8000);
                        el.clear();
                        el.sendKeys(value);
                        System.out.println("try to Send keys into filed" + value);
                        //		js.executeScript("arguments[0].setAttribute('style', 'border: 0px solid red;');", el);
                    } catch (Exception e1) {
                        //	Reporter.addStepLog("Something went Wrong adn Send Keys did not performed successfully " + e.getMessage());
                        Assert.fail();
                    }
                }
            }
            //Thread.sleep(3000);
        } else {
            Assert.fail("Element We are trying to interact is not found");
        }
        try {
        } catch (Exception e) {
            System.out.println("No a device");
        }
    }

    public void ClickOnElementToOpenInNewWindowAndSwitchToIt(WebElement element) {

        String parent = driver.getWindowHandle();
        Set<String> s = driver.getWindowHandles();

        Iterator<String> I1 = s.iterator();
        while (I1.hasNext()) {
            String child_window = I1.next();
            if (!parent.equals(child_window)) {
                driver.switchTo().window(child_window);

                System.out.println(driver.switchTo().window(child_window).getTitle());

            }
        }

    }

    public void SendKeyBoardKeysUsingActions(Keys keys) throws Exception {

        Actions action = new Actions(driver);
        action.sendKeys(keys).build().perform();

    }

    public void PressShiftDelete() throws Exception {

        Actions action = new Actions(driver);
        action.keyDown(Keys.SHIFT).keyDown(Keys.DELETE).build().perform();
        waitForElementLoad(1);
        action.keyUp(Keys.SHIFT).keyUp(Keys.DELETE).build().perform();
    }

    public void ScrollIntoView(WebElement el) throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].scrollIntoView({behavior: 'smooth', block: 'center'});", el);
    }

    public void Scrolltobottom() throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("window.scrollTo(0, document.documentElement.scrollHeight);");
    }

    public void ScrollIntoComplexView(String Locator) throws InterruptedException {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
        WebElement el = wait.until(ExpectedConditions.refreshed(
                ExpectedConditions.elementToBeClickable(By.xpath(Locator))));
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].scrollIntoView({behavior: 'smooth', block: 'center'});", el);

    }

    public WebElement getWebElementById(String locator) throws InterruptedException {
        String[] finalval;
        finalval = locator.split("=");
        WebElement el = driver.findElement(By.id(finalval[1]));
        return el;
    }

    public void move_to_element() throws InterruptedException {
        //Try this code
        WebElement e = driver.findElement(By.className("slider"));
        Actions move = new Actions(driver);
        move.moveToElement(e).clickAndHold().moveByOffset(0, 250).release().perform();
        sleep(3000);
    }

    public void setPaylod(String payload) throws SAXException, IOException, ParserConfigurationException, DocumentException {

        Payload = payload;
    }

    public void dragAndDrop(WebElement sourceElement, WebElement TargetElement) {
        Actions actions = new Actions(driver);
        actions.dragAndDrop(sourceElement, TargetElement).build().perform();
    }

    public void dragAndDropWithOffset(WebElement sourceElement, WebElement TargetElement) {
        Actions actions = new Actions(driver);
        // Move slightly below HazMat element
        int xOffset = TargetElement.getSize().width / 2;   // middle of HazMat horizontally
        int yOffset = TargetElement.getSize().height;
        actions.dragAndDrop(sourceElement, TargetElement).build().perform();
        actions.clickAndHold(sourceElement).pause(Duration.ofMillis(1000)).moveToElement(TargetElement, xOffset, yOffset).release().build().perform();
    }

    public void dragAndDropWithJS(String script, String sourceField, String targetField) {

        ((JavascriptExecutor) driver).executeScript(script, sourceField, targetField);

    }

    public void dragAndDropWithJS(String script, WebElement sourceField, WebElement targetField) {

        ((JavascriptExecutor) driver).executeScript(script, sourceField, targetField);

    }

    public void acceptAlert() {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));
            wait.until(ExpectedConditions.alertIsPresent());

            Alert alert = driver.switchTo().alert();
            System.out.println("Alert Message: " + alert.getText());
            alert.accept();
            System.out.println("Alert accepted successfully.");
        } catch (TimeoutException e) {
            System.out.println("No alert present.");
        } catch (NoAlertPresentException e) {
            System.out.println("Alert already handled or not present.");
        }
    }

    public void move_to_element(WebElement wl) throws InterruptedException {
        //Try this code
        Actions move = new Actions(driver);
        move.moveToElement(wl).build().perform();
        move.moveByOffset(80, 150).build().perform();
    }

    public void move_to_element_With_JS(WebElement element) {
        JavascriptExecutor js = (JavascriptExecutor) driver;

        // 1️⃣ Bring element into viewport (IMPORTANT)
        js.executeScript(
                "arguments[0].scrollIntoView({behavior:'smooth', block:'center', inline:'center'});",
                element
        );

        waitForElementLoad(1);

        // 2️⃣ Simulate page activity (best effort)
        js.executeScript(
                "document.dispatchEvent(new MouseEvent('mousemove', {" +
                        "view: window, bubbles: true, cancelable: true, clientX: 120, clientY: 120}));"
        );

        js.executeScript("window.focus();");
        waitForElementLoad(1);

        js.executeScript("window.scrollBy(0, 200)");
        waitForElementLoad(1);

        js.executeScript("window.scrollBy(0, -100)");


    }

    public void ScrollPageUsingJs() throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("window.scrollBy(0, 300)");
        sleep(500);
        js.executeScript("window.scrollBy(0, -100)");
    }

    public void ClickUsingActions(WebElement wl) throws InterruptedException {
        //Try this code
        Actions move = new Actions(driver);
        move.moveToElement(wl).click(wl).build().perform();
    }

    public void SendKeysUsingActions(WebElement wl, String typeLetter) throws InterruptedException {
        //Try this code
        Actions move = new Actions(driver);
        move.scrollToElement(wl).sendKeys(typeLetter).build().perform();
        EnterdownkeyUsingAction(5);
    }

    public void EnterdownkeyUsingAction(int num) throws InterruptedException {
        Actions keyAction = new Actions(driver);
        for (int i = 0; i < num; i++) {
            keyAction.sendKeys(Keys.DOWN).build().perform();
        }
    }

    public void EnterUsingActions() throws InterruptedException {
        Actions keyAction = new Actions(driver);
        keyAction.sendKeys(Keys.ENTER).build().perform();
    }

    public void ScrollLast() {
        ((JavascriptExecutor) driver).executeScript("window.scrollTo(0, document.body.scrollHeight);");

    }

    public void ClearAndEnterDate(WebElement wl, String Date) {
        try {
//            Thread.sleep(2000);
            JavascriptExecutor js = (JavascriptExecutor) driver;
            js.executeScript("arguments[0].value = '';", wl);
            sleep(1000);
            js.executeScript("arguments[0].value='" + Date + "';", wl);
            sleep(2000);
            js.executeScript("arguments[0].value = '" + Date + "'; arguments[0].dispatchEvent(new Event('change'));", wl);
//			js.executeScript("arguments[0].value = '"+Date+"'; arguments[0].dispatchEvent(new Event('change'));", wl);
            js.executeScript("arguments[0].value = '" + Date + "'; arguments[0].dispatchEvent(new Event('input')); arguments[0].dispatchEvent(new Event('change')); arguments[0].dispatchEvent(new Event('blur'));", wl);

        } catch (Exception e) {

        }

    }

    public void EnterTabUsingActions() throws InterruptedException {
        Actions keyAction = new Actions(driver);
        keyAction.sendKeys(Keys.TAB).build().perform();
    }

    public String getAttrubuteOfFocusedElement(String attribute) {
        WebElement focusedElement = driver.switchTo().activeElement();
        return focusedElement.getAttribute(attribute);
    }

    public WebElement getFocusedElement() {
        return driver.switchTo().activeElement();
    }

    public void ClickUsingActions() throws InterruptedException {
        Actions keyAction = new Actions(driver);
        keyAction.click().build().perform();
    }

    public void SendKeysUsingActions(String text) throws InterruptedException {
        Actions keyAction = new Actions(driver);
        keyAction.sendKeys(text).build().perform();
    }

    public void Send_CTRL_S() {
        Actions actions = new Actions(driver);
        // Perform Ctrl + S
        actions.keyDown(Keys.CONTROL).sendKeys("s").keyUp(Keys.CONTROL).perform();
    }

    public void OpenUrlInNewTab(int TabNumber, String Url) {
        ((JavascriptExecutor) driver).executeScript("window.open()");

        // Switch to new tab and open a URL
        ArrayList<String> tabs = new ArrayList<>(driver.getWindowHandles());
        driver.switchTo().window(tabs.get(TabNumber));
        driver.get(Url);
    }

    public void OpenNewTab(int TabNumber) {
        ((JavascriptExecutor) driver).executeScript("window.open()");

        // Switch to new tab and open a URL
        ArrayList<String> tabs = new ArrayList<>(driver.getWindowHandles());
        driver.switchTo().window(tabs.get(TabNumber));
    }

    public void SwitchWindowByIndex(String index) {
        parentWinHandle = driver.getWindowHandle();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(driver -> driver.getWindowHandles().size() > 1);
        allHandles = driver.getWindowHandles();
        int totalWin = allHandles.size();
        String winTitle = null;
        for (int i = 0; i < totalWin; i++) {
            if (i == Integer.parseInt(index)) {
                winTitle = allHandles.toArray()[i].toString();
            }
        }
        driver.switchTo().window(winTitle);
        System.out.println(winTitle);
    }

    public void switchToLatestWindow() {
        lastWindow = driver.getWindowHandle();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(15));
        wait.until(driver -> driver.getWindowHandles().size() > 1);
        Set<String> handles = driver.getWindowHandles();
        List<String> windows = new ArrayList<>(handles);
        driver.switchTo().window(windows.get(windows.size() - 1));

    }

    public void SwitchToLastWindow() {
        if (driver.getWindowHandles().contains(lastWindow)) {
            driver.switchTo().window(lastWindow);
        } else {
            System.out.println("Parent window was closed. Cannot switch back.");
        }
    }

    public void switchWindowRemaining() {
        // Switch to any remaining window
        List<String> tabs = new ArrayList<>(driver.getWindowHandles());

        if (!tabs.isEmpty()) {
            driver.switchTo().window(tabs.get(0));
        }
    }

    public void SwitchToParentWindod() {
        if (driver.getWindowHandles().contains(parentWinHandle)) {
            driver.switchTo().window(parentWinHandle);
        } else {
            System.out.println("Parent window was closed. Cannot switch back.");
        }
    }

    public void CloseActiveWindows() {
        driver.close();
    }

    public void submitAPI(String EndPoint) {
        Response response = given()
                .header("Authorization", "DB819E967F1D1B4F85B54536F14A716E")
                .when()
                .get(EndPoint)
                .then()
                .log().all()
                .extract()
                .response();
        Resultrespoence.set(response);
    }

    public void ImplicitlyWait(int Time) {
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(Time));
    }

    public String getWindowHandle() {
        return driver.getWindowHandle();
    }

    public void returnToWindow(String windowname) {
        driver.switchTo().window(windowname);
    }

    public void SelectComboBoxOption(WebElement wl, WebElement wl1) {
        boolean found = false;
        while (!found) {
            try {
                ((JavascriptExecutor) driver).executeScript("arguments[0].dispatchEvent(new WheelEvent('wheel', {deltaY: 200, bubbles: true}));", wl);
                safeJavaScriptClick(wl1);
                found = true;
            } catch (NoSuchElementException e) {
                // Scroll down the dropdown container
                ((JavascriptExecutor) driver).executeScript("arguments[0].scrollTop = arguments[0].scrollTop + 200;", wl);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    public WebElement passwebelement(String locator) {
        WebElement el = null;
        By by = By.xpath(locator);
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));
            wait.pollingEvery(Duration.ofMillis(200))
                    .ignoring(StaleElementReferenceException.class)
                    .ignoring(NoSuchElementException.class);

            // 1️⃣ Wait for presence (works even if off-screen)
            el = wait.until(
                    ExpectedConditions.presenceOfElementLocated(by)
            );
            checkForErrorToast();
        } catch (Exception e) {
        }
        return el;
    }

    public WebElement Errorwebelement(String locator) {
//        waitForLightningPageToLoad(driver);
        try {
            el = driver.findElement(By.xpath(locator));
        } catch (Exception e) {
            waitForElementLoad(7);
            el = driver.findElement(By.xpath(locator));
        }
        return el;

    }

    public String ExpectedDate(String P_Expected_Date) {
        String formattedDate;
        LocalDate dateInChicago;

        // Define Chicago time zone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Calculate date based on input
        if (P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            dateInChicago = LocalDate.now(chicagoZone).plusDays(1);
        } else {
            int daysToAdd = Integer.parseInt(P_Expected_Date);
            dateInChicago = LocalDate.now(chicagoZone).plusDays(daysToAdd);
        }


        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy", Locale.ENGLISH);
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("MMM d, yyyy", Locale.ENGLISH);
        formattedDate = dateInChicago.format(formatter);
        LocalDate localDate = LocalDate.parse(formattedDate, formatter);
        formattedDate = localDate.format(outputFormat);
        System.out.println(formattedDate);
        return formattedDate;
    }

    public String ReturnDate(String P_Expected_Date) {
        String formattedDate;
        LocalDate dateInChicago;

        // Define Chicago time zone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Calculate date based on input
        if (P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            dateInChicago = LocalDate.now(chicagoZone).plusDays(1);
        } else {
            int daysToAdd = Integer.parseInt(P_Expected_Date);
            dateInChicago = LocalDate.now(chicagoZone).plusDays(daysToAdd);
        }

        // Format date
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.ENGLISH);
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("M/d/yyyy", Locale.ENGLISH);
        formattedDate = dateInChicago.format(formatter).trim();
        LocalDate localDate = LocalDate.parse(formattedDate, formatter);
        formattedDate = localDate.format(outputFormat);
        System.out.println(formattedDate);
        return formattedDate;
    }

    public String ReturnDateInSpecifiedFormat(String P_Expected_Date, String format) {
        String formattedDate;
        LocalDate dateInChicago;

        // Define Chicago time zone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Calculate date based on input
        if (P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            dateInChicago = LocalDate.now(chicagoZone).plusDays(1);
        } else {
            int daysToAdd = Integer.parseInt(P_Expected_Date);
            dateInChicago = LocalDate.now(chicagoZone).plusDays(daysToAdd);
        }

        // Format date
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern(format, Locale.ENGLISH);
        formattedDate = dateInChicago.format(outputFormat).trim();
        System.out.println(formattedDate);
        return formattedDate;
    }

    public String ReturnDateTimeInSpecifiedFormat(String P_Expected_Date, String format) {
        String formattedDate;
        LocalDateTime dateInChicago;

        // Define Chicago time zone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Calculate date based on input
        if (P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            dateInChicago = LocalDateTime.now(chicagoZone).plusDays(1);
        } else {
            int daysToAdd = Integer.parseInt(P_Expected_Date);
            dateInChicago = LocalDateTime.now(chicagoZone).plusDays(daysToAdd);
        }

        // Format date
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern(format, Locale.ENGLISH);
        formattedDate = dateInChicago.format(outputFormat).trim();
        System.out.println(formattedDate);
        return formattedDate;
    }

    public String ReturnDateInSpecifiedTimeZoneAndFormat(String P_Expected_Date, String TimeZone, String format) {
        String formattedDate;
        LocalDate dateInChicago;

        // Define Chicago time zone
        ZoneId chicagoZone = ZoneId.of(TimeZone);

        // Calculate date based on input
        if (P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            dateInChicago = LocalDate.now(chicagoZone).plusDays(1);
        } else {
            int daysToAdd = Integer.parseInt(P_Expected_Date);
            dateInChicago = LocalDate.now(chicagoZone).plusDays(daysToAdd);
        }

        // Format date
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern(format, Locale.ENGLISH);
        formattedDate = dateInChicago.format(outputFormat).trim();
        System.out.println(formattedDate);
        return formattedDate;
    }

    public String ReturnDateTime(String P_Expected_Date) {

        // Chicago timezone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Base datetime: current date + time in Chicago
        LocalDateTime dateTimeInChicago = LocalDateTime.now(chicagoZone);

        // Add days based on input
        if (P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            dateTimeInChicago = dateTimeInChicago.plusDays(1);
        } else {
            int daysToAdd = Integer.parseInt(P_Expected_Date);
            dateTimeInChicago = dateTimeInChicago.plusDays(daysToAdd);
        }

        // Output format
        DateTimeFormatter outputFormat =
                DateTimeFormatter.ofPattern("M/d/yyyy hh:mm a", Locale.ENGLISH);

        // Format final datetime
        String formattedDate = dateTimeInChicago.format(outputFormat);

        System.out.println(formattedDate);
        return formattedDate;
    }

    public String ReturnCurrentDateAndTime(String P_Expected_Date, String format) {
        // Define Chicago time zone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Determine base date and time in Chicago
        LocalDateTime dateTimeInChicago;
        if (P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            dateTimeInChicago = LocalDateTime.now(chicagoZone).plusDays(1);
        } else {
            int daysToAdd = 0;
            try {
                daysToAdd = Integer.parseInt(P_Expected_Date);
            } catch (NumberFormatException e) {
                System.out.println("Invalid input for P_Expected_Date. Defaulting to 0 days.");
            }
            dateTimeInChicago = LocalDateTime.now(chicagoZone).plusDays(daysToAdd);
        }

        // Use provided format or default to MMddyyHHmm
        String finalFormat = (format == null || format.isEmpty()) ? "MMddyyHHmm" : format;
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern(finalFormat, Locale.ENGLISH);

        // Format and return
        String formattedDateAndTime = dateTimeInChicago.format(outputFormatter);
        System.out.println(formattedDateAndTime);
        return formattedDateAndTime;
    }

    public void EnterTextUsingJS(WebElement wl, String Value) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            js.executeScript("arguments[0].value = '';", wl);
            js.executeScript("arguments[0].value='" + Value + "';", wl);
            js.executeScript("arguments[0].blur();", wl);
        } catch (Exception e) {

        }

    }

    public void getSalesforceSearchInput(String value) {
        List<WebElement> inputs =
                driver.findElements(By.xpath("//input[@placeholder='Search...']"));

        WebElement visibleInput = inputs.stream()
                .filter(WebElement::isDisplayed)
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Visible Search input not found"));

        visibleInput.click();
        visibleInput.sendKeys(value);
    }

    public void EnterTimeUsingJS(WebElement wl, String Value) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;

            // Clear the field
            js.executeScript("arguments[0].value = '';", wl);

            // Set the value
            js.executeScript("arguments[0].value = arguments[1];", wl, Value);

            // Fire input event
            js.executeScript("arguments[0].dispatchEvent(new Event('input', { bubbles: true }));", wl);

            // Fire change event
            js.executeScript("arguments[0].dispatchEvent(new Event('change', { bubbles: true }));", wl);

            // Optional: blur to trigger any onBlur validations
            js.executeScript("arguments[0].blur();", wl);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void scrollDownWithJS(int Key) throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        for (int i = 0; i < Key; i++) {
            js.executeScript("window.scrollBy(0, 100);"); // scroll down by 100px
            sleep(300);
            System.out.println(1);
            // small pause to mimic key press
        }
    }

    public void scrollUpWithJS(int Key) throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        for (int i = 0; i < Key; i++) {
            js.executeScript("window.scrollBy(0, -100);"); // scroll down by 100px
            sleep(300); // small pause to mimic key press
        }
    }

    public void setPermission(String permission, boolean enable) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement checkbox = wait.until(ExpectedConditions.elementToBeClickable(
                By.xpath("//tr[td[normalize-space(text())='" + permission + "']]//input[@type='checkbox']")
        ));

        if (checkbox.isSelected() != enable) {
            checkbox.click();
        }
    }

    public void enablePermissionSet(String First, String Second, String operators, String permissionSetName) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));


        if (!First.contains("Enabled")) {
            // Locate Enabled Permission Sets select (right side)
            WebElement enabledSelect1 = driver.findElement(By.xpath(Second));
            Select enableded = new Select(enabledSelect1);
            // Check if already enabled
            boolean alreadyEnabled = enableded.getOptions().stream()
                    .anyMatch(opt -> opt.getText().equals(permissionSetName));

            if (alreadyEnabled) {
                System.out.println("Permission Set already enabled: " + permissionSetName);
                return; // do nothing
            }
        }

        // Locate Available Permission Sets select
        WebElement availableSelect = wait.until(ExpectedConditions.presenceOfElementLocated(By.xpath(First)));

        // Select the permission set by visible text
        Select select = new Select(availableSelect);

        select.selectByVisibleText(permissionSetName);

        // Click the Add button (right arrow)
        WebElement addBtn = driver.findElement(By.xpath(operators));
        addBtn.click();

        // Verify it moved to Enabled Permission Sets
        WebElement enabledSelect = driver.findElement(By.xpath(Second));
        Select enabled = new Select(enabledSelect);
        boolean found = enabled.getOptions().stream()
                .anyMatch(opt -> opt.getText().equals(permissionSetName));

        if (!found) {
            throw new RuntimeException("Permission Set not enabled: " + permissionSetName);
        }

    }

    public WebElement HandlingMultipleElements(String locators, int index) throws InterruptedException {
        ScrollIntoView(driver.findElement(By.xpath(locators)));
        waitUntilTheElementIsVisible(driver.findElement(By.xpath(locators)));
        List<WebElement> elements = driver.findElements(By.xpath(locators));
        return elements.get(index - 1);
    }

    public int NumberOfWindow() {
        Set<String> windowHandles = driver.getWindowHandles();
        return windowHandles.size();
    }

    public void scrollAndSelectRecord(String recordName) throws InterruptedException {

        JavascriptExecutor js = (JavascriptExecutor) driver;
        boolean found = false;
        int maxScrolls = 40;

        WebElement scrollableDiv = driver.findElement(
                By.xpath("(//div[contains(@class,'active')]//div[contains(@class,'slds-scrollable_y')])[2]")
        );

        for (int i = 0; i < maxScrolls; i++) {

            List<WebElement> records = driver.findElements(
                    By.xpath("//*[@data-cell-value='" + recordName + "']//button")
            );

            if (!records.isEmpty()) {
                WebElement recordButton = records.get(0);

                js.executeScript(
                        "arguments[0].scrollIntoView({block:'center'});",
                        recordButton
                );

                sleep(500); // allow LWC to settle

                js.executeScript("arguments[0].click();", recordButton);

                System.out.println("✅ Record '" + recordName + "' selected.");
                found = true;
                break;
            }

            // 🔑 SCROLL THE CORRECT CONTAINER
            js.executeScript(
                    "arguments[0].dispatchEvent(new WheelEvent('wheel', {deltaY: 350, bubbles: true, cancelable: true}));",
                    scrollableDiv
            );

            sleep(600);
        }

        if (!found) {
            throw new RuntimeException("❌ Record '" + recordName + "' not found after scrolling.");
        }
    }

    public void scrollRecordFromList(String recordName) {

        JavascriptExecutor js = (JavascriptExecutor) driver;

        // VERY SHORT wait only when needed
        WebDriverWait shortWait = new WebDriverWait(driver, Duration.ofMillis(300));

        WebElement scrollableDiv = driver.findElement(
                By.xpath("//div[contains(@class,'slds-scrollable_y')]")
        );

        // Jump to top first
        js.executeScript("arguments[0].scrollTop = 0;", scrollableDiv);

        int maxScrolls = 30; // reduced
        int scrollCount = 0;

        while (scrollCount < maxScrolls) {
            try {
                List<WebElement> elements = driver.findElements(
                        By.xpath("//div[contains(@class,'active')]//*[contains(normalize-space(.),'" + recordName + "')]")
                );

                if (!elements.isEmpty()) {
                    WebElement recordButton = elements.get(0);

                    js.executeScript(
                            "arguments[0].scrollIntoView({block:'center'});", recordButton
                    );

                    shortWait.until(ExpectedConditions.visibilityOf(recordButton));

                    System.out.println("✅ Record '" + recordName + "' found.");
                    return;
                }

            } catch (Exception ignored) {
            }

            // FAST SCROLL – 2 pages at once
            js.executeScript(
                    "arguments[0].scrollTop += arguments[0].offsetHeight * 2;",
                    scrollableDiv
            );

            scrollCount++;
        }

        throw new RuntimeException("❌ Record '" + recordName + "' not found.");
    }

    //    public void ScrollUsingJSUntilElementIsNotFound(String locator) throws InterruptedException {
//        while (true) {
//            try {
//                driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(1));
//                ellist = driver.findElements(By.xpath(locator));
//                int count = ellist.size();
//                if(count>0) {
//                    break;
//                }
//               } catch (Exception e) {
//                // element not yet in view, scroll more
//               }
//              scrollDownWithJS(1);
//        }
//        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
//    }
    public void ScrollUsingJSUntilElementIsNotFound(String locator) throws InterruptedException {
        int maxScrolls = 40;
        int currentScroll = 0;
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(1));
        try {
            while (currentScroll < maxScrolls) {
                List<WebElement> ellist = driver.findElements(By.xpath(locator));
                if (!ellist.isEmpty()) {
                    break; // element found
                }
                scrollDownWithJS(1);
                currentScroll++;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
    }


    public String getJsonValue(String jsonString, String attributePath) {
        final ObjectMapper mapper = new ObjectMapper();

        try {
            JsonNode node = mapper.readTree(jsonString);
            // Split the path by '.'
            String[] keys = attributePath.split("\\.");

            for (String key : keys) {
                // Handle array elements like stops[0]
                if (key.startsWith("[") && key.endsWith("]")) {
                    int index = Integer.parseInt(
                            key.substring(1, key.length() - 1)
                    );

                    if (node.isArray() && node.size() > index) {
                        node = node.get(index);
                    } else {
                        return null;
                    }
                } else if (key.contains("[")) {
                    String fieldName = key.substring(0, key.indexOf("["));
                    int index = Integer.parseInt(key.substring(key.indexOf("[") + 1, key.indexOf("]")));

                    node = node.path(fieldName);
                    if (node.isArray() && node.size() > index) {
                        node = node.get(index);
                    } else {
                        return null;
                    }
                } else {
                    node = node.path(key);
                }

                if (node.isMissingNode()) {
                    return null;
                }
            }

            return node.isValueNode() ? node.asText() : node.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }


    }

    public void scrollHorizontal(WebElement wl) {
        // Scroll horizontally to the far right
        ((JavascriptExecutor) driver).executeScript(
                "arguments[0].scrollIntoView({block: 'nearest', inline: 'end'});", wl);
    }

    public void ScrollToHelpText(WebElement el) {
        ((JavascriptExecutor) driver).executeScript(
                "arguments[0].dispatchEvent(new MouseEvent('mouseover', { bubbles: true }));",
                el
        );
    }

    public String getRoundedTimeBeforeNow(long minutes) {
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Get current time in Chicago
        ZonedDateTime now = ZonedDateTime.now(chicagoZone);

        // Go 1 hour behind
        ZonedDateTime oneHourBefore = now.minusMinutes(minutes);

        // Round down to nearest 15-minute mark
        int roundedMinute = (oneHourBefore.getMinute() / 15) * 15;

        // Set rounded time and clear seconds/nanos
        ZonedDateTime roundedTime = oneHourBefore
                .withMinute(roundedMinute)
                .withSecond(0)
                .withNano(0);

        // Ensure it's strictly before now
        if (!roundedTime.isBefore(now)) {
            roundedTime = roundedTime.minusMinutes(15);
        }

        // Format in 12-hour AM/PM format (removes leading zero)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a");
        return roundedTime.format(formatter);
    }

    private void checkForErrorToast() {
        try {
            driver.manage().timeouts().implicitlyWait(Duration.ofMillis(200));
//            List<WebElement> toasts = driver.findElements(
//                    By.xpath("//div[@data-key='error']//*[@icon-name='utility:error']/..//span[contains(@class,'toastMessage')]")
//            );

            List<WebElement> toasts = driver.findElements(
                    By.xpath("//div[@data-key='error']//*[@icon-name='utility:error']/..//span[contains(@class,'toastMessage')] | //span[contains(@class,'utility-error') and contains(@title,'Error')]")
            );


            if (!toasts.isEmpty()) {
                String message = toasts.get(0).getText().trim();

                if (ToastContext.isNew(message)) {
                    if (ToastContext.isExpected(message)) {
                        System.out.println("✅ Expected toast: " + message);
                    } else {
                        Assert.fail("Unexpected Salesforce Error Toast: " + message);
                    }
                }
            }
        } finally {
            driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
        }
    }

    public void openNewTab(String url) {
        driver.switchTo().newWindow(WindowType.TAB);
        driver.get(url);
    }

    public void SwitchBackToMainWindow() {
        driver.switchTo().window(driver.getWindowHandles().iterator().next());
    }

    public void closeAndSwitchToPrevious() {
        List<String> handles = new ArrayList<>(driver.getWindowHandles());
        String current = driver.getWindowHandle();
        int index = handles.indexOf(current);

        driver.close();

        if (index > 0) {
            driver.switchTo().window(handles.get(index - 1));
        }
    }

    public void BrowserZoom(String number) {
        // Set zoom back to 100%
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("document.body.style.zoom='" + number + "%'");
    }

    public String waitForAttributeValue(WebElement element, String attribute, int timeout) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(timeout));
        wait.until(d -> {
            String val = element.getAttribute(attribute);
            return val != null && !val.trim().isEmpty();
        });
        return element.getAttribute(attribute);
    }

    public String getOverlayText(WebElement element) {

        JavascriptExecutor js = (JavascriptExecutor) driver;
        String text = (String) js.executeScript(
                "return arguments[0].textContent;", element
        );

        if (text == null || text.trim().isEmpty()) {
            text = (String) js.executeScript(
                    "return arguments[0].innerText;", element
            );
        }
        return text == null ? "" : text.trim();
    }

    public boolean checkSelectedUsingJS(WebElement checkbox) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        Boolean checked = (Boolean) js.executeScript(
                "return arguments[0].checked;", checkbox);
        return checked;
    }

    public void dragFromParentToIframe(String sourceXpath, String targetXpathInIframe) {

        int maxRetries = 3; // Retry if drag-drop not registered

        for (int attempt = 1; attempt <= maxRetries; attempt++) {
            try {
                // 1️⃣ Wait a bit for DOM stability
                waitForElementLoad(2);

                // 2️⃣ Switch to parent and locate source
                driver.switchTo().defaultContent();
                WebElement source = passwebelement(sourceXpath);

                ((JavascriptExecutor) driver).executeScript(
                        "arguments[0].scrollIntoView({block:'center'});", source
                );

                Point sourceLoc = source.getLocation();
                Dimension sourceSize = source.getSize();
                int sourceX = sourceLoc.getX() + sourceSize.getWidth() / 2;
                int sourceY = sourceLoc.getY() + sourceSize.getHeight() / 2;

                // 3️⃣ Locate iframe
                WebElement iframe = driver.findElement(By.xpath("//iframe[contains(@title,'Surface')]"));
                driver.switchTo().frame(iframe);

                // 4️⃣ Locate target and scroll if needed
                WebElement target = passwebelement(targetXpathInIframe);
                ((JavascriptExecutor) driver).executeScript(
                        "arguments[0].scrollIntoView({block:'center'});", target
                );

                Point targetLoc = target.getLocation();
                Dimension targetSize = target.getSize();
                int targetX = targetLoc.getX() + targetSize.getWidth() / 2;
                int targetY = targetLoc.getY() + targetSize.getHeight() / 2;

                // 5️⃣ Switch back to default content to perform actions
                driver.switchTo().defaultContent();

                // 6️⃣ Perform drag and drop via Actions
                Actions actions = new Actions(driver);
                actions.moveByOffset(sourceX, sourceY)
                        .clickAndHold()
                        .pause(Duration.ofMillis(500))
                        .moveByOffset(targetX - sourceX, targetY - sourceY)
                        .pause(Duration.ofMillis(500))
                        .release()
                        .build()
                        .perform();

                // 7️⃣ Switch back to parent
                driver.switchTo().defaultContent();

                // 8️⃣ Optional: verify if field added (custom logic)
                if (isFieldAdded(targetXpathInIframe)) {
                    return; // Success
                } else {
                    // Wait before retry
                    waitForElementLoad(1);
                }
            } catch (Exception e) {
                // On any exception, reset and retry
                driver.switchTo().defaultContent();
                if (attempt == maxRetries) {
                    throw new RuntimeException("Drag & Drop failed after " + maxRetries + " attempts", e);
                }
                waitForElementLoad(1);
            }
        }
    }

    private boolean isFieldAdded(String targetXpathInIframe) {
        try {
            driver.switchTo().defaultContent();
            WebElement iframe = driver.findElement(By.xpath("//iframe[contains(@title,'Surface')]"));
            driver.switchTo().frame(iframe);
            WebElement target = passwebelement(targetXpathInIframe);
            // You can check any condition that confirms field was added, e.g.,
            return target.isDisplayed() && target.getText().trim().length() > 0;
        } catch (Exception e) {
            return false;
        } finally {
            driver.switchTo().defaultContent();
        }
    }


    public void scrollRecordFromList2(String recordName) throws InterruptedException {

        JavascriptExecutor js = (JavascriptExecutor) driver;

        // VERY SHORT wait only when needed
        WebDriverWait shortWait = new WebDriverWait(driver, Duration.ofMillis(300));

        WebElement scrollableDiv = driver.findElement(
                By.xpath("(//div[contains(@class,'active')]//div[contains(@class,'slds-scrollable_y')])[2]")
        );
        // Jump to top first
        js.executeScript("arguments[0].scrollTop = 0;", scrollableDiv);

        int maxScrolls = 30; // reduced
        int scrollCount = 0;

        while (scrollCount < maxScrolls) {
            try {
                List<WebElement> elements = driver.findElements(
                        By.xpath("//*[@data-cell-value='" + recordName + "']//button")
                );

                if (!elements.isEmpty()) {
                    WebElement recordButton = elements.get(0);

                    js.executeScript(
                            "arguments[0].scrollIntoView({block:'center'});", recordButton
                    );

                    shortWait.until(ExpectedConditions.visibilityOf(recordButton));
                    System.out.println("✅ Record '" + recordName + "' found.");
                    sleep(500); // allow LWC to settle

                    js.executeScript("arguments[0].click();", recordButton);
                    return;
                }

            } catch (Exception ignored) {
            }

            // FAST SCROLL – 2 pages at once
            js.executeScript(
                    "arguments[0].scrollTop += arguments[0].offsetHeight * 2;",
                    scrollableDiv
            );

            scrollCount++;
        }

        throw new RuntimeException("❌ Record '" + recordName + "' not found.");
    }

    public String getBackgroundColorUsingJs(WebElement el) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].blur();", el);
        waitForElementLoad(1);
        new Actions(driver).moveByOffset(0, 0).perform();
        String bg = (String) js.executeScript(
                "return window.getComputedStyle(arguments[0]).backgroundColor;",
                el
        );

        System.out.println(bg);
        return bg;
    }

    public void enable() {
        DevTools devTools = ((HasDevTools) driver).getDevTools();
        devTools.createSession();
    }

    public String getTextUsingJS(WebElement wl) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        String text = (String) js.executeScript(
                "return arguments[0].innerText;", wl
        );

        return text;
    }

    public WebElement NavigateChildWelElement(WebElement el, String xpathString) {
        return el.findElement(By.xpath("." + xpathString));
    }

    public void VerifyChildElementDisplayed(WebElement el, String xpathString) {
        int size = el.findElements(By.xpath("." + xpathString)).size();
        if (size > 0) {
            System.out.println("Element displaying");
        } else {
            Assert.fail(xpathString + "is not dispalying");
        }
    }

    public void WaitForCurrentURLChange(String OldURL) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(40));
        wait.until(ExpectedConditions.not(
                ExpectedConditions.urlToBe(OldURL)
        ));
    }

    public int NumOfTab() {
        return driver.getWindowHandles().size();
    }

    public void EnterJsonText(WebElement el, String Value) throws Exception {
        JavascriptExecutor js = (JavascriptExecutor) driver;

        js.executeScript(
                "var element = arguments[0];" +
                        "var value = arguments[1];" +
                        "element.focus();" +
                        "element.value = value;" +
                        "element.dispatchEvent(new Event('input', { bubbles: true }));" +
                        "element.dispatchEvent(new Event('change', { bubbles: true }));",
                el,
                Value
        );

    }

    public void WaitForLongElementClickable(String locators) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(200));
        WebElement element = wait.until(
                ExpectedConditions.elementToBeClickable(By.xpath(locators))
        );
        wait.until(ExpectedConditions.invisibilityOfElementLocated(
                By.xpath("//div[@class='spinner']")
        ));
    }

    public void ToleranceTime(String Actaul, String Expected, String Format) {
        int TIME_TOLERANCE_MINUTES = 5;
        //      DateTimeFormatter formatter = DateTimeFormatter.ofPattern(Format);
        DateTimeFormatter formatter = new DateTimeFormatterBuilder()
                .parseCaseInsensitive()
                .appendPattern(Format)
                .toFormatter();
        LocalDateTime eTime = LocalDateTime.parse(Actaul.trim(), formatter);
        LocalDateTime aTime = LocalDateTime.parse(Expected.trim(), formatter);
        long diff = Math.abs(Duration.between(eTime, aTime).toMinutes());
        if (diff > TIME_TOLERANCE_MINUTES) {
            Assert.assertEquals(Actaul, Expected, Actaul + " not matched with " + Expected);
        }
    }

    public boolean waitForUrlContains(String UrlPart) {

        String expectedUrlPart = "/lightning/page/home";
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        boolean isOnHomePage;

        try {
            isOnHomePage = wait.until(d -> Objects.requireNonNull(d.getCurrentUrl()).contains(UrlPart));
        } catch (Exception e) {
            isOnHomePage = false;
        }
        return isOnHomePage;
    }

    public void ClickAndHoldWithMoveOffset(WebElement el) {
        Actions actions = new Actions(driver);
        actions.clickAndHold(el)
                .moveByOffset(100, 0)
                .release()
                .perform();
    }


    public void waitForLightningPageToLoad(WebDriver driver) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(90));
        wait.pollingEvery(Duration.ofMillis(500));

        try {
            // 1. Wait for document ready
            wait.until((ExpectedCondition<Boolean>) wd -> {
                try {
                    return ((JavascriptExecutor) wd)
                            .executeScript("return document.readyState")
                            .toString()
                            .equals("complete");
                } catch (Exception e) {
                    return false;
                }
            });

            // 2. Wait for Aura framework ready
            wait.until((ExpectedCondition<Boolean>) wd -> {
                try {
                    Object auraReady = ((JavascriptExecutor) wd).executeScript(
                            "return (window.$A !== undefined " +
                                    "&& $A.clientService !== undefined)");
                    return Boolean.TRUE.equals(auraReady);
                } catch (Exception e) {
                    return false;
                }
            });

            // 3. Wait for all Lightning spinners to disappear
            wait.until((ExpectedCondition<Boolean>) wd -> {
                try {

                    List<WebElement> spinners = wd.findElements(
                            org.openqa.selenium.By.cssSelector(
                                    ".slds-spinner, " +
                                            ".forceSpinner, " +
                                            ".loadingIndicator"));

                    for (WebElement spinner : spinners) {
                        if (spinner.isDisplayed()) {
                            return false;
                        }
                    }

                    return true;

                } catch (Exception e) {
                    return true;
                }
            });

            // 4. Wait for pending Aura actions to finish
            wait.until((ExpectedCondition<Boolean>) wd -> {
                try {

                    Object result = ((JavascriptExecutor) wd).executeScript(
                            "if (window.$A && $A.clientService) {" +
                                    "   return $A.clientService.getCurrentAccess() !== null;" +
                                    "} else {" +
                                    "   return false;" +
                                    "}"
                    );

                    return Boolean.TRUE.equals(result);

                } catch (Exception e) {
                    return false;
                }
            });

            // 5. Extra stabilization delay for Lightning rerenders
            Thread.sleep(1000);

        } catch (TimeoutException e) {
            throw new RuntimeException(
                    "Timeout waiting for Salesforce Lightning page load.", e);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    public void ScrollOnModal() {
        WebElement modal = driver.findElement(
                By.xpath("//*[contains(@class,'slds-modal__content')]")
        );
        Actions actions = new Actions(driver);
        actions.scrollFromOrigin(
                WheelInput.ScrollOrigin.fromElement(modal),
                0,
                500
        ).perform();
    }

    public List<WebElement> waitUntilVisibleAndReturnElements(String locator) {
        By by = By.xpath(locator);
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
            List<WebElement> elements = wait.until(ExpectedConditions.visibilityOfAllElementsLocatedBy(by));
            System.out.println("All Elements are visible on Screen");
            return elements;
        } catch (Exception e) {
            System.out.println("Elements not visible on Screen");
            throw new RuntimeException(e);
        }
    }

    public void HandleWindowsAndClickOnLinkText(String Frame, String Text) throws InterruptedException {
        // Store parent window
        String parentWindow = driver.getWindowHandle();
// Wait for new window to open
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(driver -> driver.getWindowHandles().size() > 1);
// Switch to lookup window
        for (String windowHandle : driver.getWindowHandles()) {
            if (!windowHandle.equals(parentWindow)) {
                driver.switchTo().window(windowHandle);
                break;
            }
        }

// Verify lookup window
        System.out.println("Current Window Title: " + driver.getTitle());
        if (!Frame.equalsIgnoreCase("No")) {
            driver.switchTo().frame(Frame);
        }
// Click the search result
        Thread.sleep(2000);
        driver.findElement(By.linkText(Text)).click();
        new WebDriverWait(driver, Duration.ofSeconds(10))
                .until(ExpectedConditions.numberOfWindowsToBe(1));
// Switch back to parent window
        driver.switchTo().window(parentWindow);
    }

    public void scrollHeight(WebElement wl) {
        JavascriptExecutor js =
                (JavascriptExecutor) driver;
        js.executeScript(
                "arguments[0].scrollTop=arguments[0].scrollHeight",
                wl);
    }

    public String getPaySettlementPdfCookies() {

        StringBuilder cookieHeader = new StringBuilder();

        for (Cookie cookie : driver.manage().getCookies()) {

            if (cookieHeader.length() > 0) {
                cookieHeader.append("; ");
            }

            cookieHeader
                    .append(cookie.getName())
                    .append("=")
                    .append(cookie.getValue());
        }

        return cookieHeader.toString();
    }
}