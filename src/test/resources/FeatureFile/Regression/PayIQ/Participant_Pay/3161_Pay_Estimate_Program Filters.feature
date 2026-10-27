Feature:3161 - Pay Estimate- Program Filters

  @API @Regression @PayIQ  @WEB @SingleCurrency @3161 @PayHeader
  Scenario: 3161 - Pay Estimate- Program Filters

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
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds

    #Step 4
    Then Click on Edit icon on Label "Allow Pay Estimates"
    Then Update details
      |Allow Pay Estimates|Pay Off Load Instead of Trip Plan Leg|
      |True               |True                                 |

    #Step 5
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Allow Pay Estimates|
      |True |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"
    Then Set Key "Participants_SFID_1" page Record Id with "rtms9__Participant__c"

   #Step 6
    Then Navigate to stored URL for "PayIQ_Program_1"
    #Step 7
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Fleet Asset" and "Name" as "Tractor 1008"
    Then Wait for "2" Seconds

    #Step 8
    Then Click on Edit icon on Label "Allow Pay Estimates"
    Then Update details
      |Allow Pay Estimates|Pay Off Load Instead of Trip Plan Leg|
      |True               |False                                 |

    #Step 9
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Allow Pay Estimates|
      |True |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_2"
    Then Set Key "Participants_SFID_2" page Record Id with "rtms9__Participant__c"

    #Step 10
    Then Navigate Browser Back
    Then Navigate to stored URL for "PayIQ_Program_1"
    #Step 11
    Then Scroll Until Related List for "Filters"
    Then Choose "New" button on "Filters" section

    #Step 12
    Then Wait for "4" Seconds
    Then Update details
      |* Table |* Field             |* Operator|
      |Trip Plan Leg    | Billable  |Not equal to  |

    #Step 13
    Then Click on "Save" with Text
    Then Wait for "5" Seconds

    #Step 14
    Then Scroll Until Related List for "Filters"
    Then Get "Filter-" Name with "Value" as "true" and store in "Filter_1"

    #Step 15
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load

    #Step 16
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

    #Step 17
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 18
    Then Update "1" Segment details
    |Search  | Driver                   | Load  |
    |Tractor 1008  | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "5" Seconds

    #Step 19
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

   #Step 20
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds
    Then Close Toast message

    #Step 21 and expected result a
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "15" Seconds
    Then Verify Text not displaying as "Dave Fleet Carrier One 8" under Pay Estimate Details
    Then Verify Text not displaying as "Tractor 1008" under Pay Estimate Details
    Then Verify Normalized Text displaying as "(Segment is not eligible for pay estimate.  If you are require an estimate, please check your PayIQ Program setup)"

    #Step 22
    Then Click on button with Title "Cancel"

   #Step 23
    Then Update "1" leg details
      |Billable|
      |False|
    Then Wait for "2" Seconds

  #Step 24 and expected result b
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "15" Seconds
    Then Verify Normalized Text displaying as "(Segment is not eligible for pay estimate.  If you are require an estimate, please check your PayIQ Program setup)"
    Then Verify Text not displaying as "Dave Fleet Carrier One 8" under Pay Estimate Details
    Then Verify Text not displaying as "Tractor 1008" under Pay Estimate Details

   #Step 25
    Then Click on button with Title "Cancel"

    #Step 26
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "10" Seconds

    #Step 27 and expected result c
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "10" Seconds
    Then Verify Pay Estimate Status for "Dave Fleet Carrier One 8" as "Estimated"
    Then Verify Pay Estimate Status for "Tractor 1008" as "Estimated"


