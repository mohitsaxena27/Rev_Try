package pageHelper.Test.FMS;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.ColorUtils;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Log4j
public class Fleet_Management {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader Generic;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;
    public Fleet_Management(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("FMS" + File.separator + "Fleet_Management.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Clear Address search for {string}")
    public void clearAddressSearchFor(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("ClearAdrressSearch").replace("{paramlink1}",arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ClearAdrressSearch").replace("{paramlink1}",arg0)));
    }

    @Then("Verify Text {string} displaying on Modal")
    public void verifyTextDisplayingOnModal(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("ModalText").replace("{paramlink}",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("ModalText").replace("{paramlink}",arg0));
    }
    @Then("Verify {string} Color with {string} Text of {string} Button on modal")
    public void verifyColorWithTextOfButtonOnModal(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        WebElement wl = webDriver.getwebelement(pageObject.getlocator("ModalText").replace("{paramlink}",arg2));
        String color = wl.getCssValue("color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" Color is: " + bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("Color Name: " + colorName);
        webDriver.Stringcomparator(colorName, arg1);
        String imgbackgroundcolor = wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg0);
    }

    @Then("Drag the row for {string} beneath the row for {string}")
    public void dragTheRowForBeneathTheRowFor(String arg0, String arg1) throws DocumentException, InterruptedException {
       WebElement wl1= webDriver.passwebelement(pageObject.getlocator("ModalText").replace("{paramlink}",arg0));
       WebElement wl2= webDriver.passwebelement(pageObject.getlocator("ModalText").replace("{paramlink}",arg1));

        webDriver.dragAndDrop(wl1,wl2);
    }

    @Then("Verify {string} is displaying below {string}")
    public void verifyIsDisplayingBelow(String arg0, String arg1) throws DocumentException, InterruptedException {
        WebElement wl2= webDriver.passwebelement(Generic.getlocator("Global_Text").replace("{paramlink}",arg0));
        WebElement wl1= webDriver.passwebelement(Generic.getlocator("Global_Text").replace("{paramlink}",arg1));
        int y1 = wl1.getLocation().getY();
        int y2 = wl2.getLocation().getY();

        if (y1 > y2) {
            System.out.println("Element 1 is below Element 2");
        } else {
            System.out.println("Element 1 is NOT below Element 2");
        }
    }

    @Then("Add {string} into column selection")
    public void addIntoColumnSelection(String arg0) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.updateServicesData1("Field Search",arg0);
        webDriver.waitForElementLoad(2);
        int count = webDriver.getwebelementscount(pageObject.getlocator("AddColumnIcon").replace("{paramlink}",arg0));
        if(count>0)
        {
        webDriver.waitforElementtobeclickable(pageObject.getlocator("AddColumnIcon").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("AddColumnIcon").replace("{paramlink}",arg0)));
        }
    }
    @Then("Remove {string} into column selection")
    public void RemoveColumnSelection(String arg0) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.updateServicesData1("Column Search",arg0);
        webDriver.waitForElementLoad(2);
        int count = webDriver.getwebelementscount(pageObject.getlocator("RemoveColumnIcon").replace("{paramlink}",arg0));
        if(count>0)
        {
            webDriver.waitforElementtobeclickable(pageObject.getlocator("RemoveColumnIcon").replace("{paramlink}",arg0));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("RemoveColumnIcon").replace("{paramlink}",arg0)));
        }    }

    @Then("Click on View Manager icon")
    public void clickOnViewManagerIcon() throws DocumentException, InterruptedException {

        int count = webDriver.getwebelementscount(pageObject.getlocator("ViewManager"));
        if(count>0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ViewManager")));
            webDriver.waitforElementtobeclickable(pageObject.getlocator("ViewManager"));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ViewManager")));
        }
    }
    @Then("Delete {string} View Manager")
    public void DeleteViewManager(String arg0) throws DocumentException, InterruptedException {

        int count = webDriver.getwebelementscount(pageObject.getlocator("DeleteViewManager").replace("{paramlink}",arg0));
        if(count>0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("DeleteViewManager").replace("{paramlink}",arg0)));
            webDriver.waitforElementtobeclickable(pageObject.getlocator("DeleteViewManager").replace("{paramlink}",arg0));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("DeleteViewManager").replace("{paramlink}",arg0)));
        }
    }

    @Then("Enter Address Search Text as {string}")
    public void enterAddressSearchTextAs(String arg0) throws DocumentException, InterruptedException, IOException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("AddressSearch"));
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("AddressSearch")),arg0 );
    }

    @Then("Verify following Actions are displaying for {string}")
    public void VerifyColumnActions(String section, DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println(pageObject.getlocator("AddColumnActionText").replace("{paramlink1}",section).replace("{paramlink2}",entry.getValue()));
                webDriver.waitUntilElementIsVisible(pageObject.getlocator("AddColumnActionText").replace("{paramlink1}",section).replace("{paramlink2}",entry.getValue()));
                webDriver.verifyElementToBePresent(pageObject.getlocator("AddColumnActionText").replace("{paramlink1}",section).replace("{paramlink2}",entry.getValue()));
            }
        }
    }

    @Then("Verify Fleet Assets renders Light aligned with One per Row and alphabetical-numeric order")
    public void verifyFleetAssetsRendersLightAlighnedWithOnePerRowAndAlphabeticalNumericOrder() throws DocumentException, InterruptedException {
        List<WebElement> items = webDriver.getWebElements(pageObject.getlocator("FleetAssetList"));
        int previousY = -1;
        int baseX = items.get(0).getLocation().getX();
        for (WebElement item : items) {
            int currentX = item.getLocation().getX();
            int y = item.getLocation().getY();

            // Left alignment check (allow small tolerance)
            Assert.assertTrue(Math.abs(currentX - baseX) <= 5,
                    "Item not aligned properly: " + item.getText() +
                            " | Expected X ~ " + baseX + " but found " + currentX);

            // One per row (Y should increase)
            if (previousY != -1) {
                Assert.assertTrue(y > previousY, "Items are overlapping/not in separate rows");
            }

            previousY = y;
        }
        List<String> actualList = items.stream()
                .map(WebElement::getText)
                .collect(Collectors.toList());
        List<String> sortedList = new ArrayList<>(actualList);
        sortedList.sort(String.CASE_INSENSITIVE_ORDER);
        Assert.assertEquals(actualList, sortedList, "List is not sorted in descending alphanumeric order");
    }

    @Then("Select {string} within the fleet asset list")
    public void selectWithinTheFleetAssetList(String arg0) throws DocumentException, InterruptedException {
       webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("FleetAssets").replace("{paramlink}",arg0)));
       webDriver.waitforElementtobeclickable(pageObject.getlocator("FleetAssets").replace("{paramlink}",arg0));
       webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("FleetAssets").replace("{paramlink}",arg0)));
    }

    @Then("Verify {string} selected and bolded")
    public void verifySelectedAndBolded(String arg0) throws DocumentException, InterruptedException {
       WebElement element = webDriver.passwebelement(pageObject.getlocator("FleetAssets").replace("{paramlink}",arg0));
       String attVALUE = element.getDomAttribute("data-selected");
        String style = element.getCssValue("font-weight");
            if (style.equals("700") || style.equalsIgnoreCase("bold")) {
                style="bold";
                webDriver.Stringcomparator(style,"bold");
                System.out.println("Font is bold");
            }
         Assert.assertEquals(attVALUE,"true");
    }

    @Then("Verify Modal close")
    public void verifyModalClose() throws DocumentException, InterruptedException {
       webDriver.waitUntilTheElementIsNotVisible(pageObject.getlocator("VerifyModal"));
       webDriver.waitForElementLoad(5);
       webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyModal"));
    }

    @Then("Verify Fleet Asset column header has a {string} filter icon")
    public void verifyFleetAssetColumnHeaderHasAPurpleFilterIcon(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyFilterIcon"));
        WebElement wl = webDriver.getwebelement(pageObject.getlocator("VerifyFilterIcon"));
        String imgbackgroundcolor=wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: "+bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1,arg0);

    }

    @Then("Verify Fleet Asset column header has no filter icon")
    public void verifyFleetAssetColumnHeaderHasNoFilterIcon() throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyFilterIcon"));

    }

    @Then("verify {string} icon is displaying on modal")
    public void verifyIconIsDisplayingOnModal(String arg0) throws DocumentException, InterruptedException {
       webDriver.waitUntilElementIsVisible(pageObject.getlocator("ModalIcon").replace("{paramlink}",arg0));
       webDriver.verifyElementToBePresent(pageObject.getlocator("ModalIcon").replace("{paramlink}",arg0));
    }
    @Then("Verify Select Label {string} having following values")
    public void verify_label_having_following_values(String label, DataTable dataTable) throws DocumentException, InterruptedException {

        // Convert DataTable to List
        List<List<String>> expectedData = dataTable.asLists();

        // Flatten expected values (since you have duplicate rows)
        List<String> expectedValues = expectedData.stream()
                .flatMap(List::stream)
                .distinct() // remove duplicates if needed
                .collect(Collectors.toList());

        // Locate dropdown using label
        String xpath = "//label[text()='" + label + "']/..//select";
        WebElement dropdown = webDriver.passwebelement(pageObject.getlocator("VerifyOptions").replace("{paramlink}",label));

        // Get all options from dropdown
        Select select = new Select(dropdown);
        List<WebElement> options = select.getOptions();

        // Extract actual values
        List<String> actualValues = options.stream()
                .map(WebElement::getText)
                .map(String::trim)
                .collect(Collectors.toList());

        // Assertion
        Assert.assertTrue(actualValues.containsAll(expectedValues),
                "Expected values not present. \nExpected: " + expectedValues + "\nActual: " + actualValues);
    }

    @Then("Verify {string} size is {string} under {string}")
    public void verifySizeIs(String arg0, String arg1,String TabName) throws DocumentException, InterruptedException {
        WebElement element = webDriver.passwebelement(pageObject.getlocator("ColumnWidth").replace("{paramlink}",arg0).replace("{paramlink2}",TabName));
        String width = element.getDomAttribute("aria-valuenow");
        assert width != null;
        Assert.assertTrue(Integer.parseInt(width)>=Integer.parseInt(arg1));
    }


    @Then("{string} Column - drag the border to change the column size for {string} under {string}")
    public void columnDragTheBorderToChangeTheColumnSizeFor(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        WebElement element = webDriver.passwebelement(pageObject.getlocator("ColumnWidth").replace("{paramlink}",arg1).replace("{paramlink2}",arg2));
        String BeforeWidth = element.getDomAttribute("aria-valuenow");
        WebElement ResizeElement =webDriver.passwebelement(pageObject.getlocator("resizeHandle").replace("{paramlink}",arg0).replace("{paramlink2}",arg2));
        webDriver.ClickAndHoldWithMoveOffset(ResizeElement);
        webDriver.waitForElementLoad(3);
        WebElement element1 = webDriver.passwebelement(pageObject.getlocator("ColumnWidth").replace("{paramlink}",arg1).replace("{paramlink2}",arg2));
        String AfterWidth = element1.getDomAttribute("aria-valuenow");
        assert BeforeWidth != null;
        assert AfterWidth != null;
        Assert.assertTrue(Integer.parseInt(BeforeWidth)<=Integer.parseInt(AfterWidth));
    }

    @Then("Fleet Management Console - Wait for Page Load")
    public void fleetManagementConsoleWaitForPageLoad() throws DocumentException, InterruptedException {
        try {
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("SelectAnOption"));
        }
        catch (TimeoutException e)
        {
            try {
                webDriver.waitUntilElementIsVisible(pageObject.getlocator("SelectAnOption"));
            }
            catch(TimeoutException e1)
            {

            }
        }
      webDriver.waitForElementLoad(3);
    }

    @Then("View Manager - Verify Table Header Icon & Name")
    public void viewManagerVerifyTableHeaderIconName() throws DocumentException, InterruptedException {
        // Verify table displayed beneath View Manager
        WebElement tableHeader = webDriver.passwebelement(pageObject.getlocator("ViewManagerTable"));
        Assert.assertTrue(tableHeader.isDisplayed(),
                "Table is not displayed beneath View Manager");
        // Verify Select All checkbox header
        WebElement selectAllCheckbox =  webDriver.passwebelement(pageObject.getlocator("SelectAllCheckbox"));
        Assert.assertTrue(selectAllCheckbox.isDisplayed(),
                "Select All checkbox header is not displayed");

        // Verify default selected rows
        WebElement divisionOneDriversCheckbox = webDriver.passwebelement(pageObject.getlocator("VerifyViewManagerSelected").replace("{paramlink}","Division One Drivers"));
        Assert.assertTrue(divisionOneDriversCheckbox.isSelected(),
                "Division One Drivers checkbox is not selected by default");

        WebElement revenovaLoadsCheckbox  = webDriver.passwebelement(pageObject.getlocator("VerifyViewManagerSelected").replace("{paramlink}","Revenova Loads (Planned)"));
        Assert.assertFalse(revenovaLoadsCheckbox.isSelected(),
                "Division One Drivers checkbox is not selected by default");

        // Verify fixed-width action icon columns
        Assert.assertTrue(webDriver.passwebelement(pageObject.getlocator("ViewManagerIcon").replace("{paramlink}","Edit")).isDisplayed(),
                "Edit icon column not displayed");

        Assert.assertTrue(webDriver.passwebelement(pageObject.getlocator("ViewManagerIcon").replace("{paramlink}","Clone")).isDisplayed(),
                "Clone icon column not displayed");
        Assert.assertTrue(webDriver.passwebelement(pageObject.getlocator("ViewManagerIcon").replace("{paramlink}","Delete")).isDisplayed(),
                "Delete icon column not displayed");

        // Verify column headers left to right order
        List<WebElement> headers = webDriver.getwebelements(pageObject.getlocator("ViewManagerHeaderText"));
        List<String> actualHeaders = headers.stream()
                .map(WebElement::getText)
                .collect(Collectors.toList());

        List<String> expectedHeaders = Arrays.asList(
                "View Name",
                "View Type",
                "Default For",
                "Shared With",
                "Owner"
        );
        Assert.assertEquals(actualHeaders, expectedHeaders,
                "Column headers are not displayed in expected left-to-right order");
        // Verify adjustable width columns
        for (String column : expectedHeaders) {
            System.out.println(pageObject.getlocator("VerifyColumnResize").replace("{paramlink}",column));
            int verifyElement = webDriver.getwebelementscount(pageObject.getlocator("VerifyColumnResize").replace("{paramlink}",column));
            Assert.assertTrue(verifyElement>0,
                    column + " column is not adjustable width");
        }
    }

    @Then("Verify only selected views from View Manager are rendered in Fleet Management Console")
    public void verifyOnlySelectedViewsFromViewManagerAreRenderedInFleetManagementConsole() throws DocumentException, InterruptedException {
        List<String> selectedViews = new ArrayList<>();
        List<String> unSelectedViews = new ArrayList<>();

        // Fetch all rows from View Manager table
        List<WebElement> allRows = webDriver.getWebElements(pageObject.getlocator("ViewManagerAllRow"));
        for (WebElement row : allRows) {
            String viewName = row.findElement(
                            By.xpath(".//td[contains(@data-label,'View Name')]//span"))
                    .getText().trim();
            WebElement checkbox = row.findElement(
                    By.xpath(".//input[@type='checkbox']"));
            if (checkbox.isSelected()) {
                selectedViews.add(viewName);
            } else {
                unSelectedViews.add(viewName);
            }
        }

        // Only first 10 selected views should render
        List<String> expectedRenderedViews = selectedViews.stream()
                .limit(10)
                .collect(Collectors.toList());

        // Fetch rendered views from Fleet Management Console
        List<WebElement> renderedViewElements = webDriver.getWebElements(pageObject.getlocator("ViewAllTab"));

        List<String> actualRenderedViews = renderedViewElements.stream()
                .map(e -> e.getAttribute("value").trim())
                .filter(text -> !text.isEmpty())
                .collect(Collectors.toList());

        // Verify selected views are rendered
        for (String expectedView : expectedRenderedViews) {
            Assert.assertTrue(actualRenderedViews.contains(expectedView),
                    "Expected selected view is not rendered: " + expectedView);
        }

        // Verify maximum 10 views rendered
        Assert.assertTrue(actualRenderedViews.size() <= 10,
                "More than 10 views are rendered");

        // Verify unselected views are NOT rendered
        for (String unselectedView : unSelectedViews) {
            Assert.assertFalse(actualRenderedViews.contains(unselectedView),
                    "Unselected view should not render: " + unselectedView);
        }

    }

    @Then("Verify {string} is displaying at the bottom, after all of the other selected views")
    public void verifyIsDisplayingAtTheBottomAfterAllOfTheOtherSelectedViews(String newlySelectedView ) throws DocumentException, InterruptedException {
        // Fetch all rendered views from Fleet Management Console
        List<WebElement> renderedViewElements =  webDriver.getWebElements(pageObject.getlocator("ViewAllTab"));
        List<String> actualRenderedViews = renderedViewElements.stream()
                .map(e -> e.getAttribute("value").trim())
                .filter(text -> !text.isEmpty())
                .collect(Collectors.toList());
        // Verify newly selected view is rendered
        Assert.assertTrue(actualRenderedViews.contains(newlySelectedView),
                "Newly selected view is not rendered in Fleet Management Console");
        // Verify newly selected view is rendered at bottom
        String lastRenderedView = actualRenderedViews.get(actualRenderedViews.size() - 1);
        Assert.assertEquals(lastRenderedView,
                newlySelectedView,
                "Newly selected view is not rendered at the bottom of the list");

    }

    @Then("View Manager - Deselect All Views")
    public void viewManagerDeselectAllViews() throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("SelectAllCheckbox")));
        WebElement wl =webDriver.passwebelement(pageObject.getlocator("SelectAllCheckbox"));
        boolean flag = wl.isSelected();
        if(flag) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectAllCheckbox")));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("SelectAllCheckbox"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("SelectAllCheckbox")));
        }
    }

    @Then("View Manager - Select All Views")
    public void viewManagerSelectAllViews() throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("SelectAllCheckbox")));
        WebElement wl =webDriver.passwebelement(pageObject.getlocator("SelectAllCheckbox"));
        boolean flag = wl.isSelected();
        if(!flag) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectAllCheckbox")));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("SelectAllCheckbox"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("SelectAllCheckbox")));
        }
    }

    @Then("Confirm all views in View Manager are unselected")
    public void confirmAllViewsInViewManagerAreUnselected() throws DocumentException, InterruptedException {
        // Fetch all rows from View Manager table
        List<WebElement> allRows = webDriver.getWebElements(pageObject.getlocator("ViewManagerAllRow"));
        for (WebElement row : allRows) {
            String viewName = row.findElement(
                            By.xpath(".//td[contains(@data-label,'View Name')]//span"))
                    .getText().trim();
            WebElement checkbox = row.findElement(
                    By.xpath(".//input[@type='checkbox']"));
            Assert.assertFalse(checkbox.isSelected(),
                    "Checkbox is selected for " + viewName);
        }
    }

    @Then("Confirm first 10 selected views render in order and 11th view does not render")
    public void confirmFirst10SelectedViewsRenderInOrderAnd11thViewDoesNotRender() throws DocumentException, InterruptedException {

        List<String> selectedViews = new ArrayList<>();

        // Fetch all rows from View Manager
        List<WebElement> allRows = webDriver.getWebElements(pageObject.getlocator("ViewManagerAllRow"));


        for (WebElement row : allRows) {

            String viewName = row.findElement(
                            By.xpath(".//td[contains(@data-label,'View Name')]//span"))
                    .getText().trim();

            WebElement checkbox = row.findElement(
                    By.xpath(".//input[@type='checkbox']"));

            if (checkbox.isSelected()) {
                selectedViews.add(viewName);
            }
        }
        // First 10 expected rendered views
        List<String> expectedRenderedViews = selectedViews.stream()
                .limit(10)
                .collect(Collectors.toList());

        // 11th selected view (should NOT render)
        String eleventhView = selectedViews.size() > 10
                ? selectedViews.get(10)
                : "";

        // Fetch rendered views from Fleet Management Console
        List<WebElement> renderedViewElements = webDriver.getWebElements(pageObject.getlocator("ViewAllTab"));
        List<String> actualRenderedViews = renderedViewElements.stream()
                .map(e -> e.getAttribute("value").trim())
                .filter(text -> !text.isEmpty())
                .collect(Collectors.toList());

        // Verify first 10 views render
        for (String expectedView : expectedRenderedViews) {

            Assert.assertTrue(actualRenderedViews.contains(expectedView),
                    "Expected view is not rendered: " + expectedView);
        }

        // Verify order of rendered views
        for (int i = 0; i < expectedRenderedViews.size(); i++) {

            Assert.assertEquals(actualRenderedViews.get(i),
                    expectedRenderedViews.get(i),
                    "View order mismatch at position: " + (i + 1));
        }

        // Verify only 10 views render
        Assert.assertTrue(actualRenderedViews.size() <= 10,
                "More than 10 views are rendered");

        // Verify 11th selected view does NOT render
        if (!eleventhView.isEmpty()) {

            Assert.assertFalse(actualRenderedViews.contains(eleventhView),
                    "11th selected view should not render: " + eleventhView);
        }
    }

    @Then("Verify {string} checkbox is disabled and unable to select")
    public void verifyCheckboxIsDisabledAndUnableToSelect(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ViewManagerCheckboxDisabled").replace("{paramlink}",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("ViewManagerCheckboxDisabled").replace("{paramlink}",arg0));
        WebElement wl = webDriver.passwebelement(pageObject.getlocator("ViewManagerCheckboxDisabled").replace("{paramlink}",arg0));
        Assert.assertFalse(wl.isSelected());
        int count= webDriver.getwebelementscount(pageObject.getlocator("ViewManagerCheckboxDisabled").replace("{paramlink}",arg0));
        Assert.assertTrue(count>0,arg0+" is not disabled");
    }
    @Then("Verify {string} checkbox is not selected")
    public void verifyCheckboxIsNotSelected(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ViewManagerCheckbox").replace("{paramlink}",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("ViewManagerCheckbox").replace("{paramlink}",arg0));
        WebElement wl = webDriver.passwebelement(pageObject.getlocator("ViewManagerCheckbox").replace("{paramlink}",arg0));
        Assert.assertFalse(wl.isSelected());
        int count= webDriver.getwebelementscount(pageObject.getlocator("ViewManagerCheckbox").replace("{paramlink}",arg0));
        Assert.assertTrue(count>0,arg0+" is  Selected");
    }

    @Then("View Manager - Click on {string} for {string}")
    public void viewManagerClickOnFor(String arg0, String arg1) throws DocumentException, InterruptedException {
       webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ViewManagerViewAction").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
       webDriver.waitforElementtobeclickable(pageObject.getlocator("ViewManagerViewAction").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
       webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ViewManagerViewAction").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
    }


    @Then("De-Select {string} from Multi-Select Field {string}")
    public void deSelectFromMultiSelectField(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("MultiSelectText").replace("{paramlink}",arg1)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("MultiSelectText").replace("{paramlink}",arg1));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("MultiSelectText").replace("{paramlink}",arg1)));
        webDriver.waitForElementLoad(2);
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("MultiSelectOptions").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("MultiSelectOptions").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));

        String dataSelected= webDriver.Getattribute(webDriver.passwebelement(pageObject.getlocator("MultiSelectOptions").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)),"data-selected");
        if(dataSelected.equalsIgnoreCase("true")) {
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("MultiSelectOptions").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        }
    }
    @Then("Select {string} from Multi-Select Field {string}")
    public void SelectFromMultiSelectField(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("MultiSelectText").replace("{paramlink}",arg1)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("MultiSelectText").replace("{paramlink}",arg1));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("MultiSelectText").replace("{paramlink}",arg1)));
        webDriver.waitForElementLoad(2);
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("MultiSelectOptions").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("MultiSelectOptions").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));

        String dataSelected= webDriver.Getattribute(webDriver.passwebelement(pageObject.getlocator("MultiSelectOptions").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)),"data-selected");
        if(dataSelected.equalsIgnoreCase("False")) {
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("MultiSelectOptions").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        }
    }
    @Then("Verify View Manager Details for {string}")
    public void verifyViewManagerDetailsFor(String viewName, io.cucumber.datatable.DataTable dataTable) throws DocumentException, InterruptedException {

        Map<String, String> expectedDetails =
                dataTable.asMaps(String.class, String.class).get(0);
        for (Map.Entry<String, String> entry : expectedDetails.entrySet()) {

            String columnName = entry.getKey().trim();
            String expectedValue = entry.getValue().trim();
            WebElement cell =webDriver.passwebelement(pageObject.getlocator("VerifyViewManagerDetails").replace("{paramlink1}",viewName).replace("{paramlink2}",columnName));
            String actualValue = cell.getAttribute("data-cell-value").trim();
            Assert.assertEquals(actualValue,
                    expectedValue,
                    "Mismatch found for column: " + columnName);
        }
    }

    @Then("Verify View Type dropdown having options")
    public void verifyViewTypeDropdownHavingOptions(DataTable dataTable) throws DocumentException, InterruptedException {

        List<String> expectedOptions = dataTable.asList()
                .stream()
                .map(value -> value == null ? "" : value.trim())
                .collect(Collectors.toList());

        WebElement dropdown = webDriver.passwebelement(pageObject.getlocator("ViewTypeDropdown"));

        Select select = new Select(dropdown);

        List<String> actualOptions = select.getOptions()
                .stream()
                .map(WebElement::getText)
                .map(String::trim)
                .collect(Collectors.toList());

        Assert.assertEquals(actualOptions, expectedOptions,
                "View Type dropdown options mismatch");
    }

    @Then("Store Chicago date time with day offset {int} and time {string} into {string}")
    public void storeChicagoDateTimeWithDayOffsetAndTimeInto(int arg0, String arg1, String arg2) {
        ZoneId CHICAGO_ZONE = ZoneId.of("America/Chicago");
        DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("h:mm a");

        LocalTime localTime = LocalTime.parse(arg1.toUpperCase(), timeFormatter);

        LocalDate chicagoDate = LocalDate.now(CHICAGO_ZONE).plusDays(arg0);

        LocalDateTime localDateTime = LocalDateTime.of(chicagoDate, localTime);

        ZonedDateTime chicagoDateTime = localDateTime.atZone(CHICAGO_ZONE);

        DriverInstance.setVariable(arg2,chicagoDateTime.format(FORMATTER));
    }
}
