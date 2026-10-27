Feature: 3241 - Fleet Management Job 3- Pass 13- Driver Messages

  @API @Regression @Smoke @WEB @FMS @Fleet_Management_Job @SingleCurrency  @3241
  Scenario: 3241 - Fleet Management Job 3- Pass 13- Driver Messages

    When Login into Salesforce
    Then Delete Field with Title "SamsaraGetMessagesOperation"
     #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    And Update details for "Catena" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

     # Step 2 a
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | true                 |
    And Update the Custom Select option "Logging User" as "User User"
     # Step 2 b
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    Then Update details -
      | Fleet Management Enabled |
      | True                     |
    And Click on Button with Value "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame

    #Step 3
    Given Upload File "SamsaraGetMessagesOperation-3241.txt" with Title "SamsaraGetMessagesOperation"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "SamsaraGetMessagesOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "SamsaraGetMessagesOperation" -
    Then Enter File Label "API Name" Text as "SamsaraGetMessagesOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    #Step 4
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 44" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID  |
      | 3241    |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "ELD ID" having value of "3241"
    Then Capture the current URL for "Driver_Page"

    #Step 5
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Wait for "20" Seconds

    #Step 6
   Then Navigate to stored URL for "Driver_Page"
    Then Wait for "5" Seconds
    
    #Expected Result 
    Then Scroll into Section "From Driver: Revenova Rocks"
    Then Verify Text displaying as "From Driver: Revenova Rocks"
    Then Verify Text displaying as "Automated Process to Scratch2-SC-US-tmsMain/packages/tmsMain"
    Then Scroll into Section "From Driver: QA is so Cool"
    Then Verify Text displaying as "From Driver: QA is so Cool"
    Then Verify Text displaying as "Automated Process to Scratch2-SC-US-tmsMain/packages/tmsMain"


