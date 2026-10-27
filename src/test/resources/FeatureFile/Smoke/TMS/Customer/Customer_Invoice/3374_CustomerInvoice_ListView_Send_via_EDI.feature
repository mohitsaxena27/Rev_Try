Feature: 3374 - Customer Invoice- List View- Send via EDI

  @Regression @API @WEB @TMS @Smoke @SingleCurrency @Customer @Customer_Invoice @3374
  Scenario: 3374 - Customer Invoice- List View- Send via EDI

    When Login into Salesforce
    #Step1
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Open "Customer Invoice" Object Manager
    Then Click on "List View Button Layout" with Text
    Then Click on down-arrow for "List View"
    Then Click on button with Title "Edit"
    Then Switch to Frame by Title "Edit Search Layout: Customer Invoices List View ~ Salesforce - Enterprise Edition"
    Then select "Send Via EDI" to Selected Buttons
    Then Wait for "5" Seconds
    Then Click on button with Title "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI |
      | True        | True                 |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 3
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
      | 1         | P1     | D2       | Mustard     | 5000   | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load1"

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    Then Click on Customer Quote from FQA Page
    Then Capture the current URL for "Customer_Quote_Load1"
    Then Wait for "2" Seconds
    Then Navigate Browser Back

    #Step 5
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 6
    Then Go to "EDI" Tab
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

    #Step 7
    Then Go to "Summary" Tab
    Then Click on "2D" "Departed" chevron
    Then Update details
      | Departure Date |
      | 3              |
    Then Click on "2D" "Save" button
    Then Verify "2D" Shipment is "Departed"
    Then Wait for "5" Seconds

    #Step 8
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "6" Seconds

    #Step9
    Then Scroll into Section "Billing Contact Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | EDI            |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Method |
      | EDI            |
    #Step 10
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Revenova HQ | LTL  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Relish      | 7500   | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load2"

    #Step 11
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    Then Click on Customer Quote from FQA Page
    Then Capture the current URL for "Customer_Quote_Load2"
    Then Wait for "2" Seconds
    Then Navigate Browser Back

    #Step 12
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 13
    Then Go to "EDI" Tab
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

    #Step 14
    Then Go to "Summary" Tab
    Then Click on "2D" "Departed" chevron
    Then Update details
      | Departure Date |
      | 3              |
    Then Click on "2D" "Save" button
    Then Verify "2D" Shipment is "Departed"
    Then Wait for "3" Seconds

    #Step 15
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Wait for "6" Seconds

    #Step 16
    Then Scroll into Section "Billing Contact Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | EDI            |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Method |
      | EDI            |

    #Step 17
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Manage "Created Date" in "descending" Order
    Then Select Multiple Records from List
      | Data1       | Data2       |
      | SysData=>1L | SysData=>2L |

    #Step 17.a, 17a.i
    Then Click If button with Title "Show 2 more actions" is enabled
    Then Click on button with Title "Send Via EDI" -
    Then Set "CurrentDateTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "2" Seconds

    Then Switch to Frame by Title "accessibility title"
    Then Verify Heading Text "Send Invoices"

    #Step 17.b
    Then Verify Text displaying as "Processing 2 of 2" -
    Then Verify Text displaying as "Processing complete." -
    Then Verify Text displaying as "2 invoices sent. 0 Invoices failed." -
    Then Click on "Return to Previous Page" with Text -
    Then Switch to Parent Frame

    #Step 18
    Then Navigate to stored URL for "Load1"

    Then Go to "EDI" Tab

    #Expected a.2
    Then Verify "EDI Transactions" "Transaction Type" "210" count as "1"

    #Expected a.1 and a.3
    Then Select "EDI Transactions" with "Transaction Type" as "210" and "Direction" as "Outbound"
    Then Verify details for
      | Transaction Type | Direction | Status  |
      | 210              | Outbound  | Pending |
    Then Navigate Browser Back

    #Step 19
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "2" Seconds

    #Expected b
    Then Scroll into Section "General Information"
    Then Verify Details
      | Invoice Status | EDI Processed Date |
      | Pending        |                    |
    Then Get Details
      |Date Sent|
      |         |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 20
    Then Navigate to stored URL for "Customer_Quote_Load1"
    Then Wait for "2" Seconds

    #Expected c
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 21
    Then Navigate to stored URL for "Load2"

    Then Go to "EDI" Tab

    #Expected d.2
    Then Verify "EDI Transactions" "Transaction Type" "210" count as "1"

    #Expected d.1 and d.3
    Then Select "EDI Transactions" with "Transaction Type" as "210" and "Direction" as "Outbound"
    Then Verify details for
      | Transaction Type | Direction | Status  |
      | 210              | Outbound  | Pending |
    Then Navigate Browser Back

    #Step 22
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Wait for "2" Seconds

    #Expected e
    Then Scroll into Section "General Information"
    Then Verify Details
      | Invoice Status | EDI Processed Date |
      | Pending        |                    |
    Then Get Details
      |Date Sent|
      |         |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 23
    Then Navigate to stored URL for "Customer_Quote_Load2"
    Then Wait for "2" Seconds

    #Expected c
    Then Verify Details
      | Billing Status |
      | Invoiced       |