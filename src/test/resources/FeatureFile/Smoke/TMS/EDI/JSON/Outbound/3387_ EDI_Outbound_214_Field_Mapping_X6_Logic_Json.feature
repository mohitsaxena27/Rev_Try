Feature: 3387 - EDI Outbound 214- Field Mapping: X6 Logic (JSON)

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @3387
  Scenario: 3387 - EDI Outbound 214- Field Mapping: X6 Logic (JSON)


    When Login into Salesforce
     #Pre-Request
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI|
      | True        |True                |
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    #-----------------------------------------------------
     #Step 1
    Then Go to Home Page
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
      |1        |P1    |D2      |Bananas     |15000 |NA          |NA       |NA       |

    #Step 4
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_1"

    #Step 6
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

    #Step 7
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Arrival Date | Arrival Time| Departure Date | Departure Time |
      |0             |0900         | 0              | 1000           |
    Then Click on "1P" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "20" Seconds

    #Step 8
    Then Go to "Home" Object
    Then Run "EDIWatcherJob" Job
    Then Get "Previous Run Time" of "EDIJob" onto "PreviousRunTime"
    Then Set "SysData=>PreviousRunTime" minus "2" hours time onto "EDIJobCompletedTime"
    Then Wait for "220" Seconds

    #Step 9
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    #Expected a
    Then Verify "EDI Transactions" "Transaction Type" "214" count as "3"

    #Step 10
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected b
    Then Verify Json "Transaction Payload" with File "Transaction_payload.json"
      |{CurrentDate+1}|{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentTime-2}             |{CurrentDateMM/dd/yyyy}|
      |1              |SysData=>1L |0            |3              |SysData=>EDIJobCompletedTime|0                      |