Feature:405 - TMS Admin Configuration- Calculate and Display Taxes

  @API @DeleteFile @Regression @TMS @Smoke @Admin @Mail @WEB @SingleCurrency @405
  Scenario: 405 - TMS Admin Configuration- Calculate and Display Taxes

    When Login into Salesforce

  # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Capture the current URL for "TMS_Admin"
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Calculate and Display Taxes |
      | False                       |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

  # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value          | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Vancouver Vans | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Manitoba Movers | 7             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3D   | Account_Address | Nova Scotia Shipping | 14            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12345  | NA           | NA       | NA             |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P1     | D3       | Stuff       | 23456  | NA           | NA       | NA             |
    Then Save Load With All details

  # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1200"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

  # Expected result a
    Then Verify Text not displaying as "Customer Quote Taxes"

  # Step 4
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
      | Load Status |
      | Delivered   |
    Then Refresh current Page

  # Step 5  Expected result  b
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Net Freight Charges | Transportation Total | Tax Amount | Invoice Total |
      | USD 1,200.00        | USD 1,200.00         | USD 0.00   | USD 1,200.00  |

  # Step 6  Expected result c
    Then Go to "Related" Tab
    Then Verify Text not displaying as "Customer Quote Taxes"

  # Step 7
    Then Open "TMS Admin" from App Launcher
    Then Capture the current URL for "TMS_Admin"
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Calculate and Display Taxes |
      | True                        |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

  # Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Mexico Company One | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Boston Beans | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 7             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12345  | NA           | NA       | NA             |
    Then Save Load With All details

  # Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1200"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Load_2"

  # Expected result d
    Then Wait for "6" Seconds
    Then Verify details for all Disabled or Readonly fields for "Customer Quote Taxes" grid
      | Sales Tax  | Taxable Amount | Tax Rate | Tax Amount |
      | Mexico RET | USD 1,200.00   | 4.000    | -USD 48.00 |
      | Mexico VAT | USD 1,200.00   | 16.000   | USD 192.00 |

  # Step 10  Expected result e
    Then "Send" Customer Quotes
    Then Wait for "4" Seconds
    Then To open the preview attachments -
    Then Wait for "4" Seconds
    Then Get Pdf content from "Preview Attachments" with Subject "Customer Quote Confirmation"
    Then Verify Pdf contains "Mexico RET (4.000% on 1200.00)"
    Then Verify Pdf contains "Mexico VAT (16.000% on 1200.00)"
    Then Verify Pdf contains "USD -48.00"
    Then Verify Pdf contains "USD 192.00"
    Then Delete "DownloadDirectory" after Verification

  # Step 11
    Then "Cancel" Customer Quotes

  # Step 12
    Then Navigate to stored URL for "Load_2"
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
      | Load Status |
      | Delivered   |
    Then Refresh current Page

  # Step 13 Expected result  f
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Click on button "Generate"
    Then Wait for "5" Seconds
    Then Close Modal
    Then Go to "Preview Customer Invoice" Tab
    Then Wait for "5" Seconds
    Then Set Key "GetElementID" page Record Id with "rtms__CustomerInvoice__c"
    Then Set "Document_Name" with "SysData=>2L" and " - Customer Invoice.pdf"
    Then Get Pdf content from "Document" with Subject "SysData=>Document_Name"
    Then Verify Pdf contains "Mexico RET (4.000% on 1200.00)"
    Then Verify Pdf contains "Mexico VAT (16.000% on 1200.00)"
    Then Verify Pdf contains "144.00"

  # Step 14 Expected result g
    Then Refresh current Page
    Then Navigate to stored URL for "Load_2"
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "2" Times
    Then Scroll Until Related List for "Customer Invoice Taxes"
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax  | Taxable Total | Tax Rate | Tax Amount |
      | Mexico RET | USD 1,200.00  | 4.000%   | USD -48.00 |
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax  | Taxable Total | Tax Rate | Tax Amount |
      | Mexico VAT | USD 1,200.00  | 16.000%  | USD 192.00 |

  # Step 15
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Boston Beans | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Boston Beans | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Kankakee Kayaks | 7             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12345  | NA           | NA       | NA             |
    Then Save Load With All details

  # Step 16 Expected result  h
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Verify Text not displaying as "Customer Quote Taxes"

  # Step 17
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
      | Load Status |
      | Delivered   |
    Then Refresh current Page

  # Step 18 Expected result i
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "3L" on QuoteInvoice Tab
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Net Freight Charges | Transportation Total | Tax Amount | Invoice Total |
      | USD 500.00          | USD 500.00           | NA         | USD 500.00    |

  # Step 19 Expected result j
    Then Go to "Related" Tab
    Then Verify Text not displaying as "Customer Quote Taxes"