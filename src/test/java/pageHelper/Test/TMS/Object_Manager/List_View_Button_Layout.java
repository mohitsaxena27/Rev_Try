package pageHelper.Test.TMS.Object_Manager;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

@Log4j
public class List_View_Button_Layout {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader commomXml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public List_View_Button_Layout(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        commomXml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Object_Manager"+File.separator+"List_View_Button_Layout.xml");
    }

    @Then("Click on down-arrow for {string}")
    public void clickOnDownArrowFor(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ShowMoreDropdown").replace("{paramlink}",arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("ShowMoreDropdown").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ShowMoreDropdown").replace("{paramlink}",arg0)));
    }

    @Then("select {string} to Selected Buttons")
    public void selectToSelectedButtons(String option) throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(pageObject.getlocator("SelectedButtons").replace("{paramlink}", option));
        System.out.println("count is:"+count);
        if(webDriver.getwebelementscount(pageObject.getlocator("SelectedButtons").replace("{paramlink}", option))>0) {
            //Verify selected and displaying in Selected Buttons
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("SelectedButtons").replace("{paramlink}", option)));
            webDriver.waitForElementLoad(1);
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("SelectedButtons").replace("{paramlink}", option)));
            webDriver.verifyElementToBePresent(pageObject.getlocator("SelectedButtons").replace("{paramlink}", option));
        }
        else{
        //    webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("AvailableButtons").replace("{paramlink}", option)));
            webDriver.waitForElementLoad(1);
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("AvailableButtons").replace("{paramlink}", option)));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("AvailableButtons").replace("{paramlink}", option)));
            // Click "Move to Chosen" (right arrow button)
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(commomXml.getlocator("WithoutActiveTitle").replace("{paramlink}", "Add")));
            webDriver.WaitforElementtobeclickable(commomXml.getlocator("WithoutActiveTitle").replace("{paramlink}", "Add"));
            webDriver.ClickOnElement(webDriver.getwebelement(commomXml.getlocator("WithoutActiveTitle").replace("{paramlink}", "Add")));
            webDriver.waitForElementLoad(1);
            //Verify selected and displaying on cosen List
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("SelectedButtons").replace("{paramlink}", option)));
            webDriver.waitForElementLoad(1);
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("SelectedButtons").replace("{paramlink}", option)));
            webDriver.verifyElementToBePresent(pageObject.getlocator("SelectedButtons").replace("{paramlink}", option));

        }
    }
}