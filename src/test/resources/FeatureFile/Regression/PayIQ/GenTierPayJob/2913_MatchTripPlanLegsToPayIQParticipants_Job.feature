Feature:2913 - MatchTripPlanLegsToPayIQParticipants_Job

  @API @Regression @PayIQ  @WEB @SingleCurrency @2913 @PayIQ_Logs
  Scenario: 2913 - MatchTripPlanLegsToPayIQParticipants_Job

    When Login into Salesforce

   #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List
    #Step 3
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
    #Step4
    Then Note the current Date and Time
    #Step5
    Then Go to "Related" Tab
    Then Scroll into Section "Roles"
    Then Click on "Role-" with "Parent Object" as "Trip Plan Leg" and "Lookup Type" as "Fleet Asset" and "Eligible Date Field" as "Departure Date"
    Then Wait for "2" Seconds
    #Step6
    Then Click on Edit icon on Label "Eligible Date Field"
    Then Update details
      | Eligible Date Field      |
      | Last Leg Departure Date  |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Eligible Date Field      |
      | Last Leg Departure Date  |
    Then Capture the current URL for "Role_edit"
    #Step7
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    #Step8
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds
    #Step9
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    #Step10
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Search       | Driver                    | Load |
      | Tractor 1008 | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "5" Seconds
    #Step11
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "3" Seconds

    Then Store date with month offset 0 and day 25 in format "M/d/yyyy" into "Date"
    Then Store date with month offset 0 and day 27 in format "M/d/yyyy" into "Date_1"
    Then Store date with month offset 0 and day 28 in format "M/d/yyyy" into "Date_2"
    Then Store date with month offset 1 and day 1 in format "M/d/yyyy" into "Next_date_1"
    Then Store date with month offset 1 and day 2 in format "M/d/yyyy" into "Next_date_2"
    Then Store date with month offset 1 and day 3 in format "M/d/yyyy" into "Next_date_3"

    #Step12
    Then Update "1" leg details
     | Due Out Date    | Due Out Time |
     |  SysData=>Date  | 8:00 AM      |

    Then Update "1" leg details
      | Appointment Date | Appointment Start Time | Appointment End Time |
      |  SysData=>Date_1 | 10:00 AM               | 10:00 AM             |

    #Step13
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "4" Seconds

    #Step14
    Then Update "1" leg details
      | Arrival Date    |Departure Date|
      | SysData=>Date   |SysData=>Date_1 |

    #Step15
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step16
    Then Click on "Add Leg Below" on "1" Leg
    Then Wait for "2" Seconds

    #Step17
    Then Update "2" leg details
       | Due Out Date     | Due Out Time | End Type | Location_2     |
       |  SysData=>Date_1 | 11:45 AM      | Location    | Washington Commanders  |

    Then Update "2" leg details
      | Appointment Date | Appointment Start Time | Appointment End Time |
      | SysData=>Date_2  | 8:00 AM               | 8:00 AM               |

    #Step18
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step19
    Then Update "2" leg details
      | Arrival Date   |Departure Date|
      |  SysData=>Date_2 |SysData=>Next_date_1   |

    #Step20
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "8" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step21
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step22
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

  #Step23
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "2" Seconds

    #Step24
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Participant Matches"
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds
    #Step 25 Expected a(a,b,c,d)
    Then Set "MatchedTo" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "MatchedTo_2" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Verify "Participant Matches" Table Details
      | Participant Name                  | Eligible Date           | Matched To |
      |Dave Fleet Carrier One 8 (Driver) |      SysData=>Date       | SysData=>MatchedTo |
      |Dave Fleet Carrier One 8 (Driver) |      SysData=>Date_2      | SysData=>MatchedTo_2|
      | Tractor 1008 (Fleet Asset)       |      SysData=>Next_date_1  | SysData=>MatchedTo |
      | Tractor 1008 (Fleet Asset)       |      SysData=>Next_date_1  | SysData=>MatchedTo_2 |

    #Step26 & 27
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step28 &29
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan(s)|
      |SysData=>Trip_Plan_ID   |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    #Step30
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "3" Seconds

  #Step31
    Then Click on "Add Leg Below" on "2" Leg
    Then Wait for "1" Seconds
    #Step32
    Then Update "3" leg details
       | Due Out Date    | Due Out Time |End Type        | Location_2 |
       | SysData=>Date_2   | 9.00 AM      | Location    | Baltimore PayIQ         |
    Then Update "3" leg details
      | Appointment Date | Appointment Start Time | Appointment End Time |
      | SysData=>Date_2   |  3:00 PM               | 3:00 PM              |

   #Step33
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

   #Step34
    Then Update "3" leg details
      | Arrival Date         |  Departure Date|
      | SysData=>Next_date_2 |SysData=>Next_date_3 |

    #Step35
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step36
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step37
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "2" Seconds

    #Step38
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Participant Matches"
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds
    #Step 25 Expected b(a,b,c,d)
    Then Set "MatchedTo" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "MatchedTo_2" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Set "MatchedTo_3" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 3"

    Then Verify "Participant Matches" Table Details
      | Participant Name                  | Eligible Date        | Matched To |
      |Dave Fleet Carrier One 8 (Driver) |       SysData=>Date   | SysData=>MatchedTo |
      |Dave Fleet Carrier One 8 (Driver) |       SysData=>Date_2 | SysData=>MatchedTo_2|
      |Dave Fleet Carrier One 8 (Driver) |   SysData=>Next_date_2 | SysData=>MatchedTo_3|
      | Tractor 1008 (Fleet Asset)       |   SysData=>Next_date_3 | SysData=>MatchedTo_3|
      | Tractor 1008 (Fleet Asset)       |   SysData=>Next_date_3 | SysData=>MatchedTo_3|
      | Tractor 1008 (Fleet Asset)       |   SysData=>Next_date_3  | SysData=>MatchedTo_3|
