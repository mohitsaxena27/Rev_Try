Feature:2866 - Fleet Trip Planner LWC- Pay Estimate- Format/Functionality

  @API @Regression @PayIQ  @WEB @SingleCurrency @2866 @PayHeader
  Scenario: 2866 - Fleet Trip Planner LWC- Pay Estimate- Format/Functionality

    When Login into Salesforce
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"

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
      |Allow Pay Estimates|
      |True               |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | Allow Pay Estimates |
      | True                |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"
    Then Navigate Browser Back

    #Step 5
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load

    #Step 6 & 7
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 8
    Then Update "1" Segment details
      | Driver                   | Load  |
      | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "5" Seconds

    #Step 9
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

    #Step 10 & 11
    Then Update "1" leg details
      | Appointment Date | Appointment Start Time | Appointment End Time | Due Out Date | Due Out Time |
      | 2                | 10:00 AM               | 10:00 AM             | 1            | 8:00 AM      |

    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds

    #Step 12
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "10" Seconds

    #expected a(a)
    Then Verify Icon "custom:custom17" is displaying with background color "Earth Yellow"
    Then Verify "White" Color with "LightGray" Text of "Refresh" Button is "Disabled"
    Then Verify "White" Color with "SteelBlue" Text of "Regenerate" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "Cancel" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Save & Close" Button is "Enabled"

    #expected a(b)
    Then Verify Icon "custom:custom15" is displaying with background color "Dark Red"
    Then Verify Pay Estimate Status for "Dave Fleet Carrier One 8" as "Estimated"
    Then Verify details for all Enabled fields
      | Email Out Pay Estimate |
      | False                  |
    Then Verify details for all Disabled or Readonly fields
      | Total Estimated Pay |
      | $365.38             |
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      | Load / Leg | Tier/Rule | Type                                                      | Rate  | Qty | Comment | Estimated Pay Amount |
      | Leg 1      | NA        | Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile | $0.50 | NA  | NA      | 365.38               |
    Then Verify Button with Title displaying as "Edit" -
    Then Verify Text displaying as "Load / Leg" with "font-weight" as "bold"
    Then Verify Text displaying as "Type" with "font-weight" as "bold"
    Then Verify Text displaying as "Rate" with "font-weight" as "bold"
    Then Verify Text displaying as "Qty" with "font-weight" as "bold"
    Then Verify Text displaying as "Comment" with "font-weight" as "bold"
    Then Verify Text displaying as "Estimated Pay Amount" with "font-weight" as "bold"

    #expected a(c)
    Then Verify "White" Color with "LightGray" Text of "Refresh_2" Button is "Disabled"
    Then Verify "White" Color with "SteelBlue" Text of "Regenerate_2" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "Cancel_2" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Save_2" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Save & Close_2" Button is "Enabled"

    #Step 13
    Then Click on button with Title "Close"

    #Step 14 & 15
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Set URL with "-setup.com/lightning/setup/ManageUsers/home" and store into "Manage User URL"
    Then Navigate to stored URL for "Manage User URL"
    Then Switch to Frame by Title "All"
    Then Click on "U" with Text -
    Then Switch to Parent Frame
    Then Wait for "5" Seconds
    Then Switch to Frame by Title "All"
    Then Wait for "5" Seconds
    Then Click on "User, User" with Text -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "User: User User ~ Salesforce - Enterprise Edition"
    Then Capture the current URL for "User_setup"
    Then Click on "edit" button -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "User Edit"
    Then Scroll down with "15" Times
    Then Enter "10" with Label "Estimate Adjustment Lower Limit" -
    Then Enter "12" with Label "Estimate Adjustment Upper Limit" -
    Then Click on button with Title "Save" -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 16
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan(s)|
      |SysData=>Trip_Plan_ID       |
#    Then Update details
#      |Trip Plan Start Date|
#      |This Month       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 17 & 18
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "5" Seconds
    Then Get "Estimated Pay Amount" value from Estimated Pay Section "Dave Fleet Carrier One 8" into "Estimated Pay Amount"

    #Step 19 & expected b
    Then Click on button with Title "Edit" on Modal
    Then Wait for "2" Seconds
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      | Load / Leg | Tier/Rule | Type | Rate | Qty | Comment | Estimated Pay Amount          |
      | NA         | NA        | NA   | NA   | NA  | NA      | SysData=>Estimated Pay Amount |

    #Step 20 & expected c
    Then Calculate value "-9" from existing value "SysData=>Estimated Pay Amount" and store in "Reduced_Pay_amount"
    Then Update "Estimated Pay Amount" value to "SysData=>Reduced_Pay_amount" in Estimated Pay Section "Dave Fleet Carrier One 8"
    Then Click Estimated Pay button with Title "Save" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."
    Then Verify details for all Disabled or Readonly fields
      | Total Estimated Pay |
      | SysData=>Reduced_Pay_amount             |
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      | Load / Leg | Tier/Rule | Type | Rate | Qty | Comment | Estimated Pay Amount        |
      | NA         | NA        | NA   | NA   | NA  | NA      | SysData=>Reduced_Pay_amount |

    #Step 21 & expected d
    Then Calculate value "-9" from existing value "SysData=>Reduced_Pay_amount" and store in "Reduced_Pay_amount2"
    Then Update "Estimated Pay Amount" value to "SysData=>Reduced_Pay_amount2" in Estimated Pay Section "Dave Fleet Carrier One 8"
    Then Click Estimated Pay button with Title "Refresh" in Section "Pay Estimate"
    Then Verify Text containing "Adjustment below lower limit of 10 below original calculated amount" with "Red" Color is displaying

    #Step 22 & expected e
    Then Click on button with Title "Edit" on Modal
    Then Verify details for all Disabled or Readonly fields
      | Total Estimated Pay |
      | SysData=>Estimated Pay Amount            |
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      | Load / Leg | Tier/Rule | Type | Rate | Qty | Comment | Estimated Pay Amount          |
      | NA         | NA        | NA   | NA   | NA  | NA      | SysData=>Estimated Pay Amount |

    #Step 23
    Then Click on button with Title "Edit" on Modal
    Then Wait for "2" Seconds
    Then Update "Estimated Pay Amount" value to "357.00" in Estimated Pay Section "Dave Fleet Carrier One 8"
    Then Click Estimated Pay button with Title "Save" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."

    #Step 24 & expected f
    Then Update "Estimated Pay Amount" value to "377.00" in Estimated Pay Section "Dave Fleet Carrier One 8"
    Then Click Estimated Pay button with Title "Save & Close" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."
    Then Verify "Regenerate" button is not longer displaying

    #Step 25 & expected g
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "5" Seconds
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      | Load / Leg | Tier/Rule | Type | Rate | Qty | Comment | Estimated Pay Amount |
      | NA         | NA        | NA   | NA   | NA  | NA      | 377.00               |

    #Step 26 & expected h
    Then Update "Estimated Pay Amount" value to "378.00" in Estimated Pay Section "Dave Fleet Carrier One 8"
    Then Click Estimated Pay button with Title "Refresh" in Section "Pay Estimate"
    Then Verify Text containing "Adjustment above upper limit of 12 above original calculated amount" with "Red" Color is displaying