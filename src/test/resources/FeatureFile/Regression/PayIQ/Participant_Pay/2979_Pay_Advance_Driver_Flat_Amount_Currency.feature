Feature:2979 - Pay Advance- Driver- Flat Amount- Currency
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2979
  Scenario: 2979 - Pay Advance- Driver- Flat Amount- Currency
    When Login into Salesforce

    #Step 1
    Then Open "Pay Advances" from App Launcher
    Then Click on "New" with Text
    Then Store date with month offset 0 and day 18 in format MMM d, yyyy into "EighteenOfCurrentMonth"
    Then Update details
      |Transaction Date|Category|Type             |Currency              |Payee Type |Driver                  |Qty|Rate|Adjustment Plan|
      |SysData=>EighteenOfCurrentMonth|Addition|Tire Purchase    | CAD - Canadian Dollar|Driver     |Dave Fleet Carrier One 7|2   |5  |Flat Amount|
    Then Click on "SaveEdit" button on Details Page
    Then Verify Message displaying as "Pay Advance-"
    Then Wait for "4" Seconds
    Then Set Key "Pay_Advance_SFID_1" page Record Id with "rtms9__Pay_Advance__c"
    #Step 2
   Then Get Details
    |Pay Advance ID|
    |              |

    #Step 3,4
    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "PayIQProgram Driver Pay - Per Mile" from Search List

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

    #Step 5,6,7
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 8
    Then Update "1" Segment details
      | Search       | Driver                   | Load |
      | Tractor 1007 | Dave Fleet Carrier One 7 | PIQ-0   |
    Then Wait for "5" Seconds

    #Step 9
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

     #Step 10
    Then Store date with month offset 0 and day 21 in format MMM d, yyyy into "TwentyFirstOfCurrentMonth"
    Then Update "1" leg details
      | Appointment Date | Appointment Start Time | Appointment End Time |Due Out Date |Due Out Time |
      | SysData=>TwentyFirstOfCurrentMonth            | 10:00 AM                | 10:00 AM              |SysData=>EighteenOfCurrentMonth    |8:00 AM      |

  #Step 11,12
    Then Wait for "2" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date                               | Departure Date |
      | SysData=>EighteenOfCurrentMonth            | SysData=>TwentyFirstOfCurrentMonth|

    #Step 13
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds

    #Step 14
    Then Click on button with Title "Close"

    #Step 15
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #step 16,17
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 7 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "3" Seconds
    Then Set Key "Pay_Header_SFID_1" page Record Id with "rtms9__Pay_Header__c"

    #Step 18 and expected result a
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Addition" and "Type" as "Other"
    Then Verify Details
      |Category|    Type |Qty |Rate    |Source|
      | Addition|Other|1.00|USD 7.46 |SysData=>Pay Advance ID |
