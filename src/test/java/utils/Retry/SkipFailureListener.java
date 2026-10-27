package utils.Retry;

import org.testng.ITestListener;
import org.testng.ITestResult;

public class SkipFailureListener implements ITestListener {

    @Override
    public void onTestFailure(ITestResult result) {

        String runnerName = System.getProperty("bdd.runner", "");
        boolean isRetryRun = "Web_retry".equalsIgnoreCase(runnerName);
        String needRetry = System.getProperty("NeedtoRunFailedTest", "Yes");

        if ("Yes".equalsIgnoreCase(needRetry) && !isRetryRun) {

            System.out.println("Converting FAIL → SKIP (onTestFailure)");

            // 🔥 convert before @After executes
            result.setStatus(ITestResult.SKIP);
            System.out.println("Converted FAIL → SKIP");
            // 🔥 now ThreadLocal WILL be available in @After
            ScenarioContext.status.set("SKIP");
        }
    }
}
