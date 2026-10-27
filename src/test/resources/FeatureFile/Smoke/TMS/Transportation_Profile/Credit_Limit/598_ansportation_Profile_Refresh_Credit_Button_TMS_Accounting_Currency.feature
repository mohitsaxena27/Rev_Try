Feature: 598 - Transportation Profile- Refresh Credit Button- TMS Accounting- Currency

  Background: Pre- Test
    Then Set key "Death_Star_Credit_Limit_Account" for Object "Account" and Name "Death Star Credit Limit"
    Then Delete All Loads associated with "Death_Star_Credit_Limit_Account"

  @Regression @TMS @Smoke @API @WEB @MultiCurrency @Transportation_Profile @CreditLimit @598
  Scenario: 598 - Transportation Profile- Refresh Credit Button- TMS Accounting- Currency

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

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Death Star Credit Limit" from List
    Then Go to "Credit" Tab
    Then Scroll into Section "Credit Limit Information"
    Then Click on Edit icon on Label "Credit Limit Amount"
    Then Enter Label "Credit Limit Amount" Text as "10000"
    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"

   # Step 3
      #1st Load

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                       | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Death Star Credit Limit        | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |12345  |NA          |NA       |NA       |

    Then Save Load With All details

   # Step 4

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Update details
      |Status  |Currency ISO Code    |
      |Accepted|CAD - Canadian Dollar|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 5 ,6  { Step number(5 , 6) Both are executed in following two steps are written below)

    Then Execute Load "1L" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"

   # Step 7

    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "2000"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 8

    Then Update details
      |Billing Status|
      |Approved      |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L1CRI" page Record Id with "rtms__Load__c"
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 9

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L1C" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date     |
      |1                    |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Pending       |

    Then Wait for "1" Seconds

   # Step 10
      #2nd Load

    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Death Star Credit Limit     | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |12345  |NA          |NA       |NA       |

    Then Save Load With All details

   # Step 11

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "2000"
    Then Update details
      |Status|
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 12

    Then Update details
      |Billing Status|
      |Approved      |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 13

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date     |Invoice Status|
      |0                    |Approved      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Approved      |
    Then Wait for "1" Seconds


   # Step 14
       #3rd Load

    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |3L       | Death Star Credit Limit      | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |12345  |NA          |NA       |NA       |

    Then Save Load With All details

   # Step 15

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "3000"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 16

    Then Update details
      |Billing Status|
      |Approved      |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 17

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "3L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date     |Invoice Status|
      |-1                   |Approved      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Approved      |

    Then Wait for "2" Seconds

   # Step 18

    Then Go to "Home" Object
    Then Run "ARCalculationJob" Job
    Then Wait for "8" Seconds

   # Step 19

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Death Star Credit Limit" from List
    Then Refresh current Page
    Then Go to "Credit" Tab

   # Step 19
      # a) Step to verify the expected result

    Then Scroll into Section "Credit Limit Information"
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"
    Then Verify "A/R Unbilled" having value of "USD 2,238.81"
    Then Verify "A/R Current" having value of "USD 2,000.00"
    Then Verify "A/R Past Due" having value of "USD 3,000.00"
    Then Verify "Credit Limit Available" having value of "USD 2,761.19"
    Then Wait for "1" Seconds

   # Step 20

    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"
    Then "Save" Customer Quotes
    Then Wait for "1" Seconds

    # Step 21

    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L1C" on QuoteInvoice Tab
    Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Net Freight Charges"
    Then Enter Label "Net Freight Charges" Text as "3500"
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Net Freight Charges                    |
      |CAD 3,500.00 (USD 2,611.94)            |

    Then Wait for "1" Seconds

   # Step 22

    Then Go to "Transportation Profiles" Object
    Then Wait for "1" Seconds
    Then Search And Select "Death Star Credit Limit" from Search List
    Then Wait for "1" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "5" Seconds
    Then Go to "Credit" Tab

   # Step 22
      # b) Steps to verify the expected result

    Then Scroll into Section "Credit Limit Information"
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"
    Then Verify "A/R Unbilled" having value of "USD 2,985.07"
    Then Verify "A/R Current" having value of "USD 2,000.00"
    Then Verify "A/R Past Due" having value of "USD 3,000.00"
    Then Verify "Credit Limit Available" having value of "USD 2,014.93"
    Then Wait for "1" Seconds
