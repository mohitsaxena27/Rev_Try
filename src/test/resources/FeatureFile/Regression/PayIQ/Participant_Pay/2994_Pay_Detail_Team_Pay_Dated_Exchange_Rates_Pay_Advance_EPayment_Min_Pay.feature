Feature: 2994 - Pay Detail - Team Pay - Dated Exchange Rates - Pay Advance - EPayment - Min Pay

  @API @Regression @MultiCurrency @2994 @TeamPay
  Scenario: 2994 - Pay Detail - Team Pay - Dated Exchange Rates - Pay Advance - EPayment - Min Pay

    When Login into Salesforce

    Then Set "SFID" with ""
    Then Delete All Records with name "Clone - PayIQProgram Individual Load Revenue (Quoted)" for "rtms9__PayIQ_Program__c"
    Then Set "SFID" with ""
    Then Delete All Records with name "Pay Advance-" for "rtms9__Pay_Advance__c"
    Then Set "SFID" with ""
    Then Delete All Records with name "Minimum Pay Rule-" for "rtms9__Minimum_Pay_Rule__c"

    Then Store current date in format "M/d/yyyy" into "Today_Date"
    Then Store date "-1" days and "0" "months" from current date into "Yesterday_Date"
    Then Store date "1" days and "0" "months" from current date into "Tomorrow_Date"
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Set "Expected_Grand_Total_1" with "USD 714.29"
    Then Set "Expected_Grand_Total_2" with "USD 308.23"

    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Wait for "3" Seconds
    Then Recently Viewed to All

    #Step 2
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

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
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 4
    Then Click on button with Title Text "Clone"
    Then Wait for "20" Seconds
    Then Capture the current URL for "Cloned_Program"
    Then Set Key "Pay_Program_SFID1" page Record Id with "rtms9__PayIQ_Program__c"

    #Step 5
    Then Scroll Until Related List for "Participants"
    Then Click on link "Participants"
    Then Wait for "2" Seconds
    Then Click on button with Title Text "New"
    Then Wait for "2" Seconds
    Then Update details
      | Type |
      | Team |
    Then Wait for "2" Seconds
    Then Update details
      | Team Name      |
      | Team Dated CAD |
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds

    #Step 6
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Name" as "Team Dated CAD"
    Then Wait for "3" Seconds

    #Step 7
    Then Scroll Until Related List for "Team Members"
    Then Click on link "Team Members"
    Then Wait for "2" Seconds
    Then Click on button with Title Text "New"
    Then Wait for "2" Seconds
    Then Update details
      | Type |
      | User |
    Then Wait for "2" Seconds
    Then Update details
      | User      |
      | User User |

    #Step 8
    Then Click on "Save & New" with Text
    Then Wait for "3" Seconds
    Then Update details
      | Type    |
      | Contact |
    Then Wait for "2" Seconds
    Then Update details
      | Contact            |
      | Joe Revenova PayIQ |

    #Step 9
    Then Click on "Save & New" with Text
    Then Wait for "3" Seconds
    Then Update details
      | Type |
      | User |
    Then Wait for "2" Seconds
    Then Update details
      | User       |
      | Test User0 |

    #Step 10
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds

    #Step 11
    Then Navigate to stored URL for "Cloned_Program"
    Then Wait for "3" Seconds

    #Step 12
    Then Scroll Until Related List for "Participants"
    Then Click on link "Participants"
    Then Wait for "3" Seconds
    Then Get "Participant-" Name with "Name" as "User User" and store in "Participant_Name_1"
    Then Get "Participant-" Name with "Name" as "Test User0" and store in "Participant_Name_2"
    Then Get "Participant-" Name with "Name" as "Joe Revenova PayIQ" and store in "Participant_Name_3"
    Then Get "Participant-" Name with "Name" as "Dave Fleet Carrier One 8" and store in "Participant_Name_4"
    Then Get "Participant-" Name with "Name" as "Bruce Fleet Carrier Two 8" and store in "Participant_Name_5"
    Then Get "Participant-" Name with "Name" as "Tractor 1008" and store in "Participant_Name_6"
    Then Set key "Participant_Name_Key1" for Object "rtms9__Participant__c" and Name "SysData=>Participant_Name_1"
    Then Set key "Participant_Name_Key2" for Object "rtms9__Participant__c" and Name "SysData=>Participant_Name_2"
    Then Set key "Participant_Name_Key3" for Object "rtms9__Participant__c" and Name "SysData=>Participant_Name_3"
    Then Set key "Participant_Name_Key4" for Object "rtms9__Participant__c" and Name "SysData=>Participant_Name_4"
    Then Set key "Participant_Name_Key5" for Object "rtms9__Participant__c" and Name "SysData=>Participant_Name_5"
    Then Set key "Participant_Name_Key6" for Object "rtms9__Participant__c" and Name "SysData=>Participant_Name_6"
    Then Delete "rtms9__Participant__c" with Id "Participant_Name_Key1"
    Then Delete "rtms9__Participant__c" with Id "Participant_Name_Key2"
    Then Delete "rtms9__Participant__c" with Id "Participant_Name_Key3"
    Then Delete "rtms9__Participant__c" with Id "Participant_Name_Key4"
    Then Delete "rtms9__Participant__c" with Id "Participant_Name_Key5"
    Then Delete "rtms9__Participant__c" with Id "Participant_Name_Key6"

    #Step 13
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 14
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status  |
      | Pending |

    #Step 15
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | N            | N               |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

    #Step 16
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "50"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "50"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 17
    Then Enter Carrier Service as "Fleet Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "70"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Wait for "3" Seconds

    #Step 18
    Then Go to "EPayments" Tab
    Then Click on link "EPayments"
    Then Click on button "New"
    Then Update details
      | Load        | Transaction Type | Amount | Vendor         | Load Contact | Recipient          | Credit Deduction Amount | Funding Source | Currency |
      | SysData=>1L | Other            | 10     | Revenova PayIQ | Driver       | Joe Revenova PayIQ | Amount Only            | EFS            | CAD      |

    #Step 19
    Then Click on button "Issue"
    Then Wait for "3" Seconds

    #Step 20
    Then Close Toast message

    #Step 21
    Then Navigate to stored URL for "Load_Details"
    Then Wait for "3" Seconds
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Carrier Sales Rep | Sales Lead (Contact) | Custom PayIQ Eligible Date |
      | User User          | Test User1        | Joe Revenova PayIQ   | SysData=>Today_Date        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds

    #Step 22
    Then Open "EPayments" from App Launcher
    Then Wait for "5" Seconds
    Then Recently Viewed to All
    Then Wait for "3" Seconds

    #Step 23
    Then Search and Select "Deductible" Checkbox for the Value "SysData=>1L"
    Then Click on button "Save"
    Then Wait for "3" Seconds
    Then Click on "ePay-" with "Load" as "SysData=>1L"
    Then Wait for "2" Seconds
    Then Get Details
      | Name |
      |      |
    Then Set "ePay_Name" with "SysData=>Name"

    #Step 24
    Then Open "Pay Advances" from App Launcher
    Then Wait for "3" Seconds
    Then Click on "New" with Text
    Then Wait for "3" Seconds
    Then Update details
      | Transaction Date        |
      | SysData=>Yesterday_Date |
    Then Wait for "2" Seconds
    Then Update details
      | Category |
      | Addition |
    Then Wait for "2" Seconds
    Then Update details
      | Type  | Description |
      | Other | testing     |
    Then Wait for "2" Seconds
    Then Update details
      | Currency              |
      | CAD - Canadian Dollar |
    Then Wait for "2" Seconds
    Then Update details
      | Payee Type |
      | User       |
    Then Wait for "2" Seconds
    Then Update details
      | User      |
      | User User |
    Then Wait for "2" Seconds
    Then Update details
      | Qty | Rate | Adjustment Plan |
      | 2   | 5    | Flat Amount     |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button on Details Page
    Then Verify Message displaying as "Pay Advance-"
    Then Set Key "Pay_Advance_SFID_1" page Record Id with "rtms9__Pay_Advance__c"
    Then Get Details
      | Pay Advance ID |
      |                |
    Then Set "Pay_Advance_1" with "SysData=>Pay Advance ID"

    #Step 25
    Then Open "Pay Schedules" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "Test Pay Schedule" from List
    Then Go to "Min Pay Rules" Tab
    Then Scroll Until Related List for "Minimum Pay Rules"
    Then Click on "New" button on "Minimum Pay Rules" section
    Then Update details
      | Payee Type |
      | User       |
    Then Wait for "2" Seconds
    Then Update details
      | User       |
      | Test User0 |
    Then Wait for "2" Seconds
    Then Update details
      | Minimum Pay (Per Period) | Currency              |
      | 1000.00                  | CAD - Canadian Dollar |

    #Step 26
    Then Click on "SaveEdit" button
    Then Wait for "5" Seconds
    Then Get "Minimum Pay Rule-" Name with "Payee Name" as "Test User0" and store in "Min_Pay_Rule_1"

    #Step 27 : In this step we should wait for the next day, currently it is set to wait for 2 seconds, but in real scenario we should wait for the next day to run the dated exchange rates job.
    Then Wait for "2" Seconds

    #Step 28
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Update details
      | Quick Find        |
      | Manage Currencies |
    Then Wait for "1" Seconds
    Then Click on "Manage Currencies" with Text
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Currency ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "Manage Dated Exchange Rates" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "Continue" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "New Exchange Rates" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #Step 29
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Add New Exchange Rate with Start Date as "SysData=>Yesterday_Date" and CAD as "1.200000"

    #Step 30
    Then Switch to Parent Frame
    Then Wait for "3" Seconds

    #Step 31
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "New Exchange Rates" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #Step 32
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Add New Exchange Rate with Start Date as "SysData=>Today_Date" and CAD as "1.300000"

    #Step 33
    Then Switch to Parent Frame
    Then Wait for "3" Seconds

    #Step 34
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "New Exchange Rates" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #Step 35
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Add New Exchange Rate with Start Date as "SysData=>Tomorrow_Date" and CAD as "1.400000"

    #Step 36
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Capture the current URL for "CurrencyExchanged"
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 37
    Then Open "Pay Schedules" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "Test Pay Schedule" from List
    Then Go to "Min Pay Rules" Tab
    Then Scroll Until Related List for "Minimum Pay Rules"
    Then Click on "SysData=>Min_Pay_Rule_1" with Text

    #Step 38
    Then Click on Edit icon on Label "User"
    Then Update details
      | User       |
      | Test User1 |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

    #Step 39
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 40
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 41
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "5" Seconds

    #Step 42
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "Pay_Header_User"
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_User" from the Global search
    Then Wait for "3" Seconds

    #Step 43
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on link "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Verify Table With Header
      | Category | Rate     |
      | Addition | USD 8.33 |
    Then Click on "Pay Adjustment-" with "Category" as "Addition" and "Type" as "Other"
    Then Wait for "2" Seconds
    Then Verify Text displaying as "SysData=>Pay_Advance_1"

    #Step 44
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "Pay_Header_Joe"
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_Joe" from the Global search
    Then Wait for "3" Seconds

    #Step 45
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on link "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Verify Table With Header
      | Category  | Rate     |
      | Deduction | USD 7.69 |
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other"
    Then Wait for "2" Seconds
    Then Verify Text displaying as "SysData=>ePay_Name"

    #Step 46
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Test User0" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "Pay_Header_Test0"
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_Test0" from the Global search
    Then Wait for "3" Seconds

    #Step 47
    Then Scroll into Section "Totals"
    Then Verify Text displaying either "SysData=>Expected_Grand_Total_1" or "SysData=>Expected_Grand_Total_2"

    #Step 48
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "Pay_Header_User"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "Pay_Header_Joe"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Test User0" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "Pay_Header_Test0"

    #Step 49
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_User" from the Global search
    Then Wait for "3" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Total Pay |
      |           |
    Then Set "Total_Pay_User" with "SysData=>Total Pay"
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_Joe" from the Global search
    Then Wait for "3" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Total Pay |
      |           |
    Then Set "Total_Pay_Joe" with "SysData=>Total Pay"
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_Test0" from the Global search
    Then Wait for "3" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Total Pay |
      |           |
    Then Set "Total_Pay_Test0" with "SysData=>Total Pay"
    Then Verify "SysData=>Total_Pay_User" is within a cent of "SysData=>Total_Pay_Joe"
    Then Verify "SysData=>Total_Pay_User" is within a cent of "SysData=>Total_Pay_Test0"

    #Step 50
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_User" from the Global search
    Then Wait for "3" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Grand Total |
      |             |
    Then Set "Grand_Total_User" with "SysData=>Grand Total"
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_Joe" from the Global search
    Then Wait for "3" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Grand Total |
      |             |
    Then Set "Grand_Total_Joe" with "SysData=>Grand Total"
    Then Search and Select "rtms9__Pay_Header__c" "SysData=>Pay_Header_Test0" from the Global search
    Then Wait for "3" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Grand Total |
      |             |
    Then Set "Grand_Total_Test0" with "SysData=>Grand Total"
    Then Verify "Grand_Total_User" not equal to "SysData=>Grand_Total_Joe"
    Then Verify "Grand_Total_User" not equal to "SysData=>Grand_Total_Test0"
    Then Verify "Grand_Total_Joe" not equal to "SysData=>Grand_Total_Test0"
    Then Verify Text displaying either "SysData=>Expected_Grand_Total_1" or "SysData=>Expected_Grand_Total_2"
