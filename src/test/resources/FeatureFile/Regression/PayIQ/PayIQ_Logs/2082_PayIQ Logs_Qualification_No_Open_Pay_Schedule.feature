Feature:2082 - PayIQ Logs- Qualification- No Open Pay Schedule
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2082
  Scenario: 2082 - PayIQ Logs- Qualification- No Open Pay Schedule
    When Login into Salesforce

#Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

    #Step 3
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Open|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Open|
    Then Capture the current URL for "PayIQ_Program_1"


     #Step 4
    Then Open "Pay Schedules" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "Test Pay Schedule" from List
    Then Click on Edit icon on Label "Active"
    Then Update details
      |Active|
      |false|
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Active|
      |false|
    Then Capture the current URL for "PaySchedule_URL"


    #Step 5 & 6
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 7
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-9" from List

    #Step 8 and Expected Result a
    Then Scroll Until Related List for "Participant Matches"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "User User"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Test User0"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Participant Team 1"

    #Step 7 &8
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Go to "Logs" Tab

    #Step 9 and  Expected Result b
    Then Update details
    |Load|Type|
    |PIQ-9|Qualification|
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Pay Schedule not open"
    Then Verify Timestamp date is "Current Date"




