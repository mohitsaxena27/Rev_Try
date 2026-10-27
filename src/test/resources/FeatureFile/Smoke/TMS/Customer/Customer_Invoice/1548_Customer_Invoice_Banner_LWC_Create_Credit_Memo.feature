Feature: 1548 - Customer Invoice Banner LWC- Create Credit Memo

  @Regression @API @WEB @smoke @SingleCurrency @Customer @Customer_Invoice @1548
  Scenario: 1548 - Customer Invoice Banner LWC- Create Credit Memo

    When Login into Salesforce

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | N     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 1200  | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Verify details for
      | Status   |
      | Accepted |
    Then Store Customer Quote value on "Customer_Quote"

    #Step 3
    Then Go to "Summary" Tab
    Then Wait for "2" Seconds
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered        |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

    #Step 4,5
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab

    Then Click on "L-" with "Invoice Status" as "Pending"
    Then Wait for "4" Seconds
    Then Get Details
    |Master Invoice Number|
    |                     |

    #Step 6 and expected result a
    Then Click on button "Create Credit Memo"
    Then Wait for "3" Seconds
#    Then Verify Button with Title "Create Credit Memo" is disabled
    Then Verify Details
    |Invoice Number|
    |SysData=>1L-M              |
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
    |Net Freight Charges|Transportation Total|Invoice Total|Paid Amount|Balance Due|
   |USD -500.00        |USD -500.00         |USD -500.00  |           |USD -500.00|
    Then Scroll into Section "General Information"
    Then Verify Details
    |Invoice Status|
    | Pending             |
    Then Scroll into Section "Load Information"
    Then Verify Details
    |Load|Customer Quote|
    |SysData=>1L    |SysData=>Customer_Quote|

    #Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | Truckload | N     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 1200  | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Verify details for
      | Status   |
      | Accepted |
    Then Store Customer Quote value on "Customer_Quote_1"

  #Step 9
    Then Go to "Summary" Tab
    Then Wait for "2" Seconds
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered        |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

    #Step 10,11
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Click on "L-" with "Invoice Status" as "Pending"
    Then Wait for "4" Seconds
    Then Get Details
      |Master Invoice Number|
      |                     |

    #Step 12
  Then Go to "Related" Tab
    Then Scroll Until Related List for "Customer Payments"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Customer Payments" section
    Then Update details
    |Load|Payment Type|Payment Amount|Description|
    |SysData=>2L    |Other|250       |testing    |
#   Then Click on button "SaveEdit"
#    Then Click on button with Title "SaveEdit"
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds

    #Step 13 and expected result b
    Then Click on button "Create Credit Memo"
    Then Wait for "3" Seconds
#    Then Verify Button with Title "Create Credit Memo" is disabled
    Then Go to "Details" Tab
    Then Verify Details
      |Invoice Number|
      |SysData=>2L-M              |
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      |Net Freight Charges|Transportation Total|Invoice Total|Paid Amount|Balance Due|
      |USD -500.00        |USD -500.00         |USD -500.00  |           |USD -500.00|
    Then Scroll into Section "General Information"
    Then Verify Details
      |Invoice Status|
      | Pending             |
    Then Scroll into Section "Load Information"
    Then Verify Details
      |Load|Customer Quote|
      |SysData=>2L    |SysData=>Customer_Quote_1|
