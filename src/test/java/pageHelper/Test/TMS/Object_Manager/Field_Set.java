package pageHelper.Test.TMS.Object_Manager;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.NoSuchFrameException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.DriverController;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.NoSuchElementException;

@Log4j
public class Field_Set {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Field_Set(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Object_Manager"+File.separator+"Field_Set.xml");
    }

    @Then("Open {string} Object Manager")
    public void openObjectManager(String arg0) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SpanText1").replace("{paramlink}", "Object Manager")));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SpanText1").replace("{paramlink}", "Object Manager")));
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Quick_Find")), arg0);
        Thread.sleep(1000);
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("ObjectLink").replace("{paramlink}",arg0)));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ObjectLink").replace("{paramlink}",arg0)));
    }

    @Then("Open {string} from Setup Icon")
    public void openFromSetupIcon(String arg0) throws Exception {
        try {
//            webDriver.waitUntilElementIsVisible(pageObject.getlocator("Set_up_Icon"));
            Thread.sleep(1000);
            webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("Set_up_Icon")));
            Thread.sleep(3000);
//            int count = webDriver.getwebelementscount(xml.getlocator("SetUpLink").replace("{paramlink}",arg0));
//            if(count>0) {
//                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SetUpLink").replace("{paramlink}", arg0)));
//            }
//            else{
//                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SetUpLink").replace("{paramlink}", arg0)));
//            }
            webDriver.waitUntilElementIsVisible(xml.getlocator("SetUpLink").replace("{paramlink}", arg0));
            Thread.sleep(1000);
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SetUpLink").replace("{paramlink}", arg0)));


        }
        catch(Exception e) {
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("Set_up_Icon")));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("SetUpLink").replace("{paramlink}", arg0)));
        }
    }

    @Then("Open Field Sets {string} from List")
    public void openFieldSetsFromList(String arg0) throws Exception {
        DriverInstance.setVariable("Field_Set",arg0);
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Quick_Find")), arg0);
        webDriver.waitForElementLoad(1);
        try {
            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("SpanText1").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(2);
        }
        catch(Exception e)
        {
            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("SpanText1").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(2);
        }
    }

    @Then("Delete Fields if any available with Field Set")
    public void deleteFieldsIfAnyAvailableWithFieldSet() throws Exception {
        webDriver.ImplicitlyWait(5);
        int count1 = webDriver.getwebelementscount(pageObject.getlocator("Select_Field").replace("[index]", ""));
        if(count1>0) {
            DeleteObject();
        }
        webDriver.ImplicitlyWait(20);
    }

    @Then("Update Object Manager {string} with Delete All Field")
    public void editObjectManagerWithDeleteField(String arg0) throws Exception {

        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LinkText").replace("{paramlink}","Field Sets")));
        Thread.sleep(1000);
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Quick_Find")), arg0);
        Thread.sleep(3000);
        try {
            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("SpanText1").replace("{paramlink}", arg0)));
            Thread.sleep(1000);
            webDriver.SwitchToFrameByElement(webDriver.getwebelement(xml.getlocator("IframeTitle").replace("{paramlink}", "Salesforce - Enterprise Edition")));
        }
        catch(NoSuchFrameException e)
        {
            webDriver.Clickon(webDriver.passwebelement(xml.getlocator("SpanText1").replace("{paramlink}", arg0)));
            Thread.sleep(1000);
            webDriver.SwitchToFrameByElement(webDriver.getwebelement(xml.getlocator("IframeTitle").replace("{paramlink}", "Salesforce - Enterprise Edition")));
        }
        DeleteObject();
        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*","//button").replace("{paramlink}","Save")));
        Thread.sleep(2000);
        webDriver.SwitchToParentFrame();


    }
    @Then("Add the Following Fields in this Order")
    public void addTheFollowingFieldsInThisOrder(DataTable dt) throws Exception {
        java.util.List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            webDriver.BrowserZoom("70");
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                try {
                    dragObject(entry.getKey());
                } catch (Exception e) {
                    try {
                        dragObject(entry.getKey());
                    }
                    catch (Exception e1)
                    {
                        Assert.fail("Issue with adding Field set "+ entry.getKey() +"due to "+e1.getMessage());
                    }
                }
            }
            webDriver.BrowserZoom("100");
        }
    }
    @Then("Zoom Current Screen by {string}")
    public void BrowserZoom(String ZoomRatio)
    {
        webDriver.BrowserZoom(ZoomRatio);
    }
    @Then("Make below Field Set Required")
    public void makeBelowFieldSetRequired(DataTable dt) throws Exception {
        java.util.List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            webDriver.BrowserZoom("60");
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                MakeItRequired(entry.getKey(),true);
            }
            webDriver.BrowserZoom("100");
        }
    }
    @Then("Create New Field Set With Label as {string}")
    public void createNewFieldSetWithLabelAs(String arg0) throws Exception {
        webDriver.WaitforElementtobeclickable(xml.getlocator("Global_Text").replace("{paramlink}", "New"));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "New")));
        webDriver.waitForElementLoad(1);
    }

    String text ="abc";
    public void dragObject(String Field)throws Exception
    {

        WebElement wl;
        WebElement wl1;
        int targetX;
        int targetY;
        webDriver.SendKeys(webDriver.getwebelement(pageObject.getlocator("Quick_Find2")), Field);
        Thread.sleep(500);
        if(Field.length()>16) {
            System.out.println(Field.substring(0, 17));
            wl = webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}", Field.substring(0, 17)));
        }
        else{
            wl = webDriver.getwebelement(xml.getlocator("SpanText1").replace("{paramlink}",Field));
        }
        if(text.equalsIgnoreCase("abc")) {
            wl1 = webDriver.getwebelement(pageObject.getlocator("defailtView"));
        }
        else{
            wl1 = webDriver.getwebelement(pageObject.getlocator("DivTextFieldName").replace("{paramlink}",text));
        }
        webDriver.dragAndDrop(wl,wl1);
        text= Field;

    }

    public void dragObjectIndividual(String Field, String AfterField)throws Exception
    {
        WebElement wl;
        WebElement wl1;
        webDriver.SendKeys(webDriver.getwebelement(pageObject.getlocator("Quick_Find2")), Field);
        Thread.sleep(500);
        if(Field.length()>16) {
            System.out.println(Field.substring(0, 17));
            wl = webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}", Field.substring(0, 17)));
        }
        else{
            wl = webDriver.getwebelement(xml.getlocator("SpanText1").replace("{paramlink}",Field));
        }
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("DivTextFieldName").replace("{paramlink}",AfterField)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("DivTextFieldName").replace("{paramlink}",AfterField)));
        wl1 = webDriver.getwebelement(pageObject.getlocator("DivTextFieldName").replace("{paramlink}",AfterField));
        webDriver.waitForElementLoad(1);
        webDriver.dragAndDropWithOffset(wl,wl1);
