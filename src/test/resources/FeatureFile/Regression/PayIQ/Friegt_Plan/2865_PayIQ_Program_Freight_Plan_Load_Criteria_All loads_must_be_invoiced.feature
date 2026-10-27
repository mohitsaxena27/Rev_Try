Feature: 2865 - PayIQ Program - Freight Plan Load Criteria - All loads must be invoiced

  @API @Regression @PayIQ @WEB @SingleCurrency  @PayIQ_FreightPlan @2865
  Scenario: 2865 - PayIQ Program - Freight Plan Load Criteria - All loads must be invoiced

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"
    #Step 1
    Then Open "Freight Plans" from App Launcher
    Then Search and Select "Plan-7" from List
    Then Wait for "5" Seconds
    Then Click on "Clone" with Text

    #Step 2
    Then Wait for "10" Seconds
    Then Freight Plan - Click on 1 Cloned Load Checkbox
    Then Freight Plan - Click on 2 Cloned Load Checkbox

    #Step 3,4
    Then Click on "Save" with Text
    Then Wait for "5" Seconds
    Then Capture the current URL for "Plan_1"
    Then Freight Plan - Verify and get the "1" Load hyperlink in the User Selected Loads - Load View Section on "FP_Customer_Load_1"
    Then Freight Plan - Verify and get the "2" Load hyperlink in the User Selected Loads - Load View Section on "FP_Customer_Load_2"
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"
    Then Freight Plan - Verify and get the "2" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_2"


    #Step 5
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Customer_Load_1" from List
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep |
      | Test User1         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Test User1         |
    Then  Capture the current URL for "Load_1L"
    Then Expand "Details" for "1" Load
    Then Click on button with Title "Go to Freight Plan"
    #Step 6
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan1"


    #Step 7
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Customer_Load_2" from List

    #Step 8
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep |
      | Test User1         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Test User1         |
    Then  Capture the current URL for "Load_2L"


    Then Expand "Details" for "1" Load
    Then Click on button with Title "Go to Freight Plan"

    #Step 9
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan2"

    #Step 10
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_1" from List
    Then Wait for "2" Seconds

    #Step 11
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Second User           |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Second User           |
    Then  Capture the current URL for "Load_3L"


    #Step 12
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_2" from List
    Then Wait for "2" Seconds

    #Step 13
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Second User           |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then  Capture the current URL for "Load_4L"

    #Step 14
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Freight Plan Settings" from List

    #Step 15
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Scroll into Section "Freight Plan Settings"
    Then Update details
    |Freight Plan Load Criteria|
    |All loads must be invoiced|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 16
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Wait for "2" Seconds
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

   #Step 17
   Then Go to "Logs" Tab
    Then Update details
    | Load|
    |SysData=>FP_Customer_Load_1   |
    Then Wait for "4" Seconds

    #Expected Result a)
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan1}"
    Then Wait for "2" Seconds

    Then Update details
      | Load|
      |SysData=>FP_Customer_Load_2   |
    Then Wait for "4" Seconds

    #Expected Result b)
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan2}"

    Then Update details
      | Load|
      |SysData=>FP_Carrier_Load_1 |
    Then Wait for "4" Seconds

    #Expected Result c)
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan1}"
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan2}"

    Then Update details
      | Load|
      |SysData=>FP_Carrier_Load_2 |
    Then Wait for "4" Seconds

    #Expected Result d)
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan2}"

    #Step 18,19
    Then Navigate to stored URL for "Load_2L"

    #Step 20 a)
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "900"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then Update details
      |Status|
      |Accepted   |

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 20 b)
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"

    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Wait for "3" Seconds

    #Step 21 need to be written
    Then Update details
    |*|
    |SysData=>FP_Carrier_Load_2|
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"

    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Wait for "3" Seconds

    #Step 22,23
    Then Navigate to stored URL for "Load_1L"

    #Step 24
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "900"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then Update details
      |Status|
      |Accepted   |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 25
    Then Go to Home Page
    Then Run "FreightPlanManagementJob" Job
    Then Wait for "5" Seconds

    #Step 26
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Wait for "2" Seconds
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 27
    Then Go to "Logs" Tab
    Then Update details
      | Load|
      |SysData=>FP_Customer_Load_1   |
    Then Wait for "3" Seconds
    #Expected Result e)
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan1}"

    Then Update details
      | Load|
      |SysData=>FP_Customer_Load_2   |
    Then Wait for "4" Seconds

    #Expected Result f)
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan2}"

    Then Update details
      | Load|
      |SysData=>FP_Carrier_Load_1   |
    Then Wait for "4" Seconds

    #Expected Result g)
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan1}"
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan2}"

    Then Update details
      | Load|
      |SysData=>FP_Carrier_Load_2  |
    Then Wait for "4" Seconds

    #Expected Result h)
    Then Verify Logs Contains as "Freight Plan Load Criteria All loads must be invoiced not met for freight plan: {Freight_Plan2}"

    #Step 28,29)
    Then Navigate to stored URL for "Load_3L"


    #Step 30 a,b)
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Billing Status|
      | Approved  |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 30 c,d) pending
    Then Update details
      |*|
      |SysData=>FP_Customer_Load_2|
    Then Wait for "5" Seconds
    Then Update details
      |Billing Status|
      |Approved  |
    Then Wait for "3" Seconds
    Then "Save" Customer Quotes

    #Step 30 e)
    Then Go to "Details" Tab
    Then Click on Edit icon on "Load Status"
    Then Update details
      |Load Status  |
      |Delivered       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "4" Seconds

    #Step 31,32)
    Then Navigate to stored URL for "Load_4L"
    Then Go to "Details" Tab
    Then Click on Edit icon on "Load Status"
    Then Update details
      |Load Status  |
      |Delivered       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "4" Seconds

    #Step 33)
    Then Go to Home Page
    Then Run "FreightPlanManagementJob" Job
    Then Wait for "5" Seconds

    #Step 34)
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Wait for "2" Seconds
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 35,36)
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Go to "PayIQ Generated" Tab
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds

    #Expected Result i)
    Then Set "MatchedTo1" with "SysData=>FP_Customer_Load_1" and " / " and "SysData=>Freight_Plan1"
    Then Set "MatchedTo2" with "SysData=>FP_Customer_Load_2" and " / " and "SysData=>Freight_Plan2"
    Then Set "MatchedTo3" with "SysData=>FP_Carrier_Load_1" and " / " and "SysData=>Freight_Plan1"
    Then Set "MatchedTo4" with "SysData=>FP_Carrier_Load_1" and " / " and "SysData=>Freight_Plan2"
    Then Set "MatchedTo5" with "SysData=>FP_Carrier_Load_2" and " / " and "SysData=>Freight_Plan2"
    Then Verify "Participant Matches" Table Details
      | Participant Name   | Matched To Type | Matched To          |
      | Test User1 (User)  | Load            | SysData=>MatchedTo1 |
      | Test User1 (User)  | Load            | SysData=>MatchedTo2 |
      | Second User (User) | Load            | SysData=>MatchedTo3 |
      | Second User (User) | Load            | SysData=>MatchedTo4 |
      | Second User (User) | Load            | SysData=>MatchedTo5 |








