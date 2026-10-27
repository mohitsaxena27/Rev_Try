Feature:2928 - Pay Advance - Driver - Flat Amount

  @API @Regression @PayIQ @WEB @MultiCurrency @2928 @PayAdvance
  Scenario: 2928 - Pay Advance - Driver - Flat Amount

    When Login into Salesforce
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "Pay Header-" for "rtms9__Pay_Header__c"
    Then Delete All Records with "rtms9__Participant_Name__c" as "Dave Fleet Carrier One 7 (Driver)" for "rtms9__Pay_Header__c"
    Then Delete All Records with "rtms9__Participant_Name__c" as "Tractor 1007 (Fleet Asset)" for "rtms9__Pay_Header__c"


    Then Store date with month offset 0 and day 18 in format "M/d/yyyy" into "Current_Month_18"
    Then Store date with month offset 0 and day 21 in format "M/d/yyyy" into "Current_Month_21"
    Then Store date with month offset 1 and day 2 in format "M/d/yyyy" into "Next_Month_2"
    Then Store date with month offset 1 and day 3 in format "M/d/yyyy" into "Next_Month_3"

    #Step 1
    Then Open "Pay Advances" from App Launcher
    Then Wait for "2" Seconds
    Then Capture the current URL for "Pay_Advance_Page"
    Then Click on button with Title "New"
    Then Update details
      | Transaction Date          | Category | Type          | Payee Type | Driver                   | Qty | Rate | Adjustment Plan |
      | SysData=>Current_Month_18 | Addition | Tire Purchase | Driver     | Dave Fleet Carrier One 7 | 2   | 5    | Flat Amount     |

    #Step 2
    Then Click on "Save" with Text
    Then Wait for "3" Seconds
    Then Get Details
      | Pay Advance ID |
      |                |
    Then Set "Pay_Advance_1" with "SysData=>Pay Advance ID"
    Then Set Key "Pay_Advance_SFID1" page Record Id with "rtms9__Pay_Advance__c"
    Then Capture the current URL for "PayAdvance1_Url"
    Then Navigate to stored URL for "Pay_Advance_Page"
    Then Wait for "3" Seconds
    Then Click on button with Title "New"

    #Step 3
    Then Update details
      | Transaction Date          | Category  | Type          | Payee Type  | Fleet Asset  | Qty | Rate | Adjustment Plan |
      | SysData=>Current_Month_21 | Deduction | Fuel Purchase | Fleet Asset | Tractor 1007 | 2   | 3    | Flat Amount     |
   Then Wait for "2" Seconds
    Then Update details
        |Wait For Next Period To Begin Adjusting |
        |True                                    |
    #Step 4
    Then Click on "Save" with Text
    Then Wait for "3" Seconds
    Then Get Details
      | Pay Advance ID |
      |                |
    Then Set "Pay_Advance_2" with "SysData=>Pay Advance ID"
    Then Wait for "3" Seconds
    Then Set Key "Pay_Advance_SFID2" page Record Id with "rtms9__Pay_Advance__c"
    Then Capture the current URL for "PayAdvance2_Url"

    #Step 5 & 6
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Driver Pay - Per Mile" from List
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
    Then Wait for "3" Seconds

    #Step 7 & 8
    Then Scroll Until Related List for "Roles"
    Then Click on "Role-" with "Lookup Type" as "Fleet Asset" and "Eligible Date Field" as "Arrival Date"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Eligible Date Field"
    Then Update details
      | Eligible Date Field   |
      | Last Leg Arrival Date |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Eligible Date Field   |
      | Last Leg Arrival Date |
    Then Capture the current URL for "Roles_Page"

    #Step 9 - 18
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Search       | Driver                   | Load  |
      | Tractor 1007 | Dave Fleet Carrier One 7 | PIQ-0 |
    Then Wait for "4" Seconds
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "5" Seconds
    Then Update "1" leg details
      | Due Out Date              | Due Out Time | Appointment Date          | Appointment Start Time | Appointment End Time |
      | SysData=>Current_Month_18 | 8:00 AM      | SysData=>Current_Month_21 | 10:00 AM               | 10:00 AM             |
    Then Wait for "2" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date              | Departure Date            |
      | SysData=>Current_Month_18 | SysData=>Current_Month_21 |
    Then Click on button with Title "Save"
    Then Verify Text displaying as "Save was successful." -
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 19
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "10" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "15" Seconds

    #Step 20 & 21
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 7 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Open "Pay Headers" from App Launcher
    Then Search and Select "SysData=>PayHeaderID" from List
     #Step 22 #expected result a
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Addition" and "Type" as "Other"
    Then Wait for "2" Seconds
    Then Verify Details
      | Category | Source                 | Type  | Qty  | Rate      |
      | Addition | SysData=>Pay_Advance_1 | Other | 1.00 | USD 10.00 |

    #Step 23 & 24
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1007 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Open "Pay Headers" from App Launcher
    Then Search and Select "SysData=>PayHeaderID" from List
     #Step 25 #expected result b
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify "Pay Adjustments" count displaying as "0"

    #Step 26
    Then Navigate to stored URL for "PayAdvance1_Url"
    Then Wait for "3" Seconds
    #Step 27 & Expected Result c
    Then Scroll into Section "Financials"
    Then Verify Details
      | Paid Amount | Remaining Balance |
      | USD 10.00       | USD 0.00              |

    #Step 28
    Then Navigate to stored URL for "PayAdvance2_Url"

    Then Wait for "3" Seconds
    #Step 29 & Expected Result d
    Then Scroll into Section "Financials"
    Then Verify Details
      | Paid Amount     | Remaining Balance |
      | USD 0.00        | USD -6.00             |

    #Step 30
    Then Open "Fleet Management Console" from App Launcher
    Then Fleet Management Console - Wait for Page Load
    #Step 31
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Wait for "2" Seconds
    #Step 32
    Then Update details
      |Trip Plan(s)|
      |SysData=>Trip_Plan_ID       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    #Step 33
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -
    #Step 34
    Then Click on "Add Leg Below" on "1" Leg
    #Step 35
    Then Update "2" leg details
      | Due Out Date              | Due Out Time | End Type | Location_2       | Appointment Date      | Appointment Start Time | Appointment End Time |
      | SysData=>Current_Month_21 | 11:00 AM     | Location | Baltimore Ravens | SysData=>Next_Month_3 | 10:00 AM               | 10:00 AM             |
    #Step 36
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    #Step 37
    Then Update "2" leg details
      | Arrival Date          | Departure Date        |
      | SysData=>Next_Month_2 | SysData=>Next_Month_3 |
    #Step 38
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 39
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "15" Seconds

    #Step 40 - 42, expected e
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Next" Month Range on To "Next_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 7 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify "Pay Adjustments" count displaying as "0"

    #Step 43 - 45, expected f
    Then Open "Pay Headers" from App Launcher
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1007 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other"
    Then Wait for "2" Seconds
    Then Verify Details
      | Category  | Source                 | Type  | Qty  | Rate     |
      | Deduction | SysData=>Pay_Advance_2 | Other | 1.00 | USD 6.00 |

    #Step 46
    Then Navigate to stored URL for "PayAdvance1_Url"
    Then Wait for "3" Seconds
    #Step 47 #Expected g
    Then Scroll into Section "Financials"
    Then Verify Details
      | Paid Amount | Remaining Balance |
      | USD 10.00       | USD 0.00              |

    #Step 48
    Then Navigate to stored URL for "PayAdvance2_Url"
    Then Wait for "3" Seconds
    #Step 49 #Expected h
    Then Scroll into Section "Financials"
    Then Verify Details
      | Paid Amount | Remaining Balance |
      | USD -6.00       |USD 0.00              |
