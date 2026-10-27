Feature:2199 - PayIQ Logs- Qualification- PayIQ Program Not Open

  @API @Regression @PayIQ  @WEB @SingleCurrency @2199 @PayIQ_Logs
  Scenario: 2199 - PayIQ Logs- Qualification- PayIQ Program Not Open

    When Login into Salesforce

   #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

    #Step 2
    Then Click on Edit icon on Label "Status"
    Then Update details
         |Status|
         |Pending|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
         |Status|
         |Pending|

    #Step 3
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Aggregated Load Count (Invoiced Calculations)" from List

    #Step 4
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

    #Step 5
  Then Open "PayIQ Admin" from App Launcher
  Then Wait for "5" Seconds
    #Step 6
   Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    
    #Step 7
    Then Go to "Logs" Tab
    Then Update details
         |Type|
         |Qualification|

    #Step 8 & Expected Result a
    Then Verify Normalized Text displaying as "PayIQ Program not open: PayIQProgram Aggregated Load Count (Quoted Calculations)"







