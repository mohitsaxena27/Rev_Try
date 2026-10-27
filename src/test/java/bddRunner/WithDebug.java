package bddRunner;
//import cucumber.Reporter;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeClass;
import utils.MockServer;
import utils.PropertyReader;
import utils.MailUtility.maiUtility;

import java.io.IOException;


@CucumberOptions(
		features = {"src/test/resources/FeatureFile"}, glue = {"pageHelper"},
		plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
		tags = "@WEB and @Debugging"

)

public class WithDebug extends AbstractTestNGCucumberTests {
	public static String message;
	MockServer mock=new MockServer();
	PropertyReader propertyReader=new PropertyReader();

	static long startTime;
	static long endTime;
	@AfterClass
	 public static void writeExtentReport() throws IOException {
		endTime = System.currentTimeMillis();
		long duration = (endTime - startTime) / 1000;
		System.out.println("Execution time for Web: " + duration + " Seconds");
	}
	@AfterSuite
	public void TearDown() throws IOException {
		//mock.MockServerTearDown();
		PropertyReader pr=new PropertyReader();
		String enable = pr.readproperty("SendReportOnEmail");
		if(enable.equalsIgnoreCase("Yes")) {
			String message = "";
			maiUtility ml = new maiUtility();
			message = "<p>Hi All,</p><p>A Test Execution build was triggered and the execution has been completed.</p><p>For the detailed Information’s, please refer the attached html report.</p><p>Thanks,<br/>QA Team</p>";
			ml.SendEmail(message, "Reports//3505_Spark.html");
			ml.SendEmail("Excel Report", "Report//TestResults.xlsx");
		}
		else{
			System.out.println("No email sent as not configured");
		}
	}

	@BeforeClass
	public void beforeClass() {
		startTime = System.currentTimeMillis();
	}
}