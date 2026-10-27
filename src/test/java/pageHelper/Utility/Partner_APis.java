package pageHelper.Utility;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.en.Then;
import io.restassured.http.Method;
import io.restassured.path.json.JsonPath;
import lombok.extern.log4j.Log4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.json.JSONObject;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.PropReader;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.time.*;
import java.util.*;

@Log4j
public class Partner_APis {
    String URI;
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public apiHelper apiDriver;
    public xmlreader xml;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Apis ca;
    private static final ObjectMapper MAPPER = new ObjectMapper();

    public Partner_APis(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver = new baseDriverHelper(DriverInstance.getApiDriver(), DriverInstance.API_RESPONCE_THREAD_LOCAL.get());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        ca= new Common_Apis(DriverInstance);
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


    @Then("Get All {string} and Store Response into {string}")
    public void getAllAssetsAndStoreResponseInto(String arg, String arg0) throws IOException {
        URI = "https://api.samsara.com";
        URI = URI.concat("/"+arg);
//        apiDriver.updateRequestHeader("Authorization","Bearer samsara_api_3uXkrldI4kYHJnmzNyWoBB2W4odLi5");
        apiDriver.updateRequestHeader("Authorization",propertyReader.readproperty("Samsara_Auth"));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        DriverInstance.setVariable(arg0,apiDriver.RetrurnResponce());

        apiDriver.clearRequestHeaders();


    }

    @Then("Get {string} from {string} where {string} is {string} and store into {string}")
    public void getFromWhereNameIs(String arg0, String arg1, String arg2, String arg3, String key) {

        if(arg3.contains("SysData"))
        {
            arg3= DriverInstance.getVariable(arg3.split("=>")[1]);
        }
        JsonPath jsonPath = new JsonPath(DriverInstance.getVariable(arg1));

        String value = jsonPath.getString(
                "data.find { it." + arg2 + " == '" + arg3 + "' }." + arg0
        );

        DriverInstance.setVariable(key, value);
    }


    @Then("Get vehicle {string} Stats for Vehicle Id {string} and Store Response into {string}")
    public void getVehicleStatsForVehicleIdAndStoreResponseInto(String arg0, String arg1, String arg2) throws IOException {
        URI = "https://api.samsara.com";
        URI = URI.concat("/fleet/vehicles/stats?vehicleIds="+DriverInstance.getVariable(arg1)+"&types="+arg0);
        apiDriver.updateRequestHeader("Authorization",propertyReader.readproperty("Samsara_Auth"));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        DriverInstance.setVariable(arg2,apiDriver.RetrurnResponce());
        apiDriver.clearRequestHeaders();
    }

    @Then("Samsara API - Create a Location using Request {string} and Store Response into {string}")
    public void samsaraAPICreateALocationWithNameAsAndValueAs(String arg0, String arg1) throws IOException {
        URI = "https://api.samsara.com";
        URI = URI.concat("/addresses");
        apiDriver.updateRequestHeader("Authorization",propertyReader.readproperty("Samsara_Auth"));
        apiDriver.setRequestBody(ca.readTextFile(arg0));
        apiDriver.generatePayLoad();
        apiDriver.submitRequest(Method.POST, URI);
        bddDriver.logResponse();
        System.out.println("Response "+apiDriver.RetrurnResponce());
        apiDriver.assertStatusCode(200);
        DriverInstance.setVariable(arg1,apiDriver.RetrurnResponce());
        apiDriver.clearRequestHeaders();
    }
    @Then("Samsara API - Get a Location using Id {string}")
    public void GetLocationUsingID(String arg1) throws IOException {
        URI = "https://api.samsara.com";
        URI = URI.concat("/addresses/"+DriverInstance.getVariable(arg1));
        apiDriver.updateRequestHeader("Authorization",propertyReader.readproperty("Samsara_Auth"));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response "+apiDriver.RetrurnResponce());
        apiDriver.assertStatusCode(200);
        DriverInstance.setVariable(arg1+"_Response",apiDriver.RetrurnResponce());
        apiDriver.clearRequestHeaders();
    }

    @Then("Samsara API - Get Route Details using ELD Id {string}")
    public void GetRouteUsingID(String arg1) throws IOException {
        URI = "https://api.samsara.com";
        URI = URI.concat("/fleet/routes/"+DriverInstance.getVariable(arg1));
        apiDriver.updateRequestHeader("Authorization",propertyReader.readproperty("Samsara_Auth"));
        apiDriver.submitRequest(Method.GET, URI);
        bddDriver.logResponse();
        System.out.println("Response "+apiDriver.RetrurnResponce());
        apiDriver.assertStatusCode(200);
        DriverInstance.setVariable(arg1+"_Response",apiDriver.RetrurnResponce());
        apiDriver.clearRequestHeaders();
    }

    @Then("Delete Samsara Address With Id {string}")
    public void DeleteSamSaraAddress(String arg0) throws IOException {
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url("https://api.samsara.com/addresses/"+DriverInstance.getVariable(arg0))
                .delete(null)
                .addHeader("accept", "application/json")
                .addHeader("authorization", propertyReader.readproperty("Samsara_Auth"))
                .build();
        Response response = client.newCall(request).execute();

    }

    @Then("Delete all Samsara addresses with name {string}")
    public void deleteAllSamsaraAddressesWithName(String name) throws IOException {
        OkHttpClient client = new OkHttpClient();
        String cursor = null;
        int deletedCount = 0;

        do {
            String url = "https://api.samsara.com/addresses?limit=100";
            if (cursor != null && !cursor.isEmpty()) {
                url += "&after=" + java.net.URLEncoder.encode(cursor, StandardCharsets.UTF_8);
            }

            Request request = new Request.Builder()
                    .url(url)
                    .get()
                    .addHeader("accept", "application/json")
                    .addHeader("authorization", propertyReader.readproperty("Samsara_Auth"))
                    .build();

            String responseBody;
            try (Response response = client.newCall(request).execute()) {
                if (!response.isSuccessful() || response.body() == null) {
                    throw new IOException("Unable to retrieve Samsara addresses. HTTP status: "
                            + response.code());
                }
                responseBody = response.body().string();
            }

            JsonNode responseJson = MAPPER.readTree(responseBody);
            JsonNode addresses = responseJson.path("data");
            if (!addresses.isArray()) {
                throw new IOException("Samsara addresses response did not contain a data array.");
            }

            for (JsonNode address : addresses) {
                if (name.equals(address.path("name").asText())) {
                    String addressId = address.path("id").asText();
                    if (addressId.isEmpty()) {
                        throw new IOException("Samsara address matched by name but had no ID.");
                    }
                    deleteSamsaraAddressById(client, addressId);
                    deletedCount++;
                }
            }

            JsonNode pagination = responseJson.path("pagination");
            boolean hasNextPage = pagination.path("hasNextPage").asBoolean(false);
            cursor = hasNextPage ? pagination.path("endCursor").asText() : null;
            if (hasNextPage && cursor.isEmpty()) {
                throw new IOException("Samsara pagination indicated another page without an end cursor.");
            }
        } while (cursor != null && !cursor.isEmpty());

        log.info("Deleted " + deletedCount + " Samsara address(es) named '" + name + "'.");
    }

    private void deleteSamsaraAddressById(OkHttpClient client, String addressId) throws IOException {
        Request request = new Request.Builder()
                .url("https://api.samsara.com/addresses/" + addressId)
                .delete(null)
                .addHeader("accept", "application/json")
                .addHeader("authorization", propertyReader.readproperty("Samsara_Auth"))
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Unable to delete Samsara address " + addressId
                        + ". HTTP status: " + response.code());
            }
        }
    }


}