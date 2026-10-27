Feature:2776 - PayIQ Admin LWC - Configuration - Delete Logs by Category
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2776
  Scenario: 2776 - PayIQ Admin LWC - Configuration - Delete Logs by Category

    When Login into Salesforce

   Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
   Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
   Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
   Then Delete All Records with name "L-" for "rtms__Load__c"
    Then Delete All Records with name "Pay Header-" for "rtms9__Pay_Header__c"
    Then Delete All Records with "rtms9__Participant_Name__c" as "Joe Revenova PayIQ (Contact)" for "rtms9__Pay_Header__c"

   #Step1
   Then Open "PayIQ Programs" from App Launcher

   #Step2
   Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

    #Step3
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
   Then Search and Select "Contact" "Joe Revenova PayIQ" from the Global search
   Then Go to "Details" Tab

   #Step 5
   Then Click on Edit icon on Label "Contact Currency"
    Then Scroll into Section "System Information"
    Then Update details
    |Contact Currency|
    |CAD - Canadian Dollar|
   Then Click on "SaveEdit" button
   Then Wait for "2" Seconds
   Then Verify Details
    |Contact Currency|
    |CAD - Canadian Dollar|
   Then Capture the current URL for "Contact_Currency"

   #Step 6
   Then Open "PayIQ Admin" from App Launcher
   Then Wait for "6" Seconds

   #Step 7
   Then Go to "Configuration" Tab
   Then Verify details for all Enabled fields
   |Log Performance|Log Governor Limits|Log Qualification (met/did not meet criteria)|Log Math|Log Currency Conversions|
   |False          |False              |True                                         |True    |True                    |

   #step 8
   Then Go to "Job Monitor" Tab
   Then Wait for "3" Seconds
   Then Click on "Execute PayIQ Jobs Now" with Text
   Then Verify Message displaying as "PayIQ Jobs Triggered"
   Then Wait till "Generate Adjustments" is "Completed"

   #Step 9
   Then Go to "Configuration" Tab
   Then Update details
   |Delete Performance Logs|Delete Governor Limits Logs|Delete Qualification Logs|Delete Math Logs|Delete Currency Conversion Logs|
   |  False                |False                     |False                     |False           |False                          |
   Then Click on button "Save"
   Then Verify Message displaying as "PayIQ Configuration Saved"

   #Step 10
   Then Go to "Job Monitor" Tab
   Then Wait for "3" Seconds
   Then Click on "Execute PayIQ Jobs Now" with Text
   Then Verify Message displaying as "PayIQ Jobs Triggered"
   Then Wait till "Generate Adjustments" is "Completed"

   #Step 11 and expected result a
   Then Go to "Logs" Tab
   Then Update details
   |Type|
   |Qualification|
   Then Verify Type is "Qualification"

   #Step 12 and expected result b
   Then Go to "Logs" Tab
   Then Update details
    |Type|
    |Math|
   Then Verify Type is "Math"

    #Step 13 and expected result c
   Then Go to "Logs" Tab
   Then Update details
    |Type|
    |Currency Conversion |
   Then Verify Type is "Currency Conversion"

   #Step 14
   Then Go to "Configuration" Tab
   Then Update details
     |Delete Currency Conversion Logs|
     |True                           |
   Then Click on button "Save"
   Then Verify Message displaying as "PayIQ Configuration Saved"

   #Step 15
   Then Go to "Job Monitor" Tab
   Then Wait for "3" Seconds
   Then Click on "Execute Delete PayIQ Logs Now" with Text
   Then Verify Message displaying as "Delete PayIQ Logs Triggered"
   Then Wait till "Delete PayIQ Log" is "Completed"

   #Step 16 and expected result d
   Then Go to "Logs" Tab
   Then Update details
    |Type|
    |Qualification |
   Then Verify Type is "Qualification"

    #Step 17 and expected result e
   Then Go to "Logs" Tab
   Then Update details
    |Type|
    |Math|
   Then Verify Type is "Math"

    #Step 18 and expected result f
   Then Go to "Logs" Tab
   Then Update details
    |Type|
    |Currency Conversion |
   Then Verify Type is not "Currency Conversion"

   #Step 19
   Then Go to "Configuration" Tab
   Then Verify Banner details For Checkbox
    |Delete Performance Logs|Delete Governor Limits Logs|Delete Qualification Logs|
    |  False                |False                     |False                     |
   Then Update details
    |Delete Currency Conversion Logs|Delete Math Logs|
    |True                           |True            |
   Then Click on button "Save"
   Then Verify Message displaying as "PayIQ Configuration Saved"

   #Setp 20
   Then Go to "Job Monitor" Tab
   Then Wait for "3" Seconds
   Then Click on "Execute Delete PayIQ Logs Now" with Text
   Then Verify Message displaying as "Delete PayIQ Logs Triggered"
   Then Wait till "Delete PayIQ Log" is "Completed"

   #Step 21 and expected result g
   Then Go to "Logs" Tab
   Then Update details
    |Type|
    |Qualification |
   Then Verify Type is "Qualification"

   #Step 22 and expected result h
   Then Go to "Logs" Tab
   Then Update details
    |Type|
    |Math |
   Then Verify Type is not "Math"

   #Step 23
   Then Go to "Configuration" Tab
   Then Update details
    |Delete Performance Logs|Delete Governor Limits Logs|Delete Qualification Logs|Delete Math Logs| Delete Currency Conversion Logs|
    |  False                |False                     |True                   |True           | True                           |
   Then Click on button "Save"
   Then Verify Message displaying as "PayIQ Configuration Saved"
   Then Capture the current URL for "PayIQ_DeleteLogs"

   #Step 24
   Then Go to "Job Monitor" Tab
   Then Wait for "3" Seconds
   Then Click on "Execute Delete PayIQ Logs Now" with Text
   Then Verify Message displaying as "Delete PayIQ Logs Triggered"
   Then Wait till "Delete PayIQ Log" is "Completed"

   #Step 25 and expected result i
   Then Go to "Logs" Tab
   Then Update details
    |Type|
    |Qualification |
   Then Verify Type is not "Qualification"


