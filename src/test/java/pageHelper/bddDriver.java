package pageHelper;

import ReportManager.ExtentManager;
import ReportManager.ExtentTestManager;
import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.MediaEntityBuilder;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import core.*;
import io.cucumber.java.*;
import io.cucumber.java.en.Then;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.SAXReader;
import org.jsoup.Jsoup;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.devtools.DevTools;
import org.openqa.selenium.devtools.v131.page.Page;
import org.testng.Reporter;
import org.xml.sax.SAXException;
import pageHelper.Utility.Common_Steps;
import utils.Excel.ExcelUpdater;
import utils.OnePassword.OnePasswordUtil;
import utils.Org_Manager.OrgManager;
import utils.Org_Manager.TestContext;
import utils.PropReader;
import utils.PropertyReader;
import java.io.*;
import java.util.*;
import java.util.Optional;
import org.apache.log4j.xml.DOMConfigurator;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import utils.Retry.FailedScenarioWriter;
import utils.Retry.ScenarioContext;

import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

public class bddDriver
{
	public static int  itr;
	public static boolean  Accessibilityflag;
	PropertyReader pr=new PropertyReader();
	apiDriver ApiDriver = new baseDriver();
    private ExtentReports extent = ExtentManager.getExtent();

    public static ThreadLocal<String> TestName= new InheritableThreadLocal<>();
	public static final ThreadLocal<WebDriver> WEB_DRIVER_THREAD_LOCAL = new InheritableThreadLocal<>();
	public static final ThreadLocal<WebDriver> WEB_DRIVER_Test = new InheritableThreadLocal<>();
	public static final ThreadLocal<RequestSpecification> API_DRIVER_THREAD_LOCAL = new InheritableThreadLocal<>();
	public static final ThreadLocal<Response> API_RESPONCE_THREAD_LOCAL = new InheritableThreadLocal<>();
	public static ThreadLocal<String> LoadNum=new InheritableThreadLocal<>();
    private static final ThreadLocal<String> scenarioName = new ThreadLocal<>();



	public static ThreadLocal<Double> customerTotalPrice=new InheritableThreadLocal<>();

	public static ThreadLocal<List<apiModal.Order.Payment>> payment=new InheritableThreadLocal<>();
	public static ThreadLocal<List<apiModal.Order.OrderLineItem>> orderLineItem=new InheritableThreadLocal<>();
	public static ThreadLocal<HashMap<String, String>> Variables = new InheritableThreadLocal<>();
//	public static ThreadLocal<HashMap<String, String>> Variable = new InheritableThreadLocal<>();

	public static List<apiModal.Order.Payment> getPayment() {
		return payment.get();
	}
	public static void setPayment(List<apiModal.Order.Payment> classname) {
		payment.set(classname);
	}
	public static List<apiModal.Order.OrderLineItem> getOrderLineItem() {
		return orderLineItem.get();
	}
	public static void setOrderLineItem(List<apiModal.Order.OrderLineItem> classname) {
		orderLineItem.set(classname);
	}


	@Before(value = "@API",order=1)
	public void APIsetup(Scenario s){
		apiDriver ApiDriver=new baseDriver();
		API_DRIVER_THREAD_LOCAL.set(ApiDriver.apiinit(""));
		API_RESPONCE_THREAD_LOCAL.set(null);
		//Initiate values
		HashMap<String, String> Variables = new HashMap<>();
		Variables.put("Test", "123");
		setVariables(Variables);
	}

