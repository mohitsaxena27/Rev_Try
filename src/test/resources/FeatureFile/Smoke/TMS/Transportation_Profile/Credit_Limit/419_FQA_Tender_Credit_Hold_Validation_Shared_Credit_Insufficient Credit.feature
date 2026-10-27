Feature: 419 - FQA LWC- Tender Credit Hold Validation Insufficient Credit

  Background: Pre- Test
    Then Set key "Chewbacca_Credit_Limit" for Object "Account" and Name "Chewbacca Credit Limit"
    Then Set key "The_Jedi_Order_Credit_Limit" for Object "Account" and Name "The Jedi Order Credit Limit"
    Then Delete All Loads associated with "Chewbacca_Credit_Limit"
    Then Delete All Loads associated with "The_Jedi_Order_Credit_Limit"

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Transportation_Profile @CreditLimit @419
  Scenario: 419 - FQA LWC- Tender Credit Hold Validation Insufficient Credit

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
    Then Search and Select "Chewbacca Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Limit Amount"
    Then Update details
      |Credit Limit Amount|
      |-100              |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds
    Then Capture the current URL for "TP_Chewbacca"

    # Step 3
    #1st Load
    Then Open "Loads" from App Launcher
#    Then Open Load Number "L-1024"
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Chewbacca Credit Limit       | Truckload | NA     | N             | N                 |

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
    Then Wait for "2" Seconds
    # Step 4
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "Customer Bill To"
    Then Update details
      |Credit Limit Source      |
      |Customer         |
    Then Click on "Save" button
    Then Scroll into Section "Customer Order Information"
    Then Wait for "2" Seconds
    Then Verify Details
      |Credit Limit Source      |
      |Customer  |
    Then Refresh current Page
    # Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then "Tender" Carrier
    #Expected a
    Then Verify Error Message displaying as "You cannot tender this load as the customer or customer quote is on credit hold."
    Then Wait for "2" Seconds

    # Step 6 & 7
    Then Execute Load "1L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
     #Step 8
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "2" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then "Assign" Carrier

    #Expected b
    Then Verify Error Message displaying as "You cannot tender this load as the customer or customer quote is on credit hold."
    Then Wait for "2" Seconds
    Then Verify Banner Details
         |Load Status|
         |Unassigned |

    #Step 9
    Then Go to "Transportation Profiles" Object
    Then Search and Select "The Jedi Order Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Limit Amount"
    Then Update details
      |Credit Limit Amount|
      |100000              |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds
    Then Refresh current Page
    Then Go to "Billing" Tab
    Then Wait for "3" Seconds
    Then Scroll into Section "Billing Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Default Customer Bill To_2 |
      |Chewbacca Credit Limit      |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds
    Then Capture the current URL for "TP_Jedi_Credit"

    # Step 10
    #2nd Load
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | The Jedi Order Credit Limit | Truckload | NA     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Grand Rapids Kayaks |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed      |12345  |NA          |NA       |NA       |

    Then Save Load With All details
    Then Wait for "2" Seconds
    # Step 11
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
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

     # Step 12
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "2" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then "Tender" Carrier
    #Expected c
    Then Verify Error Message displaying as "You cannot tender this load as the customer or customer quote is on credit hold."
    Then Wait for "2" Seconds

    # Step 13 & 14
    Then Execute Load "2L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"

     #Step 15
    Then Open Last Load from Cloned Load
    Then Wait for "1" Seconds
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
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

    #Step 16
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "2" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"

    #Ste0 17
    Then "Assign" Carrier
    #Expected d
    Then Verify Error Message displaying as "You cannot tender this load as the customer or customer quote is on credit hold."
    Then Wait for "2" Seconds
    Then Verify Banner Details
      |Load Status|
      |Unassigned |