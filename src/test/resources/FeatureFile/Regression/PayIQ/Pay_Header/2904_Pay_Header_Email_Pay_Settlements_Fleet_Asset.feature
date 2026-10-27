Feature:2904 - Pay Header - Email Pay Settlements - Fleet Asset

  @API @Regression @PayIQ @WEB @MultiCurrency @2904 @PayHeader
  Scenario: 2904 - Pay Header - Email Pay Settlements - Fleet Asset

    When Login into Salesforce
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Store date with month offset 0 and day 18 in format "M/d/yyyy" into "Current_Month_18"
    Then Store date with month offset 0 and day 21 in format "M/d/yyyy" into "Current_Month_21"

    #Step 1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load

    #Step 2
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    #Step 3
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 4
    Then Update "1" Segment details
      | Search       | Driver                   | Load  |
      | Tractor 1008 | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "4" Seconds

    #Step 5
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "5" Seconds

    #Step 6
    Then Update "1" leg details
      | Due Out Date              | Due Out Time | Appointment Date          | Appointment Start Time | Appointment End Time |
      | SysData=>Current_Month_18 | 8:00 AM      | SysData=>Current_Month_21 | 10:00 AM               | 10:00 AM             |
    Then Wait for "2" Seconds

    #Step 7
    Then Click on button with Title "Save"
    Then Verify Text displaying as "Save was successful." -
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 8
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 9
    Then Update "1" leg details
      | Arrival Date              | Departure Date            |
      | SysData=>Current_Month_18 | SysData=>Current_Month_18 |

    #Step 10
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 11 & 12
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

    #Step 13 & 14
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds
    Then Go to "Configuration" Tab
    Then Set "ErrorEmail" with "EnvData=>EmailID"
    Then Wait for "3" Seconds
    Then Update details
      | Error Email         |
      | SysData=>ErrorEmail |
    Then Click on button "Save"
    Then Verify Message displaying with "Success PayIQ Configuration Saved"

    #Step 15
    Then Go to "Job Monitor" Tab
    Then Wait for "2" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "5" Seconds

    #Step 16 & 17
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1008 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "3" Seconds
    Then Navigate Browser Back
    Then Select Multiple Records from List
      | Record               |
      | SysData=>PayHeaderID |

    #Step 18 & Expected Result 1 (a)
    Then Click on "Email Pay Settlements" with Text

    # Expected a.a
    Then Verify Message displaying with "Successfully queued job to generate and email out pay settlements"
    Then Wait for "3" Seconds
    Then Verify Title displaying as "Pay Headers"

    #Step 19 & Expected Result 2 (b)
    Then Wait for Email to Receive On Email
    Then Set "ParticipantName" with "Tractor 1008"
    Then Set "Email_Content" with "SysData=>ParticipantName" and " does not have any \"To\" emails set"
    Then Set "Email_Subject" with "Could not send Pay Settlement email to " and "SysData=>ParticipantName"
    Then Verify Content "SysData=>Email_Content" in the email body with Subject "SysData=>Email_Subject"
    Then Reset Time to get New Email
    Then Wait for "10" Seconds

    #Step 20
    Then Search Records "SysData=>PayHeaderID" from List
    Then Select Multiple Records from List
      | Record               |
      | SysData=>PayHeaderID |

    #Step 21
    Then Click on "Email Combined Pay Settlement" with Text
    # Expected c.a & c.b
    Then Verify Message displaying with "Sent Combined Pay Settlement"
    Then Wait for "3" Seconds

    #Step 22 & Expected Result 4 (d)
    Then Wait for Email to Receive On Email
    Then Verify Content "Pay settlement is attached" in the email body with Subject "Pay Settlement"
    Then Verify the email attachment has "CollatedPaySettlement.pdf" as an attachment with subject "Pay Settlement"
    Then Reset Time to get New Email
    #Step 23 - 25
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "Tractor 1008" from List
    Then Click on Edit icon on Label "Pay Settlement Email To"
    Then Update details
      | Pay Settlement Email To | Pay Settlement Email CC |
      |                         | SysData=>ErrorEmail     |
    Then Enter Label "Pay Settlement Email To" TextArea as ""
    Then Enter Label "Pay Settlement Email CC" TextArea as "SysData=>ErrorEmail"
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Settlement Email To | Pay Settlement Email CC |
      |                         | SysData=>ErrorEmail     |
    Then Capture the current URL for "Fleet_Asset_Url"


    #Step 26 & 27
    Then Open "Pay Headers" from App Launcher
    Then Search Records "SysData=>PayHeaderID" from List
    Then Select Multiple Records from List
      | Record                       |
      | SysData=>PayHeaderID_Tractor |

    #Step 28 & Expected Result 5 (e)
    Then Click on "Email Pay Settlements" with Text

    Then Verify Message displaying with "Successfully queued job to generate and email out pay settlements"
    Then Wait for "5" Seconds

    #Step 29 & expected Result 5 (e)
    Then Wait for Email to Receive On Email
    Then Verify Content "SysData=>Email_Content" in the email body with Subject "SysData=>Email_Subject"

    #Step 30 - 32
    Then Navigate to stored URL for "Fleet_Asset_Url"
    Then Wait for "2" Seconds