	@Before(value = "@WEB",order=1)
	public void Websetup(Scenario s) throws Exception {
        //Org Pool Initialization
        String org = OrgManager.acquireOrg();
        Properties properties = PropReader.load(org);
        PropReader.setConfig(properties);
        TestContext.setOrg(org);
        System.out.println(Thread.currentThread().getName() + " → Allocated: " + org);
		webDriver webDriver = new baseDriver();
        String app = PropReader.get("application_url");
        String browser = PropReader.get("browser");
        System.out.println(browser);
		String Headless = pr.readproperty("Headless_Execution");
        boolean flag= Headless.equalsIgnoreCase("Yes");
        setWebDriver(webDriver.webinit(browser, app, false, false,flag));
		//Initiate values
		HashMap<String, String> Variables = new HashMap<>();
		Variables.put("Test", "123");
		setVariables(Variables);
        setScenarioName(s.getName());
        System.out.println("Starting Scenario : "+s.getName());
        ExtentTest test = extent.createTest(
                s.getName(),
                s.getUri().toString()
        );
        ExtentTestManager.setTest(test);
//        String test11 =OnePasswordUtil.getSecret("HubTran Portal", "username");
//        System.out.println("Hubtran:"+test11);

    }
//	@After(value = "@WEB",order=1)
//	public void TearDown(Scenario s) throws Exception {
//
//
//		String sourcePath = "data:image/png;base64," + ((TakesScreenshot) WEB_DRIVER_THREAD_LOCAL.get()).
//				getScreenshotAs(OutputType.BASE64);
////        String status = ScenarioContext.status.get();
//		if (s.isFailed()) {
//			System.out.println(s.getName()+" is Failed");
//			ExtentCucumberAdapter.getCurrentStep().log(Status.FAIL,"Teardown failed → Screenshot taken during cleanup", MediaEntityBuilder.createScreenCaptureFromBase64String(sourcePath).build());
//		}
//		else {
//			System.out.println(s.getName()+" is Passed");
//		}
//		System.out.println("TestCaseID is" + s.getId());
//        String appName = PropReader.get("OrgName");
//        String BrowserName = PropReader.get("browser");
//
//        if (s.isFailed()) {
//            ExtentTestManager.getTest().fail("Scenario Failed");
//			if(getVariable("Transcore_Down").equalsIgnoreCase("Yes")||getVariable("SMC3_End_Point_disabled").equalsIgnoreCase("Yes")){
//				ExcelUpdater.updateStatus(s.getName(), "SKIP", appName, BrowserName);
//			}else {
//				ExcelUpdater.updateStatus(s.getName(), "FAIL", appName, BrowserName);
//			}
//            //Retry code
//            String needFailedRun = pr.readproperty("FirstRetry");
//            System.out.println(needFailedRun);
//            if ("Yes".equalsIgnoreCase(needFailedRun)) {
//                String runnerName = System.getProperty("bdd.runner", "");
//                System.out.println(runnerName);
//                // Skip storing failures when executing retry runner
//                if (!"Web_retry".equalsIgnoreCase(runnerName)) {
//                    String uri = s.getUri().getPath();
//                    String projectPath = System.getProperty("user.dir");
//                    uri = uri.replace(projectPath + "/", "");
//                    if (uri.startsWith("/")) {
//                        uri = uri.substring(1);
//                    }
//                    uri = uri.replace(" ", "%20");
//                    String failedScenario = "file:" + uri + ":" + s.getLine();
//                    FailedScenarioWriter.writeFailedScenario(failedScenario);
//                }
//                else{
//                    String needFailedRunAgain = pr.readproperty("SecondRetry");
//                    System.out.println(needFailedRun);
//                    if("Yes".equalsIgnoreCase(needFailedRunAgain)) {
//                            String uri = s.getUri().getPath();
//                            String projectPath = System.getProperty("user.dir");
//                            uri = uri.replace(projectPath + "/", "");
//                            if (uri.startsWith("/")) {
//                                uri = uri.substring(1);
//                            }
//                            uri = uri.replace(" ", "%20");
//                            String failedScenario = "file:" + uri + ":" + s.getLine();
//                            FailedScenarioWriter.writeFailedRetryScenario(failedScenario);
//                        //}
//                    }
//                }
//            }
//        }
//        else {
//            ExtentTestManager.getTest().pass("Scenario Passed");
//            ExcelUpdater.updateStatus(s.getName(), "PASS",appName,BrowserName);
//        }
//        extent.flush();
//        ExtentTestManager.removeTest();
//        safeGuestQuit(getGuestDriver());
//        safeQuit(WEB_DRIVER_THREAD_LOCAL.get());
//        System.out.println("Ending Scenario : "+s.getName());
//
//        //Org pool - Release Org
//        String org = TestContext.getOrg();
//        OrgManager.releaseOrg(org);
//        TestContext.remove();
//	}


