Feature: 742 - Customer Invoice Banner LWC- Generate- Customer Inv Docs Required Validation

  @Regression @API @WEB @smoke @SingleCurrency @Customer @Customer_Invoice @742
  Scenario: 742 - Customer Invoice Banner LWC- Generate- Customer Inv Docs Required Validation

    When Login into Salesforce

    #Step 1

    Then Open "TMS Admin" from App Launcher
    Then Go to "Customer Invoice Documents" Tab
    Then Switch to Frame by Title "accessibility title"
    Then "Delivery Receipt" : Select "Invoice Action" as "Always Include"
    Then Click on button with Title "Save"

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Denver Deli Meats|Truckload       | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000 |NA          |NA       |NA       |
    Then Save Load With All details
    Then Capture the current URL for "Load_Url"

    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 4
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered        |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

    #Step 5
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Click on "L-" with "Invoice Status" as "Pending"
    Then Wait for "4" Seconds

    #Step 6 and expected result a
    Then Click on button "Generate"
    Then Wait for "3" Seconds
#    Then Verify Message displaying as "The following required documents are missing: SysData=>1L Delivery Receipt"
    Then Verify Text displaying as "The following required documents are missing: SysData=>1L Delivery Receipt"