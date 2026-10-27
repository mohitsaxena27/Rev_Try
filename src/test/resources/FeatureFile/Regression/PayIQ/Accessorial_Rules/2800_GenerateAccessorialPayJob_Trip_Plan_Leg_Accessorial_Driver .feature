Feature:2800 - GenerateAccessorialPayJob- Trip Plan Leg Accessorial- Accessorial Rules

  @API @Regression @PayIQ  @WEB @SingleCurrency @2800
  Scenario: 2800 - GenerateAccessorialPayJob- Trip Plan Leg Accessorial- Accessorial Rules

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    #Step1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load
    # Step 2
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    #Step 3 &4
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
     | Driver                   |
     | Dave Fleet Carrier One 8 |
    Then Wait for "5" Seconds
    #Step 5
    Then Update "1" leg details
      | Start Type | Location         | Due Out Date | Due Out Time | End Type | Location_2    | Appointment Date | Appointment Start Time | Appointment End Time |
      | Terminal   | Illinois Terminal |   1     | 8:00 AM     | Location | Indianapolis Colts | 2               | 10:00 AM                | 10:00 AM              |

   # Step 6
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 7 & 8 & 9
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Accessorial     | Unit       | Quantity | Unit Price |Payable|
      | Blind Shipments | Fixed Cost | 308.64   |   4    | True  |

    #Step 10
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 11
    Then Update "1" leg details
      | Arrival Date |
      | 0 |

    #Step 12
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    #Step 13
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List
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

    #Step 14
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "10" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "20" Seconds

    #Step 15
    Then Open "Pay Headers" from App Launcher
    #Step 16
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    #Step 17 & Expected a
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Type" as "Blind Shipments"
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 1,234.56|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program  |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial |
      | Blind Shipments|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Trip Plan Leg  |
      | Leg 1 |
    Then Verify Exact Text not displaying as "Load"
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Calculation Tier"

    #Step 18
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-0" from List
    Then Wait for "2" Seconds
    Then Refresh current Page
    Then Wait for "5" Seconds
    Then Click on Edit icon on Label "Custom PayIQ Eligible Date"
    Then Update details
      |Custom PayIQ Eligible Date|
      |          0               |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Custom PayIQ Eligible Date|
      |          0               |
    Then Capture the current URL for "Load_URL"

    #Step 19
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load

    # Step 20
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 21
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan Start Date|
      |This Month       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    #Step 22
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 23
    Then Update "1" Segment details
      | Load |
      | PIQ-0 |
    Then Wait for "5" Seconds
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "3" Seconds

    #Step 24
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 25
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds

    #Step 26
    Then Click on "Clone" button
    Then Wait for "8" Seconds

    #Step 27
    Then Update details
      | Type   | Driver                   | Pay Off Load Instead of Trip Plan Leg |
      | Driver | Dave Fleet Carrier One 8 | True                                  |
   #Step 28
    Then Click on "SaveEdit" button
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"
    Then Set Key "Participants_SFID_1" page Record Id with "rtms9__Participant__c"

   #Step 29 & 30
    Then Capture the current URL for "Participants_1"

   #Step 31
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "10" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
     #Step 32 & 33
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    #Step 34
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Capture the current URL for "Pay_Details_List"
    Then Set "PaidFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Capture the current URL for "Pay_Details_Page"
    #Expected b
    Then Verify "Pay Details" Table Details
      | Pay Amount|Paid From Type| Paid From |  Accessorial  |
      | USD 10.00|Load           |PIQ-0      |            |
      | USD 5.00|Load            |  PIQ-0     |             |
      | USD 5.00|Load            |  PIQ-0     |             |
      | USD 26.00|Load           |  PIQ-0    |            |
      | USD 5.00|Load            |  PIQ-0     |             |
      | USD 2.00|Load            |  PIQ-0     |             |

    Then Verify "Pay Details" Table Details
      | Pay Amount|Paid From Type | Paid From              |  Accessorial  |
      | USD 1,234.56|Trip Plan Leg |  SysData=>PaidFrom     | Blind Shipments |

    #1st Records
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Revenue (Quoted)" and "Pay Amount" as "USD 10.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 10.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Verify details for
       |Calculation Tier|
       |Calculation Tier-|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    #Second Records
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Margin (Quoted - Sliding Scale)" and "Pay Amount" as "USD 5.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 5.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Verify details for
      |Calculation Tier|
      |Calculation Tier-|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    #Third Records
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Margin with Max (Quoted)" and "Pay Amount" as "USD 5.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 5.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Verify details for
      |Calculation Tier|
      |Calculation Tier-|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    #Fourth Records
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Margin (Quoted)" and "Pay Amount" as "USD 5.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 5.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Verify details for
      |Calculation Tier|
      |Calculation Tier-|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    #Fifth Records
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Margin with Min (Quoted)" and "Pay Amount" as "USD 26.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 26.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Verify details for
      |Calculation Tier|
      |Calculation Tier-|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    #Sixth Records
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Type" as "Amount per Load" and "Pay Amount" as "USD 2.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 2.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Verify details for
      |Calculation Tier|
      |Calculation Tier-|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    #Seventh Records
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Type" as "Blind Shipments"
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 1,234.56|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program  |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial |
      | Blind Shipments|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Trip Plan Leg  |
      | Leg 1 |
    Then Verify Exact Text not displaying as "Load"
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Calculation Tier"