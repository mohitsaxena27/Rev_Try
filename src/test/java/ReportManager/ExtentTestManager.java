package ReportManager;

import com.aventstack.extentreports.ExtentTest;
import io.cucumber.java.AfterStep;
import io.cucumber.java.BeforeStep;
import io.cucumber.java.Scenario;

public class ExtentTestManager {

    private static ThreadLocal<ExtentTest> test = new ThreadLocal<>();

    public static void setTest(ExtentTest extentTest) {
        test.set(extentTest);
    }

    public static ExtentTest getTest() {
        return test.get();
    }

    public static void removeTest() {
        test.remove();
    }
    @BeforeStep
    public void beforeStep(Scenario scenario) {
        ExtentTestManager.getTest()
                .info("➡️ Step started");
    }
    @AfterStep
    public void afterStep(Scenario scenario) {

        if (scenario.isFailed()) {
            ExtentTestManager.getTest()
                    .fail("❌ Step Failed");
        } else {
            ExtentTestManager.getTest()
                    .pass("✅ Step Passed");
        }
    }


}
