package utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.NumberFormat;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jetbrains.annotations.NotNull;
import org.testng.Assert;
import org.testng.annotations.DataProvider;
import pageHelper.bddDriver;

public class DataReader {

static String apiInputSheet = System.getProperty("user.dir")+File.separator+"src"+File.separator+"test"+File.separator+"resources"+File.separator+"Data"+File.separator+"API_Input_Sheet.xlsx";

	public static boolean isNumeric(String str) {
		NumberFormat formatter = NumberFormat.getInstance();
		ParsePosition pos = new ParsePosition(0);
		formatter.parse(str, pos);
		return str.length() == pos.getIndex();
	}


	//-------------------------------------------------------------------------------------------------------------
	public static void main(String[] args) throws Exception {

		// datareader1();

//	String value=	DataReader.ReadQuestionAndHelp(2, 2,"mom");
//	System.out.println(value);
	}


	public static HashMap<String, Object> ReadDataByAutomationID(String automationID) throws IOException {

		String AutomationID = null;
		HashMap<String, Object> Data = new HashMap<>();
		//FileInputStream file = new FileInputStream(new File("src\\test\\resources\\Data\\API_Input_Sheet.xlsx"));
		FileInputStream file = new FileInputStream(new File(apiInputSheet));
		XSSFWorkbook workbook = new XSSFWorkbook(file);
		XSSFSheet sheet = workbook.getSheet("Data");
		System.out.println("Last Row"+sheet.getLastRowNum());
		for (int i = 1; i <= sheet.getLastRowNum(); i++) {

			try {
				if (sheet.getRow(i).getCell(0).getCellType() == CellType.NUMERIC) {
					AutomationID = String.valueOf((int) sheet.getRow(i).getCell(0).getNumericCellValue());
				} else {
					 AutomationID = sheet.getRow(i).getCell(0).getStringCellValue().trim();
				}
			} catch (Exception e) {
				System.out.println("Unable to get AutomationID");
				Assert.fail("Please provide valid Automation ID");
			}

			if (AutomationID.equalsIgnoreCase(automationID)) {
				String StoreNumber =DataReader.getStringValue(sheet,i,1);
				String Notes =DataReader.getStringValue(sheet,i,2);
				String OrderNumber =DataReader.getStringValue(sheet,i,3);
				int TotalOrderItems =DataReader.getIntegerValue(sheet,i,4);
				String DocumentNumber =DataReader.getStringValue(sheet,i,5);
				String OrderStatus =DataReader.getStringValue(sheet,i,6);
				double DeliveryCharge =DataReader.getDoubleValue(sheet,i,7);
				double SubTotal =DataReader.getDoubleValue(sheet,i,8);
				boolean ForceTaxableFlag =DataReader.getBooleanValue(sheet,i,9);
				String WebCustomerId =DataReader.getStringValue(sheet,i,10);
				double Total =DataReader.getDoubleValue(sheet,i,11);
				String CustomerType =DataReader.getStringValue(sheet,i,12);
				String FulfillmentSource =DataReader.getStringValue(sheet,i,13);
				boolean ManualFulfillment =DataReader.getBooleanValue(sheet,i,14);
				String OrderSource =DataReader.getStringValue(sheet,i,15);
				int SalesmanNumber =DataReader.getIntegerValue(sheet,i,16);
				boolean SpecialOrderFlag =DataReader.getBooleanValue(sheet,i,17);
				String SalesTerritory =DataReader.getStringValue(sheet,i,18);
				boolean ShipCompleteFlag =DataReader.getBooleanValue(sheet,i,19);
				double ShippingCostToTP =DataReader.getDoubleValue(sheet,i,20);
				int WebOrderNumber =DataReader.getIntegerValue(sheet,i,21);
				String CustomerNumber =DataReader.getStringValue(sheet,i,22);
				String ServiceName =DataReader.getStringValue(sheet,i,23);
				String SelectedPrinter =DataReader.getStringValue(sheet,i,24);
				String Site =DataReader.getStringValue(sheet,i,25);
				String ShipCarrier =DataReader.getStringValue(sheet,i,26);
				String PurchaseOrderNumber =DataReader.getStringValue(sheet,i,27);
				double EstimatedTax =DataReader.getDoubleValue(sheet,i,28);
				String PaymentMethodUsed =DataReader.getStringValue(sheet,i,29);
				double EstimatedShipping =DataReader.getDoubleValue(sheet,i,30);
				String OrderDate =DataReader.getStringValue(sheet,i,31);
				double FuelSurcharge =DataReader.getDoubleValue(sheet,i,32);
				String stateTaxCode =DataReader.getStringValue(sheet,i,33);

				Data.put("StoreNumber",StoreNumber);
				Data.put("Notes",Notes);
				Data.put("OrderNumber",OrderNumber);
				Data.put("TotalOrderItems",TotalOrderItems);
				Data.put("DocumentNumber",DocumentNumber);
				Data.put("OrderStatus",OrderStatus);
				Data.put("DeliveryCharge",DeliveryCharge);
				Data.put("SubTotal",SubTotal);
				Data.put("ForceTaxableFlag",ForceTaxableFlag);
				Data.put("WebCustomerId",WebCustomerId);
				Data.put("Total",Total);
				Data.put("CustomerType",CustomerType);
				Data.put("FulfillmentSource",FulfillmentSource);
				Data.put("ManualFulfillment",ManualFulfillment);
				Data.put("OrderSource",OrderSource);
				Data.put("SalesmanNumber",SalesmanNumber);
				Data.put("SpecialOrderFlag",SpecialOrderFlag);
				Data.put("SalesTerritory",SalesTerritory);
				Data.put("ShipCompleteFlag",ShipCompleteFlag);
				Data.put("ShippingCostToTP",ShippingCostToTP);
				Data.put("WebOrderNumber",WebOrderNumber);
				Data.put("CustomerNumber",CustomerNumber);
				Data.put("ServiceName",ServiceName);
				Data.put("SelectedPrinter",SelectedPrinter);
				Data.put("Site",Site);
				Data.put("ShipCarrier",ShipCarrier);
				Data.put("PurchaseOrderNumber",PurchaseOrderNumber);
				Data.put("EstimatedTax",EstimatedTax);
				Data.put("PaymentMethodUsed",PaymentMethodUsed);
				Data.put("EstimatedShipping",EstimatedShipping);
				Data.put("OrderDate",OrderDate);
				Data.put("FuelSurcharge",FuelSurcharge);
				Data.put("stateTaxCode",stateTaxCode);
				break;
			}


		}
		return Data;

	}



