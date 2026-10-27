Feature: 1165 - Carrier Guest LWC - Simple Tender: Carrier Quote - Accepted False

  @Regression @TMS @Priority_1 @WEB @SingleCurrency @Carrier @Headed @Carrier_Guest @1165
  Scenario: 1165 - Carrier Guest LWC - Simple Tender: Carrier Quote - Accepted False

    When Login into Salesforce
    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 4             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Tender Email" -
    Then Click on "Legend" Link Text "Tender" on Page -
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | Tendered    |
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Set Carrier Quote value on to "Carrier_Quote"

    #Step 3
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds
    Then Scroll into "Carrier Quotes" on QuoteInvoice Tab
    Then Open "Carrier Quotes" using value from "Carrier_Quote" on QuoteInvoice Tab
    Then Wait for "3" Seconds
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Click on Edit icon on Label "Accepted"
    Then Update details
      | Accepted |
      | False    |
    Then Click on "Save" button
    Then Wait for "4" Seconds

    #Step 4
    Then Set "Email_Subject" with "Load Tender for SysData=>1L"
    Then Wait for Email to Receive On Email
    Then Get "Accept Quote" link from Email for Subject "SysData=>Email_Subject"
    Then Launch browser and Navigate Link
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds
    Then Guest - Click on button with Text "Accept"
    Then Wait for "3" Seconds

    #Expected Result a
    Then Guest - Verify Text displaying as "Error - Carrier Tender"
    Then Guest - Verify Text displaying as "This load link is obsolete and can no longer be acted upon."
    Then Guest - Verify Text displaying as "Sorry, we could not process your current action."
    Then Guest - Verify Text displaying as "Please try again later."
    Then Close Guest Browser
