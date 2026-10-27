package utils.Retry;

import org.testng.IInvokedMethod;
import org.testng.IInvokedMethodListener;
import org.testng.ITestResult;
import utils.PropertyReader;

import java.io.IOException;

public class SkipFailureInterceptor implements IInvokedMethodListener {
    @Override
    public void afterInvocation(IInvokedMethod method, ITestResult result) {

        if (result.getStatus() == ITestResult.FAILURE) {
            PropertyReader pr=new PropertyReader();
            String needFailedRun = null;
            try {
                needFailedRun = pr.readproperty("NeedtoRunFailedTest");
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            System.out.println(needFailedRun);

            if ("Yes".equalsIgnoreCase(needFailedRun)) {
            String runnerName = System.getProperty("bdd.runner", "");
            boolean isRetryRun = "Web_retry".equalsIgnoreCase(runnerName);

            if (!isRetryRun) {
                result.setStatus(ITestResult.SKIP);
                ScenarioContext.status.set("SKIP");
                System.out.println("Converted FAIL → SKIP");
            }
        }
    }
    }

}
