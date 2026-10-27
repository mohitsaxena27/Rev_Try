package ReportManager;

import com.aventstack.extentreports.ExtentTest;
import io.cucumber.plugin.ConcurrentEventListener;
import io.cucumber.plugin.event.*;

public class ExtentCucumberListener implements ConcurrentEventListener {

    @Override
    public void setEventPublisher(EventPublisher publisher) {

        publisher.registerHandlerFor(TestStepStarted.class, this::handleStepStarted);
        publisher.registerHandlerFor(TestStepFinished.class, this::handleStepFinished);
    }

    private void handleStepStarted(TestStepStarted event) {

        if (event.getTestStep() instanceof PickleStepTestStep step) {
            String stepText = step.getStep().getText();

            ExtentTestManager.getTest()
                    .info("➡️ " + stepText);
        }
    }

    private void handleStepFinished(TestStepFinished event) {

        if (event.getTestStep() instanceof PickleStepTestStep step) {
            Status status = event.getResult().getStatus();

            switch (status) {
                case PASSED ->
                        ExtentTestManager.getTest().pass("✅ Passed");
                case FAILED ->
                        ExtentTestManager.getTest().fail("❌ Failed");
                case SKIPPED ->
                        ExtentTestManager.getTest().skip("⏭ Skipped");
            }
        }
    }


}