    @After(value = "@WEB", order = 1)
    public void TearDown1(Scenario s) throws Exception {

        try {
            String sourcePath = "data:image/png;base64," + ((TakesScreenshot) WEB_DRIVER_THREAD_LOCAL.get()).
                    getScreenshotAs(OutputType.BASE64);
            if (s.isFailed()) {
                System.out.println(s.getName()+" is Failed");
                ExtentCucumberAdapter.getCurrentStep().log(Status.FAIL,"Teardown failed → Screenshot taken during cleanup", MediaEntityBuilder.createScreenCaptureFromBase64String(sourcePath).build());
            }
            else {
                System.out.println(s.getName()+" is Passed");
            }
            System.out.println("TestCaseID is" + s.getId());
            String appName = PropReader.get("OrgName");
            String BrowserName = PropReader.get("browser");

            if (s.isFailed()) {
                ExtentTestManager.getTest().fail("Scenario Failed");
                if(getVariable("Transcore_Down").equalsIgnoreCase("Yes")||getVariable("SMC3_End_Point_disabled").equalsIgnoreCase("Yes")){
                    ExcelUpdater.updateStatus(s.getName(), "SKIP", appName, BrowserName);
                }else {
                    ExcelUpdater.updateStatus(s.getName(), "FAIL", appName, BrowserName);
                }
                //Retry code
                String needFailedRun = pr.readproperty("FirstRetry");
                System.out.println(needFailedRun);
                if ("Yes".equalsIgnoreCase(needFailedRun)) {
                    String runnerName = System.getProperty("bdd.runner", "");
                    System.out.println(runnerName);
                    // Skip storing failures when executing retry runner
                    if (!"Web_retry".equalsIgnoreCase(runnerName)) {
                        String uri = s.getUri().getPath();
                        String projectPath = System.getProperty("user.dir");
                        uri = uri.replace(projectPath + "/", "");
                        if (uri.startsWith("/")) {
                            uri = uri.substring(1);
                        }
                        uri = uri.replace(" ", "%20");
                        String failedScenario = "file:" + uri + ":" + s.getLine();
                        FailedScenarioWriter.writeFailedScenario(failedScenario);
                    }
                    else{
                        String needFailedRunAgain = pr.readproperty("SecondRetry");
                        System.out.println(needFailedRun);
                        if("Yes".equalsIgnoreCase(needFailedRunAgain)) {
                            String uri = s.getUri().getPath();
                            String projectPath = System.getProperty("user.dir");
                            uri = uri.replace(projectPath + "/", "");
                            if (uri.startsWith("/")) {
                                uri = uri.substring(1);
                            }
                            uri = uri.replace(" ", "%20");
                            String failedScenario = "file:" + uri + ":" + s.getLine();
                            FailedScenarioWriter.writeFailedRetryScenario(failedScenario);
                            //}
                        }
                    }
                }
            }
            else {
                ExtentTestManager.getTest().pass("Scenario Passed");
                ExcelUpdater.updateStatus(s.getName(), "PASS",appName,BrowserName);
            }

        } finally {

            try {
                extent.flush();
            } catch (Exception e) {
                System.err.println("Extent flush failed: " + e.getMessage());
            }

            try {
                ExtentTestManager.removeTest();
            } catch (Exception e) {
                System.err.println("Extent cleanup failed: " + e.getMessage());
            }

            try {
                safeGuestQuit(getGuestDriver());
            } catch (Exception e) {
                System.err.println("Guest driver cleanup failed: "
                        + e.getMessage());
            }

            try {
                safeQuit(WEB_DRIVER_THREAD_LOCAL.get());
            } catch (Exception e) {
                System.err.println("WebDriver cleanup failed: "
                        + e.getMessage());
            }

            System.out.println("Ending Scenario: " + s.getName());
        }
    }

