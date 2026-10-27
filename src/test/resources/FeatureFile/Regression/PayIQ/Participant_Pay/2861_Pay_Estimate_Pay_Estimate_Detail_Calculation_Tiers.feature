Feature:2861 - Pay Estimate- Pay Estimate Detail- Calculation Tiers

  @API @Regression @PayIQ  @WEB @SingleCurrency @2861 @PayHeader
  Scenario: 2861 - Pay Estimate- Pay Estimate Detail- Calculation Tiers

    When Login into Salesforce
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "Pay Estimate Detail-" for "rtms9__Pay_Estimate_Detail__c"

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
    Then Scroll Until Related List for "Calculation Tiers"
    Then Click on "Calculation Tier-" with "Criteria Description" as "Individual Driver Log (Driving Distance)/Trip Plan Leg Distance (Miles)"
    Then Wait for "4" Seconds
    Then Capture the current URL for "CalculationTierURL"

    #Step 3
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Participants"
    Then Get "Participant-" Name with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8" and store in "Participant_1"
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds

    #Step 4
    Then Click on Edit icon on Label "Allow Pay Estimates"
    Then Update details
      |Allow Pay Estimates|
      |True |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Allow Pay Estimates|
      |True |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"

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
      | Tractor 1008 | Dave Fleet Carrier One 8 | PIQ-0   |
    Then Wait for "5" Seconds

    #Step 9
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

     #Step 10
    Then Update "1" leg details
      | Appointment Date | Appointment Start Time | Appointment End Time |Due Out Date |Due Out Time |
      | 2                | 10:00 AM                | 10:00 AM              |1          |8:00 AM      |

    #Step 11
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "8" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds

    #Step 12,13
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "10" Seconds

    #Expected a
    Then Verify Pay Estimate Status for "Dave Fleet Carrier One 8" as "Estimated"
    Then Verify details for all Enabled fields
         |Email Out Pay Estimate|
         |False                 |
    Then Verify details for all Disabled or Readonly fields
         |Total Estimated Pay|
         |$365.38            |
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
       |Load / Leg|Tier/Rule         |Type                                                     |Rate  |Qty          |Comment|Estimated Pay Amount|
       |Leg 1     |Calculation Tier- |Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile|$0.50 |730.768 mi   |NA     |365.38             |

    Then Get "Estimated Pay Amount" value from Estimated Pay Section "Dave Fleet Carrier One 8" into "Estimated_Pay_Amount_1"
    Then Get "Tier/Rule" value from Estimated Pay Section "Dave Fleet Carrier One 8" into "Tier/Rule"
    Then Click Estimated Pay button with Title "Save" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."

    #Step 14
    Then Open New Tab with url "SysData=>CalculationTierURL"
    Then Wait for "2" Seconds

    #Step 15,16
    Then Scroll Until Related List for "Pay Estimate Details"
    Then Click on link "Pay Estimate Details"
    Then Wait for "2" Seconds
    Then Set "EstimatedFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "MatchedTo1" with "USD " and "SysData=>Estimated_Pay_Amount_1"
    Then Verify "Pay Estimate Details" Table Details
      |Estimated From         |Amount                       |Estimated From Type|
      |SysData=>EstimatedFrom |SysData=>MatchedTo1          |Trip Plan Leg      |
    Then Click on "Pay Estimate Detail-" with "Estimated From" as "SysData=>EstimatedFrom" and "Estimated From Type" as "Trip Plan Leg"
    Then Get Details
      |Pay Estimate Detail ID|Pay Estimate|
      |                      |            |
    Then Set "Pay Estimate Detail ID_1" with "SysData=>Pay Estimate Detail ID"
    Then Set "Pay Estimate_1" with "SysData=>Pay Estimate"

    Then Set Key "Pay_Estimate_Rules_SFID_1" page Record Id with "rtms9__Pay_Estimate_Detail__c"

    Then Click on Partial Link Text "Pay Estimate-" on Page

    #Step 17,18
    Then Click on Edit icon on Label "Email Out Pay Estimate"
    Then Update details
      |Email Out Pay Estimate|
      |True                  |
    Then Scroll into Section "Status"
    Then Update details
      |Status|
      |Sent  |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Email Out Pay Estimate|
      |True |
    Then Wait for "6" Seconds

    #Step 19  #expected result c
    Then Close and Switch to Previous Window
    Then Wait for "1" Seconds
    Then Click Estimated Pay button with Title "Refresh" in Section "Pay Estimate"
    Then Wait for "2" Seconds

    Then Verify Pay Estimate Status for "Dave Fleet Carrier One 8" as "Sent"
    Then Verify details for all Enabled fields
      |Email Out Pay Estimate|
      |False                 |
    Then Verify details for all Disabled or Readonly fields
      |Total Estimated Pay|
      |$365.38            |
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      |Load / Leg|Tier/Rule         |Type                                                     |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |Calculation Tier- |Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile|$0.50 |730.768 mi   |NA     |365.38             |


  #Step 20
    Then Click Estimated Pay button with Title "Regenerate" in Section "Pay Estimate"
    Then Wait for "3" Seconds
    Then Update "Comment" value to "Testing 2861" in Estimated Pay Section "Dave Fleet Carrier One 8"
    Then Click Estimated Pay button with Title "Save" in Section "Pay Estimate"
    Then Wait for "2" Seconds
  #Step 21
    Then Open New Tab with url "SysData=>CalculationTierURL"
    Then Wait for "2" Seconds
    Then Scroll into Section "Tier Calculation Settings"
    Then Click on Edit icon on Label "Amount"
    Then Update details
      | Amount |
      | 0.55   |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "5" Seconds
    Then Verify Details
      | Amount |
      | 0.55   |
    Then Set Key "Calculation_Tier_SFID_1" page Record Id with "rtms9__Calculation_Tier__c"

  #Step 22 and expected result d
    Then Close and Switch to Previous Window
    Then Wait for "1" Seconds
    Then Click Estimated Pay button with Title "Regenerate" in Section "Pay Estimate"
    Then Wait for "5" Seconds

    Then Verify Pay Estimate Status for "Dave Fleet Carrier One 8" as "Estimated"
    Then Verify details for all Enabled fields
      |Email Out Pay Estimate|
      |False                 |
    Then Verify details for all Disabled or Readonly fields
      |Total Estimated Pay|
      |$401.92             |
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      |Load / Leg|Tier/Rule          |Type                                                     |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |Calculation Tier-  |Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile|$0.55 |730.768 mi   |NA     |401.92              |

    #Step 23
    Then Click Estimated Pay button with Title "Save" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."

    #Step 24 and expected result e
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds
    Then Navigate to stored URL for "CalculationTierURL"
    Then Click on button with Title "Refresh"
    Then Click on link "Pay Estimate Details"
    Then Wait for "3" Seconds
    Then Set "EstimatedFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "MatchedTo2" with "USD " and "SysData=>Dave Fleet Carrier One 8_EstimatedPay_Estimated_Pay_Amount"
    Then Capture the current URL for "Pay_Estimate_Details_Page"
    Then Verify "Pay Estimate Details" Table Details
      |Estimated From        |Amount|Estimated From Type|
      |SysData=>EstimatedFrom|SysData=>MatchedTo1|Trip Plan Leg|
      |SysData=>EstimatedFrom|SysData=>MatchedTo2|Trip Plan Leg|

    Then Click on "Pay Estimate Detail-" with "Estimated From" as "SysData=>EstimatedFrom" and "Amount" as "SysData=>MatchedTo1"
    Then Wait for "2" Seconds
    Then Get Details
      |Pay Estimate Detail ID|Pay Estimate|
      |                      |            |
    Then Verify Assertion for "Pay Estimate Detail ID" contains "SysData=>Pay Estimate Detail ID_1"
    Then Verify Assertion for "Pay Estimate" contains "SysData=>Pay Estimate_1"

    Then Navigate to stored URL for "Pay_Estimate_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Estimate Detail-" with "Estimated From" as "SysData=>EstimatedFrom" and "Amount" as "SysData=>MatchedTo2"
    Then Wait for "2" Seconds
    Then Get Details
      |Pay Estimate Detail ID|Pay Estimate|
      |                      |            |
    Then Verify Assertion for "Pay Estimate Detail ID" not contains "SysData=>Pay Estimate Detail ID_1"
    Then Verify Assertion for "Pay Estimate" not contains "SysData=>Pay Estimate_1"
    Then Set Key "Pay_Estimate_Rules_SFID_2" page Record Id with "rtms9__Pay_Estimate_Detail__c"










