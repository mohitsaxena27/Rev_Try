Feature: 1715 - AR Calculation Job- Shared Credit Limit-TMS Accounting- Currency

  Background: Pre- Test
    Then Set key "Millennium_Falcon_Credit_Limit_Account" for Object "Account" and Name "Millennium Falcon Credit Limit"
    Then Set key "Chewbacca_Credit_Limit_Account" for Object "Account" and Name "Chewbacca Credit Limit"
    Then Delete All Loads associated with "Millennium_Falcon_Credit_Limit_Account"
    Then Delete All Loads associated with "Chewbacca_Credit_Limit_Account"

  @Regression @TMS @Smoke @API @WEB @MultiCurrency @Transportation_Profile @CreditLimit @1715
  Scenario: 1715 - AR Calculation Job- Shared Credit Limit-TMS Accounting- Currency

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

    Then Go to "TMS Admin" Object
    Then Go to "Credit Limits" Tab
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Credit Limit" -
    Then Switch to Parent Frame
    Then Update details -
      |Name_2                              |Credit Limit Amount   |
      |Test Shared Credit Limit 1715       |10,000.00             |
    Then Click on "SaveEdit" button on Details Page
    Then Verify Message displaying as "Test Shared Credit Limit 1715"
    Then Wait for "2" Seconds
    Then Set Key "Credit_Limit" page Record Id with "rtms__CreditLimit__c"

   # Step 3

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Millennium Falcon Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Limit"
    Then Update details
      |Credit Limit                  |
      |Test Shared Credit Limit 1715   |
    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit" having value of "Test Shared Credit Limit 1715"

   #{ By performing above three steps again starts from Step 1}
   # Step 1

    Then Go to "Transportation Profiles" Object
    Then Search and Select "Chewbacca Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Limit"
    Then Update details
      |Credit Limit                  |
      |Test Shared Credit Limit 1715   |
    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit" having value of "Test Shared Credit Limit 1715"

   # Step 2
      #1st Load
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                       | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Millennium Falcon Credit Limit | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts|  1             | NA                      | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count |Handling_Units|
      |1        |P1    |D2      |Mixed      |12345  |NA          |NA       |NA            |

    Then Save Load With All details

   # Step 3

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Update details
      |Status  |Currency ISO Code    |
      |Accepted|CAD - Canadian Dollar|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 4,5 { Step number(3 , 4) Both are executed in following two steps are written below)

    Then Execute Load "1L" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"

   # Step 6

    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "2000"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 7

    Then Update details
      |Billing Status|
      |Approved      |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L1CRI" page Record Id with "rtms__Load__c"
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Steps 8

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

   # Step 9
      #2nd Load

    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Chewbacca Credit Limit | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Grand Rapids Kayaks|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |12345  |NA          |NA       |NA       |

    Then Save Load With All details

   # Step 10

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "2000"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 11

    Then Update details
      |Billing Status|
      |Approved      |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 12

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


   # Step 13
       #3rd Load

    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |3L       | Chewbacca Credit Limit      | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Grand Rapids Kayaks|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |12345  |NA          |NA       |NA       |

    Then Save Load With All details

   # Step 14

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "3000"
    Then Update details
      |Status|
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 15

    Then Update details
      |Billing Status|
      |Approved|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 16

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "3L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date     |Invoice Status|
      |-1                    |Approved      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Approved      |

    Then Wait for "2" Seconds

   # Step 17

    Then Go to "Home" Object
    Then Run "ARCalculationJob" Job
    Then Wait for "8" Seconds

   # Step 18

    Then Open "TMS Admin" from App Launcher
    Then Go to "Credit Limits" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Test Shared Credit Limit 1715" with Text -
    Then Switch to Parent Frame
   # Step 18
      # a) Steps to verify the expected results
    Then Refresh current Page
    Then Scroll into Section "General Information"
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"
    Then Verify "A/R Unbilled" having value of "USD 2,238.81"
    Then Verify "A/R Current" having value of "USD 2,000.00"
    Then Verify "A/R Past Due" having value of "USD 3,000.00"
    Then Verify "Credit Limit Available" having value of "USD 2,761.19"
    Then Verify "Credit Limit Utilized" having value of "72.39%"
    Then Set Key "Credit_Limit" page Record Id with "rtms__CreditLimit__c"
    Then Wait for "1" Seconds

   # Step 19

    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"
    Then "Save" Customer Quotes
    Then Wait for "1" Seconds

   # Step 20

    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L1C" on QuoteInvoice Tab
    Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Net Freight Charges"
    Then Enter Label "Net Freight Charges" Text as "3500"
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Net Freight Charges            |
      |CAD 3,500.00 (USD 2,611.94)    |
    Then Wait for "1" Seconds

   # Step 21

    Then Go to "Transportation Profiles" Object
    Then Wait for "1" Seconds
    Then Search And Select "Millennium Falcon Credit Limit" from Search List
    Then Wait for "1" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "3" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "3" Seconds
   # Step 22

    Then Go to "Transportation Profiles" Object
    Then Wait for "1" Seconds
    Then Search And Select "Chewbacca Credit Limit" from Search List
    Then Wait for "1" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "3" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 23
    Then Wait for "3" Seconds
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credit Limits" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Test Shared Credit Limit 1715" with Text -
    Then Switch to Parent Frame

   # Step 23
      # b)  Steps to verify the expected result
    Then Refresh current Page
    Then Scroll into Section "General Information" -
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"
    Then Verify "A/R Unbilled" having value of "USD 2,985.07"
    Then Verify "A/R Current" having value of "USD 2,000.00"
    Then Verify "A/R Past Due" having value of "USD 3,000.00"
    Then Verify "Credit Limit Available" having value of "USD 2,014.93"
    Then Verify "Credit Limit Utilized" having value of "79.85%"
    Then Wait for "1" Seconds
