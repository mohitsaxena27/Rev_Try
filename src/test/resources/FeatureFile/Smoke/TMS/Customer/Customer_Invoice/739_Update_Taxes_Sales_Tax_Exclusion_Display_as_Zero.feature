Feature: 739 - Customer Invoice Banner LWC- Update Taxes- Sales Tax Exclusion- Display as Zero

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Customer @Customer_Invoice @739
  Scenario: 739 - Customer Invoice Banner LWC- Update Taxes- Sales Tax Exclusion- Display as Zero

    When Login into Salesforce
    #Pre-Step1
    Then Open "TMS Admin" from App Launcher
    Then Wait for "3" Seconds
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
    Then Navigate to stored URL for "TMS_Admin"
    Then Go to "Sales Taxes" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Alberta GST" with Text -
    Then Switch to Parent Frame
    Then Scroll into Section "General Information"
    Then Get Details
         |Tax Rate|
         |        |
    # Step 1>1
    Then Navigate to stored URL for "TMS_Admin"
    Then Go to "Sales Tax Exclusions" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on button with Title "New Sales Tax Exclusion" -
    Then Switch to Parent Frame
    Then Update details
         |Account        |Sales Tax  |Tax Treatment|
         |Edmonton Eatery|Alberta GST|Display as Zero Amount|
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Capture the current URL for "Sales_Tax_Exclusions"
    Then Set Key "Sales_Tax_Exclusions_Record_Id" page Record Id with "rtms__SalesTaxExclusion__c"

   # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Edmonton Eatery | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                    | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Hamilton Hockey Supplies | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Same_as_Customer | NA              | 7             | NA                       | NA               | NA                   |
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
    #Step 4
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Store "1" Tax Amount on to "Alberta GST"
    Then Verify "SysData=>Alberta GST" is Zero

    # Step 5
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
    
#    Then Open "Loads" from App Launcher
#    Then Open Load Number "L-131"

 # Step 6
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Go to "Related" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "2" Times
    Then Scroll Until Related List for "Customer Invoice Taxes"
    #Step 7
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax   | Tax Amount |
      | Alberta GST | 0.00      |

    # Step  8
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Click on link "Customer Invoice Taxes"
    Then Wait for "2" Seconds
    Then Delete "Customer Invoice Taxes" with data "Alberta GST"
    Then Verify Message displaying as "Customer Invoice Tax was deleted."
    Then Navigate Back & Refresh

   # Step 8>1
   # expected results a & b
    Then Click on button "Update Taxes"
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Scroll down with "3" Times
    Then Scroll Until Related List for "Customer Invoice Taxes"
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax   | Tax Amount | Tax Rate |
      | Alberta GST |  0.00      | 0.000%   |
    







