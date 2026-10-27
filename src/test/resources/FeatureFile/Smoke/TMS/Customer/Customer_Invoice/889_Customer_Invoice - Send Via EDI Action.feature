Feature: 889 - Customer Invoice Banner LWC- Send Via EDI Action

  @WEB @API @Regression @TMS @Smoke @SingleCurrency @Customer @Customer_Invoice @889
  Scenario: 889 - Customer Invoice Banner LWC- Send Via EDI Action

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
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mustard     | 15000  | NA           | NA       | NA             |
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

  # Step5
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

   # Step 6
    Then Go to "Summary" Tab
    Then Click on "2D" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date |
      | 3              |
    Then Click on "2D" "Save" button
    Then Verify Success Message displaying as "Save was successful."

   # Step7
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab

  # Step8
    Then Go to "Details" Tab
    Then Scroll into Section "Billing Contact Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | EDI            |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds

  # Step9 Expected result a
    Then Click on "Send via EDI" with Text
    Then Note the current Date and Time
    Then Set "CurrentDateTime" with "MM/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Verify Success Message displaying as "Invoice was successfully sent via EDI."

  #Step 10 Expected result b
    Then Go to "Details" Tab
    Then Scroll into Section "Billing Contact Information"
    Then Verify Details
      | Invoice Status | EDI Processed Date |
      | Pending        | NA                 |
    Then Get Details
      | Date Sent |
      |           |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

  # Step11,12 Expected result c
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    #Expected c
    Then Verify "EDI Transactions" "Transaction Type" "210" count as "1"
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "210"
    Then Verify "EDI Transactions" "Direction" is displaying as "Outbound"

  #Step 13  Expected Result d
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Click on Customer Quote from FQA Page
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |