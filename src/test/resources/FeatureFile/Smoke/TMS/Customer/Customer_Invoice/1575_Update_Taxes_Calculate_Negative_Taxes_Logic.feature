Feature: 1575 - Customer Invoice Banner LWC-Update Taxes Action w/Calculate Negative Taxes Logic

  @Regression @TMS @Smoke @WEB @SingleCurrency @Customer @Customer_Invoice @1575
  Scenario: 1575 - Customer Invoice Banner LWC-Update Taxes Action w/Calculate Negative Taxes Logic

    When Login into Salesforce

   # Step 1

    Then Open "TMS Admin" from App Launcher
    Then Go to "Sales Tax Exclusions" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Verify Text displaying as "No records to display." -
    Then Switch to Parent Frame

   # Step 2
      # load 1

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                    | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Hamilton Hockey Supplies | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Edmonton Eatery | 7             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | mixed       | 12345  | NA           | NA       | NA             |
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
      |Load Status      |
      |Delivered |
    Then Refresh current Page

 # Step 5

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Go to "Related" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "2" Times
    Then Scroll Until Related List for "Customer Invoice Taxes"
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax   | Tax Amount |
      | Alberta GST | 60.00      |

    # Step 6

    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Click on link "Customer Invoice Taxes"
    Then Wait for "2" Seconds
    Then Delete "Customer Invoice Taxes" with data "Alberta GST"
    Then Verify Message displaying as "Customer Invoice Tax was deleted."
    Then Navigate Back & Refresh

   # Step 7
   # expected results a
    Then Click on button "Update Taxes"
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax   | Tax Amount | Tax Rate |
      | Alberta GST |  60.00  | 5.000%   |

   # Step 8

    Then Open "Customer Invoices" from App Launcher
    Then Go to "New" Tab
    Then Update details
      | Invoice Number | Invoice Date | Invoice Status | Invoice Due Date | Billing Method | Load        | Invoice Total |
      | SysData=>1L&-N    | 0            | Approved       | 7                | Email          | SysData=>1L | -1200.00      |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created"
    Then Click on button "Update Taxes"
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page

    # Step 1
      # expected results b
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax   | Taxable Total | Tax Amount | Tax Rate |
      | Alberta GST | USD -1,200.00 | USD -60.00 | 5.000%   |

  # Step 2

    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Calculate Negative Taxes |
      | false                    |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

## Step 3
     # load

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                    | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Hamilton Hockey Supplies | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Edmonton Eatery | 7             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | mixed       | 12345  | NA           | NA       | NA             |
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
    Then Wait for "4" Seconds
    Then Refresh current Page

    # Step 6

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Go to "Related" Tab
    Then Scroll down with "2" Times


    # Step 7

    Then Click on button "Create Credit Memo"
    Then Wait for "5" Seconds
    Then Refresh current Page

     # Step 8

    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Click on link "Customer Invoice Taxes"
    Then Delete "Customer Invoice Taxes" with data "Alberta GST"
    Then Verify Message displaying as "was deleted."

    # Step 9
    # expected result c
    Then Navigate Back & Refresh
    Then Click on button "Update Taxes"
    Then Refresh current Page
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Scroll down with "6" Times
    Then Verify Table "Customer Invoice Taxes" row count is "0"














