Feature:2900 - Pay Estimate- CopyOverPayEstimateAdjustmentsJob

  @API @Regression @PayIQ  @WEB @SingleCurrency @2900 @PayHeader
  Scenario: 2900 - Pay Estimate- CopyOverPayEstimateAdjustmentsJob

    When Login into Salesforce

    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    #Step 2
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

    #Step 3
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Fleet Asset" and "Name" as "Tractor 1008"
    Then Wait for "2" Seconds

    #Step 4 & 5
    Then Click on Edit icon on Label "Allow Pay Estimates"
    Then Update details
      | Allow Pay Estimates | Pay Off Load Instead of Trip Plan Leg|
      | True                | False                                  |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | Allow Pay Estimates |Pay Off Load Instead of Trip Plan Leg|
      | True                |False                                  |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"

    #step 6 & 7
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds

    #Step 8 & 9
    Then Click on Edit icon on Label "Allow Pay Estimates"
    Then Update details
      | Allow Pay Estimates | Pay Off Load Instead of Trip Plan Leg|
      | True                | True                                  |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | Allow Pay Estimates |Pay Off Load Instead of Trip Plan Leg|
      | True                |True                                  |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_2"
    Then Navigate Browser Back

    #Step 10
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load

    #Step 11 & 12
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 13
    Then Update "1" Segment details
      | Search       | Driver                   | Load  |
      | Tractor 1008 | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "5" Seconds

    #Step 14
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

    #Step 15 & 16
    Then Store date with month offset 0 and day 15 in format MMM d, yyyy into "FifteenOfCurrentMonth"
    Then Store date with month offset 0 and day 18 in format MMM d, yyyy into "EighteenOfCurrentMonth"
    Then Update "1" leg details
      | Appointment Date                | Appointment Start Time | Appointment End Time | Due Out Date                   | Due Out Time |
      | SysData=>EighteenOfCurrentMonth | 10:00 AM               | 10:00 AM             | SysData=>FifteenOfCurrentMonth | 8:00 AM      |

    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds

    #Step 17
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 18
    Then Update "1" leg details
      | Arrival Date                   | Departure Date                  |
      | SysData=>FifteenOfCurrentMonth | SysData=>EighteenOfCurrentMonth |

    #Step 19
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying with "Plan Trip Save was successful."
    Then Close All Toast message

    #Step 20
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 21
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    #Step 22 & 23
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Header1"
    

    #Step 24
    Then Open "Pay Headers" from App Launcher
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1008 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"

    #Step 25 & 26
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Header2"

    #Step 27
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load

    #Step 28
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 29 & 30

    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      | Trip Plan Start Date |
      | This Month           |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "6" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -
    Then Wait for "6" Seconds
    #Step 31
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "20" Seconds

    # Step 32
    Then Update Estimated Pay Amount "2.00" to "200.00" in Section "Dave Fleet Carrier One 8"

    # Step 33
    Then Update Estimated Pay Amount "26.00" to "2.60" in Section "Dave Fleet Carrier One 8"

    # Step 34
    Then Update Estimated Pay Amount "10.00" to "0.00" in Section "Dave Fleet Carrier One 8"

    #Step 35
    Then Get "Estimated Pay Amount" value from Estimated Pay Section "Tractor 1008" into "Estimated_Pay_Amount_Tractor"
    Then Update Estimated Pay Amount "SysData=>Estimated_Pay_Amount_Tractor" to "300.00" in Section "Tractor 1008"

    #Step 36
    Then Click Estimated Pay button with Title "Save & Close" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."

    #Step 37
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."

#    Step 38
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 39 & expected a
    Then Navigate to stored URL for "Pay_Header1"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on link "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Store current date in format "M/d/yyyy" into "Today"
    Then Verify "Pay Adjustments" Table Details
      | Category  | Type  | Qty  | Rate       | Item Total | Transaction Date | Status  |
      | Addition  | Other | 1.00 | USD 198.00 | USD 198.00 | SysData=>Today   | Pending |
      | Deduction | Other | 1.00 | USD 23.40  | USD -23.40 | SysData=>Today   | Pending |
      | Deduction | Other | 1.00 | USD 10.00  | USD -10.00 | SysData=>Today   | Pending |

    #Step 40 & 41
    Then Navigate to stored URL for "Pay_Header2"
    Then Wait for "2" Seconds

    #Step 42 & expected b
    Then Click on link "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Calculate value "-300" from existing value "SysData=>Estimated_Pay_Amount_Tractor" and store in "Rate"
    Then Set "Rate_Formatted" with "USD " and "SysData=>Rate"
    Then Set "Rate_Formatted2" with "USD " and "-" and "SysData=>Rate"
    Then Verify Table With Header
      | Category  | Source               | Type  | Qty  | Rate                    | Item Total               | Transaction Date | Status  |
      | Deduction | Pay Estimate Detail- | Other | 1.00 | SysData=>Rate_Formatted | SysData=>Rate_Formatted2 | SysData=>Today   | Pending |