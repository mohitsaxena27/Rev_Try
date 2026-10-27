Feature:2781 - PayIQ Admin LWC - Execute Delete PayIQ Logs
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2781
  Scenario: 2781 - PayIQ Admin LWC - Execute Delete PayIQ Logs

    When Login into Salesforce

   #Step1
   Then Open "PayIQ Programs" from App Launcher
   Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

    #Step 2 & 3
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
   Then Open "PayIQ Admin" from App Launcher
   Then Wait for "6" Seconds

   #Step 5
   Then Click on "Execute PayIQ Jobs Now" with Text
   Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "Current_Time"
   Then Verify Message displaying as "PayIQ Jobs Triggered"
   Then Wait till "Generate Adjustments" is "Completed"

   #Step 6
   Then Go to "Logs" Tab
   Then Click on button "Refresh"
   Then Verify Timestamp date is "Current Date"

   #Step 7 & expected a
   Then Go to "Job Monitor" Tab
   Then Click on "Execute Delete PayIQ Logs Now" with Text
   Then Verify Message displaying as "Delete PayIQ Logs Triggered"

   #Step 8 & expected b
   Then Go to "Logs" Tab
   Then Click on button "Refresh"
   Then Verify Text not displaying as "PayIQ Program not open"

   #Step 9 & 10
   Then Navigate to stored URL for "PayIQ_Program_1"
   Then Click on Edit icon on Label "Status"
   Then Update details
    |Status|
    |Pending|
   Then Click on "SaveEdit" button
   Then Wait for "2" Seconds
   Then Verify Details
    |Status|
    |Pending|

   #Step 11
   Then Open "PayIQ Admin" from App Launcher
   Then Wait for "6" Seconds
   Then Go to "Job Monitor" Tab

   #Step 12 & expected c
   Then Click on "Execute Delete PayIQ Logs Now" with Text
   Then Verify Message displaying as "Delete PayIQ Logs Triggered"
