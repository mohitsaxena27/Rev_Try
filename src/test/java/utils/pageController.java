package utils;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.windows.WindowsDriver;
import org.openqa.selenium.WebDriver;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;


public class pageController {

	//public static final ThreadLocal<calculatorPageHelperBDD> Calculator= new InheritableThreadLocal<>();
	//public static final ThreadLocal<wikiPageHelperBDD> WikiMobile= new InheritableThreadLocal<>();
	//public static final ThreadLocal<APIHelper> API= new InheritableThreadLocal<>();
	//public static final ThreadLocal<DemoAPI> APIPage= new InheritableThreadLocal<>();


//	public static final ThreadLocal<VideoAudioHelperMobile> VideoAudioMob= new InheritableThreadLocal<>();
//	public static final ThreadLocal<VideoAudioHelperDesktop> VideoAudioDesk= new InheritableThreadLocal<>();


	public void initPage(WebDriver driver){
		DriverController DriverControler=new DriverController();
		DriverControler.setDriver(driver);


	}

	public void initPage(WindowsDriver driver){
		DriverController DriverControler=new DriverController();
		DriverControler.setDesktopDriver(driver);
//		calculatorPageHelperBDD CP= new calculatorPageHelperBDD(DriverControler);
//
//		Calculator.set(CP);


	}

	public void initPage(AppiumDriver driver) throws Exception {
		DriverController DriverControler=new DriverController();
		DriverControler.setMobileDriver(driver);
//		wikiPageHelperBDD WP= new wikiPageHelperBDD(DriverControler);
//		WikiMobile.set(WP);


	}
		public void initPage(RequestSpecification dr,Response respoence) throws Exception {
//			APIHelper SP=new APIHelper(dr,respoence);
//			API.set(SP);
			//DemoAPI dm = new DemoAPI(dr, respoence);
			//APIPage.set(dm);
			System.out.println("Initiated");
		}


}