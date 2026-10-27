Feature: 1969 -Load Financial Summary LWC- Currency

  Background: Pre- Test
    When Login into Salesforce
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Update details
      |Quick Find      |
      |Manage Currencies|
    Then Wait for "1" Seconds
    Then Click on "Manage Currencies" with Text
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Currency ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "Manage Dated Exchange Rates" -
    Then Switch to Parent Frame
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "Continue" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "New Exchange Rates" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Add New Exchange Rate with Start Date as "1/1/2024" and CAD as "1.55"
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "New Exchange Rates" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Add New Exchange Rate with Start Date as "1/8/2024" and CAD as "1.34"
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

  @Regression @TMS @Smoke @WEB @MultiCurrency @Load @Load_Financial @1969
  Scenario: 1969 -Load Financial Summary LWC- Currency

#    #Steps1
    Then Open "Loads" from App Launcher
#
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload  | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA                 | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Mixed     | 12345  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    #Step 2
    Then Save Load With All details
#    Then Open Load Number "L-10338"

    #Step 3
    Then Scroll into Section "Financial Summary"
    #Expected a
     Then Verify Text displaying as "Financial Summary"
     Then Verify Title "Currency" Field value is set to "USD" on "rtms-loadfinancialsummary_loadfinancialsummary"
    #Step 4
     Then Go to "Details" Tab
     Then Wait for "2" Seconds
     Then Scroll into Section "Quote/Invoice Rollups"
     Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Currency |
      | CAD - Canadian Dollar   |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Currency |
      | CAD - Canadian Dollar   |

    #Step 5
    Then Refresh current Page
    Then Scroll into Section "Financial Summary"
    Then Verify Title "Currency" Field value is set to "CAD" on "rtms-loadfinancialsummary_loadfinancialsummary"

   # Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1200"
    Then Update details
      | Status   |Currency ISO Code|
      | Accepted |USD - U.S. Dollar|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   #Step 7
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Update details
    |Currency ISO Code|
    |USD - U.S. Dollar|
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "900"
    Then Wait for "2" Seconds

    #Step 8
    Then Verify Margin Text on Customer Quote is "USD 300.00 / 25.00%"

    #Step 9
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"

    #Step 10
    Then Refresh current Page
    Then Scroll into Section "Financial Summary"
    Then Wait for "2" Seconds
    #Expected c
    Then Verify Title "Currency" Field value is set to "CAD" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Carrier Only | Margin (Carrier Only) |
      | Quoted    | 1,608.00 | 1,206.00     | 402.00/25.00%         |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify Highlight Color of "profit" is "Green"
    Then Wait for "2" Seconds
#    Step 11
    Then Select Title "Currency" Field value as "USD" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"
    Then Wait for "3" Seconds
    #Expected d
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Carrier Only | Margin (Carrier Only) |
      | Quoted    | 1,200.00 | 900.00     | 300.00/25.00%         |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify Highlight Color of "profit" is "Green"
    Then Verify Text displaying as "Exchange Rate: 0.75 USD/1 CAD"
    Then Verify and get Updated On "SysData=>CurrentTime" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

   #    Step 12
    Then Select Title "Currency" Field value as "CAD" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"
    Then Wait for "3" Seconds
    #Expected d
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Carrier Only | Margin (Carrier Only) |
      | Quoted    | 1,608.00 | 1,206.00     | 402.00/25.00%         |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify Highlight Color of "profit" is "Green"
    Then Verify Text displaying as "Exchange Rate: 1.00 CAD/1 CAD"
    Then Verify and get Updated On "SysData=>CurrentTime" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

    #Step 13
    Then Wait for "2" Seconds
    Then Click on Edit icon with Field Name "Expected Date"
    Then Update details
        |Expected Date|
        | 1/2/2024    |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "8" Seconds
    #Step 14
    Then Scroll into Section "Financial Summary"
    Then Click on Title button "Refresh" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Wait for "2" Seconds
    Then Click on Title button "Refresh" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"
    Then Wait for "3" Seconds
        #Expected f
    Then Verify Title "Currency" Field value is set to "CAD" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Carrier Only | Margin (Carrier Only) |
      | Quoted    | 1,860.00 | 1,395.00     | 465.00/25.00%         |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify Highlight Color of "profit" is "Green"
    Then Verify Text displaying as "Exchange Rate: 1.00 CAD/1 CAD"
    Then Verify and get Updated On "SysData=>CurrentTime" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

#    Step 15
    Then Scroll into Section "Financial Summary"
    Then Select Title "Currency" Field value as "USD" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"
    Then Wait for "3" Seconds
    #Expected d
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Carrier Only | Margin (Carrier Only) |
      | Quoted    | 1,200.00 | 900.00     | 300.00/25.00%         |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify Highlight Color of "profit" is "Green"
    Then Verify Text displaying as "Exchange Rate: 0.65 USD/1 CAD"
    Then Verify and get Updated On "SysData=>CurrentTime" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

   #Step 16
    Then Wait for "2" Seconds
    Then Click on Edit icon with Field Name "Expected Date"
    Then Update details
      |Expected Date|
      |NA           |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
   #Step 17
    Then Go to "Details" Tab
    Then Scroll into Section "Quote/Invoice Rollups"
    #Expected h
    Then Verify Details
      | Customer Quote Total |
      | CAD 1,860.00 (USD 1,388.06)   |