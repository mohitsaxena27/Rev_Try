Feature: 1686 - Customer Quote Trigger- Credit Hold Logic

  Background: Pre- Test
    Then Set key "Millennium_Falcon_Credit_Limit" for Object "Account" and Name "Millennium Falcon Credit Limit"
    Then Delete All Loads associated with "Millennium_Falcon_Credit_Limit"

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Customer @Customer_Quotes @CreditLimit @1686
  Scenario: 1686 - Customer Quote Trigger- Credit Hold Logic

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

    #Step 2
    Then Go to "Transportation Profiles" Object
    Then Search and Select "Millennium Falcon Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Review Status"
    Then Update details
       |Credit Review Status     |
       |Credit Hold              |
    Then Click on "Save" button on Details Page
    Then Verify "Credit Review Status" having value of "Credit Hold"
    Then Capture the current URL for "TP_Millennium"

    # Step 3
    #1st Load
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Millennium Falcon Credit Limit  | LTL       | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed      |1234  |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    # Step 5
    Then Click on Customer Quote from FQA Page
    Then Wait for "1" Seconds
    #Expected Result a
    Then Verify Label Checkbox
         |Credit Hold|
         |True       |
    
    #Step 6
    Then Navigate to stored URL for "TP_Millennium"
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Review Status"
    Then Update details
      |Credit Review Status     |Credit Limit Amount|
      |Approved                 |-1000              |
    Then Click on "Save" button on Details Page
    Then Wait for "1" Seconds
    Then Verify "Credit Review Status" having value of "Approved"

    #Step 7
    Then Navigate to stored URL for "Load_1"
    Then Wait for "2" Seconds
    Then Execute Load "1L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"

     #Step 8
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
#    Then Set Key "1L1CRI" page Record Id with "rtms__Load__c"

   # Step 9
    Then Click on Customer Quote from FQA Page
    Then Wait for "1" Seconds
    #Expected Result b
    Then Verify Label Checkbox
      |Credit Hold|
      |True       |

        #Step 10
    Then Navigate to stored URL for "TP_Millennium"
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Limit Amount"
    Then Update details
      |Credit Limit Amount|
      |100000              |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

    #Step 11
    Then Navigate to stored URL for "Load_1"
    Then Wait for "2" Seconds
    Then Execute Load "2L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"

     #Step 12
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "500"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
#    Then Set Key "2L1CRI" page Record Id with "rtms__Load__c"

   # Step 13
    Then Click on Customer Quote from FQA Page
    Then Wait for "1" Seconds
    #Expected Result b
    Then Verify Label Checkbox
      |Credit Hold|
      |False       |