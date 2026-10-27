Feature: 880 - Transportation Profile- Batch Invoicing Email Process-Multi Emails Indiv Attachments (SingleCust)

  @Regression @TMS @Smoke @API @WEB @DeleteFile @Customer @SingleCurrency @880
  Scenario: 880 - Transportation Profile- Batch Invoicing Email Process-Multi Emails Indiv Attachments (SingleCust)

    When Login into Salesforce

# Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Los Angeles Lighting" from List
    Then Go to "Billing" Tab
    Then Click on Edit icon on Label "Batch Invoicing Email Process"
    Then Update details
      | Batch Invoicing Email Process                    |
      | Multiple Emails, Individual Invoice Attachments |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page"

# Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       |  Los Angeles Lighting | LTL | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address |  Boston Beans | NA             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Material     | 6500   | NA           | NA       | NA            |
    Then Save Load With All details

# Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

# Step 4
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

# Step 5, 6,7
    Then Execute Load "1L" Clone with count "2" and Customer Quote as "True" and Carrier Quote as "False"

# Step 8
    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List

# Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

 # step 10 & 11
    Then Open "Loads" from App Launcher
    Then Open "1L2C" Created Load from List

# Step 12
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

# Step 13 & 14
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Wait for "3" Seconds
    Then Manage "Created Date" in "descending" Order
    Then Select Multiple Records from List
      | Data1       | Data2         | Data3         |
      | SysData=>1L | SysData=>1L1C | SysData=>1L2C |
    Then Click on "Generate & Send" with Text
    Then Wait for "40" Seconds
    Then Wait for "60" Seconds

#  Step 15 Expected Result A
    Then Set "PdfName" with "SysData=>1L" and " - Customer Invoice.pdf"
    Then Set "SubjectName" with "Sandbox: " and "SysData=>1L"
    Then Verify the email attachment has "SysData=>PdfName" as an attachment with subject "SysData=>SubjectName"

#  Step 16 Expected Result b
    Then Set "PdfName" with "SysData=>1L1C" and " - Customer Invoice.pdf"
    Then Set "SubjectName" with "Sandbox: " and "SysData=>1L1C"
    Then Verify the email attachment has "SysData=>PdfName" as an attachment with subject "SysData=>SubjectName"

    #  Step 17 Expected Result c
    Then Set "PdfName" with "SysData=>1L2C" and " - Customer Invoice.pdf"
    Then Set "SubjectName" with "Sandbox: " and "SysData=>1L2C"
    Then Verify the email attachment has "SysData=>PdfName" as an attachment with subject "SysData=>SubjectName"





