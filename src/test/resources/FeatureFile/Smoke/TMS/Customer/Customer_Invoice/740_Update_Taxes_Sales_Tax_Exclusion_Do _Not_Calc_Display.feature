Feature: 740 - Customer Invoice Banner LWC-Update Taxes-Sales Tax Exclusion-Do Not Calc/Display

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Customer @Customer_Invoice @740
  Scenario: 740 - Customer Invoice Banner LWC-Update Taxes-Sales Tax Exclusion-Do Not Calc/Display

    When Login into Salesforce
    #Pre-Step1
    Then Open "TMS Admin" from App Launcher
    Then Wait for "2" Seconds
    Then Capture the current URL for "TMS_Admin"
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
    |Calculate and Display Taxes|
    |True                       |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Sales Taxes" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Alberta GST" with Text -
    Then Switch to Parent Frame
    Then Scroll into Section "General Information"
    Then Get Details
         |Tax Rate|
         |        |
    # Step 1>1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Sales Tax Exclusions" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on button with Title "New Sales Tax Exclusion" -
    Then Switch to Parent Frame
    Then Update details
         |Account        |Sales Tax  |Tax Treatment|
         |Boston Beans   |Alberta GST|Do Not Calculate or Display|
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Capture the current URL for "Sales_Tax_Exclusions"
    Then Set Key "Sales_Tax_Exclusions_Record_Id" page Record Id with "rtms__SalesTaxExclusion__c"

   # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans    | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                    | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Hamilton Hockey Supplies | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address  | Edmonton Eatery | 7             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | mixed       | 12345  | NA           | NA       | NA             |
    Then Save Load With All details

    # Step 3

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1200"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    # Step 4
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status |
      | Delivered   |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      |Load Status      |
      |Delivered |
    Then Refresh current Page
    Then Wait for "4" Seconds

 # Step 5
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
 # Step 6
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
    |Tax Amount|
    |          |
    Then Go to "Related" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "2" Times
    Then Scroll Until Related List for "Customer Invoice Taxes"
    Then Verify No Records Available with "Customer Invoice Taxes"

   # Step 7
    Then Click on button "Update Taxes"
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page
    Then Scroll into Section "Invoice Summary"

    #Expected Result a
    Then Verify Details
      |Tax Amount|
      |          |
    Then Go to "Related" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "2" Times
    Then Scroll Until Related List for "Customer Invoice Taxes"
    Then Verify No Records Available with "Customer Invoice Taxes"
    







