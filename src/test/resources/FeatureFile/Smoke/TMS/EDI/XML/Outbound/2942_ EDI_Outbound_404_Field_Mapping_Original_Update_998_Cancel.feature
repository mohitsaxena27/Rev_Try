Feature: 2942 - EDI Outbound 404- Field Mapping (Original+Update+998 Cancel)

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @2942
  Scenario: 2942 - EDI Outbound 404- Field Mapping (Original+Update+998 Cancel)

    When Login into Salesforce
    #-----------------------------------------------------
        #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | Use REST API for EDI |
      | False                |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | EDI Enabled | Enable EDI Transaction Logging |
      | True        | True                           |
    And Update the Custom Select option "EDI Administrator" as "User User"
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    Then Update details -
      | Inbound 204 | Inbound 990 | Inbound 214 | Inbound 210 | Inbound 824 | Inbound 322 | Inbound 410 | Outbound 990 | Outbound 204 | Outbound 210 | Outbound 214 | Outbound 404 | Outbound 998 |
      | True        | True        | True        | True        | True        | True        | True        | True         | True         | True         | True         | True         | True         |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
       #Setting SCAC as EDC1
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "Rail EDI Carrier One" from Search List
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Click on Edit icon on "SCAC"
    Then Enter Label "SCAC" Text as "EDC1"
    Then Click on "Save" button
    Then Verify "SCAC" having value of "EDC1"

    #Step 2
    Then Search and Select "rtms__CarrierService__c" "Rail EDI Carrier One - Intermodal" from the Global search
    Then Capture the current URL for "Carrier_Service"
    Then Scroll into Section "Carrier Booking Contact (Default)"
    Then Click on Edit icon on Label "EDI Provider"
    Then Update details
      | EDI Provider |
      | Kleinschmidt |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "EDI Provider" having value of "Kleinschmidt"

    #Step 3
    Then Search and Select "rtms__CarrierService__c" "Rail EDI Carrier Two - Intermodal" from the Global search
    Then Capture the current URL for "Carrier_Service"
    Then Scroll into Section "Carrier Booking Contact (Default)"
    Then Click on Edit icon on Label "EDI Provider"
    Then Update details
      | EDI Provider |
      | Kleinschmidt |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "EDI Provider" having value of "Kleinschmidt"

#    #Step4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode       | Equipment_Type          | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | Intermodal | Container 40' High Cube | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Port of Long Beach | 0             | NA                       | 0400             | True                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Port of Savannah | 5             | 1200-1830                | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 14000  | NA           | 8        | Pallets        | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details


    #Step 5
    Then Click on button with Title "Add Freight Plan"
    Then Wait for "5" Seconds
    #Step 6
    Then Freight Plan - Click on Template Panel
    Then Wait for "2" Seconds
    Then Click on button with Title "Add"
    Then Enter value "Illinois Terminal" with Input having "placeholder" as "Search Locations"
    Then Select Search Result "Illinois Terminal - Markham, IL"
    Then Wait for "2" Seconds
    Then Click on button with Title "Add"
    Then Enter value "Georgia Terminal" with Input having "placeholder" as "Search Locations" for "2" Stop
    Then Select Search Result "Georgia Terminal - Ellenwood, GA"
    Then Wait for "2" Seconds
    Then Click on Title button "Refresh" is displaying with Object "rtms-freightplantemplate_freightplantemplate"
    Then Wait for "2" Seconds
    Then Click on button with Title "Hide Filter/Template Panel"
    #Step 7
    Then Freight Plan - Click on Checkbox with Location "Port of Long Beach - Long Beach"
    Then Freight Plan - Click on Dropdown with Location "Markham, IL"
    Then Click on "New Load" with Text
    Then Update details
      | Mode       | Equipment Type |
      | Intermodal | Container 45'  |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"

    #Step 8
    Then Freight Plan - Click on Checkbox with Location "Markham, IL"
    Then Freight Plan - Click on Dropdown with Location "Ellenwood, GA"
    Then Click on "New Load" with Text
    Then Update details
      | Mode       | Equipment Type |
      | Intermodal | Container 45'  |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Freight Plan - Verify and get the "2" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_2"

     #Step 9
    Then Freight Plan - Click on Checkbox with Location "Ellenwood, GA"
    Then Freight Plan - Click on Dropdown with Location "Port of Savannah - Garden City, GA"
    Then Click on "New Load" with Text
    Then Update details
      | Equipment Type |
      | Container 45'  |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Freight Plan - Verify and get the "3" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_3"

    #Step 10
    Then Freight Plan - Select the "1" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "2" Seconds
    Then Capture the current URL for "Load_1"

    #Step 11
    Then Get "Distance (Miles)" from "rtms-loadbanner_loadbanner"

    #Step 12
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Wait for "1" Seconds
    Then Update details
      | Expected Date |
      | 2             |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Verify details for
      | Expected Date |
      | 2             |
    Then Collapse "Details" for "2" Load

    #Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then Enter Label "Carrier Quote Reference" Text as "29422492"
    And Wait for "1" Seconds
    Then Add "Load" "Carrier Quote Items" "Net Freight Charges" with Unit as "Per Mile" Qty as "1850.12" and Price "1.25" with all details
    Then Add "Load" "Carrier Quote Items" "Fuel Surcharge" with Unit as "Fixed Cost" Qty as "1" and Price "200" with all details
    Then Add "Stop 1" "Carrier Quote Items" "Carrier Terminal Drop Off" Accessorial with Unit as "Fixed Cost" Qty as "50" and Price "2"

