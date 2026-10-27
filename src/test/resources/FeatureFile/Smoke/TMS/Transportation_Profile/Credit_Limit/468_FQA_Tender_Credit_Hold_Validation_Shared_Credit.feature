Feature: 468 - FQA- Tender Credit Hold Validation (Shared Credit)

  Background: Pre- Test
    Then Set key "Sith_Credit_Limit_Account" for Object "Account" and Name "The Sith Credit Limit"
    Then Set key "Death_Star_Credit_Limit_Account" for Object "Account" and Name "Death Star Credit Limit"
    Then Set key "Credit_Limit_468" for Object "rtms__CreditLimit__c" and Name "Shared Limit 468"
    Then Delete All Loads associated with "Sith_Credit_Limit_Account"
    Then Delete All Loads associated with "Death_Star_Credit_Limit_Account"
    Then Delete All Records with name "Credit_Limit_468" for "rtms__CreditLimit__c"

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Transportation_Profile @CreditLimit @468
  Scenario: 468 - FQA- Tender Credit Hold Validation (Shared Credit)

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

    Then Go to "TMS Admin" Object
    Then Go to "Credit Limits" Tab
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Credit Limit" -
    Then Switch to Parent Frame
    Then Update details -
      |Name_2                             |Credit Limit Amount   |
      |Shared Limit 468                   |10,000.00             |
    Then Click on "SaveEdit" button on Details Page
    Then Verify Message displaying as "Shared Limit 468"
    Then Wait for "2" Seconds
    Then Set Key "Credit_Limit" page Record Id with "rtms__CreditLimit__c"

    # Step 3

    Then Go to "Transportation Profiles" Object
    Then Search and Select "The Sith Credit Limit" from List
    Then Go to "Credit" Tab

    # Step 4

    Then Click on Edit icon on Label "Credit Limit"
    Then Update details
      |Credit Limit                  |Credit Review Status     |
      |Shared Limit 468              |Approved                 |

    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit" having value of "Shared Limit 468"
    # By performing all above steps again steps started from "1"
    # Step 1

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Death Star Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Limit"
    Then Update details
      |Credit Limit                    | Credit Review Status     |
      |Shared Limit 468                |  Credit Hold             |

    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit" having value of "Shared Limit 468"
    Then Verify "Credit Review Status" having value of "Credit Hold"

    # Step 2
    #1st Load
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | The Sith Credit Limit       | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed      |12345  |NA          |NA       |NA       |

    Then Save Load With All details

    # Step 3

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    # Step 4

    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Tender" Carrier
    Then Verify Text displaying as "Tender Email" -

    # Step 5

    Then Click on "Legend" Link Text "Tender" on Page -
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds
    Then Refresh current Page
    Then Verify Banner Details
    |Load Status|
    |Tendered   |

    # Step 6
    # 2nd Load
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Death Star Credit Limit     | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date  | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Grand Rapids Kayaks|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |12345  |NA          |NA       |NA       |

    Then Save Load With All details

    # Step 7

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Update details
      |Status  |
      |Accepted|

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    # Step 8

    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Tender" Carrier
    Then Verify Error Message displaying as "You cannot tender this load as the customer or customer quote is on credit hold."

    # Step 9

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Death Star Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Review Status"
    Then Update details
       |Credit Review Status            |
       |Approved                        |

    Then Click on "Save" button on Details Page
    Then Verify "Credit Review Status" having value of "Approved"

    # Step 10

    Then Open "TMS Admin" from App Launcher
    Then Go to "Credit Limits" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Link" Link Text "Shared Limit 468" on Page -
    Then Switch to Parent Frame
    Then Click on Edit icon on Label "Credit Limit Amount"
    Then Enter Label "Credit Limit Amount" Text as "-500"
    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit Amount" having value of "USD -500.00"

   # Step 11

    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Wait for "1" Seconds
    Then Execute Load "1L" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"

   # Step 12
    Then Open "Loads" from App Launcher
    Then Open "1L1C" Created Load from List

   # Step 13

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Error Message displaying as "You cannot tender this load as the customer or customer quote is on credit hold."
    Then Set Key "1L1CRI" page Record Id with "rtms__Load__c"
