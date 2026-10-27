package core;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.time.Duration;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import groovy.beans.PropertyReader;
import io.appium.java_client.AppiumBy;
import io.appium.java_client.InteractsWithApps;
import io.appium.java_client.android.options.UiAutomator2Options;
import io.appium.java_client.windows.options.WindowsOptions;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.*;
import org.openqa.selenium.devtools.DevTools;
import org.openqa.selenium.devtools.HasDevTools;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.zaproxy.clientapi.core.ClientApi;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.windows.WindowsDriver;
import io.restassured.RestAssured;
import io.restassured.config.HttpClientConfig;
import io.restassured.config.RestAssuredConfig;
import java.util.logging.Level;
import org.apache.http.params.CoreConnectionPNames;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import io.restassured.specification.RequestSpecification;

import static org.openqa.selenium.chrome.ChromeOptions.LOGGING_PREFS;

public class baseDriver implements apiDriver, webDriver,desktopDriver,mobileDriver
{
	public   ThreadLocal<ClientApi> ZapScanner=new ThreadLocal<ClientApi>();
	public static Process p;

    public void runKillCommand() {
        // Commands to kill both Edge browser and EdgeDriver processes
        String[] commands = {
                "cmd.exe /c taskkill /F /IM msedgedriver.exe /T",
                "cmd.exe /c taskkill /F /IM msedge.exe /T"
        };

        for (String command : commands) {
            try {
                System.out.println("Executing: " + command);
                ProcessBuilder builder = new ProcessBuilder(command.split(" "));
                builder.redirectErrorStream(true);
                Process process = builder.start();

                // Read and print process output
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println(line);
                    }
                }

                int exitCode = process.waitFor();
                System.out.println("Process exited with code: " + exitCode);
            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

	public WebDriver webinit(String browser, String BaseURL, Boolean Grid, Boolean proxyRequired, boolean HeadlessMode) throws Exception {
		WebDriver dr = null;
		System.out.println("In Web Initiator");
		if(!Grid) {
			if (browser.equalsIgnoreCase("chrome")) {
                Map<String, Object> prefs = new HashMap<>();
                prefs.put("profile.default_content_setting_values.notifications", 2); // 2 = block
                prefs.put("profile.default_content_setting_values.geolocation", 2);
                ChromeOptions options = new ChromeOptions();
                options.setExperimentalOption("prefs", prefs);
                options.addArguments("--no-sandbox");
                options.addArguments("--disable-dev-shm-usage");
                options.addArguments("--disable-notifications");
                if(HeadlessMode) {
                    options.addArguments("--headless");          // Run in headless mode
                    options.addArguments("--window-size=1920,1080");  // Set viewport size
                    System.out.println(browser +": Running on Headless");
                }
                try {

                    dr = new ChromeDriver(options);
                    dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
                    dr.manage().window().maximize();
                    dr.get(BaseURL);
                }
                catch(Exception e)
                {
                    Thread.sleep(2000);
                    dr = new ChromeDriver(options);
                    dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
                    dr.manage().window().maximize();
                    dr.get(BaseURL);
                }

			}
			else if(browser.equalsIgnoreCase("edge"))
			{
                try {
                String dir = System.getProperty("user.dir")+ File.separator+"lib"+File.separator+"msedgedriver.exe";
                System.setProperty("webdriver.edge.driver", dir);
                Map<String, Object> prefs = new HashMap<>();
				prefs.put("profile.default_content_setting_values.notifications", 2); // 2 = block
                prefs.put("profile.default_content_setting_values.geolocation", 2);
				EdgeOptions options = new EdgeOptions();
				options.setExperimentalOption("prefs", prefs);
				options.addArguments("--no-sandbox");
				options.addArguments("--disable-dev-shm-usage");
				options.addArguments("--disable-notifications");
				if(HeadlessMode) {
                    options.addArguments("--headless");          // Run in headless mode
                    options.addArguments("--window-size=1920,1080");  // Set viewport size
					System.out.println(browser +": Running on Headless");
				}
					dr = new EdgeDriver(options);
					dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
					dr.manage().window().maximize();
					dr.get(BaseURL);
				}
				catch(Exception e)
				{
                    try {
                        Thread.sleep(2000);
                        Map<String, Object> prefs = new HashMap<>();
                        prefs.put("profile.default_content_setting_values.notifications", 2); // 2 = block
                        prefs.put("profile.default_content_setting_values.geolocation", 2);
                        EdgeOptions options = new EdgeOptions();
                        options.setExperimentalOption("prefs", prefs);
                        options.addArguments("--no-sandbox");
                        options.addArguments("--disable-dev-shm-usage");
                        options.addArguments("--disable-notifications");
                        if(HeadlessMode) {
                            options.addArguments("--headless");          // Run in headless mode
                            options.addArguments("--window-size=1920,1080");  // Set viewport size
                            System.out.println(browser +": Running on Headless");
                        }
                        dr = new EdgeDriver(options);
                        dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
                        dr.manage().window().maximize();
                        dr.get(BaseURL);
                    } catch (Exception ex) {
                        System.out.println("Failed to initialize " + browser);
                        throw e;
                    }
				}

			}
			else if(browser.equalsIgnoreCase("firefox")){
				WebDriverManager.firefoxdriver().setup();
				FirefoxOptions options = new FirefoxOptions();
				if(HeadlessMode) {
					options.addArguments("--headless");
					System.out.println(browser +": Running on Headless");
				}
				dr =new FirefoxDriver(options);
				dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
				dr.manage().deleteAllCookies();
				dr.manage().window().maximize();
				dr.get(BaseURL);
			}
			else {
				System.out.println("For IE Browser");
			}

		}
        if(HeadlessMode) {
            dr.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(60));
            dr.manage().window().setSize(new Dimension(1920, 1080));
        }
		return dr;
	}

