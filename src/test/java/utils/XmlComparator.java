package utils;

import org.testng.Assert;
import org.xmlunit.builder.DiffBuilder;
import org.xmlunit.builder.Input;
import org.xmlunit.diff.Diff;

import java.io.File;
import java.nio.file.Files;

public class XmlComparator {
    public static String fileloaction;
    public static void SoapXmlCompare (String scenarioName, String FileName, String stringXml) throws Exception {
        // XML from file
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String dir = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator+"TestCaseFiles"+File.separator+TID+ File.separator;
//        String dir = System.getProperty("user.dir")+File.separator+"src"+File.separator+"test"+File.separator+"resources"+File.separator+"Documents"+File.separator+"TestCaseFiles"+File.separator;
        fileloaction=dir+FileName;
        String fileXml = new String(Files.readAllBytes(new File(fileloaction).toPath()));

        // Compare while ignoring whitespace and namespace prefixes
        Diff diff = DiffBuilder.compare(Input.fromString(fileXml))
                .withTest(Input.fromString(stringXml))
                .ignoreWhitespace()
                .checkForSimilar()
                .build();

        if (diff.hasDifferences()) {
            diff.getDifferences().forEach(d -> {
                System.out.println("Difference: " + d);
                Assert.fail("Getting Difference in xml"+ d);
            });

        }
        else {
            System.out.println("✅ XMLs match (structurally similar)");
        }
    }
}
