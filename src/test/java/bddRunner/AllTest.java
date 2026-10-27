package bddRunner;
//import cucumber.Reporter;
import com.google.api.services.gmail.Gmail;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.*;
import utils.Excel.ExcelToCsvConverter;
import utils.Excel.ExcelUpdater;
import utils.ExtentSetup;
import utils.MailUtility.GmailSender;
import utils.PropertyReader;
import utils.Retry.FailedScenarioWriter;
import utils.Retry.SkipFailureInterceptor;
import utils.MailUtility.maiUtility;

import java.io.IOException;


@CucumberOptions(
		features = {"src/test/resources/FeatureFile"}, glue = {"pageHelper"},
		plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
		tags = "@WEB"
)
//@Listeners(SkipFailureInterceptor.class)
public class AllTest extends AbstractTestNGCucumberTests {
	public static String message;
	PropertyReader propertyReader=new PropertyReader();

    @Override
    @DataProvider(parallel = true)
    public Object[][] scenarios() {
        return super.scenarios();
    }

	@BeforeSuite
	public void initializeMock() throws IOException {
//		propertyReader.updateproprty("TotalClickCount","0");
        ExcelToCsvConverter.clearCsvFile();
        ExcelUpdater.resetExecutionStatus();
        FailedScenarioWriter.cleanFailedFile();
        FailedScenarioWriter.cleanFailedRetryFile();
        ExtentSetup ex = new ExtentSetup();
        ex.setupReportName();
	}
	static long startTime;
	static long endTime;
	@AfterSuite
	public void TearDown() throws Exception {
     ExcelUpdater.generateSummary();
     ExcelToCsvConverter.CsvConvertor();
        PropertyReader pr=new PropertyReader();
        String enable = pr.readproperty("SendReportOnEmail");
        if(enable.equalsIgnoreCase("Yes")) {
            String message = "";
            maiUtility ml = new maiUtility();
//            message = "<p>Hi All,</p><p>A Test Execution build was triggered and the execution has been completed.</p><p>For the detailed Information’s, please refer the attached html report.</p><p>Thanks,<br/>QA Team</p>";
            message = "<html>"
                    + "<body style='font-family:Arial, sans-serif;'>"
                    + "<p>Hi Team,</p>"

                    + "<p>We are pleased to inform you that the <b>automation test execution</b> has been successfully completed.</p>"

                    + "<p><b>Execution Summary:</b></p>"
                    + "<ul>"
                    + "<li>Release: <b>" + pr.readproperty("Org_Release") + "</b></li>"
//                    + "<li>Org ID: <b>" + pr.readproperty("Org_Id") + "</b></li>"
                    + "<li>Total Tests Executed: <b>" + System.getProperty("Total_Test") + "</b></li>"
                    + "<li>Total Passed: <b>" + System.getProperty("Total_Passed") + "</b></li>"
                    + "<li>Total Failed: <b>" + System.getProperty("Total_Failed") + "</b></li>"
                    + "<li>Total Skipped: <b>"+System.getProperty("Total_Skipped")+"</b></li>"
                    + "<li>Retry Attempts: <b>" + System.getProperty("Total_retry") + "</b></li>"
                    + "</ul>"

                    + "<p><b>Execution Highlights:</b></p>"
                    + "<ul>"
                    + "<li>Build was successfully triggered and executed</li>"
                    + "<li>Automated test suite completed without interruption</li>"
                    + "<li>Test reports have been generated and attached</li>"
                    + "</ul>"

                    + "<p><b>Detailed Reports:</b></p>"
                    + "<ul>"
                    + "<li><b>HTML Report:</b> Includes detailed execution logs and step-by-step results</li>"
                    + "<li><b>Excel Report:</b> Provides a summarized view of test results (Pass/Fail)</li>"
                    + "</ul>"

                    + "<p>Please find the attached reports for detailed insights and analysis.</p>"

                    + "<p>If you have any questions or need further clarification, please feel free to reach out.</p>"

                    + "<p>Thanks & Regards,<br/>"
                    + "<b>QA Team</b></p>"

                    + "</body></html>";
            if(pr.readproperty("MailProvider").equalsIgnoreCase("IMAP")) {
                ml.SendEmail(message, "Report//TestResults.xlsx");
            }
            else{
                Gmail gmail = GmailSender.getService();
                GmailSender sender = new GmailSender(gmail);
                sender.sendEmail(
                        propertyReader.readproperty("ToEmailList"),
                        "Automation Script Execution Report",
                        message,
                        "Report//TestResults.xlsx"
                );
            }
        }
        else{
            System.out.println("No email sent as not configured");
        }
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