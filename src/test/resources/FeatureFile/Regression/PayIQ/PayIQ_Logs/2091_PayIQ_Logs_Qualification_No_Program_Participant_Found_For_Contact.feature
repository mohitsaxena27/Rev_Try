Feature:2091 - PayIQ Logs- Qualification- No Program Participant Found For Contact
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2091
  Scenario: 2091 - PayIQ Logs- Qualification- No Program Participant Found For Contact
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
    Then Search and Select "PIQ-13" from List

    #Step 5
    Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      |Sales Lead (Contact)|
      |Joe Boston Beans|
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Sales Lead (Contact)|
      |Joe Boston Beans|
    Then Capture the current URL for "Load_URL"

    #Step 7
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

      #Step 8
    Then Navigate to stored URL for "Load_URL"
    Then Wait for "1" Seconds
    #Step 9 and Expected Result a
    Then Scroll Until Related List for "Participant Matches"
    Then Scroll down with "2" Times
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Joe Boston Beans"

    #Step 10 & 11
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Go to "Logs" Tab

     #Step 12 and Expected Result b
    Then Update details
      |Load|Type|
      |PIQ-13|Qualification|
    Then Wait for "1" Seconds
    Then Verify Normalized Text displaying as "No program participant found for contact: Joe Boston Beans"
    Then Verify Timestamp date is "Current Date"

