Feature: 2203 - PayIQ Logs- Qualification- Eligible Date Not Within Date Range for User

  @API @Regression @PayIQ @WEB @SingleCurrency @2203 @PayIQ_Logs
  Scenario: 2203 - PayIQ Logs- Qualification- Eligible Date Not Within Date Range for User

    When Login into Salesforce

    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    #Step 2
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List
    #Step 3
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program"

    #Step 4 and 4a
    Then Go to "Related" Tab
    Then Scroll Until Related List for "Participants"
    Then Get "Participant-" Name with "Name" as "User User" and store in "Participant_Name"
    Then Click on "Participant-" with "Name" as "User User"
    Then Wait for "2" Seconds
    #Step 5
    Then Scroll into Section "Duration"
    Then Click on Edit icon on Label "Effective Date"
    Then Update details
      | Effective Date |
      | 1/6/2024       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Effective Date |
      | 1/6/2024       |
    Then Capture the current URL for "Participant_Page"

    #Step 6
    Then Open "PayIQ Admin" from App Launcher
    #Step 7
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 8
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-16" from List

    #Step 9
    Then Scroll Until Related List for "Participant Matches"
      #Expected Result A
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "User User"

    #Step 10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    #Step 11
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      | Load   | Type          |
      | PIQ-16 | Qualification |
    Then Wait for "5" Seconds

    #Step 12
    Then Verify Logs Contains as "Eligible date 2024-01-05 not within date range for {Participant_Name}: 2024-01-06 - null"
    Then Verify Timestamp date is "Current Date"
    