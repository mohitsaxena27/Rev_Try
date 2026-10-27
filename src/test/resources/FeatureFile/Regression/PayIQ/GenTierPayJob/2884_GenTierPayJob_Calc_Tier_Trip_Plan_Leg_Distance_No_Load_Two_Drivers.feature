Feature: 2884 - GenTierPayJob- Calc Tier: Trip Plan Leg Distance/No Load/Two Drivers

  @API @Regression @PayIQ @WEB @SingleCurrency @2884 @PayIQ_Logs
  Scenario: 2884 - GenTierPayJob- Calc Tier: Trip Plan Leg Distance/No Load/Two Drivers

    When Login into Salesforce

    # Step 1
    Then Open "PayIQ Programs" from App Launcher

    # Step 2
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    # Step 3
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

    # Step 4
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Rate per Driver Log (Driving Distance)/Trip Plan Leg Mile" and "From (>)" as "0.00" and "Amount" as "USD 0.50"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Verify Details
      | Amount   |
      | USD 0.50 |

    # Step 5
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load

    # Step 6
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    # Step 7
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    # Step 8
    Then Update "1" Segment details
      | Search       | Driver                    |
      | Tractor 1008 | Bruce Fleet Carrier Two 8 |
    Then Update "1" leg details
      | Start Type | Location     |
      | Location   | Boston Beans |
    Then Update "1" leg details
      | Due Out Date |
      | 0            |
    Then Update "1" leg details
      | End Type | Location_2        | Appointment Date |
      | Location | Denver Deli Meats | 3                |
    Then Wait for "1" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date |
      | 0            |
    Then Wait for "2" Seconds
    Then Click on "Add Driver" on "1" Segment
    Then Wait for "3" Seconds
    Then Update "1" Segment details
      | Driver_2                                          |
      | Dave Fleet Carrier One 8 |
    Then Wait for "1" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "8" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    # Step 9
    Then Get "Unloaded (mi/km)" from "1" Segment mileage box and store into "Unloaded_Value"

    # Step 10
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    # Step 11
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    # Step 12
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 13, 14 & 15 - Expected a
    Then Set "EstimatedFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Get Count from "rtms9__Pay_Detail__c" using "rtms9__Paid_From__c" with value "SysData=>EstimatedFrom" and Store onto "PayDetailID"
    Then Verify Assertion for "PayDetailID_count" contains "2"

    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c LIKE '%Bruce Fleet Carrier Two 8 (Driver)%' AND rtms9__Trip_Plan_Segment_Name__c" with contains "Segment 1" & "rtms9__Trip_Plan_Name__c" with contains "SysData=>Trip_Plan_ID" and Store into "PayDetailName_1"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_1" from the Global search

    # Step 16 & Expected b
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty_1"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty_1" is within a cent of "SysData=>Unloaded_Value"
    Then Multiple "SysData=>Extracted_Qty_1" with "0.5" and store in "ThreeDecimal_Pay_Amount_1" and "TwoDecimal_Pay_Amount_1"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_1"

    # Step 17
    Then Verify the field value "SysData=>Extracted_Qty_1" has "3" decimal places

    # Step 18 & Expected c
    Then Go to "Logs" Tab
    Then Set "Qty" with "SysData=>Extracted_Qty_1"
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 0 < {Qty} <= (NULL)"

    # Step 19 & Expected d
    Then Set "Qty" with "SysData=>Extracted_Qty_1"
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Qty} x 0.5 USD"

    # Step 20 & 21
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c LIKE '%Dave Fleet Carrier One 8 (Driver)%' AND rtms9__Trip_Plan_Segment_Name__c" with contains "Segment 1" & "rtms9__Trip_Plan_Name__c" with contains "SysData=>Trip_Plan_ID" and Store into "PayDetailName_2"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_2" from the Global search

    # Step 22 & Expected e
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty_2"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty_2" is within a cent of "SysData=>Unloaded_Value"
    Then Multiple "SysData=>Extracted_Qty_2" with "0.5" and store in "ThreeDecimal_Pay_Amount_2" and "TwoDecimal_Pay_Amount_2"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_2"

    # Step 23 & Expected f
    Then Go to "Logs" Tab
    Then Set "Qty" with "SysData=>Extracted_Qty_2"
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 0 < {Qty} <= (NULL)"

    # Step 24 & Expected g
    Then Set "Qty" with "SysData=>Extracted_Qty_2"
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Qty} x 0.5 USD"

    # Step 25
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    # Step 26
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan(s)|
      |SysData=>Trip_Plan_ID       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    # Step 27
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    # Step 28
    Then Click on button with Title "Add Segment Below"
    Then Wait for "4" Seconds

    # Step 29
    Then Update "2" Segment details
      | Search       |
      | Tractor 1008 |
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Start Type | Location          | Due Out Date |
      | Location   | Denver Deli Meats | 3            |
    Then Update "2" leg details
      | End Type | Location_2    | Appointment Date |
      | Location | Chicago Pizza | 7                |
    Then Wait for "1" Seconds

    # Step 30
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Departure Date |
      | 3              |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    # Step 31
    Then Get "Unloaded (mi/km)" from "2" Segment mileage box and store into "Unloaded_Value_2"

    # Step 32
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    # Step 33
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    # Step 34
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 35 & 36
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c LIKE '%Tractor 1008 (Fleet Asset)%' AND rtms9__Trip_Plan_Segment_Name__c" with contains "Segment 1" & "rtms9__Trip_Plan_Name__c" with contains "SysData=>Trip_Plan_ID" and Store into "PayDetailName_3"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_3" from the Global search

    # Step 37  & Expected h
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty_3"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty_3" is within a cent of "SysData=>Unloaded_Value"
    Then Multiple "SysData=>Extracted_Qty_3" with "0.5" and store in "ThreeDecimal_Pay_Amount_3" and "TwoDecimal_Pay_Amount_3"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_3"

    # Step 38
    Then Verify the field value "SysData=>Extracted_Qty_3" has "3" decimal places

    # Step 39 & Expected i
    Then Go to "Logs" Tab
    Then Set "Qty" with "SysData=>Extracted_Qty_3"
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 0 < {Qty} <= (NULL)"

    # Step 40 & Expected j
    Then Set "Qty" with "SysData=>Extracted_Qty_3"
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Qty} x 0.5 USD"

    # Step 41
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    # Step 42
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan(s)|
      |SysData=>Trip_Plan_ID       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    # Step 43
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    # Step 44
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Arrival Date |
      | 7            |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    # Step 45
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    # Step 46
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 47 & 48
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c LIKE '%Bruce Fleet Carrier Two 8 (Driver)%' AND rtms9__Trip_Plan_Segment_Name__c" with contains "Segment 2" & "rtms9__Trip_Plan_Name__c" with contains "SysData=>Trip_Plan_ID" and Store into "PayDetailName_4"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_4" from the Global search

    # Step 49 & Expected k
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty_4"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty_4" is within a cent of "SysData=>Unloaded_Value_2"
    Then Multiple "SysData=>Extracted_Qty_4" with "0.5" and store in "ThreeDecimal_Pay_Amount_4" and "TwoDecimal_Pay_Amount_4"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_4"

    # Step 50 & Expected l
    Then Go to "Logs" Tab
    Then Set "Qty" with "SysData=>Extracted_Qty_4"
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 0 < {Qty} <= (NULL)"

    # Step 51 & Expected m
    Then Set "Qty" with "SysData=>Extracted_Qty_4"
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Qty} x 0.5 USD"

    # Step 52 & 53
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c LIKE '%Dave Fleet Carrier One 8 (Driver)%' AND rtms9__Trip_Plan_Segment_Name__c" with contains "Segment 2" & "rtms9__Trip_Plan_Name__c" with contains "SysData=>Trip_Plan_ID" and Store into "PayDetailName_5"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_5" from the Global search

    # Step 54 & Expected n
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty_5"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty_5" is within a cent of "SysData=>Unloaded_Value_2"
    Then Multiple "SysData=>Extracted_Qty_5" with "0.5" and store in "ThreeDecimal_Pay_Amount_5" and "TwoDecimal_Pay_Amount_5"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_5"

    # Step 55 & Expected o
    Then Go to "Logs" Tab
    Then Set "Qty" with "SysData=>Extracted_Qty_5"
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 0 < {Qty} <= (NULL)"

    # Step 56 & Expected p
    Then Set "Qty" with "SysData=>Extracted_Qty_5"
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Qty} x 0.5 USD"

    # Step 57
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    # Step 58
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan(s)|
      |SysData=>Trip_Plan_ID       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    # Step 59
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    # Step 60
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Departure Date |
      | 7              |
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "4" Seconds

    # Step 61
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    # Step 62
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 63 & 64
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c LIKE '%Tractor 1008 (Fleet Asset)%' AND rtms9__Trip_Plan_Segment_Name__c" with contains "Segment 2" & "rtms9__Trip_Plan_Name__c" with contains "SysData=>Trip_Plan_ID" and Store into "PayDetailName_6"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_6" from the Global search

    # Step 65   & Expected q
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty_6"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty_6" is within a cent of "SysData=>Unloaded_Value_2"
    Then Multiple "SysData=>Extracted_Qty_6" with "0.5" and store in "ThreeDecimal_Pay_Amount_6" and "TwoDecimal_Pay_Amount_6"
    Then Get Details
      | Pay Amount |
      |            |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount_6"

    # Step 66  & Expected r
    Then Go to "Logs" Tab
    Then Set "Qty" with "SysData=>Extracted_Qty_6"
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 0 < {Qty} <= (NULL)"

    # Step 67  & Expected s
    Then Set "Qty" with "SysData=>Extracted_Qty_6"
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Qty} x 0.5 USD"
