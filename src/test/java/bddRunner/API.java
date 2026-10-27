package bddRunner;


//import cucumber.Reporter;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;
import io.cucumber.plugin.Plugin;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeSuite;
import utils.MockServer;
import utils.PropertyReader;

import java.io.File;
import java.io.IOException;

@CucumberOptions(

		features = {"src/test/resources/FeatureFile"}, glue = {"pageHelper"},
		plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
		tags = "@POS-API",

		dryRun = false
)

public class API extends AbstractTestNGCucumberTests {
	public static String message;
	MockServer mock=new MockServer();



	@BeforeSuite
	public void initializeMock() throws IOException {
	}
	
	@AfterClass
	 public static void writeExtentReport() throws IOException {
	 PropertyReader prpertyreader = new PropertyReader();

	 //Reporter.loadXMLConfig(new File(System.getProperty("user.dir") +"/"+prpertyreader.readproperty("reportConfigPath")));
//	 Reporter.setSystemInfo("User Name", System.getProperty("user.name"));
//     Reporter.setSystemInfo("Time Zone", System.getProperty("user.timezone"));
//     Reporter.setSystemInfo("Machine", "Windows 10" + "64 Bit");
//     Reporter.setSystemInfo("Selenium", "3.7.0");
//     Reporter.setSystemInfo("Maven", "3.5.2");
//     Reporter.setSystemInfo("Java Version", "1.8.0_151");
      //Sent the Email
    // System.out.println(prpertyreader.readproperty("to"));
//     maiUtility ml=new maiUtility();
//     message="<p>Hi All,</p><p>A Test Execution build was triggered and the execution has been completed.</p><p>For the detailed Information’s, please refer the attached html report.</p><p>Thanks,<br/>QA Team</p>";
//		ml.SendEmail(message,"target//cucumber-reports//SIT//report.html");

	}
	@AfterSuite
	public void TearDown() throws IOException {
		//mock.MockServerTearDown();
	}

}