    @After(value = "@WEB", order = 0)
    public void releaseOrgAfterScenario(Scenario s) {

        String org = TestContext.getOrg();

        try {
            System.out.println(
                    "[ORG POOL] Release hook started for: " + s.getName());

        } finally {
            try {
                if (org != null && !org.trim().isEmpty()) {

                    System.out.println("[ORG POOL] Releasing Org: " + org);

                    OrgManager.releaseOrg(org);
                    Thread.sleep(1500);
                    OrgManager.checkStaleOrgs(120);
//                    List<String> staleOrgs = OrgManager.StaleOrgList(120);
//                    for (String staleOrg : staleOrgs) {
//                        OrgManager.releaseOrg(staleOrg);
//                    }
//                    System.out.println(
//                            "[ORG POOL] Release completed for Org: " + org);

                } else {
                    System.err.println(
                            "[ORG POOL] Org context is NULL. "
                                    + "Cannot release Org for: " + s.getName());
                }

            } catch (Exception e) {
                System.err.println(
                        "[ORG POOL] Failed to release Org: " + org);
                e.printStackTrace();

            }
            finally {
                TestContext.remove();
            }
        }
    }

    @After(value ="@WEB",order=3)
    public void TearDown2(Scenario s) throws Exception {
        if (s.isFailed()) {
            String sourcePath1 = "data:image/png;base64," + ((TakesScreenshot) WEB_DRIVER_THREAD_LOCAL.get()).
                    getScreenshotAs(OutputType.BASE64);
            ExtentCucumberAdapter.getCurrentStep().log(Status.FAIL, "Scenario failed → Screenshot taken", MediaEntityBuilder.createScreenCaptureFromBase64String(sourcePath1).build());
            ExtentTestManager.getTest().fail("Teardown failed → Screenshot taken during cleanup", MediaEntityBuilder.createScreenCaptureFromBase64String(sourcePath1).build());

        }
        System.out.println("Ending Scenario : "+s.getName());
        Common_Steps cm = new Common_Steps(bddDriver.this);
    //    cm.Homepage();
    }

	@After("@API")
	public void APITearDown(Scenario s) throws IOException{
		PropertyReader prpertyreader = new PropertyReader();

	}

	@org.testng.annotations.BeforeSuite
	public void BeforeSuite(){
	itr=0;
	DOMConfigurator.configure("log4j.xml");
	}
	
	public static WebDriver getWebDriver() {
		return WEB_DRIVER_THREAD_LOCAL.get();
	}
    public static void setWebDriver(WebDriver dr) {
              WEB_DRIVER_THREAD_LOCAL.set(dr);
    }
	public static WebDriver getGuestDriver() {
		return WEB_DRIVER_Test.get();
	}
    public static void setGuestDriver(WebDriver dr) {
        WEB_DRIVER_Test.set(dr);
    }
	public void setApiDriver(){
		API_DRIVER_THREAD_LOCAL.set(ApiDriver.apiinit(""));
}
	public RequestSpecification getApiDriver(){
		return API_DRIVER_THREAD_LOCAL.get();
	}
	public void setLoadNum(String num){
		LoadNum.set(num);
	}
	public String getLoadNum(){
		return LoadNum.get();
	}
	public void setCustomerTotalPrice(double price){customerTotalPrice.set(price);}
	public double getCustomerTotalPrice(){	return customerTotalPrice.get();}
    public void setScenarioName(String name) {
        scenarioName.set(name);
    }

    public String getScenarioName() {
        return scenarioName.get();
    }

