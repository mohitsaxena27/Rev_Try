Feature: 3449 - EDI Inbound 210- Field Mapping Original JSON

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @3449
  Scenario: 3449 - EDI Inbound 210- Field Mapping Original JSON

    When Login into Salesforce

#   Pre-conditions
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI |
      | True        | True                 |
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "User User"

    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode | Lane     | Category | Rate Type | Status   |
      | Revenova HQ            | LTL  | US to US | Customer | Freight   | Accepted |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Rate Method     | Handling Units | HU Calculation Method     | HU Max Weight | Rate |
      | Per HU Position | Pallets        | Adjusted by HU Max Weight | 1500          | 10   |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_Name"
    Then Capture the current URL for "Rate_Entry_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

#    Step2
    Then Open "Loads" from App Launcher
 #   Then Open Load Number "L-776"
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Mixed       | 6000   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 1 | Stop 2   | Bananas     | 5000   | NA           | 2        | Pallets        | 36     | 36    | 36     | NA             | 60         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 3         | Stop 1 | Stop 2   | Grapes      | 4000   | NA           | 2        | Pallets        | 24     | 24    | 24     | NA             | 70         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step3
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Order Information"
    Then Click on Edit icon on Label "EDI Status"
    Then Update details
      | EDI Status | EDI Provider |
      | Accept     | Kleinschmidt |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Wait for "EDI Status" Field Value Update with "Accept"
    Then Verify Details
      | EDI Status |
      | Accept     |
    Then Refresh current Page

    #Step4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier Two - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "3000"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "1000"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

#    Step5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Add Note for "Customer Quote Items" "Net Freight Charges" as "123@#$"
    Then Add "Load" "Customer Quote Items" "Fuel Surcharge" with Unit as "Percent of Freight" Qty as "100" and Price "4000" with all details
    Then Wait for "2" Seconds
    Then Add Note for "Customer Quote Items" "Fuel Surcharge" as "TEST Fuel Note 456$%^"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

#    Step6
    Then Go to "Summary" Tab
    Then Click on "2D" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date |
      | 3              |
    Then Click on "2D" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step7 & 8
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Go to "Related" Tab
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Customer Invoice Accessorials"
    Then Click on link "Customer Invoice Accessorials"
    Then Wait for "2" Seconds
    Then Click on button with Title "New"

#   # Step 9,10
    Then Select Multiple "After Hours Pick Up,,Guaranteed" from "Accessorials" list and click on "Add to Invoice >>"
    Then Wait for "2" Seconds
    Then Update "After Hours Pick Up" accessorial data
      | Qty  | Unit Price | Unit       |
      | 1.00 | 100.00     | Fixed Cost |
    Then Wait for "2" Seconds
    Then Update the "Guaranteed" accessorial data
      | Qty  | Unit Price | Unit     |
      | 1.00 | 00.25      | Per Mile |
    Then Wait for "5" Seconds
    Then Refresh current Page

    #Step11
    Then Go to "Details" Tab
    Then Scroll into Section "Billing Contact Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | EDI            |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds

    #Step 12
    Then Click on "Send via EDI" with Text
    Then Verify Success Message displaying as "Invoice was successfully sent via EDI."

    #Step13
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"

#    #Step14  Expected result
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "210" and "Direction" as "Outbound"
    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Pending |            |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |

    Then Get Attribute "invoiceDate" and store into "tms_invDate" from "Transaction Payload"
    Then Verify Json "Transaction Payload" with File "Transaction_payload.json"
      | ShipmentId  | {CurrentDateYYYY-MM-DD} | {CurrentDateYYYY-MM-DD+5} | {CurrentDateYYYY-MM-DD+3} | {CurrentDateYYYY-MM-DD+2} |{invoiceDate}|
      | SysData=>1L | 0                       | 5                         | 3                         | 2                         |SysData=>tms_invDate|