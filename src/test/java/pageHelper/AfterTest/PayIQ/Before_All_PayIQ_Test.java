package pageHelper.AfterTest.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Test.PayIQ.PayIQ_Admin;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author Sufiya
 */
public class Before_All_PayIQ_Test {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;
    Common_Apis ca;
    CommonFunction cmf;
    CommonFunction_Frame cff;
    Common_Steps_Frame cf;
    PayIQ_Admin pa;

    public Before_All_PayIQ_Test(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Admin.xml");
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        pa = new PayIQ_Admin(DriverInstance);

    }

    @Before(value = "@PayIQ",order=2)
    public void After_2984(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        try {
            ca.verifyAndUpdateAllPayIQProgramStatusIsPending();
        }
        catch (Exception e)
        {
            try {
                ca.verifyAndUpdateAllPayIQProgramStatusIsPending();
            }
            catch(Exception e1)
            {
                System.out.println("Unable to Reset status if any PayIQ Program is Open");
            }

        }
    }



}