	public String VerifyHtmlContent(String data,String tag) throws DocumentException {

     	org.jsoup.nodes.Document doc = Jsoup.parse(data);

		String link = doc.select("body").toString().replaceAll("  ","").replaceAll("&lt;","<").replaceAll("&gt;",">").replaceAll("<br>","").replaceAll("<body class=\"test\">","").replaceAll("<.body>","").trim();
        System.out.println("Value for the tage in response is"+link);
		SAXReader xmlreader=new SAXReader();
		Document doc1=xmlreader.read(new StringReader(link));


		doc1.selectSingleNode(tag).getText();
		System.out.println("Value for the tage in response is"+doc1.selectSingleNode(tag).getText());
		//Assert.assertTrue(doc.selectSingleNode(Node).getText().equals(Expectedvalue),"Expected the Value of <b>"+Node+"</b> Attribute value contains <b>"+Expectedvalue+"</b> but  Actual returned was <b>"+doc.selectSingleNode(Node).getText()+"</b>");


       return doc1.selectSingleNode(tag).getText();

	}
	public static boolean validateXMLSchema(String xsdPath, String xmlPath){
		String updatedpath = System.getProperty("user.dir")+ "/src/test/resources/apiResourceTemplate/";
		try {
			SchemaFactory factory =
					SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
			Schema schema = factory.newSchema(new File(updatedpath+xsdPath));
			Validator validator = schema.newValidator();
			validator.validate(new StreamSource(new File(updatedpath+xmlPath)));
		} catch (IOException | SAXException e) {
			System.out.println("Exception: "+e.getMessage());
			return false;
		}
		return true;
	}


	public static void Addlog(String message) throws IOException {
		ExtentCucumberAdapter.addTestStepLog(message);
	}

	public static void logPayload()
	{
		ExtentCucumberAdapter.addTestStepLog("<textarea readonly> Request Payload: \n"+baseDriverHelper.ReportPayload+"</textarea>");
	}
	public static void logResponse()
	{
		ExtentCucumberAdapter.addTestStepLog("<textarea readonly> Response: \n"+baseDriverHelper.Resultrespoence.get().getBody().asString()+"</textarea>");
	}
	public static void log(String message)
	{
		ExtentCucumberAdapter.addTestStepLog(message);
	}

    public void setVariables(HashMap<String, String> args) {
        Variables.set(args);
    }
    public HashMap<String, String> getVariables() {
        return Variables.get();
    }
    public void initVariables() {
        if (Variables.get() == null) {
            Variables.set(new HashMap<>());
        }
    }
    public void setVariable(String key, String value) {
		initVariables();
        Variables.get().put(key, value);
		System.out.println("Value of Attribute Stored: "+key+" is :"+value);// replaces if already exists
    }
//    // Get a variable
//    public String getVariable(String key) {
//        initVariables();
//		System.out.println("Value of Attribute Returned: "+key+" is :"+Variables.get().get(key));
//		return Variables.get().get(key);
//    }
    public String getVariable(String key) {
        initVariables();
        String value = Variables.get().get(key);
        System.out.println("Value of Attribute Returned: " + key + " is :" + value);
        return value != null ? value : "";
    }
	Long startTime;
	Long endTime;
	Long executionTime;
//	@BeforeStep
//	public void beforeStep()
//	{
//		startTimeWebStep = System.currentTimeMillis();
//	}
//	@AfterStep
//	public void afterStep()
//	{
//		endTimeWebStep = System.currentTimeMillis();
//		executionTimeWebStep = endTimeWebStep - startTimeWebStep;
//		ExtentCucumberAdapter.getCurrentStep().info("Total step time taken: <b>" + convertMillisecondsToSeconds(executionTimeWebStep) + " Sec.</b>");
//	}
	public static double convertMillisecondsToSeconds(long milliseconds) {
		return milliseconds / 1000.0;
	}

	public static void WriteExcelData(String TestCaseID, String userID, String ExecutionTime, String timeStamp, String Status, String Error) throws IOException {
		String testOutputSheet = System.getProperty("user.dir")+File.separator+"src"+File.separator+"test"+File.separator+"resources"+File.separator+"Data"+File.separator+"Execution_Details.xlsx";
		String TestCase;
		int Rownum = 0;
		boolean flag = false;
		Row row;
		FileInputStream file = new FileInputStream(new File(testOutputSheet));
		Workbook workbook = new XSSFWorkbook(file);
		Sheet sheet = workbook.getSheetAt(0);
		for (int i = 0; i <= sheet.getLastRowNum(); i++) {
			try {
				TestCase = sheet.getRow(i).getCell(0).getStringCellValue().trim();
				if (TestCase.equalsIgnoreCase(TestCaseID)) {
					flag = true;
					Rownum = i;
				}
			} catch (Exception e) {
				flag = false;
			}
		}
		if (flag) {
			row = sheet.createRow(Rownum);
		} else {
			row = sheet.createRow(sheet.getLastRowNum() + 1);
		}
		// Create cells and write data
		Cell cell1 = row.createCell(0);
		cell1.setCellValue(TestCaseID);

		Cell cell2 = row.createCell(1);
		cell2.setCellValue(userID);

		Cell cell3 = row.createCell(2);
		cell3.setCellValue(ExecutionTime);

		Cell cell4 = row.createCell(3);
		cell4.setCellValue(timeStamp);

		Cell cell5 = row.createCell(4);
		cell5.setCellValue(Status);

		Cell cell6 = row.createCell(5);
		cell6.setCellValue(Error);

		try (FileOutputStream fileOut = new FileOutputStream(testOutputSheet)) {
			workbook.write(fileOut);
			System.out.println("Excel file has been updated successfully!");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// Close the workbook
			try {
				workbook.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	public static boolean isDouble(String str) {
		return str.matches("^-?\\d*\\.\\d+$");
	}
	public static boolean isInteger(String str) {
		return str.matches("^-?\\d+$");
	}

    @Then("Launch browser and Navigate Link")
    public void launchBrowserAndNavigateLink() throws InterruptedException, IOException {
        if (getGuestDriver() != null) {
            try {
                getGuestDriver().quit();
            } catch (Exception e) {
                // ignore
            } finally {
                setGuestDriver(null);
            }
        }
        webDriver webDriver = new baseDriver();
        String Headless = pr.readproperty("Headless_Execution");
        boolean flag= Headless.equalsIgnoreCase("Yes");
        setGuestDriver(webDriver.LaunchBrowserWithLink(getVariable("Link"),flag));
        System.out.println(getGuestDriver().getTitle());
    }
    @Then("Navigate to guest browser with link")
    public void NavigateGuestBrowser() throws InterruptedException, IOException {
        getGuestDriver().get(getVariable("Link"));
        Thread.sleep(2000);
    }
    @Then("Close Guest Browser")
    public void CloseGuestBrowser() throws InterruptedException {
        if (getGuestDriver() != null) {
            try {
                getGuestDriver().quit();
            } catch (Exception e) {
                // ignore already closed session
            } finally {
                setGuestDriver(null);   // always reset
            }
        }
        Thread.sleep(2000);
    }
    public static void safeGuestQuit(WebDriver driver) {
        if (driver != null) {
            try {
                driver.getTitle();
                String sourcePath1 = "data:image/png;base64," + ((TakesScreenshot) driver).
                        getScreenshotAs(OutputType.BASE64);
                ExtentCucumberAdapter.getCurrentStep().log(Status.FAIL, "Scenario failed → Screenshot taken", MediaEntityBuilder.createScreenCaptureFromBase64String(sourcePath1).build());

           //     driver.quit();
            } catch (
                    org.openqa.selenium.WebDriverException e) {
                // Session already closed – ignore safely
            }
        }
    }
    public static void safeQuit(WebDriver driver) {
        if (driver != null) {
            try {
                driver.getTitle();
            //    driver.quit();
            } catch (
                     org.openqa.selenium.WebDriverException e) {
                // Session already closed – ignore safely
            }
        }
    }

}
