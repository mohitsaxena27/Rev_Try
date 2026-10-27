package utils.Xml;

import org.w3c.dom.Node;
import org.xmlunit.diff.Comparison;
import org.xmlunit.diff.ComparisonResult;
import org.xmlunit.diff.ComparisonType;
import org.xmlunit.diff.DifferenceEvaluator;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class CustomDifferenceEvaluator implements DifferenceEvaluator {

    private final XmlToleranceConfig config;

    public CustomDifferenceEvaluator(XmlToleranceConfig config) {
        this.config = config;
    }

    @Override
    public ComparisonResult evaluate(Comparison comparison, ComparisonResult outcome) {

        if (outcome == ComparisonResult.DIFFERENT &&
                comparison.getType() == ComparisonType.TEXT_VALUE) {

            String expected = comparison.getControlDetails().getValue().toString().trim();
            String actual   = comparison.getTestDetails().getValue().toString().trim();

            Node controlNode = comparison.getControlDetails().getTarget();

            if (controlNode == null || controlNode.getParentNode() == null) {
                return outcome;
            }

            String nodeName = controlNode.getParentNode().getNodeName();

            // Mileage handling
            if ("mileage".equals(nodeName)) {
                try {
                    BigDecimal e = new BigDecimal(expected.replace(",", ""))
                            .setScale(config.getMileageScale(), RoundingMode.HALF_UP);
                    BigDecimal a = new BigDecimal(actual.replace(",", ""))
                            .setScale(config.getMileageScale(), RoundingMode.HALF_UP);

                    if (e.compareTo(a) == 0) {
                        return ComparisonResult.SIMILAR;
                    }
                } catch (Exception ignored) {}
            }

            // Time tolerance handling
            if ("respondByTime".equals(nodeName) || "statusTime".equals(nodeName)) {
                try {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
                    LocalTime eTime = LocalTime.parse(expected, formatter);
                    LocalTime aTime = LocalTime.parse(actual, formatter);

                    long diffMinutes = Math.abs(Duration.between(eTime, aTime).toMinutes());

                    if (diffMinutes <= config.getTimeToleranceMinutes()) {
                        return ComparisonResult.SIMILAR;
                    }
                } catch (Exception ignored) {}
            }
        }

        return outcome;
    }
}