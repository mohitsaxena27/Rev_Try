package pageHelper.Utility;

import bddRunner.Web;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.restassured.path.json.JsonPath;
import lombok.extern.log4j.Log4j;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.InputSource;
import org.openqa.selenium.interactions.SourceType;
import org.stringtemplate.v4.ST;
import org.testng.Assert;
import org.xmlunit.builder.DiffBuilder;
import org.xmlunit.builder.Input;
import org.xmlunit.diff.Diff;
import pageHelper.bddDriver;
import utils.*;
import utils.Xml.XML_Utils;
import utils.Xml.XmlComparisonUtil;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.io.InputStream;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.openqa.selenium.devtools.v129.dom.DOM.removeNode;
import static org.python.indexer.Util.readFile;

@Log4j
public class Handing_Request_Response {
    public webHelper webDriver;
    public apiHelper apiDriver;

    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader iframexml;
    public PropertyReader propertyReader = new PropertyReader();

    public Handing_Request_Response(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        System.out.println("this.DriverInstance");
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver=new baseDriverHelper(DriverInstance.getApiDriver(),DriverInstance.API_RESPONCE_THREAD_LOCAL.get());

        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        iframexml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
    }
    @And("{string} and Close all the Toast messages from Bottom")
    public void captureAllTheToastMessages1(String args) throws Exception {
        try {
            webDriver.waitUntilElementIsVisible(xml.getlocator("ToastMessagesList"));
        }
        catch (Exception e)
        {
            System.out.println("Seems like Debugging message not displayed");
        }
        Common_Steps cm= new Common_Steps(DriverInstance);
        cm.StoreSuccessMessage();
        Thread.sleep(5000);
        long idleStart = System.currentTimeMillis();
        System.out.println("Current milisecods: "+idleStart);
        long idleTimeout = 2000; // stop if no new toast for 10s
        List<String> currentGroup = new ArrayList<>();
        List<ApiToast> capturedApis = new ArrayList<>();
        while (true) {
            List<WebElement> toasts = webDriver.getWebElements(xml.getlocator("Toastmessage"));
            System.out.println("Number of elements: " + toasts.size());

            if (!toasts.isEmpty()) {
                if (args.equalsIgnoreCase("Capture")) {
                    for (int i = toasts.size(); i > 0; i--) {
                        cm.StoreSuccessMessage();
                        cm.StoreWarningMessage();
                        try {
                            // Print toast text
//                            String message = toasts.get(i-1).getText();
                            String message = webDriver.getOverlayText(toasts.get(i-1));
                            System.out.println("Current Focused Toast " + message);

                            if (message.contains("REQUEST BODY")) {

                                System.out.println("REQUEST Toast message: " + message.replace(
                                        "REQUEST BODY: ", ""));
                                currentGroup.add(message.replace(
                                        "REQUEST BODY: ", ""));

                            }
                            else if (message.contains("RESPONSE BODY")) {
                                System.out.println("RESPONSE Toast message: " + message.replace(
                                        "RESPONSE BODY: ", ""));
                                currentGroup.add(message.replace(
                                        "RESPONSE BODY: ", ""));
//                        DriverInstance.setVariable("Response_Payload", message.replace(
//                                "RESPONSE BODY: ", ""));
                            }
                            else if (message.contains("REQUEST URL:")) {
                                System.out.println("REQUEST URL Toast message: " + message.replace(
                                        "REQUEST URL: ", ""));
                                currentGroup.add(message.replace(
                                        "REQUEST URL: ", ""));
//                        DriverInstance.setVariable("Response_Payload", message.replace(
//                                "REQUEST URL: ", ""));
                            }
                            if (currentGroup.size() == 3) {
                                ApiToast api = new ApiToast();
                                api.requestBody = currentGroup.get(0);
                                api.url = currentGroup.get(1);
                                api.response = currentGroup.get(2);
                                capturedApis.add(api);
                                currentGroup.clear(); // ready for next API
                            }
                            Thread.sleep(3000);
                            int Current_tosetnumber=i+1;
                            try {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("toastclose")));
                                Thread.sleep(2000);
                            } catch (Exception e) {
                                System.out.println("Unable to close the Toast");
                                                          }
                            // Wait a little for DOM update
                            Thread.sleep(1000);
                        } catch (Exception e) {
                            System.out.println("Error handling toast: " + e.getMessage());
                        }
                    }

                }
                else if (args.equalsIgnoreCase("Without Capture")) {
                    for (WebElement toast : toasts) {
                        cm.StoreSuccessMessage();
                        cm.StoreWarningMessage();
                        try {
                            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("toastclose")));
                        } catch (Exception e) {
                            System.out.println("Closed Toast");
//                            Thread.sleep(1000);
//                            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("toastclose")));
                        }
                        // Wait a little for DOM update
                        Thread.sleep(2000);
                    }

                }

            }
            else {
                // No toasts currently present
                if (System.currentTimeMillis() - idleStart > idleTimeout) {
                    break; // stop if idle too long
                }
                Thread.sleep(500); // small pause before checking again
            }
        }
        for (ApiToast api : capturedApis) {
            System.out.println("----- API -----\n"+api.url);
            Pattern pattern = Pattern.compile("^(https?://\\S+)");
            Matcher matcher = pattern.matcher(api.url);
            String url="";
            if (matcher.find()) {
                url = matcher.group(1);
                System.out.println("Extracted URL: " + url);
            }
            System.out.println(api);
     //     String Varname=url.substring(url.lastIndexOf("/")+1);
            DriverInstance.setVariable(url+"_Request_Payload",api.requestBody);
            DriverInstance.setVariable(url+"_Response_Body",api.response);

            String Varname;

            if ("Project44 Customer".equalsIgnoreCase(DriverInstance.getVariable("Customer")))
            {
                if(api.requestBody.contains("CustA") && api.requestBody.contains("capacityProviderAccountGroup"))
                {
                    Varname="CustA";
                }
                else if(api.requestBody.contains("HYBRID")&& api.requestBody.contains("capacityProviderAccountGroup"))
                {
                    Varname="HYBRID";
                }
                else{
                    Varname = url.substring(url.lastIndexOf("/") + 1);
                }
            }
            else if ("SMC3 EVA Customer".equalsIgnoreCase(DriverInstance.getVariable("Customer")))
            {
                if(api.url.contains("status/SMCA"))
                {
                    Varname="SMCA_Status";
                }
                else if(api.url.contains("documentType") && api.url.contains("fileType"))
                {
                    Varname="document";
                }
                else if(api.url.contains("carriers/SMCA"))
                {
                    Varname="SMCA_Carrier";
                }
                else{
                    Varname = url.substring(url.lastIndexOf("/") + 1);
                }
            }
            else if (api.url.contains("revenova.com")&&api.url.contains("pricing/aggregate"))
            {
                    Varname = "Logging";
            }
            else if (url.contains("post-loads?") && url.contains("ServiceKey"))
            {
                Varname = "post-loads";
            }
            else if (api.url.contains("https://api.axleapi.com/v1/trip/"))
            {
                Varname = "Catena";
            } else {
                Varname = url.substring(url.lastIndexOf("/") + 1);
            }
            DriverInstance.setVariable(Varname+"_Request_Payload",api.requestBody);
            System.out.println(Varname+"_Request_Payload : "+api.requestBody);
            DriverInstance.setVariable(Varname+"_Response_Body",api.response);
            System.out.println("api.url"+api.url);
            DriverInstance.setVariable(Varname+"_Url",api.url.split(" - ")[0].trim());
            Thread.sleep(3000);

        }
        DriverInstance.setVariable("CapturedMessage","Reset");
    }


    @And("{string} and Close all messages from Bottom")
    public void captureAllTheMessages1(String args) throws Exception {
        Thread.sleep(6000);
        try {
            webDriver.waitUntilElementIsVisible(xml.getlocator("Toastmessage"));
        }
        catch(Exception e)
        {
            System.out.println("No Log Available");
        }
        long idleStart = System.currentTimeMillis();
        System.out.println("Current milisecods: "+idleStart);
        long idleTimeout = 2000; // stop if no new toast for 10s
        Map<String, ApiToast> apiMap = new LinkedHashMap<>();
        ApiToast currentApi = null;
        while (true) {
            List<WebElement> toasts = webDriver.getWebElements(xml.getlocator("Toastmessage"));
            System.out.println("Number of elements: " + toasts.size());

            if (!toasts.isEmpty()) {
                if (args.equalsIgnoreCase("Capture")) {
                    for (int i = toasts.size(); i > 0; i--) {
                        Common_Steps cm= new Common_Steps(DriverInstance);
                        cm.StoreSuccessMessage();
                        cm.StoreWarningMessage();
                        try {
                            String message = webDriver.getOverlayText(toasts.get(i-1));
                            System.out.println("Current Focused Toast " + message);

                            if (message.contains("REQUEST URL")) {
                                String url = message.replace("REQUEST URL:", "").trim();
                                currentApi = new ApiToast();
                                currentApi.url = url;
                                apiMap.put(url, currentApi);
                                System.out.println("REQUEST URL : " + url);
                            }
                            else if (message.contains("REQUEST BODY")) {

                                String request =
                                        message.replace("REQUEST BODY:", "").trim();

                                if (currentApi != null) {
                                    currentApi.requestBody = request;
                                }

                                System.out.println("REQUEST BODY : " + request);

                            }
                            else if (message.contains("RESPONSE BODY")) {

                                String response =
                                        message.replace("RESPONSE BODY:", "").trim();

                                if (currentApi != null) {
                                    currentApi.response = response;
                                }

                                System.out.println("RESPONSE BODY : " + response);
                            }
                            else if (message.contains("ADDRESS:")) {
                                DriverInstance.setVariable("AddressLine",message.replace("ADDRESS:", "").trim());
                            }

                            Thread.sleep(3000);
                            int Current_tosetnumber=i+1;
                            try {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("toastclose")));
                                Thread.sleep(2000);
                            } catch (Exception e) {
                                System.out.println("Unable to close the Toast");
                            }
                            // Wait a little for DOM update
                            Thread.sleep(1000);
                        } catch (Exception e) {
                            System.out.println("Error handling toast: " + e.getMessage());
                        }
                    }

                }
                else if (args.equalsIgnoreCase("Without Capture")) {
                    for (WebElement toast : toasts) {
                        Common_Steps cm= new Common_Steps(DriverInstance);
                        cm.StoreSuccessMessage();
                        cm.StoreWarningMessage();
                        try {
                            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("toastclose")));
                        } catch (Exception e) {
                            System.out.println("Closed Toast");
                       }
                        // Wait a little for DOM update
                        Thread.sleep(2000);
                    }

                }

            }
            else {
                // No toasts currently present
                if (System.currentTimeMillis() - idleStart > idleTimeout) {
                    break; // stop if idle too long
                }
                Thread.sleep(500); // small pause before checking again
            }
        }
        List<ApiToast> capturedApis = new ArrayList<>(apiMap.values());

        for (ApiToast api : capturedApis) {
            System.out.println("----- API -----\n"+api.url);
            Pattern pattern = Pattern.compile("^(https?://\\S+)");
            Matcher matcher = pattern.matcher(api.url);
            String url="";
            if (matcher.find()) {
                url = matcher.group(1);
                System.out.println("Extracted URL: " + url);
            }
            System.out.println(api);
            //     String Varname=url.substring(url.lastIndexOf("/")+1);
            DriverInstance.setVariable(url+"_Request_Payload",api.requestBody);
            DriverInstance.setVariable(url+"_Response_Body",api.response);

            String Varname;

            if ("Project44 Customer".equalsIgnoreCase(DriverInstance.getVariable("Customer")))
            {
                if(api.requestBody.contains("CustA") && api.requestBody.contains("capacityProviderAccountGroup"))
                {
                    Varname="CustA";
                }
                else if(api.requestBody.contains("HYBRID")&& api.requestBody.contains("capacityProviderAccountGroup"))
                {
                    Varname="HYBRID";
                }
                else{
                    Varname = url.substring(url.lastIndexOf("/") + 1);
                }
            }
            else if ("SMC3 EVA Customer".equalsIgnoreCase(DriverInstance.getVariable("Customer")))
            {
                if(api.url.contains("status/SMCA"))
                {
                    Varname="SMCA_Status";
                }
                else if(api.url.contains("documentType") && api.url.contains("fileType"))
                {
                    Varname="document";
                }
                else if(api.url.contains("carriers/SMCA"))
                {
                    Varname="SMCA_Carrier";
                }
                else{
                    Varname = url.substring(url.lastIndexOf("/") + 1);
                }
            }
            else if (api.url.contains("revenova.com")&&api.url.contains("pricing/aggregate"))
            {
                Varname = "Logging";
            }
            else if(api.url.contains("randmcnally.com") && api.url.contains("routetype"))
            {
                Varname="randmcnally_routetype";
            }
            else if (url.contains("post-loads?") && url.contains("ServiceKey"))
            {
                Varname = "post-loads";
            }
            else if (api.url.contains("https://api.axleapi.com/v1/trip/"))
            {
                Varname = "Catena";
            } else {
                Varname = url.substring(url.lastIndexOf("/") + 1);
            }
            DriverInstance.setVariable(Varname+"_Request_Payload",api.requestBody);
            System.out.println(Varname+"_Request_Payload : "+api.requestBody);
            DriverInstance.setVariable(Varname+"_Response_Body",api.response);
            System.out.println("api.url"+api.url);
            DriverInstance.setVariable(Varname+"_Url",api.url.split(" - ")[0].trim());
            Thread.sleep(5000);
        }
    }

    @Then("Store Original Request for {string} into {string}")
    public void StoreOriginalRequest(String arg0,String arg1) throws Exception {
        String request_Actual;
        if (arg0.contains("SysData")) {
            request_Actual = DriverInstance.getVariable(DriverInstance.getVariable(arg0.split(">")[1].trim()) + "_Request_Payload").replace("❰", "{").replace("❱", "}");
        } else {
            request_Actual = DriverInstance.getVariable(arg0 + "_Request_Payload").replace("❰", "{").replace("❱", "}");
        }
        DriverInstance.setVariable(arg1, request_Actual);

    }

    @Then("Update and verify payload for {string} with {string}")
    public void updatePayloadforAPI(String arg0,String arg1, DataTable dt) throws Exception{
        Common_Apis ca = new Common_Apis(DriverInstance);
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        String request_Actual;
        if(arg0.contains("SysData"))
        {
            request_Actual = DriverInstance.getVariable(DriverInstance.getVariable(arg0.split(">")[1].trim()) + "_Request_Payload").replace("❰", "{").replace("❱", "}");
        }
        else {

            request_Actual = DriverInstance.getVariable(arg0 + "_Request_Payload").replace("❰", "{").replace("❱", "}");
        }
 //       request_Actual = request_Actual.replace("CurrentDateWithSlash",new SimpleDateFormat("MM/dd/yyyy").format(new Date()));
        JSONObject Actual_request_Json_Object = new JSONObject(request_Actual);

        Actual_request_Json_Object.remove("AuthenticationData");
        Actual_request_Json_Object.remove("BOLNumber");
        Actual_request_Json_Object.remove("ReturnLatestLoadData");
        Actual_request_Json_Object.remove("EmailBOL");
        Actual_request_Json_Object.remove("DispatchRequest");
//        if(!arg0.equalsIgnoreCase("trackedshipments") && !arg0.equalsIgnoreCase("shipments")) {
//            removeAttributes(Actual_request_Json_Object, "EXTERNAL");
//            removeAttributes(Actual_request_Json_Object, "BILL_OF_LADING");
//        }
        //    JSONObject Actual_response_Json_Object = new JSONObject(response_Actual);
        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg1;
        String request_Expected = apiDriver.readRequestTemplate(Path);

        request_Expected = request_Expected.replace("{email}", propertyReader.readproperty("LoggedInUser"));
        request_Expected = request_Expected.replace("{OrgID}", PropReader.get("Org_Id"));
        request_Expected = request_Expected.replace("{Company_Name}", ca.GetCompanyName());
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);

        // Format as YYYY-MM-DD OR MM/DD/YYYY
        String formattedDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentData}", formattedDate);
