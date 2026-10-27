package utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Locale;
import java.util.Properties;

public class PropReader {

    private static ThreadLocal<Properties> prop = new ThreadLocal<>();
    public static void setConfig(Properties properties) {
        prop.set(properties);
    }
    public static Properties getConfig() {
        return prop.get();
    }
    public static String get(String key) {
        return getConfig().getProperty(key);
    }

    public static Properties load(String org) {
        Properties prop = new Properties();
        String fileName = "config-" + org + ".properties";

        try (FileInputStream fis = new FileInputStream(fileName)) {
            prop.load(fis);
        } catch (Exception e) {
            throw new RuntimeException("Failed to load config: " + org);
        }
        return prop;
    }

	public static  String readproperty(String key) throws IOException
	{ 
		InputStream file;
    	String St=null;
	    Properties pr= new Properties();
		file= new FileInputStream(".\\config.properties");
	    pr.load(file);
	    St=pr.getProperty(key);
	    file.close();
	    return St;
	}

	public static void updateproprty(String key,String value) throws IOException {
		FileInputStream in = new FileInputStream(".\\config.properties");
		Properties props = new Properties();
		props.load(in);
		in.close();
		FileOutputStream out = new FileOutputStream(".\\config.properties");
		props.setProperty(key, value);
		props.store(out, null);
		out.close(); 
	}
}