#    Step 14
    Then Click on Native "Tender" icon
    Then Store current Time plus "2" hrs in format of "HH:mm" on to "CurrentTime"
    Then Wait for "2" Seconds
    Then Verify Success Message displaying as "Load tendered successfully."

     #Step15
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "404" and "Direction" as "Outbound"

    #Step 16 Expected Result a
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 404              | Original | Outbound  |            |
    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    Then Set key "RevenovaHQ_AccountID" for Object "Account" and Name "Revenova HQ"
    Then Set key "Port_of_Long_Beach_AccountID" for Object "Account" and Name "Port of Long Beach"
    Then Set key "IllinoisTerminal_AccountID" for Object "Account" and Name "Illinois Terminal"
    Then Verify "Transaction Payload" with File "Transaction_payload.txt"
      | ShipmentId                 | {CurrentDateYYYY-MM-DD} | {CurrentDateYYYY-MM-DD+2} | {CurrentDateYYYY-MM-DD+5} | {ScratchOrgEmail} | DistanceInMiles           | RevenovaHQAccountID           | PortOfLongBeachAccountID              | IllinoisTerminal_AccountIDAccountID | RespondTime          |
      | SysData=>FP_Carrier_Load_1 | 0                       | 2                         | 5                         | Company_Email     | SysData=>Distance (Miles) | SysData=>RevenovaHQ_AccountID | SysData=>Port_of_Long_Beach_AccountID | SysData=>IllinoisTerminal_AccountID | SysData=>CurrentTime |

     #Step 17
    Then Close Current Tab
    Then Switch to Parent Window
    Then Wait for "2" Seconds

      #Step 18
    Then Freight Plan - Select the "2" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "2" Seconds
    Then Capture the current URL for "Load_2"

    #Step 19
    Then Wait for "1" Seconds
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Wait for "1" Seconds
#    Then Click on Edit icon with Field Name "1P" "Expected Date"
    Then Update details
      | Expected Date | Appointment Required | Appointment Time |
      | 2             | True                 | 1800-1830        |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Collapse "Details" for "1" Load
    Then Wait for "1" Seconds

    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Wait for "1" Seconds
