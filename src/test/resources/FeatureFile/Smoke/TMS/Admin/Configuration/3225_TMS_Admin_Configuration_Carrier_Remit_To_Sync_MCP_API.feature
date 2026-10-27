Feature: 3225 - TMS Admin Configuration- Carrier Remit To Sync (MCP API)

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency  @Admin @TMS_Config @3225 @Debugging
  Scenario: 3225 - TMS Admin Configuration- Carrier Remit To Sync (MCP API)
    
    When Login into Salesforce
    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Wait for "2" Seconds
    Then Go to "Global Services" Tab
    Then Search text "SaferWatch" in the "Search Credentials..." search box
    Then Select the "SaferWatch" record from the lookup field results
    Then Update details
      | Enabled |
      | False    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds
    Then Search text "RMIS" in the "Search Credentials..." search box
    Then Select the "RMIS" record from the lookup field results
    Then Update details
      | Enabled |
      | False    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds
    Then Search text "Highway" in the "Search Credentials..." search box
    Then Select the "Highway" record from the lookup field results
    Then Update details
      | Enabled |
      | False    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds

    # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Wait for "2" Seconds
    Then Update details -
      |Carrier Remit To Sync| Enable Packet Replay |
      |False                | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    Then Update details -
         |Carrier Monitor Last Run|
         |                        |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   #Step 3, 4, 5 & 6
    Given Upload File "MCPGetCarrierOperation.txt" with Title "MCPGetCarrierOperation"
    Given Upload File "MCPGetMonitoredCarriersOperation.txt" with Title "MCPGetMonitoredCarriersOperation"
    Given Upload File "MCPGetCarrierChangesOperation.txt" with Title "MCPGetCarrierChangesOperation"
    Given Upload File "MCPGetCompletedPacketsOperation.txt" with Title "MCPGetCompletedPacketsOperation"

    #Step 7
    Then Go to Home Page
    Then Run "CarrierMonitorMCPJob" Job
    Then Wait for "1" Seconds
    
    #Step 8
    Then Delete "CarrierMonitorMCPJob" job

    #Step 9
    Then Go to "Transportation Profiles" Object
    Then Search and Select "MCP Carrier 2947" from List
    Then Go to "Settlement" Tab

    #Expected a
    Then Scroll into Section "Carrier Remittance Information"
    Then Verify Details
         |Carrier Remit To|
         |MCP Carrier 2947|
    Then Capture the current URL for "TP_MCP"

    #Step 10
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Wait for "2" Seconds
    Then Update details -
      |Carrier Remit To Sync|
      |True                |
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    Then Update details -
      |Carrier Monitor Last Run|
      |                        |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 11
    Then Go to Home Page
    Then Run "CarrierMonitorMCPJob" Job
    Then Wait for "1" Seconds
    Then Delete "CarrierMonitorMCPJob" job

    #Step 12
    Then Navigate to stored URL for "TP_MCP"
    Then Go to "Settlement" Tab

    #Expected b
    Then Scroll into Section "Carrier Remittance Information"
    Then Verify Details
      |Carrier Remit To|
      |My Factoring Company 2947|
