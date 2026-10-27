Feature: 1702 - FQA- Tender Credit Hold Validation (Non-Shared Credit)

  Background: Pre- Test
    Then Set key "Sith_Credit_Limit_Account" for Object "Account" and Name "The Sith Credit Limit"
    Then Delete All Loads associated with "Sith_Credit_Limit_Account"

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Transportation_Profile @CreditLimit @1702
  Scenario: 1702 - FQA- Tender Credit Hold Validation (Non-Shared Credit)

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
    Then Search and Select "The Sith Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Review Status"
    Then Update details
      |Credit Review Status            |
      |Credit Hold                     |
    Then Click on "Save" button on Details Page
    Then Verify "Credit Review Status" having value of "Credit Hold"

   # Step 3
      #1st Load

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                       | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | The Sith Credit Limit          | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date  | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date  | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count |Handling_Units|
      |1        |P1    |D2      |Mixed      |12345  |NA          |NA       |NA            |

    Then Save Load With All details

   # Step 4

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    # Step 5

    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Tender" Carrier
    Then Verify Error Message displaying as "You cannot tender this load as the customer or customer quote is on credit hold."

   # Step 6

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "The Sith Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Review Status"
    Then Update details
       | Credit Limit Amount| Credit Review Status    |
       |-500                | Approved                |
    Then Click on "Save" button on Details Page
    Then Verify "Credit Review Status" having value of "Approved"

    # Step 7

    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Wait for "1" Seconds

    # Step 8

    Then Execute Load "1L" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"

    # Step 9

    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then "Assign" Carrier
    Then Verify Error Message displaying as "You cannot tender this load as the customer or customer quote is on credit hold."
    Then Set Key "1L1CRI" page Record Id with "rtms__Load__c"
