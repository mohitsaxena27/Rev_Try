Feature: 3456 - EDI REST Webservice- GET: 200 Success

  @Regression @TMS @Smoke @WEB @API @SingleCurrency @EDI @3456
  Scenario: 3456 - EDI REST Webservice- GET: 200 Success

    When Login into Salesforce
    #Pre-Condition
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI|
      | True        |True                |
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "User User"
#    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "API User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Set key "ChicagoPizza_AccountID" for Object "Account" and Name "Chicago Pizza"
    Then Set key "LosAngelesLighting_AccountID" for Object "Account" and Name "Los Angeles Lighting"
    Then Set key "RevenovaHQ_AccountID" for Object "Account" and Name "Revenova HQ"
    Then Set key "Port_of_Long_Beach_AccountID" for Object "Account" and Name "Port of Long Beach"
    Then Set key "Illinois_Terminal_AccountID" for Object "Account" and Name "Illinois Terminal"


    #Step 1 & 2
    Then Open "EDI Transactions" from App Launcher
    Then Wait for "1" Seconds
    Then Click on button with Title "New"
    Then Get "Outbound_204_GET.txt" files and update below Attributes
      |{ChicagoPizzaAccountID}|{LosAngelesLightingAccountID}|{RevenovaHQAccountID}|
      |SysData=>ChicagoPizza_AccountID|SysData=>LosAngelesLighting_AccountID|SysData=>RevenovaHQ_AccountID|
    Then Wait for "3" Seconds
    Then Update details
      | Trading Partner      | EDI Location | Transaction Type | Purpose  | Direction | EDI Provider |
        | EDI Carrier One    |  EDIC1       | 204              | Original | Outbound   | Kleinschmidt |
    Then Enter Label "Transaction Payload" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Capture the current URL for "EDI_Transaction_1"
    Then Set Key "Transaction_204" page Record Id with "rtms__EDITransaction__c"


    #Step 3 & 4
    Then Open "EDI Transactions" from App Launcher
    Then Wait for "1" Seconds
    Then Click on button with Title "New"
    Then Get "Outbound_210_GET.txt" files and update below Attributes
      | No Update Required |
      |                    |
    Then Wait for "3" Seconds
    Then Update details
      | Trading Partner      | EDI Location | Transaction Type | Purpose  | Direction | EDI Provider |
      | Revenova HQ          |  KLIQA       | 210              | Original | Outbound   | Kleinschmidt |
    Then Enter Label "Transaction Payload" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Capture the current URL for "EDI_Transaction_2"
    Then Set Key "Transaction_210" page Record Id with "rtms__EDITransaction__c"


        #Step 5 & 6
    Then Open "EDI Transactions" from App Launcher
    Then Wait for "1" Seconds
    Then Click on button with Title "New"
    Then Get "Outbound_214_GET.txt" files and update below Attributes
      | No Update Required |
      |                    |
    Then Wait for "3" Seconds
    Then Update details
      | Trading Partner      | EDI Location | Transaction Type | Purpose  | Direction | EDI Provider |
      | Revenova HQ          |  KLIQA       | 214              | Original | Outbound   | Kleinschmidt |
    Then Enter Label "Transaction Payload" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Capture the current URL for "EDI_Transaction_3"
    Then Set Key "Transaction_214" page Record Id with "rtms__EDITransaction__c"

        #Step 7 & 8
    Then Open "EDI Transactions" from App Launcher
    Then Wait for "1" Seconds
    Then Click on button with Title "New"
    Then Get "Outbound_404_GET.txt" files and update below Attributes
      |{PortOfLong_BeachAccountID}|{Illinois_TerminalAccountID}|{RevenovaHQAccountID}|
      |SysData=>Port_of_Long_Beach_AccountID|SysData=>Illinois_Terminal_AccountID|SysData=>RevenovaHQ_AccountID|

    Then Wait for "3" Seconds
    Then Update details
      | Trading Partner         | EDI Location | Transaction Type | Purpose  | Direction | EDI Provider |
      | Rail EDI Carrier One    |  REDIC1       | 404              | Original | Outbound   | Kleinschmidt |
    Then Enter Label "Transaction Payload" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Capture the current URL for "EDI_Transaction_4"
    Then Set Key "Transaction_404" page Record Id with "rtms__EDITransaction__c"


      #Step 9 & 10
    Then Open "EDI Transactions" from App Launcher
    Then Wait for "1" Seconds
    Then Click on button with Title "New"
    Then Get "Outbound_990_GET.txt" files and update below Attributes
      | No Update Required |
      |                    |
    Then Wait for "3" Seconds
    Then Update details
      | Trading Partner      | EDI Location | Transaction Type | Purpose  | Direction | EDI Provider |
      | Revenova HQ          |  KLIQA       | 990              | Original | Outbound   | Kleinschmidt |
    Then Enter Label "Transaction Payload" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Capture the current URL for "EDI_Transaction_5"
    Then Set Key "Transaction_990" page Record Id with "rtms__EDITransaction__c"


      #Step 11 & 12 & 13
    Then Send Get Request for EDI with Access Token as "Access_Token"
    Then Set "CurrentDateTime" with "MM/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Set "RetrievableDataTime" with "yyyy-MM-dd HH:mm:ss.SSS Z" Format and "GMT" Timezone


    #Expected Result a
    Then Verify Json Array "EDI_API_Response" with File "EDI_Response.json"
      |{204_EDI_Transaction_Id}|{210_EDI_Transaction_Id}|{214_EDI_Transaction_Id}|{404_EDI_Transaction_Id}|{990_EDI_Transaction_Id}| {RetrievableDataTime}        |ChicagoPizzaAccountID|LosAngelesLightingAccountID|RevenovaHQAccountID|PortOfLong_BeachAccountID|Illinois_TerminalAccountID|
      |SysData=>Transaction_204|SysData=>Transaction_210|SysData=>Transaction_214|SysData=>Transaction_404|SysData=>Transaction_990| SysData=>RetrievableDataTime |SysData=>ChicagoPizza_AccountID|SysData=>LosAngelesLighting_AccountID| SysData=>RevenovaHQ_AccountID|SysData=>Port_of_Long_Beach_AccountID|SysData=>Illinois_Terminal_AccountID|

    #Step 14
    Then Navigate to stored URL for "EDI_Transaction_1"
    Then Scroll into Section "System Information"
    Then Get Details
      | EDI Provider Retrieval Date/Time |
      |                    |

    #Expected b
    Then Verify "SysData=>EDI Provider Retrieval Date/Time" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

   #Step 15
    Then Navigate to stored URL for "EDI_Transaction_2"
    Then Scroll into Section "System Information"
    Then Get Details
      | EDI Provider Retrieval Date/Time |
      |                    |
    #Expected c
    Then Verify "SysData=>EDI Provider Retrieval Date/Time" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 16
    Then Navigate to stored URL for "EDI_Transaction_3"
    Then Scroll into Section "System Information"
    Then Get Details
      | EDI Provider Retrieval Date/Time |
      |                    |
    #Expected d
    Then Verify "SysData=>EDI Provider Retrieval Date/Time" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 17
    Then Navigate to stored URL for "EDI_Transaction_4"
    Then Scroll into Section "System Information"
    Then Get Details
      | EDI Provider Retrieval Date/Time |
      |                    |
    #Expected e
    Then Verify "SysData=>EDI Provider Retrieval Date/Time" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 18
    Then Navigate to stored URL for "EDI_Transaction_5"
    Then Scroll into Section "System Information"
    Then Get Details
      | EDI Provider Retrieval Date/Time |
      |                    |
    #Expected f
    Then Verify "SysData=>EDI Provider Retrieval Date/Time" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"


