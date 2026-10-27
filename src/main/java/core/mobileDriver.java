package core;

import io.appium.java_client.AppiumDriver;
import io.restassured.specification.RequestSpecification;
import org.openqa.selenium.WebDriver;

public interface mobileDriver {
	AppiumDriver mobileinit(String Device, String appPackage, String AppActivity, String Platform, String Application) throws Exception;
	 
	}
