Feature:2869 - GenTierPayJob Calc Tier Trip Plan Leg Distance Miles

  @API @Regression @PayIQ  @WEB @SingleCurrency @2869 @PayIQ_Logs
  Scenario: 2869 -  GenTierPayJob Calc Tier Trip Plan Leg Distance Miles

    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"
    Then Delete All Records with name "Pay Detail-" for "rtms9__Pay_Detail__c"

    When Login into Salesforce

    #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Driver Pay - Per Mile" from List

    #Step 3
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

    #Step 4
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Get "Calculation Tier-" Name with "From (>)" as "0.00" and store in "Calc_TierID_1"
    Then Get "Calculation Tier-" Name with "From (>)" as "500.00" and store in "Calc_TierID_2"

    #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Update details
      | Fleet |
      | True  |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load_1L"

    #Step 7 & 8
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    #Step 9
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 10
    Then Update "1" Segment details
      | Search       | Driver                   | Load        |
      | Tractor 1007 | Dave Fleet Carrier One 7 | SysData=>1L |

    Then Update "1" leg details
      | Start Type | Location             |
      | Location   | New England Patriots |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 0            | 6:30 AM      |
    Then Wait for "1" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date |
      | 1            |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 11
    Then Get "Unloaded (mi/km)" from "1" Segment mileage box and store into "Unloaded_Value"
    Then Get "Loaded (mi/km)" from "1" Segment mileage box and store into "Loaded_Value"

    #Step 12
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 13
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 14
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait for "5" Seconds
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "10" Seconds
    #Step 15
    Then Open "Pay Details" from App Launcher
    #Expected Result a
    Then Set "EstimatedFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with contains "Tractor 1007 (Fleet Asset)" & "rtms9__Paid_From__c" with contains "SysData=>EstimatedFrom" and Store into "PayDetailID"
    Then Verify Assertion for "PayDetailID_count" contains "0"

    #Step 16
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with contains "Tractor 1007 (Fleet Asset)" & "rtms9__Trip_Plan_Name__c" with contains "SysData=>Trip_Plan_ID" and Store into "PayDetailID"
    Then Search and Select "SysData=>PayDetailID" from List
    Then Wait for "2" Seconds

    #Step 17 and expected result b
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty" is within a cent of "SysData=>Unloaded_Value"
    Then Multiple "SysData=>Extracted_Qty" with "3" and store in "ThreeDecimal_Pay_Amount" and "TwoDecimal_Pay_Amount"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount"

   #Step 18
    Then Verify the field value "SysData=>Extracted_Qty" has "3" decimal places

    #Step 19 and expected result c
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_1} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 0 < {Extracted_Qty} <= 200"

    #Step 20 and expected result d
    Then Set "Pay Amount" with "SysData=>ThreeDecimal_Pay_Amount"
    Then Verify Logs displaying as "[{Calc_TierID_1} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Extracted_Qty} x 3 USD = {Pay Amount} USD"

    #Step 21,22
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      | Trip Plan Start Date |
      | Today                |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    #Step 23
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 24
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Departure Date |
      | 0              |
    Then Update "2" leg details
      | Arrival Date |
      | 3            |
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying with "Save was successful."
    Then Close All Toast message

    #Step 25
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 26
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait for "5" Seconds
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "10" Seconds

    #Step 27 and expected result e
    Then Open "Pay Details" from App Launcher
    Then Get "name" from "rtms9__Pay_Detail__c" using "rtms9__Trip_Plan_Name__c" with value "SysData=>Trip_Plan_ID" & "rtms9__Trip_Plan_Segment_Name__c" with value "Segment 1" and Store onto "PayDetails"
    Then Verify Assertion for "PayDetails_count" contains "4"

    #Step 28
    Then Set "EstimatedFrom1" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "EstimatedFrom2" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 7 (Driver)" & "rtms9__Paid_From__c" with contains "SysData=>EstimatedFrom1" and Store into "PayDetailID_1"

    Then Search and Select "SysData=>PayDetailID_1" from List
    Then Wait for "3" Seconds
   #Step 29 and expected result f
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount"

    #Step 30 and expected result g
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_1} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 0 < {Extracted_Qty} <= 200"

    #Step 31 and expected result h
    Then Verify Logs displaying as "[{Calc_TierID_1} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Extracted_Qty} x 3 USD = {ThreeDecimal_Pay_Amount} USD"

    #Step 32
    Then Open "Pay Details" from App Launcher
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 7 (Driver)" & "rtms9__Paid_From__c" with contains "SysData=>EstimatedFrom2" and Store into "PayDetailID_2"
    Then Search and Select "SysData=>PayDetailID_2" from List
    Then Wait for "2" Seconds
    #Step 33 and expected result i
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty_1"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty_1" is within a cent of "SysData=>Loaded_Value"
    Then Multiple "SysData=>Extracted_Qty_1" with "1.50" and store in "ThreeDecimal_Pay_Amount_1" and "TwoDecimal_Pay_Amount_1"
    Then Get Details
      | Pay Amount |
      |            |

    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_1"

   #Step 34
    Then Verify the field value "SysData=>Extracted_Qty_1" has "3" decimal places

    #Step 35 and expected result j
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_2} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 500 < {Extracted_Qty_1} <= (NULL)"

   #Step 36 and expected result k
    Then Set "Pay Amount" with "SysData=>ThreeDecimal_Pay_Amount_1"
    Then Verify Logs displaying as "[{Calc_TierID_2} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Extracted_Qty_1} x 1.5 USD = {ThreeDecimal_Pay_Amount_1} USD"

   #Step 37
    Then Open "Pay Details" from App Launcher
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with contains "Tractor 1007 (Fleet Asset)" & "rtms9__Paid_From__c" with contains "SysData=>EstimatedFrom2" and Store into "PayDetailID_3"

    Then Search and Select "SysData=>PayDetailID_3" from List
   #Step 38 and expected result l
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_1"

  #Step 39 and expected result m
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_2} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 500 < {Extracted_Qty_1} <= (NULL)"

   #Step 31 and expected result n
    Then Verify Logs displaying as "[{Calc_TierID_2} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Extracted_Qty_1} x 1.5 USD = {ThreeDecimal_Pay_Amount_1} USD"