#    Then Click on Edit icon with Field Name "2D" "Expected Date"
    Then Update details
      | Expected Date |
      | 3             |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Collapse "Details" for "2" Load

    #Step 20
    Then Go to "Details" Tab
    Then Scroll into Section "Import/Export Information"
    Then Click on Edit icon on Label "Customs Broker"
    Then Wait for "2" Seconds
    Then Update details
      | Customs Broker       |
      | Customs Broker Three |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Verify Details
      | Customs Broker       |
      | Customs Broker Three |

    #Step 21
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier Two - Intermodal"
    Then "Accept" Carrier
    Then Verify Message displaying as "Carrier Quote accepted."
    
    #Step 22
    Then Navigate to stored URL for "Load_1"

    #Step 23
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then "Tender" Carrier
    Then Store current Time plus "2" hrs in format of "HH:mm" on to "CurrentTime"
    Then Wait for "2" Seconds
    Then Verify Success Message displaying as "Load tendered successfully."

    #Step 24
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "404" and "Direction" as "Outbound"

    #Step 25 Expected Result b
    Then Verify Details
      | Transaction Type | Purpose | Direction | Event Code |
      | 404              | Update  | Outbound  |            |
    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    Then Set key "RevenovaHQ_AccountID" for Object "Account" and Name "Revenova HQ"
    Then Set key "Port_of_Long_Beach_AccountID" for Object "Account" and Name "Port of Long Beach"
    Then Set key "IllinoisTerminal_AccountID" for Object "Account" and Name "Illinois Terminal"
    Then Verify "Transaction Payload" with File "Transaction_b_payload.txt"
      | ShipmentId                 | {CurrentDateYYYY-MM-DD} | {CurrentDateYYYY-MM-DD+2} | {CurrentDateYYYY-MM-DD+5} | {ScratchOrgEmail} | DistanceInMiles           | RevenovaHQAccountID           | PortOfLongBeachAccountID              | IllinoisTerminal_AccountIDAccountID | RespondTime          |
      | SysData=>FP_Carrier_Load_1 | 0                       | 2                         | 5                         | Company_Email     | SysData=>Distance (Miles) | SysData=>RevenovaHQ_AccountID | SysData=>Port_of_Long_Beach_AccountID | SysData=>IllinoisTerminal_AccountID | SysData=>CurrentTime |
    
    #Step 26
    Then Navigate to stored URL for "Load_2"
    Then Get "Distance (Miles)" from "rtms-loadbanner_loadbanner"
    #Step 27
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Click on Carrier Quote from FQA Page
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Contract Information"
    Then Click on Edit icon on Label "Contract Id"
    Then Update details
      | Contract Id    |
      | ContractId2942 |
    Then Scroll into Section "Terminal Information"
    Then Update details
      | Movement Type | Origin Terminal Location | Destination Terminal Location |
      | Door to Port  | R2*CSXT*S*CHGO**25*X     | Destination Term 2942         |
    Then Wait for "1" Seconds
    Then Enter Label "Destination Terminal Location" TextArea as "Destination Term 2942"
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Contract Id    |
      | ContractId2942 |
    Then Go to "Pricing" Tab
    Then Click on button with Title "Tender"
    Then Store current Time plus "2" hrs in format of "HH:mm" on to "CurrentTime"
    Then Verify Message displaying as "Load tendered successfully."
    Then Capture the current URL for "Carrier_Quotes_2"
    Then Navigate to stored URL for "Load_2"

     #Step 28
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "404" and "Direction" as "Outbound"

    #Step 29 Expected Result c
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 404              | Original | Outbound  |            |
    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    Then Set key "RevenovaHQ_AccountID" for Object "Account" and Name "Revenova HQ"
    Then Set key "Georgia_Terminal_AccountID" for Object "Account" and Name "Georgia Terminal"
    Then Set key "IllinoisTerminal_AccountID" for Object "Account" and Name "Illinois Terminal"
    Then Verify "Transaction Payload" with File "Transaction_c_payload.txt"
      | ShipmentId                 | {CurrentDateYYYY-MM-DD} | {CurrentDateYYYY-MM-DD+2} | {CurrentDateYYYY-MM-DD+3} | {CurrentDateYYYY-MM-DD+5} | {ScratchOrgEmail} | DistanceInMiles           | RevenovaHQAccountID           | GeorgiaTerminalAccountID            | IllinoisTerminal_AccountIDAccountID | RespondTime          |
      | SysData=>FP_Carrier_Load_2 | 0                       | 2                         | 3                         | 5                         | Company_Email     | SysData=>Distance (Miles) | SysData=>RevenovaHQ_AccountID | SysData=>Georgia_Terminal_AccountID | SysData=>IllinoisTerminal_AccountID | SysData=>CurrentTime |
    Then Scroll into Section "System Information"
    Then Store EDI "CreatedBy"

    #Step 30 & 31
    Then Navigate to stored URL for "Carrier_Quotes_2"
    #Step 32
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Auto-Engagement"
    #EXpected d
    Then Verify details for
      | Tender Sent Date   |
      | SysData=>CreatedBy |

    #Step 33
    Then Navigate to stored URL for "Load_2"

    #Step 34
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "Seal Number"
    Then Wait for "2" Seconds
    Then Update details
      | Seal Number |
      | SN-2942     |
    Then Scroll into Section "Carrier Requirements"
    Then Update details
      | Equipment Weight |
      | 12,540           |
    Then Scroll into Section "Assigned Carrier Information"
    Then Update details
      | Container/Trailer Number |
      | 2942                     |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Verify Details
      | Seal Number |
      | SN-2942     |
    
   #Step 35
    Then Click on Native "Remove Carrier" icon
    Then Wait for "5" Seconds
    Then Verify Modal Heading Text displaying as "Rail EDI Carrier Two" -
    Then Click on button "Remove Carrier" -
    Then Verify Message displaying with "Carrier removed from load."
    Then Store current Time plus "2" hrs in format of "HH:mm" on to "CurrentTime"

    #Step 36
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "998" and "Direction" as "Outbound"

    #Step 37 Expected Result e
    Then Verify Details
      | Transaction Type | Purpose      | Direction | Event Code |
      | 998              | Cancellation | Outbound  |            |
    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    Then Set key "RevenovaHQ_AccountID" for Object "Account" and Name "Revenova HQ"
    Then Set key "Georgia_Terminal_AccountID" for Object "Account" and Name "Georgia Terminal"
    Then Set key "IllinoisTerminal_AccountID" for Object "Account" and Name "Illinois Terminal"
    Then Verify "Transaction Payload" with File "Transaction_d_payload.txt"
      | ShipmentId                 | {CurrentDateYYYY-MM-DD} | {CurrentDateYYYY-MM-DD+2} | {CurrentDateYYYY-MM-DD+3} | {CurrentDateYYYY-MM-DD+5} | {ScratchOrgEmail} | DistanceInMiles           | RevenovaHQAccountID           | GeorgiaTerminalAccountID            | IllinoisTerminal_AccountIDAccountID | RespondTime          |
      | SysData=>FP_Carrier_Load_2 | 0                       | 2                         | 3                         | 5                         | Company_Email     | SysData=>Distance (Miles) | SysData=>RevenovaHQ_AccountID | SysData=>Georgia_Terminal_AccountID | SysData=>IllinoisTerminal_AccountID | SysData=>CurrentTime |

    Then Close Current Tab
    Then Switch to Parent Window
    Then Wait for "2" Seconds