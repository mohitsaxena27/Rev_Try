Feature: 879 - Transportation Profile- Batch Invoicing Email Process-One Email Individual Invoice Attachments

  @Regression @TMS @Smoke @API @WEB @DeleteFile @Customer @SingleCurrency @879
  Scenario: 879 - Transportation Profile- Batch Invoicing Email Process-One Email Individual Invoice Attachments

    When Login into Salesforce

# Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Go to "Billing" Tab
    Then Click on Edit icon on Label "Batch Invoicing Email Process"
    Then Update details
      | Batch Invoicing Email Process          |
      | One Email, Individual Invoice Attachments |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page"
# Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Vanilla       | 1550   | NA           | NA       | NA             |
    Then Save Load With All details

# Step 3 & 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

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
      | N       | 2D   | Account_Address |  Chicago Pizza | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Salt   | 8500   | NA           | NA       | NA             |
    Then Save Load With All details

# Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds

 # Step 7, 8 & 9
# Step 9
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Wait for "3" Seconds
    Then Manage "Created Date" in "descending" Order
    Then Select Multiple Records from List
      | Data1       | Data2       |
      | SysData=>1L | SysData=>2L |
    Then Click on "Generate & Send" with Text
    Then Wait for "90" Seconds

# Step 10 Expected Result A
    Then Set "PdfName1" with "SysData=>1L" and " - Customer Invoice.pdf"
    Then Set "PdfName2" with "SysData=>2L" and " - Customer Invoice.pdf"

    Then Verify the email attachment has "SysData=>PdfName1" as an attachment with subject "Sandbox: Transportation Invoices Due"
    Then Verify the email attachment has "SysData=>PdfName2" as an attachment with subject "Sandbox: Transportation Invoices Due"
