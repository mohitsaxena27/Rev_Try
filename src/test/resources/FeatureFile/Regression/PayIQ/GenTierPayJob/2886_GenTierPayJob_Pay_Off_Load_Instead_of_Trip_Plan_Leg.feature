Feature: 2886 - GenTierPayJob- Pay Off Load Instead of Trip Plan Leg

  @API @Regression @PayIQ  @WEB @SingleCurrency @2886 @GenTierPayJob
  Scenario: 2886 - GenTierPayJob- Pay Off Load Instead of Trip Plan Leg

    When Login into Salesforce

    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"
    #Step 1
    Then Open "PayIQ Programs" from App Launcher

    #Step 2
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    #Step 3
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Open|
    Then Click on "SaveEdit" button
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 4
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Bruce Fleet Carrier Two 8"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Pay Off Load Instead of Trip Plan Leg"
    Then Wait for "2" Seconds
    Then Update details
      |Pay Off Load Instead of Trip Plan Leg|
       |True                                 |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Pay Off Load Instead of Trip Plan Leg|
      |True                                 |
    Then Wait for "2" Seconds
    Then Capture the current URL for "Participant_1"
    Then Set Key "Participants_SFID_1" page Record Id with "rtms9__Participant__c"

    #Step 5
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile" and "From (>)" as "0.00" and "To (<=)" as ""
    Then Wait for "3" Seconds
    Then Capture the current URL for "Calculation_Tier_URL"

    #Step 6
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-32" from List
    Then Wait for "3" Seconds
    Then Set Key "Load_ID" page Record Id with "rtms__Load__c"
    Then Get "rtms__Expected_Ship_Date2__c" from "rtms__Load__c" using "Id" with value "SysData=>Load_ID" and Store onto "ShipMonth"
    Then Capture the current URL for "Load_Page"

    #Step 7
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

   #Step 8
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan"

    #Step 9 & 10
    Then Convert "SysData=>ShipMonth" in "MM/dd/yyyy" format into "Ship_Date"

    Then Update "1" Segment details
      | Search       | Driver                     | Load         |
      | Tractor 1010 | Dave Fleet Carrier One 8 |PIQ-33   |
    Then Wait for "5" Seconds

    Then Update "1" leg details
      | Start Type | Location       |
      | Location   |  New England Patriots |

    Then Update "1" leg details
    |Due Out Date |Due Out Time|
    |SysData=>Ship_Date|6:30 AM|
    Then Wait for "2" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date |
      | SysData=>Ship_Date |
    Then Click on "Add Driver" on "1" Segment
    Then Wait for "3" Seconds
    Then Update "1" Segment details
      | Driver_2                                          |
      |  Bruce Fleet Carrier Two 8 |
    #Step 9
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

   #Step 10
    Then Click on button with Title "Close"

    #Step 13
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Wait for "2" Seconds
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 14
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 15
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Participant Matches"
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds

    #Step 16 and expected result a
    Then Set "MatchedTo" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Verify "Participant Matches" Table Details
      |Participant Name                  |Matched To Type|Matched To|
      |Bruce Fleet Carrier Two 8 (Driver)| Load          |PIQ-33    |
      |Dave Fleet Carrier One 8 (Driver)|Trip Plan Leg   |SysData=>MatchedTo|

    #Step 17
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 18
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan(s)|
      |SysData=>Trip_Plan_ID       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    #Step 19
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -
    

     
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -
    Then Wait for "2" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 20
    Then Update "1" leg details
       |  Departure Date |
      |SysData=>Ship_Date|
    Then Store date 3 days after stored date "SysData=>ShipMonth" in format "MMM d, yyyy" into "ThreeDaysAfterShipMonth"
    Then Update "2" leg details
      | Arrival Date|
      |SysData=>ThreeDaysAfterShipMonth|
    Then Click on button with Title "Save & Close"
    Then Wait for "5" Seconds

    #Step 21
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 22
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 23
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 24
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Participant Matches"
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds

    #Step 25 and expected result b
    Then Set "MatchedTo" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Verify "Participant Matches" Table Details
      |Participant Name                  |Matched To Type|Matched To|
      |Dave Fleet Carrier One 8 (Driver)| Trip Plan Leg        |SysData=>MatchedTo   |

   #Step 26
    #Step 27
    Then Navigate to stored URL for "Calculation_Tier_URL"
    Then Wait for "2" Seconds
    #Step 28 and expected result c
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Verify table with "Pay Detail ID" as "Pay Detail-" does not have "Participant Name" as "Bruce Fleet Carrier Two 8 (Driver)"

   #Step 29
    Then Navigate to stored URL for "Load_Page"
    Then Wait for "2" Seconds
    #Step 30 and expected result d
    Then Scroll Until Related List for "Participant Matches"
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Participant Name" as "Dave Fleet Carrier One 8 (Driver)"




