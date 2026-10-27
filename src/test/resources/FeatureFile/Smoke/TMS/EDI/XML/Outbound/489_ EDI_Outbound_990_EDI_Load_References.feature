Feature: 489 - EDI Outbound 990- EDI Load References

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @489
  Scenario: 489 - EDI Outbound 990- EDI Load References

    When Login into Salesforce
    #-----------------------------------------------------
        #Pre- Step 1
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
      #Pre- Step 2
    Then Go to "Home" Object
    Then Verify and Delete "EDIWatcherJob" from Scheduled Jobs

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
       | Enable Packet Replay |
       | True                 |
    And Update the Custom Select option "Logging User" as "User User"
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

     #Step 3, 4, 5
    Given Upload File "KleinschmidtGetLoadTendersOperation.xml" with Title "KleinschmidtGetLoadTendersOperation"

    #Step 6
    Then Open "TMS Admin" from App Launcher
    Then Go to "EDI Locations" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "KLIQA" with Text -
    Then Switch to Parent Frame
    Then Capture the current URL for "EDI_Transaction"
    Then Go to "Related" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "EDI Load References"
    Then Click on "EDI Load References" with Text
    Then Wait for "2" Seconds
    Then Click on "New" button
    Then Update details
     |TMS Object|Label             |Direction|Type|TMS Field  |
     |Load      |Reference Number 1|Outbound |OD  |Order Date|
    Then Click on "SaveAndNew" button
    Then Wait for "2" Seconds

    Then Update details
      |TMS Object|Label             |Direction|Type|TMS Field  |
      |Load      |Reference Number 2|Both     |PRO  |PRO Number|
    Then Click on "SaveAndNew" button
    Then Wait for "2" Seconds

    Then Update details
      |TMS Object|Label             |Direction|Type|TMS Field  |
      |Stop      |Reference Number 3|Outbound |PD  |Pickup/Delivery Number|
    Then Click on "SaveAndNew" button
    Then Wait for "2" Seconds

    Then Update details
      |TMS Object|Label             |Direction|Type|TMS Field  |
      |Line Item |Reference Number 4|Outbound |IN  |Item Number|
    Then Click on "SaveAndNew" button
    Then Wait for "2" Seconds

    Then Update details
      |TMS Object|Label             |Direction|Type|TMS Field  |
      |Load      |Reference Number 5|Inbound |CR  |PO Number|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 7
    Then Go to "Home" Object
    Then Run "EDIWatcherJob" Job
    Then Wait for "60" Seconds

    #Step 8
    Then Open "Loads" from App Launcher
    Then Search and Select "Load-489" from List
    Then Set Key "1LRI" page Record Id with "rtms__Load__c"
    #Step 9
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "PRO Number"
    Then Update details
      |PRO Number      |Order Date|
      |PROXYZ489       |1|
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Shipment IDs"
    Then Wait for "2" Seconds
    Then Wait for "PRO Number" Field Value Update with "PROXYZ489"
    Then Verify Details
      |PRO Number      |
      |PROXYZ489  |
    Then Refresh current Page
    Then Wait for "2" Seconds
    #Step 10
    Then Expand "Details" for "1" Load
    Then Click on Edit icon with Field Name "1P" "Pickup/Delivery Number"
    Then Update details
      |Pickup/Delivery Number|
      |TEST123               |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Collapse "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Expand "Items" for "1" Load
    Then Click on "Edit" on "1" item
    Then Update details
      |Item Number|
      |123TEST  |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Collapse "Items" for "1" Load

    #Step 11
    Then Wait for "1" Seconds
    Then Expand "Details" for "2" Load
    Then Click on Edit icon with Field Name "2D" "Pickup/Delivery Number"
    Then Update details
      |Pickup/Delivery Number|
      |TEST678               |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Collapse "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Expand "Items" for "2" Load
    Then Click on "Edit" on "2" item
    Then Update details
      |Item Number|
      |678TEST  |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Collapse "Items" for "2" Load

    #Step 12
    Then Go to "EDI" Tab
    Then Click on Edit icon on Label "EDI Status"
    Then Update details
        |EDI Status|
        |Accept    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Wait for "EDI Status" Field Value Update with "Accept"
    Then Verify Details
      |EDI Status      |
      |Accept  |
    #Step 13
    Then Wait for "120" Seconds
    Then Refresh current Page
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "990" and "Direction" as "Outbound"
    Then Verify details for
         |Transaction Type|Direction|
         |990             |Outbound |
    Then Scroll into Section "EDI Payload"
    Then Get Details
         |Transaction Payload|
         |Transaction Payload|
    #EXpected a
    Then Verify "Transaction Payload" with File "Transaction_payload.txt"
         |{CurrentDate+1}|
         |1              |
    #Expected b
    Then Verify Assertion for "Transaction Payload" not contains "<type>CR</type>"