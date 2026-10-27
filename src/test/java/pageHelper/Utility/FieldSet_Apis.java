package pageHelper.Utility;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.restassured.http.Method;
import lombok.extern.log4j.Log4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.PropReader;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Log4j
public class FieldSet_Apis {
    String URI;
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public apiHelper apiDriver;
    public xmlreader xml;
    public PropertyReader propertyReader = new PropertyReader();
    private static final ObjectMapper MAPPER = new ObjectMapper();

    public FieldSet_Apis(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver = new baseDriverHelper(DriverInstance.getApiDriver(), DriverInstance.API_RESPONCE_THREAD_LOCAL.get());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    public String getSessionID() throws Exception {

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
            Session = PropReader.get("Access_Token");
        }
        return Session;
    }

    public void GetEntityDefinitionId(String Name) throws Exception {
        String SessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/tooling/query/?q=SELECT DurableId, QualifiedApiName FROM EntityDefinition WHERE Label='" + Name + "'");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.submitRequest(Method.GET, URI);
        String success = apiDriver.getSingleValueFromResponse("done");
        String Count = apiDriver.getSingleValueFromResponse("totalSize");
        if (success.equalsIgnoreCase("true") && Objects.equals(Count, "1")) {
            String DurableId = apiDriver.getSingleValueFromResponse("records[0].DurableId");
            String QualifiedApiName = apiDriver.getSingleValueFromResponse("records[0].QualifiedApiName");
            System.out.println("ContentDocumentId :" + DurableId);
            DriverInstance.setVariable("Durable_Id", DurableId);
            DriverInstance.setVariable("Qualified_Api_Name", QualifiedApiName);
        } else {
            System.out.println("File Not Found");
            Assert.fail("Can not get  Get Entity Definition Id");
        }
        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }

    public void GetFieldSetID(String FieldSetName) throws Exception {
        String SessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/tooling/query/?q=SELECT Id, DeveloperName, EntityDefinitionId FROM FieldSet WHERE DeveloperName='" + FieldSetName + "' AND EntityDefinitionId='"+DriverInstance.getVariable("Durable_Id")+"'");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.submitRequest(Method.GET, URI);
        String success = apiDriver.getSingleValueFromResponse("done");
        String Count = apiDriver.getSingleValueFromResponse("totalSize");
        if (success.equalsIgnoreCase("true") && Objects.equals(Count, "1")) {
            String Id = apiDriver.getSingleValueFromResponse("records[0].Id");
            DriverInstance.setVariable("Field_Set_ID", Id);
        } else {
            Assert.fail("Can not get  Field Set Id");
        }
        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }

    public void GetAllExistingFieldSetItemIDs(String FieldSetName) throws Exception {
        String SessionId = getSessionID();
        URI = PropReader.get("application_url");
        URI = URI.concat("/services/data/v56.0/tooling/query/?q=SELECT Id, DeveloperName, EntityDefinitionId FROM FieldSet WHERE DeveloperName='" + FieldSetName + "' AND EntityDefinitionId='"+DriverInstance.getVariable("Durable_Id")+"'");
        apiDriver.updateRequestHeader("Authorization", "Bearer " + SessionId);
        apiDriver.submitRequest(Method.GET, URI);
        String success = apiDriver.getSingleValueFromResponse("done");
        String Count = apiDriver.getSingleValueFromResponse("totalSize");
        if (success.equalsIgnoreCase("true") && Objects.equals(Count, "1")) {
            String Id = apiDriver.getSingleValueFromResponse("records[0].Id");
            DriverInstance.setVariable("Field_Set_ID", Id);
        } else {
            Assert.fail("Can not get  Field Set Id");
        }
        bddDriver.logResponse();
        apiDriver.clearRequestHeaders();
    }

}