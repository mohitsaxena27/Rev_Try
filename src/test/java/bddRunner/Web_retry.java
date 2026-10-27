package bddRunner;
//import cucumber.Reporter;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.*;
import utils.MockServer;
import utils.PropertyReader;

import java.io.IOException;


@CucumberOptions(
		features = {"@rerun/failed_scenarios.txt"}, glue = {"pageHelper"},
		plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"}
)

public class Web_retry extends AbstractTestNGCucumberTests {
	public static String message;
    @Override
    @DataProvider(parallel = true)
    public Object[][] scenarios() {
        return super.scenarios();
    }
    @BeforeClass
    public void beforeClass() {
        System.setProperty("bdd.runner", this.getClass().getSimpleName());
    }
}