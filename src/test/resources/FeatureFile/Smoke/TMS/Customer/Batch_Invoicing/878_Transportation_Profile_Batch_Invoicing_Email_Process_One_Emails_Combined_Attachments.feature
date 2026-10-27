Feature: 878 - Transportation Profile- Batch Invoicing Email Process-One Email Combined Attachments

  @Regression @TMS @Smoke @API @WEB @DeleteFile @Customer @SingleCurrency @878 @After
  Scenario: 878 - Transportation Profile- Batch Invoicing Email Process-One Email Combined Attachments

    When Login into Salesforce

# Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Go to "Billing" Tab
    Then Click on Edit icon on Label "Batch Invoicing Email Process"
    Then Update details
      | Batch Invoicing Email Process          |
      | One Email, Combined Invoice Attachment |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

# Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | HOUSTON TEXANS | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 2500   | NA           | NA       | NA             |
    Then Save Load With All details
    Then Close Toast message

# Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."


 # Step 4
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "6" Seconds
    Then Scroll into Section "General Information"
    Then Get Details
      |Invoice Number | Master Invoice Number | Invoice Date |
      |               |                       |              |
    Then Set "MIN1H" with "SysData=>Master Invoice Number"
    Then Convert Date format "Invoice Date" from "M/d/yyyy" to "MM-dd-yyyy"
    Then Set "MIN1H1" with "SysData=>MIN1H" and "-"
    Then Set "MIN1" with "SysData=>MIN1H1" and "SysData=>Invoice Date"
    Then Set "MIN_1" with "SysData=>MIN1" and ".pdf"
    Then Capture the current URL for "Invoice_1"
# Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | LTL  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | HOUSTON TEXANS | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Equipment   | 6000   | NA           | NA       | NA             |
    Then Save Load With All details

# Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

 # Step 7
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Wait for "6" Seconds
    Then Scroll into Section "General Information"
    Then Get Details
      | Invoice Number          | Master Invoice Number          | Invoice Date          |
      |                         |                                |                       |
    Then Set "MIN2" with "SysData=>Master Invoice Number"

    Then Set "MIN2H" with "SysData=>Master Invoice Number"
    Then Convert Date format "Invoice Date" from "M/d/yyyy" to "MM-dd-yyyy"
    Then Set "MIN2H1" with "SysData=>MIN2H" and "-"
    Then Set "MIN2" with "SysData=>MIN2H1" and "SysData=>Invoice Date"
    Then Set "MIN_2" with "SysData=>MIN2" and ".pdf"

    Then Capture the current URL for "Invoice_2"

# Step 8
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Wait for "3" Seconds
    Then Manage "Created Date" in "descending" Order
    Then Select Multiple Records from List
      | Data1       | Data2       |
      | SysData=>1L | SysData=>2L |
    Then Click on "Generate & Send" with Text
    Then Wait for "30" Seconds
    Then Wait for "60" Seconds

# Step 9 Expected Result A
    Then Verify the email attachment has "SysData=>MIN_1" or "SysData=>MIN_2" as an attachment with subject "Sandbox: Transportation Invoices Due"

##Step 10 Expected Result B
    Then Get Pdf content from "Email" with Subject "Sandbox: Transportation Invoices Due"
    Then Verify Pdf contains "SysData=>1L"
    Then Verify Pdf contains "SysData=>2L"