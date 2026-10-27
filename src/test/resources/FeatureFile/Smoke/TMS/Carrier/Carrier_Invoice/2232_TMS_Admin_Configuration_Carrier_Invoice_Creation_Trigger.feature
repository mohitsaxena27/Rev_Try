Feature: 2232 - TMS Admin Configuration - Carrier Invoice Creation Trigger

  @Regression @TMS @Smoke @API @WEB @Carrier @SingleCurrency @Carrier_Invoice @2232
  Scenario: 2232 - TMS Admin Configuration - Carrier Invoice Creation Trigger

    When Login into Salesforce
   # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Carrier Invoice Creation Trigger" as "Tendered"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
   # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 1234   | NA           | NA       | NA             |
    Then Save Load With All details
     #Clone load number for use in steps 11+22+32+42+52+62
    Then Execute Load "1L" Clone with count "6" and Customer Quote as "False" and Carrier Quote as "False"
    Then Navigate Browser Back

   # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "100"
    Then "Save" Carrier

    # Step 4
    Then Go to "Vendor Quotes" Tab
    Then Wait for "3" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "125"

    # Step 5
    Then "Save" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 6
    Then "New" Vendor Quotes
    Then Enter Vendor Service as "Email Carrier Two - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier Two |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "150"

   # Step 7
    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "1" Seconds
    Then Set Vendor Quote value on to "Vendor_Quote_1L"

    # Step 8
    Then Go to "Carrier Quotes" Tab
    Then Wait for "3" Seconds
    Then "Tender" Carrier
    Then Verify Text displaying as "Tender Email" -
    Then Click on "Legend" Link Text "Tender" on Page -
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | Tendered    |
    Then Refresh current Page

   # Step 9
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_1L" on "Vendor_Invoice_1L"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
      # expected  results a
    Then Verify "Vendor Invoices" Table details with following Details
     |Invoice Number | Vendor            | Invoice Status | Invoice Total | Balance Due |
     |SysData=>1L    | Email Carrier One | Pending        | 100.00        | 100.00      |
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number                | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>Vendor_Invoice_1L    | Email Carrier Two | Pending        | 150.00        | 150.00      |


    # Step 10
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Carrier Invoice Creation Trigger" as "Assigned"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

     # Step 11 & 12
    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List

    # Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "200"
    # Step 14
    Then "Tender" Carrier
    Then Verify Text displaying as "Tender Email" -
    Then Click on "Legend" Link Text "Tender" on Page -
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds
    Then Set Key "1L1CRI" page Record Id with "rtms__Load__c"

    #Step 15
    Then Go to "Vendor Quotes" Tab
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "225"

     # Step 16
    Then "Save" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    # Step 17
    Then "New" Vendor Quotes
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier Two - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier Two |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "250"

    # Step 18

    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Set Vendor Quote value on to "Vendor_Quote_1L1C"

    # Step 19
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Assigned         |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Assigned"
    Then Verify Details
      |Load Status      |
      |Assigned         |
    Then Refresh current Page

    # Step 20
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_1L1C" on "Vendor_Invoice_1L1C"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    # expected  results b
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>1L1C| Email Carrier One | Pending        | 200.00        | 200.00      |
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>Vendor_Invoice_1L1C| Email Carrier Two | Pending        | 250.00        | 250.00      |

     # Step 21
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
#    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Carrier Invoice Creation Trigger" as "Dispatched"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 22 & 23
    Then Open "Loads" from App Launcher
    Then Open "1L2C" Created Load from List

    # Step 24
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "300"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Key "1L2CRI" page Record Id with "rtms__Load__c"

    # Step 25
    Then Go to "Vendor Quotes" Tab
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "325"

     # Step 26
    Then "Save" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 27
    Then "New" Vendor Quotes
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier Two - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier Two |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "350"

    # Step 28
    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "1" Seconds
    Then Set Vendor Quote value on to "Vendor_Quote_1L2C"

    # Step 29
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Dispatched       |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Dispatched"
    Then Verify Details
      |Load Status      |
      |Dispatched       |
    Then Refresh current Page

    # Step 30
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_1L2C" on "Vendor_Invoice_1L2C"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
      # expected  results c
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number  | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>1L2C| Email Carrier One | Pending        | 300.00        | 300.00      |
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number  | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>Vendor_Invoice_1L2C| Email Carrier Two | Pending        | 350.00        | 350.00      |

   # Step 31
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Carrier Invoice Creation Trigger" as "In Transit"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 32 & 33
    Then Open "Loads" from App Launcher
    Then Open "1L3C" Created Load from List

      # Step 34
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Key "1L3CRI" page Record Id with "rtms__Load__c"

      # Step 35
    Then Go to "Vendor Quotes" Tab
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "425"

     # Step 36
    Then "Save" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 37
    Then "New" Vendor Quotes
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier Two - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier Two |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "450"

    # Step 38
    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "3" Seconds
    Then Set Vendor Quote value on to "Vendor_Quote_1L3C"

    # Step 39
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |In Transit       |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "In Transit"
    Then Verify Details
      |Load Status      |
      |In Transit       |
    Then Refresh current Page

    #Step 40
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_1L3C" on "Vendor_Invoice_1L3C"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
        # expected  results d
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number  | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>1L3C| Email Carrier One | Pending        | 400.00        | 400.00      |
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number  | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>Vendor_Invoice_1L3C| Email Carrier Two | Pending        | 450.00        | 450.00      |

     # Step 41
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
#    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Carrier Invoice Creation Trigger" as "Delivered"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 42 & 43
    Then Open "Loads" from App Launcher
    Then Open "1L4C" Created Load from List

    # Step 44
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "500"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Key "1L4CRI" page Record Id with "rtms__Load__c"

    # Step 45
    Then Go to "Vendor Quotes" Tab
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "525"

     # Step 46
    Then "Save" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 47
    Then "New" Vendor Quotes
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier Two - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier Two |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "550"

    # Step 48
    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "1" Seconds
    Then Set Vendor Quote value on to "Vendor_Quote_1L4C"

    # Step 49
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered       |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      |Load Status      |
      |Delivered       |
    Then Refresh current Page

    # Step 50
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_1L4C" on "Vendor_Invoice_1L4C"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
        # expected  results e
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number  | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>1L4C| Email Carrier One | Pending        | 500.00        | 500.00      |
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number| Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>Vendor_Invoice_1L4C| Email Carrier Two | Pending        | 550.00        | 550.00      |

    # Step 51
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
#    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Carrier Invoice Creation Trigger" as "Completed"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 52 & 53
    Then Open "Loads" from App Launcher
    Then Open "1L5C" Created Load from List

    # Step 54
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "600"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Key "1L5CRI" page Record Id with "rtms__Load__c"

    # Step 55
    Then Go to "Vendor Quotes" Tab
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "625"

     # Step 56
    Then "Save" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 57
    Then "New" Vendor Quotes
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier Two - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier Two |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "650"

    # Step 58
    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "3" Seconds
    Then Set Vendor Quote value on to "Vendor_Quote_1L5C"

    # Step 59
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Completed       |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Completed"
    Then Verify Details
      |Load Status      |
      |Completed       |
    Then Refresh current Page

    # Step 60
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_1L5C" on "Vendor_Invoice_1L5C"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
        # expected  results f
    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number  | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>1L5C| Email Carrier One | Pending        | 600.00        | 600.00      |

    Then Verify "Vendor Invoices" Table details with following Details
      |Invoice Number   | Vendor            | Invoice Status | Invoice Total | Balance Due |
      |SysData=>Vendor_Invoice_1L5C| Email Carrier Two | Pending        | 650.00        | 650.00      |

      # Step 61
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Carrier Invoice Creation Trigger" as "Delivered"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 62 & 63
    Then Open "Loads" from App Launcher
    Then Open "1L6C" Created Load from List

    # Step 64
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "700"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Key "1L6CRI" page Record Id with "rtms__Load__c"

    # Step 65
    Then Go to "Vendor Quotes" Tab
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "725"

     # Step 66
    Then "Save" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 67
    Then "New" Vendor Quotes
    Then Wait for "1" Seconds
    Then Enter Vendor Service as "Email Carrier Two - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier Two |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "750"

    # Step 68
    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "1" Seconds

    # Step 69
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |In Transit       |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "In Transit"
    Then Verify Details
      |Load Status      |
      |In Transit       |
    Then Refresh current Page

    # Step 70
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
        # expected  results g
    Then Verify "Vendor Invoices" count displaying as "0"


































