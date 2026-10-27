Feature:2079 - PayIQ Logs- Qualification- No Eligible Date Set

  @API @Regression @PayIQ  @WEB @SingleCurrency @2079 @PayIQ_Logs
  Scenario: 2079 - PayIQ Logs- Qualification- No Eligible Date Set

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

    #Step 3 & 4
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-2" from List
    Then  Capture the current URL for "Load_1L"

    #Step 5
    Then Click on Edit icon on Label "Custom PayIQ Eligible Date"
    Then Update details
      | Custom PayIQ Eligible Date |
      |                            |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "5" Seconds
    Then Verify Details
      | Custom PayIQ Eligible Date |
      |                            |

    #Step 6
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 7
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 9 & expected a
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Participant Matches"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Joe Revenova PayIQ"

    #Step 10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 11
    Then Go to "Logs" Tab
    Then Update details
      | Load  | Type          |
      | PIQ-2 | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Step 12 & expected b
    Then Verify Normalized Text displaying as "No eligible date set via Load field rtms9__Custom_Pay_Eligible_Date__c on Load: PIQ-2"
    Then Verify Timestamp date is "Current Date"