//        String formattedDate2 = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
//        request_Expected = request_Expected.replace("{CurrentDateYYYYMMDD}", formattedDate2);

        LocalDate expectedDate = today.plusDays(1);
        String formattedDate1 = expectedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentDate+1}", formattedDate1);

        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                if(!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().equalsIgnoreCase("Transactional")) {
                        request_Expected = request_Expected.replace(entry.getKey(), DriverInstance.getVariable(entry.getKey()));
                    }
                    else if (entry.getValue().contains("UpdateData")) {
                        String value = entry.getValue().split("=>")[1];
                        double newRate = Double.parseDouble(
                                DriverInstance.getVariable(value)
                        );
                        request_Expected = request_Expected.replaceFirst(
                                "(\"" + entry.getKey() + "\"\\s*:\\s*)([0-9.]+)",
                                "$1" + newRate
                        ).replace("UpdateData=>","");
                    }
                    else if (entry.getValue().contains("SysData")) {
                            String value = entry.getValue().split("=>")[1];
                            request_Expected = request_Expected.replace("{"+entry.getKey()+"}", DriverInstance.getVariable(value));
                    }
                    else if (entry.getKey().contains("CurrentDateWithSlash")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("M/d/yyyy"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateMM")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYYMMDD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else {
                        request_Expected = request_Expected.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }

        if(DriverInstance.getVariable("TestCaseTimeZoneDSTEnabled").equalsIgnoreCase("Yes"))
        {
            request_Expected= JsonTimeUpdater.updateAllUtcTimes(request_Expected);
        }
        System.out.println("Man "+request_Expected);

        JSONObject Expected_request_Json_Object = new JSONObject(request_Expected);

        // Deep diff using Jackson
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(Expected_request_Json_Object.toString());
        JsonNode actualNode   = mapper.readTree(Actual_request_Json_Object.toString());
        System.out.println("Diff: " + expectedNode.equals(actualNode));

        JSONObject expectedNormalized = new JSONObject(Expected_request_Json_Object.toString());
        JSONObject actualNormalized   = new JSONObject(Actual_request_Json_Object.toString());


        //    JSONObject Expected_response_Json_Object = new JSONObject(response_Expected);
        Assert.assertTrue(expectedNormalized.similar(actualNormalized), "Assertion failed as Expected is :\n" + Expected_request_Json_Object.toString() + " \nAnd Actual is:\n" + Actual_request_Json_Object);
        //    Assert.assertTrue(Expected_response_Json_Object.similar(Actual_response_Json_Object),"Assertion failed as Expected is :\n"+Expected_response_Json_Object.toString()+" \nAnd Actual is:\n"+Actual_response_Json_Object);
        ExtentCucumberAdapter.addTestStepLog("<b><span style='font-size:16px;'>Request Payload:</span></b>");

        displayComparisionDetails(request_Expected, request_Actual);
        //    displayComparisionDetails(response_Expected,response_Actual);

    }

    @Then("TimeZone Specific - Update and verify payload for {string} with {string}")
    public void updatePayloadforAPIWithTimeZone(String arg0,String arg1, DataTable dt) throws Exception{
        Common_Apis ca = new Common_Apis(DriverInstance);
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        String request_Actual;
        if(arg0.contains("SysData"))
        {
            request_Actual = DriverInstance.getVariable(DriverInstance.getVariable(arg0.split(">")[1].trim()) + "_Request_Payload").replace("❰", "{").replace("❱", "}");
        }
        else {

            request_Actual = DriverInstance.getVariable(arg0 + "_Request_Payload").replace("❰", "{").replace("❱", "}");
        }
        //       request_Actual = request_Actual.replace("CurrentDateWithSlash",new SimpleDateFormat("MM/dd/yyyy").format(new Date()));
        JSONObject Actual_request_Json_Object = new JSONObject(request_Actual);

        Actual_request_Json_Object.remove("AuthenticationData");
        Actual_request_Json_Object.remove("BOLNumber");
        Actual_request_Json_Object.remove("ReturnLatestLoadData");
        Actual_request_Json_Object.remove("EmailBOL");
        Actual_request_Json_Object.remove("DispatchRequest");
        removeAttributes(Actual_request_Json_Object,"EXTERNAL");
        removeAttributes(Actual_request_Json_Object,"BILL_OF_LADING");

        //    JSONObject Actual_response_Json_Object = new JSONObject(response_Actual);
        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path;
        ZoneId zone = ZoneId.of("America/Chicago");
        ZonedDateTime now = ZonedDateTime.now(zone);
        boolean isDST = zone.getRules().isDaylightSavings(now.toInstant());
        if (isDST) {
            //2026-03-11T06:15:00+00:00
            System.out.println("Currently CDT (Daylight Saving Time)");
            Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator +"CDT"+ File.separator + arg1;

        }
        else {
            System.out.println("Currently CST (Standard Time)");
            Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator +"CST"+ File.separator + arg1;

        }



        String request_Expected = apiDriver.readRequestTemplate(Path);

        request_Expected = request_Expected.replace("{email}", propertyReader.readproperty("LoggedInUser"));
        request_Expected = request_Expected.replace("{Company_Name}", ca.GetCompanyName());
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);

        // Format as YYYY-MM-DD OR MM/DD/YYYY
        String formattedDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentData}", formattedDate);
        String formattedDate2 = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        request_Expected = request_Expected.replace("{CurrentDateYYYYMMDD}", formattedDate2);

        LocalDate expectedDate = today.plusDays(1);
        String formattedDate1 = expectedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentDate+1}", formattedDate1);

        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                if(!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().equalsIgnoreCase("Transactional")) {
                        request_Expected = request_Expected.replace(entry.getKey(), DriverInstance.getVariable(entry.getKey()));
                    }
                    else if (entry.getValue().contains("UpdateData")) {
                        String value = entry.getValue().split("=>")[1];
                        double newRate = Double.parseDouble(
                                DriverInstance.getVariable(value)
                        );
                        request_Expected = request_Expected.replaceFirst(
                                "(\"" + entry.getKey() + "\"\\s*:\\s*)([0-9.]+)",
                                "$1" + newRate
                        ).replace("UpdateData=>","");
                    }
                    else if (entry.getValue().contains("SysData")) {
                        String value = entry.getValue().split("=>")[1];
                        request_Expected = request_Expected.replace("{"+entry.getKey()+"}", DriverInstance.getVariable(value));
                    }
                    else if (entry.getKey().contains("CurrentDateWithSlash")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("M/d/yyyy"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYYMMDD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else {
                        request_Expected = request_Expected.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        System.out.println("Man "+request_Expected);

        JSONObject Expected_request_Json_Object = new JSONObject(request_Expected);

        // Deep diff using Jackson
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(Expected_request_Json_Object.toString());
        JsonNode actualNode   = mapper.readTree(Actual_request_Json_Object.toString());
        System.out.println("Diff: " + expectedNode.equals(actualNode));

        JSONObject expectedNormalized = new JSONObject(Expected_request_Json_Object.toString());
        JSONObject actualNormalized   = new JSONObject(Actual_request_Json_Object.toString());


        //    JSONObject Expected_response_Json_Object = new JSONObject(response_Expected);
        Assert.assertTrue(expectedNormalized.similar(actualNormalized), "Assertion failed as Expected is :\n" + Expected_request_Json_Object.toString() + " \nAnd Actual is:\n" + Actual_request_Json_Object);
        //    Assert.assertTrue(Expected_response_Json_Object.similar(Actual_response_Json_Object),"Assertion failed as Expected is :\n"+Expected_response_Json_Object.toString()+" \nAnd Actual is:\n"+Actual_response_Json_Object);
        ExtentCucumberAdapter.addTestStepLog("<b><span style='font-size:16px;'>Request Payload:</span></b>");

        displayComparisionDetails(request_Expected, request_Actual);
        //    displayComparisionDetails(response_Expected,response_Actual);

    }

    @Then("TimeZone Specific - Update and verify Response payload for {string} with {string}")
    public void updateResponsePayloadforAPIWithTimeZone(String arg0,String arg1, DataTable dt) throws Exception{

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);


        String request_Actual = DriverInstance.getVariable(arg0+"_Response_Body").replace("❰", "{").replace("❱", "}");
        //    String response_Actual = DriverInstance.getVariable("Response_Payload").replace("❰", "{").replace("❱", "}");

        JSONObject Actual_request_Json_Object = new JSONObject(request_Actual);
        Actual_request_Json_Object.remove("AuthenticationData");
        Actual_request_Json_Object.remove("BOLNumber");
        Actual_request_Json_Object.remove("ReturnLatestLoadData");
        Actual_request_Json_Object.remove("EmailBOL");
        Actual_request_Json_Object.remove("DispatchRequest");
//        Actual_request_Json_Object.remove("transactionId");
        removeAttributes(Actual_request_Json_Object,"EXTERNAL");
        removeAttributes(Actual_request_Json_Object,"BILL_OF_LADING");

        //    JSONObject Actual_response_Json_Object = new JSONObject(response_Actual);
        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
//        String Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg1;
//        String request_Expected = apiDriver.readRequestTemplate("src/test/resources/Documents/TestCaseFiles/TID/" + arg1);
        String Path;
        ZoneId zone = ZoneId.of("America/Chicago");
        ZonedDateTime now = ZonedDateTime.now(zone);
        boolean isDST = zone.getRules().isDaylightSavings(now.toInstant());
        if (isDST) {
            //2026-03-11T06:15:00+00:00
            System.out.println("Currently CDT (Daylight Saving Time)");
            Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator +"CDT"+ File.separator + arg1;

        }
        else {
            System.out.println("Currently CST (Standard Time)");
            Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator +"CST"+ File.separator + arg1;

        }
        String request_Expected = apiDriver.readRequestTemplate(Path);
        request_Expected = request_Expected.replace("{email}", propertyReader.readproperty("LoggedInUser"));
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);

        // Format as YYYY-MM-DD
        String formattedDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentData}", formattedDate);

        String formattedDate2 = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        request_Expected = request_Expected.replace("{CurrentDateYYYYMMDD}", formattedDate2);

        LocalDate expectedDate = today.plusDays(1);
        String formattedDate1 = expectedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentDate+1}", formattedDate1);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                if(!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().equalsIgnoreCase("Transactional")) {
                        request_Expected = request_Expected.replace(entry.getKey(), DriverInstance.getVariable(entry.getKey()));
                    }
                    if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else {
                        request_Expected = request_Expected.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        System.out.println("Man "+request_Expected);
        JSONObject Expected_request_Json_Object = new JSONObject(request_Expected);

        // Deep diff using Jackson
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(Expected_request_Json_Object.toString());
        JsonNode actualNode   = mapper.readTree(Actual_request_Json_Object.toString());
        System.out.println("Diff: " + expectedNode.equals(actualNode));

        JSONObject expectedNormalized = new JSONObject(Expected_request_Json_Object.toString());
        JSONObject actualNormalized   = new JSONObject(Actual_request_Json_Object.toString());


        boolean result = compareJsonIgnoringFields(
                expectedNormalized,
                actualNormalized,
                "liveSharingUrl"
        );

        Assert.assertTrue(
                result,
                "❌ Assertion failed:\nExpected:\n" + expectedNormalized.toString(2)
                        + "\nActual:\n" + actualNormalized.toString(2)
        );
        ExtentCucumberAdapter.addTestStepLog("<b><span style='font-size:16px;'>Request Payload:</span></b>");

        displayComparisionDetails(request_Expected, request_Actual);
        //    displayComparisionDetails(response_Expected,response_Actual);

    }

    @Then("Update and verify Response payload for {string} with {string}")
    public void updateResponsePayloadforAPI(String arg0,String arg1, DataTable dt) throws Exception{

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        String request_Actual = DriverInstance.getVariable(arg0+"_Response_Body").replace("❰", "{").replace("❱", "}");
        JSONObject Actual_request_Json_Object = new JSONObject(request_Actual);
        Actual_request_Json_Object.remove("AuthenticationData");
        Actual_request_Json_Object.remove("BOLNumber");
        Actual_request_Json_Object.remove("ReturnLatestLoadData");
        Actual_request_Json_Object.remove("EmailBOL");
        Actual_request_Json_Object.remove("DispatchRequest");
//        Actual_request_Json_Object.remove("transactionId");
        removeAttributes(Actual_request_Json_Object,"EXTERNAL");
        removeAttributes(Actual_request_Json_Object,"BILL_OF_LADING");

        //    JSONObject Actual_response_Json_Object = new JSONObject(response_Actual);
        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg1;
//        String request_Expected = apiDriver.readRequestTemplate("src/test/resources/Documents/TestCaseFiles/TID/" + arg1);
        String request_Expected = apiDriver.readRequestTemplate(Path);
        request_Expected = request_Expected.replace("{email}", propertyReader.readproperty("LoggedInUser"));
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);

        // Format as YYYY-MM-DD
        String formattedDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentData}", formattedDate);

        String formattedDate2 = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        request_Expected = request_Expected.replace("{CurrentDateYYYYMMDD}", formattedDate2);

        LocalDate expectedDate = today.plusDays(1);
        String formattedDate1 = expectedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentDate+1}", formattedDate1);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                if(!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().equalsIgnoreCase("Transactional")) {
                        request_Expected = request_Expected.replace(entry.getKey(), DriverInstance.getVariable(entry.getKey()));
                    }
                    else if (entry.getValue().contains("SysData")) {
                        request_Expected = request_Expected.replace(entry.getKey(), DriverInstance.getVariable(entry.getValue().split("=>")[1]));
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else {
                        request_Expected = request_Expected.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        if(DriverInstance.getVariable("TestCaseTimeZoneDSTEnabled").equalsIgnoreCase("Yes"))
        {
            request_Expected= JsonTimeUpdater.updateAllUtcTimes(request_Expected);
        }
        System.out.println("Man "+request_Expected);
        JSONObject Expected_request_Json_Object = new JSONObject(request_Expected);

        // Deep diff using Jackson
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(Expected_request_Json_Object.toString());
        JsonNode actualNode   = mapper.readTree(Actual_request_Json_Object.toString());
        System.out.println("Diff: " + expectedNode.equals(actualNode));

        JSONObject expectedNormalized = new JSONObject(Expected_request_Json_Object.toString());
        JSONObject actualNormalized   = new JSONObject(Actual_request_Json_Object.toString());


        boolean result = compareJsonIgnoringFields(
                expectedNormalized,
                actualNormalized,
                "liveSharingUrl","statusHistory"
        );

        Assert.assertTrue(
                result,
                "❌ Assertion failed:\nExpected:\n" + expectedNormalized.toString(2)
                        + "\nActual:\n" + actualNormalized.toString(2)
        );
          ExtentCucumberAdapter.addTestStepLog("<b><span style='font-size:16px;'>Request Payload:</span></b>");

        displayComparisionDetails(request_Expected, request_Actual);
        //    displayComparisionDetails(response_Expected,response_Actual);

    }

    @Then("Get Attribute {string} store into {string} from {string} {string}")
    public void getAttributeFrom(String arg0,String arg4, String arg1, String arg2) {

        if(arg2.equalsIgnoreCase("Response"))
        {
            String _Actual=  DriverInstance.getVariable(arg1+"_Response_Body").replace("❰", "{").replace("❱", "}");
            System.out.println(_Actual);
//            if (_Actual.startsWith("[") && _Actual.endsWith("]")) {
//                _Actual = _Actual.substring(1, _Actual.length() - 1);
//            }
            String AttributeValue= webDriver.getJsonValue(_Actual,arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg4,AttributeValue);
        }
        else{
            String _Actual= DriverInstance.getVariable(arg1+"_Request_Payload").replace("❰", "{").replace("❱", "}");
            String AttributeValue= webDriver.getJsonValue(_Actual,arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg4,AttributeValue);
        }
    }

    @Then("Get Conditional Attribute {string} store into {string} from {string} {string}")
    public void get(String path, String Key,String arg1, String arg2) {
        String _Actual;
        if(arg2.equalsIgnoreCase("Response"))
        {
             _Actual=  DriverInstance.getVariable(arg1+"_Response_Body").replace("❰", "{").replace("❱", "}");
        }
        else{
             _Actual= DriverInstance.getVariable(arg1+"_Request_Payload").replace("❰", "{").replace("❱", "}");
        }
        JsonPath jsonPath = new JsonPath(_Actual);

        DriverInstance.setVariable(Key,jsonPath.getString(path));
    }

    @Then("Get Attribute {string} from {string} {string}")
    public void getAttributeFrom(String arg0, String arg1, String arg2) {

        if(arg2.equalsIgnoreCase("Response"))
        {
            String _Actual=  DriverInstance.getVariable(arg1+"_Response_Body").replace("❰", "{").replace("❱", "}");
            String AttributeValue= webDriver.getJsonValue(_Actual,arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg0,AttributeValue);
        }
        else{
            String _Actual= DriverInstance.getVariable(arg1+"_Request_Payload").replace("❰", "{").replace("❱", "}");
            String AttributeValue= webDriver.getJsonValue(_Actual,arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg0,AttributeValue);
        }
    }

    @Then("Get Attribute {string} from Json {string}")
    public void getAttributeFrom(String arg0, String arg1) {

        if(arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
            String AttributeValue= webDriver.getJsonValue(arg1,arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg0,AttributeValue);
    }

    @Then("Get XML Attribute {string} from {string} {string} and store onto {string}")
    public void getXMLAttributeForm(String arg0, String arg1, String arg2, String arg3) {

        if(arg2.equalsIgnoreCase("Response"))
        {
            String _Actual=  DriverInstance.getVariable(arg1+"_Response_Body").replace("❰", "{").replace("❱", "}");
            String AttributeValue= XML_Utils.getValue(_Actual, arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg3,AttributeValue);
        }
        else{
            String _Actual= DriverInstance.getVariable(arg1+"_Request_Payload").replace("❰", "{").replace("❱", "}");
            String AttributeValue= XML_Utils.getValue(_Actual, arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg3,AttributeValue);
        }
    }
    @Then("Get XML Attribute {string} or {string} from {string} {string} and store onto {string}")
    public void getXMLAttributeForm(String arg0, String arg01, String arg1, String arg2, String arg3) {

        if(arg2.equalsIgnoreCase("Response"))
        {
            String AttributeValue;
            String _Actual=  DriverInstance.getVariable(arg1+"_Response_Body").replace("❰", "{").replace("❱", "}");
           try{
               AttributeValue= XML_Utils.getValue(_Actual, arg0);
           }
           catch(Exception e){
               AttributeValue= XML_Utils.getValue(_Actual, arg01);
        }

            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg3,AttributeValue);
        }
        else{
            String _Actual= DriverInstance.getVariable(arg1+"_Request_Payload").replace("❰", "{").replace("❱", "}");
            String AttributeValue= XML_Utils.getValue(_Actual, arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg3,AttributeValue);
        }
    }
    @Then("Get Attribute {string} or {string} from {string} {string}")
    public void getAttributeFromSecond(String arg0,String second, String arg1, String arg2) {

        if(arg2.equalsIgnoreCase("Response"))
        {
            String _Actual=  DriverInstance.getVariable(arg1+"_Response_Body").replace("❰", "{").replace("❱", "}");
            String AttributeValue= webDriver.getJsonValue(_Actual,arg0);
            System.out.println(AttributeValue);
            if(AttributeValue.isBlank())
            {
                AttributeValue= webDriver.getJsonValue(_Actual,second);
            }
            DriverInstance.setVariable(arg0,AttributeValue);
        }
        else{
            String _Actual= DriverInstance.getVariable(arg1+"_Request_Payload").replace("❰", "{").replace("❱", "}");
            String AttributeValue= webDriver.getJsonValue(_Actual,arg0);
            System.out.println(AttributeValue);
            if(AttributeValue.isBlank())
            {
                AttributeValue= webDriver.getJsonValue(_Actual,second);
            }
            DriverInstance.setVariable(arg0,AttributeValue);
        }
    }

    @Then("Get Attribute {string} store into {string} from {string}")
    public void getAttributeFrom1(String arg0,String arg4, String arg1) {

            String _Actual=  DriverInstance.getVariable(arg1);
            System.out.println(_Actual);
            String AttributeValue= webDriver.getJsonValue(_Actual,arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg4,AttributeValue);
    }

    @Then("Verify url displaying with {string}")
    public void verifyUrlDisplayingWith(String arg0) {
        String _Actual=  DriverInstance.getVariable(DriverInstance.getVariable(arg0)+"_Url");
         System.out.println(_Actual);
        Assert.assertEquals("https://api.samsara.com/v1/fleet/dispatch/routes/"+DriverInstance.getVariable(arg0), _Actual);
    }

    @Then("Verify url contains {string}")
    public void verifyUrlcontains(String arg0) {
          webDriver.waitForUrlContains(arg0);
          String url = webDriver.CurrentURL();
          Assert.assertTrue(url.contains(arg0),"Url not matched");
           }

    @Then("Verify url displaying with {string} as {string}")
    public void verifyUrlDisplayingWithAs(String arg0, String arg1) {
        if(arg0.contains("SysData")) {
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        String _Actual=  DriverInstance.getVariable(arg0+"_Url");
        System.out.println(_Actual);
        if(arg1.contains("SysData"))
        {
            String text= getTextBetweenCurlyBraces(arg1);
            String Value = text.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg1=arg1.replace("SysData=>","").replace(Value,Act).replace("{","").replace("}","");

            DriverInstance.setVariable(arg0,arg1);
        }
        System.out.println("Arg1 : "+arg1);
        Assert.assertEquals(arg1,_Actual, arg1+" not matched with "+_Actual);
    }
    public String getTextBetweenCurlyBraces(String input) {
        if (input == null) return null;
        Matcher m = Pattern.compile("\\{([^}]*)\\}").matcher(input);
        return m.find() ? m.group(1) : null;
    }
    public void removeAttributes(JSONObject requestJson, String type)
    {
        if (requestJson.has("shipmentIdentifiers")) {
            JSONArray shipmentIdentifiers = requestJson.getJSONArray("shipmentIdentifiers");
            for (int i = 0; i < shipmentIdentifiers.length(); i++) {
                JSONObject identifier = shipmentIdentifiers.getJSONObject(i);
                if (type.equalsIgnoreCase(identifier.optString("type"))) {
                    String abc=identifier.optString("value", null);
                    if (abc.matches("^[\\p{Alnum}\\p{Punct}\\s]+$")) {
                        System.out.println("Valid string with letters, digits, special chars, and spaces");
                    } else {
                        System.out.println("Invalid characters present");
                        Assert.assertTrue(false,abc + " value not as expected in json");
                    }
                    shipmentIdentifiers.remove(i);
                    break; // remove only first match
                }
            }
        }
    }

    public void displayComparisionDetails(String Expected, String Actual) {
        ExtentCucumberAdapter.addTestStepLog("<table border='1' style='border-collapse:collapse;width:100%'>" + "<tr style='background-color:#f2f2f2'>" + "<th style='padding:8px;text-align:left'>Expected</th>" + "<th style='padding:8px;text-align:left'>Actual</th>" + "</tr>" + "<tr>" + "<td style='padding:8px'>" + Expected + "</td>" + "<td style='padding:8px'>" + Actual + "</td>" + "</tr>" + "</table>");
    }

    @Then("Verify Success Message displaying as {string}")
    public void verifyMessageAreDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        closeSuccessToastMessage();
    }
    @Then("Close Success Toast message")
    public void closeSuccessToastMessage() throws DocumentException, InterruptedException {
        int count=webDriver.getwebelementscount(xml.getlocator("CloseToastMsg1"));
        if (count>0) {
            try {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("CloseToastMsg1")));
                webDriver.WaitforElementtobeclickable(xml.getlocator("CloseToastMsg1"));
                webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("CloseToastMsg1")));
            }
            catch (Exception e){
                System.out.println("Toast message looks like already closed");
            }
        }
    }


    public  boolean compareJsonIgnoringFields(JSONObject expected, JSONObject actual, String... fieldsToIgnore) {
        Set<String> ignoreSet = new HashSet<>();
        for (String field : fieldsToIgnore) {
            ignoreSet.add(field);
        }

        JSONObject expectedCopy = new JSONObject(expected.toString());
        JSONObject actualCopy = new JSONObject(actual.toString());

        removeIgnoredFields(expectedCopy, ignoreSet);
        removeIgnoredFields(actualCopy, ignoreSet);
        expectedCopy = normalizeObject(expectedCopy);
        actualCopy = normalizeObject(actualCopy);
        return expectedCopy.similar(actualCopy);
    }
    private JSONObject normalizeObject(JSONObject obj) {
        JSONObject normalized = new JSONObject();

        List<String> keys = new ArrayList<>(obj.keySet());
        Collections.sort(keys);

        for (String key : keys) {
            Object value = obj.get(key);

            if (value instanceof JSONObject) {
                normalized.put(key, normalizeObject((JSONObject) value));
            } else if (value instanceof JSONArray) {
                normalized.put(key, normalizeArray((JSONArray) value));
            } else {
                normalized.put(key, value);
            }
        }

        return normalized;
    }
    private JSONArray normalizeArray(JSONArray array) {
        List<Object> values = new ArrayList<>();

        for (int i = 0; i < array.length(); i++) {
            Object value = array.get(i);

            if (value instanceof JSONObject) {
                values.add(normalizeObject((JSONObject) value));
            } else if (value instanceof JSONArray) {
                values.add(normalizeArray((JSONArray) value));
            } else {
                values.add(value);
            }
        }

        values.sort(Comparator.comparing(this::sortKey));

        JSONArray normalized = new JSONArray();
        values.forEach(normalized::put);

        return normalized;
    }
    private String sortKey(Object value) {
        if (value instanceof JSONObject) {
            JSONObject obj = (JSONObject) value;

            if (obj.has("code")) {
                return obj.getString("code");
            }

            if (obj.has("id")) {
                return obj.get("id").toString();
            }

            if (obj.has("name")) {
                return obj.getString("name");
            }

            return obj.toString();
        }

        return String.valueOf(value);
    }

    private static void removeIgnoredFields(Object obj, Set<String> ignoreSet) {
        if (obj instanceof JSONObject) {
            JSONObject jsonObject = (JSONObject) obj;
            Iterator<String> keys = jsonObject.keys();
            while (keys.hasNext()) {
                String key = keys.next();
                if (ignoreSet.contains(key)) {
                    keys.remove(); // safe remove
                } else {
                    Object value = jsonObject.get(key);
                    removeIgnoredFields(value, ignoreSet);
                }
            }
        } else if (obj instanceof JSONArray) {
            JSONArray jsonArray = (JSONArray) obj;
            for (int i = 0; i < jsonArray.length(); i++) {
                removeIgnoredFields(jsonArray.get(i), ignoreSet);
            }
        }
    }
    @Then("Verify no Request & Response  Rendered")
    public void verifyNoRequestResponseRendered() throws DocumentException, InterruptedException {
        webDriver.waitForElementLoad(2);
        webDriver.verifyElementNotToBePresent(xml.getlocator("VerifyDebuggingMessage"));
    }

    @Then("Update and verify Json for {string} with {string}")
    public void VerifyTwoJson(String arg0,String arg1, DataTable dt) throws Exception{

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        String request_Actual = DriverInstance.getVariable(arg0);
        //    String response_Actual = DriverInstance.getVariable("Response_Payload").replace("❰", "{").replace("❱", "}");

        JSONObject Actual_request_Json_Object = new JSONObject(request_Actual);
        Actual_request_Json_Object.remove("AuthenticationData");
        Actual_request_Json_Object.remove("BOLNumber");
        Actual_request_Json_Object.remove("ReturnLatestLoadData");
        Actual_request_Json_Object.remove("EmailBOL");
        Actual_request_Json_Object.remove("DispatchRequest");
//        Actual_request_Json_Object.remove("transactionId");
        removeAttributes(Actual_request_Json_Object,"EXTERNAL");
        removeAttributes(Actual_request_Json_Object,"BILL_OF_LADING");

        //    JSONObject Actual_response_Json_Object = new JSONObject(response_Actual);
        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg1;
//        String request_Expected = apiDriver.readRequestTemplate("src/test/resources/Documents/TestCaseFiles/TID/" + arg1);
        String request_Expected = apiDriver.readRequestTemplate(Path);
        request_Expected = request_Expected.replace("{email}", propertyReader.readproperty("LoggedInUser"));
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);

        // Format as YYYY-MM-DD
        String formattedDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentData}", formattedDate);

        String formattedDate2 = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        request_Expected = request_Expected.replace("{CurrentDateYYYYMMDD}", formattedDate2);

        LocalDate expectedDate = today.plusDays(1);
        String formattedDate1 = expectedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentDate+1}", formattedDate1);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                if(!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().equalsIgnoreCase("Transactional")) {
                        request_Expected = request_Expected.replace(entry.getKey(), DriverInstance.getVariable(entry.getKey()));
                    }
                    else if (entry.getValue().contains("SysData")) {
                        String value = entry.getValue().split(">")[1];
                        request_Expected = request_Expected.replace("{"+entry.getKey()+"}", DriverInstance.getVariable(value));
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else {
                        request_Expected = request_Expected.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        System.out.println("Man "+request_Expected);
        JSONObject Expected_request_Json_Object = new JSONObject(request_Expected);

        // Deep diff using Jackson
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(Expected_request_Json_Object.toString());
        JsonNode actualNode   = mapper.readTree(Actual_request_Json_Object.toString());
        System.out.println("Diff: " + expectedNode.equals(actualNode));

        JSONObject expectedNormalized = new JSONObject(Expected_request_Json_Object.toString());
        JSONObject actualNormalized   = new JSONObject(Actual_request_Json_Object.toString());


        boolean result = compareJsonIgnoringFields(
                expectedNormalized,
                actualNormalized,
                "url"
        );

        Assert.assertTrue(
                result,
                "❌ Assertion failed:\nExpected:\n" + expectedNormalized.toString(2)
                        + "\nActual:\n" + actualNormalized.toString(2)
        );
        ExtentCucumberAdapter.addTestStepLog("<b><span style='font-size:16px;'>Request Payload:</span></b>");

        displayComparisionDetails(request_Expected, request_Actual);
        //    displayComparisionDetails(response_Expected,response_Actual);

    }

    @Then("Verify XML request for {string} with File {string}")
    public void verifyXMLWithFile(String arg0, String arg1,DataTable dt) throws Exception {
        if(arg0.contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);

        String actualText= DriverInstance.getVariable(arg0+"_Request_Payload").replace("\n", "").trim();

        String scenarioName= DriverInstance.getScenarioName();
        System.out.println("scenarioName:"+scenarioName);
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        System.out.println("TID:"+TID);
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        File file = new File(Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg1);
        String expectedText = readFile(file.getAbsolutePath());

        expectedText = expectedText.replace("\n", "")
                .replace("\r", "")
                .trim();
        expectedText = expectedText.replace("{email}", propertyReader.readproperty("LoggedInUser"));

        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                if (!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().contains("SysData")) {
                        String value = entry.getValue().split("=>")[1];
                        if(entry.getKey().contains("{"))
                        {
                            expectedText = expectedText.replace(entry.getKey() , DriverInstance.getVariable(value));
                        }
                        else {
                            expectedText = expectedText.replace("{" + entry.getKey() + "}", DriverInstance.getVariable(value));
                        }
                    }
                    else if (entry.getKey().contains("ScratchOrgEmail")) {

                        System.out.println(entry.getKey()+" is the value to be replaced from expected ");
                        String value = propertyReader.readproperty(entry.getValue());
                        System.out.println(entry.getValue()+" is the property and read value is "+value);
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }

                    else if (entry.getKey().contains("OrgID")) {
                        String value = propertyReader.readproperty(entry.getValue());
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }
                    else if (entry.getKey().contains("CurrentDateWithSlash")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("M/d/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateMM/dd/yyyy")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYYMMDD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYY/MM/DD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    } else {
                        expectedText = expectedText.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        actualText = actualText.replaceAll("<auth>.*?</auth>", "");
        Diff diff = XmlComparisonUtil.compareXml(expectedText, actualText);

        System.out.println(expectedText);
        System.out.println(actualText);
        Assert.assertFalse(diff.hasDifferences(),
                "Expected : " + expectedText + " but getting " + actualText + "XML Mismatch Found: " + diff.toString());

    }
    @Then("TimeZone Specific - Update and verify XML Request for {string} with {string}")
    public void updateXMLRequestforAPIWithTimeZone(String arg0,String arg1, DataTable dt) throws Exception{
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);

        String actualText= DriverInstance.getVariable(arg0+"_Request_Payload").replace("\n", "").trim();

        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path;
        ZoneId zone = ZoneId.of("America/Chicago");
        ZonedDateTime now = ZonedDateTime.now(zone);
        boolean isDST = zone.getRules().isDaylightSavings(now.toInstant());
        if (isDST) {
            //2026-03-11T06:15:00+00:00
            System.out.println("Currently CDT (Daylight Saving Time)");
            Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator +"CDT"+ File.separator + arg1;

        }
        else {
            System.out.println("Currently CST (Standard Time)");
            Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator +"CST"+ File.separator + arg1;

        }
        if(arg0.contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }

        File file = new File(Path);
        String expectedText = readFile(file.getAbsolutePath());

        expectedText = expectedText.replace("\n", "")
                .replace("\r", "")
                .trim();
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                if (!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().contains("SysData")) {
                        String value = entry.getValue().split("=>")[1];
                        if(entry.getKey().contains("{"))
                        {
                            expectedText = expectedText.replace(entry.getKey() , DriverInstance.getVariable(value));
                        }
                        else {
                            expectedText = expectedText.replace("{" + entry.getKey() + "}", DriverInstance.getVariable(value));
                        }
                    }
                    else if (entry.getKey().contains("ScratchOrgEmail")) {

                        System.out.println(entry.getKey()+" is the value to be replaced from expected ");
                        String value = propertyReader.readproperty(entry.getValue());
                        System.out.println(entry.getValue()+" is the property and read value is "+value);
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }

                    else if (entry.getKey().contains("OrgID")) {
                        String value = propertyReader.readproperty(entry.getValue());
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }
                    else if (entry.getKey().contains("CurrentDateWithSlash")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("M/d/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateMM/dd/yyyy")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYYMMDD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYY/MM/DD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    } else {
                        expectedText = expectedText.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        actualText = actualText.replaceAll("<auth>.*?</auth>", "");
        Diff diff = XmlComparisonUtil.compareXml(expectedText, actualText);

        System.out.println(expectedText);
        System.out.println(actualText);
        Assert.assertFalse(diff.hasDifferences(),
                "Expected : " + expectedText + " but getting " + actualText + "XML Mismatch Found: " + diff.toString());

    }
    @And("Close all the Toast messages")
    public void tcloseAllTheToastMessages() throws DocumentException, InterruptedException {
        String toastMessageList=xml.getlocator("ToastMessagesList");
        webDriver.waitForElementLoad(15);
        int messageCount=webDriver.getwebelementscount(toastMessageList);
        if(messageCount ==0){
            return;
        }
      List<WebElement> toastMessages=webDriver.waitUntilVisibleAndReturnElements(toastMessageList);
      int count=toastMessages.size();
      while (count>0) {
          webDriver.waitUntilTheElementIsVisible(toastMessages.getFirst());
          for (WebElement toastMessage : toastMessages) {
              if (toastMessage.isDisplayed()) {
                  WebElement closeIcon = toastMessage.findElement(By.xpath(".//button[contains(@class,'toastClose')]"));
                  if(closeIcon.isDisplayed()) {
                      webDriver.waitForElementToBeClickable(closeIcon);
                      webDriver.ClickOnElement(closeIcon);
                      webDriver.waitForElementLoad(1);
                  }
              }
          }
          toastMessages = webDriver.getwebelements(toastMessageList);
          count=toastMessages.size();
      }
    }
}
