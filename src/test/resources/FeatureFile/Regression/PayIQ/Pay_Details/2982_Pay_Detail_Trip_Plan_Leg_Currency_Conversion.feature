Feature:2982 - Pay Detail - Trip Plan Leg Currency Conversion

  @API @Regression @PayIQ  @WEB @SingleCurrency @2982 @PayIQ_Logs
  Scenario: 2982 - Pay Detail - Trip Plan Leg Currency Conversion

    When Login into Salesforce

    # Step 1
    Then Open "Drivers" from App Launcher
    Then Search and Select "Dave Fleet Carrier One 7" from List

    #Step 2
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Currency"
    Then Update details
      |Currency|
      |CAD - Canadian Dollar|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Currency|
      |CAD - Canadian Dollar|
    Then Capture the current URL for "Driver_1"

    #Step 3
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "Tractor 1007" from List
    #Step 4
    Then Go to "Details" Tab
    Then Scroll into Section "System Information"
    Then Click on Edit icon on Label "Currency"
    Then Update details
      |Currency|
      |CAD - Canadian Dollar|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Currency|
      |CAD - Canadian Dollar|
    Then Capture the current URL for "Fleet_Assets_1"

    #Step 5 & 6
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Driver Pay - Per Mile" from List
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
    #Step 7
    Then Open "Loads" from App Launcher
    Then Store date with month offset 1 and day 2 in format MMM d, yyyy into "SecondDayOfNextMonth"
    Then Store date with month offset 1 and day 5 in format MMM d, yyyy into "FifthDayOfNextMonth"

    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova PayIQ | Truckload | Dry Van 53'    | NA           | NA                |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | SysData=>SecondDayOfNextMonth  | NA   | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             |        Expected_Date          | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | SysData=>FifthDayOfNextMonth  |            NA            | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load_1L"

    #Step 8
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds

    # Step 9
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

    #Step 10
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds

    #Step 11
    Then Store date with month offset 1 and day 1 in format MMM d, yyyy into "FirstDayOfNextMonth"
    Then Store date with month offset 1 and day 3 in format MMM d, yyyy into "ThirdDayOfNextMonth"
    Then Update "1" Segment details
      |Search        |Driver                   |Load|
      |Tractor 1007  |Dave Fleet Carrier One 7 |SysData=>1L|
    Then Wait for "4" Seconds
    Then Update "1" leg details
      | Start Type | Location       |
      | Terminal   | Illinois Terminal |

    Then Update "1" leg details
      | Due Out Date  | Due Out Time   |Appointment Start Time|Appointment End Time|
      | SysData=>FirstDayOfNextMonth | 8:00 AM  |9:00 AM      |9:00 AM                      |

    Then Update "2" leg details
      |    Due Out Date      | Due Out Time  |Appointment Start Time|Appointment End Time|
      | SysData=>ThirdDayOfNextMonth  |   11:00 AM    |     10:00 AM         |  10:00 AM          |
    Then Wait for "1" Seconds

    #Step 12
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Store date with month offset 1 and day 4 in format MMM d, yyyy into "FourthDayOfNextMonth"
    Then Store date with month offset 1 and day 7 in format MMM d, yyyy into "SeventhDayOfNextMonth"
    #Step 13
    Then Update "1" leg details
      | Arrival Date |
      |SysData=>FourthDayOfNextMonth |
    #Step 14
    Then Update "2" leg details
      | Arrival Date |
      | SysData=>SeventhDayOfNextMonth  |
    Then Wait for "1" Seconds

     #Step 15
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "8" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 16
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."

    #Step 17
    Then Set Payroll "Next" Month Range on To "Next_Month_Range"
    Then Get Id from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 7 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Delete "rtms9__Pay_Header__c" with Id "PayHeaderID"
    Then Get Id from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1007" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Delete "rtms9__Pay_Header__c" with Id "PayHeaderID"

    #Step 18
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "7" Seconds
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 19
    Then Open "Pay Headers" from App Launcher
    #Step 20 & 21
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 7 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "4" Seconds
    Then Set Key "Pay_Header_SFID_1" page Record Id with "rtms9__Pay_Header__c"

    #Step 22
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Rate" as "$4.02"
    Then Wait for "3" Seconds
    #Step 23
    Then Go to "Logs" Tab
    Then Scroll into Section "PayIQ Logs"
    Then Click on "PayIQ Log-" with "Type" as "Currency Conversion"
    Then Wait for "5" Seconds

    #Step 24 Expected a
    Then Store date with month offset 1 and day 7 in format "yyyy-MM-dd" into "SeventhOfNextMonth"
    Then Get Details
      | Detail |
      |        |
    Then Set "Log1" with "[Calculation Amount] converted from USD to CAD (using dated exchange rate from " and "SysData=>SeventhOfNextMonth" and ") => 3 USD = 4.02 CAD"
    Then Verify Assertion for "Detail" contains "SysData=>Log1"

    #Step 25
    Then Open "Pay Headers" from App Launcher
    #Step 26
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 7 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

    #Step 27
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Rate" as "$2.01"

    #Step 28
    Then Go to "Logs" Tab
    Then Scroll into Section "PayIQ Logs"
    Then Click on "PayIQ Log-" with "Type" as "Currency Conversion"
    Then Wait for "5" Seconds

    #Step 29 & Expected b
    Then Store date with month offset 1 and day 7 in format "yyyy-MM-dd" into "SeventhOfNextMonth"
    Then Get Details
      | Detail |
      |        |
    Then Set "Log2" with "[Calculation Amount] converted from USD to CAD (using dated exchange rate from " and "SysData=>SeventhOfNextMonth" and ") => 1.5 USD = 2.01 CAD"
    Then Verify Assertion for "Detail" contains "SysData=>Log2"

    #Step 30
    Then Open "Pay Headers" from App Launcher
    #Step 31 & 32
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1007" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "5" Seconds
    Then Set Key "Pay_Header_SFID_2" page Record Id with "rtms9__Pay_Header__c"


    #Step 33
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Rate" as "$4.02"
    Then Wait for "2" Seconds
    #Step 34
    Then Go to "Logs" Tab
    Then Scroll into Section "PayIQ Logs"
    Then Click on "PayIQ Log-" with "Type" as "Currency Conversion"
    Then Wait for "5" Seconds

    #Step 35 & Expected c
    Then Store date with month offset 1 and day 4 in format "yyyy-MM-dd" into "FourthOfNextMonth"
    Then Get Details
      | Detail |
      |        |
    Then Set "Log3" with "[Calculation Amount] converted from USD to CAD (using dated exchange rate from " and "SysData=>FourthOfNextMonth" and ") => 3 USD = 4.02 CAD"
    Then Verify Assertion for "Detail" contains "SysData=>Log3"

    #Step 36
    Then Open "Pay Headers" from App Launcher
    #Step 37
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1007" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

    #Step 38
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Rate" as "$2.01"
    Then Wait for "3" Seconds
    #Step 39
    Then Go to "Logs" Tab
    Then Scroll into Section "PayIQ Logs"
    Then Click on "PayIQ Log-" with "Type" as "Currency Conversion"
    Then Wait for "5" Seconds

    #Step 40 & Expected d
    Then Store date with month offset 1 and day 7 in format "yyyy-MM-dd" into "SeventhOfNextMonth"
    Then Get Details
      | Detail |
      |        |
    Then Set "Log4" with "[Calculation Amount] converted from USD to CAD (using dated exchange rate from " and "SysData=>SeventhOfNextMonth" and ") => 1.5 USD = 2.01 CAD"
    Then Verify Assertion for "Detail" contains "SysData=>Log4"
