Feature:2808 - GenerateAccessorialPayJob- Trip Plan Leg Accessorial- Fleet Asset

  @API @Regression @PayIQ  @WEB @SingleCurrency @2808
  Scenario: 2808 - GenerateAccessorialPayJob- Trip Plan Leg Accessorial- Fleet Asset

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"

    #Step 1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds

    #Step 2
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

   #Step 3
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan"

    #Step 4
    Then Update "1" Segment details
      | Search       | Driver                     | Load         |
      | Tractor 1008 | Dave Fleet Carrier One 8 |PIQ-0   |
    Then Wait for "5" Seconds

    #Step 5
    Then Update "1" leg details
      | Start Type | Location       |
      | Terminal   | Illinois Terminal |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 1            | 8:00 AM      |
    Then Update "1" leg details
      |Appointment Date |Appointment Start Time |Appointment End Time|
      |2                | 9:00 AM               | 9:00 AM               |

    #Step 6
    Then Update "2" leg details
      | Due Out Date | Due Out Time  | Appointment Date |Appointment Start Time |Appointment End Time|
      | 2            |    11:00 AM      | 4               | 10:00 AM |            10:00 AM |
    Then Wait for "1" Seconds

    #Step 7
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 8
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds

    #Step 9
    Then Update "1" leg details
      | Accessorial             | Unit   | Quantity |Unit Price|Payable_2|
      | Detention at Pick Up     |  Fixed Cost|  1.00|20    | False  |
    Then Wait for "2" Seconds

    #Step 10
    Then Click on icon "utility:add" on "1" Leg
    Then Wait for "2" Seconds
    #Step 11
    Then Update "1" leg details
      | Accessorial_2            | Unit_2     | Quantity_2|Unit Price_2|
      | Vehicle Ordered Not Used | Per Day    | 2.00     |112.5     |
    Then Wait for "2" Seconds


    #Step 12
    Then Click on "Show Accessorials" on "2" Leg
    Then Wait for "2" Seconds

    #Step 13
    Then Update "2" leg details
      | Accessorial              | Unit   | Quantity | Unit Price |Payable|
      | Lumper Delivery          | Per Day| 4.00     | 57.75      | True  |
    
    #Step 14
   Then Set "TotalValue_1" with "225.00"
    Then Set "TotalValue_2" with "231.00"


    #Step 15
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 16
    Then Update "1" leg details
      | Departure Date |
      | 0 |

    #Step 17
    Then Update "2" leg details
      | Departure Date |
      | 0 |

    #Step 18
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying with "Save was successful."
    Then Close All Toast message

    #Step 19
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    #Step 20
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

   #Step 21
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 22
    Then Open "Pay Headers" from App Launcher

    #Step 23
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1008 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "2" Seconds
    #Step 24 and expected result a
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Capture the current URL for "Pay_Details_List"
    Then Set "PaidFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Click on "Pay Detail-" with "Type" as "Vehicle Ordered Not Used" and "Paid From" as "SysData=>PaidFrom"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 225.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Trip Plan Leg  |
      | Leg 1 |
    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial  |
      |Vehicle Ordered Not Used |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Load"


    Then Navigate to stored URL for "Pay_Details_List"
    Then Set "PaidFrom1" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Click on "Pay Detail-" with "Type" as "Lumper Delivery" and "Paid From" as "SysData=>PaidFrom1"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 231.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Trip Plan Leg  |
      | Leg 2 |
    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial  |
      |Lumper Delivery |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Load"

    #Step 25
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

    #Step 26
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    #Step 27
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Fleet Asset" and "Name" as "Tractor 1008"
    Then Wait for "2" Seconds

    #Step 28
    Then Click on "Clone" button
    Then Wait for "10" Seconds

    #Step 29
    Then Update details
      | Type   | Fleet Asset                   | Pay Off Load Instead of Trip Plan Leg |
      | Fleet Asset |Tractor 1008              | True                                  |

    #Step 30
    Then Click on "SaveEdit" button
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"
    Then Set Key "Participants_SFID_1" page Record Id with "rtms9__Participant__c"

    #Step 31 & 32
    Then Capture the current URL for "Participants_1"

    #Step 33
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 34
    Then Navigate to stored URL for "Pay_Details_List"
    Then Wait for "2" Seconds

    #Step 35 and expected result b
    #Frist Row
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Revenue (Quoted)" and "Pay Amount" as "USD 10.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      |USD 10.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Details
      |Calculation Tier|
      |Calculation Tier-|
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    Then Navigate to stored URL for "Pay_Details_List"
    Then Wait for "2" Seconds
    #Second Row
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Margin with Max (Quoted)" and "Pay Amount" as "USD 5.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      |USD 5.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Details
      |Calculation Tier|
      |Calculation Tier-|
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    Then Navigate to stored URL for "Pay_Details_List"
    Then Wait for "2" Seconds

     #Third Row
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Margin (Quoted - Sliding Scale)" and "Pay Amount" as "USD 5.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      |USD 5.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Details
      |Calculation Tier|
      |Calculation Tier-|
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    Then Navigate to stored URL for "Pay_Details_List"
    Then Wait for "2" Seconds
    #Fourth Row
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Margin with Min (Quoted)" and "Pay Amount" as "USD 26.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      |USD 26.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Details
      |Calculation Tier|
      |Calculation Tier-|
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    Then Navigate to stored URL for "Pay_Details_List"
    Then Wait for "2" Seconds

    #Fifth Row
    Then Click on "Pay Detail-" with "Type" as "Percent of Load Margin (Quoted)" and "Pay Amount" as "USD 5.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      |USD 5.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Details
      |Calculation Tier|
      |Calculation Tier-|
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    Then Navigate to stored URL for "Pay_Details_List"
    Then Wait for "2" Seconds

    #Sixth Row
    Then Click on "Pay Detail-" with "Type" as "Amount per Load" and "Pay Amount" as "USD 2.00"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      |USD 2.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Load  |
      | PIQ-0 |
    Then Verify Details
      |Calculation Tier|
      |Calculation Tier-|
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Trip Plan Leg"
    Then Verify Exact Text not displaying as "Accessorial"

    Then Navigate to stored URL for "Pay_Details_List"
    Then Wait for "2" Seconds

    #b First Row
    Then Set "PaidFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"

    Then Click on "Pay Detail-" with "Type" as "Vehicle Ordered Not Used" and "Paid From" as "SysData=>PaidFrom"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 225.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Trip Plan Leg  |
      | Leg 1 |
    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial  |
      |Vehicle Ordered Not Used |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Load"

 #b Second Row
    Then Navigate to stored URL for "Pay_Details_List"
    Then Set "PaidFrom1" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"

    Then Click on "Pay Detail-" with "Type" as "Lumper Delivery" and "Paid From" as "SysData=>PaidFrom1"
    Then Wait for "3" Seconds
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  |
      | USD 231.00|
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program                                |
      | PayIQProgram Individual Load Revenue (Quoted)|
    Then Scroll into Section "Parent References"
    Then Verify Details
      | Trip Plan Leg  |
      | Leg 2 |
    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial  |
      |Lumper Delivery |
    Then Verify Exact Text not displaying as "Driver Log"
    Then Verify Exact Text not displaying as "Load"