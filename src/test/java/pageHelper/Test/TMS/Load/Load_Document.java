package pageHelper.Test.TMS.Load;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Test.FMS.Fleet_Common;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.ColorUtils;
import utils.PropertyReader;
import utils.TableVerifier;
import utils.xmlreader;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

@Log4j
public class Load_Document {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Common_Steps cf;
    public Fleet_Common fc;

    public Load_Document(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_Summary.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cf = new Common_Steps(DriverInstance);
        fc= new Fleet_Common(DriverInstance);
    }

    @Then("Wait and verify the files present in the document tab")
    public void waitAndVerifyTheFilesPresentInTheDocumentForLoad() throws Exception {

        fc.setWith("FileName_5", "SysData=>1L", " - ");
        fc.setWith("Final_FileName","SysData=>FileName_5","SMC3 EVA Carrier - SMC3 EVA - BOL.pdf");
        String bolFileName = DriverInstance.getVariable("Final_FileName");
        System.out.println("bol_FileName: "+bolFileName);
        List<String> expectedDocuments = Arrays.asList(
                "Weight & Inspection Certificate.PNG",
                "Delivery Receipt.PNG",
                "Bill of Lading.PNG",
                "Invoice.PNG",
                resolveDynamicValue(bolFileName)
                );

     //   boolean found = waitForAnyDocument(arg0, expectedDocuments, 5, 7);
        boolean found = waitForAnyDocument(expectedDocuments,7);

        Assert.assertTrue(found, "No expected document generated after 35 minutes.");
    }
    private String resolveDynamicValue(String input) {
        if (input != null && input.contains("SysData=>")) {
            String key = input.split("SysData=>")[1].trim();
            return DriverInstance.getVariable(key); // replace with your actual store/lookup
        }
        else {
            return input;
        }
    }
    public boolean waitForAnyDocument(List<String> docs, int maxAttempts) throws Exception {

        for (int attempt = 1; attempt <= maxAttempts; attempt++) {
            cf.refreshCurrentPage();
            cf.goToTab("Documents");
            cf.goToTab("Files");

            for (String doc : docs) {
                System.out.println("Searched Doc : " + doc);
                if (isDocumentPresent(doc)) {
                    System.out.println("Found : " + doc);
                    return true;
                }
            }
            if (attempt < maxAttempts) {
                cf.waitForSeconds("300");
            }
        }
        return false;
    }
    public boolean isDocumentPresent(String documentName) throws DocumentException, InterruptedException {

        List<WebElement> docs = webDriver.getwebelements(xml.getlocator("Global_Text_Contains").replace("{paramlink}",documentName));
        return !docs.isEmpty();
    }
}