Feature:2862 - Pay Estimate- Accessorial Rules

  @API @Regression @PayIQ  @WEB @SingleCurrency @2862 @PayHeader
  Scenario: 2862 - Pay Estimate- Accessorial Rules

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

    #Step 4,5,6
    Then Click on Edit icon on Label "Allow Pay Estimates"
    Then Update details
      |Allow Pay Estimates|Email Out Pay Estimates|
      |True               |True                   |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Allow Pay Estimates|
      |True |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"
    Then Set Key "Participants_SFID_1" page Record Id with "rtms9__Participant__c"
    

    #Step 7,8
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Accessorial Rules" section
    Then Update details
      | Type                     | Accessorial         | Rule     | Amount |
      | Trip Plan Leg Accessorial| Detention at Pick Up| Flat Rate| 75    |
    Then Click on "SaveEdit" button

    #Step 9
    Then Verify Message displaying as "Accessorial Rule-"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Trip Plan Leg Accessorial" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "4" Seconds
    Then Capture the current URL for "Accessorial_Rules_1"
    Then Set Key "Accessorial_Rules_SFID_1" page Record Id with "rtms9__Accessorial_Rule__c"

    #Step 10,11,12
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

    #Step 13
    Then Update "1" Segment details
      | Search       | Driver                   | Load |
      | Tractor 1008 | Dave Fleet Carrier One 8 | PIQ-0   |
    Then Wait for "5" Seconds

   #Step 14
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

     #Step 15
    Then Store date with month offset 0 and day 18 in format "MMM dd, yyyy" into "Current_Month_18"
    Then Store date with month offset 0 and day 21 in format "MMM dd, yyyy" into "Current_Month_21"
    Then Update "1" leg details
      | Appointment Date | Appointment Start Time | Appointment End Time |Due Out Date |Due Out Time |
      | SysData=>Current_Month_21              | 10:00 AM                | 10:00 AM              |SysData=>Current_Month_18        |8:00 AM      |

    #Step 16
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds

    #Step 17 and expected result a
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "5" Seconds
    Then Verify Pay Estimate Status for "Tractor 1008" as "Estimated"
    Then Verify details for all Enabled fields
      |Email Out Pay Estimate|
      |True                 |
    Then Verify details for all Disabled or Readonly fields
      |Total Estimated Pay|
      |$365.38            |
    Then Verify "1" Estimated Pay for Section "Tractor 1008"
      |Load / Leg|Tier/Rule         |Type                                                     |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |Calculation Tier- |Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile|$0.50 |730.768 mi   |NA     |365.38             |

  #Step 18
    Then Click Estimated Pay button with Title "Cancel" in Section "Pay Estimate"
   Then Wait for "3" Seconds

    #Step 19,20,21
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Accessorial              | Unit   | Quantity | Unit Price |Payable|
      | Detention at Pick Up | --None--| 1.00   | 75.00      | True  |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds

    #Step 22 and expected result b
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "10" Seconds

    Then Verify Pay Estimate Status for "Tractor 1008" as "Estimated"
    Then Verify details for all Enabled fields
      |Email Out Pay Estimate|
      |True                 |
    Then Verify details for all Disabled or Readonly fields
      |Total Estimated Pay|
      |$440.38            |
    Then Verify "1" Estimated Pay for Section "Tractor 1008"
      |Load / Leg|Tier/Rule                   |Type                       |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |(Trip Plan Leg Accessorial) |Detention at Pick Up       |$75.00 |1           |NA     |75.00             |
    Then Verify "2" Estimated Pay for Section "Tractor 1008"
      |Load / Leg|Tier/Rule         |Type                                                     |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |Calculation Tier- |Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile|$0.50 |730.768 mi   |NA     |365.38             |

    #Step 23,24
    Then Click Estimated Pay button with Title "Save" in Section "Pay Estimate"
    Then Wait for "2" Seconds
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 25,26
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds

    #Step 27
    Then Click on Edit icon on Label "Allow Pay Estimates"
    Then Update details
      |Allow Pay Estimates|
      |True               |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Allow Pay Estimates|
      |True |
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_2"
    Then Set Key "Participants_SFID_1" page Record Id with "rtms9__Participant__c"

    #Step 28,29
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

    #Step 30,31
    Then Scroll into Last of Webpage
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan Start Date|
      |This Month       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 32,33
    Then Click on button with Title "Add Segment Below"
    Then Update "2" Segment details
      | Search      | Driver                 |
      | Tractor 1009 |  Dave Fleet Carrier One 8 |
    Then Wait for "5" Seconds

#Step 34,35
    Then Update "2" leg details
      | Start Type | Location                   |
      | Load Stop   | Stop 2D - Baltimore PayIQ |
    Then Update "2" leg details
      | Due Out Date | Due Out Time |
      | 2            | 1:00 PM      |
    Then Update "2" leg details
      |End Type|Location_2|Appointment Date|
      |Terminal|Illinois Terminal|4        |
    Then Update "2" leg details
     |Appointment Start Time|Appointment End Time|
     |7:00 AM               |7:00 AM             |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Close Toast message
    Then Close Toast message
    
    #Step 36 and expected result c
    Then Wait for "5" Seconds
    Then Click on "Estimated Pay" on "2" Segment
    Then Wait for "10" Seconds

    Then Verify Pay Estimate Status for "Dave Fleet Carrier One 8" as "Estimated"
    Then Verify details for all Enabled fields
      |Email Out Pay Estimate|
      |False                 |
    Then Verify details for all Disabled or Readonly fields
      |Total Estimated Pay|
      |$346.95           |

    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      |Load / Leg|Tier/Rule         |Type                                                     |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 2     |Calculation Tier- |Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile|$0.50 |693.893        |NA     |346.95             |

    Then Wait for "3" Seconds
    #Step 37 and expected result d
    Then Click on "Estimated Pay" on "1" Segment
    Then Wait for "5" Seconds
    Then Click on button with Title "Regenerate"
    Then Wait for "5" Seconds

    Then Verify Pay Estimate Status for "Dave Fleet Carrier One 8" as "Estimated"
    Then Verify details for all Enabled fields
      |Email Out Pay Estimate|
      |False                 |
    Then Verify details for all Disabled or Readonly fields
      |Total Estimated Pay|
      |$440.38            |
    Then Verify "1" Estimated Pay for Section "Dave Fleet Carrier One 8"
      |Load / Leg|Tier/Rule                   |Type                       |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |(Trip Plan Leg Accessorial) |Detention at Pick Up       |$75.00 |1           |NA     |75.00             |
    Then Verify "2" Estimated Pay for Section "Dave Fleet Carrier One 8"
      |Load / Leg|Tier/Rule         |Type                                                     |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |Calculation Tier- |Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile|$0.50 |730.768 mi   |NA     |365.38             |

    Then Verify Pay Estimate Status for "Tractor 1008" as "Estimated"
    Then Verify details for all Enabled fields
      |Email Out Pay Estimate_2|
      |True                 |
    Then Verify details for all Disabled or Readonly fields
      |Total Estimated Pay_2|
      |$440.38            |

    Then Verify "1" Estimated Pay for Section "Tractor 1008"
      |Load / Leg|Tier/Rule                   |Type                       |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |(Trip Plan Leg Accessorial) |Detention at Pick Up       |$75.00 |1           |NA     |75.00             |
    Then Verify "2" Estimated Pay for Section "Tractor 1008"
      |Load / Leg|Tier/Rule         |Type                                                     |Rate  |Qty          |Comment|Estimated Pay Amount|
      |Leg 1     |Calculation Tier- |Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile|$0.50 |730.768 mi   |NA     |365.38             |