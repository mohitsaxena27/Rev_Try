Feature:2945 - GenTierPayJob- Calc Tier: Trip Plan Leg Distance Change

  @API @Regression @PayIQ  @WEB @SingleCurrency @2945 @PayIQ_Logs
  Scenario: 2945 - GenTierPayJob- Calc Tier: Trip Plan Leg Distance Change

    When Login into Salesforce

   #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Driver Pay - Per Mile" from List
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
    Then Click on "Calculation Tier-" with "Calculation Description" as "Rate per Trip Plan Leg Mile" and "From (>)" as "500.00" and "To (<=)" as ""
    Then Wait for "2" Seconds
    Then Get Details
    |Calculation Tier ID|
    |                   |

    #Step 5 & 6
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

    #Step 7
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 8
    Then Update "1" Segment details
      | Search       | Driver                    |
      | Tractor 1007 | Dave Fleet Carrier One 7 |
    Then Update "1" leg details
      | Start Type | Location     |
      | Location   | Boston Beans |
    Then Update "1" leg details
      | Due Out Date |
      | 0            |
    Then Update "1" leg details
      | End Type | Location_2      | Appointment Date |
      | Location | Chicago Pizza | 3                |
    Then Wait for "1" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date |
      | 3           |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 9
    Then Get "Unloaded (mi/km)" from "1" Segment mileage box and store into "Unloaded_Value"

    #Step 10
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 11
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 12
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 13 & 14
    Then Open "Pay Details" from App Launcher
    Then Wait for "5" Seconds
    Then Recently Viewed to All
    Then Click on "Pay Detail-" with "Participant Name" as "Dave Fleet Carrier One 7 (Driver)" and "Trip Plan Segment" as "Segment 1" and "Trip Plan Leg" as "Leg 1" and "Trip Plan" as "SysData=>Trip_Plan_ID"

      #Step 15 , expected a
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Extracted_Qty" is within a cent of "SysData=>Unloaded_Value"
    Then Multiple "SysData=>Extracted_Qty" with "1.5" and store in "ThreeDecimal_Pay_Amount" and "TwoDecimal_Pay_Amount"
    Then Get Details
    |Pay Amount|
    |          |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount"

    #Step 16
    Then Verify the field value "SysData=>Extracted_Qty" has "3" decimal places

    #Step 17 & expected b
    Then Go to "Logs" Tab
    Then Set "Program" with "Individual Trip Plan Leg Distance (Miles)"
    Then Set "Qty" with "SysData=>Extracted_Qty"
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 500 < {Qty} <= (NULL)"

    #Step 18 & expected c
    Then Set "Program" with "Trip Plan Leg Distance Miles"
    Then Set "Qty" with "SysData=>Extracted_Qty"
    Then Set "Pay Amount" with "SysData=>ThreeDecimal_Pay_Amount"
    Then Verify Logs displaying as "[{Calculation Tier ID} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Qty} x 1.5 USD = {Pay Amount} USD"

#    Step 19 & 20
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan Start Date|
      |Today       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    #Step 21
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 22
    Then Update "1" leg details
      | Location_2          |
      | Denver Deli Meats |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 23 & 24
    Then Get "Unloaded (mi/km)" from "1" Segment mileage box and store into "Unloaded_Value"
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 25 & 26
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 27 & expected d
    Then Open "Pay Details" from App Launcher
    Then Wait for "5" Seconds
    Then Recently Viewed to All
    Then Verify table contains "2" records with "Trip Plan" as "SysData=>Trip_Plan_ID" and "Trip Plan Segment" as "Segment 1" and "Trip Plan Leg" as "Leg 1"

    #Step 28
    Then Click on "Pay Detail-" with "Participant Name" as "Dave Fleet Carrier One 7 (Driver)" and "Trip Plan Segment" as "Segment 1" and "Trip Plan Leg" as "Leg 1" and "Trip Plan" as "SysData=>Trip_Plan_ID"
    Then Wait for "2" Seconds
    #Step 29, expected e, 30
    Then Get Details
      | Qty |
      |     |
    Then extract the numeric value from "SysData=>Qty" and store in "Extracted_Qty"
    Then Verify Details
      | Pay Header  |
      | Pay Header- |
    Then Verify "SysData=>Qty" is within a cent of "SysData=>Unloaded_Value"
    Then Multiple "SysData=>Extracted_Qty" with "1.5" and store in "ThreeDecimal_Pay_Amount" and "TwoDecimal_Pay_Amount"
    Then Get Details
      |Pay Amount|
      |          |
    Then Verify Assertion for "Pay Amount" contains "SysData=>TwoDecimal_Pay_Amount"
    Then Verify the field value "SysData=>Extracted_Qty" has "3" decimal places

      #Step 31 & expected f
    Then Go to "Logs" Tab
    Then Set "Qty" with "SysData=>Extracted_Qty"
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Trip Plan Leg Distance (Miles)] <= [To] = 500 < {Qty} <= (NULL)"

     #Step 32 & expected g
    Then Set "Qty" with "SysData=>Extracted_Qty"
    Then Set "Pay Amount" with "SysData=>ThreeDecimal_Pay_Amount"
    Then Verify Logs displaying as "[{Calculation Tier ID} Pay Amount] = [Trip Plan Leg Distance Miles] x [Amount] = {Qty} x 1.5 USD = {Pay Amount} USD"
