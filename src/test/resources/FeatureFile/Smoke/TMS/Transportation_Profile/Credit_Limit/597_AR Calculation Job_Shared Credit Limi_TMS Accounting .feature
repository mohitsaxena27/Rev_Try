Feature: 597 - AR Calculation Job- Shared Credit Limit- TMS Accounting

  Background: Pre- Test
    Then Set key "Sith_Credit_Limit_Account" for Object "Account" and Name "The Sith Credit Limit"
    Then Set key "Jedi_Order_Credit_Limit_Account" for Object "Account" and Name "The Jedi Order Credit Limit"
    Then Delete All Loads associated with "Sith_Credit_Limit_Account"
    Then Delete All Loads associated with "Jedi_Order_Credit_Limit_Account"

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Transportation_Profile @CreditLimit @597
  Scenario: 597 - AR Calculation Job- Shared Credit Limit- TMS Accounting

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
         |Name_2                             |Credit Limit Amount   |
         |Test Shared Credit Limit 597       |10,000.00             |
    Then Click on "SaveEdit" button on Details Page
    Then Verify Message displaying as "Test Shared Credit Limit 597"
    Then Wait for "2" Seconds
    Then Set Key "Credit_Limit" page Record Id with "rtms__CreditLimit__c"
   # Step 3

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "The Jedi Order Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Limit"
    Then Update details
      |Credit Limit                   |
      |Test Shared Credit Limit 597   |
    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit" having value of "Test Shared Credit Limit 597"


   # Step 4 is not a mandatory step it will execute if needed

   # Step 5

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "The Sith Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Limit"
    Then Update details
      |Credit Limit                   |
      |Test Shared Credit Limit 597   |
    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit" having value of "Test Shared Credit Limit 597"

   # Step 6
      #1st Load

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | The Jedi Order Credit Limit | Truckload | Dry Van 53     | N             | N                 |

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

   # Step 7

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step (8 ,9) { Both will execute in following step }

    Then Execute Load "1L" Clone with count "2" and Customer Quote as "True" and Carrier Quote as "False"

   # Step 10

    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 11

    Then Update details
      |Billing Status|
      |Approved      |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L1CRI" page Record Id with "rtms__Load__c"
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 12

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L1C" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"

   # Step 13

    Then Update details
      |Invoice Due Date     |Invoice Status|
      |1                   |Invoiced      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Invoiced      |

    Then Wait for "1" Seconds

   # Step 14

    
    Then Open "Loads" from App Launcher
    Then Open "1L2C" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 15

    Then Update details
      |Billing Status|
      |Approved      |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "1L2CRI" page Record Id with "rtms__Load__c"
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 16

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L2C" on QuoteInvoice Tab
    Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"

   # Step 17

    Then Update details
      |Invoice Due Date     |Invoice Status|
      |-1                   |Invoiced      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Invoiced      |

    Then Wait for "1" Seconds

   # Step 18
      #2nd Load

    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | The Sith Credit Limit | Truckload | Dry Van 53     | N             | N                 |

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

   # Step 19

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"
    Then Update details
      |Status|
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step (20,21) { Both will execute in following step}

    Then Execute Load "2L" Clone with count "2" and Customer Quote as "True" and Carrier Quote as "False"

   # Step 22

    Then Open "Loads" from App Launcher
    Then Open "2L1C" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 23

    Then Update details
      |Billing Status|
      |Approved      |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "2L1CRI" page Record Id with "rtms__Load__c"
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 24

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L1C" on QuoteInvoice Tab
    Then Wait for "2" Seconds

   # Step 25

    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date    |Invoice Status|
      |1                   |Invoiced      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Invoiced      |

    Then Wait for "1" Seconds

   # Step 26

    Then Open "Loads" from App Launcher
    Then Open "2L2C" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 27

    Then Update details
      |Billing Status|
      |Approved|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Set Key "2L2CRI" page Record Id with "rtms__Load__c"
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 28

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L2C" on QuoteInvoice Tab
    Then Wait for "1" Seconds

   # Step 29

    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date     |Invoice Status|
      |-1                   |Invoiced      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Invoiced      |

    Then Wait for "2" Seconds

   # Step 30

    Then Go to "Home" Object
    Then Run "ARCalculationJob" Job
    Then Wait for "10" Seconds
    Then Refresh current Page

   # Step 31

    Then Open "TMS Admin" from App Launcher
    Then Go to "Credit Limits" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Test Shared Credit Limit 597" with Text -
    Then Switch to Parent Frame
    Then Refresh current Page
    Then Scroll into Section "General Information"
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"
    Then Verify "A/R Unbilled" having value of "USD 1,000.00"
    Then Verify "A/R Current" having value of "USD 2,000.00"
    Then Verify "A/R Past Due" having value of "USD 3,000.00"
    Then Verify "Credit Limit Available" having value of "USD 4,000.00"
    Then Set Key "Credit_Limit" page Record Id with "rtms__CreditLimit__c"
    Then Wait for "1" Seconds

   # Step 32

    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "250"
    Then "Save" Customer Quotes
    Then Wait for "1" Seconds

   # Step 33

    Then Open "Loads" from App Launcher
    Then Open "2L" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "250"
    Then "Save" Customer Quotes
    Then Wait for "1" Seconds

   # Step 34

    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L1C" on QuoteInvoice Tab
    Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Net Freight Charges"
    Then Enter Label "Net Freight Charges" Text as "3500"
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Net Freight Charges     |
      |USD 3,500.00            |

    Then Wait for "1" Seconds

   # Step 35

    Then Open "Loads" from App Launcher
    Then Open "2L1C" Created Load from List
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L1C" on QuoteInvoice Tab
    Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Net Freight Charges"
    Then Enter Label "Net Freight Charges" Text as "3500"
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Net Freight Charges     |
      |USD 3,500.00            |

   # Step 36

    Then Open "Transportation Profiles" from App Launcher
    Then Wait for "1" Seconds
    Then Search and Select "The Jedi Order Credit Limit" from List
    Then Wait for "2" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "5" Seconds

   # Step 37

    Then Open "Transportation Profiles" from App Launcher
    Then Wait for "1" Seconds
    Then Search and Select "The Sith Credit Limit" from List
    Then Wait for "2" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "4" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "5" Seconds
    Then Refresh current Page
    Then Wait for "2" Seconds
   # Step 38
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credit Limits" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Test Shared Credit Limit 597" with Text -
    Then Switch to Parent Frame
    Then Scroll into Section "General Information" -
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"
    Then Verify "A/R Unbilled" having value of "USD 500.00"
    Then Verify "A/R Current" having value of "USD 7,000.00"
    Then Verify "A/R Past Due" having value of "USD 3,000.00"
    Then Verify "Credit Limit Available" having value of "USD -500.00"
    Then Wait for "1" Seconds
