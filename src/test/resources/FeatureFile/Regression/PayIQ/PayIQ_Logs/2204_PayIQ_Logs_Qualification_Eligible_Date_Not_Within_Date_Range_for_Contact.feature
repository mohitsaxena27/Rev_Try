Feature:2204 - PayIQ Logs- Qualification- Eligible Date Not Within Date Range for Contact

  @API @Regression @PayIQ  @WEB @SingleCurrency @2204 @PayIQ_Logs
  Scenario: 2204 - PayIQ Logs- Qualification- Eligible Date Not Within Date Range for Contact

    When Login into Salesforce

   #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List
    
    #Step 2
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

    #Step 3
    Then Scroll Until Related List for "Participants"
    Then Get "Participant-" Name with "Name" as "Joe Revenova PayIQ" and store in "Participant_1"
    Then Click on "Participant-" with "Name" as "Joe Revenova PayIQ"
    Then Wait for "3" Seconds
    #capture participant id

    #Step 4
    Then Click on Edit icon on Label "Expiration Date"
    Then Update details
    |Expiration Date|
    |1/29/2024      |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Expiration Date|
      |1/29/2024      |
    Then Capture the current URL for "Participant"

    #Step 5
   Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 6
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 7
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-17" from List
    Then  Capture the current URL for "Load_1L"

    #Step 8 & expected a
    Then Scroll Until Related List for "Participant Matches"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Joe Revenova PayIQ"

    #Step 9
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 10
    Then Go to "Logs" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Load  | Type          |
      | PIQ-17 | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Step 12 & expected b
    Then Verify Normalized Text displaying as "Eligible date 2024-02-01 not within date range for SysData=>Participant_1: null - 2024-01-29"
    Then Verify Timestamp date is "Current Date"