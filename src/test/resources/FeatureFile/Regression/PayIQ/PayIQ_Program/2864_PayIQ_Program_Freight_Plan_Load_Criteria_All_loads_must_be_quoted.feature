Feature:2864 - PayIQ Program - Freight Plan Load Criteria - All loads must be quoted

  @API @Regression @PayIQ  @WEB @SingleCurrency @2864 @PayIQ_Logs
  Scenario: 2864 - PayIQ Program - Freight Plan Load Criteria - All loads must be quoted

    When Login into Salesforce

    #Step 1
    Then Open "Freight Plans" from App Launcher
    Then Search and Select "Plan-7" from List
    Then Wait for "5" Seconds
    Then Click on "Clone" with Text
    Then Wait for "10" Seconds
    Then Freight Plan - Click on 1 Cloned Load Checkbox
    Then Freight Plan - Click on 2 Cloned Load Checkbox
    Then Click on "Save" with Text
    Then Capture the current URL for "Plan_1"

    Then Wait for "10" Seconds
    Then Freight Plan - Verify and get the "1" Load hyperlink in the User Selected Loads - Load View Section on "FP_Customer_Load_1"
    Then Freight Plan - Verify and get the "2" Load hyperlink in the User Selected Loads - Load View Section on "FP_Customer_Load_2"
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"
    Then Freight Plan - Verify and get the "2" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_2"

    #Step 2
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

    #Step 4
    Then Expand "Details" for "1" Load
    Then Click on button with Title "Go to Freight Plan"
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan1"

    #Step 5
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Customer_Load_2" from List

    #Step 6
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

    #Step 7
    Then Expand "Details" for "1" Load
    Then Click on button with Title "Go to Freight Plan"
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan2"

    #Step 8
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_1" from List

    #Step 9
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Second User       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Second User       |
    Then  Capture the current URL for "Load_3L"


    #Step 10
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_2" from List

    #Step 11
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Second User       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Second User       |
    Then  Capture the current URL for "Load_4L"

    #Step 12
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Freight Plan Settings" from List

    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 13
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 14
    Then Go to "Logs" Tab
    Then Update details
      | Load                        |
      | SysData=>FP_Customer_Load_1 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Expected a
    Then Verify Normalized Text displaying as "Freight Plan Load Criteria All loads must be quoted not met for freight plan: SysData=>Freight_Plan1"

    Then Update details
      | Load                        |
      | SysData=>FP_Customer_Load_2 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Expected b
    Then Verify Normalized Text displaying as "Freight Plan Load Criteria All loads must be quoted not met for freight plan: SysData=>Freight_Plan2"

    Then Update details
      | Load                       |
      | SysData=>FP_Carrier_Load_1 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Expected c
    Then Verify Normalized Text displaying as "Freight Plan Load Criteria All loads must be quoted not met for freight plan: SysData=>Freight_Plan1"
    Then Verify Normalized Text displaying as "Freight Plan Load Criteria All loads must be quoted not met for freight plan: SysData=>Freight_Plan2"

    Then Update details
      | Load                       |
      | SysData=>FP_Carrier_Load_2 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Expected d
    Then Verify Normalized Text displaying as "Freight Plan Load Criteria All loads must be quoted not met for freight plan: SysData=>Freight_Plan2"

    #Step 15 & 16
    Then Navigate to stored URL for "Load_2L"

    #Step 17
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "900"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Update details
      | *                          |
      | SysData=>FP_Carrier_Load_2 |
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 18 & 19
    Then Navigate to stored URL for "Load_1L"

    #Step 20
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "900"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   #Step 21
    Then Go to Home Page
    Then Run "FreightPlanManagementJob" Job

   #Step 22
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 23
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 24
    Then Go to "PayIQ Generated" Tab
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds

    #Expected e
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













