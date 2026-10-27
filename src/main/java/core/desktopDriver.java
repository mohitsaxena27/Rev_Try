package core;

import io.appium.java_client.windows.WindowsDriver;
import io.restassured.specification.RequestSpecification;

public interface desktopDriver {
	  WindowsDriver desktopinit(String baseUrl) throws Exception; // interface method
	 
	}
