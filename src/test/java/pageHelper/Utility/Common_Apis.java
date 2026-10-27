package pageHelper.Utility;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.http.Method;
import io.restassured.path.json.JsonPath;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.Color;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.MailUtility.maiUtility;
import utils.PropReader;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Log4j
public class Common_Apis {
    String URI;
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public apiHelper apiDriver;
    public xmlreader xml;
    public PropertyReader propertyReader = new PropertyReader();
    private static final ObjectMapper MAPPER = new ObjectMapper();

    public Common_Apis(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver = new baseDriverHelper(DriverInstance.getApiDriver(), DriverInstance.API_RESPONCE_THREAD_LOCAL.get());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    public String getSessionID() throws Exception {
        //DriverInstance.setApi
        String Session;
        if(!PropReader.get("Security_Token").equalsIgnoreCase("NA")) {
            apiDriver.clearRequestHeaders();
            URI = "https://test.salesforce.com";
            URI = URI.concat("/services/Soap/c/42.0");
            apiDriver.updateRequestHeader("Content-Type", "text/xml");
            apiDriver.updateRequestHeader("SOAPAction", "\"\"");
            apiDriver.updateAttributeInRequestBody("login.xml", "//*[name()='urn:organizationId']", PropReader.get("Org_Id"));
            apiDriver.UpdatedAttributeinxmlPayload("//*[name()='urn:username']", PropReader.get("UserName"));
            apiDriver.UpdatedAttributeinxmlPayload("//*[name()='urn:password']", PropReader.get("Password") + PropReader.get("Security_Token"));
            apiDriver.generatePayLoad();
            apiDriver.submitRequest(Method.POST, URI);
            bddDriver.logResponse();
            Session = apiDriver.SaveAttributevalue("//*[name()='sessionId']");
            apiDriver.clearRequestHeaders();
        }
        else {
             String OrgName = PropReader.get("UserName");
            ProcessBuilder pb = new ProcessBuilder(
                    "sf.cmd", "org", "display", "--target-org", OrgName, "--json"
            );
            Process process = pb.start();
            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream())
            );
            StringBuilder output = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                output.append(line);
            }
            JSONObject json = new JSONObject(output.toString());
            Session = json.getJSONObject("result").getString("accessToken");
            System.out.println("Man"+Session);
        }
        return Session;
    }

    @Given("Upload File {string} with Title {string}")
    public void uploadFileWithTitle(String arg0, String arg1) throws Exception {
        String SessionId = getSessionID();
        DriverInstance.setVariable("SessionID", SessionId);
        DriverInstance.setApiDriver();
        String entityContent = "{\"Title\":\"" + arg1 + "\",\"PathOnClient\":\"" + arg0 + "\"}";
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/sobjects/ContentVersion");
        apiDriver.updateRequestHeader("Content-Type", "multipart/form-data");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.updateMultipart("entity_content", entityContent, "application/json");

        //Getting testcases id from scenarios
        String scenarioName= DriverInstance.getScenarioName();
        System.out.println("scenarioName:"+scenarioName);
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        System.out.println("TID:"+TID);
        apiDriver.updateMultipart("VersionData",TID+"//"+arg0, "NA");
        apiDriver.submitRequest(Method.POST,URI);
        bddDriver.logResponse();
        String id = apiDriver.getSingleValueFromResponse("id");
        String success = apiDriver.getSingleValueFromResponse("success");
        if (success.equalsIgnoreCase("true")) {
            DriverInstance.setVariable(arg1, id);
        } else {
            String Error = apiDriver.getSingleValueFromResponse("errors");
            System.out.println(Error);
            Assert.fail("File not uploaded correctly!! " + Error);
        }
        apiDriver.clearRequestHeaders();

    }

    @Given("Upload File {string} with Title {string} and Description {string}")
    public void uploadFileWithTitleDescription(String arg0, String arg1, String Description) throws Exception {
        String SessionId = getSessionID();
        DriverInstance.setVariable("SessionID", SessionId);
        DriverInstance.setApiDriver();
        String entityContent = "{\"Title\":\"" + arg1 + "\",\"PathOnClient\":\"" + arg0 + "\",\"Description\":\"" + Description + "\"}";
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/sobjects/ContentVersion");
        apiDriver.updateRequestHeader("Content-Type", "multipart/form-data");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.updateMultipart("entity_content", entityContent, "application/json");

        //Getting testcases id from scenarios
        String scenarioName= DriverInstance.getScenarioName();
        System.out.println("scenarioName:"+scenarioName);
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        System.out.println("TID:"+TID);
        apiDriver.updateMultipart("VersionData",TID+"//"+arg0, "NA");
        apiDriver.submitRequest(Method.POST,URI);
        bddDriver.logResponse();
        String id = apiDriver.getSingleValueFromResponse("id");
        String success = apiDriver.getSingleValueFromResponse("success");
        if (success.equalsIgnoreCase("true")) {
            DriverInstance.setVariable(arg1, id);
        } else {
            String Error = apiDriver.getSingleValueFromResponse("errors");
            System.out.println(Error);
            Assert.fail("File not uploaded correctly!! " + Error);
        }
        apiDriver.clearRequestHeaders();

    }

    @Given("Upload File {string} in Asset Library with Title {string}")
    public void uploadFileInAssetLibraryWithTitle(String filePath, String title) throws Exception {

        String sessionId = getSessionID();
        DriverInstance.setVariable("SessionID", sessionId);
        DriverInstance.setApiDriver();

        String entityContent = "{\"Title\":\"" + title + "\",\"PathOnClient\":\"" + filePath + "\"}";

        String baseUri = PropReader.get("application_url"); // e.g. https://yourInstance.my.salesforce.com
        if (baseUri == null || baseUri.isBlank()) {
            throw new RuntimeException("application_url property not set");
        }

        String contentVersionEndpoint = baseUri + "/services/data/v56.0/sobjects/ContentVersion";
        apiDriver.updateRequestHeader("Content-Type", "multipart/form-data");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
        apiDriver.updateMultipart("entity_content", entityContent, "application/json");

        String scenarioName = DriverInstance.getScenarioName();
        System.out.println("scenarioName:" + scenarioName);
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ", "");
        System.out.println("TID:" + TID);

        apiDriver.updateMultipart("VersionData", TID + "//" + filePath, "NA");

        apiDriver.submitRequest(Method.POST, contentVersionEndpoint);
        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();

        String contentVersionId = apiDriver.getSingleValueFromResponse("id");
        String success = apiDriver.getSingleValueFromResponse("success");

        if (contentVersionId == null || contentVersionId.isBlank() || !"true".equalsIgnoreCase(success)) {
            String error = apiDriver.getSingleValueFromResponse("errors");
            System.out.println("Error creating ContentVersion: " + error);
            apiDriver.clearRequestHeaders();
            Assert.fail("File not uploaded correctly!! " + error);
            return;
        }

        // store the ContentVersion Id (if you want to use later)
        DriverInstance.setVariable(title, contentVersionId);
        System.out.println("Created ContentVersion id: " + contentVersionId);

        String soql = "SELECT ContentDocumentId FROM ContentVersion WHERE Id = '"+contentVersionId+"'";
        String queryEndpoint = baseUri + "/services/data/v56.0/query?q=" + soql;
        apiDriver.clearRequestHeaders();
        apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
        apiDriver.submitRequest(Method.GET, queryEndpoint);
        bddDriver.logResponse();

        String contentDocumentId = null;
        try {
            contentDocumentId = apiDriver.getSingleValueFromResponse("records[0].ContentDocumentId");
        }
        catch (Exception e) {
               String raw = apiDriver.RetrurnResponce();
            if (raw != null && !raw.isEmpty()) {
                JSONObject respJson = new JSONObject(raw);
                JSONArray records = respJson.optJSONArray("records");
                if (records != null && records.length() > 0) {
                    contentDocumentId = records.getJSONObject(0).optString("ContentDocumentId", null);
                }
            }
        }

        if (contentDocumentId == null || contentDocumentId.isBlank()) {
            apiDriver.clearRequestHeaders();
            Assert.fail("Could not retrieve ContentDocumentId for ContentVersion id: " + contentVersionId);
            return;
        }

        System.out.println("ContentDocumentId: " + contentDocumentId);

        // Link ContentDocument to Asset Library via ContentWorkspaceDoc
        String soql_LibraryID = "SELECT ID, Name FROM ContentWorkspace WHERE Name = 'Asset Library'";
        String queryEndpoint_LibraryID = baseUri + "/services/data/v56.0/query?q=" + soql_LibraryID;
        apiDriver.clearRequestHeaders();
        apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);

        apiDriver.submitRequest(Method.GET, queryEndpoint_LibraryID);
        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
        String libraryId = apiDriver.getSingleValueFromResponse("records[0].Id");
