Feature: 2723 - Carrier Monitor Highway Job - Java to Salesforce Queued Transaction Insert

  @API @Regression  @WEB @API_Operation @2723 @HighWay_API
  Scenario: 2723 - Carrier Monitor Highway Job - Java to Salesforce Queued Transaction Insert

    When Login into Salesforce
    Then Delete All Records with "rtms__Processor__c" as "HighwayInbound" for "rtms__QueuedTransaction__c"

    #Step 1
    Then Highway API - Reset processed onboarding packets

    #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab

    Then Search text "MyCarrierPackets" in the "Search Credentials..." search box
    Then Select the "MyCarrierPackets" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    Then Search text "SaferWatch" in the "Search Credentials..." search box
    Then Select the "SaferWatch" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    Then Search text "RMIS" in the "Search Credentials..." search box
    Then Select the "RMIS" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

    #Step 3
    Then Go to Home Page
    Then Run "CarrierMonitorHighwayJob" Job
    Then Wait for "2" Seconds

    #Step 4
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds

    #Step 5
    Then Recently Viewed to All
    Then Wait for "2" Seconds
    Then Sort "Last Modified Date" column in "descending" Order
    Then Wait for "2" Seconds

    #Step 6
    Then Click on Partial Link Text "QT-" on Page
    Then Wait for "2" Seconds

    #Expected Result a
    Then Verify Details
      | Processor      | Direction | Content Type     |
      | HighwayInbound | Inbound   | application/json |
    Then Get Details
      | Payload 1 |
      |           |
    Then Verify "Payload 1" is Not null or Empty
