package bddRunner;
//import cucumber.Reporter;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;


@CucumberOptions(
		features = {"@rerun/failed_retry_scenarios.txt"}, glue = {"pageHelper"},
		plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"}
)

public class Web_Failed_retry extends AbstractTestNGCucumberTests {
	public static String message;
    @Override
    @DataProvider(parallel = true)
    public Object[][] scenarios() {
        return super.scenarios();
    }
    @BeforeClass
    public void beforeClass() {
//        System.setProperty("bdd.failed.runner", this.getClass().getSimpleName());
    }
}