package bddRunner;
//import cucumber.Reporter;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeSuite;
import utils.MockServer;
import utils.PropertyReader;

import java.io.IOException;


@CucumberOptions(
		features = {"src/test/resources/FeatureFile"}, glue = {"pageHelper"},
		plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
		tags = "@WEB and @Field_Set and not @Debugging "
)

public class WithoutDebugAndFieldSet extends AbstractTestNGCucumberTests {
	public static String message;
	MockServer mock=new MockServer();
	PropertyReader propertyReader=new PropertyReader();

	static long startTime;
	static long endTime;
	@AfterClass
	 public static void writeExtentReport() throws IOException {
	 PropertyReader prpertyreader = new PropertyReader();
		endTime = System.currentTimeMillis();
		long duration = (endTime - startTime) / 1000;
		System.out.println("Execution time for Web: " + duration + " Seconds");
	}

	@BeforeClass
	public void beforeClass() {
		startTime = System.currentTimeMillis();
	}
}