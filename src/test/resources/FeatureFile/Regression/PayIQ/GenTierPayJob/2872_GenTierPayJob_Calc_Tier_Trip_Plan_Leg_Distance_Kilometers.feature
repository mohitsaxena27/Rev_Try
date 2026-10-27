Feature:2872 - GenTierPayJob- Calc Tier: Trip Plan Leg Distance (Kilometers)

  @API @Regression @PayIQ  @WEB @SingleCurrency @2872 @PayIQ_Logs
  Scenario: 2872 -  GenTierPayJob- Calc Tier: Trip Plan Leg Distance (Kilometers)

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"

    #Step 1
    Then Open "PayIQ Programs" from App Launcher

    #Step 2
    Then Search and Select "PayIQProgram Driver Pay - Per Kilometer" from List

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

    #Step 4
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Get "Calculation Tier-" Name with "From (>)" as "0.00" and store in "Calc_TierID_1"

     #Step 5
    Then Get "Calculation Tier-" Name with "From (>)" as "500.00" and store in "Calc_TierID_2"

    #Step 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Update details
    |Fleet|
    |True |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000   | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 7
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

    #Step 8
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 9 & 10
    Then Update "1" Segment details
      | Search       | Driver                    |Load|
      | Tractor 1008 | Dave Fleet Carrier One 8 |SysData=>1L|
    Then Wait for "4" Seconds
    Then Update "1" leg details
      | Start Type | Location     |
      | Location   | New England Patriots |
    Then Update "1" leg details
      | Due Out Date | Due Out Time|
      | 0            | 6:30 AM     |

    Then Wait for "2" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date |Departure Date |
      | 0           |0               |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "8" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 11
    Then Get "Unloaded (mi/km)" from the "1" Segment mileage box and store into "Unloaded_Value"
    Then Get "Loaded (mi/km)" from the "1" Segment mileage box and store into "Loaded_Value"

    #Step 12
    Then Click on button with Title "Close"

    #Step 13
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds

    #Step 14
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 15
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 16 and expected result a
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Set "PaidFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Get Count from "rtms9__Pay_Detail__c" using "rtms9__Paid_From__c" with value "SysData=>PaidFrom" and Store onto "PM"
    Then Verify Assertion for "PM_count" contains "0"

    #Step 17
    Then Click on "Pay Detail-" with "Participant Name" as "Tractor 1008 (Fleet Asset)" and "Calculation Tier" as "SysData=>Calc_TierID_1" and "Paid From" as "SysData=>PaidFrom1"
    Then Wait for "2" Seconds

    #Step 18 and expected result b
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty" is within a cent of "SysData=>Unloaded_Value"
    Then Multiple "SysData=>Extracted_Qty" with "5" and store in "ThreeDecimal_Pay_Amount" and "TwoDecimal_Pay_Amount"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount"

    #Step 19
    Then Verify the field value "SysData=>Extracted_Qty" has "3" decimal places

    #Step 20 and expected result c
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_1} calculation] = [From] < [Individual Trip Plan Leg Distance (Km)] <= [To] = 0 < {Extracted_Qty} <= 200"

    #Step 21 and expected result d
    Then Set "Pay Amount" with "SysData=>TwoDecimal_Pay_Amount"
    Then Verify Logs displaying as "[{Calc_TierID_1} Pay Amount] = [Trip Plan Leg Distance Kilometers] x [Amount] = {Extracted_Qty} x 5 USD = {Pay Amount} USD"

    #Step 22
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Trip Plan"

    #Step 23
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan(s)|
      |SysData=>Trip_Plan_ID       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    #Step 24
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 25
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Departure Date |
      | 3              |
    Then Update "2" leg details
      | Arrival Date |
      | 3            |
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying with "Save was successful."
    Then Close All Toast message

    #Step 26
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds

    #Step 27
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 28
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 29 and expected result e
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "3" Seconds
    Then Set "PaidFrom3" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "Paid_From" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"

    Then Verify table has "2" records with "Calculation Tier" as "SysData=>Calc_TierID_1" and "Paid From Type" as "Trip Plan Leg" and "Paid From" as "SysData=>PaidFrom3"
    Then Verify table has "2" records with "Calculation Tier" as "SysData=>Calc_TierID_2" and "Paid From Type" as "Trip Plan Leg" and "Paid From" as "SysData=>Paid_From"

    #step 30
    Then Click on "Pay Detail-" with "Participant Name" as "Dave Fleet Carrier One 8 (Driver)" and "Calculation Tier" as "SysData=>Calc_TierID_1" and "Paid From" as "SysData=>PaidFrom1"

    #Step 31 and expected result f
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount"

    #Step 32 and expected result g
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_1} calculation] = [From] < [Individual Trip Plan Leg Distance (Km)] <= [To] = 0 < {Extracted_Qty} <= 200"

    #Step 33 and expected result h
    Then Verify Logs displaying as "[{Calc_TierID_1} Pay Amount] = [Trip Plan Leg Distance Kilometers] x [Amount] = {Extracted_Qty} x 5 USD = {Pay Amount} USD"

   #Step 34
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 35
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Set "PaidFrom6" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Click on "Pay Detail-" with "Participant Name" as "Dave Fleet Carrier One 8 (Driver)" and "Calculation Tier" as "SysData=>Calc_TierID_2" and "Paid From" as "SysData=>PaidFrom6"
    Then Wait for "2" Seconds

    #Step 36 and expected result i
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty_1"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty_1" is within a cent of "SysData=>Loaded_Value"
    Then Multiple "SysData=>Extracted_Qty_1" with "3.5" and store in "ThreeDecimal_Pay_Amount_1" and "TwoDecimal_Pay_Amount_1"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_1"

    #Step 37
    Then Verify the field value "SysData=>Extracted_Qty_1" has "3" decimal places

    #Step 38 and expected result j
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_2} calculation] = [From] < [Individual Trip Plan Leg Distance (Km)] <= [To] = 500 < {Extracted_Qty_1} <= (NULL)"

   #Step 39 and expected result k
    Then Set "Pay Amount" with "SysData=>ThreeDecimal_Pay_Amount_1"
    Then Verify the Logs displaying as "[{Calc_TierID_2} Pay Amount] = [Trip Plan Leg Distance Kilometers] x [Amount] = {Extracted_Qty_1} x 3.50 USD = {Pay Amount} USD"

    #Step 40
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 41
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Set "PaidFrom7" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Click on "Pay Detail-" with "Participant Name" as "Tractor 1008 (Fleet Asset)" and "Calculation Tier" as "SysData=>Calc_TierID_2" and "Paid From" as "SysData=>PaidFrom7"
    Then Wait for "2" Seconds

    #Step 42
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify Assertion for "Pay Amount" contains "SysData=>ThreeDecimal_Pay_Amount_1"

    #Step 43 and expected result m
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_2} calculation] = [From] < [Individual Trip Plan Leg Distance (Km)] <= [To] = 500 < {Extracted_Qty_1} <= (NULL)"

    #Step 44 and expected result n
    Then Set "Pay Amount" with "SysData=>ThreeDecimal_Pay_Amount_1"
    Then Verify the Logs displaying as "[{Calc_TierID_2} Pay Amount] = [Trip Plan Leg Distance Kilometers] x [Amount] = {Extracted_Qty_1} x 3.5 USD = {Pay Amount} USD"