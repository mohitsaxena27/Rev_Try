Feature: 2087 - PayIQ Logs- Qualification- No Contact Assigned on Load Role Field

  @API @Regression @PayIQ @WEB @SingleCurrency @2087 @Qualification
  Scenario: 2087 - PayIQ Logs- Qualification- No Contact Assigned on Load Role Field

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
    
    #Step 4
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-10" from List
    Then Wait for "1" Seconds
    #Step 5
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) |
      |                   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "Load_1"

    #Step 6
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    #Wait for Generate Adjustments to complete
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 7
    Then Navigate to stored URL for "Load_1"

    #Step 8
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Participant Matches"

    #Expected Result 1(a)
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Joe Revenova PayIQ"

    #Step 9
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 10
    Then Go to "Logs" Tab
    Then Wait for "5" Seconds
    Then Update details
      | Load   | Type          |
      | PIQ-10 | Qualification |
    Then Wait for "2" Seconds

    #Step 11 #Expected Result b
    Then Verify Logs Contains as "No contact assigned via load field rtms9__Sales_Lead_Contact__c on load PIQ-10"
    Then Verify Timestamp date is "Current Date"
