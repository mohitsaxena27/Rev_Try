Feature: 2523 - EDI Outbound 214- Field Mapping: X6 Logic

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @2523
  Scenario: 2523 - EDI Outbound 214- Field Mapping: X6 Logic

    When Login into Salesforce
    #-----------------------------------------------------
     #Step 1
    Then Verify and Delete "EDIWatcherJob" from Scheduled Jobs

    #Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Revenova HQ" from List
    Then Scroll into Section "Customer Load Tracking"
    Then Click on Edit icon on Label "Location Update Send Frequency"
    Then Wait for "2" Seconds
    Then Update details
         |Location Update Send Frequency|
         |15 minutes|
    Then Click on "Save" button
    Then Verify "Location Update Send Frequency" having value of "15 minutes"
    Then Capture the current URL for "Revenova_TP"

    #Step 3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Cleo" in the "Search Credentials..." search box
    Then Select the "Cleo" record from the lookup field results
    And Update details for "Cleo" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Search text "Custom EDI" in the "Search Credentials..." search box
    Then Select the "Custom EDI" record from the lookup field results
    And Update details for "Custom EDI" service
      | Enabled |
      | False   |
    And Click on Native "Save" button


    #Step 4
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
   Then Scroll into Section "EDI Setup" -
    Then Update details -
      |Use REST API for EDI|
      |False               |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
    |EDI Enabled|Enable EDI Transaction Logging|
    |True       |True                          |
    And Update the Custom Select option "EDI Administrator" as "User User"
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    Then Update details -
    |Inbound 204|Inbound 990|Inbound 214|Inbound 210|Inbound 824|Inbound 322|Inbound 410|Outbound 990|Outbound 204|Outbound 210|Outbound 214|Outbound 404|Outbound 998|
    |True       |True       |True       |True       |True       |True       |True       |True        |True        |True        |True        |True        |True        |

    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Revenova HQ | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |

    #Step 6
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 7
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_1"

    #Step 8
    Then Go to "EDI" Tab
    Then Click on Edit icon on Label "EDI Status"
    Then Update details
      |EDI Status|EDI Provider|
      |Accept    |Kleinschmidt|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Wait for "EDI Status" Field Value Update with "Accept"
    Then Verify Details
      |EDI Status      |
      |Accept  |
    Then Refresh current Page

    #Step 9
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Arrival Date | Arrival Time| Departure Date | Departure Time |
      |0             |0900         | 0              | 1000           |
    Then Click on "1P" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "60" Seconds
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Verify Banner Details
      |Load Status|
      |In Transit |

    #Step 10
    Then Go to "Home" Object
    Then Run "EDIWatcherJob" Job
    Then Wait for "240" Seconds
    Then Get "Previous Run Time" of "EDIJob" onto "PreviousRunTime"
    Then Set "SysData=>PreviousRunTime" minus "2" hours time onto "EDIJobCompletedTime"

    #Step 11
    Then Navigate to stored URL for "Load_1"
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "EDI" Tab
    #Expected a
    Then Verify "EDI Transactions" "Transaction Type" "214" count as "3"

    #Step 12
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected b
    Then Verify "Transaction Payload" with File "Transaction_payload.txt"
      |{CurrentDate+1}|{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentTime-2}             |{CurrentDateMM/dd/yyyy}|
      |1              |SysData=>1L |0            |3              |SysData=>EDIJobCompletedTime|0                      |