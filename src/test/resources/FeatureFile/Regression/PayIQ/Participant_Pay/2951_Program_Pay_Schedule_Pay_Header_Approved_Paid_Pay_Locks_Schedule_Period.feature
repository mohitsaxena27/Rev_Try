Feature:2951 - Program Pay Schedule Pay Header Approved Paid Pay Locks Schedule Period

  @API @Regression @PayIQ  @WEB @SingleCurrency @2951 @PayHeader
  Scenario: 2951 - Program Pay Schedule Pay Header Approved Paid Pay Locks Schedule Period

    When Login into Salesforce
    Then Delete All Records with name "Pay Header-" for "rtms9__Pay_Header__c"

   #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    #Step 2
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

    #Step 3
    Then Wait for "5" Seconds
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "8" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "6" Seconds

    #Step 4
    Then Navigate to stored URL for "PayIQ_Program_1"
    #Step 5 and expected result a
    Then Click on Edit icon on Label "Pay Schedule"
    Then Update details
      |Pay Schedule |
      | Two Year Period   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Schedule |
      | Two Year Period   |

   #Step 6
    Then Set "Payroll_Description" with "Pay Period- (" and "2024-01-01 to 2024-01-31" and ")"
    Then Open "Pay Headers" from App Launcher
    Then Set "Current" with "(2024-01-01 to 2024-01-31)"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Test User0 (User)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "2" Seconds
    #Step 7
  Then Get Details
    |Pay Header ID|
    |             |
   Then Capture the current URL for "Pay_Header_Page"
    #Step 8
  Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
    |Payment Status|
    | Approved     |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds
    Then Scroll into Section "Payroll Status"
    Then Verify Details
      |Payment Status|
      | Approved     |

    #Step 9
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 10
    Then Click on Edit icon on Label "Pay Schedule"
    Then Update details
      |Pay Schedule |
      | Test Pay Schedule   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    #expected result b
    Then Verify Normalized Text displaying as "Pay has already been approved for this program, the Pay Schedule may not be changed.  Please enter a new PayIQ Program if you need to pay on a different schedule."

    #Step 11
    Then Click on "Cancel" button
    Then Wait for "2" Seconds
  #Step 12
    Then Navigate to stored URL for "Pay_Header_Page"
    #Step 13
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      |Payment Status|
      | Paid    |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Verify Details
      |Payment Status|
      | Paid     |

    #Step 14
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 15 and expected result c
    Then Click on Edit icon on Label "Pay Schedule"
    Then Update details
      |Pay Schedule |
      | Test Pay Schedule   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Pay has already been approved for this program, the Pay Schedule may not be changed.  Please enter a new PayIQ Program if you need to pay on a different schedule."

    #Step 16
    Then Click on "Cancel" button
    Then Wait for "2" Seconds

    #Step 17
    Then Open "Pay Schedules" from App Launcher
    Then Search and Select "Test Pay Schedule" from List
    Then Wait for "4" Seconds
    Then Capture the current URL for "PaySchedulePage"

    #Step 18
    Then Scroll Until Related List for "Pay Periods"
    Then Click on "Pay Period-" with "Period Beginning" as "1/1/2024"

    #Step 19
    Then Click on Edit icon on Label "Period Beginning"
    Then Set "Period_Beginning" with "1/2/2024"
    Then Update details
    |Period Beginning|
    |  SysData=>Period_Beginning    |

    #Step 20 and expected result d
    Then Click on "SaveEdit" button on Details Page
    Then Verify Normalized Text displaying as "Pay has already been approved for this period, the period beginning date may not be changed."
    Then Capture the current URL for "Pay_Schedule_URL"

    #Step 21
    Then Click on "Cancel" button
    Then Wait for "2" Seconds
    #Step 22
    Then Navigate to stored URL for "Pay_Header_Page"

    #Step 23
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      |Payment Status|
      | Pending     |
    Then Click on "SaveEdit" button on Details Page

    #Step 24
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 25 and expected result e
    Then Click on Edit icon on Label "Pay Schedule"
    Then Update details
      |Pay Schedule |
      | Test Pay Schedule   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Schedule |
      | Test Pay Schedule   |

    #Step 26 & 27
    Then Navigate to stored URL for "Pay_Schedule_URL"
    #Step 28
    Then Click on Edit icon on Label "Period Beginning"
    Then Set "Period_Beginning_1" with "1/2/2024"
    Then Update details
      |Period Beginning|
      |  SysData=>Period_Beginning_1    |

     #Step 29 and expected result d
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Period Beginning|
      |  SysData=>Period_Beginning_1    |

