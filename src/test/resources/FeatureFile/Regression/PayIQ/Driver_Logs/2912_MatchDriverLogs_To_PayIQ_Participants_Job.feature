Feature:2912 - MatchDriverLogsToPayIQParticipants Job

  @API @Regression @PayIQ  @WEB @SingleCurrency @2912 @PayIQ_Logs
  Scenario: 2912 - MatchDriverLogsToPayIQParticipants Job

    When Login into Salesforce

    #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

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
    Then Note the current Date and Time

    #Step 5
    Then Go to "PayIQ Generated" Tab
    Then Click on link "Participant Matches"
    Then Zoom Current Screen by "33"
    Then Wait for "3" Seconds
    Then Verify table has "0" records with "Matched To Type" as "Driver Log"

    #Step 6
    Then Open "Driver Logs" from App Launcher
    Then Wait for "3" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Driver                   | Driving Duration | On Duty Duration | Certification Status|
      | Dave Fleet Carrier One 8 | 225              | 275              | Certified           |
    Then Update Legend details
      | Start Time, Date | End Time, Date | Certified as of, Date |
      | 0                | 0              | 0                     |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Set Key "DriverLog_SFID" page Record Id with "rtms__DriverLog__c"
    Then Get Details
         |Driver Log Name|
         |               |

    #Step 7
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "10" Seconds

    #Step 8
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 9
    #Step 10 & expected a
    Then Get count from "rtms9__Participant_Match2__c" using "rtms9__Participant_Name__c" with value "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Matched_To__c" with value "SysData=>Driver Log Name" and Store into "PM"
    Then Verify Assertion for "PM_count" contains "0"

    #Step 11
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "2" Seconds
    #Step 12 & 13
    Then Click on "Role-" with "Parent Object" as "Trip Plan Leg" and "Lookup Type" as "Driver"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Parent Object"
    Then Update details
    |Parent Object|
    |Driver Log|
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 14
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "10" Seconds
    #Step 15
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Go to "PayIQ Generated" Tab
    #Step 16 & expected b
    Then Get count from "rtms9__Participant_Match2__c" using "rtms9__Participant_Name__c" with value "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Matched_To__c" with value "SysData=>Driver Log Name" and Store into "PM"
    Then Verify Assertion for "PM_count" contains "1"
