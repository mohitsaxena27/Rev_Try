Feature:2080 - PayIQ Logs- Qualification- No Open Pay Period (Period Not Created)
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2080
  Scenario: 2080 - PayIQ Logs- Qualification- No Open Pay Period (Period Not Created)

    When Login into Salesforce

    #Step1
    Then Open "PayIQ Programs" from App Launcher
#    Then Ensure no "PayIQ Program" record exists with "Status" as "Open"
    #Step 2
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
    Then Search and Select "PIQ-4" from List
    #Step 5
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Custom PayIQ Eligible Date"
    Then Update details
     |Custom PayIQ Eligible Date|
     |11/29/2023|
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Custom PayIQ Eligible Date|
      |11/29/2023|
    Then Capture the current URL for "Load_URL"
    #Step 6
    Then Go to "Shipment" Tab
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "1P" "Expected Date"
    Then Update details
      |Expected Date|
      |11/28/2023   |
    Then Click on "Save" Button with Type "submit"
    Then Wait for "4" Seconds
    Then Collapse "Details" for "1" Load

    #Step 7
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 8
    Then Navigate to stored URL for "Load_URL"

    #Step 9 and Expected Result a
    Then Scroll Until Related List for "Participant Matches"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Joe Revenova PayIQ"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Test User0"

    #Step 10 and Expected Result b
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Go to "Logs" Tab
    Then Update details
    |Load|Type|
    |PIQ-4|Qualification|
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "No pay periods matched to date: 2023-11-28"
    Then Verify Timestamp date is "Current Date"

    #Step 12 and Expected Result c
    Then Go to "Logs" Tab
    Then Verify Normalized Text displaying as "No pay periods matched to date: 2023-11-29"
