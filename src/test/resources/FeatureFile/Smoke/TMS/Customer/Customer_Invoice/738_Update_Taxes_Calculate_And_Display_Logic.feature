Feature: 738 - Customer Invoice Banner LWC-Update Taxes Action w/Calculate+Display Taxes Logic

  @Regression @TMS @Smoke @WEB @SingleCurrency @Customer @Customer_Invoice @738
  Scenario: 738 - Customer Invoice Banner LWC-Update Taxes Action w/Calculate+Display Taxes Logic

    When Login into Salesforce

  # Step 1

    Then Open "TMS Admin" from App Launcher
    Then Go to "Sales Tax Exclusions" Tab
    Then Wait for "3" Seconds
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

 # Step 4

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

 # Step 5
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      |Load Status      |
      |Delivered |
    Then Refresh current Page
 # Step 6

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Go to "Related" Tab
    Then Wait for "1" Seconds
 # Step 7

    Then Scroll down with "2" Times
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax   | Tax Rate |
      | Alberta GST | 5.000%   |

 # Step 8

    Then Click on button "Update Taxes"

 # Steps to verify expected result

    Then Verify Message displaying as "Save was successful."

 # a) steps to verify expected result

    Then Verify Table "Customer Invoice Taxes" row count is "1"

    # i)
    Then Wait for "2" Seconds
    Then Verify "Customer Invoice Taxes" Table details with following Details
      | Sales Tax   | Tax Rate | Tax Amount |
      | Alberta GST | 5.000%   | USD 60.00  |

 # Step 9

    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Calculate and Display Taxes |
      | False                       |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Refresh current Page

 # Step 10
    # load 2

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

 # Step 11
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1200"
    Then Update details
      | Status   |
      | Accepted |

 # Step 12
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

 # Step 13
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      |Load Status|
      |Delivered |
    Then Refresh current Page
 # Step 14
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Go to "Related" Tab

 # Step 15
     # Steps to verify expected result
    Then Verify "Update Taxes" in not displaying on Page














