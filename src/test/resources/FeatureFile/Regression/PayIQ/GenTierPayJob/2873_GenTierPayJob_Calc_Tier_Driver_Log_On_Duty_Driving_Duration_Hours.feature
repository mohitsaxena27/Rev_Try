Feature:2873 - GenTierPayJob- Calc Tier: Driver Log On Duty Driving Duration Hours

  @API @Regression @PayIQ  @WEB @SingleCurrency @2873 @PayIQ_Logs
  Scenario: 2873 -  GenTierPayJob- Calc Tier: Driver Log On Duty Driving Duration Hours

    When Login into Salesforce
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"
    #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Driver Pay - Driver Logs" from List

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
    Then Get "Calculation Tier-" Name with "From (>)" as "50.00" and store in "Calc_TierID_1"

     #Step 5
    Then Get "Calculation Tier-" Name with "From (>)" as "100.00" and store in "Calc_TierID_2"

   #Step 6
    Then Open "Driver Logs" from App Launcher
    Then Wait for "3" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Driver                        |Remarks|
      | Dave Fleet Carrier One 10  |Calculation Tier from 50-100|

    Then Update Legend details
      | Start Time, Date | End Time, Date| Start Time, Time | End Time, Time |Certified as of, Date|Certified as of, Time|
      | 0                | 3             | 12:00 PM                | 12:00 PM  |0                  |         12:00 PM            |
    Then Scroll into Section "Day Summary"
    Then Update details
    |Driving Duration |On Duty Duration|
    |    25           |          60    |
    Then Scroll into Section "Certification"
    Then Update details
      | Certification Status |
      | Certified            |
    Then Click on "SaveEdit" button
    Then Wait for "6" Seconds
    Then Set Key "DriverLog_SFID_1" page Record Id with "rtms__DriverLog__c"
    Then Close Toast message
    Then Capture the current URL for "Driver_Log_1"

     #Step 7
    Then Open "Driver Logs" from App Launcher
    Then Wait for "3" Seconds
    Then Click on button with Title "New"
    Then Wait for "3" Seconds
    Then Update details
      | Driver                        |Remarks|
      | Dave Fleet Carrier One 10  |Calculation Tier from 100-500|
   Then Store date with month offset -1 and day 1 in format "MMM dd, yyyy" into "last_Month_1"
    Then Store date with month offset -1 and day 20 in format "MMM dd, yyyy" into "last_Month_20"
    Then Store date with month offset -1 and day 21 in format "MMM dd, yyyy" into "last_Month_21"

    Then Update Legend details
      | Start Time, Date       | End Time, Date | Start Time, Time | End Time, Time |Certified as of, Date|Certified as of, Time|
      | SysData=>last_Month_1  | SysData=>last_Month_20| 12:00 PM         | 12:00 PM       |SysData=>last_Month_21                 |         12:00 PM            |
    Then Scroll into Section "Day Summary"
    Then Update details
      |Driving Duration |On Duty Duration|
      |    225.25          |          275.50   |
    Then Scroll into Section "Certification"
    Then Update details
      | Certification Status |
      | Pending           |
    Then Click on "SaveEdit" button
    Then Wait for "6" Seconds
    Then Set Key "DriverLog_SFID_2" page Record Id with "rtms__DriverLog__c"
    Then Close Toast message
    Then Capture the current URL for "Driver_Log_2"
    #Step 8
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 9
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #step 10
#    Then Open "Driver Logs" from App Launcher
#    Then Get "Name" from "rtms__DriverLog__c" using "rtms__Remarks__c" with value "Calculation Tier from 50-100" & "rtms__Certification_Status__c" with value "Certified" and Store into "DriverlogRecords"
#    Then Search and Select "SysData=>DriverlogRecords" from List
    Then Navigate to stored URL for "Driver_Log_1"
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    
    #Step 13
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Participant Name" as "Dave Fleet Carrier One 10 (Driver)" and "Calculation Tier" as "SysData=>Calc_TierID_1"
    Then Wait for "2" Seconds
    #Step 14 and expected result a
    Then Verify Details
    |Pay Header |Qty   |Pay Amount|
    |Pay Header-|25 hrs|USD 1,000.00|

    #Step 15 and expected result b
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_1} calculation] = [From] < [Individual Driver Log (On Duty Duration) Hours] <= [To] = 50 < 60 <= 100"

    #Step 16 and expected result c
    Then Verify Logs displaying as "[{Calc_TierID_1} Pay Amount] = [Driver Log Driving Duration (Hours)] x [Amount] = 25 x 40 USD = 1,000 USD"
    
    #Step 17
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page

    #Step 18 and expected result d
    Then Scroll into Section "Totals"
    Then Get Details
    |Total Pay|
    |         |
    Then Then Verify "Total Pay" is at least "USD 1,000"

#    #step 19
    Then Navigate to stored URL for "Driver_Log_2"
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"

    #Step 21
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Participant Name" as "Dave Fleet Carrier One 10 (Driver)" and "Calculation Tier" as "SysData=>Calc_TierID_2"
    Then Wait for "2" Seconds
    #Step 22 and expected result e
    Then Verify Details
      |Pay Header |Qty   |Pay Amount|
      |Pay Header-|225.25 hrs| USD 6,757.50|

    #Step 23 and expected result f
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calc_TierID_2} calculation] = [From] < [Individual Driver Log (On Duty Duration) Hours] <= [To] = 100 < 275.5 <= 500"

    #Step 16 and expected result g
    Then Verify Logs displaying as "[{Calc_TierID_2} Pay Amount] = [Driver Log Driving Duration (Hours)] x [Amount] = 225.25 x 30 USD = 6,757.5 USD"

    #Step 17
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    #Step 18 and expected result h
    Then Scroll into Section "Totals"
    Then Get Details
      |Total Pay|
      |         |
    Then Then Verify "Total Pay" is at least "USD 6,757.50"






