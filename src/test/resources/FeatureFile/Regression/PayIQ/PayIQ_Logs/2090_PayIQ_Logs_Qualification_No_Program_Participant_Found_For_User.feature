Feature:2090 - PayIQ Logs- Qualification- No Program Participant Found For User

  @API @Regression @PayIQ  @WEB @SingleCurrency @2090 @PayIQ_Logs
  Scenario: 2090 - PayIQ Logs- Qualification- No Program Participant Found For User

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
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-12" from List
    Then  Capture the current URL for "Load_1L"

    #Step 5
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Test User1        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "5" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Test User1        |

    #Step 6
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 7
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 8, 9 & expected a
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Participant Matches"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Test User1"

    #Step 10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 11 & expected b
    Then Go to "Logs" Tab
    Then Update details
      | Load  | Type          |
      | PIQ-12 | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "No program participant found for user: Test User1"
    Then Verify Timestamp date is "Current Date"