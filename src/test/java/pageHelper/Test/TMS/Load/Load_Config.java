package pageHelper.Test.TMS.Load;

import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang.StringUtils;
import org.dom4j.DocumentException;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.Color;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.*;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Log4j
public class Load_Config {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader Generic;
    public PropertyReader propertyReader = new PropertyReader();
    public Load_Config(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("TMS"+ File.separator+"Load"+File.separator+"Load_Config.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    @Then("Select Customer Details and Load Type")
    public void createOneLoadWithTheirDetails(DataTable dataTable) throws Exception {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        String Load_Num = data.get(0).get("Load_Num");
        String Customer = data.get(0).get("Customer");
        String Mode = data.get(0).get("Mode");
        String Equipment_Type = data.get(0).get("Equipment_Type");
        String Details_Entry = data.get(0).get("Details_Entry");
        String ShowAccessorials = data.get(0).get("Show_Accessorials");
        DriverInstance.setVariable("Equipment_Type", Equipment_Type);
        DriverInstance.setVariable("Customer", Customer);
        DriverInstance.setVariable("Mode", Mode);
        DriverInstance.setVariable("Details_Entry", Details_Entry);
        DriverInstance.setVariable("Show_Accessorials", ShowAccessorials);

        //New Btn
        webDriver.waitForElementLoad(1);
        webDriver.waitUntilElementIsVisible(xml.getlocator("New_Btn"));
        webDriver.verifyElementToBePresent(xml.getlocator("New_Btn"));
        webDriver.WaitforElementtobeclickable(xml.getlocator("New_Btn"));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("New_Btn")));

        webDriver.waitForElementLoad(3);
        int count=webDriver.getwebelementscount(xml.getlocator("InputField").replace("{paramlink}", "Customer Search"));
        if(count==0)
        {
            int Btncount=webDriver.getwebelementscount(xml.getlocator("New_Btn"));
            if(Btncount>0)
            {
                Common_Steps cm = new Common_Steps(DriverInstance);
                cm.openFromAppLauncher("Loads");
                webDriver.WaitforElementtobeclickable(xml.getlocator("New_Btn"));
                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("New_Btn")));
                webDriver.waitForElementLoad(2);
            }
        }
        //Enter and Select Customer
        if (!Customer.equalsIgnoreCase("NA"))
        {webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", "Customer Search")));
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", "Customer Search")), Customer);
        Thread.sleep(800);
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Search_Result").replace("{paramlink}", Customer)));
        Thread.sleep(1000);
        }
        //Select Mode
        if(!Mode.equalsIgnoreCase("NA")) {
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Field_Button").replace("{paramlink}", "Mode")));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SelectValueFromComboBox").replace("{paramlink1}", "Mode").replace("{paramlink2}", Mode)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("TextField").replace("{paramlink}", "1P")));
        }
        //Select Equipment Type
        if(!Equipment_Type.equalsIgnoreCase("NA")) {
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Field_Button").replace("{paramlink}", "Equipment Type")));
            webDriver.SelectComboBoxOption(webDriver.passwebelement(xml.getlocator("Div_aria_Label").replace("{paramlink}", "Equipment Type")), webDriver.passwebelement(xml.getlocator("SpanText").replace("{paramlink}", Equipment_Type)));
            Thread.sleep(1000);
        }
        //Check Detailed Entry and Show Accessorials
        if (Details_Entry.equalsIgnoreCase("Y")) {
            if(webDriver.getwebelementscount(xml.getlocator("ButtonText").replace("{paramlink}", "Detail Entry"))>0) {
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ButtonText").replace("{paramlink}", "Detail Entry")));
                webDriver.waitForElementLoad(1);
            }
            if (ShowAccessorials.equalsIgnoreCase("Y")) {
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ButtonText").replace("{paramlink}", "Show Accessorials")));
            }
        }
        else{
            if(webDriver.getwebelementscount(xml.getlocator("ButtonText").replace("{paramlink}", "Detail Entry"))>0) {
               System.out.println("Quick View Load");
            }
            else{
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ButtonText").replace("{paramlink}", "Quick Entry")));

            }
        }
        DriverInstance.setVariable("Total_Stops", "0");
        DriverInstance.setVariable("Total_Pickup_Stops", "0");
        DriverInstance.setVariable("Total_Delivery_Stops", "0");
        DriverInstance.setVariable("LoadNum", Load_Num);

    }

    @Then("Select {string} as {string}")
    public void selectAs(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Field_Button").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Field_Button").replace("{paramlink}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Field_Button").replace("{paramlink}", arg0)));
        webDriver.SelectComboBoxOption(webDriver.passwebelement(xml.getlocator("Div_aria_Label").replace("{paramlink}", arg0)), webDriver.passwebelement(xml.getlocator("SpanText").replace("{paramlink}", arg1)));
        Thread.sleep(1000);
    }

    @Then("Add Location Details")
    public void Add_Location_Details(DataTable dataTable) throws Exception {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        String Add_Loc= data.get(0).get("Add_Loc");
        String Type = data.get(0).get("Type");
        String Address_Type = data.get(0).get("Address_Type");
        String Location_Value = data.get(0).get("Value");
        String Expected_Date = data.get(0).get("Expected_Date");
        String Shipping_Receiving_Hours = data.get(0).get("Shipping_Receiving_Hours");
        String Appointment_Time = data.get(0).get("Appointment_Time");
        String Appointment_Required = data.get(0).get("Appointment_Required");
        DriverInstance.setVariable("Type", Type);
        DriverInstance.setVariable(Type+"Location_Value", Location_Value);
        if(!(Expected_Date.equalsIgnoreCase("NA")||Expected_Date.contains("SysData"))) {
            DriverInstance.setVariable(Type + "Expected_Date", webDriver.ExpectedDate(Expected_Date));
        }
        DriverInstance.setVariable(Type+"Shipping_Receiving_Hours", Shipping_Receiving_Hours);
        DriverInstance.setVariable(Type+"Appointment_Time", Appointment_Time);
        DriverInstance.setVariable(Type+"Appointment_Required", Appointment_Required);
        webDriver.waitForElementLoad(2);
        if(Add_Loc.trim().equals("Y"))
        {
          int index= Integer.parseInt(String.valueOf(Type.charAt(0)));
          String locationType=String.valueOf(Type.charAt(1));
          webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddLocation").replace("index",String.valueOf(index))));
          if(locationType.trim().equals("P"))
          {
              webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddPickup").replace("index",String.valueOf(index))));
          }
          else if(locationType.trim().equals("D"))
          {
              webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddDelivery").replace("index",String.valueOf(index))));

          }
          else{
              Assert.fail("You have passed incorrect location type!!");
          }
        }

        if(Address_Type.equalsIgnoreCase("Same_as_Customer"))
        {
            LocationUsingSameAsCustomer( Type, Location_Value, Shipping_Receiving_Hours,  Appointment_Time,  Appointment_Required,  Expected_Date );

        }
        else if(Address_Type.equalsIgnoreCase("Account_Address"))
        {
            LocationUsingAccountAddress( Type, Location_Value, Shipping_Receiving_Hours,  Appointment_Time,  Appointment_Required,  Expected_Date );

        }
        else if(Address_Type.equalsIgnoreCase("City_State_PC"))
        {
            LocationUsingCityStatePostalCode( Type, Location_Value, Shipping_Receiving_Hours,  Appointment_Time,  Appointment_Required,  Expected_Date );

        }
        else if(Address_Type.equalsIgnoreCase("GeoLocation"))
        {
            LocationUsingGeoLocation( Type, Location_Value, Shipping_Receiving_Hours,  Appointment_Time,  Appointment_Required,  Expected_Date );

        }
        else{
            Assert.fail("You have passed some wrong adress type at the time of select location Address");
         }
        DriverInstance.setVariable("Total_Stops", String.valueOf(Integer.parseInt(DriverInstance.getVariable("Total_Stops"))+1));
        if(Type.contains("P"))
        {
            DriverInstance.setVariable("Total_Pickup_Stops", String.valueOf(Integer.parseInt(DriverInstance.getVariable("Total_Pickup_Stops"))+1));

        }
        else{
            DriverInstance.setVariable("Total_Delivery_Stops", String.valueOf(Integer.parseInt(DriverInstance.getVariable("Total_Delivery_Stops"))+1));
        }
    }

    @Then("Add More Location Details")
    public void Add_More_Location_Details(DataTable dataTable) throws Exception {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        String Add_Loc= data.get(0).get("Add_Loc");
        String Type = data.get(0).get("Type");
        String Address_Type = data.get(0).get("Address_Type");
        String Location_Value = data.get(0).get("Value");
        String Expected_Date = data.get(0).get("Expected_Date");
        String Shipping_Receiving_Hours = data.get(0).get("Shipping_Receiving_Hours");
        String Appointment_Time = data.get(0).get("Appointment_Time");
        String Appointment_Required = data.get(0).get("Appointment_Required");
        DriverInstance.setVariable("Type", Type);
        DriverInstance.setVariable(Type+"Location_Value", Location_Value);
        if(!Expected_Date.equalsIgnoreCase("NA")) {
            DriverInstance.setVariable(Type + "Expected_Date", webDriver.ExpectedDate(Expected_Date));
        }
        DriverInstance.setVariable(Type+"Shipping_Receiving_Hours", Shipping_Receiving_Hours);
        DriverInstance.setVariable(Type+"Appointment_Time", Appointment_Time);
        DriverInstance.setVariable(Type+"Appointment_Required", Appointment_Required);
        webDriver.waitForElementLoad(2);
        if(Add_Loc.trim().equals("Y"))
        {
            int index= Integer.parseInt(String.valueOf(Type.charAt(0)));
            String locationType=String.valueOf(Type.charAt(1));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddLocation").replace("index",String.valueOf(index-1))));
            if(locationType.trim().equals("P"))
            {
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddPickup").replace("index",String.valueOf(index-1))));
            }
            else if(locationType.trim().equals("D"))
            {
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddDelivery").replace("index",String.valueOf(index-1))));

            }
            else{
                Assert.fail("You have passed incorrect location type!!");
            }
        }
        webDriver.waitForElementLoad(2);
        if(Address_Type.equalsIgnoreCase("Same_as_Customer"))
        {
            LocationUsingSameAsCustomer( Type, Location_Value, Shipping_Receiving_Hours,  Appointment_Time,  Appointment_Required,  Expected_Date );

        }
        else if(Address_Type.equalsIgnoreCase("Account_Address"))
        {
            LocationUsingAccountAddress(Type, Location_Value, Shipping_Receiving_Hours, Appointment_Time, Appointment_Required, Expected_Date);
        }
        else if(Address_Type.equalsIgnoreCase("City_State_PC"))
        {
            LocationUsingCityStatePostalCode( Type, Location_Value, Shipping_Receiving_Hours,  Appointment_Time,  Appointment_Required,  Expected_Date );

        }
        else if(Address_Type.equalsIgnoreCase("GeoLocation"))
        {
            LocationUsingGeoLocation( Type, Location_Value, Shipping_Receiving_Hours,  Appointment_Time,  Appointment_Required,  Expected_Date );

        }
        else{
            Assert.fail("You have passed some wrong adress type at the time of select location Address");
        }
        DriverInstance.setVariable("Total_Stops", String.valueOf(Integer.parseInt(DriverInstance.getVariable("Total_Stops"))+1));
        if(Type.contains("P"))
        {
            DriverInstance.setVariable("Total_Pickup_Stops", String.valueOf(Integer.parseInt(DriverInstance.getVariable("Total_Pickup_Stops"))+1));

        }
        else{
            DriverInstance.setVariable("Total_Delivery_Stops", String.valueOf(Integer.parseInt(DriverInstance.getVariable("Total_Delivery_Stops"))+1));
        }
    }

    public void enterExpectedDate(String Expected_Date, String Type) throws DocumentException, InterruptedException {

        if (!"NA".equalsIgnoreCase(Expected_Date)) {
            String formattedDate;
            if (Expected_Date.contains("SysData"))
            {
                formattedDate = DriverInstance.getVariable(Expected_Date.split("=>")[1]);
            }
            else{
                formattedDate  = webDriver.ExpectedDate(Expected_Date);
            }
            boolean success = false;
            int attempts = 0;

            do {
                try {
                    // Re-fetch element each time to avoid stale reference
                    WebElement element = webDriver.getwebelement(
                            xml.getlocator("Expected_Date").replace("{paramlink}", Type)
                    );

                    webDriver.ClearAndEnterDate(element, formattedDate);

                    Thread.sleep(1000);
                    // Fetch element again before reading value (avoid stale)
                    element = webDriver.getwebelement(
                            xml.getlocator("Expected_Date").replace("{paramlink}", Type)
                    );

                    String enteredValue = element.getAttribute("value");

                    if (enteredValue != null && enteredValue.equals(formattedDate)) {
                        success = true;
                        System.out.println("✅ Expected Date entered successfully: " + formattedDate);
                    } else {
                        System.out.println("⚠️ Mismatch, retrying... Expected: "
                                + formattedDate + " but got: " + enteredValue);
                    }
                } catch (StaleElementReferenceException sere) {
                    System.out.println("⚠️ Stale element, retrying...");
                } catch (Exception e) {
                    System.err.println("⚠️ Exception while entering date: " + e.getMessage());
                }

                attempts++;
            } while (!success && attempts < 3);

            if (!success) {
                throw new RuntimeException("❌ Unable to enter Expected Date after " + attempts + " attempts.");
            }
        }
    }

    public void LocationUsingSameAsCustomer(String Type,String Location_Value,String Shipping_Receiving_Hours, String Appointment_Time, String Appointment_Required, String Expected_Date ) throws Exception {
            //Select Location Type and Value
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Select_Loc_Type").replace("{paramlink1}",Type).replace("{paramlink2}","Same as Customer")));
            Thread.sleep(3000);
            enterExpectedDate(Expected_Date,Type);
            //Enter Shipping_Receiving_Hours, Appointment_Time and  Appointment_Required
            if(!Shipping_Receiving_Hours.equalsIgnoreCase("NA")) {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Shipping_Receiving_Hours")));
                webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Shipping_Receiving_Hours")), Shipping_Receiving_Hours);
            }
            if(!Appointment_Time.equalsIgnoreCase("NA")) {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Time")));
                webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Time")), Appointment_Time);

            }
           if(!Appointment_Required.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required")));
            webDriver.waitUntilElementIsVisible(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required"));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required")));
           }

            //Enter Expected Date


        }

    public void LocationUsingAccountAddress(String Type,String Location_Value,String Shipping_Receiving_Hours, String Appointment_Time, String Appointment_Required, String Expected_Date ) throws Exception
    {
        //Select Location Type and Value
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Select_Loc_Type").replace("{paramlink1}",Type).replace("{paramlink2}","Account Address")));
        Thread.sleep(1000);

         //Select Location
        if(!Location_Value.equalsIgnoreCase("NA"))  {
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LabelTextInput").replace("{paramlink1}", Type).replace("{paramlink2}", "Location")), Location_Value);
            Thread.sleep(1000);
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Search_Result").replace("{paramlink}", Location_Value)));
            Thread.sleep(1000);
        }
        enterExpectedDate(Expected_Date,Type);

        //Enter Shipping_Receiving_Hours, Appointment_Time and  Appointment_Required
        if(!Shipping_Receiving_Hours.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Shipping_Receiving_Hours")));
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Shipping_Receiving_Hours")), Shipping_Receiving_Hours);

        }
        if(!Appointment_Time.equalsIgnoreCase("NA")) {
            webDriver.waitUntilElementIsVisible(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Time"));
            webDriver.SendKeys(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Time")), Appointment_Time);
        }
        if(!Appointment_Required.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required")));
            webDriver.waitUntilElementIsVisible(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required"));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required")));
        }


    }
    public void LocationUsingCityStatePostalCode(String Type,String Location_Value,String Shipping_Receiving_Hours, String Appointment_Time, String Appointment_Required, String Expected_Date ) throws Exception
    {
        //Select Location Type and Value
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));

        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Select_Loc_Type").replace("{paramlink1}",Type).replace("{paramlink2}","City/State/Postal Code")));
        Thread.sleep(1000);

        //Select City State Postal Code
        if(!Location_Value.equalsIgnoreCase("NA")) {
            String[] arg = Location_Value.split(",");
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Select_Country").replace("{paramlink}", Type)));
            webDriver.waitForElementLoad(1);
            webDriver.SelectComboBoxOption(webDriver.passwebelement(xml.getlocator("Select_Country1").replace("{paramlink}", Type)), webDriver.passwebelement(xml.getlocator("Select_Country1_Text").replace("{paramlink}", Type).replace("{paramlink1}", arg[3])));

            Thread.sleep(800);
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LabelTextInput").replace("{paramlink1}", Type).replace("{paramlink2}", "Postal Code")), arg[2]);
            Thread.sleep(800);
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LabelTextInput").replace("{paramlink1}", Type).replace("{paramlink2}", "City")), arg[0]);
            Thread.sleep(1000);
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Search_Result").replace("{paramlink}", arg[2])));
            Thread.sleep(1000);
        }
        if(!Expected_Date.equalsIgnoreCase("NA")) {
            //Enter Expected Date
            enterExpectedDate(Expected_Date, Type);
        }
        //Enter Shipping_Receiving_Hours, Appointment_Time and  Appointment_Required
        if(!Shipping_Receiving_Hours.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Shipping_Receiving_Hours")));
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Shipping_Receiving_Hours")), Shipping_Receiving_Hours);

        }
        if(!Appointment_Time.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Time")));
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Time")), Appointment_Time);

        }
        if(!Appointment_Required.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required")));
            webDriver.waitUntilElementIsVisible(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required"));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required")));
        }


    }
    public void LocationUsingGeoLocation(String Type,String Location_Value,String Shipping_Receiving_Hours, String Appointment_Time, String Appointment_Required, String Expected_Date ) throws Exception
    {
         //Select Location Type and Value
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Location_Menu").replace("{paramlink}",Type)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Select_Loc_Type").replace("{paramlink1}",Type).replace("{paramlink2}","Geolocation")));
        Thread.sleep(1000);
        //Enter Latitude & Longitude
        String[] arg =  Location_Value.split(",");
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LabelTextInput").replace("{paramlink1}",Type).replace("{paramlink2}","Latitude")),arg[0]);
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LabelTextInput").replace("{paramlink1}",Type).replace("{paramlink2}","Longitude")),arg[1]);
         //Enter Expected Date
        webDriver.waitForElementLoad(1);
        enterExpectedDate(Expected_Date,Type);

        //Enter Shipping_Receiving_Hours, Appointment_Time and  Appointment_Required
        if(!Shipping_Receiving_Hours.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Shipping_Receiving_Hours")));
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Shipping_Receiving_Hours")), Shipping_Receiving_Hours);

        }
        if(!Appointment_Time.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Time")));
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Time")), Appointment_Time);

        }
        if(!Appointment_Required.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required")));
            webDriver.waitUntilElementIsVisible(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required"));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("LocationField").replace("{paramlink1}", Type).replace("{paramlink2}", "Appointment_Required")));
        }


    }


    @Then("Add Line Items - Quick View")
    public void Add_Line_Item(DataTable dataTable) throws Exception {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        String Line_Item= data.get(0).get("Line_Item");
        String PickUp= data.get(0).get("PickUp");
        String Delivery= data.get(0).get("Delivery");
        String Description = data.get(0).get("Description");
        String Weight = data.get(0).get("Weight");
        String Weight_Units = data.get(0).get("Weight_Units");
        String HU_Count = data.get(0).get("HU_Count");
        String Handling_Units = data.get(0).get("Handling_Units");

        DriverInstance.setVariable(Line_Item+"Description", Description);
        DriverInstance.setVariable(Line_Item+"Weight", Weight);
        DriverInstance.setVariable(Line_Item+"Weight_Units", Weight_Units);
        DriverInstance.setVariable(Line_Item+"HU_Count", HU_Count);
        DriverInstance.setVariable(Line_Item+"Handling_Units", Handling_Units);
        AddLineItem( Line_Item, PickUp, Delivery,  Description, Weight, Weight_Units,  HU_Count, Handling_Units  );
    }

     public void AddLineItem(String Line_Item,String PickUp,String Delivery, String Description,String Weight,String Weight_Units, String HU_Count, String Handling_Units  ) throws Exception {
         if(Integer.parseInt(Line_Item)>1)
         {
             webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("AddLineItem")));
             webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("AddLineItem")));
             webDriver.Clickon(webDriver.passwebelement(xml.getlocator("AddLineItem")));
             webDriver.waitForElementLoad(2);
         }

        if(Integer.parseInt(DriverInstance.getVariable("Total_Stops"))>2) {
           webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Pickup").replace("index", Line_Item)));
           webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SelectPickup").replace("{paramlink}", PickUp).replace("index", Line_Item)));
           webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Delivery").replace("index", Line_Item)));
           webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SelectDelivery").replace("{paramlink}", Delivery).replace("index", Line_Item)));
        }

         webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("EnterDescription").replace("index",Line_Item)),Description);
         webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("EnterWeight").replace("index",Line_Item)),Weight);

         if(!Weight_Units.equalsIgnoreCase("NA")) {
             webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Weight_Unit").replace("index", Line_Item)));
             webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SelectWUnit").replace("{paramlink}", Weight_Units).replace("index", Line_Item)));
         }
         if(!HU_Count.equalsIgnoreCase("NA")) {
             webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("EnterHUCount").replace("index", Line_Item)), HU_Count);
         }
         if(!Handling_Units.equalsIgnoreCase("NA")) {
             webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Handling_Unit").replace("index", Line_Item)));
             webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SelectHandUnit").replace("{paramlink}", Handling_Units).replace("index", Line_Item)));
         }
     }

    @Then("Add Line Items - Detailed View")
    public void Add_Line_Item_Detailed(DataTable dataTable) throws Exception {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        String Line_Item= data.get(0).get("Line_Item");
        String PickUp= data.get(0).get("PickUp");
        String Delivery= data.get(0).get("Delivery");
        String Description = data.get(0).get("Description");
        String Weight = data.get(0).get("Weight");
        String Weight_Units = data.get(0).get("Weight_Units");
        String HU_Count = data.get(0).get("HU_Count");
        String Handling_Units = data.get(0).get("Handling_Units");
        String Length = data.get(0).get("Length");
        String Width = data.get(0).get("Width");
        String Height = data.get(0).get("Height");
        String Dimension_Unit = data.get(0).get("Dimension_Unit");
        String NMFC_Class = data.get(0).get("NMFC_Class");
        AddLineItemDetailed( Line_Item, PickUp, Delivery,  Description, Weight, Weight_Units,  HU_Count,  Handling_Units,  Length,  Width,  Height,  Dimension_Unit, NMFC_Class  );
    }

    public void AddLineItemDetailed(String Line_Item,String PickUp,String Delivery, String Description,String Weight,String Weight_Units, String HU_Count, String Handling_Units, String Length, String Width, String Height, String Dimension_Unit,String NMFC_Class  ) throws Exception
    {
        if(Integer.parseInt(Line_Item)>1)
        {
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("AddLineItem")));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("AddLineItem")));
            webDriver.Clickon(webDriver.passwebelement(xml.getlocator("AddLineItem")));
            webDriver.waitForElementLoad(2);
        }
        if(!Description.equalsIgnoreCase("NA")) {
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("EnterDescription1").replace("index", Line_Item)), Description);
        }
        if(!Weight.equalsIgnoreCase("NA")) {
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("EnterWeight").replace("index", Line_Item)), Weight);
        }
        if(!Weight_Units.equalsIgnoreCase("NA")) {
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Weight_Unit").replace("index", Line_Item)));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SelectWUnit").replace("{paramlink}", Weight_Units).replace("index", Line_Item)));
        }
        if(!HU_Count.equalsIgnoreCase("NA")) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("EnterHUCount").replace("index", Line_Item)));
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("EnterHUCount").replace("index", Line_Item)), HU_Count);
        }
        if(!Handling_Units.equalsIgnoreCase("NA")) {
            webDriver.waitForElementLoad(1);
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Handling_Unit").replace("index", Line_Item)));
            webDriver.SelectComboBoxOption(webDriver.getwebelement(xml.getlocator("SelectHandUnit1").replace("index", Line_Item)),webDriver.getwebelement(xml.getlocator("SelectHandUnit").replace("{paramlink}", Handling_Units).replace("index", Line_Item)));
        }
        if(DriverInstance.getVariable("Details_Entry").equalsIgnoreCase("Y")) {
            if (!Length.equalsIgnoreCase("NA")) {
                webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("Length").replace("index", Line_Item)), Length);
                webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("Width").replace("index", Line_Item)), Width);
            }
            if (!Width.equalsIgnoreCase("NA")) {
                webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("Width").replace("index", Line_Item)), Width);
            }
            if(!Height.equalsIgnoreCase("NA"))
            {
                webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("Height").replace("index", Line_Item)), Height);
            }
            if (!Dimension_Unit.equalsIgnoreCase("NA")) {
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Dimension_Unit").replace("index", Line_Item)));
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SelectDimensionUnit").replace("{paramlink}", Dimension_Unit).replace("index", Line_Item)));

            }
            if (!NMFC_Class.equalsIgnoreCase("NA")) {
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("NMFC_Class").replace("index", Line_Item)));
//                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SelectNMFC_Class").replace("{paramlink}", NMFC_Class).replace("index", Line_Item)));
                webDriver.SelectComboBoxOption(webDriver.getwebelement(xml.getlocator("SelectNMFC_Class1").replace("index", Line_Item)),webDriver.getwebelement(xml.getlocator("SelectNMFC_Class2").replace("{paramlink}", NMFC_Class).replace("index", Line_Item)));
            }
            if (Integer.parseInt(DriverInstance.getVariable("Total_Stops")) > 2) {
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Pickup_Stop").replace("index", Line_Item)));
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Select_Pickup_Stop").replace("{paramlink}", PickUp).replace("index", Line_Item)));
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Delivery_Stop").replace("index", Line_Item)));
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Select_Delivery_Stop").replace("{paramlink}", Delivery).replace("index", Line_Item)));
            }
        }
    }

   @Then ("Save Load With All details")
   public void SaveLoad() throws Exception {
        Thread.sleep(1000);
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SaveBtn")));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SaveBtn")));
        try {
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}", "Success - Load Configuration")));
//            webDriver.verifyElementToBePresent(xml.getlocator("DivText").replace("{paramlink}", "Success - Load Configuration"));
        }
        catch(Exception e)
        {
           if(webDriver.getwebelementscount(xml.getlocator("ReuiredDateError"))>1) {
               WebElement element = webDriver.getwebelement(xml.getlocator("Expected_Date").replace("{paramlink}", DriverInstance.getVariable("Type")));
               try {
                   webDriver.ClearAndEnterDate(element, webDriver.ExpectedDate(DriverInstance.getVariable("Type")+DriverInstance.getVariable("Expected_Date")));
                   System.out.println("0");
               } catch (Exception ee) {
                   webDriver.ClearAndEnterDate(element, webDriver.ExpectedDate(DriverInstance.getVariable("Type")+DriverInstance.getVariable("Expected_Date")));
               }

               webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SaveBtn")));
               webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SaveBtn")));
               webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}", "Success - Load Configuration")));
               webDriver.verifyElementToBePresent(xml.getlocator("DivText").replace("{paramlink}", "Success - Load Configuration"));
           }
        }

        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("GetLoadNumber")));
        String loadnum= webDriver.getText(webDriver.getwebelement(xml.getlocator("GetLoadNumber")));
        DriverInstance.setVariable(DriverInstance.getVariable("LoadNum"),loadnum);
        ExtentCucumberAdapter.getCurrentStep().info("Created Load ID: "+loadnum);
        String CurrentURL = webDriver.CurrentURL();
        String recordId = StringUtils.substringBetween(CurrentURL, "/rtms__Load__c/", "/view");
        System.out.println("Record_Id: "+recordId);
        DriverInstance.setVariable(DriverInstance.getVariable("LoadNum")+"RI",recordId);
        ExtentCucumberAdapter.getCurrentStep().info("Record_Id: "+recordId);
        DriverInstance.setVariable(DriverInstance.getVariable("LoadNum")+"_LoadURL",webDriver.CurrentURL());
   }
    @Then("Open Load with {string}")
    public void openLoadWith(String arg0) {
        webDriver.GOto(DriverInstance.getVariable(arg0));
    }

    @Then ("Save Load")
    public void SaveLoad1() throws Exception {
        Thread.sleep(1000);
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SaveBtn")));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SaveBtn")));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SaveBtn")));
    }
        public String ReturnDate(String P_Expected_Date)  {
        String formattedDate;
        LocalDate tomorrow;
        if(P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            tomorrow = LocalDate.now().plusDays(1);
        }
        else{
            tomorrow = LocalDate.now().plusDays(Integer.parseInt(P_Expected_Date));

        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        formattedDate = tomorrow.format(formatter);
        System.out.println(formattedDate);
        return formattedDate;
    }
    public static void log(String message)
    {
        System.out.println(message);
        ExtentCucumberAdapter.addTestStepLog("<table style='color:DarkGreen;'><tr><td><b>"+message+"</b></td></tr><tr></table>");

    }


    @Then("Open {string} Created Load from List")
    public void openCreatedLoadFromList(String arg0) throws DocumentException, InterruptedException {
        String Load = DriverInstance.getVariable(arg0);
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}", Load)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}", Load)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}", Load)));

    }

    @Then("Open Load Number {string}")
    public void openLoadNumber(String arg0)throws DocumentException, InterruptedException {

        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}", arg0)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}", arg0)));
        DriverInstance.setVariable("1L",arg0);


