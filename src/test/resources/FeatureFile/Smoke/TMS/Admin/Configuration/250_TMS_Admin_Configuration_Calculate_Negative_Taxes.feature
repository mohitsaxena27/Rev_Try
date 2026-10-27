Feature:250 - TMS Admin Configuration- Calculate Negative Taxes

  @API @DeleteFile @Regression @TMS @Smoke @Admin @Mail @WEB @SingleCurrency @250
  Scenario: 250 - TMS Admin Configuration- Calculate Negative Taxes

    When Login into Salesforce

  # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Capture the current URL for "TMS_Admin"
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Calculate Negative Taxes |
      | False                    |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

  # Step 2 & 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                    | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Hamilton Hockey Supplies | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Edmonton Eatery | 7             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12345  | NA           | NA       | NA             |
    Then Save Load With All details

  # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1200"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

  # Step 5
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

    #Step 6
    Then Open "Customer Invoices" from App Launcher
    Then Go to "New" Tab
    Then Update details
      | Invoice Number | Invoice Date | Invoice Status | Invoice Due Date | Billing Method | Load        | Invoice Total |
      | SysData=>1L&-N | 0            | Approved       | 7                | Email          | SysData=>1L | -800.00       |

    #Step 7
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created"
    Then Refresh current Page
    Then Click on button "Update Taxes"
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page

    #Expected a
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Transportation Total | Tax Amount | Invoice Total |
      | USD -800.00          |            | USD -800.00   |

  #Step 8
    Then Open "TMS Admin" from App Launcher
    Then Capture the current URL for "TMS_Admin"
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Calculate Negative Taxes |
      | True                     |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                    | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Hamilton Hockey Supplies | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Edmonton Eatery | 7             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12345  | NA           | NA       | NA             |
    Then Save Load With All details

  # Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1200"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 11
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

    # Step 12
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Wait for "3" Seconds

    #Step 13
    Then Click on button "Create Credit Memo"
    Then Wait for "3" Seconds

    #Expected b
    Then Set "Invoice_2" with "SysData=>2L" and "-M"

    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Invoice Number     | Net Freight Charges | Transportation Total | Tax Amount | Invoice Total |
      | SysData=>Invoice_2 | USD -1,200.00       | USD -1,200.00        | USD -60.00 | USD -1,260.00 |