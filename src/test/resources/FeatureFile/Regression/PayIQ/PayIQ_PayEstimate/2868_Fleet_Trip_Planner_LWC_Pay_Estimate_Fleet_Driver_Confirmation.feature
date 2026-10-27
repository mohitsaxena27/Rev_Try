Feature:2868 - Fleet Trip Planner LWC- Pay Estimate- Fleet Driver Confirmation

  @API @Regression @PayIQ  @WEB @SingleCurrency @2868 @PayHeader
  Scenario: 2868 - Fleet Trip Planner LWC- Pay Estimate- Fleet Driver Confirmation

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"

    # Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    # Step 2
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

    # Step 3
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds

    # Step 4
    Then Click on Edit icon on Label "Allow Pay Estimates"
    Then Update details
      | Allow Pay Estimates |
      | True                |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | Allow Pay Estimates |
      | True                |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"

    # Step 5
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load

    # Step 6 & 7
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    # Step 8
    Then Update "1" Segment details
      | Driver                   | Load  |
      | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "5" Seconds

    # Step 9
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

    # Step 10 & 11
    Then Update "1" leg details
      | Appointment Date | Appointment Start Time | Appointment End Time | Due Out Date | Due Out Time |
      | 2                | 10:00 AM               | 10:00 AM             | 1            | 8:00 AM      |

    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds

    # Step 12
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "10" Seconds
    Then Get "Total Estimated Pay" value from Estimated Pay Section "Dave Fleet Carrier One 8" into "Total Estimated Pay"
    Then Get "Estimated Pay Amount" value from Estimated Pay Section "Dave Fleet Carrier One 8" into "Estimated Pay Amount"

    # Step 13
    Then Click Estimated Pay button with Title "Save & Close" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."

    # Step 14
    Then Click on button with Title "Confirm Driver"
    Then Verify Message displaying as "The driver confirmation email was sent."
    Then Wait for Email to Receive On Email

    # Step 15
    Then Get "Trip Details" link from Email for Driver Trip Confirmation
    Then Reset Time to get New Email
    Then Launch browser and Navigate Link

    # Expected a
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds
    Then Guest - Verify Icon "custom:custom17" is displaying with background color "Earth Yellow"
    Then Guest - Verify Text displaying as "Pay Estimate"
    Then Guest - Verify Text displaying as "Load / Leg"
    Then Guest - Verify Text displaying as "Type"
    Then Guest - Verify Text displaying as "Rate"
    Then Guest - Verify Text displaying as "Qty"
    Then Guest - Verify Text displaying as "Comment"
    Then Guest - Verify Text displaying as "Estimated Pay Amount"
    Then Set "Estimated_Pay_Amount" with "$" and "SysData=>Estimated Pay Amount"
    Then Guest - Verify Pay Estimate details
      | Load / Leg | Type                                                      | Rate  | Qty | Comment | Estimated Pay Amount          |
      | Leg 1      | Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile | $0.50 | NA  | NA      | SysData=>Estimated_Pay_Amount |
    Then Reset Time to get New Email

    Then Guest - Click on button with Title "Decline"
    Then Wait for "2" Seconds
    Then Guest - "Decline" Fleet Driver Confirmation
    Then Guest - Verify Text displaying as "Success - Driver Confirmation"
    Then Guest - Verify Text displaying as "This trip will not be dispatched to you."

    # Step 17
    Then Wait for "5" Seconds
    Then Click on button with Title "Close"

    # Step 18 & 19
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds

    # Step 20
    Then Click on "New" button on "Accessorial Rules" section
    Then Update details
      | Type                      | Accessorial          | Rule      | Amount |
      | Trip Plan Leg Accessorial | Detention at Pick Up | Flat Rate | 75     |
    Then Click on "SaveEdit" button

    # Step 21
    Then Verify Message displaying as "Accessorial Rule-"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Trip Plan Leg Accessorial" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "4" Seconds
    Then Get Details
      | Accessorial Rule ID |
      |                     |
    Then Capture the current URL for "Accessorial_Rules_1"
    Then Set Key "Accessorial_Rules_SFID_1" page Record Id with "rtms9__Accessorial_Rule__c"

    # Step 22 & 23
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    # Step 24 & 25
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      | Trip Plan(s)          |
      | SysData=>Trip_Plan_ID |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    # Step 26 & 27
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Accessorial          | Unit     | Quantity | Unit Price | Payable |
      | Detention at Pick Up | --None-- | 1.00     | 75.00      | True    |

    # Step 28
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Pending                    |

    # Step 29
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."

    # Step 30
    Then Wait for "2" Seconds
    Then Click on "Estimated Pay" on "1" Segment

    # Step 31
    Then Click Estimated Pay button with Title "Regenerate" in Section "Pay Estimate"
    Then Wait for "5" Seconds
    Then Click Estimated Pay button with Title "Save & Close" in Section "Pay Estimate"
    Then Wait for "5" Seconds
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "5" Seconds

    # Step 32
    Then Update "Comment" value to "Testing 2868" in Estimated Pay Section "Dave Fleet Carrier One 8"
    Then Update Estimated Pay Amount "365.38" to "366.00" in Section "Dave Fleet Carrier One 8"

    # Step 33
    Then Get details for "Total Estimated Pay" Disabled or Readonly fields and store in "TotalEstimatedPay"

    # Step 34
    Then Click Estimated Pay button with Title "Save & Close" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."
    Then Verify "Regenerate" button is not longer displaying

    # Step 35
    Then Click on button with Title "Confirm Driver"
    Then Verify Message displaying as "The driver confirmation email was sent."
    Then Wait for Email to Receive On Email

    # Step 36
    Then Get "Trip Details" link from Email for Driver Trip Confirmation
#    Then Launch browser and Navigate Link
    Then Navigate to guest browser with link

    # Expected b
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds
    Then Guest - Verify Text displaying as "Total Estimated Pay:"
    Then Guest - Verify Text displaying as "SysData=>TotalEstimatedPay"
    Then Guest - Verify Pay Estimate details
      | Load / Leg | Type                                                      | Rate   | Qty | Comment      | Estimated Pay Amount |
      | Leg 1      | Detention at Pick Up                                      | $75.00 | 1   | Testing 2868 | $75.00               |
      | Leg 1      | Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile | $0.50  | NA  |              | $366.00              |
    Then Close Guest Browser