//        String libraryId = "058cf000000UBm2AAG";

        if (libraryId == null || libraryId.isBlank()) {
            apiDriver.clearRequestHeaders();
            throw new RuntimeException("asset_library_id not provided. Set property 'asset_library_id' or system property 'asset_library_id' to the target ContentWorkspace.Id");
        }

        // Create ContentWorkspaceDoc payload
        JSONObject linkPayload = new JSONObject();
        linkPayload.put("ContentWorkspaceId", libraryId);
        linkPayload.put("ContentDocumentId", contentDocumentId);

        String linkEndpoint = baseUri + "/services/data/v56.0/sobjects/ContentWorkspaceDoc";
        apiDriver.updateRequestHeader("Content-Type", "application/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
        System.out.println("Payload: "+linkPayload);

        apiDriver.payloadFromPOJOClass(linkPayload.toString());
        apiDriver.generatePayLoad();
        System.out.println("Payload="+apiDriver.ReturnPaylod());

        // Submit the link creation
        apiDriver.submitRequest(Method.POST, linkEndpoint);
        bddDriver.logResponse();

        String linkSuccess = apiDriver.getSingleValueFromResponse("success");
        if (!"true".equalsIgnoreCase(linkSuccess)) {
            String linkError = apiDriver.getSingleValueFromResponse("errors");
            apiDriver.clearRequestHeaders();
            Assert.fail("Failed linking ContentDocument to Asset Library: " + linkError);
            return;
        }
        System.out.println("Successfully linked ContentDocument to library: " + libraryId);
        apiDriver.clearRequestHeaders();
    }

    @Then("Delete Field with Title {string}")
    public void deleteFieldWithTitle(String arg0) throws Exception {
        int Count;
        if (arg0.contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        do {
            String SessionId = getSessionID();
            URI = PropReader.get("application_url");
            URI = URI.concat("/services/data/v56.0/query?q=SELECT ContentDocumentId FROM ContentVersion WHERE Title='" + arg0 + "'");
            apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
            apiDriver.submitRequest(Method.GET, URI);

            String success = apiDriver.getSingleValueFromResponse("done");
            String fileCount = apiDriver.getSingleValueFromResponse("totalSize");
            Count = Integer.parseInt(fileCount);

            if (success.equalsIgnoreCase("true")) {
                String ContentDocumentId = apiDriver.getSingleValueFromResponse("records[0].ContentDocumentId");
                System.out.println("ContentDocumentId :" + ContentDocumentId);
                DriverInstance.setVariable(arg0 + 0, ContentDocumentId);
            } else {
                System.out.println("File Not Found");
//            Assert.fail("File not Deletred correctly!! ");
            }
            URI = PropReader.get("application_url");
            URI = URI.concat("/services/data/v56.0/sobjects/ContentDocument/" + DriverInstance.getVariable(arg0 + 0));
            apiDriver.submitRequest(Method.DELETE, URI);
            bddDriver.logResponse();
            apiDriver.clearRequestHeaders();
        }
        while (Count > 1);
    }

    public void DeleteRecords(String ObjectName, String RecordId) throws Exception {
        String Session = getSessionID();
        if(RecordId.contains("SysData"))
        {
            RecordId = DriverInstance.getVariable(RecordId.split("=>")[1]);
        }
        if (RecordId != null && !RecordId.isEmpty()) {
            URI = PropReader.get("application_url");
            apiDriver.updateRequestHeader("Authorization", "Bearer " + Session);
            URI = URI.concat("/services/data/v57.0/sobjects/" + ObjectName + "/" + RecordId);
            System.out.println(URI);
            apiDriver.submitRequest(Method.DELETE, URI);
            apiDriver.clearRequestHeaders();
        }
    }

    @Then("Delete {string} with Id {string}")
    public void DeleteRecords1(String ObjectName, String RecordId) throws Exception {
        apiDriver.clearRequestHeaders();
        String Session = getSessionID();
        if (DriverInstance.getVariable(RecordId) != null && !DriverInstance.getVariable(RecordId).isEmpty()) {
            URI = PropReader.get("application_url");
            apiDriver.updateRequestHeader("Authorization", "Bearer " + Session);
            URI = URI.concat("/services/data/v57.0/sobjects/" + ObjectName + "/" + DriverInstance.getVariable(RecordId));
            System.out.println(URI);
            apiDriver.submitRequest(Method.DELETE, URI);
            apiDriver.clearRequestHeaders();
        }
    }

    public void DeleteRecordsWithoutAuthorization(String ObjectName, String RecordId) throws Exception {
        if (RecordId != null && !RecordId.isEmpty()) {
            URI = PropReader.get("application_url");
            URI = URI.concat("/services/data/v57.0/sobjects/" + ObjectName + "/" + RecordId);
            System.out.println(URI);
            apiDriver.submitRequest(Method.DELETE, URI);
        }
        apiDriver.clearRequestHeaders();
    }

    public String getAccountID(String arg0) throws Exception {
        apiDriver.clearRequestHeaders();
        //    int Count;
        String ObjectID = "";
//        do {
            String SessionId = getSessionID();
            URI = PropReader.get("application_url");

            URI = URI.concat("/services/data/v56.0/query?q=SELECT Id, Name FROM Account WHERE Name='"+arg0+"'");

            apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
            apiDriver.submitRequest(Method.GET, URI);

            String success = apiDriver.getSingleValueFromResponse("done");
            String fileCount = apiDriver.getSingleValueFromResponse("totalSize");
        //    Count = Integer.parseInt(fileCount);

            if (success.equalsIgnoreCase("true")) {
                ObjectID = apiDriver.getSingleValueFromResponse("records[0].Id");
                System.out.println("ObjectID :" + ObjectID);
                DriverInstance.setVariable(arg0 , ObjectID);
            } else {
                System.out.println("Account Not Found");
            }
            bddDriver.logResponse();
            apiDriver.clearRequestHeaders();
        return ObjectID;
    }

    @Then("Set key {string} for Object {string} and Name {string}")
    public String GetIDUsingName(String Key, String ObjectName, String arg0) throws Exception {
        String ObjectID = "";
        String SessionId = getSessionID();
        URI = PropReader.get("application_url");
         if (arg0.contains("SysData")) {
             String Value = arg0.split("=>")[1];
             URI = URI.concat("/services/data/v56.0/query?q=SELECT Id, Name FROM "+ ObjectName +" WHERE Name='"+DriverInstance.getVariable(Value)+"'");
         }
         else {
             URI = URI.concat("/services/data/v56.0/query?q=SELECT Id, Name FROM " + ObjectName + " WHERE Name='" + arg0 + "'");
         }
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.submitRequest(Method.GET, URI);
        String success = apiDriver.getSingleValueFromResponse("done");
        if (success.equalsIgnoreCase("true")) {
            ObjectID = apiDriver.getSingleValueFromResponse("records[0].Id");
            System.out.println("ObjectName :" + ObjectID);
            DriverInstance.setVariable(Key , ObjectID);
        } else {
            System.out.println("Account Not Found");
        }
        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
        return ObjectID;
    }
    public String GetContentDocumentLink(String arg0, String DocumentName) throws Exception {
        String contentDocumentId = "";
        String SessionId = getSessionID();
        DriverInstance.setApiDriver();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId='" + arg0 + "'");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.submitRequest(Method.GET, URI);
        System.out.println(apiDriver.RetrurnResponce());
        String success = apiDriver.getSingleValueFromResponse("done");
        if (success.equalsIgnoreCase("true")) {
            JSONObject obj = new JSONObject(apiDriver.RetrurnResponce());
            JSONArray records = obj.getJSONArray("records");
            for (int i = 0; i < records.length(); i++) {
                JSONObject record = records.getJSONObject(i);
                apiDriver.clearRequestHeaders();
                contentDocumentId=  GetContentVersion(record.getString("ContentDocumentId"), DocumentName);
                if(!contentDocumentId.equalsIgnoreCase("NA"))
                {
                    break;
                }
            }
        }
        apiDriver.clearRequestHeaders();
        return contentDocumentId;

    }
    public String GetContentVersion(String arg0, String DocumentName) throws Exception {
        String ContentVersion = "NA";
        String SessionId = getSessionID();
        DriverInstance.setApiDriver();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT Id,Title,FileType FROM ContentVersion WHERE ContentDocumentId='" + arg0 + "' AND IsLatest=true");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.submitRequest(Method.GET, URI);
        System.out.println(apiDriver.RetrurnResponce());
        String success = apiDriver.getSingleValueFromResponse("done");
        if (success.equalsIgnoreCase("true")) {
            JSONObject json = new JSONObject(apiDriver.RetrurnResponce());
            JSONArray records = json.getJSONArray("records");
            JSONObject firstRecord = records.getJSONObject(0);
            String ContentTitle = firstRecord.getString("Title");
            if(ContentTitle.contains(DocumentName)){
                ContentVersion = firstRecord.getString("Id");
            }
        } else {
            System.out.println("Issue with getting ContentDocumentId");
        }
        apiDriver.clearRequestHeaders();

        return ContentVersion;

    }

    public String GetCompanyName() throws Exception {
        String CompanyName = "";
        String SessionId = getSessionID();
        DriverInstance.setApiDriver();
        URI = PropReader.get("application_url");
        String OrgID = PropReader.get("Org_Id");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT Id,Name FROM Organization");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.submitRequest(Method.GET, URI);
        System.out.println(apiDriver.RetrurnResponce());
        String success = apiDriver.getSingleValueFromResponse("done");
        if (success.equalsIgnoreCase("true")) {
            JSONObject json = new JSONObject(apiDriver.RetrurnResponce());
            JSONArray records = json.getJSONArray("records");
            JSONObject firstRecord = records.getJSONObject(0);
            CompanyName = firstRecord.getString("Name");
        } else {
            System.out.println("Issue with getting ContentDocumentId");
        }
        apiDriver.clearRequestHeaders();

        return CompanyName;
    }
    @Then("Get Company Name on to {string}")
    public void getCompanyNameOnTo(String arg0) throws Exception {
        String CompanyName = GetCompanyName();
        DriverInstance.setVariable(arg0,CompanyName);
    }

    @Then("Get {string} from {string} using {string} with value {string} and Store onto {string}")
    public void getValueFromObject(String arg0, String arg1, String arg2, String arg3, String arg4) throws Exception {

        if (arg3.contains("SysData")) {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }

        String fieldValue = "";
        String sessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT " + arg0 + " FROM " + arg1
                + " WHERE " + arg2 + "='" + arg3 + "'");

        int retryCount = 0;
        int maxRetry = 20;
        int fileCount = 0;

        do {
            webDriver.waitForElementLoad(3);
            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
            apiDriver.submitRequest(Method.GET, URI);

            String success = apiDriver.getSingleValueFromResponse("done");
            String totalSize = apiDriver.getSingleValueFromResponse("totalSize");

            fileCount = Integer.parseInt(totalSize);

            if (success.equalsIgnoreCase("true") && fileCount > 0) {
                fieldValue = apiDriver.getSingleValueFromResponse("records[0]." + arg0);
                System.out.println("ObjectID : " + fieldValue);
                DriverInstance.setVariable(arg4, fieldValue);
                break;
            }

            retryCount++;

            if (retryCount < maxRetry) {
                System.out.println("Record not found. Retry " + retryCount + "/" + maxRetry);
                Thread.sleep(1000); // Wait 1 second before retrying
            }

        } while (fileCount == 0 && retryCount < maxRetry);

        if (fileCount == 0) {
            throw new Exception(arg0 + " not found in " + arg1 + " after " + maxRetry + " retries.");
        }

        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }

    @Then("Get {string} from {string} using {string} with value {string} & {string} with value {string} and Store onto {string}")
    public void getValueFromObjectWithAnd(String arg0, String arg1, String arg2, String arg3, String arg31, String arg32, String arg4) throws Exception {

        if (arg3.contains("SysData")) {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }
        if (arg32.contains("SysData")) {
            arg32 = DriverInstance.getVariable(arg32.split("=>")[1]);
        }

        String fieldValue = "";
        String sessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT " + arg0 + " FROM " + arg1
                + " WHERE " + arg2 + "='" + arg3 + "'and "+arg31+" ='"+arg32+"'");

        int retryCount = 0;
        int maxRetry = 20;
        int fileCount = 0;

        do {
            webDriver.waitForElementLoad(3);
            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
            apiDriver.submitRequest(Method.GET, URI);

            String success = apiDriver.getSingleValueFromResponse("done");
            String totalSize = apiDriver.getSingleValueFromResponse("totalSize");
            DriverInstance.setVariable(arg4+"_count",totalSize);
            fileCount = Integer.parseInt(totalSize);

            if (success.equalsIgnoreCase("true") && fileCount > 0) {
                fieldValue = apiDriver.getSingleValueFromResponse("records[0]." + arg0);
                System.out.println("ObjectID : " + fieldValue);
                DriverInstance.setVariable(arg4, fieldValue);
                break;
            }

            retryCount++;

            if (retryCount < maxRetry) {
                System.out.println("Record not found. Retry " + retryCount + "/" + maxRetry);
                Thread.sleep(1000); // Wait 1 second before retrying
            }

        } while (fileCount == 0 && retryCount < maxRetry);

        if (fileCount == 0) {
            throw new Exception(arg0 + " not found in " + arg1 + " after " + maxRetry + " retries.");
        }

        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }


    @Then("Get {string} from {string} using {string} with value {string} & {string} with value {string} and Store into {string}")
    public void getValueFromObjectWithAndinto(String arg0, String arg1, String arg2, String arg3, String arg31, String arg32, String arg4) throws Exception {

        if (arg3.contains("SysData")) {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }

        if (arg32.contains("SysData")) {
            arg32 = DriverInstance.getVariable(arg32.split("=>")[1]);
        }

        String fieldValue = "";
        String sessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT " + arg0 + " FROM " + arg1
                + " WHERE " + arg2 + "='" + arg3 + "'and "+arg31+" ='"+arg32+"'"+" ORDER BY LastModifiedDate DESC LIMIT 1");

        int retryCount = 0;
        int maxRetry = 20;
        int fileCount = 0;

        do {
            webDriver.waitForElementLoad(5);
            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
            apiDriver.submitRequest(Method.GET, URI);

            String success = apiDriver.getSingleValueFromResponse("done");
            String totalSize = apiDriver.getSingleValueFromResponse("totalSize");

            fileCount = Integer.parseInt(totalSize);

            if (success.equalsIgnoreCase("true") && fileCount > 0) {
                fieldValue = apiDriver.getSingleValueFromResponse("records[0]." + arg0);
                System.out.println("ObjectID : " + fieldValue);
                DriverInstance.setVariable(arg4, fieldValue);
                break;
            }

            retryCount++;

            if (retryCount < maxRetry) {
                System.out.println("Record not found. Retry " + retryCount + "/" + maxRetry);
                Thread.sleep(1000); // Wait 1 second before retrying
            }

        } while (fileCount == 0 && retryCount < maxRetry);

        if (fileCount == 0) {
            throw new Exception(arg0 + " not found in " + arg1 + " after " + maxRetry + " retries.");
        }

        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }


    @Then("Get {string} from {string} using {string} with contains {string} & {string} with contains {string} and Store into {string}")
    public void getValueFromObjectWithAndintoContains(String arg0, String arg1, String arg2, String arg3, String arg31, String arg32, String arg4) throws Exception {

        if (arg3.contains("SysData")) {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }

        if (arg32.contains("SysData")) {
            arg32 = DriverInstance.getVariable(arg32.split("=>")[1]);
        }

        String fieldValue = "";
        String sessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT " + arg0 + " FROM " + arg1
                + " WHERE " + arg2 + " LIKE '%" + arg3 + "%'"
                + " AND " + arg31 + " LIKE '%" + arg32 + "%'"
                + " ORDER BY LastModifiedDate DESC LIMIT 1");


        int retryCount = 0;
        int maxRetry = 20;
        int fileCount = 0;

        do {
            webDriver.waitForElementLoad(5);
            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
            apiDriver.submitRequest(Method.GET, URI);

            String success = apiDriver.getSingleValueFromResponse("done");
            String totalSize = apiDriver.getSingleValueFromResponse("totalSize");

            fileCount = Integer.parseInt(totalSize);
            DriverInstance.setVariable(arg4+"_count",totalSize);

            if (success.equalsIgnoreCase("true") && fileCount > 0) {
                fieldValue = apiDriver.getSingleValueFromResponse("records[0]." + arg0);
                System.out.println("ObjectID : " + fieldValue);
                DriverInstance.setVariable(arg4, fieldValue);
                break;
            }

            retryCount++;

            if (retryCount < maxRetry) {
                System.out.println("Record not found. Retry " + retryCount + "/" + maxRetry);
                Thread.sleep(1000); // Wait 1 second before retrying
            }

        } while (fileCount == 0 && retryCount < maxRetry);

        if (fileCount == 0) {
            throw new Exception(arg0 + " not found in " + arg1 + " after " + maxRetry + " retries.");
        }

        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }

    @Then("Get Count from {string} using {string} with value {string} and Store onto {string}")
    public void getCountFromObject( String arg1, String arg2, String arg3, String arg4) throws Exception {

        if (arg3.contains("SysData")) {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }

        String fieldValue = "";
        String sessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT Id FROM " + arg1
                + " WHERE " + arg2 + "='" + arg3 + "'");
            webDriver.waitForElementLoad(3);
            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
            apiDriver.submitRequest(Method.GET, URI);
            String success = apiDriver.getSingleValueFromResponse("done");

            if (success.equalsIgnoreCase("true")) {
                String totalSize = apiDriver.getSingleValueFromResponse("totalSize");
                DriverInstance.setVariable(arg4+"_count", totalSize);
            }

        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }

    @Then("Get count from {string} using {string} with contains {string} & {string} with contains {string} and Store into {string}")
    public void getCountFromObjectWithAndintoContains( String arg1, String arg2, String arg3, String arg31, String arg32, String arg4) throws Exception {

        if (arg3.contains("SysData")) {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }

        if (arg32.contains("SysData")) {
            arg32 = DriverInstance.getVariable(arg32.split("=>")[1]);
        }

        String fieldValue = "";
        String sessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT Name FROM " + arg1
                + " WHERE " + arg2 + " LIKE '%" + arg3 + "%'"
                + " AND " + arg31 + " LIKE '%" + arg32 + "%'");

            webDriver.waitForElementLoad(5);
            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
            apiDriver.submitRequest(Method.GET, URI);
            String success = apiDriver.getSingleValueFromResponse("done");
        if (success.equalsIgnoreCase("true"))
        {
            String totalSize = apiDriver.getSingleValueFromResponse("totalSize");
            DriverInstance.setVariable(arg4 + "_count", totalSize);
        }
        else{
            System.out.println("Unable to get 200");
        }



        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }


    @Then("Get count from {string} using {string} with value {string} & {string} with value {string} and Store into {string}")
    public void getCountFromObjectWithValue( String arg1, String arg2, String arg3, String arg31, String arg32, String arg4) throws Exception {

        if (arg3.contains("SysData")) {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }

        if (arg32.contains("SysData")) {
            arg32 = DriverInstance.getVariable(arg32.split("=>")[1]);
        }

        String fieldValue = "";
        String sessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT Name FROM " + arg1
                + " WHERE " + arg2 + " = '" + arg3 + "'"
                + " AND " + arg31 + " = '" + arg32 + "'");

        webDriver.waitForElementLoad(5);
        apiDriver.clearRequestHeaders();
        apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
        apiDriver.submitRequest(Method.GET, URI);
        String success = apiDriver.getSingleValueFromResponse("done");
        if (success.equalsIgnoreCase("true"))
        {
            String totalSize = apiDriver.getSingleValueFromResponse("totalSize");
            DriverInstance.setVariable(arg4 + "_count", totalSize);
        }
        else{
            System.out.println("Unable to get 200");
        }



        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }


    @Then("Get {string} from {string} using {string} with contains {string} & {string} with contains {string} & {string} with contains {string} and Store into {string}")
    public void getValueFromObjectWithAndintoContains(
            String arg0,
            String arg1,
            String arg2,
            String arg3,
            String arg31,
            String arg32,
            String arg33,
            String arg34,
            String arg4) throws Exception {

        // ---------------------------------------------------------
        // Resolve SysData values
        // ---------------------------------------------------------

        if (arg3 != null && arg3.contains("SysData=>")) {
            String variableName = arg3.split("=>", 2)[1];
            arg3 = DriverInstance.getVariable(variableName);

            System.out.println("Resolved SysData " + variableName + " = " + arg3);
        }

        if (arg32 != null && arg32.contains("SysData=>")) {
            String variableName = arg32.split("=>", 2)[1];
            arg32 = DriverInstance.getVariable(variableName);

            System.out.println("Resolved SysData " + variableName + " = " + arg32);
        }

        if (arg34 != null && arg34.contains("SysData=>")) {
            String variableName = arg34.split("=>", 2)[1];
            arg34 = DriverInstance.getVariable(variableName);

            System.out.println("Resolved SysData " + variableName + " = " + arg34);
        }

        // ---------------------------------------------------------
        // Validate values
        // ---------------------------------------------------------

        if (arg3 == null || arg3.equalsIgnoreCase("null")) {
            arg3 = "";
        }

        if (arg32 == null || arg32.equalsIgnoreCase("null")) {
            arg32 = "";
        }

        if (arg34 == null || arg34.equalsIgnoreCase("null")) {
            arg34 = "";
        }

        System.out.println("Condition 1 : " + arg2 + " = " + arg3);
        System.out.println("Condition 2 : " + arg31 + " = " + arg32);
        System.out.println("Condition 3 : " + arg33 + " = " + arg34);

        // ---------------------------------------------------------
        // Get Salesforce Session
        // ---------------------------------------------------------

        String sessionId = getSessionID();

        URI = PropReader.get("application_url");

        // ---------------------------------------------------------
        // Build SOQL WHERE conditions
        // ---------------------------------------------------------

        String condition1;
        String condition2;
        String condition3;

        // ---------------------------------------------------------
        // Condition 1
        // Participant Name is a text field
        // Therefore LIKE is correct
        // ---------------------------------------------------------

        condition1 = arg2 + " LIKE '%" + arg3 + "%'";

        // ---------------------------------------------------------
        // Condition 2
        // Trip Plan Leg is a LOOKUP field.
        //
        // Do NOT use:
        // rtms9__Trip_Plan_Leg__c LIKE '%Leg 2%'
        //
        // Instead search the related record's Name:
        // rtms9__Trip_Plan_Leg__r.Name LIKE '%Leg 2%'
        // ---------------------------------------------------------

        if (arg31.equalsIgnoreCase("rtms9__Trip_Plan_Leg__c")) {

            condition2 = "rtms9__Trip_Plan_Leg__r.Name LIKE '%"
                    + arg32
                    + "%";

            condition2 = condition2 + "'";

        } else {

            condition2 = arg31 + " LIKE '%" + arg32 + "%'";
        }

        // ---------------------------------------------------------
        // Condition 3
        //
        // Trip Plan Name is normally a lookup/ID field.
        // If SysData contains the Salesforce ID, use '='.
        //
        // Example:
        // rtms9__Trip_Plan_Name__c = 'a01xxxxxxxxxxxx'
        //
        // Do NOT use LIKE on an ID field.
        // ---------------------------------------------------------

        if (arg33.equalsIgnoreCase("rtms9__Trip_Plan_Name__c")) {

            if (!arg34.isEmpty()) {

                condition3 = arg33 + " = '" + arg34 + "'";

            } else {

                // Do not add an empty ID condition.
                condition3 = "";
            }

        } else {

            if (!arg34.isEmpty()) {

                condition3 = arg33 + " LIKE '%" + arg34 + "%'";

            } else {

                condition3 = "";
            }
        }

        // ---------------------------------------------------------
        // Build final SOQL
        // ---------------------------------------------------------

        StringBuilder soql = new StringBuilder();

        soql.append("SELECT ")
                .append(arg0)
                .append(" FROM ")
                .append(arg1)
                .append(" WHERE ")
                .append(condition1)
                .append(" AND ")
                .append(condition2);

        if (!condition3.isEmpty()) {
            soql.append(" AND ")
                    .append(condition3);
        }

        soql.append(" ORDER BY LastModifiedDate DESC LIMIT 1");

        // ---------------------------------------------------------
        // Build URL
        // ---------------------------------------------------------

        URI = URI.concat(
                "/services/data/v56.0/query?q="
                        + soql.toString()
        );

        System.out.println("============================================");
        System.out.println("SOQL Query:");
        System.out.println(soql);
        System.out.println("============================================");
        System.out.println("SOQL Query URL:");
        System.out.println(URI);
        System.out.println("============================================");

        // ---------------------------------------------------------
        // Retry logic
        // ---------------------------------------------------------

        int retryCount = 0;
        int maxRetry = 20;
        int fileCount = 0;

        String fieldValue = "";

        do {

            webDriver.waitForElementLoad(10);

            apiDriver.clearRequestHeaders();

            apiDriver.updateRequestHeader(
                    "Authorization",
                    "Bearer " + sessionId
            );

            apiDriver.submitRequest(
                    Method.GET,
                    URI
            );

            String success = apiDriver.getSingleValueFromResponse("done");

            String totalSize =
                    apiDriver.getSingleValueFromResponse("totalSize");

            System.out.println("Success : " + success);
            System.out.println("Total Size : " + totalSize);

            // -----------------------------------------------------
            // Protect against Salesforce error response
            // -----------------------------------------------------

            if (success == null
                    || success.equalsIgnoreCase("null")
                    || totalSize == null
                    || totalSize.equalsIgnoreCase("null")
                    || totalSize.isEmpty()) {

                System.out.println(
                        "Salesforce query did not return a valid result."
                );

                retryCount++;

                if (retryCount < maxRetry) {

                    System.out.println(
                            "Retry " + retryCount + "/" + maxRetry
                    );

                    Thread.sleep(1000);
                }

                continue;
            }

            // -----------------------------------------------------
            // Parse totalSize safely
            // -----------------------------------------------------

            try {

                fileCount = Integer.parseInt(
                        totalSize.replaceAll("[^0-9]", "")
                );

            } catch (NumberFormatException e) {

                System.out.println(
                        "Unable to parse totalSize: " + totalSize
                );

                fileCount = 0;
            }

            // -----------------------------------------------------
            // Record found
            // -----------------------------------------------------

            if (success.equalsIgnoreCase("true")
                    && fileCount > 0) {

                fieldValue =
                        apiDriver.getSingleValueFromResponse(
                                "records[0]." + arg0
                        );

                System.out.println(
                        "ObjectID : " + fieldValue
                );

                DriverInstance.setVariable(
                        arg4,
                        fieldValue
                );

                System.out.println(
                        "Stored " + fieldValue
                                + " into SysData=>"
                                + arg4
                );

                break;
            }

            // -----------------------------------------------------
            // Record not found
            // -----------------------------------------------------

            retryCount++;

            if (retryCount < maxRetry) {

                System.out.println(
                        "Record not found. Retry "
                                + retryCount
                                + "/"
                                + maxRetry
                );

                Thread.sleep(1000);
            }

        } while (retryCount < maxRetry);

        // ---------------------------------------------------------
        // Final validation
        // ---------------------------------------------------------

        if (fileCount == 0 || fieldValue == null || fieldValue.isEmpty()) {

            throw new Exception(
                    arg0
                            + " not found in "
                            + arg1
                            + " after "
                            + maxRetry
                            + " retries."
            );
        }

        // ---------------------------------------------------------
        // Log response and clear headers
        // ---------------------------------------------------------

        bddDriver.logResponse();

        apiDriver.clearRequestHeaders();
    }




    @Then("Get Id from {string} using {string} with contains {string} & {string} with contains {string} and Store into {string}")
    public void getIdFromObjectWithAndintoContains( String arg1, String arg2, String arg3, String arg31, String arg32, String arg4) throws Exception {
        int fileCount = 0;
        if (arg3.contains("SysData")) {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }

        if (arg32.contains("SysData")) {
            arg32 = DriverInstance.getVariable(arg32.split("=>")[1]);
        }

        String fieldValue = "";
        String sessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/query?q=SELECT Id FROM " + arg1
                + " WHERE " + arg2 + " LIKE '%" + arg3 + "%'"
                + " AND " + arg31 + " LIKE '%" + arg32 + "%'"
                + " ORDER BY LastModifiedDate DESC LIMIT 1");

            webDriver.waitForElementLoad(5);
            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader("Authorization", "Bearer " + sessionId);
            apiDriver.submitRequest(Method.GET, URI);

            String success = apiDriver.getSingleValueFromResponse("done");
            String totalSize = apiDriver.getSingleValueFromResponse("totalSize");

            fileCount = Integer.parseInt(totalSize);
            DriverInstance.setVariable(arg4+"_count",totalSize);

            if (success.equalsIgnoreCase("true") && fileCount > 0) {
                fieldValue = apiDriver.getSingleValueFromResponse("records[0].Id");
                System.out.println("ObjectID : " + fieldValue);
                DriverInstance.setVariable(arg4, fieldValue);
            }

        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }




    public File DownloadFileWithContentVersion(String DocumentName) throws Exception {
        String id = GetContentDocumentLink(DriverInstance.getVariable("GetElementID"),DocumentName);
//        String id1 = GetContentVersion(id);
        String accessToken = getSessionID(); // must be a valid OAuth / SOAP session token
        String instanceUrl = PropReader.get("application_url");
        // 2️⃣  Construct VersionData REST URL
        String fileUrl = instanceUrl + "/services/data/v59.0/sobjects/ContentVersion/"
                + id + "/VersionData";
        System.out.println("Fetching PDF from: " + fileUrl);
        // 3️⃣  Make authorized HTTP GET request
        URL url = new URL(fileUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
        conn.setRequestProperty("Accept", "application/pdf");

        int code = conn.getResponseCode();
        System.out.println("HTTP Response: " + code + " (" + conn.getResponseMessage() + ")");
        System.out.println("Content-Type: " + conn.getContentType());

        if (code != 200) {
            // Print error for debugging
            try (InputStream err = conn.getErrorStream()) {
                if (err != null) {
                    System.out.println("Error response:\n" + new String(err.readAllBytes()));
                }
            }
            throw new IOException("Failed to download PDF. HTTP " + code);
        }
        // 4️⃣  Save file locally for inspection (optional)
        File pdfFile = new File(System.getProperty("user.dir") + File.separator + "DownloadedFiles" + File.separator + "downloaded_salesforce_file.pdf");
        try (InputStream in = conn.getInputStream();
             FileOutputStream out = new FileOutputStream(pdfFile)) {
            in.transferTo(out);
        }
        System.out.println("✅ File downloaded: " + pdfFile.getAbsolutePath());
        apiDriver.clearRequestHeaders();
        return pdfFile;
    }

    public File DownloadFileWithRecordId() throws Exception {
    String recordId = DriverInstance.getVariable("GetElementID")
            .replace("'", "")
            .trim();
        String instanceUrl = PropReader.get("application_url").replace(".scratch.my.salesforce.com","--rtms9.scratch.vf.force.com");
    String fileUrl = instanceUrl + "/apex/PaySettlementPDF?id=" + recordId;
    System.out.println("Fetching PDF from: " + fileUrl);
    webDriver.OpenURL(fileUrl);
    webDriver.waitForElementLoad(6);

    // Build cookies from Selenium session
    String cookieHeader = webDriver.getPaySettlementPdfCookies();

    System.out.println("Cookie Header: " + cookieHeader);

    URL url = new URL(fileUrl);

    HttpURLConnection conn =
            (HttpURLConnection) url.openConnection();

    conn.setRequestMethod("GET");

    conn.setRequestProperty(
            "Cookie",
            cookieHeader
    );

    conn.setRequestProperty(
            "User-Agent",
            "Mozilla/5.0"
    );

    conn.setRequestProperty(
            "Accept",
            "application/pdf"
    );

    conn.setConnectTimeout(30000);
    conn.setReadTimeout(60000);

    // Don't follow redirects while debugging
    conn.setInstanceFollowRedirects(false);

    int responseCode = conn.getResponseCode();

    System.out.println(
            "HTTP Response: "
                    + responseCode
                    + " ("
                    + conn.getResponseMessage()
                    + ")"
    );

    System.out.println(
            "Content-Type: "
                    + conn.getContentType()
    );

    System.out.println(
            "Location: "
                    + conn.getHeaderField("Location")
    );

    if (responseCode == HttpURLConnection.HTTP_OK &&
            conn.getContentType() != null &&
            conn.getContentType()
                    .toLowerCase()
                    .contains("application/pdf")) {

        File downloadDirectory =
                new File(
                        System.getProperty("user.dir"),
                        "DownloadedFiles"
                );

        if (!downloadDirectory.exists()) {
            downloadDirectory.mkdirs();
        }
        File pdfFile = new File(System.getProperty("user.dir") + File.separator + "DownloadedFiles" + File.separator + "downloaded_salesforce_file.pdf");
        DriverInstance.setVariable("PDFFilePath", pdfFile.getAbsolutePath());
        try (
                InputStream inputStream =
                        conn.getInputStream();

                FileOutputStream outputStream =
                        new FileOutputStream(pdfFile)
        ) {

            byte[] buffer = new byte[8192];

            int bytesRead;

            while ((bytesRead =
                    inputStream.read(buffer)) != -1) {

                outputStream.write(
                        buffer,
                        0,
                        bytesRead
                );
            }
        }

        System.out.println(
                "✅ PDF downloaded: "
                        + pdfFile.getAbsolutePath()
        );

        return pdfFile;
    }

    // Not a PDF
    String responseBody;

    try (InputStream inputStream =
                 conn.getInputStream()) {

        responseBody =
                new String(
                        inputStream.readAllBytes(),
                        StandardCharsets.UTF_8
                );
    }

    System.out.println(
            "========== RESPONSE =========="
    );

    System.out.println(responseBody);

    System.out.println(
            "========== END RESPONSE =========="
    );

    throw new IOException(
            "Expected PDF but received HTTP "
                    + responseCode
                    + ", Content-Type: "
                    + conn.getContentType()
    );
}


    @Then("Get Access token using {string} and store in {string}")
    public void getAccessToken(String filename, String Access_Token) throws Exception {

        URI = "https://api.axleapi.com/v1/token";
        apiDriver.updateRequestHeader("Content-Type", "text/json");

        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Path = "TestCaseFiles" + File.separator +TID+ File.separator + filename;
        apiDriver.readPayload(Path);
        apiDriver.generatePayLoad();
        apiDriver.submitRequest(Method.POST, URI);
        bddDriver.logResponse();
        String token = apiDriver.getSingleValueFromResponse("access_token");
        System.out.println("Access Token: "+token);
        DriverInstance.setVariable(Access_Token,token);
        apiDriver.clearRequestHeaders();


    }

    @Then("Get Fleet Code using {string} for Fleet ID {string}")
    public String getFleetCodeUsing(String arg0, String arg1) throws Exception {
        if(arg1.contains("SysData"))
        {
            arg1=DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        URI = "https://api.axleapi.com/v1/fleet/codes";
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable(arg0));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response: "+apiDriver.RetrurnResponce());
        String resp=apiDriver.RetrurnResponce();
        JsonPath jsonPath = new JsonPath(resp);
        String fleetCode = jsonPath.getString(
                "fleets.find { it.fleet_id == "+arg1+" }.fleet_code"
        );
        String tsp_id = findMotiveAxleIdByFleetId(resp,arg1);
        String Samsara_tsp_id = findSamsaraAxleIdByFleetId(resp,arg1);
        DriverInstance.setVariable("AxleID", tsp_id);
        DriverInstance.setVariable("fleet_code", fleetCode);
        DriverInstance.setVariable("Samsara_AxleID", Samsara_tsp_id);
        System.out.println("Motive Axle ID: "+DriverInstance.getVariable("AxleID"));
        apiDriver.clearRequestHeaders();
        return apiDriver.RetrurnResponce();
    }
    public String findMotiveAxleIdByFleetId(String json, String targetFleetId) throws Exception {

        JsonNode root = MAPPER.readTree(json);

        for (JsonNode fleet : root.path("fleets")) {

            if (targetFleetId.equals(fleet.path("fleet_id").asText())) {

                for (JsonNode tsp : fleet.path("tsps")) {
                    if ("motive".equalsIgnoreCase(tsp.path("tsp_source").asText())) {
                        return tsp.path("axle_tsp_id").asText();
                    }
                }
            }
        }
        return null; // Fleet or Motive TSP not found
    }

    public String findSamsaraAxleIdByFleetId(String json, String targetFleetId) throws Exception {

        JsonNode root = MAPPER.readTree(json);

        for (JsonNode fleet : root.path("fleets")) {

            if (targetFleetId.equals(fleet.path("fleet_id").asText())) {

                for (JsonNode tsp : fleet.path("tsps")) {
                    if ("samsara".equalsIgnoreCase(tsp.path("tsp_source").asText())) {
                        return tsp.path("axle_tsp_id").asText();
                    }
                }
            }
        }
        return null; // Fleet or Motive TSP not found
    }


    @Then("Get Fleet Code using {string}")
    public String getFleetCodeUsing(String arg0) throws Exception {
        URI = "https://api.axleapi.com/v1/fleet/codes";
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable(arg0));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response: "+apiDriver.RetrurnResponce());
        String resp=apiDriver.RetrurnResponce();
        List<Long> AxleID = findMotiveAxleIds(resp);
        for (Long id : AxleID) {
            System.out.println(id);
            DriverInstance.setVariable("AxleID", String.valueOf(id));
        }
        if (AxleID != null && !AxleID.isEmpty()) {
            boolean allSame = new HashSet<>(AxleID).size() == 1;
            System.out.println("All values same? " + allSame);
        } else {
            System.out.println("List is empty or null.");
        }
        System.out.println("Motive Axle ID: "+DriverInstance.getVariable("AxleID"));
        apiDriver.clearRequestHeaders();
        return apiDriver.RetrurnResponce();
    }
    public static List<Long> findMotiveAxleIds(String json) throws Exception {
        List<Long> ids = new ArrayList<>();
        JsonNode root = MAPPER.readTree(json);
        JsonNode fleets = root.get("fleets");
        if (fleets != null && fleets.isArray()) {
            for (JsonNode fleet : fleets) {
                JsonNode tsps = fleet.get("tsps");
                if (tsps != null && tsps.isArray()) {
                    for (JsonNode tsp : tsps) {
                        JsonNode source = tsp.get("tsp_source");
                        if (source != null && "motive".equalsIgnoreCase(source.asText())) {
                            JsonNode axleNode = tsp.get("axle_tsp_id");
                            if (axleNode != null && !axleNode.isNull()) {
                                ids.add(axleNode.asLong());
                            }
                        }
                    }
                }
            }
        }
        return ids;
    }

    @Then("Get Fleet Code using {string} and for {string}")
    public String getFleetCodeUsingData(String arg0, String tspSource) throws Exception {

        URI = "https://api.axleapi.com/v1/fleet/codes";
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable(arg0));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response: "+apiDriver.RetrurnResponce());
        String resp=apiDriver.RetrurnResponce();
        List<Long> AxleID = findAxleIds(resp, tspSource);
        for (Long id : AxleID) {
            System.out.println(id);
            DriverInstance.setVariable("AxleID", String.valueOf(id));
        }
        if (AxleID != null && !AxleID.isEmpty()) {
            boolean allSame = new HashSet<>(AxleID).size() == 1;
            System.out.println("All values same? " + allSame);
        } else {
            System.out.println("List is empty or null.");
        }
        System.out.println("Axle ID for "+tspSource+" is: "+DriverInstance.getVariable("AxleID"));

        List<String> fleetCodes = findFleetCodes(resp, tspSource);
        System.out.println("Fleet codes with " + tspSource + ": " + fleetCodes);

        if (!fleetCodes.isEmpty()) {
            DriverInstance.setVariable("FleetCode", fleetCodes.get(0));
            System.out.println("Saved FleetCode: " + DriverInstance.getVariable("FleetCode"));
        }
        apiDriver.clearRequestHeaders();
        return apiDriver.RetrurnResponce();
    }
    public static List<Long> findAxleIds(String json, String tspSource) throws Exception {
        List<Long> ids = new ArrayList<>();
        JsonNode root = MAPPER.readTree(json);
        JsonNode fleets = root.get("fleets");
        if (fleets != null && fleets.isArray()) {
            for (JsonNode fleet : fleets) {
                JsonNode tsps = fleet.get("tsps");
                if (tsps != null && tsps.isArray()) {
                    for (JsonNode tsp : tsps) {
                        JsonNode source = tsp.get("tsp_source");
                        if (source != null && tspSource.equalsIgnoreCase(source.asText())) {
                            JsonNode axleNode = tsp.get("axle_tsp_id");
                            if (axleNode != null && !axleNode.isNull()) {
                                ids.add(axleNode.asLong());
                            }
                        }
                    }
                }
            }
        }
        return ids;
    }
    public static List<String> findFleetCodes(String json, String tspSource) throws Exception {
        List<String> codes = new ArrayList<>();
        JsonNode root = MAPPER.readTree(json);
        JsonNode fleets = root.get("fleets");
        if (fleets != null && fleets.isArray()) {
            for (JsonNode fleet : fleets) {
                JsonNode tsps = fleet.get("tsps");
                if (tsps != null && tsps.isArray()) {
                    for (JsonNode tsp : tsps) {
                        JsonNode source = tsp.get("tsp_source");
                        if (source != null && tspSource.equalsIgnoreCase(source.asText())) {
                            JsonNode codeNode = fleet.get("fleet_code");
                            if (codeNode != null && !codeNode.isNull()) {
                                codes.add(codeNode.asText());
                                // break here if you want only one code per fleet even if multiple tsps match
                                break;
                            }
                        }
                    }
                }
            }
        }
        return codes;
    }

    @Then("Create a Vehicle using updated payload")
    public void createAVehicleUsingAndUpdateBelowAttributes() throws Exception {

        URI = "https://api.axleapi.com/v1/vehicle";
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable("Access_Token"));
        apiDriver.payloadFromPOJOClass(DriverInstance.getVariable("Updated_Payload"));
        apiDriver.generatePayLoad();
        apiDriver.submitRequest(Method.POST, URI);
        bddDriver.logResponse();
        System.out.println("Response "+apiDriver.RetrurnResponce());
        if(apiDriver.RetrurnResponce().contains("Internal Server Error") )
        {
            Assert.fail("Unable to create Vehicles - Getting "+apiDriver.RetrurnResponce());
        }
