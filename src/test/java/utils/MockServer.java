package utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.ResponseDefinitionBuilder;
import com.github.tomakehurst.wiremock.client.WireMock;
import io.restassured.RestAssured;

import static com.github.tomakehurst.wiremock.client.WireMock.*;

public class MockServer {

	static Workbook Workbook = null;
	private static final WireMockServer server = new WireMockServer();
	private static final PropertyReader propertyreader = new PropertyReader();
	static String response = null;
	static String requrstmacher = null;
	static String path = null;
	static String host = null;
	static String flag = null;
	static String content = null;
	static String filePath = "src/test/resources/MockServerData/MockData.xlsx";
	static String requestType = null;
	static int responseCode;
	static int port;

	public static void MockServerSetup() throws IOException {
		if (propertyreader.readProperyFromFile("../../../../config.properties", "MockRequired").equalsIgnoreCase("Y")) {
			server.start();
			System.out.println("***************Mock Server Turned UP!!");
			FileInputStream inputStream = new FileInputStream(filePath);
			Workbook = new XSSFWorkbook(inputStream);

			Sheet Sheet = Workbook.getSheet("SPQR");
			int rowCount = Sheet.getLastRowNum() - Sheet.getFirstRowNum();


			for (int i = 1; i < rowCount + 1; i++) {
				Row row = Sheet.getRow(i);
				for (int j = 0; j < row.getLastCellNum(); j++) {

					if (j == 3) {
						response = row.getCell(j).getStringCellValue();

					}
					if (j == 2) {
						path = row.getCell(j).getStringCellValue();

					}
					if (j == 4) {
						requrstmacher = row.getCell(j).getStringCellValue();

					}

					if (j == 1) {
						host = row.getCell(j).getStringCellValue();
					}
					if (j == 6) {
						flag = row.getCell(j).getStringCellValue();
					}
					if (j == 5) {
						content = row.getCell(j).getStringCellValue();
					}
				if (j == 7) {
					port = (int) row.getCell(j).getNumericCellValue();

				}
				if (j == 8) {
					responseCode =(int) row.getCell(j).getNumericCellValue();
				}
				if (j ==9) {
					requestType = row.getCell(j).getStringCellValue();
				}

			}
			if (flag.equalsIgnoreCase("y")) {
				ResponseDefinitionBuilder mockResponse = new ResponseDefinitionBuilder();
				mockResponse.withStatus(responseCode);
				mockResponse.withHeader("Content-Type", content);
				mockResponse.withBody(response);
				WireMock.configureFor(host, port);
				if (requestType.equalsIgnoreCase("get")) {
					WireMock.stubFor(WireMock.get(path).willReturn(mockResponse));
				} else if (requestType.equalsIgnoreCase("delete")) {
					WireMock.stubFor(WireMock.delete(path).willReturn(mockResponse));
				} else if (requestType.equalsIgnoreCase("post")) {
					System.out.println("********************************************");
					System.out.println(requrstmacher);
					System.out.println("*********************************************");
					WireMock.stubFor(WireMock.put(path)
							.withRequestBody(equalToJson(requrstmacher))

							.willReturn(mockResponse));
					System.out.println("Done");
				} else {
					WireMock.stubFor(WireMock.post(path).willReturn(mockResponse));
				}
			}
		}
		rowCount=0;
		Sheet Sheet2 = Workbook.getSheet("AVAA");
		rowCount = Sheet2.getLastRowNum() - Sheet2.getFirstRowNum();
		
	
		for (int i = 1; i < rowCount+1; i++) {
			Row row = Sheet2.getRow(i);
			for (int j = 0; j < row.getLastCellNum(); j++) {

				if (j == 3) {
					response = row.getCell(j).getStringCellValue();

				}
				if (j == 2) {
					path = row.getCell(j).getStringCellValue();

				}
				if (j == 4) {
					requrstmacher = row.getCell(j).getStringCellValue();

				}
				if (j == 1) {
					host = row.getCell(j).getStringCellValue();
				}
				if (j == 6) {
					flag = row.getCell(j).getStringCellValue();
				}
				if (j == 5) {
					content = row.getCell(j).getStringCellValue();
				}
				if (j == 7) {
					port = (int) row.getCell(j).getNumericCellValue();

				}
				if (j == 8) {
					responseCode =(int) row.getCell(j).getNumericCellValue();
				}
				if (j ==9) {
					requestType = row.getCell(j).getStringCellValue();
				}

			}
			if (flag.equalsIgnoreCase("y")) {
				ResponseDefinitionBuilder mockResponse = new ResponseDefinitionBuilder();
				mockResponse.withStatus(responseCode);
				mockResponse.withHeader("Content-Type", content);
				mockResponse.withBody(response);
				WireMock.configureFor(host, port);
				if (requestType.equalsIgnoreCase("get")) {
					WireMock.stubFor(WireMock.get(path).willReturn(mockResponse));
				} else if (requestType.equalsIgnoreCase("delete")) {
					WireMock.stubFor(WireMock.delete(path).willReturn(mockResponse));
				} else if (requestType.equalsIgnoreCase("put")) {
					System.out.println("********************************************");
					System.out.println(requrstmacher);
					System.out.println("*********************************************");
					WireMock.stubFor(WireMock.put(path)
							.withRequestBody(equalToXml(requrstmacher))

							.willReturn(mockResponse));
					System.out.println("Done");
				} else {
					WireMock.stubFor(WireMock.post(path).willReturn(mockResponse));
				}
			}
		}
		rowCount=0;
		Sheet = Workbook.getSheet("ORDER");
		rowCount = Sheet.getLastRowNum() - Sheet.getFirstRowNum();
		
	
		for (int i = 1; i < rowCount+1; i++) {
			Row row = Sheet.getRow(i);
			for (int j = 0; j < row.getLastCellNum(); j++) {

				if (j == 3) {
					response = row.getCell(j).getStringCellValue();

				}
				if (j == 2) {
					path = row.getCell(j).getStringCellValue();

				}
				if (j == 4) {
					try {
						requrstmacher = row.getCell(j).getStringCellValue();
					} catch (Exception e) {
						requrstmacher = "";
					}

				}
				if (j == 1) {
					host = row.getCell(j).getStringCellValue();
				}
				if (j == 6) {
					flag = row.getCell(j).getStringCellValue();
				}
				if (j == 5) {
					content = row.getCell(j).getStringCellValue();
				}
				if (j == 7) {
					port = (int) row.getCell(j).getNumericCellValue();

				}
				if (j == 8) {
					responseCode = (int) row.getCell(j).getNumericCellValue();
				}
				if (j == 9) {
					requestType = row.getCell(j).getStringCellValue();
				}

			}
			System.out.println("Priore to mock");
			if (flag.equalsIgnoreCase("y")) {
				ResponseDefinitionBuilder mockResponse = new ResponseDefinitionBuilder();
				mockResponse.withStatus(responseCode);
				mockResponse.withHeader("Content-Type", content);
				System.out.println(content);
				mockResponse
						.withBody(response);
				WireMock.configureFor(host, port);
				if (requestType.equalsIgnoreCase("get")) {
					System.out.println("In Order Get");
					WireMock.stubFor(WireMock.get(path).willReturn(mockResponse));
				} else if (requestType.equalsIgnoreCase("delete")) {
					System.out.println("In Order Delete");
					WireMock.stubFor(WireMock.delete(path).willReturn(mockResponse));
				} else if (requestType.equalsIgnoreCase("put")) {
					System.out.println("In Order Order Put");
					System.out.println("********************************************");
					System.out.println(requrstmacher);
					System.out.println("*********************************************");
					if (content.contains("xml")) {
						WireMock.stubFor(WireMock.put(path)
								.withRequestBody(equalToXml(requrstmacher))

								.willReturn(mockResponse));
						System.out.println("Done");
					} else if (content.contains("json")) {
						WireMock.stubFor(WireMock.put(path)
								.withRequestBody(equalToJson(requrstmacher))

								.willReturn(mockResponse));
						System.out.println("Done with put method" + requrstmacher);
					}
				} else {
					System.out.println("In Order post");
					System.out.println("********************************************");
					System.out.println(requrstmacher);
					System.out.println("*********************************************");
					if (content.contains("xml")) {
						WireMock.stubFor(WireMock.post(path)
								.withRequestBody(equalToXml(requrstmacher))

								.willReturn(mockResponse));
						System.out.println("Done");
					} else if (content.contains("json")) {
						WireMock.stubFor(WireMock.post(path)
								.withRequestBody(equalToJson(requrstmacher))

								.willReturn(mockResponse));
						System.out.println("Done");
					}
				}
			}
		}
		}


	}

	public void MockServerTearDown() throws IOException {
		if (propertyreader.readProperyFromFile("../../../../config.properties", "MockRequired").equalsIgnoreCase("Y")) {
			server.shutdownServer();
			System.out.println("Mock Server Turned Down!!");
		}
	}

	public static void main(String[] args) throws IOException {
		MockServerSetup();
	}
}