//        DriverInstance.setVariable("Carrier_Service","Estes Express - SMC3");
    }

    @Then("Execute Load {string} Clone with count {string} and Customer Quote as {string} and Carrier Quote as {string}")
    public void executeLoadCloneWithCountAndCustomerQuoteAsTrueFalse(String load, String arg0, String arg1, String arg2) throws Throwable {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("CloneButton")));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("CloneButton")));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("CloneButton")));
        switchToFrameByTitle("accessibility title");
        if(!arg0.equalsIgnoreCase("1")) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("NoOfCopy")));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("NoOfCopy")));
            webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("NoOfCopy")), arg0);
        }
         if(arg1.equalsIgnoreCase("True"))
         {
             webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("QuoteCheckbox").replace("{paramlink}", "Customer Quote")));
             webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("QuoteCheckbox").replace("{paramlink}", "Customer Quote")));
             webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("QuoteCheckbox").replace("{paramlink}", "Customer Quote")));

         }
        if(arg2.equalsIgnoreCase("True"))
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("QuoteCheckbox").replace("{paramlink}", "Carrier Quote")));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("QuoteCheckbox").replace("{paramlink}", "Carrier Quote")));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("QuoteCheckbox").replace("{paramlink}", "Carrier Quote")));

        }
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputValue").replace("{paramlink}", "Create")));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("InputValue").replace("{paramlink}", "Create")));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("InputValue").replace("{paramlink}", "Create")));
        switchToFrameByTitle("accessibility title");
        webDriver.waitForElementLoad(5);
        int count;
        do{
            count= webDriver.getwebelementscount(xml.getlocator("TotalCount"));
            webDriver.waitForElementLoad(3);
         }
         while (count<Integer.parseInt(arg0)+1);

         for (int i=2;i<=Integer.parseInt(arg0)+1;i++)
         {
             webDriver.scrollDownWithJS(4);
            String cloneLoad= webDriver.GetText(webDriver.getwebelement(xml.getlocator("CloneLoad").replace("index", String.valueOf(i))));
//             String cloneLoad = "";
//
//             for (int retry = 0; retry < 3; retry++) {
//                 try {
//                     WebElement element = webDriver.getwebelement(
//                             xml.getlocator("CloneLoad").replace("index", String.valueOf(i))
//                     );
//                     cloneLoad = element.getText();
//                     break;
//
//                 } catch (StaleElementReferenceException e) {
//                     Thread.sleep(500);
//                 }
//             }
             String LoadSFID= webDriver.GetDomAttribute(webDriver.getwebelement(xml.getlocator("CloneLoad").replace("index", String.valueOf(i))),"href");
            String LoadId = extractSalesforceRecordId(LoadSFID);
            DriverInstance.setVariable(load+ (i - 1) +"C",cloneLoad);
            DriverInstance.setVariable(load+ (i - 1) +"CRI",LoadId);
            System.out.println(load+ (i - 1) +"C:" + cloneLoad);
            System.out.println(load+ (i - 1) +"CRI:" + LoadId);
            webDriver.waitForElementLoad(1);
         }

        switchToParentFrame();
        }
    @Then("Open Last Load from Cloned Load")
    public void openLastLoadFromClonedLoad() throws DocumentException, InterruptedException {
        switchToFrameByTitle("accessibility title");
        int count=  webDriver.getwebelementscount((xml.getlocator("TotalCloneLoad")));
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("CloneLoad").replace("index", String.valueOf(count))));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("CloneLoad").replace("index", String.valueOf(count))));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("CloneLoad").replace("index", String.valueOf(count))));
        switchToParentFrame();
    }

    public String extractSalesforceRecordId(String hrefValue) {
        Pattern pattern = Pattern.compile("(a2[A-Za-z0-9]{16})");
        Matcher matcher = pattern.matcher(hrefValue);
        return matcher.find() ? matcher.group(1) : null;
    }
    @Then("Search and Select Load {string}")
    public void searchAndSelectLoad(String arg0) throws DocumentException, InterruptedException, IOException {
//        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", "Search this list...")));
//        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", "Search this list...")));
//        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", "Search this list...")),DriverInstance.getVariables().get(arg0));
//

    }

    public void switchToFrameByTitle(String arg0) throws DocumentException, InterruptedException {
        webDriver.SwitchToParentFrame();
        webDriver.SwitchToFrameByElement(webDriver.getwebelement(xml.getlocator("IframeTitle").replace("{paramlink}", arg0)));
    }

    public void switchToParentFrame() {
        webDriver.SwitchToParentFrame();
    }

    @Then("Enter {string} as {string} on {string} Stop")
    public void enterAsOnStop(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException, IOException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", arg2).replace("{paramlink2}", arg0)));
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("LocationField").replace("{paramlink1}", arg2).replace("{paramlink2}", arg0)), arg1);

    }

    @Then("Click into field {string} within {string} and click out")
    public void clickIntoFieldWithinAndClickOut(String fieldName, String stopName) throws Exception {
        WebElement element = webDriver.getwebelement(xml.getlocator("LabelTextInput").replace("{paramlink1}", stopName).replace("{paramlink2}", fieldName));
        webDriver.ScrollIntoView(element);
        webDriver.Clickon(element);
        Thread.sleep(1000);
        element.sendKeys(org.openqa.selenium.Keys.TAB);
        Thread.sleep(1000);
    }


    @Then("Verify {string} icon and {string} {string} with Title {string} are displaying")
    public void verifyColorWithTitleAreDisplaying(String arg0, String arg1, String arg2, String arg3) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("VerifyImage").replace("{paramlink1}", arg2).replace("{paramlink2}", arg3)));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyImage").replace("{paramlink1}", arg2).replace("{paramlink2}", arg3));
        WebElement wl = webDriver.getwebelement(xml.getlocator("VerifyImage").replace("{paramlink1}", arg2).replace("{paramlink2}", arg3));
        String color=wl.getCssValue("color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" Color is: "+bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("Color Name: " + colorName);
        webDriver.Stringcomparator(colorName,arg1);
        WebElement wl2 = webDriver.getwebelement(xml.getlocator("VerifyImage").replace("{paramlink1}", arg2).replace("{paramlink2}", arg3)+"/..");
        String imgbackgroundcolor=wl2.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: "+bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1,arg0);
    }

    @Then("Verify {string} Color with {string} Text of {string} Button is {string}")
    public void verifyColorWithTextOfButtonIs(String arg0, String arg1, String arg2, String arg3) throws DocumentException, InterruptedException {
        String Locators;
        if( arg2.charAt(arg2.length() - 2) == '_')
        {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = "("+xml.getlocator("VerifyButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "true")+")["+arg2.charAt(arg2.length() - 1)+"]";
            } else {
                Locators = "("+xml.getlocator("VerifyButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "false")+")["+arg2.charAt(arg2.length() - 1)+"]";
            }
        }
        else {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = xml.getlocator("VerifyButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "true");
            } else {
                Locators = xml.getlocator("VerifyButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "false");
            }
        }
           webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(Locators));
           webDriver.verifyElementToBePresent(Locators);
            System.out.println(Locators);
            WebElement wl = webDriver.getwebelement(Locators);
            String color = wl.getCssValue("color");
            String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
            java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
            System.out.println(" Color is: " + bgcolor);
            String colorName = ColorUtils.getClosestColorName(
                    bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
            System.out.println("Color Name: " + colorName);
            webDriver.Stringcomparator(colorName, arg1);

            WebElement wl2 = webDriver.getwebelement(Locators + "/..");
            String imgbackgroundcolor = wl.getCssValue("background-color");
            String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
            java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
            System.out.println("Color is: " + bgcolor1);
            System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
            String colorName1 = ColorUtils.getClosestColorName(
                    bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
            System.out.println("Color Name: " + colorName1);
            webDriver.Stringcomparator(colorName1, arg0);
    }
    @Then("Verify {string} Color with {string} Text of {string} Button")
    public void verifyColorWithTextOf(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        String Locators;
        Locators = xml.getlocator("GlobalText").replace("{paramlink}", arg2);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(Locators));
        webDriver.verifyElementToBePresent(Locators);
        System.out.println(Locators);
        WebElement wl = webDriver.getwebelement(Locators);
        String color = wl.getCssValue("color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" Color is: " + bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("Color Name: " + colorName);
        webDriver.Stringcomparator(colorName, arg1);

        WebElement wl2 = webDriver.getwebelement(Locators + "/..");
        String imgbackgroundcolor = wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg0);
    }
    @Then("Verify {string} Text with {string} Color is displaying")
    public void verifyTextColor(String arg0, String arg1) throws DocumentException, InterruptedException {
        String Locators;
        if( arg0.charAt(arg0.length() - 2) == '_')
        {
            Locators = "("+xml.getlocator("GlobalText").replace("{paramlink}", arg0.split("_")[0])+")["+arg0.charAt(arg0.length() - 1)+"]";
        }
        else {
            Locators = xml.getlocator("GlobalText").replace("{paramlink}", arg0);
        }
        WebElement wl = webDriver.getwebelement(Locators);
        String color = wl.getCssValue("color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" Color is: " + bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("Color Name: " + colorName);
        webDriver.Stringcomparator(colorName, arg1);
    }
    @Then("Verify Layout {string} Text with Background Color {string} is displaying")
    public void verifyTextBackGroundColor(String arg0, String arg1) throws DocumentException, InterruptedException {
        String Locators;
        if( arg0.charAt(arg0.length() - 2) == '_')
        {
            Locators = "("+xml.getlocator("LayOutText").replace("{paramlink}", arg0.split("_")[0])+")["+arg0.charAt(arg0.length() - 1)+"]";
        }
        else {
            Locators = xml.getlocator("LayOutText").replace("{paramlink}", arg0);
        }
        WebElement wl = webDriver.getwebelement(Locators);
        String color = wl.getCssValue("background-color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" background-color is: " + bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("background-color Name: " + colorName);
        webDriver.Stringcomparator(colorName, arg1);
    }

    @Then("Verify {string} Text with Background Color {string} is displaying on Modal")
    public void verifySpanTextBackGroundColor(String arg0, String arg1) throws DocumentException, InterruptedException {
        String Locators = xml.getlocator("SpanTextModal").replace("{paramlink}", arg0);
        WebElement wl = webDriver.getwebelement(Locators);
        String color = wl.getCssValue("background-color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" background-color is: " + bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("background-color Name: " + colorName);
        webDriver.Stringcomparator(colorName, arg1);
    }

    @Then("Verify Text {string} not displaying on modal")
    public void VerifyLinkTextOnPage(String arg0)throws Exception {
       webDriver.verifyElementNotToBePresent(xml.getlocator("SpanTextModal").replace("{paramlink}", arg0));

    }

    @Then("Verify {string} button is displaying with Title {string}")
    public void verifyButtonIsDisplayingWithTitle(String arg0, String arg1) throws DocumentException, InterruptedException {
       String Locators = xml.getlocator("VerifyButtonIcon").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1);
       webDriver.ScrollIntoView(webDriver.getwebelement(Locators));
       webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(Locators));
       webDriver.verifyElementToBePresent(Locators);
    }
    @Then("Verify Second {string} button is displaying with Title {string}")
    public void verifyButtonIsDisplayingWithTitleSecond(String arg0, String arg1) throws DocumentException, InterruptedException {
        String Locators = xml.getlocator("VerifyButtonIcon2").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1);
        webDriver.ScrollIntoView(webDriver.getwebelement(Locators));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(Locators));
        webDriver.verifyElementToBePresent(Locators);
    }

    @Then("Verify {string} color with {string} data key and Title {string} are displaying")
    public void verifyIconAndDataKeyWithTitleAreDisplaying(String arg0, String arg2, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("VerifyIcon").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("VerifyIcon").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2)));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyIcon").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2));
        WebElement wl2 = webDriver.getwebelement(xml.getlocator("VerifyIcon").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2));
        String imgbackgroundcolor=wl2.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: "+bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1,arg0);
    }


    @Then("Add {string} location at {string}")
    public void addLocationAt(String arg0, String arg1) throws Exception {
        int index= Integer.parseInt(String.valueOf(arg1.charAt(0)));
        String locationType=String.valueOf(arg1.charAt(1));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddLocation").replace("index",String.valueOf(index))));
        if(arg0.trim().equals("Pickup"))
        {
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddPickup").replace("index",String.valueOf(index))));
        }
        else if(arg0.trim().equals("Delivery"))
        {
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("AddDelivery").replace("index",String.valueOf(index))));

        }
        else{
            Assert.fail("You have passed incorrect location type!!");
        }
    }


    @Then("Click on Move Stops action for Stop {string}")
    public void clickOnMoveStopsActionForStop(String arg0) throws Exception {
        int index= Integer.parseInt(String.valueOf(arg0.charAt(0)));
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("MoveStop").replace("{index}",String.valueOf(index))));
        webDriver.Clickon(webDriver.passwebelement(xml.getlocator("MoveStop").replace("{index}",String.valueOf(index))));
    }
    @Then("Verify {string} action is displaying with Stop {string}")
    public void verifyActionIsDisplayingWithStop(String arg0, String arg1) throws DocumentException, InterruptedException {
       webDriver.verifyElementToBePresent(xml.getlocator("VerifyUpDownStop").replace("{paramlink}",arg0).replace("{index}",arg1));
    }

    @Then("Verify Title {string} is displaying with Stop {string}")
    public void verifyTitleIsDisplayingWithStop(String arg0, String arg1) throws DocumentException, InterruptedException {
       String title= webDriver.Getattribute(webDriver.passwebelement(xml.getlocator("VerifyUpDownStop").replace("{paramlink}",arg0).replace("{index}",arg1)),"title");
       Assert.assertEquals(title,arg0);
    }

    @Then("Click on {string} action is displaying with Stop {string}")
    public void ClickOnActionIsDisplayingWithStop(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("VerifyUpDownStop").replace("{paramlink}",arg0).replace("{index}",arg1)));
    }

    @Then("Verify Stop Name of Stop {string} is {string} with date {string}")
    public void verifyStopNameOfStopIsWithDate(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        String text=webDriver.GetText(webDriver.passwebelement(xml.getlocator("VerifyStopText").replace("{index}",arg0))).replaceAll("\\s+", " ").trim();;
        System.out.println(text);
        if(arg2.equalsIgnoreCase("NA"))
        {
            webDriver.Stringcomparator(text, arg1);
        }
        else {
            String Date = webDriver.ReturnDateInSpecifiedFormat(arg2, "yyyy-MM-dd");
            webDriver.Stringcomparator(text, arg1 + " " + Date);
        }
    }
    @Then("Verify button with Text {string} on Modal")
    public void verifyButtonWithTextOnModal(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("VerifyButtonOnModal").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyButtonOnModal").replace("{paramlink}", arg0));

    }
    @Then("Verify button with Text {string} not displaying on Modal")
    public void verifyButtonWithTextnotOnModal(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("VerifyButtonOnModal").replace("{paramlink}", arg0));

    }
    @Then("Click button with Text {string} on Modal")
    public void ClickButtonWithTextOnModal(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitforElementtobeclickable(xml.getlocator("VerifyButtonOnModal").replace("{paramlink}", arg0));
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("VerifyButtonOnModal").replace("{paramlink}", arg0)));
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("VerifyButtonOnModal").replace("{paramlink}", arg0)));
    }
    @Then("Verify Load Stop details for {string}")
    public void verifyDetailsForDisabledService(String StopName,DataTable dt) throws Exception {

        validateLoadStopsData(StopName,dt);
    }
    public void validateLoadStopsData(String StopName, DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                    fieldName = webDriver.passwebelement(xml.getlocator("LabelTextLoadStop").replace("{Stop}",StopName).replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);

                WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();

                String type = element.getAttribute("type");

                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {

                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {

                        String ActualText = webDriver.Getattribute(element, "value");
                        System.out.println("Actual Test:" + ActualText);
                        Boolean enabled = element.isEnabled();
                        Boolean readonly = Boolean.valueOf(webDriver.Getattribute(element, "readonly"));
                        System.out.println("Read only Value" + readonly);
                        System.out.println("Enable Value" + enabled);
                        System.out.println("Enable Value" + enabled);
                        if (entry.getKey().contains("Date")) {
                            if(entry.getValue().contains(",")||entry.getValue().contains("/"))
                            {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                            else{
                                webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                            }
                        }
                        else {
                            webDriver.Partialstringcomparator(ActualText, entry.getValue());
                        }
                    }
                    else{
                        String ActualText = webDriver.Getattribute(element, "value");
                        webDriver.Stringcomparator(ActualText, "");

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    webDriver.Stringcomparator(ActualText, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    //   webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
//                    String ActualText = webDriver.getAttributeValueUsingJavascript(element);
                    String ActualText = webDriver.Getattribute(element, "value");
                    String actualSize = "0";
                    String expectedSize = "0";
                    try {
                        actualSize = String.valueOf(ActualText.length());
                    } catch (NullPointerException e) {
                        actualSize = "0";
                    }

                    try {
                        expectedSize = String.valueOf(entry.getValue().length());
                    } catch (NullPointerException e) {
                        expectedSize = "0";
                    }
                    webDriver.Stringcomparator(actualSize, expectedSize);
//                    webDriver.Stringcomparator(ActualText, entry.getValue());
//                    Assert.assertNotNull(ActualText, "Password Fields has some value");

                    System.out.println("Current Fields:" + entry.getKey() + " is Encrypted as this is Password type Element");

                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {
                    //    webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));

                    boolean isChecked  = "true".equalsIgnoreCase(element.getAttribute("aria-checked"));
                    System.out.println( isChecked+"" +new Date());
                    if (isChecked) {
                        System.out.println("Checkbox is checked");
                    } else {
                        System.out.println("Checkbox is unchecked");
                    }
//                    Assert.assertEquals(isChecked, Boolean.valueOf(entry.getValue()));
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    // Create a Select object
                    Select select = new Select(element);
                    String selectedText = select.getFirstSelectedOption().getText();
                    System.out.println("Selected Text: " + selectedText);
                    webDriver.Stringcomparator(selectedText, entry.getValue());
                }
            }
        }
    }


    @Then("Select {string} Country as {string}")
    public void selectCountryAs(String arg0, String arg1) throws Exception {
        webDriver.waitUntilElementIsVisible(xml.getlocator("Select_Country").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Select_Country").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
        webDriver.SelectComboBoxOption(webDriver.passwebelement(xml.getlocator("Select_Country1").replace("{paramlink}", arg0)), webDriver.passwebelement(xml.getlocator("Select_Country1_Text").replace("{paramlink}", arg0).replace("{paramlink1}", arg1)));

    }

    @Then("Click on {string} under Containers Section")
    public void clickOnUnderContainersSection(String arg0) throws DocumentException, InterruptedException {
        String locator = xml.getlocator("ContainersAddIcon").replace("{paramlink}", arg0);
        List<WebElement> elements = webDriver.getwebelements(locator);
        for (WebElement element : elements) {
            if (element.isDisplayed()) {
                webDriver.waitForElementToBeClickable(element);
                webDriver.ScrollIntoView(element);
                webDriver.ClickOnElement(element);
                break;
            }
        }
    }

    @Then("Update container details")
    public void updateContainerDetails(DataTable dt) throws Exception {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            for (int i = 0; i < dataRows.size(); i++) {
                Map<String, String> details = dataRows.get(i);

                for (Map.Entry<String, String> entry : details.entrySet()) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    String fieldName;
                    String Key = "";
                    String labelText = Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey());
                    List<WebElement> labels = webDriver.waitUntilVisibleAndReturnElements(labelText);
                    fieldName = labels.get(i).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(labelText);
                    String formFields = Generic.getlocator("FormFields").replace("{paramlink}", fieldName);
                    //List<
                    WebElement element = webDriver.getwebelement(formFields);

                    webDriver.ScrollIntoView(element);
                    String Tag = element.getTagName();
                    System.out.println(Tag);
                    String type = element.getAttribute("type");
                    System.out.println(type);
                    String role = element.getAttribute("role");
                    if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                        webDriver.ScrollIntoView(element);
                        webDriver.Clear(element);
                        webDriver.EnterTextUsingJS(element, entry.getValue());
                    } else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                        webDriver.ScrollIntoView(element);
                        webDriver.waitForElementLoad(1);
                        String ActualText = webDriver.Getattribute(element, "data-value");
                        if (ActualText.equalsIgnoreCase("")) {
                            webDriver.Clickon(element);
                            webDriver.SendKeys(element, entry.getValue());

                            webDriver.Clickon(element);
                            webDriver.waitForElementLoad(3);
                            String titleWithLabel = Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey()).replace("{paramlink2}", entry.getValue());
                            List<WebElement> buttonTitles = webDriver.getWebElements(titleWithLabel);
                            webDriver.waitForElementToBeClickable(buttonTitles.get(i));
                            webDriver.Clickon(buttonTitles.get(i));
                        }
                    }
                }
                if(i>=0 &&i < dataRows.size()-1){
                    clickOnUnderContainersSection("Add");
                }
            }
        }
    }

    @Then("Verify Text containing {string} with {string} Color is displaying")
    public void verifyTextContainingWithColorIsDisplaying(String arg0, String arg1) throws DocumentException, InterruptedException {
        String Locators;
        if( arg0.charAt(arg0.length() - 2) == '_')
        {
            Locators = "("+xml.getlocator("GlobalTextContains").replace("{paramlink}", arg0.split("_")[0])+")["+arg0.charAt(arg0.length() - 1)+"]";
        }
        else {
            Locators = xml.getlocator("GlobalTextContains").replace("{paramlink}", arg0);
        }
        WebElement wl = webDriver.getwebelement(Locators);
        String color = wl.getCssValue("color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" Color is: " + bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("Color Name: " + colorName);
        webDriver.Stringcomparator(colorName, arg1);
    }
}
