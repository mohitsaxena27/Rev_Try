Feature: 195 - RMIS API- TMS Admin Configuration- Allow Carrier Address Updates

  Background: Pre- Test
    Then Delete Field with Title "RMISGetCarrierOperation"
    Then Delete Field with Title "RMISGetNewOrUpdatedCarriersOperation"
    Then Delete All Records with name "Almas Express Inc - LTL" for "rtms__CarrierService__c"
    Then Delete All Records with name "Almas Express Inc" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "Almas Express Inc" for "Account"

    When Login into Salesforce

  # Pre-Condition 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "RMIS" in the "Search Credentials..." search box
    Then Select the "RMIS" record from the lookup field results
    Then Update details
      | Enabled |
      | true    |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

  # Pre-Condition 1.a (SaferWatch)
    Then Search text "SaferWatch" in the "Search Credentials..." search box
    Then Select the "SaferWatch" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

  # Pre-Condition 1.a (MCP)
    Then Search text "MyCarrierPackets" in the "Search Credentials..." search box
    Then Select the "MyCarrierPackets" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

  # Pre-Condition 1.a (Highway)
    Then Search text "Highway" in the "Search Credentials..." search box
    Then Select the "Highway" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

  @API @Regression @WEB @TMS @Smoke @API_Operation @SingleCurrency @195 @RMIS_API
  Scenario: 195 - RMIS API- TMS Admin Configuration- Allow Carrier Address Updates

  # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Allow Carrier Address Updates |
      | False                         |
    Then Wait for "1" Seconds
    Then Scroll into Section "Debugging" -
    And Update details -
      | Enable Packet Replay |
      | true                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Wait for "1" Seconds
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    And Update details -
      | Carrier Monitor Last Run |
      |                          |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

  # Step 2 & Step 3 & Step 4
    Given Upload File "RMISGetCarrierOperation2.txt" with Title "RMISGetCarrierOperation"

  # Step 5 & Step 6
    Given Upload File "RMISGetNewOrUpdatedCarriersOperation.txt" with Title "RMISGetNewOrUpdatedCarriersOperation"

  # Step 7
    Then Go to Home Page
    Then Run "CarrierMonitorRMISJob" Job until Previous Run Time is not blank

  # Step 8
    Then Delete "CarrierMonitorRMISJob" from Apex job
    Then Wait for "2" Seconds

  # Step 9
    Then Search and Select "Almas Express Inc" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Shipping Address"
    Then Update Legend details
      | Shipping Address, Address Search                                             | Billing Address, Address Search                                              |
      | 181 W. Madison, Suite 3100, Chicago, IL 60602 =>181 W Madison St suite 3100 | 181 W. Madison, Suite 3100, Chicago, IL 60602 =>181 W Madison St suite 3100 |
    Then Click on button "Save"
    Then Wait for "3" Seconds

  # Step 10
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Wait for "1" Seconds
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    And Update details -
      | Carrier Monitor Last Run |
      |                          |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Go to Home Page
    Then Run "CarrierMonitorRMISJob" Job until Previous Run Time is not blank

  # Step 11
    Then Delete "CarrierMonitorRMISJob" from Apex job
    Then Wait for "2" Seconds

  # Step 12
    Then Search and Select "Almas Express Inc" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Get Details
      | Shipping Address | Billing Address |
      |                  |                 |
    Then Wrap "Shipping Address" in one line
    Then Verify Assertion for "Shipping Address" contains "181 W"
    Then Verify Assertion for "Shipping Address" contains "Madison"
    Then Verify Assertion for "Shipping Address" contains "Chicago"
    Then Verify Assertion for "Shipping Address" contains "60602"

  # Step 13
    Then Wrap "Billing Address" in one line
    Then Verify Assertion for "Billing Address" contains "181 W"
    Then Verify Assertion for "Billing Address" contains "Madison"
    Then Verify Assertion for "Billing Address" contains "Chicago"
    Then Verify Assertion for "Billing Address" contains "60602"

  # Step 14
    Then Delete Field with Title "RMISGetCarrierOperation"
    Then Delete Field with Title "RMISGetNewOrUpdatedCarriersOperation"
    Then Delete All Records with name "Almas Express Inc - LTL" for "rtms__CarrierService__c"
    Then Delete All Records with name "Almas Express Inc" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "Almas Express Inc" for "Account"

  # Step 15
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Allow Carrier Address Updates |
      | True                          |
    Then Wait for "1" Seconds
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    And Update details -
      | Carrier Monitor Last Run |
      |                          |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

  # Step 16 & Step 17
    Given Upload File "RMISGetCarrierOperation2_IsFactoring_No.txt" with Title "RMISGetCarrierOperation"

  # Step 18 & Step 19
    Given Upload File "RMISGetNewOrUpdatedCarriersOperation.txt" with Title "RMISGetNewOrUpdatedCarriersOperation"

  # Step 20
    Then Go to Home Page
    Then Run "CarrierMonitorRMISJob" Job until Previous Run Time is not blank

  # Step 21
    Then Delete "CarrierMonitorRMISJob" from Apex job
    Then Wait for "2" Seconds

  # Step 22 & Step 23
    Then Search and Select "Almas Express Inc" Account from the Global search
    Then Scroll into Section "Address Information"

  # Step 24
    Then Click on Edit icon on Label "Shipping Address"
    Then Update Legend details
      | Shipping Address, Address Search                                             | Billing Address, Address Search                                              |
      | 181 W. Madison, Suite 3100, Chicago, IL 60602 =>181 West Madison Street suite 3100 | 181 W. Madison, Suite 3100, Chicago, IL 60602 =>181 West Madison Street suite 3100 |
    Then Click on button "Save"
    Then Wait for "3" Seconds

  # Step 25
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Wait for "1" Seconds
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    And Update details -
      | Carrier Monitor Last Run |
      |                          |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Go to Home Page
    Then Run "CarrierMonitorRMISJob" Job until Previous Run Time is not blank

  # Step 26
    Then Delete "CarrierMonitorRMISJob" from Apex job
    Then Wait for "2" Seconds

  # Step 27
    Then Search and Select "Almas Express Inc" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Get Details
      | Shipping Address | Billing Address |
      |                  |                 |
    Then Wrap "Shipping Address" in one line
    Then Verify Assertion for "Shipping Address" contains "10900 Bustleton Ave Apt C4"
    Then Verify Assertion for "Shipping Address" contains "Philadelphia"
    Then Verify Assertion for "Shipping Address" contains "19116"

  # Step 28
    Then Wrap "Billing Address" in one line
    Then Verify Assertion for "Billing Address" contains "PO Box 840267"
    Then Verify Assertion for "Billing Address" contains "Dallas"
    Then Verify Assertion for "Billing Address" contains "75284-0267"