//            webDriver.dragAndDropWithJS(wl,wl1,Field,AfterField);
    }


    public void DeleteObject()throws Exception
    {
        webDriver.ImplicitlyWait(5);
        webDriver.ScrollLast();
        int count1;
        count1 = webDriver.getwebelementscount(pageObject.getlocator("Field_Count").replace("[index]", ""));
        do {
           //
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Select_Field").replace("index", String.valueOf(count1))));
            webDriver.Clickon(webDriver.passwebelement(pageObject.getlocator("Select_Field").replace("index", String.valueOf(count1))));
            WebElement element = webDriver.passwebelement(pageObject.getlocator("Remove_Field").replace("index", String.valueOf(count1)));
            String ID = webDriver.Getattribute(element, "id");
            System.out.println("id is " + ID);
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("DeleteJob2").replace("{paramlink}", ID)));
            webDriver.ClickUsingActions(webDriver.passwebelement(pageObject.getlocator("DeleteJob2").replace("{paramlink}", ID)));
            Thread.sleep(600);
            count1 = webDriver.getwebelementscount(pageObject.getlocator("Field_Count").replace("[index]", ""));
            System.out.println("count" + count1);
        }
        while (count1 !=0);
        webDriver.ImplicitlyWait(20);
    }
    public void MakeItRequired(String key, boolean Check) throws Exception {

        webDriver.ImplicitlyWait(5);
        int count1=0;
        if(Check) {
            count1 = webDriver.getwebelementscount(pageObject.getlocator("CheckRequired").replace("{paramlink}", key));
            if(count1==0)
            {
                CheckRequired(key);
                System.out.println("count" + count1);
            }
        }
        else{
            webDriver.ScrollLast();
            count1 = webDriver.getwebelementscount(pageObject.getlocator("CheckRequiredFalse").replace("{paramlink}", key));
            if(count1==0)
            {
                CheckRequired(key);
                System.out.println("count" + count1);
            }
        }
        webDriver.ImplicitlyWait(20);
    }
     private void CheckRequired(String key)throws Exception
     {
         webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("FieldName").replace("{paramlink}", key)));
         webDriver.Clickon(webDriver.passwebelement(pageObject.getlocator("FieldName").replace("{paramlink}", key)));
         WebElement element = webDriver.passwebelement(pageObject.getlocator("Field_Properties").replace("{paramlink}", key));
         String ID = webDriver.Getattribute(element, "id");
         System.out.println("id is " + ID);
         webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("DeleteJob2").replace("{paramlink}", ID)));
         webDriver.ClickUsingActions(webDriver.passwebelement(pageObject.getlocator("DeleteJob2").replace("{paramlink}", ID)));
         Thread.sleep(600);
         webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("Required_Input").replace("{paramlink}", key)));
         Thread.sleep(600);
         webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("OKButton")));

     }
    public void DeleteFieldSet(String arg0) throws Exception {
        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LinkText").replace("{paramlink}","Field Sets")));
        Thread.sleep(1000);
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Quick_Find")), arg0);
        Thread.sleep(3000);

        int count = webDriver.getwebelementscount(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0));
        if(count>0) {
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0));
            webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(1);
            webDriver.WaitforElementtobeclickable(xml.getlocator("Global_Text").replace("{paramlink}", "Delete"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "Delete")));
            webDriver.WaitforElementtobeclickable(xml.getlocator("LinkTitle").replace("{paramlink}", "delete"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LinkTitle").replace("{paramlink}", "delete")));
            webDriver.waitForElementLoad(6);
        }
    }

    public void DeleteFieldsAndRelationships(String arg0) throws Exception {
        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LinkText").replace("{paramlink}","Fields & Relationships")));
        Thread.sleep(1000);
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Quick_Find")), arg0);
        Thread.sleep(3000);

        int count = webDriver.getwebelementscount(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0));
        if(count>0) {
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0));
            webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("DeleteDropdown").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(1);
            webDriver.WaitforElementtobeclickable(xml.getlocator("Global_Text").replace("{paramlink}", "Delete"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", "Delete")));
            webDriver.WaitforElementtobeclickable(xml.getlocator("LinkTitle").replace("{paramlink}", "delete"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LinkTitle").replace("{paramlink}", "delete")));
            webDriver.waitForElementLoad(6);
        }
    }

    public void OpenFieldSet(String FieldSet) throws Exception {
       webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LinkText").replace("{paramlink}","Field Sets")));
       Thread.sleep(1000);
       webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Quick_Find")), FieldSet);
       Thread.sleep(2000);
       try {
           webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("SpanText1").replace("{paramlink}", FieldSet)));
           Thread.sleep(1000);
       }
       catch(NoSuchFrameException e)
       {
           webDriver.Clickon(webDriver.passwebelement(xml.getlocator("SpanText1").replace("{paramlink}", FieldSet)));
           Thread.sleep(1000);
       }
       webDriver.SwitchToFrameByElement(webDriver.getwebelement(xml.getlocator("IframeTitle").replace("{paramlink}", "Salesforce - Enterprise Edition")));

   }

    public void DeleteWithFieldName( String key) throws Exception {
        webDriver.ImplicitlyWait(5);
//        webDriver.BrowserZoom("60");
        webDriver.ScrollLast();
        int count1=0;
            do {
                count1 = webDriver.getwebelementscount(pageObject.getlocator("FieldName").replace("{paramlink}", key));
               if(count1>0) {
                   webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("FieldName").replace("{paramlink}", key)));
                   webDriver.Clickon(webDriver.passwebelement(pageObject.getlocator("FieldName").replace("{paramlink}", key)));
                   webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Field_Delete").replace("{paramlink}", key)));
                   webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("Field_Delete").replace("{paramlink}", key)));
                   webDriver.ClickUsingActions(webDriver.passwebelement(pageObject.getlocator("Field_Delete").replace("{paramlink}", key)));
                   Thread.sleep(1000);
                   count1 = webDriver.getwebelementscount(pageObject.getlocator("Field_Delete").replace("{paramlink}", key));
                   System.out.println("count" + count1);
               }
            }
            while (count1 != 0);
