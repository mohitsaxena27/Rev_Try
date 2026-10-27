Feature:2858 - GenerateAdjustmentsJob- Minimum Pay Rules

  @API @Regression @PayIQ  @WEB @SingleCurrency @2858 @PayIQ_Logs
  Scenario: 2858 - GenerateAdjustmentsJob- Minimum Pay Rules
    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"

    # Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

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

    # Step 3 & 4
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Accessorial Rules" section
    Then Update details
      | Type                      | Accessorial | Rule      | Amount |
      | Trip Plan Leg Accessorial | Stop Off    | Flat Rate | 75     |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Accessorial Rule-"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Trip Plan Leg Accessorial" and "Accessorial" as "Stop Off"
    Then Wait for "4" Seconds
    Then Capture the current URL for "Accessorial_Rules_1"
    Then Set Key "Accessorial_Rules_SFID_1" page Record Id with "rtms9__Accessorial_Rule__c"

    # Step 5 & 6
    Then Open "Pay Schedules" from App Launcher
    Then Search and Select "Test Pay Schedule" from List
    Then Go to "Min Pay Rules" Tab
    Then Click on "New" button on "Minimum Pay Rules" section
    Then Update details
      | Payee Type | Minimum Pay (Per Period) | User      | Currency              |
      | User       | 5000                     | User User | CAD - Canadian Dollar |

    # Step 7
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Minimum Pay Rule-"
    Then Get "Minimum Pay Rule-" Name with "Payee Name" as "User User" and store in "Minimum Pay Rule_1"
    Then Click on "Minimum Pay Rule-" with "Payee Name" as "User User" and "Minimum Pay (Per Period)" as "CAD 5,000.00 (USD 3,731.34)"
    Then Wait for "4" Seconds
    Then Capture the current URL for "Minimum_Pay_Rules_1"
    Then Set Key "Minimum_Pay_Rules_SFID_1" page Record Id with "rtms9__Minimum_Pay_Rule__c"

    #Step 8
    Then Open "Pay Schedules" from App Launcher
    Then Search and Select "Test Pay Schedule" from List
    Then Go to "Min Pay Rules" Tab
    Then Click on "New" button on "Minimum Pay Rules" section
    Then Update details
      | Payee Type | Minimum Pay (Per Period) | Driver                   | Currency          |
      | Driver     | 6000                     | Dave Fleet Carrier One 8 | USD - U.S. Dollar |

    # Step 9
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Minimum Pay Rule-"
    Then Get "Minimum Pay Rule-" Name with "Payee Name" as "Dave Fleet Carrier One 8" and store in "Minimum Pay Rule_2"
    Then Click on "Minimum Pay Rule-" with "Payee Name" as "Dave Fleet Carrier One 8" and "Minimum Pay (Per Period)" as "USD 6,000.00"
    Then Wait for "4" Seconds
    Then Capture the current URL for "Minimum_Pay_Rules_2"
    Then Set Key "Minimum_Pay_Rules_SFID_2" page Record Id with "rtms9__Minimum_Pay_Rule__c"

    # Step 10 & 11
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    # Step 12 & 13
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Driver                   | Load  |
      | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "5" Seconds

    # Step 14
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

    # Step 15
    Then Store date with month offset 0 and day 15 in format "MMM dd, yyyy" into "Current_Month_15"
    Then Store date with month offset 0 and day 17 in format "MMM dd, yyyy" into "Current_Month_17"
    Then Update "1" leg details
      | Due Out Date              | Due Out Time |
      | SysData=>Current_Month_15 | 8:00 AM      |
    Then Update "1" leg details
      | Appointment Date          | Appointment Start Time | Appointment End Time |
      | SysData=>Current_Month_17 | 10:00 AM               | 10:00 AM             |

    # Step 16
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds

    # Step 17 & 18
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Accessorial |
      | Stop Off    |
    Then Wait for "5" Seconds
    Then Verify "1" leg details
      | Unit Price | Total |
      | 75         | 75.00 |

    # Step 19 & 20
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    Then Update "1" leg details
      | Arrival Date              |
      | SysData=>Current_Month_15 |

    # Step 21
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."

    # Step 22
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Wait for "5" Seconds
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "20" Seconds
    # Step 23 & 24
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User (User)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

    # Step 25 and expected result a
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Addition" and "Type" as "Other"
    Then Verify Details
      | Rate | Item Total |
      | USD  | USD        |

    # Step 26 and expected result b
    Then Navigate Browser Back
    Then Scroll into Section "Totals"
    Then Verify Details
      | Grand Total  |
      | USD 3,731.34 |

    # Step 27,28
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

    # Step 29 and expected result c
    Then Scroll into Section "Totals"
    Then Verify Details
      | Grand Total  |
      | USD 6,000.00 |

    # Step 30,31 and expected result d
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Addition" and "Type" as "Other"
    Then Verify Details
      | Category | Source                      |
      | Addition | SysData=>Minimum Pay Rule_2 |

    # Step 32 and expected result e
    Then Scroll into Section "System Information"
    Then Click on Edit icon on Label "Currency"
    Then Update details
      | Currency              |
      | CAD - Canadian Dollar |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Message displaying with "Pay Adjustment currency must match pay header currency"
    Then Verify Message displaying with "We hit a snag."