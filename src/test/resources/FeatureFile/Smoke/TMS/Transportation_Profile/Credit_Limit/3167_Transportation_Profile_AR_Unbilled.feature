Feature: 3167 - Transportation Profile- A/R Unbilled

  Background: Pre- Test
    Then Set key "Sith_Credit_Limit_Account" for Object "Account" and Name "The Sith Credit Limit"
    Then Delete All Loads associated with "Sith_Credit_Limit_Account"

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Transportation_Profile @CreditLimit @3167
  Scenario: 3167 - Transportation Profile- A/R Unbilled

    When Login into Salesforce
   # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      |Enforce Customer Credit Limits |
      |True                           |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 2
      #1st Load
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | The Sith Credit Limit       | Flatbed   | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | -1              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  4             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana    |15000  |NA          |NA       |NA       |

    Then Save Load With All details

   # Step 3

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 4
    Then Execute Load "1L1" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"

   # Step 5
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then Update details
      |Status  |
      |Quoted  |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

     # Step 6 & 7
    Then Execute Load "1L2" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then Update details
      |Status  |
      |Rejected  |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 8 & 9
    Then Execute Load "1L3" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then Update details
      |Status  |
      |Cancelled  |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 10 & 11
    Then Execute Load "1L4" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then Update details
      |Status  |
      |Expired  |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

       # Step 12 & 13 & 14
    Then Execute Load "1L5" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1750"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "550"
    Then Update details
      |Status  |
      |Accepted  |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   #Step 15
    Then Execute Load "1L6" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load
     # Step 16
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
     # Step 17
    Then Click on Customer Quote from FQA Page
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Click on Edit icon on Label "A/R Ignore"
    Then Update details
      |A/R Ignore         |
      |True                    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |A/R Ignore         |
      |True                |
    Then Navigate Browser Back
    # Step 18 , 19 & 20
    Then Execute Load "1L7" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load



    #Step 21
    Then Click on Edit icon with Field Name "Expected Date"
    Then Wait for "2" Seconds
    Then Update details
      |Expected Date|
      |-1           |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."


    #Step 22
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Click on Customer Quote from FQA Page
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Click on Edit icon on Label "A/R Ignore"
    Then Update details
      |A/R Ignore         |
      |False                    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |A/R Ignore         |
      |False                |

    Then Click on Edit icon with Field Name "Billing Status"
    Then Wait for "2" Seconds
    Then Update details
      |Billing Status|
      |Approved      |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
   #Step 23
    Then Go to "Related" Tab on Next to "Preview Rate Confirmation" Tab
    Then Scroll down with "10" Times
    Then Click on "Invoice Number""Sysdata=>1L71C" on "Customer Invoices"

    #Step 24
    Then Click on Edit icon with Field Name "Net Freight Charges"
    Then Wait for "2" Seconds
    Then Update details
      |Net Freight Charges|Fuel Surcharge|
      |1000               |200           |

    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify details for
      |Net Freight Charges|
      |USD 1,000.00      |
    #Step 25
    Then Open "Loads" from App Launcher
    Then Open "1L71C" Created Load from List

    # Step 26 & 27
    Then Execute Load "1L8" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load

    #Step 28
    Then Go to "Details" Tab
    Then Scroll into Section "Quote/Invoice Rollups"
    Then Click on Edit icon on Label "Customer Quote Total"
    Then Update details
      |Customer Quote Total|
      |0.00     |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Quote/Invoice Rollups"
    Then Verify Details
      |Customer Quote Total  |
      |USD 0.00          |
    Then Refresh current Page

    # Step 29
    Then Execute Load "1L9" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load

    #Step 30
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Cancelled |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Cancelled"
    Then Verify Details
      |Load Status      |
      |Cancelled  |
    Then Refresh current Page

       # Step 31
    Then Execute Load "1L10" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load

    #Step 32
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Expired  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Expired"
    Then Verify Details
      |Load Status      |
      |Expired  |
    Then Refresh current Page

       # Step 33 & 34
    Then Execute Load "1L11" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load

    #Step 35
    Then Go to "Details" Tab
    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on Label "Customer Bill To"
    Then Update details
      |Credit Limit Source      |
      |Customer Bill To         |
    Then Click on "Save" button
    Then Scroll into Section "Customer Order Information"
    Then Wait for "2" Seconds
    Then Verify Details
      |Credit Limit Source      |
      |Customer Bill To  |
    Then Refresh current Page

       # Step 36 & 37
    Then Execute Load "1L12" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load
     #Step 38
    Then Click on Edit icon with Field Name "Expected Date"
    Then Wait for "2" Seconds
    Then Update details
      |Expected Date|
      |-451           |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

   # Step 39
    Then Go to "Transportation Profiles" Object
    Then Wait for "1" Seconds
    Then Search And Select "The Sith Credit Limit" from Search List
    Then Wait for "2" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "5" Seconds
    Then Refresh current Page
    Then Go to "Credit" Tab
    Then Scroll into Section "Credit Limit Information"
    Then Verify "A/R Unbilled" having value of "USD 8,100.00"

  #Step 40
    Then Open "Loads" from App Launcher
    Then Open "1L71C" Created Load from List
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L71C" on QuoteInvoice Tab
    Then Click on Edit icon with Field Name "Invoice Status"
    Then Wait for "2" Seconds
    Then Update details
      |Invoice Status|
      |Approved      |
    Then Click on "SaveEdit" button
    Then Verify details for
      |Invoice Status|
      |Approved      |

   #Step 41 & 42
    Then Open "Loads" from App Launcher
    Then Open "1L121C" Created Load from List
    Then Click on Edit icon with Field Name "Expected Date"
    Then Wait for "2" Seconds
    Then Update details
      |Expected Date|
      |-7           |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    # Step 43
    Then Go to "Transportation Profiles" Object
    Then Wait for "1" Seconds
    Then Search And Select "The Sith Credit Limit" from Search List
    Then Wait for "2" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "5" Seconds
    Then Refresh current Page
    Then Go to "Credit" Tab
    Then Scroll into Section "Credit Limit Information"
    Then Verify "A/R Unbilled" having value of "USD 9,200.00"