package utils.Retry;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class FailedScenarioWriter {
    private static final String FILE_PATH = "rerun/failed_scenarios.txt";
    private static final String FILE_Retry_PATH = "rerun/failed_retry_scenarios.txt";

    public static synchronized void writeFailedScenario(String scenarioPath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(scenarioPath);
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void cleanFailedFile() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            writer.write(""); // Clears the file content
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static synchronized void writeFailedRetryScenario(String scenarioPath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_Retry_PATH, true))) {
            writer.write(scenarioPath);
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void cleanFailedRetryFile() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_Retry_PATH))) {
            writer.write(""); // Clears the file content
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}