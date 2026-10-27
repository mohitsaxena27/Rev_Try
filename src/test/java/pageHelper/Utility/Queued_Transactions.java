package pageHelper.Utility;

import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Log4j
public class Queued_Transactions {
    public webHelper webDriver;
    public apiHelper apiDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader iframexml;
    public PropertyReader propertyReader = new PropertyReader();

    static String dir;
    public Queued_Transactions(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver=new baseDriverHelper(DriverInstance.getApiDriver(),DriverInstance.API_RESPONCE_THREAD_LOCAL.get());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        iframexml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
    }

    public  String readFileAsString(String fileName) throws IOException {
       String scenarioName= DriverInstance.getScenarioName();
       String TID = scenarioName.trim().split("-")[0];
       String path = System.getProperty("user.dir")+File.separator+"src"+File.separator+"test"+File.separator+"resources"+File.separator+"Documents"+File.separator+"TestCaseFiles"+File.separator+TID.replace(" ","")+File.separator+fileName;
        return new String(Files.readAllBytes(Paths.get(path)));
    }
    public  void writeStringToFile(String fileName, String content) throws IOException {
        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim();
        String path = System.getProperty("user.dir")+File.separator+"src"+File.separator+"test"+File.separator+"resources"+File.separator+"Documents"+File.separator+"TestCaseFiles"+File.separator+TID.replace(" ","")+File.separator+"U_"+fileName;
        Files.write(Paths.get(path), content.getBytes(), StandardOpenOption.CREATE,   // create if not exists
                StandardOpenOption.TRUNCATE_EXISTING, // clear old content
                StandardOpenOption.WRITE);
    }
    @Then("Save it with FileName {string}")
    public void saveItWithFileName(String arg0) throws IOException {
        writeStringToFile(arg0,DriverInstance.getVariable("{FinalUpdatedText}"));
    }
    @Then("Get {string} files and update below Attributes")
        public void getFilesAndUpdateBelowAttributes(String arg0, DataTable dt) throws IOException {
            List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
            String str = readFileAsString(arg0);
            if (!dataRows.isEmpty()) {
                Map<String, String> details = dataRows.get(0);
                for (Map.Entry<String, String> entry : details.entrySet()) {
                    if(!entry.getKey().equalsIgnoreCase("No Update Required")) {
                        if (entry.getKey().contains("CurrentDate")) {
                            ZoneId chicagoZone = ZoneId.of("America/Chicago");
                            LocalDate today = LocalDate.now(chicagoZone);
                            LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                            String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                            str = str.replace(entry.getKey(), formattedDate11);
                        } else if (entry.getKey().contains("Date") && !entry.getKey().contains("CurrentDate")) {
                            str = str.replace(entry.getKey(), webDriver.ReturnDate(entry.getValue()));
                        } else if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            str = str.replace(entry.getKey(), DriverInstance.getVariable(Value));
                        } else {
                            str = str.replace(entry.getKey(), entry.getValue());
                        }

                    }
                }
            }

            DriverInstance.setVariable("{FinalUpdatedText}",str);
            System.out.println("Final String"+ str);
        }

}