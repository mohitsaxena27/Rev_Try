package utils;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ExtentSetup {

    public PropertyReader propertyReader = new PropertyReader();

    public void setupReportName() throws IOException {
        String ReportOverWrite= propertyReader.readproperty("ReportWithTimeStamp");
         if(ReportOverWrite.equalsIgnoreCase("Yes"))
         {
             String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
             String reportPath = "Reports/Spark_" + timestamp + ".html";
             // This overrides extent.properties at runtime
             System.setProperty("extent.reporter.spark.out", reportPath);
             System.out.println(">>>> Extent report path set to: " + reportPath);
         }
         else{
             String reportPath = "Reports/3505_Spark.html";
             // This overrides extent.properties at runtime
             System.setProperty("extent.reporter.spark.out", reportPath);
             System.out.println(">>>> Extent report path set to: " + reportPath);
         }



    }
}
