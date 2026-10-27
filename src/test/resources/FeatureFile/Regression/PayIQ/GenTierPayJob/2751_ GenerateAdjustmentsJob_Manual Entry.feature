Feature:2751 -  GenerateAdjustmentsJob- Manual Entry

  @API @Regression @PayIQ  @WEB @SingleCurrency @2751 @PayIQ_Logs
  Scenario: 2751 - GenerateAdjustmentsJob- Manual Entry

    When Login into Salesforce

    # Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search And Select "PayIQProgram Individual Load Revenue (Quoted)" from Search List
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program_1"

    # Step 3
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "3" Seconds

    # Step 4 & 5
    Then Open "Pay Headers" from App Launcher
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ (Contact)" & "rtms9__Payroll_Description__c" with contains "Pay Period-1 (2024-02-01 to 2024-02-29)" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "5" Seconds
    Then Capture the current URL for "Pay_Header"

    # Step 6
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Pay Header ID |
      |               |
    Then Get Details
      | Total Pay | Total Additions | Total Deductions | Grand Total |
      |           |                 |                  |             |

    # Step 7
    Then Scroll Until Related List for "Pay Adjustments"
    Then Wait for "4" Seconds
    Then Click on "New" button on "Pay Adjustments" section
    Then Wait for "4" Seconds

    # Step 8
    Then Update details
      | Transaction Date | Category | Description           | Type  | Qty | Rate  | Receipt Attached | Status  |
      | 1                | Addition | 2751 addition $123.45 | Other | 2   | 38.28 | True             | Pending |

    # Step 9
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    # Expected result a
    Then Verify Message displaying as "Pay Adjustment-"
    Then Sum of "SysData=>Total Pay" and "76.56" and Store on to "Grand_Total_1"
    Then Get "Pay Adjustment-" Name with "Category" as "Addition" and store in "PayAdj1"

    # Step 10 Expected result b
    Then Scroll into Section "Totals"
    Then Verify Details
      | Total Pay          | Total Additions | Total Deductions | Grand Total  |
      | SysData=>Total Pay | USD 76.56       | USD 0.00         | SysData=>Grand_Total_1 |

    # Step 11 & 12, 13 Expected result c,d
    Then Scroll Until Related List for "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Pay Adjustments" section
    Then Wait for "4" Seconds
    Then Update details
      | Transaction Date | Category  | Type          | Qty  | Rate | Receipt Attached | Status       |
      | -1               | Deduction | Fuel Purchase | 0.25 | 200  | False            | Under Review |

    # Step 12
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    # Expected result c
    Then Verify Message displaying as "Pay Adjustment-"
    Then Get "Pay Adjustment-" Name with "Category" as "Deduction" and store in "PayAdj2"

    #Step 13
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Wait for "2" Seconds
    Then Scroll into Section "Totals"
    Then Sum of "SysData=>Grand_Total_1" and "-50.00" and Store on to "Grand_Total_2"

    #Expected d
    Then Verify Details
      | Total Pay          | Total Additions | Total Deductions | Grand Total  |
      | SysData=>Total Pay | USD 76.56       | USD -50.00       | SysData=>Grand_Total_2 |

    # Step 14
    Then Scroll Until Related List for "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Fuel Purchase"
    Then Wait for "3" Seconds
    Then Set Key "Pay_Adj_Deduction" page Record Id with "rtms9__Pay_Adjustment__c"
    Then Click on Edit icon on Label "Qty"

    # Step 15
    Then Update details
      | Qty |
      | 2.5 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    # Step 16 & 17
    Then Navigate to stored URL for "Pay_Header"
    Then Wait for "3" Seconds

    # Expected e
    Then Scroll into Section "Totals"
    Then Sum of "SysData=>Grand_Total_1" and "-500.00" and Store on to "Grand_Total_3"

    Then Verify Details
      | Total Pay          | Total Additions | Total Deductions | Grand Total |
      | SysData=>Total Pay | USD 76.56       | USD -500.00      | SysData=>Grand_Total_3  |

    # Step 18
    Then Scroll Until Related List for "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Click on "Pay Adjustment-" with "Category" as "Addition" and "Type" as "Other"
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Rate"

    # Step 19
    Then Update details
      | Rate   |
      | -38.28 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    # Step 20
    Then Navigate to stored URL for "Pay_Header"
    Then Wait for "3" Seconds

    # Expected f
    Then Scroll into Section "Totals"
    Then Sum of "SysData=>Total Pay" and "-576.56" and Store on to "Grand_Total_7"

    Then Verify Details
      | Total Pay        | Total Additions | Total Deductions | Grand Total |
      | SysData=>Total Pay| USD -76.56      | USD -500.00      | SysData=>Grand_Total_7 |

    # Step 22 Expected result g
    Then Scroll Until Related List for "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Click on "Pay Adjustment-" with "Category" as "Addition" and "Type" as "Other"
    Then Verify Text displaying as "Pay Adjustment"
    Then Wait for "3" Seconds
    Then Click on "Delete" button
    Then Click on button with Title "Delete" on Modal
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Pay Adjustment-"

    # Step 23 expected result h
    Then Refresh current Page
    Then Scroll into Section "Totals"
    Then Sum of "SysData=>Total Pay" and "-500.00" and Store on to "Grand_Total_4"
    Then Verify Details
      | Total Pay          | Total Additions | Total Deductions | Grand Total |
      | SysData=>Total Pay | USD 0.00        | USD -500.00      | SysData=>Grand_Total_4  |