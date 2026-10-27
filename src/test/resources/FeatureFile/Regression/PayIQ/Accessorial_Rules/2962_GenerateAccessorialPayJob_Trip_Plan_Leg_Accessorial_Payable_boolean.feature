Feature: 2962 - GenerateAccessorialPayJob- Trip Plan Leg Accessorial- Payable boolean

  @API @Regression @PayIQ  @WEB @SingleCurrency @2962
  Scenario: 2962 - GenerateAccessorialPayJob- Trip Plan Leg Accessorial- Payable boolean

    When Login into Salesforce

    #Step 1
    Then Store date with month offset 0 and day 3 in format MMM d, yyyy into "3rdDayOfCurrentMonth"
    Then Store date with month offset 0 and day 4 in format MMM d, yyyy into "4thDayOfCurrentMonth"

    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds

    #Step 2 and 3
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

   # Step 4
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Driver                    |
      | Dave Fleet Carrier One 8 |
    Then Wait for "5" Seconds

    #Step 5
    Then Update "1" leg details
      | Start Type | Location       |
      | Terminal   | Illinois Terminal |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | SysData=>3rdDayOfCurrentMonth      | 8:00 AM      |
    Then Update "1" leg details
      |End Type|Location_2|
      |Location|Indianapolis Colts|
    Then Update "1" leg details
      |Appointment Date |Appointment Start Time |Appointment End Time|
      |SysData=>4thDayOfCurrentMonth               | 10:00 AM               | 10:00 AM               |

    #Step 6
    Then Click on button with Title "Save"
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds
    #Step 7
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Accessorial     | Unit   | Quantity | Unit Price |Payable_2|
      | Blind Shipments | Fixed Cost| 4.00   | 308.64      | False  |
    Then Wait for "1" Seconds
    #Step 8
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 9
    Then Update "1" leg details
      | Arrival Date |
      | SysData=>3rdDayOfCurrentMonth|

    #Step 10
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    #Step 11
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List
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

    #Step 12
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "6" Seconds

    #Step 13, 14, 15
#    Then Open "Pay Headers" from App Launcher
#    #Step 14
#    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
#    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
#    Then Search and Select "SysData=>PayHeaderID" from List
#
#    #Step 15
#    Then Scroll Until Related List for "Pay Details"
#    Then Click on link "Pay Details"
#    Then Wait for "2" Seconds

    #Expected Result a)
    Then Set "PaidFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Paid_From__c" with value "SysData=>PaidFrom" & "rtms9__Accessorial__c" with value "Blind Shipments" and Store into "Actual"
    Then Verify Assertion for "Actual_count" contains "0"


    #Step 16 and 17
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds

    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 18
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan Start Date|
      |This Month      |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    #Step 19
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 20
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds

    #Step 21
    Then Update "1" leg details
      |Payable_2|
      |True     |
    Then Wait for "5" Seconds
    Then Update "1" leg details
      | Unit Price |
      | 308.64      |

    #Step 22
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    #Step 23
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "6" Seconds
    #Step 24
    Then Open "Pay Headers" from App Launcher

    #Step 25
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    #Step 26
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    #Expected Result b)
    Then Set "PaidFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Verify "Pay Details" Table Details
      |Type|Rate|Qty| Paid From           | Accessorial |
      |Blind Shipments|$308.64|4| SysData=>PaidFrom  |  Blind Shipments|