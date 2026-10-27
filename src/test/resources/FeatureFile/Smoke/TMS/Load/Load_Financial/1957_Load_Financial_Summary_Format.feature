Feature: 1957 - Load Financial Summary LWC- Format

  @Regression @TMS @Smoke @WEB @SingleCurrency @Load @Load_Financial @1957
  Scenario: 1957 - Load Financial Summary LWC- Format

    When Login into Salesforce
#    #Steps1
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL       | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Montreal Motors    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Port of Montreal | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Mixed     | 4000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    #Step 2
    Then Save Load With All details
#    Then Open Load Number "L-319"

    #Step 3 & 4
    Then Scroll into Section "Financial Summary"
    #Expected a
     Then Verify Text displaying as "Financial Summary"
     Then Verify Title "Display Options" Field value is set to "Carrier Only" on "rtms-loadfinancialsummary_loadfinancialsummary"
     Then Verify Title "Currency" Field value is set to "USD" on "rtms-loadfinancialsummary_loadfinancialsummary"
     Then Verify Title button "Refresh" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"
     Then Click on button with Title Text "Margin (Carrier Only)"
     Then Verify Help Text displaying as "The margin between the quotes, invoices, or payments from the customer and the carrier assigned to the load"
     Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Carrier Only | Margin (Carrier Only) |
      | Quoted    | 0.00     | 0.00         | 0.00/                |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify and get Updated On "Date=>0" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

    #Step 5
    Then Select Title "Display Options" Field value as "All Quotes" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Wait for "1" Seconds

    #Expected b
    Then Verify Text displaying as "Financial Summary"
    Then Verify Title "Display Options" Field value is set to "All Quotes" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Verify Title "Currency" Field value is set to "USD" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Verify Title button "Refresh" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Click on button with Title Text "Total Cost"
    Then Verify Help Text displaying as "The sum of all accepted carrier and vendor quotes, vendor invoices, or payments"
    Then Click on button with Title Text "Margin"
    Then Verify Help Text displaying as "The margin between the quotes, invoices, or payments from the customer and all accepted carrier or vendor quotes, vendor invoices, or vendor payments on the load"
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost   | Margin |
      | Quoted    | 0.00     | 0.00         | 0.00/                |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify and get Updated On "SysData=>UpdatedOn" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Capture the current URL for "Load_Details"
   # Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Store current Time in format of "HH:mm" on to "CurrentTime"

   #Step 7
    Then Store "1" Tax Amount on to "Quebec GST"
    Then Verify "SysData=>Quebec GST" is Greater than Zero
    Then Store "2" Tax Amount on to "Quebec QST"
    Then Verify "SysData=>Quebec QST" is Greater than Zero

    #Step 8
    #Expected Result c
    Then Scroll into Section "Financial Summary"
    Then Wait for "2" Seconds
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost | Margin  |
      | Quoted    | 1,000.00 | 0.00       | 1,000.00/100.00%  |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify and get Updated On "SysData=>UpdatedOn" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

#    Step 9
    Then Scroll Up with "15" Times
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "940"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"

    #Expected d
    Then Scroll into Section "Financial Summary"
    Then Wait for "2" Seconds
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost | Margin  |
      | Quoted    | 1,000.00 | 940.00       | 60.00/6.00%  |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify and get Updated On "SysData=>UpdatedOn" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

    #Step 10
    Then Scroll Up with "15" Times
    Then Go to "Vendor Quotes" Tab
    Then Wait for "3" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "100"
    # Step 11
    Then "Accept" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    #Expected e
    Then Scroll into Section "Financial Summary"
    Then Wait for "2" Seconds
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost | Margin  |
      | Quoted    | 1,000.00 | 1,040.00      | -40.00/-4.00%  |
      | Invoiced  | 0.00     | 0.00         | 0.00/                |
      | Paid      | 0.00     | 0.00         | 0.00/                |
    Then Verify Highlight Color of "loss" is "Red"
    Then Verify and get Updated On "SysData=>UpdatedOn" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

    #Step 12
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status |
      | Delivered   |
    Then Click on "Save" button
    Then Wait for "5" Seconds
    Then Verify details for
      | Load Status |
      | Delivered   |
    Then Wait for "5" Seconds
    #Step 13
    #Expected f
    Then Scroll into Section "Financial Summary"
    Then Wait for "2" Seconds
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost | Margin  |
      | Quoted    | 1,000.00 | 1,040.00      | -40.00/-4.00%  |
      | Invoiced  | 1,000.00 | 1,040.00      | -40.00/-4.00%  |
      | Paid      | 0.00     | 0.00         | 0.00/           |
    Then Verify Highlight Color of "loss" is "Red"
    Then Verify and get Updated On "SysData=>UpdatedOn" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

    #Step 14
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab

    #Step 15
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "1" Seconds
    Then Scroll down with "7" Times
    Then Click on link "Customer Payments"
    Then Click on button "New"
    Then Wait for "1" Seconds
    #Step 16
    Then Update details
      |Load       |Payment Amount|Payment Type  |Description|
     |SysData=>1L |1000           |Company Check |Customer Paid in Full|
    Then Wait for "2" Seconds
