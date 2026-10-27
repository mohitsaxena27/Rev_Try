Feature: 3085 - Carrier Service Trigger - API Provider + Credentials

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Carrier @Carrier_Service @3085
  Scenario: 3085 - Carrier Service Trigger - API Provider + Credentials

    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab

    Then Search and Select "AccuFrate" Service
    Then Scroll into Last of Webpage
    Then Set Field Value "Record Id" into "AccuFrateRecordID" Value

    Then Search and Select "Banyan" Service
    Then Scroll into Last of Webpage
    Then Set Field Value "Record Id" into "BanyanRecordID" Value
    Then Refresh current Page
    Then Go to "Carrier Services" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on Button with Value "New Carrier Service" -

    Then Switch to Parent Frame
    Then Update details
    |Service Type|Name                           |
    |Carrier     |Test Carrier a1eQh0000024CnpIAE|
    Then Update details With Set Value
    |Credentials       |
    |AccuFrateRecordID |
    Then Update details
      |Service Type|Name                           |Carrier          |Transportation Profile|
      |Carrier     |Test Carrier a1eQh0000024CnpIAE|Email Carrier One|Email Carrier One     |
    Then Update details
    |Mode     |Quote Method|Tender Method|Minimum Weight|Maximum Weight|Weight Units|
    |Truckload|Email       |Email        |0             |0             |lbs         |
    Then Click on "SaveEdit" button

    Then Verify Message displaying as "Test Carrier a1eQh0000024CnpIAE"
    Then Scroll into Section "General Information"
    Then Verify "API Provider" having value of "AccuFrate"

    Then Set Key "Carrier_Service" page Record Id with "rtms__CarrierService__c"

    Then Click on "Edit" button
#    Then Click on Edit icon on "API Provider"
    Then Wait for "1" Seconds
    Then Update details With Set Value
      |Credentials       |
      |BanyanRecordID    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify "API Provider" having value of "Banyan"












