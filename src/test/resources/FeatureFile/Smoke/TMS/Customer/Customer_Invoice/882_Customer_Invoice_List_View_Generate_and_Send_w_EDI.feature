Feature: 882 - Customer Invoice- List View- Generate and Send w/EDI

  @WEB @API @Regression @Priority_1 @SingleCurrency @Customer @Customer_Invoice @882
  Scenario: 882 - Customer Invoice- List View- Generate and Send w/EDI

    When Login into Salesforce

   #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI |
      | True        | True                 |
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "API User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | LTL  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Washington Commanders | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Material     | 5000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

  # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Wait for "4" Seconds
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

  # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 5
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on "Load Status"
    Then Update details
      | Load Status   |
      |  Delivered         |
    Then Click on "Save" button on Details Page
    Then Wait for "4" Seconds

    #Step 6
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Click on Edit icon on Label "Invoice Status"
    Then Update details
      | Invoice Status   |
      |  Approved        |
    Then Click on "Save" button on Details Page
    Then Wait for "4" Seconds

    #Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Revenova HQ | LTL  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Washington Commanders | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       |  Bananas    | 6000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_2"

    #Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Wait for "4" Seconds
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier Two - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 10
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on "Load Status"
    Then Update details
      | Load Status   |
      |  Delivered         |
    Then Click on "Save" button on Details Page
    Then Wait for "4" Seconds

    #Step 11
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Click on Edit icon on Label "Invoice Status"
    Then Update details
      | Invoice Status   |
      |  Approved        |
    Then Click on "Save" button on Details Page
    Then Wait for "4" Seconds

    #Step 12
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Revenova HQ | LTL  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Washington Commanders | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Water  | 7800 | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_3"

    #Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Wait for "4" Seconds
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 14
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier Two - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #step 15
    Then Go to "EDI" Tab
    Then Click on Edit icon on Label "EDI Status"
    Then Update details
      | EDI Status | EDI Provider |
      | Accept     | Kleinschmidt |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | EDI Status |
      | Accept     |

    #Step 16
    Then Go to "Shipment" Tab
    Then Wait for "2" Seconds
    Then Verify "2D" Stop with "Washington Commanders"
    Then Wait for "2" Seconds
    Then Click on "2D" "Departed" chevron
    Then Update details
      |Departure Date|
      |3            |
    Then Click on "2D" "Save" button
    Then Verify "2D" Shipment is "Departed"
    Then Wait for "5" Seconds
    Then Refresh current Page

    #Step 17
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "3L" on QuoteInvoice Tab
    Then Click on Edit icon on Label "Invoice Status"
    Then Update details
      | Invoice Status   |
      |  Approved        |
    Then Scroll into Section "Billing Contact Information"
    Then Update details
      | Billing Method |
      | EDI            |
    Then Click on "Save" button on Details Page
    Then Wait for "4" Seconds