	public  static String getStringValue(Sheet sheet, int RowNum,int ColNum) {
		String text;
		try {
			if (sheet.getRow(RowNum).getCell(ColNum).getCellType() == CellType.NUMERIC) {
				text = String.valueOf((int) sheet.getRow(RowNum).getCell(ColNum).getNumericCellValue());
			} else {
				text = sheet.getRow(RowNum).getCell(ColNum).getStringCellValue().trim();

			}
		}
		catch(NullPointerException e)
		{
			text="";
		}
		return text;
		}
	public static int getIntegerValue(Sheet sheet, int RowNum,int ColNum) {
		int text = 0;
		try {
			if (sheet.getRow(RowNum).getCell(ColNum).getCellType() == CellType.NUMERIC) {
				text = (int) sheet.getRow(RowNum).getCell(ColNum).getNumericCellValue();
			} else {
				text = Integer.parseInt(sheet.getRow(RowNum).getCell(ColNum).getStringCellValue().trim());

			}
		}
		catch(NullPointerException | NumberFormatException e)
		{
			System.out.println("Value mot provided");
			text=0;
		}
		return text;
	}

	public static double getDoubleValue(Sheet sheet, int RowNum,int ColNum) {
		double text = 0.0;
		try {
			if (sheet.getRow(RowNum).getCell(ColNum).getCellType() == CellType.NUMERIC) {
				text = sheet.getRow(RowNum).getCell(ColNum).getNumericCellValue();
			} else {
				System.out.println("Test: "+ sheet.getRow(RowNum).getCell(ColNum).getStringCellValue());
				text = Double.parseDouble(sheet.getRow(RowNum).getCell(ColNum).getStringCellValue().trim());
			}
		}
		catch(NullPointerException | NumberFormatException  e)
		{
			System.out.println("Value not provided");
			text=0;
		}
		return text;
	}

	public static boolean getBooleanValue(Sheet sheet, int RowNum,int ColNum) {
		boolean text = false;
		try {
			if (sheet.getRow(RowNum).getCell(ColNum).getCellType() == CellType.BOOLEAN) {
				text = sheet.getRow(RowNum).getCell(ColNum).getBooleanCellValue();
			} else {
				text = Boolean.parseBoolean(sheet.getRow(RowNum).getCell(ColNum).getStringCellValue().trim());

			}
		}
		catch(NullPointerException e)
		{
			System.out.println("Value mot provided");
		}
		return text;
	}

}