    public WebDriver webInitWithoutSysProperty(String browser, String BaseURL, Boolean Grid, Boolean proxyRequired, boolean HeadlessMode) throws Exception {
        WebDriver dr = null;
        System.out.println("In Web Initiator");
        if(!Grid) {
            if (browser.equalsIgnoreCase("chrome")) {
                Map<String, Object> prefs = new HashMap<>();
                prefs.put("profile.default_content_setting_values.notifications", 2); // 2 = block
                prefs.put("profile.default_content_setting_values.geolocation", 2);
                ChromeOptions options = new ChromeOptions();
                options.setExperimentalOption("prefs", prefs);
                options.addArguments("--no-sandbox");
                options.addArguments("--disable-dev-shm-usage");
                options.addArguments("--disable-notifications");
                if(HeadlessMode) {
                    options.addArguments("--headless");          // Run in headless mode
                    options.addArguments("--window-size=1920,1080");  // Set viewport size
                    System.out.println(browser +": Running on Headless");
                }
                try {

                    dr = new ChromeDriver(options);
                    dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
                    dr.manage().window().maximize();
                    dr.get(BaseURL);
                }
                catch(Exception e)
                {
                    Thread.sleep(2000);
                    dr = new ChromeDriver(options);
                    dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
                    dr.manage().window().maximize();
                    dr.get(BaseURL);
                }

            }
            else if(browser.equalsIgnoreCase("edge"))
            {
                Map<String, Object> prefs = new HashMap<>();
                prefs.put("profile.default_content_setting_values.notifications", 2); // 2 = block
                prefs.put("profile.default_content_setting_values.geolocation", 2);
                EdgeOptions options = new EdgeOptions();
                options.setExperimentalOption("prefs", prefs);
                options.addArguments("--no-sandbox");
                options.addArguments("--disable-dev-shm-usage");
                options.addArguments("--disable-notifications");
                if(HeadlessMode) {
                    options.addArguments("--headless");          // Run in headless mode
                    options.addArguments("--window-size=1920,1080");  // Set viewport size
                    System.out.println(browser +": Running on Headless");
                }
                try {
                    dr = new EdgeDriver(options);
                    dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
                    dr.manage().window().maximize();
                    dr.get(BaseURL);
                }
                catch(Exception e)
                {
                    Thread.sleep(2000);
                    dr = new EdgeDriver(options);
                    dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
                    dr.manage().window().maximize();
                    dr.get(BaseURL);
                }

            }
            else if(browser.equalsIgnoreCase("firefox")){
                WebDriverManager.firefoxdriver().setup();
                FirefoxOptions options = new FirefoxOptions();
                if(HeadlessMode) {
                    options.addArguments("--headless");
                    System.out.println(browser +": Running on Headless");
                }
                dr =new FirefoxDriver(options);
                dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
                dr.manage().deleteAllCookies();
                dr.manage().window().maximize();
                dr.get(BaseURL);
            }
            else {
                System.out.println("For IE Browser");
            }

        }
        if(HeadlessMode) {
            dr.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(60));
            dr.manage().window().setSize(new Dimension(1920, 1080));
        }
        return dr;
    }


	private static void deleteDirectory(java.io.File directory)
	{
		if (directory.isDirectory()) {
			java.io.File[] files = directory.listFiles();
			if (files != null) {
				for (java.io.File file : files) {
					deleteDirectory(file);
				}
			}
		}
		directory.delete();
	}

	public WindowsDriver desktopinit(String Application) throws Exception {

		WindowsDriver desktopSession = null;
		WindowsOptions capabilities = new WindowsOptions();
		capabilities.setApp(Application);
		capabilities.setCapability("app",Application);
		capabilities.setPlatformName("Windows");
		capabilities.setCapability("deviceName", "WindowsPC");
		capabilities.setWaitForAppLaunch(Duration.ofSeconds(20));
		capabilities.setExperimentalWebDriver(false);
		desktopSession = new WindowsDriver(new URL("http://127.0.0.1:4783"), capabilities);
		Thread.sleep(10000);
		desktopSession.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));

		return desktopSession;
	}

	public AppiumDriver mobileinit(String Device, String appPackage,String AppActivity,String Platform,String Application) throws Exception {

		AppiumDriver mobileDriver;
//		DesiredCapabilities cap = new DesiredCapabilities();
		UiAutomator2Options cap = new UiAutomator2Options();
		cap.setPlatformName(Platform);
		cap.setDeviceName(Device);
		cap.setNewCommandTimeout(Duration.ofSeconds(60));
		cap.setAutomationName("UiAutomator2");
		cap.setPlatformVersion("14");
		cap.setNoReset(false);
		cap.setCapability("appium:autoLaunch",false);
		cap.setCapability("appium:autoGrantPermissions",true);
		cap.setAppWaitActivity(AppActivity);
		if(!Application.equalsIgnoreCase("")) {
			cap.setApp(Application);
		}
		else
		{
			cap.setAppPackage(appPackage);
			cap.setAppActivity(AppActivity);
		}

		mobileDriver = new AndroidDriver(new URL("http://127.0.0.1:4783"),cap);
		mobileDriver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
		((InteractsWithApps) mobileDriver).activateApp(appPackage);
		mobileDriver.findElement(AppiumBy.id("org.wikipedia:id/fragment_onboarding_skip_button")).click();
		return mobileDriver;
	}
	public RequestSpecification apiinit(String baseurl) {
		// TODO Auto-generated method stub
		RequestSpecification httpRequest;
//		System.out.println("In API Initiator");
		RestAssured.baseURI = baseurl;
		@SuppressWarnings("deprecation")
		RestAssuredConfig config = RestAssured.config()
		        .httpClient(HttpClientConfig.httpClientConfig()
		                .setParam(CoreConnectionPNames.CONNECTION_TIMEOUT, 100000)
		                .setParam(CoreConnectionPNames.SO_TIMEOUT, 100000));
		//System.out.println(RestAssured.baseURI);
		httpRequest = RestAssured.given().config(config);
		return httpRequest;
	}

	public ClientApi ReturnZapScanner() {
		System.out.println("Zap Scanner Return method"+ZapScanner.get());
		return ZapScanner.get();
	}

	public Process ReturncurrentProcess() {
		System.out.println("Zap Scanner Return method"+ZapScanner);
		return p;
	}

    public WebDriver LaunchBrowserWithLink(String Link,Boolean HeadlessMode) throws InterruptedException {
        WebDriver dr = null;
        String dir = System.getProperty("user.dir")+ File.separator+"lib"+File.separator+"msedgedriver.exe";
        System.setProperty("webdriver.edge.driver", dir);
//                WebDriverManager.edgedriver().setup();
        Map<String, Object> prefs = new HashMap<>();
        prefs.put("profile.default_content_setting_values.notifications", 2); // 2 = block
        EdgeOptions options = new EdgeOptions();
        options.setExperimentalOption("prefs", prefs);
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");
        options.addArguments("--disable-notifications");
        options.addArguments("--disable-gpu");
        options.addArguments("--no-sandbox");
        options.setExperimentalOption("excludeSwitches", new String[]{"enable-automation"});
        options.setExperimentalOption("useAutomationExtension", false);
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0");
        if(HeadlessMode) {
            options.addArguments("--headless=new");          // Run in headless mode
            options.addArguments("--window-size=1920,1080");  // Set viewport size
        }
        try {
            dr = new EdgeDriver(options);
            dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
            dr.manage().window().maximize();
            dr.get(Link);
            ((JavascriptExecutor) dr).executeScript(
                    "Object.defineProperty(navigator, 'webdriver', {get: () => undefined})"
            );
        }
        catch(Exception e)
        {
            Thread.sleep(2000);
            dr = new EdgeDriver(options);
            dr.manage().timeouts().implicitlyWait(Duration.ofSeconds(30));
            dr.manage().window().maximize();
            dr.get(Link);
        }
        return dr;
    }



}