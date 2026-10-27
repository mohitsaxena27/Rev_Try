package bddRunner;
//import cucumber.Reporter;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeSuite;
import utils.Excel.ExcelUpdater;
import utils.ExtentSetup;
import utils.MockServer;
import utils.PropertyReader;
import utils.Retry.FailedScenarioWriter;

import java.io.IOException;


@CucumberOptions(
		features = {"src/test/resources/FeatureFile"}, glue = {"pageHelper"},
		plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
		tags = "@WEB and not @Debugging and not @Field_Set"
)

public class WithoutDebug extends AbstractTestNGCucumberTests {
    public static String message;
    PropertyReader propertyReader=new PropertyReader();

    @BeforeSuite
    public void initializeMock() throws IOException {
//        propertyReader.updateproprty("TotalClickCount","0");
        ExcelUpdater.resetExecutionStatus();
        FailedScenarioWriter.cleanFailedFile();
        ExtentSetup ex = new ExtentSetup();
        ex.setupReportName();
    }
    static long startTime;
    static long endTime;
    @AfterSuite
    public void TearDown() throws IOException, InterruptedException {
        ExcelUpdater.generateSummary();
    }
    @BeforeClass
    public void beforeClass() {
        startTime = System.currentTimeMillis();
    }
    @AfterClass
    public static void writeExtentReport() throws IOException {
        PropertyReader prpertyreader = new PropertyReader();
        //Sent the Email
        endTime = System.currentTimeMillis();
        long duration = (endTime - startTime) / 1000;
        System.out.println("Execution time for Web: " + duration + " Seconds");
    }
}