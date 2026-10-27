Feature:2205 - PayIQ Logs- Qualification- Eligible Date Not Within Date Range for Team

  @API @Regression @PayIQ  @WEB @SingleCurrency @2205 @PayIQ_Logs
  Scenario: 2205 - PayIQ Logs- Qualification- Eligible Date Not Within Date Range for Team

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
    Then Click on "Participant-" with "Name" as "Team Awesome"
    Then Wait for "3" Seconds
    Then Capture the current URL for "Participant"
    Then Wait for "4" Seconds
    #Step 4
    Then Click on "New" button on "Team Members" section
    Then Update details
      | Type | User      | Expiration Date |
      | User | User User | 1/4/2024        |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Get "Participant-" Name with "Name" as "User User" and store in "Team_Member1"
    Then Click on "Participant-" with "Name" as "User User"
    Then Wait for "2" Seconds
    Then Set Key "TeamMember_SFID" page Record Id with "rtms9__Participant__c"
    Then Navigate to stored URL for "Participant"

    #Step 5
    Then Get "Participant-" Name with "Name" as "Test User0" and store in "Team_Member2"
    Then Click on "Participant-" with "Name" as "Test User0"
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Expiration Date"
    Then Update details
      |Expiration Date|Effective Date|
      |1/5/2024      |1/2/2024      |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Verify Details
      |Expiration Date|
      |1/5/2024      |
    Then Capture the current URL for "Team_Member2"
    Then Navigate to stored URL for "Participant"

    #Step 6
    Then Get "Participant-" Name with "Name" as "Joe Revenova PayIQ" and store in "Team_Member3"
    Then Click on "Participant-" with "Name" as "Joe Revenova PayIQ"
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Expiration Date"
    Then Update details
      |Expiration Date|
      |2/1/2023      |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Expiration Date|
      |2/1/2023      |
    Then Capture the current URL for "Team_Member3"

    #Step 7
   Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 8
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 9
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-18" from List
    Then  Capture the current URL for "Load_1L"

    #Step 10 & expected a
    Then Scroll Until Related List for "Participant Matches"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Team Awesome"

    #Step 11
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Load  | Type          |
      | PIQ-18 | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Step 12
    #expected b
    Then Verify Normalized Text displaying as "Eligible date 2024-01-01 not within date range for SysData=>Team_Member2: 2024-01-02 - 2024-01-05"
    Then Verify Timestamp date is "Current Date"

    #expected c
    Then Verify Normalized Text displaying as "Eligible date 2024-01-05 not within date range for SysData=>Team_Member1: null - 2024-01-04"
    Then Verify Timestamp date is "Current Date"

    #expected d
    Then Verify Normalized Text displaying as "Eligible date 2024-02-01 not within date range for SysData=>Team_Member3: null - 2023-02-01"
    Then Verify Timestamp date is "Current Date"