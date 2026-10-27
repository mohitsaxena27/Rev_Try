Feature: 1385 - TMS Admin configuration-Customer Invoice Creation Trigger

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Customer @Customer_Invoice @1385
  Scenario: 1385 - TMS Admin configuration-Customer Invoice Creation Trigger

    When Login into Salesforce
   # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "Quotes Requested"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
   # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans  |Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                      | NA                | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  3            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000  |NA          |NA      |NA            |
    Then Save Load With All details
    #Clone Load to use in step 6+11+16+21+26+31+36+53
    Then Execute Load "1L" Clone with count "8" and Customer Quote as "False" and Carrier Quote as "False"
    Then Navigate Browser Back
   # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "600"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
   # Step 4
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Quotes Requested |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Quotes Requested"
    Then Verify Details
      |Load Status      |
      |Quotes Requested |
    Then Refresh current Page
   # a) Steps to verify Expected result
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Verify details for
      |Invoice Total|
      | USD 600.00  |
    Then Scroll into Section "Invoice Summary"
    Then Verify details for
      | Invoice Total|
      | USD 600.00   |
   # Step 5
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "Quotes Received"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
   # Step 6 &7
    # Load
    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List

   # Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "200"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L1CRI" page Record Id with "rtms__Load__c"

   # Step 9
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Quotes Received  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Quotes Received"
    Then Verify Details
      |Load Status      |
      |Quotes Received |
    Then Refresh current Page
   # b) Steps to verify Expected result
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L1C" on QuoteInvoice Tab
    Then Verify details for
      |Invoice Total|
      | USD 200.00  |
    Then Scroll into Section "Invoice Summary"
    Then Verify details for
      | Invoice Total|
      | USD 200.00   |
   # Step 10
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "Tendered"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 11 & 12
    Then Open "Loads" from App Launcher
    Then Open "1L2C" Created Load from List

   # Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "250"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L2CRI" page Record Id with "rtms__Load__c"

   # Step 14

    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status|
      |Tendered   |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Tendered"
    Then Verify Details
      |Load Status      |
      |Tendered |
    Then Refresh current Page
   # c) Steps to verify Expected result
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L2C" on QuoteInvoice Tab
    Then Verify details for
      |Invoice Total|
      | USD 250.00  |
    Then Scroll into Section "Invoice Summary"
    Then Verify details for
      | Invoice Total|
      | USD 250.00   |

   # Step 15
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "Assigned"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 16 & 17
    Then Open "Loads" from App Launcher
    Then Open "1L3C" Created Load from List

   # Step 18
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "100"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L3CRI" page Record Id with "rtms__Load__c"

   # Step 19
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status|
      |Assigned   |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Assigned"
    Then Verify Details
      |Load Status      |
      |Assigned |
    Then Refresh current Page

   # d) Steps to verify Expected result
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L3C" on QuoteInvoice Tab
    Then Verify details for
      |Invoice Total|
      | USD 100.00  |
    Then Scroll into Section "Invoice Summary"
    Then Verify details for
      | Invoice Total|
      | USD 100.00   |

   # Step 20
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "Dispatched"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 21 & 22
    Then Open "Loads" from App Launcher
    Then Open "1L4C" Created Load from List

   # Step 23
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "860"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L4CRI" page Record Id with "rtms__Load__c"

   # Step 24
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status|
      |Dispatched |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Dispatched"
    Then Verify Details
      |Load Status      |
      |Dispatched |
    Then Refresh current Page
   # e) Steps to verify Expected result
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L4C" on QuoteInvoice Tab
    Then Verify details for
      |Invoice Total|
      | USD 860.00  |
    Then Scroll into Section "Invoice Summary"
    Then Verify details for
      | Invoice Total|
      | USD 860.00   |

 # Step 25
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "In Transit"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

 # Step 26 &27
    Then Open "Loads" from App Launcher
    Then Open "1L5C" Created Load from List

 # Step 28
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "450"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L5CRI" page Record Id with "rtms__Load__c"

 # Step 29
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status|
      |In Transit |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "In Transit"
    Then Verify Details
      |Load Status      |
      |In Transit       |
    Then Refresh current Page

 # f) Steps to verify Expected result
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L5C" on QuoteInvoice Tab
    Then Verify details for
      |Invoice Total|
      | USD 450.00  |
    Then Scroll into Section "Invoice Summary"
    Then Verify details for
      | Invoice Total|
      | USD 450.00   |

 # Step 30
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "Delivered"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

 # Step 31 &32
    Then Open "Loads" from App Launcher
    Then Open "1L6C" Created Load from List

 # Step 33
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "125"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L6CRI" page Record Id with "rtms__Load__c"

 # Step 34
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status|
      |Delivered  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      |Load Status      |
      |Delivered       |
    Then Refresh current Page
 # g) Steps to verify Expected result
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L6C" on QuoteInvoice Tab
    Then Verify details for
      |Invoice Total|
      | USD 125.00  |
    Then Scroll into Section "Invoice Summary"
    Then Verify details for
      | Invoice Total|
      | USD 125.00   |

 # Step 35
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "Completed"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

 # Step 36 & 37
    Then Open "Loads" from App Launcher
    Then Open "1L7C" Created Load from List

 # Step 38
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "325"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L7CRI" page Record Id with "rtms__Load__c"

 # Step 39
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status|
      |Completed  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Completed"

    Then Verify Details
      |Load Status      |
      |Completed       |
    Then Refresh current Page
 # h) Steps to verify Expected result
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L7C" on QuoteInvoice Tab
    Then Verify details for
      |Invoice Total|
      | USD 325.00  |
    Then Scroll into Section "Invoice Summary"
    Then Verify details for
      | Invoice Total|
      | USD 325.00   |

 # Step 40
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Invoice Processing" -
    And Update the Custom Select option "Customer Invoice Creation Trigger" as "- None -"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

 # Step 41 & 42
    Then Open "Loads" from App Launcher
    Then Open "1L8C" Created Load from List

  # Step 43
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "100"
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L8CRI" page Record Id with "rtms__Load__c"

 # Step 44
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status|
      | Delivered |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      |Load Status      |
      |Delivered       |
    Then Refresh current Page

 # Verify
    Then Go to "Quotes/Invoices" Tab
    Then Scroll down with "5" Times
    Then Verify "Customer Invoices" count displaying as "0"