#    Then Go to "PayIQ" Tab
#    Then Scroll into Section "Pay Settlement Email Settings"
    Then Click on Edit icon on Label "Pay Settlement Email To"
    Then Update details
      | Pay Settlement Email To | Pay Settlement Email CC |
      | SysData=>ErrorEmail     |                         |
    Then Enter Label "Pay Settlement Email To" TextArea as "SysData=>ErrorEmail"
    Then Enter Label "Pay Settlement Email CC" TextArea as ""
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Settlement Email To | Pay Settlement Email CC |
      | SysData=>ErrorEmail     |                         |

    #Step 33 & 34
    Then Open "Pay Headers" from App Launcher
    Then Search Records "SysData=>PayHeaderID" from List
    Then Select Multiple Records from List
      | Record               |
      | SysData=>PayHeaderID |

      #Step 35 & 36 / Expected Result 6 (f)
    Then Click on "Email Pay Settlements" with Text
    Then Verify Message displaying with "Successfully queued job to generate and email out pay settlements"
    Then Wait for "240" Seconds
    Then Wait for Email to Receive On Email
    Then Verify Content "Pay settlement is attached" in the email body with Subject "Pay Settlement"

    Then Set "AttachmentName" with "Tractor 1008 Pay Settlement " and "SysData=>Current_Month_Range"
    Then Set "Final_Attachment" with "SysData=>AttachmentName" and ".pdf"
    Then Verify the email attachment has "SysData=>Final_Attachment" as an attachment with subject "Pay Settlement"
    Then Reset Time to get New Email

    #Step 37 - 39
    Then Navigate to stored URL for "Fleet_Asset_Url"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Pay Settlement Email To"
    Then Set "Pay_Settlement_Email_To" with "SysData=>ErrorEmail" and ";test1@example.com"
    Then Update details
      | Pay Settlement Email To          | Pay Settlement Email CC             |
      | SysData=>Pay_Settlement_Email_To | test2@example.com;test3@example.com |
    Then Enter Label "Pay Settlement Email To" TextArea as "SysData=>Pay_Settlement_Email_To"
    Then Enter Label "Pay Settlement Email CC" TextArea as "test2@example.com;test3@example.com"
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 40 & 41
    Then Open "Pay Headers" from App Launcher
    Then Search Records "SysData=>PayHeaderID" from List
    Then Select Multiple Records from List
      | Record               |
      | SysData=>PayHeaderID |

    #Step 42 & 43 / Expected Result 7 (g)
    Then Click on "Email Pay Settlements" with Text
    Then Verify Message displaying with "Successfully queued job to generate and email out pay settlements"
    Then Wait for "5" Seconds
    Then Wait for Email to Receive On Email
    Then Verify recipient "SysData=>ErrorEmail" is present in the email as "To" with Subject "Pay Settlement"
    Then Verify recipient "test1@example.com" is present in the email as "To" with Subject "Pay Settlement"
    Then Verify recipient "test2@example.com" is present in the email as "CC" with Subject "Pay Settlement"
    Then Verify recipient "test3@example.com" is present in the email as "CC" with Subject "Pay Settlement"

    #Step 44 - 46 & Expected Result 8 (h)
    Then Open "Pay Headers" from App Launcher
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Verify Label Checkbox
      | Sent Pay Settlement |
      | True                |