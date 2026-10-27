Feature:2778 - PaySettlementPDF VFP- Format

  @API @Regression @PayIQ  @WEB @SingleCurrency @2778
  Scenario: 2778 - PaySettlementPDF VFP- Format

    When Login into Salesforce

    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"

    # Step 1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds

    # Step 2
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    # Step 3 & 4
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Search       | Driver                   | Load  |
      | Tractor 1008 | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "5" Seconds

    # Step 5
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

    # Step 6
    Then Store date with month offset 0 and day 18 in format MMM d, yyyy into "Due_date"
    Then Store date with month offset 0 and day 21 in format MMM d, yyyy into "Appointment_date"
    Then Update "1" leg details
      | Due Out Date      | Due Out Time |
      | SysData=>Due_date | 1:00 AM      |
    Then Update "1" leg details
      | Appointment Date          | Appointment Start Time | Appointment End Time |
      | SysData=>Appointment_date | 10:00 AM               | 10:00 AM             |

    # Step 7
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    # Step 8
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    # Step 9
    Then Update "1" leg details
      | Arrival Date      | Departure Date    |
      | SysData=>Due_date | SysData=>Due_date |
    Then Wait for "3" Seconds

    # Step 10
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    # Step 11
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds

    # Step 12
    Then Update "1" leg details
      | Accessorial     | Unit       | Quantity | Unit Price | Payable |
      | Blind Shipments | Fixed Cost | 1.00     | 10.00      | True    |

    # Step 13
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."

    # Step 14 & 15
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List
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

    # Step 16
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-0" from List
    Then Capture the current URL for "Load"
    Then Store date with month offset 0 and day 18 in format "M/d/yyyy" into "Eligible_date"
    Then Click on Edit icon on Label "Custom PayIQ Eligible Date"
    Then Update details
      | Custom PayIQ Eligible Date |
      | SysData=>Eligible_date     |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

    # Step 17
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 18 & 19
    Then Open "Pay Headers" from App Launcher
    Then Wait for "2" Seconds
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ (Contact)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

    # Step 20
    Then Get Details
      | Start Date | End Date | Contact | Grand Total | Total Pay | Total Additions | Total Deductions |
      |            |          |         |             |           |                 |                  |
    Then extract the numeric value from "SysData=>Total Pay" and store in "Total_Pay"
    Then extract the numeric value from "SysData=>Total Additions" and store in "Total_Addition"
    Then extract the numeric value from "SysData=>Total Deductions" and store in "Total_Deductions_1"
    Then extract the numeric value from "SysData=>Grand Total" and store in "Grand_Total"
    Then Capture the current URL for "Page_Header_Page"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Addition"
    Then Get Details
      | Category | Description | Rate | Qty | Item Total | Transaction Date |
      |          |             |      |     |            |                  |

    #Step 21
    Then Navigate to stored URL for "Page_Header_Page"
    Then Click on button "View Pay Settlement"
    Then Wait for "8" Seconds
    Then Navigate to stored URL for "Page_Header_Page"
    Then Wait for "2" Seconds
    Then Set Key "GetElementID" page Record Id with "rtms9__Pay_Header__c"
    Then Get Pdf content from "Visual Force" with Subject "Pay Settlement.pdf"

    #Expected a(a)
    Then Validate PDF logo matching with "RevenovaTMS_Logo.png"

    #Expected a(b)
    Then Verify Pdf contains "Revenova HQ"
    Then Verify Pdf contains "2333 Waukegan Rd."
    Then Verify Pdf contains "Bannockburn, IL 60015"

    #Expected a(c)
    Then Set First date of month into "Start_Date" in format "MM-dd-yyyy"
    Then Set Last date of month into "End_Date" in format "MM-dd-yyyy"
    Then Set "Start" with "Period Start: " and "SysData=>Start_Date"
    Then Set "End" with "Period End: " and "SysData=>End_Date"
    Then Verify Pdf contains "Pay Settlement"
    Then Verify Pdf contains "SysData=>Start"
    Then Verify Pdf contains "SysData=>End"

    #Expected a(d)
    Then extract the numeric value from "SysData=>Grand Total" and store in "Total"
    Then Set "Grand total" with "$" and "SysData=>Total" and " (USD)"
    Then Verify Pdf contains "Joe Revenova PayIQ"
    Then Verify Pdf contains "Revenova PayIQ"
    Then Verify Pdf contains "2333 Waukegan Rd."
    Then Verify Pdf contains "Bannockburn, IL 60015"
    Then Verify Pdf contains "Total Pay:"
    Then Verify Pdf contains "Total Additions:"
    Then Verify Pdf contains "Total Deductions:"
    Then Verify Pdf contains "Grand Total:"
    Then Verify Pdf contains "SysData=>Grand total"

    #Expected a(e)
    Then Verify Pdf contains "LOADS"
    Then Verify Pdf contains "LOAD"
    Then Verify Pdf contains "ORIGIN"
    Then Verify Pdf contains "DESTINATION"
    Then Verify Pdf contains "TYPE"
    Then Verify Pdf contains "RATE"
    Then Verify Pdf contains "QTY"
    Then Verify Pdf contains "TOTAL"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Margin (Quoted - Sliding Scale) 10% sliding to $49.00 $50.00 $5.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Amount per Load $2.00 - $2.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Margin with Max (Quoted) 10% (max $49.00) $50.00 $5.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Revenue (Quoted) 10% $100.00 $10.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Margin with Min (Quoted) 10% (min $26.00) $50.00 $26.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Margin (Quoted) 10% $50.00 $5.00"
    Then Verify Pdf contains "Total Adjusted Load Pay:"
    Then Set "Total" with "$" and "SysData=>Total_Pay"
    Then Verify Pdf contains "SysData=>Total"

    #Expected a(f)
    Then extract the numeric value from "SysData=>Rate" and store in "Rate1"
    Then extract the numeric value from "SysData=>Item Total" and store in "Total"
    Then Set "Final_Rate" with "$" and "SysData=>Rate1"
    Then Set "Final_Total" with "$" and "SysData=>Total"
    Then Set "Total Additions" with "$" and "SysData=>Total_Addition"
    Then Set "Total Deductions" with "$" and "SysData=>Total_Deductions_1"
    Then Set "Total Deductions" with "$" and "SysData=>Total_Deductions"
    Then Calculate value by "Add" "SysData=>Total_Addition" and "SysData=>Total_Deductions_1" and store in "Total Other Adjustments"
    Then Set "Total_Other_Adjustments" with "$" and "SysData=>Total Other Adjustments"
    Then swap $ and - from "SysData=>Total_Other_Adjustments" and store in "Total_Other_Adjustments_Final"
    Then Verify Pdf contains "OTHER ADJUSTMENTS"
    Then Verify Pdf contains "CATEGORY"
    Then Verify Pdf contains "TYPE"
    Then Verify Pdf contains "RATE"
    Then Verify Pdf contains "QTY"
    Then Verify Pdf contains "TOTAL"
    Then Verify Pdf contains "DATE"
    Then Verify Pdf contains "REMAINING BAL"
    Then Verify Pdf contains "SysData=>Description"
    Then Verify Pdf contains "SysData=>Category"
    Then Verify Pdf contains "SysData=>Final_Total"
    Then Verify Pdf contains "SysData=>Total Additions"
    Then Verify Pdf contains "SysData=>Total_Deductions_2"
    Then Verify Pdf contains "1"
    Then Verify Pdf contains "SysData=>Total_Other_Adjustments_Final"

    #Step 22 & 23
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID2"
    Then Go to Home Page
    Then Open "Pay Headers" from App Launcher
    Then Search and Select "SysData=>PayHeaderID2" from List
    Then Capture the current URL for "Page_Header_Page2"

    #Step 24
    Then Click on button "View Pay Settlement"
    Then Wait for "8" Seconds
    Then Navigate to stored URL for "Page_Header_Page2"
    Then Wait for "2" Seconds
    Then Set Key "GetElementID" page Record Id with "rtms9__Pay_Header__c"
    Then Get Pdf content from "Visual Force" with Subject "Pay Settlement.pdf"

    #Expected b
    Then Verify Pdf contains "Dave Fleet Carrier One 8"
    Then Verify Pdf contains "Fleet Carrier One"
    Then Verify Pdf contains "203 West Jackson Boulevard"
    Then Verify Pdf contains "Chicago, IL 60606"
    Then Verify Pdf contains "LOAD / LEG"
    Then Verify Pdf contains "PIQ-0"
    Then Verify Pdf contains "Leg 1"

    #Step 25 & 26
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1008 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID3"
    Then Go to Home Page
    Then Open "Pay Headers" from App Launcher
    Then Search and Select "SysData=>PayHeaderID3" from List
    Then Capture the current URL for "Page_Header_Page3"

    #Step 27
    Then Click on button "View Pay Settlement"
    Then Wait for "8" Seconds
    Then Navigate to stored URL for "Page_Header_Page3"
    Then Wait for "2" Seconds
    Then Set Key "GetElementID" page Record Id with "rtms9__Pay_Header__c"
    Then Get Pdf content from "Visual Force" with Subject "Pay Settlement.pdf"

    #Expected c
    Then Verify Pdf contains "Fleet Carrier One"
    Then Verify Pdf contains "203 West Jackson Boulevard"
    Then Verify Pdf contains "Chicago, IL 60606"
    Then Verify Pdf contains "Tractor 1008"
    Then Verify Pdf contains "LOAD / LEG"
    Then Verify Pdf contains "PIQ-0"
    Then Verify Pdf contains "Leg 1"

    #Step 28 & 29
    Then Go to Home Page
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User (User)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID4"
    Then Search and Select "SysData=>PayHeaderID4" from List

    Then Get Details
      | Start Date | End Date | Contact | Grand Total | Total Pay |
      |            |          |         |             |           |
    Then extract the numeric value from "SysData=>Total Pay" and store in "Total_Pay"
    Then extract the numeric value from "SysData=>Grand Total" and store in "Grand_Total"
    Then Capture the current URL for "Page_Header_Page4"
    Then Scroll Until Related List for "Pay Adjustments"

    #Step 30
    Then Navigate to stored URL for "Page_Header_Page4"
    Then Click on button "View Pay Settlement"
    Then Wait for "8" Seconds
    Then Navigate to stored URL for "Page_Header_Page4"
    Then Wait for "2" Seconds
    Then Set Key "GetElementID" page Record Id with "rtms9__Pay_Header__c"
    Then Get Pdf content from "Visual Force" with Subject "Pay Settlement.pdf"

    #Expected d(a)
    Then Validate PDF logo matching with "RevenovaTMS_Logo.png"

    #Expected d(b)
    Then Verify Pdf contains "Revenova HQ"
    Then Verify Pdf contains "2333 Waukegan Rd."
    Then Verify Pdf contains "Bannockburn, IL 60015"

    #Expected d(c)
    Then Set First date of month into "Start_Date" in format "MM-dd-yyyy"
    Then Set Last date of month into "End_Date" in format "MM-dd-yyyy"
    Then Set "Start" with "Period Start: " and "SysData=>Start_Date"
    Then Set "End" with "Period End: " and "SysData=>End_Date"
    Then Verify Pdf contains "Pay Settlement"
    Then Verify Pdf contains "SysData=>Start"
    Then Verify Pdf contains "SysData=>End"

    #Expected d(d)
    Then extract the numeric value from "SysData=>Grand Total" and store in "Total"
    Then Set "Grand total" with "$" and "SysData=>Total" and " (USD)"
    Then Verify Pdf contains "User User"
    Then Verify Pdf contains "Total Pay:"
    Then Verify Pdf contains "Total Additions:"
    Then Verify Pdf contains "Total Deductions:"
    Then Verify Pdf contains "Grand Total:"
    Then Verify Pdf contains "SysData=>Grand total"

    #Expected d(e)
    Then Verify Pdf contains "LOADS"
    Then Verify Pdf contains "LOAD"
    Then Verify Pdf contains "ORIGIN"
    Then Verify Pdf contains "DESTINATION"
    Then Verify Pdf contains "TYPE"
    Then Verify Pdf contains "RATE"
    Then Verify Pdf contains "QTY"
    Then Verify Pdf contains "TOTAL"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Margin (Quoted - Sliding Scale) 10% sliding to $49.00 $50.00 $5.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Amount per Load $2.00 - $2.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Margin with Max (Quoted) 10% (max $49.00) $50.00 $5.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Revenue (Quoted) 10% $100.00 $10.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Margin with Min (Quoted) 10% (min $26.00) $50.00 $26.00"
    Then Verify Pdf contains "PIQ-0 Bannockburn, Illinois Owings, Maryland Percent of Load Margin (Quoted) 10% $50.00 $5.00"
    Then Verify Pdf contains "Total Adjusted Load Pay:"
    Then Set "Total" with "$" and "SysData=>Total_Pay"
    Then Verify Pdf contains "SysData=>Total"

    #Expected d(f)
    Then Verify Pdf not contains "OTHER ADJUSTMENTS"