//        apiDriver.assertStatusCode(201);
        apiDriver.clearRequestHeaders();
        DriverInstance.setVariable("ID",apiDriver.getSingleValueFromResponse("id"));
    }

    @Then("Update payload on {string}")
    public void updatePayload(String arg0,DataTable dt) throws Exception{

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg0;
        String request_Expected = apiDriver.readRequestTemplate(Path);
        request_Expected = request_Expected.replace("{email}", propertyReader.readproperty("LoggedInUser"));
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);

        // Format as YYYY-MM-DD
        String formattedDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        request_Expected = request_Expected.replace("{CurrentData}", formattedDate);

        String formattedDate2 = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        request_Expected = request_Expected.replace("{CurrentDateYYYYMMDD}", formattedDate2);

        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                if(!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().contains("SysData")) {
                        String Value = entry.getValue().split("=>")[1];
                        System.out.println("Value after split: "+Value);
                        request_Expected = request_Expected.replace(entry.getKey(), DriverInstance.getVariable(Value));
                    }

                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        request_Expected = request_Expected.replace(entry.getKey(), formattedDate11);
                    }
                    else {
                        request_Expected = request_Expected.replace(entry.getKey(), entry.getValue());
                        System.out.println("I am in else block");
                    }
                }
            }
        }
        DriverInstance.setVariable("Updated_Payload",request_Expected);
     //   System.out.println("Man "+request_Expected);
    }

    @Then("Set {string} value as {string}")
    public void setValueAs(String field, String pattern) {
        String value = generateDynamicValue(pattern);
        DriverInstance.setVariable(field, value);
        System.out.println("Stored value:"+DriverInstance.getVariable(field));
    }

    public static String generateDynamicValue(String pattern) {
        // Regex to find {currentDate=>...}
        String regex = "\\{currentDate=>([^}]+)\\}";
        Matcher matcher = Pattern.compile(regex).matcher(pattern);

        String result = pattern;

        while (matcher.find()) {
            String dateFormat = matcher.group(1);
            String formattedDate = new SimpleDateFormat(dateFormat).format(new Date());
            result = result.replace(matcher.group(0), formattedDate);
        }

        // Remove "+" signs (optional, if used as separators)
        result = result.replace("+", "");
        return result;
    }

    @Then("Get Fleet details using {string}")
        public void getFleetDetailsUsing(String arg0) {

        if(arg0.contains("SysData"))
        {
            String Value=arg0.split("=>")[1];
            String fleetID=DriverInstance.getVariable(Value);
            System.out.println("FleetID:"+fleetID);
            URI = " https://api.axleapi.com/v1/fleet/vehicles?fleet_id="+fleetID+"&include_details=true";
        }
        else {
            URI = " https://api.axleapi.com/v1/fleet/vehicles?fleet_id=" + arg0 + "&include_details=true";
        }
            apiDriver.updateRequestHeader("Content-Type", "text/json");
            apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable("Access_Token"));
            apiDriver.payloadFromPOJOClass(DriverInstance.getVariable("Updated_Payload"));
            apiDriver.generatePayLoad();

        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response :"+apiDriver.RetrurnResponce());
        String FleetResponse=apiDriver.RetrurnResponce();
        DriverInstance.setVariable("FleetResponse", FleetResponse);
        apiDriver.clearRequestHeaders();
    }

    @Then("Search {string} doesn't present in response")
    public void searchDoesnTPresentInResponse(String arg0) {
        if(!DriverInstance.getVariable("FleetResponse").contains("arg0")){
            System.out.println("Response doesn't contains "+arg0);
        }
        else{
            Assert.fail("Response shouldn't contain "+arg0);
        }
    }
    @Then("Get Driver {string} Details using {string}")
    public void getDriverDetails(String driverName, String arg0) throws Exception {
//        DriverInstance.setVariable("Customer_Number","69440");
        URI = "https://api.axleapi.com/v1/fleet/drivers?fleet_id="+DriverInstance.getVariable("Customer_Number")+"&include_details=true";
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable(arg0));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response: "+apiDriver.RetrurnResponce());
        String resp=apiDriver.RetrurnResponce();
        JsonNode root = MAPPER.readTree(resp);
        if(driverName.contains("SysData"))
        {
            String Value = driverName.split("=>")[1];
            driverName= DriverInstance.getVariable(Value);
        }
        DriverInstance.setVariable("Driver_id", getField(root, driverName, "id"));
        DriverInstance.setVariable("Driver_TimeZone", getField(root, driverName, "timezone"));
        DriverInstance.setVariable("Driver_work_rules.break", getField(root, driverName, "work_rules.break"));
        DriverInstance.setVariable("Driver_work_rules.cycle", getField(root, driverName, "work_rules.cycle"));
        DriverInstance.setVariable("Driver_work_rules.restart", getField(root, driverName, "work_rules.restart"));
        DriverInstance.setVariable("Driver_work_rules.shift", getField(root, driverName, "work_rules.shift"));
        DriverInstance.setVariable("Driver_work_rules.jurisdiction", getField(root, driverName, "work_rules.jurisdiction"));

        DriverInstance.setVariable("Driver_fleet_id", getField(root, driverName, "fleet_id"));
        DriverInstance.setVariable("Driver_time", getField(root, driverName, "time"));
        DriverInstance.setVariable("Driver_tsp_source", getField(root, driverName, "tsp_source"));
        DriverInstance.setVariable("Driver_name", getField(root, driverName, "name"));
        DriverInstance.setVariable("Driver_username", getField(root, driverName, "username"));
        DriverInstance.setVariable("Driver_phone", getField(root, driverName, "phone"));
        DriverInstance.setVariable("Driver_status", getField(root, driverName, "status"));
        DriverInstance.setVariable("Driver_notes", getField(root, driverName, "notes"));

        DriverInstance.setVariable("Driver_carrier_Name", getField(root, driverName, "carrier.carrier_name"));
        DriverInstance.setVariable("Driver_dot_number", getField(root, driverName, "carrier.dot_number"));

        DriverInstance.setVariable("Driver_license_number", getField(root, driverName, "license.license_number"));
        DriverInstance.setVariable("Driver_license_state", getField(root, driverName, "license.license_state"));
        DriverInstance.setVariable("Driver_license_country", getField(root, driverName, "license.license_country"));


        apiDriver.clearRequestHeaders();
    }

    public static Map<String, String> extractDriverFields(String jsonBody, String driverName) throws IOException {
        Map<String, String> result = new HashMap<>();
        // default empty values
        result.put("timezone", "");
        result.put("break", "");
        result.put("cycle", "");
        result.put("restart", "");

        JsonNode root = MAPPER.readTree(jsonBody);
        JsonNode details = root.path("details");
        if (!details.isArray()) return result; // no details array

        for (JsonNode driverNode : details) {
            JsonNode nameNode = driverNode.path("name");
            if (nameNode.isTextual() && driverName.equals(nameNode.asText())) {
                // timezone
                result.put("timezone", driverNode.path("timezone").asText(""));

                // work_rules object
                JsonNode workRules = driverNode.path("work_rules");
                if (workRules.isObject()) {
                    result.put("break", workRules.path("break").asText(""));
                    result.put("cycle", workRules.path("cycle").asText(""));
                    result.put("restart", workRules.path("restart").asText(""));
                }
                break; // found target driver; exit loop
            }
        }

        return result;
    }
    public static String getField(JsonNode root, String driverName, String fieldPath) {
        JsonNode details = root.path("details");

        if (!details.isArray()) return "";

        for (JsonNode driver : details) {
            if (driver.path("name").asText("").equals(driverName)) {
                return getNestedValue(driver, fieldPath);
            }
        }
        return "";
    }
    public static String getNestedValue(JsonNode node, String fieldPath) {
        String[] parts = fieldPath.split("\\.");
        JsonNode current = node;

        for (String part : parts) {
            current = current.path(part);
            if (current.isMissingNode() || current.isNull()) {
                return ""; // safely return empty when not found
            }
        }
        return current.asText("");
    }

    @Then("Get Trimble Trip Management External OrderIds")
    public void verifyTrimbleTripManagemetExternalOrderIdsAs() {
        URI = "https://tripmanagement.alk.com/api/trip/"+DriverInstance.getVariable("API Trip Id");
        apiDriver.updateRequestHeader("Authorization","DB819E967F1D1B4F85B54536F14A716E");
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        DriverInstance.setVariable("Response",apiDriver.RetrurnResponce());
        String externalOrderIds = apiDriver.getSingleValueFromResponse("externalOrderIds");
        String TripSegmentName = apiDriver.getSingleValueFromResponse("name");
        String actualStartDate = apiDriver.getSingleValueFromResponse("actualStartDate");
        String plannedStartTime = apiDriver.getSingleValueFromResponse("plannedStartTime");
        String plannedStartLocation = apiDriver.getSingleValueFromResponse("plannedStartLocation");
        String tripStatus = apiDriver.getSingleValueFromResponse("tripStatus");
        String stop1 = apiDriver.getSingleValueFromResponse("stops[0]");
        String stop1_earliestArrivalTime = apiDriver.getSingleValueFromResponse("stops[0].earliestArrivalTime");
        String stop1_latestArrivalTime = apiDriver.getSingleValueFromResponse("stops[0].latestArrivalTime");
        String stop1_actualArrivalTime = apiDriver.getSingleValueFromResponse("stops[0].actualArrivalTime");

        String stop2 = apiDriver.getSingleValueFromResponse("stops[1]");
        String stop2_earliestArrivalTime = apiDriver.getSingleValueFromResponse("stops[1].earliestArrivalTime");
        String stop2_latestArrivalTime = apiDriver.getSingleValueFromResponse("stops[1].latestArrivalTime");
        String stop2_actualArrivalTime = apiDriver.getSingleValueFromResponse("stops[1].actualArrivalTime");
        String stop2_actualDepartureTime = apiDriver.getSingleValueFromResponse("stops[1].actualDepartureTime");

        String driverHoursOfService = apiDriver.getSingleValueFromResponse("driverHoursOfService");

        DriverInstance.setVariable("plannedStartLocation",plannedStartLocation);
        DriverInstance.setVariable("Name",TripSegmentName);
        DriverInstance.setVariable("actualStartDate",actualStartDate);
        DriverInstance.setVariable("tripStatus",tripStatus);
        DriverInstance.setVariable("stop1",stop1);
        DriverInstance.setVariable("stop1_earliestArrivalTime",stop1_earliestArrivalTime);
        DriverInstance.setVariable("stop1_latestArrivalTime",stop1_latestArrivalTime);
        DriverInstance.setVariable("stop1_actualArrivalTime",stop1_actualArrivalTime);
        DriverInstance.setVariable("stop2",stop2);
        DriverInstance.setVariable("stop2_earliestArrivalTime",stop2_earliestArrivalTime);
        DriverInstance.setVariable("stop2_latestArrivalTime",stop2_latestArrivalTime);
        DriverInstance.setVariable("stop2_actualArrivalTime",stop2_actualArrivalTime);
        DriverInstance.setVariable("stop2_actualDepartureTime",stop2_actualDepartureTime);
        DriverInstance.setVariable("plannedStartTime",plannedStartTime);
        DriverInstance.setVariable("driverHoursOfService",driverHoursOfService);
        DriverInstance.setVariable("externalOrderIds",externalOrderIds);
        apiDriver.clearRequestHeaders();

    }

    @Then("Get Trimble Trip Management Details with API Trip Id as {string} and store response onto {string}")
    public void verifyTrimbleTripManagemetExternalOrderIdsAs1(String APITripID,String arg) {
        URI = "https://tripmanagement.alk.com/api/trip/"+DriverInstance.getVariable(APITripID);
        apiDriver.updateRequestHeader("Authorization","DB819E967F1D1B4F85B54536F14A716E");
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        DriverInstance.setVariable(arg,apiDriver.RetrurnResponce());
        apiDriver.clearRequestHeaders();

    }

    @Then("Get Trip Status and Name from Trimble for Trip Id {string}")
    public void getTrimbleTripInformation(String arg0) {
        URI = "https://tripmanagement.alk.com/api/trip/"+DriverInstance.getVariable(arg0);
        apiDriver.updateRequestHeader("Authorization","DB819E967F1D1B4F85B54536F14A716E");
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        DriverInstance.setVariable("Response",apiDriver.RetrurnResponce());
        String externalOrderIds = apiDriver.getSingleValueFromResponse("externalOrderIds");
        String TripSegmentName = apiDriver.getSingleValueFromResponse("name");
        String tripStatus = apiDriver.getSingleValueFromResponse("tripStatus");
        DriverInstance.setVariable("Name",TripSegmentName);
        DriverInstance.setVariable("tripStatus",tripStatus);
        DriverInstance.setVariable("externalOrderIds",externalOrderIds);
        apiDriver.clearRequestHeaders();
    }

    @Then("Get Trimble GPS Information for Trip Id {string}")
    public void getTrimbleGPSInformation(String arg0) {
        URI = "https://tripmanagement.alk.com/api/trip/"+DriverInstance.getVariable(arg0)+"/gps";
        apiDriver.updateRequestHeader("Authorization","DB819E967F1D1B4F85B54536F14A716E");
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        DriverInstance.setVariable("Response",apiDriver.RetrurnResponce());
        String CoOrdinate = apiDriver.getSingleValueFromResponse("features[0].geometry.coordinates");
        String DeviceTime = apiDriver.getSingleValueFromResponse("features[0].properties.deviceTime");
        String Heading = apiDriver.getSingleValueFromResponse("features[0].properties.heading");
        String Speed = apiDriver.getSingleValueFromResponse("features[0].properties.speed");

        OffsetDateTime utcDateTime = OffsetDateTime.parse(DeviceTime);
        String ctTime = utcDateTime
                .atZoneSameInstant(ZoneId.of("America/Chicago"))
                .format(DateTimeFormatter.ofPattern("MM/dd/yyyy hh:mm a"));
        System.out.println(ctTime);

        DriverInstance.setVariable("CoOrdinate",CoOrdinate);
        DriverInstance.setVariable("DeviceTime",ctTime);
        DriverInstance.setVariable("Direction",Heading);
        DriverInstance.setVariable("Speed",Speed);
        apiDriver.clearRequestHeaders();
    }

    @Then("Get ELD_Id for Driver {string} on {string}")
    public void getELD_IdForDriverOn(String arg0, String arg1) {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("Delete All Loads associated with {string}")
    public void deleteAllLoadsAssociatedWith(String arg0) throws Exception {
        int Count;
        do {
            String SessionId = getSessionID();
            URI = PropReader.get("application_url");
            URI = URI.concat("/services/data/v56.0/query?q=SELECT Id, Name FROM rtms__Load__c WHERE rtms__Customer__c='" + DriverInstance.getVariable(arg0) + "'");
            apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
            apiDriver.submitRequest(Method.GET, URI);

            String success = apiDriver.getSingleValueFromResponse("done");
            String fileCount = apiDriver.getSingleValueFromResponse("totalSize");
            Count = Integer.parseInt(fileCount);

            if (success.equalsIgnoreCase("true")&& Integer.parseInt(fileCount)>0) {
                String LoadID = apiDriver.getSingleValueFromResponse("records[0].Id");
                System.out.println("LoadID :" + LoadID);
                DriverInstance.setVariable("LoadSFID", LoadID);
            } else {
                System.out.println("Load Not Found for this Account");
//            Assert.fail("File not Deletred correctly!! ");
            }
            if (DriverInstance.getVariable("LoadSFID") != null && !DriverInstance.getVariable("LoadSFID").isEmpty()) {
                URI = PropReader.get("application_url");
//                apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
                URI = URI.concat("/services/data/v57.0/sobjects/rtms__Load__c/" + DriverInstance.getVariable("LoadSFID"));
                System.out.println(URI);
                apiDriver.submitRequest(Method.DELETE, URI);
                bddDriver.logResponse();
            }
            apiDriver.clearRequestHeaders();
        }
        while (Count > 1);
    }

    @Then("Delete All Records with name {string} for {string}")
    public void deleteAllRecordsAssociatedToName(String arg0, String arg1) throws Exception {
        if(arg0 .contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        int Count;
        int runCount = 0;
        int maxRuns = 40;
        do {
            runCount++;
            String SessionId = getSessionID();
            URI = PropReader.get("application_url");
            URI = URI.concat("/services/data/v56.0/query?q=SELECT Id, Name FROM "+arg1+" WHERE Name LIKE '%" +arg0+ "%'");
            apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
            apiDriver.submitRequest(Method.GET, URI);
            String success = apiDriver.getSingleValueFromResponse("done");
            String fileCount = apiDriver.getSingleValueFromResponse("totalSize");
            Count = Integer.parseInt(fileCount);

            if (success.equalsIgnoreCase("true")&& Integer.parseInt(fileCount)>0) {
                String LoadID = apiDriver.getSingleValueFromResponse("records[0].Id");
                System.out.println("ID :" + LoadID);
                DriverInstance.setVariable("SFID", LoadID);
            } else {
                System.out.println("Load Not Found for this Account");
            }
            if (DriverInstance.getVariable("SFID") != null && !DriverInstance.getVariable("SFID").isEmpty()) {
                URI = PropReader.get("application_url");
                URI = URI.concat("/services/data/v57.0/sobjects/"+arg1+"/" + DriverInstance.getVariable("SFID"));
                System.out.println(URI);
                apiDriver.submitRequest(Method.DELETE, URI);
                bddDriver.logResponse();
            }
            apiDriver.clearRequestHeaders();
        }
        while (Count > 1 && runCount < maxRuns);
    }

    @Then("Delete All Records with {string} as {string} for {string}")
    public void deleteAllRecordsAssociatedToFieldName(String FieldName , String arg0, String arg1) throws Exception {
        if(arg0 .contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        int Count;
        int runCount = 0;
        int maxRuns = 50;
        do {
            runCount++;
            String SessionId = getSessionID();
            URI = PropReader.get("application_url");
            URI = URI.concat("/services/data/v56.0/query?q=SELECT Id, Name FROM "+arg1+" WHERE "+FieldName+ "='" +arg0+ "'");
            apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
            apiDriver.submitRequest(Method.GET, URI);
            String success = apiDriver.getSingleValueFromResponse("done");
            String fileCount = apiDriver.getSingleValueFromResponse("totalSize");
            Count = Integer.parseInt(fileCount);

            if (success.equalsIgnoreCase("true")&& Integer.parseInt(fileCount)>0) {
                String LoadID = apiDriver.getSingleValueFromResponse("records[0].Id");
                System.out.println("ID :" + LoadID);
                DriverInstance.setVariable("SFID", LoadID);
            } else {
                System.out.println("Load Not Found for this Account");
            }
            if (DriverInstance.getVariable("SFID") != null && !DriverInstance.getVariable("SFID").isEmpty()) {
                URI = PropReader.get("application_url");
                URI = URI.concat("/services/data/v57.0/sobjects/"+arg1+"/" + DriverInstance.getVariable("SFID"));
                System.out.println(URI);
                apiDriver.submitRequest(Method.DELETE, URI);
                bddDriver.logResponse();
            }
            apiDriver.clearRequestHeaders();
        }
        while (Count > 1 && runCount < maxRuns);
    }


    @Then("Get {string} for EDI")
    public void getForEDI(String arg0) throws Exception {
          String SessionId = getSessionID();
          DriverInstance.setVariable(arg0,SessionId);
         apiDriver.clearRequestHeaders();
    }

    @Then("Send Post Request for EDI with Json {string} with Access Token as {string}")
    public void sendPostRequestForEDIWithJsonWithAccessTokenAs(String arg0, String arg1) throws Exception {

        String BaseURI = PropReader.get("application_url");
        URI = BaseURI.concat("/services/apexrest/rtms/ediService");
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable(arg1));
        apiDriver.setRequestBody(readTextFile(arg0));
        apiDriver.generatePayLoad();
        apiDriver.submitRequest(Method.POST, URI);
        bddDriver.logResponse();
        System.out.println("Response "+apiDriver.RetrurnResponce());
        apiDriver.assertStatusCode(201);
        if(!apiDriver.RetrurnResponce().contains("EDI events queued") )
        {
            Assert.fail("Not get EDI events queued on Response , getting Response as "+apiDriver.RetrurnResponce());
        }
        apiDriver.clearRequestHeaders();
    }

    @Then("Send Get Request for EDI with Access Token as {string}")
    public void sendGetRequestForEDIWithJsonWithAccessTokenAs(String arg0) throws IOException {
        String BaseURI = PropReader.get("application_url");
        URI = BaseURI.concat("/services/apexrest/rtms/ediService");
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable(arg0));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response "+apiDriver.RetrurnResponce());
        DriverInstance.setVariable("EDI_API_Response",apiDriver.RetrurnResponce());
        apiDriver.assertStatusCode(200);
        apiDriver.clearRequestHeaders();
    }

    public String readTextFile(String filename) throws IOException {
        String scenarioName= DriverInstance.getScenarioName();
        System.out.println("scenarioName:"+scenarioName);
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        System.out.println("TID:"+TID);
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        File file = new File(Root + "TestCaseFiles" + File.separator +TID+ File.separator + filename);
        return new String(Files.readAllBytes(Paths.get(file.getAbsolutePath())));
    }

    @Then("Triumphpay - Get Load details for {string} with Authorization of {string}")
    public void triumphpayGetLoadDetailsFor(String arg0, String arg1) {
        if(arg0.contains("SysData"))
        {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        String BaseURI = "https://api.audit.triumphpay.com";
        URI = BaseURI.concat("/tms/loads?load_id="+arg0);
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable(arg1));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response "+apiDriver.RetrurnResponce());
        DriverInstance.setVariable("Triumphpay_API_Response",apiDriver.RetrurnResponce());
        apiDriver.assertStatusCode(200);
        apiDriver.clearRequestHeaders();
    }

    @Then("Delete {string} from Apex job")
    public void deleteFromApexJob(String jobName) throws Exception {

        int retries = 5;

        while (retries-- > 0) {

            String sessionId = getSessionID();

            String apexCode =
                    "for (AsyncApexJob job : [SELECT Id FROM AsyncApexJob " +
                            "WHERE Status != 'Aborted' " +
                            "AND Status != 'Completed' " +
                            "AND ApexClass.Name = '" + jobName + "']) {" +
                            "System.abortJob(job.Id);" +
                            "}";

            String uri = PropReader.get("application_url")
                    + "/services/data/v56.0/tooling/executeAnonymous/";

            apiDriver.updateRequestHeader("Authorization",
                    "Bearer " + sessionId);
            System.out.println("Final URI = " + uri);
            apiDriver.addQueryParameters("anonymousBody",apexCode);
            apiDriver.submitRequest(Method.GET, uri);

            System.out.println("Response: " + apiDriver.RetrurnResponce());

            String success =
                    apiDriver.getSingleValueFromResponse("success");

            if ("true".equalsIgnoreCase(success)) {
                System.out.println("Deleted");
                break;
            } else {
                System.out.println("No active job found");
            }
        }
    }

    @Then("Send Get Request for Trip details for {string} with Access Token as {string}")
    public void sendGetRequestForTripDetailsWithAccessTokenAs(String arg0, String arg1) throws IOException {
        String BaseURI = "https://api.axleapi.com/v1/trip/";
        if(arg0.contains("SysData")){
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        URI = BaseURI.concat(arg0);
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+DriverInstance.getVariable(arg1));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response :"+apiDriver.RetrurnResponce());
        DriverInstance.setVariable("Trip_Details",apiDriver.RetrurnResponce());
        apiDriver.assertStatusCode(200);
        apiDriver.clearRequestHeaders();
    }


    @Then("Verify the datetime {string} is today and in future for timezone {string}")
    public void verifyDateTimeIsTodayAndFuture(String dateTime, String timezone) {

        if(dateTime.contains("SysData"))
        {
            dateTime=DriverInstance.getVariable(dateTime.split("=>")[1]);
        }
        // Parse input datetime
        OffsetDateTime inputDateTime = OffsetDateTime.parse(dateTime);

        // Convert input datetime to requested timezone
        ZoneId zoneId = ZoneId.of(timezone);
        ZonedDateTime inputDateTimeInZone =
                inputDateTime.atZoneSameInstant(zoneId);

        // Get current datetime in requested timezone
        ZonedDateTime currentDateTime =
                ZonedDateTime.now(zoneId);

        // Verify date is today
        boolean isToday =
                inputDateTimeInZone.toLocalDate()
                        .equals(currentDateTime.toLocalDate());

        // Verify time is in the future
        boolean isFuture =
                inputDateTimeInZone.isAfter(currentDateTime);

        Assert.assertTrue(
                isToday && isFuture,
                String.format(
                        "Expected datetime [%s] to be today's future datetime in timezone [%s]. Current time: [%s]",
                        dateTime,
                        timezone,
                        currentDateTime
                )
        );
    }



    @Then("Validate API date time {string} with expected date time {string} in timezone {string}")
    public void validateApiDateTime(
            String apiDateTime,
            String expectedDateTime,
            String timezone) {

        validateDateTimeAndTimezone(
                apiDateTime,
                expectedDateTime,
                timezone
        );
    }

    public  void validateDateTimeAndTimezone(
            String apiDateTime,
            String expectedDateTime,
            String timezone) {
        if(apiDateTime.contains("SysData"))
        {
            apiDateTime=DriverInstance.getVariable(apiDateTime.split("=>")[1]);
        }
        if(expectedDateTime.contains("SysData"))
        {
            expectedDateTime=DriverInstance.getVariable(expectedDateTime.split("=>")[1]);

        }
        DateTimeFormatter apiFormatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ssXXX");

        DateTimeFormatter expectedFormatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        // API response
        OffsetDateTime actual =
                OffsetDateTime.parse(apiDateTime, apiFormatter);

        // Expected value: 2026-08-15 02:39
        LocalDateTime expected =
                LocalDateTime.parse(expectedDateTime, expectedFormatter);

        ZoneId zoneId = ZoneId.of(timezone);

        // Determine expected offset automatically:
        // EST/EDT, CST/CDT, MST/MDT, PST/PDT, etc.
        ZoneOffset expectedOffset =
                zoneId.getRules().getOffset(expected);

        // Validate Date + Hour + Minute only
        Assert.assertEquals(
                actual.toLocalDateTime().truncatedTo(ChronoUnit.MINUTES),
                expected.truncatedTo(ChronoUnit.MINUTES),
                "Date/Time mismatch"
        );

        // Validate timezone offset
        Assert.assertEquals(
                actual.getOffset(),
                expectedOffset,
                "Timezone offset mismatch"
        );
    }

    public void verifyEmailMessageAfterTestStart(String arg0, String arg1)
            throws Exception {

        String sessionId = getSessionID();

        URI = PropReader.get("application_url");

        URI = URI.concat(
                "/services/data/v56.0/query?q=SELECT MessageDate, TextBody " +
                        "FROM EmailMessage " +
                        "WHERE Subject='" + arg0 + "' " +
                        "ORDER BY LastModifiedDate DESC LIMIT 1"
        );

        int retryCount = 0;
        int maxRetry = 20;
        boolean emailVerified = false;

        // Salesforce MessageDate example:
        // 2026-08-18T06:39:03.000+0000
        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

        try {

            do {

                webDriver.waitForElementLoad(10);

                apiDriver.clearRequestHeaders();
                apiDriver.updateRequestHeader(
                        "Authorization",
                        "Bearer " + sessionId
                );

                apiDriver.submitRequest(Method.GET, URI);

                String success =
                        apiDriver.getSingleValueFromResponse("done");

                String totalSize =
                        apiDriver.getSingleValueFromResponse("totalSize");

                int fileCount = Integer.parseInt(totalSize);

                if (success.equalsIgnoreCase("true") && fileCount > 0) {

                    String messageDate =
                            apiDriver.getSingleValueFromResponse(
                                    "records[0].MessageDate"
                            );

                    System.out.println(
                            "Test Start Time : " + maiUtility.testStartTime
                    );

                    System.out.println(
                            "Message Date    : " + messageDate
                    );

                    Instant messageTime = OffsetDateTime
                            .parse(messageDate, formatter)
                            .toInstant();

                    System.out.println(
                            "Message Instant : " + messageTime
                    );

                    /*
                     * Verify that EmailMessage was created
                     * AFTER the test started.
                     */
                    if (messageTime.isAfter(maiUtility.testStartTime)) {

                        String textBody =
                                apiDriver.getSingleValueFromResponse(
                                        "records[0].TextBody"
                                );

                        emailVerified = true;

                        System.out.println(
                                "PASS: Email MessageDate [" + messageTime +
                                        "] is after Test Start Time [" +
                                        maiUtility.testStartTime + "]"
                        );

                        DriverInstance.setVariable(arg1, textBody);

                        break;
                    }

                    System.out.println(
                            "Email exists, but it was generated before " +
                                    "the test started."
                    );

                    System.out.println(
                            "Test Start Time : " +
                                    maiUtility.testStartTime
                    );

                    System.out.println(
                            "Message Time    : " +
                                    messageTime
                    );
                }

                retryCount++;

                if (retryCount < maxRetry) {

                    System.out.println(
                            "Email not received after test start time. " +
                                    "Retry " + retryCount + "/" + maxRetry
                    );

                    Thread.sleep(1000);
                }

            } while (retryCount < maxRetry);

            if (!emailVerified) {

                throw new Exception(
                        "Email with Subject '" + arg0 +
                                "' was not received after Test Start Time. " +
                                "Test Start Time: " + maiUtility.testStartTime +
                                ", Retries: " + maxRetry
                );
            }

        } finally {

            bddDriver.logResponse();
            apiDriver.clearRequestHeaders();
        }
    }

    public void GetEmailAttributesAfterTestStart(String Attribute, String arg0, String arg1)
            throws Exception {

        String sessionId = getSessionID();

        URI = PropReader.get("application_url");

        URI = URI.concat(
                "/services/data/v56.0/query?q=SELECT MessageDate, " + Attribute +
                        " FROM EmailMessage " +
                        "WHERE Subject='" + arg0 + "' " +
                        "ORDER BY LastModifiedDate DESC LIMIT 1"
        );

        int retryCount = 0;
        int maxRetry = 5;
        boolean emailVerified = false;

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

        try {

            webDriver.waitForElementLoad(10);

            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader(
                    "Authorization",
                    "Bearer " + sessionId
            );

            while (retryCount < maxRetry && !emailVerified) {

                System.out.println(
                        "Checking EmailMessage... Attempt " +
                                (retryCount + 1) + "/" + maxRetry
                );

                apiDriver.submitRequest(Method.GET, URI);

                String success =
                        apiDriver.getSingleValueFromResponse("done");

                String totalSize =
                        apiDriver.getSingleValueFromResponse("totalSize");

                int fileCount = Integer.parseInt(totalSize);

                if (success.equalsIgnoreCase("true") && fileCount > 0) {

                    String messageDate =
                            apiDriver.getSingleValueFromResponse(
                                    "records[0].MessageDate"
                            );

                    System.out.println(
                            "Test Start Time : " +
                                    maiUtility.testStartTime
                    );

                    System.out.println(
                            "Message Date    : " +
                                    messageDate
                    );

                    Instant messageTime = OffsetDateTime
                            .parse(messageDate, formatter)
                            .toInstant();

                    System.out.println(
                            "Message Instant : " +
                                    messageTime
                    );

                    /*
                     * Verify that EmailMessage was created
                     * AFTER the test started.
                     */
                    if (messageTime.isAfter(maiUtility.testStartTime)) {

                        String attributeValue =
                                apiDriver.getSingleValueFromResponse(
                                        "records[0]." + Attribute
                                );

                        DriverInstance.setVariable(arg1, attributeValue);

                        emailVerified = true;

                        System.out.println(
                                "PASS: Email MessageDate [" +
                                        messageTime +
                                        "] is after Test Start Time [" +
                                        maiUtility.testStartTime +
                                        "]"
                        );
                        break;

                    } else {

                        System.out.println(
                                "Email exists, but it was generated before " +
                                        "the test started."
                        );

                        System.out.println(
                                "Test Start Time : " +
                                        maiUtility.testStartTime
                        );

                        System.out.println(
                                "Message Time    : " +
                                        messageTime
                        );
                    }

                } else {

                    System.out.println(
                            "Email not found. Salesforce returned totalSize = " +
                                    fileCount
                    );
                }

                retryCount++;

                if (retryCount < maxRetry) {

                    System.out.println(
                            "Email not received after test start time. " +
                                    "Retry " + retryCount + "/" + maxRetry
                    );

                    Thread.sleep(1000);
                }
            }

            if (!emailVerified) {

                throw new Exception(
                        "Email with Subject '" + arg0 +
                                "' was not received after Test Start Time. " +
                                "Test Start Time: " +
                                maiUtility.testStartTime +
                                ", Retries: " + maxRetry
                );
            }

        } finally {

            bddDriver.logResponse();
            apiDriver.clearRequestHeaders();
        }
    }

    @Then("Get {string} from EmailMessage using Subject with value {string} & {string} with value {string} and Store into {string}")
    public void GetEmailWithTwoAttributesAfterTestStart(String Attribute, String arg0, String arg01, String arg02, String arg1)
            throws Exception {
       if(arg02.contains("SysData"))
       {
           arg02 = DriverInstance.getVariable(arg02.split("=>")[1]);
       }

        String sessionId = getSessionID();

        URI = PropReader.get("application_url");

        URI = URI.concat(
                "/services/data/v56.0/query?q=SELECT MessageDate, " + Attribute +
                        " FROM EmailMessage " +
                        "WHERE Subject='" + arg0 + "' "+
                        "AND " + arg01 + " = '" + arg02 + "' "+
                        "ORDER BY LastModifiedDate DESC LIMIT 1"
        );

        int retryCount = 0;
        int maxRetry = 5;
        boolean emailVerified = false;

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

        try {

            webDriver.waitForElementLoad(10);

            apiDriver.clearRequestHeaders();
            apiDriver.updateRequestHeader(
                    "Authorization",
                    "Bearer " + sessionId
            );

            while (retryCount < maxRetry && !emailVerified) {

                System.out.println(
                        "Checking EmailMessage... Attempt " +
                                (retryCount + 1) + "/" + maxRetry
                );

                apiDriver.submitRequest(Method.GET, URI);

                String success =
                        apiDriver.getSingleValueFromResponse("done");

                String totalSize =
                        apiDriver.getSingleValueFromResponse("totalSize");

                int fileCount = Integer.parseInt(totalSize);

                if (success.equalsIgnoreCase("true") && fileCount > 0) {

                    String messageDate =
                            apiDriver.getSingleValueFromResponse(
                                    "records[0].MessageDate"
                            );

                    System.out.println(
                            "Test Start Time : " +
                                    maiUtility.testStartTime
                    );

                    System.out.println(
                            "Message Date    : " +
                                    messageDate
                    );

                    Instant messageTime = OffsetDateTime
                            .parse(messageDate, formatter)
                            .toInstant();

                    System.out.println(
                            "Message Instant : " +
                                    messageTime
                    );

                    /*
                     * Verify that EmailMessage was created
                     * AFTER the test started.
                     */
                    if (messageTime.isAfter(maiUtility.testStartTime)) {

                        String attributeValue =
                                apiDriver.getSingleValueFromResponse(
                                        "records[0]." + Attribute
                                );

                        DriverInstance.setVariable(arg1, attributeValue);

                        emailVerified = true;

                        System.out.println(
                                "PASS: Email MessageDate [" +
                                        messageTime +
                                        "] is after Test Start Time [" +
                                        maiUtility.testStartTime +
                                        "]"
                        );
                        break;

                    } else {

                        System.out.println(
                                "Email exists, but it was generated before " +
                                        "the test started."
                        );

                        System.out.println(
                                "Test Start Time : " +
                                        maiUtility.testStartTime
                        );

                        System.out.println(
                                "Message Time    : " +
                                        messageTime
                        );
                    }

                } else {

                    System.out.println(
                            "Email not found. Salesforce returned totalSize = " +
                                    fileCount
                    );
                }

                retryCount++;

                if (retryCount < maxRetry) {

                    System.out.println(
                            "Email not received after test start time. " +
                                    "Retry " + retryCount + "/" + maxRetry
                    );

                    Thread.sleep(1000);
                }
            }

            if (!emailVerified) {

                throw new Exception(
                        "Email with Subject '" + arg0 +
                                "' was not received after Test Start Time. " +
                                "Test Start Time: " +
                                maiUtility.testStartTime +
                                ", Retries: " + maxRetry
                );
            }

        } finally {

            bddDriver.logResponse();
            apiDriver.clearRequestHeaders();
        }
    }

    public void GetLinkFromEmailMessage(String arg0, String arg1)
            throws Exception {

        String sessionId = getSessionID();

        URI = PropReader.get("application_url");

        URI = URI.concat(
                "/services/data/v56.0/query?q=SELECT MessageDate, TextBody " +
                        "FROM EmailMessage " +
                        "WHERE Subject='" + arg0 + "' " +
                        "ORDER BY LastModifiedDate DESC LIMIT 1"
        );

        int retryCount = 0;
        int maxRetry = 20;
        boolean emailVerified = false;

        // Salesforce MessageDate example:
        // 2026-08-18T06:39:03.000+0000
        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

        try {

            do {

                webDriver.waitForElementLoad(10);

                apiDriver.clearRequestHeaders();
                apiDriver.updateRequestHeader(
                        "Authorization",
                        "Bearer " + sessionId
                );

                apiDriver.submitRequest(Method.GET, URI);

                String success =
                        apiDriver.getSingleValueFromResponse("done");

                String totalSize =
                        apiDriver.getSingleValueFromResponse("totalSize");

                int fileCount = Integer.parseInt(totalSize);

                if (success.equalsIgnoreCase("true") && fileCount > 0) {

                    String messageDate =
                            apiDriver.getSingleValueFromResponse(
                                    "records[0].MessageDate"
                            );

                    System.out.println(
                            "Test Start Time : " + maiUtility.testStartTime
                    );

                    System.out.println(
                            "Message Date    : " + messageDate
                    );

                    Instant messageTime = OffsetDateTime
                            .parse(messageDate, formatter)
                            .toInstant();

                    System.out.println(
                            "Message Instant : " + messageTime
                    );

                    /*
                     * Verify that EmailMessage was created
                     * AFTER the test started.
                     */
                    if (messageTime.isAfter(maiUtility.testStartTime)) {

                        String textBody =
                                apiDriver.getSingleValueFromResponse(
                                        "records[0].TextBody"
                                );

                        emailVerified = true;

                        System.out.println(
                                "PASS: Email MessageDate [" + messageTime +
                                        "] is after Test Start Time [" +
                                        maiUtility.testStartTime + "]"
                        );

                        DriverInstance.setVariable(arg1, textBody);

                        break;
                    }

                    System.out.println(
                            "Email exists, but it was generated before " +
                                    "the test started."
                    );

                    System.out.println(
                            "Test Start Time : " +
                                    maiUtility.testStartTime
                    );

                    System.out.println(
                            "Message Time    : " +
                                    messageTime
                    );
                }

                retryCount++;

                if (retryCount < maxRetry) {

                    System.out.println(
                            "Email not received after test start time. " +
                                    "Retry " + retryCount + "/" + maxRetry
                    );

                    Thread.sleep(1000);
                }

            } while (retryCount < maxRetry);

            if (!emailVerified) {

                throw new Exception(
                        "Email with Subject '" + arg0 +
                                "' was not received after Test Start Time. " +
                                "Test Start Time: " + maiUtility.testStartTime +
                                ", Retries: " + maxRetry
                );
            }

        } finally {

            bddDriver.logResponse();
            apiDriver.clearRequestHeaders();
        }
    }

    @Then("Send Post Request for SMC3 EVA Document Operation with File {string}")
    public void sendPostRequestForSMCEVADocumentOperationWithFile( String arg1) throws Exception {
        String SessionId = getSessionID();
        String BaseURI = PropReader.get("application_url");
        String Org_Id = PropReader.get("Org_Id");
        URI = BaseURI.concat("/services/apexrest/rtms/tmslistener?org="+Org_Id+"&source=SMC3EVADOCUMENT&pwd="+DriverInstance.getVariable("Code"));
        apiDriver.updateRequestHeader("Content-Type", "text/json");
        apiDriver.updateRequestHeader("Authorization", "Bearer "+SessionId);
        apiDriver.setRequestBody(readTextFile(arg1));
        apiDriver.generatePayLoad();
        apiDriver.submitRequest(Method.POST, URI);
        bddDriver.logResponse();
        System.out.println("Response "+apiDriver.RetrurnResponce());
        apiDriver.assertStatusCode(200);
        apiDriver.clearRequestHeaders();
    }

    @Then("Verify And Update all PayIQ Program Status is Pending")
    public void verifyAndUpdateAllPayIQProgramStatusIsPending() throws Exception {
        updateRecordsStatus("rtms9__PayIQ_Program__c","rtms9__Status__c","Open","rtms9__Status__c","Pending",false);
    }

    public void updateRecordsStatus(String ObjectName, String FilterField, String FilterValue, String UpdateField, String UpdateValue,boolean isBoolean) throws Exception {

        String SessionId = getSessionID();
        String BaseURI = PropReader.get("application_url");

        // Step 1: Query records
        String QueryURI = BaseURI.concat("/services/data/v56.0/query?q=SELECT Id FROM " + ObjectName + " WHERE " + FilterField + "='" + FilterValue + "'");

        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.submitRequest(Method.GET, QueryURI);

        String success = apiDriver.getSingleValueFromResponse("done");
        String fileCount = apiDriver.getSingleValueFromResponse("totalSize");
        int recordCount = Integer.parseInt(fileCount);
        if (!success.equalsIgnoreCase("true")) {
            bddDriver.logResponse();
            apiDriver.clearRequestHeaders();
            throw new Exception("Failed to query records for Object: " + ObjectName);
        }

        // Step 2: Get number of records

        System.out.println("Records Found: " + recordCount);
        // If no records found, skip PATCH
        if (recordCount > 0) {
            // IMPORTANT: Store IDs before PATCH
            List<String> recordIds = new ArrayList<>();
            for (int i = 0; i < recordCount; i++) {
                String recordId = apiDriver.getSingleValueFromResponse(
                        "records[" + i + "].Id"
                );
                recordIds.add(recordId);
            }

            // Step 3: Update each record
            for (String recordId : recordIds) {
                System.out.println("Updating Record ID: " + recordId);
                String UpdateURI = BaseURI.concat("/services/data/v56.0/sobjects/" + ObjectName + "/" + recordId);

                // Update request body
                String RequestBody;

                if (isBoolean) {
                    RequestBody = "{"
                            + "\""
                            + UpdateField
                            + "\":"
                            + UpdateValue.toLowerCase()
                            + "}";
                } else {
                    RequestBody = "{"
                            + "\""
                            + UpdateField
                            + "\":\""
                            + UpdateValue
                            + "\""
                            + "}";
                }

//                String RequestBody = "{" + "\"" + UpdateField + "\":\"" + UpdateValue + "\"" + "}";
                apiDriver.updateRequestHeader("Content-Type", "application/json");
                apiDriver.setRequestBody(RequestBody);
                apiDriver.generatePayLoad();
                apiDriver.submitRequest(Method.PATCH, UpdateURI);

                System.out.println(
                        "Updated Record: " + recordId
                                + " | "
                                + UpdateField
                                + " = "
                                + UpdateValue
                );
            }
            bddDriver.logResponse();
        }

        apiDriver.clearRequestHeaders();
    }


    @Then("API - Update {string} Records with {string} as {string} where {string} as {string}")
    public void apiUpdateRecordsWithAsWhereAs(String arg0, String arg1, String arg2, String arg3, String arg4) throws Exception {
        if (arg4.contains("SysData")) {
            arg4 = DriverInstance.getVariable(arg4.split("=>")[1]);
        }
        if (arg2.contains("SysData")) {
            arg2 = DriverInstance.getVariable(arg2.split("=>")[1]);
        }
        if(arg2.equalsIgnoreCase("true")||arg2.equalsIgnoreCase("false")) {
            updateRecordsStatus(arg0, arg3, arg4, arg1, arg2, true);
        }
        else{
            updateRecordsStatus(arg0, arg3, arg4, arg1, arg2, false);
        }

    }

    @Then("Update {string} from Developer console")
    public void updateFromDeveloperConsole(String Sfid) throws Exception {
        int retries = 5;
        if (Sfid.contains("SysData")) {
            String Value = Sfid.split("=>")[1];
            Sfid = DriverInstance.getVariable(Value);
        }
        while (retries-- > 0) {

            String sessionId = getSessionID();
            String apexCode = "rtms__TruckPosting__c t = [select rtms__Date_Entered__c from rtms__TruckPosting__c where id = '" +Sfid+"'];\n" +
                    "t.rtms__Date_Entered__c = datetime.now().addHours(-2);\n" +
                    "update t;";
            System.out.println("apexCode: "+apexCode);
            String uri = PropReader.get("application_url")
                    + "/services/data/v56.0/tooling/executeAnonymous/";

            apiDriver.updateRequestHeader("Authorization",
                    "Bearer " + sessionId);
            System.out.println("Final URI = " + uri);
            apiDriver.addQueryParameters("anonymousBody",apexCode);
            apiDriver.submitRequest(Method.GET, uri);

            System.out.println("Response: " + apiDriver.RetrurnResponce());

            String success =
                    apiDriver.getSingleValueFromResponse("success");

            if ("true".equalsIgnoreCase(success)) {
                System.out.println("Updated");
                break;
            } else {
                System.out.println("Issue in updation");
            }
        }
    }
}