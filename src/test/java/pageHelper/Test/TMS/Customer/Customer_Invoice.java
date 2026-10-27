package pageHelper.Test.TMS.Customer;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.DriverController;
import utils.PDFTableExtractor;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Log4j
public class Customer_Invoice {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Customer_Invoice(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Customer" + File.separator + "Customer_Invoice.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    public void verifyModalDisplayed() throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("modalLocator")));
        webDriver.verifyElementToBePresent(pageObject.getlocator("modalLocator"));
    }

    public void verifyModalHeaderContains(String expectedText) throws DocumentException, InterruptedException {
        String actualText = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("headerLocator")));
        Assert.assertTrue(actualText.contains(expectedText));
    }
    public void verifyIframeSrcContains(String expected) throws DocumentException, InterruptedException {
        webDriver.waitForElementLoad(3);
        WebElement wl = webDriver.passwebelement(pageObject.getlocator("iframeLocator").replace("{paramlink}",expected));
        webDriver.waitUntilTheElementIsVisible(wl);
        String actualText = webDriver.Getattribute(wl,"src");
        Assert.assertTrue(actualText.contains(expected));
    }

    @Then("Verify Preview {string} modal renders with a preview of PDF")
    public void verifyPreviewModalRendersWithAPreviewOfPDF(String arg0) throws DocumentException, InterruptedException {
        verifyModalDisplayed();
        verifyModalHeaderContains(arg0);
        verifyIframeSrcContains("/servlet.shepherd/version/download/");

    }


    @Then("Close the Preview Modal")
    public void closeThePreviewModal() throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("CloseModal")));
        webDriver.Clickon(webDriver.passwebelement(pageObject.getlocator("CloseModal")));

    }

    @Then("Verify Heading Text {string}")
    public void VerifyHeading(String arg0) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("HeadigText").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("HeadigText").replace("{paramlink}", arg0));

    }

    @Then("Verify the Invoice attachment is saved to the record with the {string} - Customer Invoice.pdf")
    public void verifyTheInvoiceAttachmentIsSavedToTheRecordWithTheCustomerInvoicePdf(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("CustomerInvoiceLink"));
        String text=  webDriver.getText(webDriver.getwebelement(pageObject.getlocator("CustomerInvoiceLink")));
        webDriver.Stringcomparator(text,DriverInstance.getVariable(arg0)+" - Customer Invoice.pdf");
    }

    @Then("Click on {string}{string} on {string}")
    public void clickOnOn(String arg0, String arg1, String arg2) throws Exception {
        if(arg1.contains("Sysdata=>"))
        {
            arg1=DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("TableTextLink").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1).replace("{paramlink3}", arg2)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("TableTextLink").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1).replace("{paramlink3}", arg2)));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("TableTextLink").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1).replace("{paramlink3}", arg2)));

    }
    @Then("Delete {string} with data {string}")
    public void deleteWithData(String arg0, String arg1) throws Exception {
        int count = webDriver.getwebelementscount(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0));
        if (count > 0) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0)));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0));
            webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(1);
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("DivText2").replace("{paramlink}", "Delete"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("DivText2").replace("{paramlink}", "Delete")));
            webDriver.WaitforElementtobeclickable(xml.getlocator("SpanTextTab").replace("{paramlink}", "Delete"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SpanTextTab").replace("{paramlink}", "Delete")));
            webDriver.waitForElementLoad(6);
        }
    }

    @Then("Delete Records with Row having {string}")
    public void deleteWithRowData(String arg0) throws Exception {
        int count = webDriver.getwebelementscount(pageObject.getlocator("DeleteDropdownWithName").replace("{paramlink}", arg0));
        if (count > 0) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("DeleteDropdownWithName").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("DeleteDropdownWithName").replace("{paramlink}", arg0)));
            webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("DeleteDropdownWithName").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(1);
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("DivText2").replace("{paramlink}", "Delete"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("DivText2").replace("{paramlink}", "Delete")));
            webDriver.WaitforElementtobeclickable(xml.getlocator("SpanTextTab").replace("{paramlink}", "Delete"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SpanTextTab").replace("{paramlink}", "Delete")));
        }
    }

    @Then("the PDF table rows should match:")
    public void thePDFTableRowsShouldMatch(DataTable expectedTable) {
        List<Map<String, String>> actualPdfRows;
//        DriverInstance.setVariable("FilePath","C:\\Users\\manishk.mishra\\IdeaProjects\\Revenova\\DownloadedFiles\\downloaded_salesforce_file.pdf");
        String url = DriverInstance.getVariable("FilePath");
        actualPdfRows = PDFTableExtractor.extractRows(url);
        System.out.println("Extracted Rows: " + actualPdfRows);

        List<Map<String, String>> expectedRows = expectedTable.asMaps(String.class, String.class);

        Assert.assertEquals(expectedRows.size(), actualPdfRows.size(),"Count Mismatch");

        for (int i = 0; i < expectedRows.size(); i++) {
            Map<String, String> expectedRow = expectedRows.get(i);
            Map<String, String> actualRow = actualPdfRows.get(i);

            for (String key : expectedRow.keySet()) {

                String expected = expectedRow.get(key);
                String actual = actualRow.get(key);
                if (actual == null) {
                    actual = "";
                }
                if (Objects.nonNull(expected) && !expected.isEmpty()) {
                    if (expected.contains("Date=>")) {
                        String Value = expected.split("=>")[1];
//                        expected = webDriver.ReturnDateInSpecifiedFormat(Value, "MMM dd");
                        expected = webDriver.ReturnDateInSpecifiedTimeZoneAndFormat(Value,"GMT" ,"MMM dd");
                    } else if (expected.contains("SysData=>")) {
                        String Value = expected.split("=>")[1];
                        expected = DriverInstance.getVariable(Value);
                    }
                    System.out.println("Extracted Rows: " + expected);
                    System.out.println("Extracted Rows: " + actual);
                    Assert.assertTrue(actual.contains(expected), "Mismatch at row " + (i + 1) + " column: " + key + "Expected :"+expected +" Actual: "+actual);
                }
                else{
                    Assert.assertEquals(actual, "", "Mismatch at row " + (i + 1) + " column: " + key);

                }
            }
        }

        System.out.println("PDF table validation successful.");
    }

    @Then("Verify File {string} displaying {string} Times")
    public void verifyTextDisplayingAsTimeS(String arg0, String arg1) throws DocumentException, InterruptedException {
        if(Integer.parseInt(arg1)>0) {
            if (arg0.contains("SysData")) {
                String Value = arg0.split("=>")[1];
                webDriver.waitUntilElementIsVisible(pageObject.getlocator("FileNameCount").replace("{paramlink}", DriverInstance.getVariable(Value)));
                webDriver.verifyElementToBePresent(pageObject.getlocator("FileNameCount").replace("{paramlink}", DriverInstance.getVariable(Value)));
                int count = webDriver.getwebelementscount(pageObject.getlocator("FileNameCount").replace("{paramlink}", DriverInstance.getVariable(Value)));
                Assert.assertEquals(count, Integer.parseInt(arg1), "Text count not matched");
            } else {
                webDriver.waitUntilElementIsVisible(pageObject.getlocator("FileNameCount").replace("{paramlink}", arg0));
                webDriver.verifyElementToBePresent(pageObject.getlocator("FileNameCount").replace("{paramlink}", arg0));
                int count = webDriver.getwebelementscount(pageObject.getlocator("FileNameCount").replace("{paramlink}", arg0));
                Assert.assertEquals(count, Integer.parseInt(arg1), "Text count not matched");
            }
        }
        else{
            Assert.fail("This method is not accepted count as Zero");
        }
    }

    @Then("Verify {string} file not showing on Attached Documents section")
    public void verifyFileNoyNotShowingOnAttachedDocumentsSection(String arg0) throws DocumentException, InterruptedException {
       webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyAttacheDocumentSection").replace("{paramlink}",arg0));
    }
    @Then("Verify {string} file showing on Attached Documents section")
    public void verifyFileShowingOnAttachedDocumentsSection(String arg0) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData"))
        {
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyAttacheDocumentSection").replace("{paramlink}",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyAttacheDocumentSection").replace("{paramlink}",arg0));
    }

    @Then("Verify {string} and {string} in format {string}")
    public void verifyDateTimeInFormat(String arg0, String arg1, String arg2) {
        if(arg0.contains("SysData")){
            arg0=arg0.split("=>")[1];
            arg0=DriverInstance.getVariable(arg0);
        }
        if(arg1.contains("SysData")){
            arg1=arg1.split("=>")[1];
            arg1=DriverInstance.getVariable(arg1);
        }
        System.out.println(arg0);
        System.out.println(arg1);
        webDriver.ToleranceTime(arg0,arg1,arg2);
        }
}