//        webDriver.BrowserZoom("100");
    }

    public void DeleteWithFieldName2( String key) throws Exception {
        webDriver.ImplicitlyWait(5);
        webDriver.ScrollLast();
        int count1=0;
            do {
                count1 = webDriver.getwebelementscount(pageObject.getlocator("FieldName").replace("{paramlink}", key));
               if(count1>0) {
                   webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("FieldName").replace("{paramlink}", key)));
                   webDriver.Clickon(webDriver.passwebelement(pageObject.getlocator("FieldName").replace("{paramlink}", key)));
                   WebElement element = webDriver.passwebelement(pageObject.getlocator("Field_Delete").replace("{paramlink}", key));
                   webDriver.ScrollIntoView(element);
                   webDriver.ClickUsingActions(element);
                   Thread.sleep(600);
                   count1 = webDriver.getwebelementscount(pageObject.getlocator("Field_Delete").replace("{paramlink}", key));
                   System.out.println("count" + count1);
               }
            }
            while (count1 != 0);
    }

    public void SaveFieldSet() throws Exception {
        webDriver.ImplicitlyWait(20);
        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*","//button").replace("{paramlink}","Save")));
        Thread.sleep(2000);
        webDriver.SwitchToParentFrame();
    }

    @Then("Enter Formula Text as {string}")
    public void enterFormulaTextAs(String arg0) throws DocumentException, InterruptedException, IOException {
       try {
           webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", "CalculatedFormula")));
           webDriver.SendKeys(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", "CalculatedFormula")), arg0);
       }
       catch (Exception e)
       {
           webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", "CalculatedFormula")));
           webDriver.SendKeys(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", "CalculatedFormula")), arg0);

       }

       }

    @Then("Verify Details {string} added and displaying on List")
    public void verifyDetailsAddedAndDisplayingOnList(String arg0) throws InterruptedException, DocumentException, IOException {
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Quick_Find")), arg0);
        Thread.sleep(3000);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
    }


    @Then("Add the Individual Fields {string} Set after {string}")
    public void addTheIndividualFieldsSetAfter(String arg0, String arg1) throws Exception {
        boolean placedCorrectly = false;

        try {
          dragObjectIndividual(arg0,arg1);
          String verifyXpath =
                  "//div[@class='field-name' and normalize-space()='" + arg0 + "']" +
                          "/ancestor::div[contains(@class,'field-source')]/following-sibling::div[1]" +
                          "//div[@class='field-name' and normalize-space()='" + arg1 + "']";

          webDriver.verifyElementToBePresent(verifyXpath);
            placedCorrectly = true;
         }
        catch (Exception ignored)
        {

        }

        if (!placedCorrectly) {
            // 🔄 JavaScript fallback

            String script =
                    "let src = [...document.querySelectorAll('.field-name')]"
                            + ".find(el => el.textContent.trim() === arguments[0]);"
                            + "let dest = [...document.querySelectorAll('.field-name')]"
                            + ".find(el => el.textContent.trim() === arguments[1]);"
                            + "if (src && dest) dest.closest('.field-source').after(src.closest('.field-source'));";
                  webDriver.dragAndDropWithJS(script,arg0,arg1);

        }

    }


}