#    Step 17
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
  #Step 18
    Then Navigate to stored URL for "Load_Details"
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"

  #Step 19
    Then Scroll into Section "Financial Summary"
    Then Wait for "2" Seconds
    Then Select Title "Display Options" Field value as "All Quotes" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Wait for "1" Seconds
    #Expected Result g
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost | Margin  |
      | Quoted    | 1,000.00 | 1,040.00      | -40.00/-4.00%  |
      | Invoiced  | 1,000.00 | 1,040.00      | -40.00/-4.00%  |
      | Paid      | 1,000.00 | 0.00          | 1,000.00/100.00% |
    Then Verify Highlight Color of "loss" is "Red"
    Then Verify and get Updated On "SysData=>CurrentTime" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

    #Step 20
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Payments" on QuoteInvoice Tab
    Then Click on link "Vendor Payments"
    Then Click on button "New"
    Then Wait for "1" Seconds
    #Step 21
    Then Update details
      |Vendor           |Payment Amount|Description|Payment Type|
      |Email Carrier One|1000          |Vendor Paid in Full|Comdata Comchek       |
    Then Wait for "2" Seconds
    Then Update details
      |Status|
      |Issued|
    #Step 22
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Vendor Payment \"Vendor Paid in Full\" was created."
    Then Wait for "1" Seconds
    Then Click on "Vendor Paid in Full" with Text
    Then Wait for "1" Seconds
    Then Capture the current URL for "Vendor_Payments"

    #Step 23
    Then Navigate to stored URL for "Load_Details"
    Then Scroll into Section "Financial Summary"
    Then Wait for "3" Seconds
    Then Select Title "Display Options" Field value as "All Quotes" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Wait for "1" Seconds
    #Expected Result h
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost | Margin  |
      | Quoted    | 1,000.00 | 1,040.00    | -40.00/-4.00%  |
      | Invoiced  | 1,000.00 | 1,040.00     | -40.00/-4.00%  |
      | Paid      | 1,000.00 | 1,000.00     | 0.00/ |
    Then Verify Highlight Color of "loss" is "Red"

    #Step 24
    Then Click on Title button "Refresh" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"
    Then Wait for "3" Seconds
        #Expected Result i
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost | Margin  |
      | Quoted    | 1,000.00 | 1,040.00    | -40.00/-4.00%  |
      | Invoiced  | 1,000.00 | 1,040.00     | -40.00/-4.00%  |
      | Paid      | 1,000.00 | 1,000.00     | 0.00/ |
    Then Verify Highlight Color of "loss" is "Red"
    Then Verify and get Updated On "SysData=>CurrentTime" is displaying with Object "rtms-loadfinancialsummary_loadfinancialsummary"

    #Step 25
    Then Navigate to stored URL for "Vendor_Payments"
    #Step 26
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Blocked|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Blocked|

    #Step 27
    Then Navigate to stored URL for "Load_Details"
    Then Scroll into Section "Financial Summary"
    Then Wait for "4" Seconds
    #Step 28
    Then Select Title "Display Options" Field value as "All Quotes" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Wait for "1" Seconds
    #Expected Result j
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost  | Margin  |
      | Quoted    | 1,000.00 | 1,040.00    | -40.00/-4.00%  |
      | Invoiced  | 1,000.00 | 1,040.00    | -40.00/-4.00%  |
      | Paid      | 1,000.00 | 0.00        | 1,000.00/100.00% |
    Then Verify Highlight Color of "loss" is "Red"
    Then Verify Highlight Color of "profit" is "Green"
    #Step 29
    Then Navigate to stored URL for "Vendor_Payments"
    #Step 30
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Issued|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Issued|

    #Step 31
    Then Navigate to stored URL for "Load_Details"
    Then Scroll into Section "Financial Summary"
    Then Wait for "4" Seconds
    #Step 32
    Then Select Title "Display Options" Field value as "All Quotes" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Wait for "1" Seconds
    #Expected Result k
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost  | Margin  |
      | Quoted    | 1,000.00 | 1,040.00    | -40.00/-4.00%  |
      | Invoiced  | 1,000.00 | 1,040.00    | -40.00/-4.00%  |
      | Paid      | 1,000.00 | 1,000.00     | 0.00/ |
    Then Verify Highlight Color of "loss" is "Red"

    #Step 33
    Then Navigate to stored URL for "Vendor_Payments"
    #Step 34
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Cancelled|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Cancelled|

    #Step 35
    Then Navigate to stored URL for "Load_Details"
    Then Scroll into Section "Financial Summary"
    Then Wait for "4" Seconds
    #Step 36
    Then Select Title "Display Options" Field value as "All Quotes" on "rtms-loadfinancialsummary_loadfinancialsummary"
    Then Wait for "1" Seconds
    #Expected Result L
    Then Verify Table "loadFinancialSummary" With Details
      | Row       | Customer | Total Cost  | Margin  |
      | Quoted    | 1,000.00 | 1,040.00    | -40.00/-4.00%  |
      | Invoiced  | 1,000.00 | 1,040.00    | -40.00/-4.00%  |
      | Paid      | 1,000.00 | 0.00        | 1,000.00/100.00% |
    Then Verify Highlight Color of "loss" is "Red"
    Then Verify Highlight Color of "profit" is "Green"