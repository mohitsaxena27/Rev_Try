Feature: 2905 - Pay Header - Email Pay Settlements - Driver

  @API @Regression @PayIQ @WEB @MultiCurrency @2905 @PayHeader
  Scenario: 2905 - Pay Header - Email Pay Settlements - Driver

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
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
      | Search       | Driver                   |
      | Tractor 1008 | Dave Fleet Carrier One 8 |
    Then Wait for "4" Seconds

    #Step 5
    Then Update "1" leg details
      | Start Type | Location      | Due Out Date              | Due Out Time | End Type | Location_2     | Appointment Date          | Appointment Start Time | Appointment End Time |
      | Location   | Chicago Pizza | SysData=>Current_Month_18 | 8:00 AM      | Location | Atlanta Braves | SysData=>Current_Month_21 | 10:00 AM               | 10:00 AM             |
    Then Wait for "2" Seconds
    #Step 6
    Then Click on button with Title "Add Segment Below"
    Then Wait for "4" Seconds

    #Step 7
    Then Update "2" Segment details
      | Search       |
      | Tractor 1008 |
    Then Wait for "2" Seconds
    Then Clear "Driver" field on "2" Segment
    Then Wait for "2" Seconds
    Then Update "2" Segment details
      | Driver                    |
      | Bruce Fleet Carrier Two 8 |
    Then Wait for "4" Seconds

    #Step 8
    Then Update "2" leg details
      | Start Type | Location       | Due Out Date              | Due Out Time | End Type | Location_2       | Appointment Date          | Appointment Start Time | Appointment End Time |
      | Location   | Atlanta Braves | SysData=>Current_Month_21 | 12:00 PM     | Location | Port of Savannah | SysData=>Current_Month_21 | 8:00 PM                | 8:00 PM              |
    Then Wait for "2" Seconds

    #Step 9
    Then Click on button with Title "Save"
    Then Verify Text displaying as "Save was successful." -
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 10
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 11
    Then Update "1" leg details
      | Arrival Date              | Departure Date            |
      | SysData=>Current_Month_18 | SysData=>Current_Month_18 |

    #Step 12
    Then Update "2" leg details
      | Arrival Date              | Departure Date            |
      | SysData=>Current_Month_21 | SysData=>Current_Month_21 |

    #Step 13
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 14 & 15
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

    #Step 16
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "20" Seconds

    #Step 17 & 18
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Bruce Fleet Carrier Two 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID_Bruce"
    Then Search and Select "SysData=>PayHeaderID_Bruce" from List
    Then Wait for "3" Seconds

    Then Open "Pay Headers" from App Launcher
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID_Dave"
    Then Search and Select "SysData=>PayHeaderID_Dave" from List
    Then Wait for "5" Seconds

    Then Open "Pay Headers" from App Launcher
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Select Multiple Records from List
      | Record1                    | Record2                   |
      | SysData=>PayHeaderID_Bruce | SysData=>PayHeaderID_Dave |

    #Step 19 & Expected Result 1 (a)
    Then Click on "Email Pay Settlements" with Text
    Then Verify Message displaying with "Successfully queued job to generate and email out pay settlements"
    Then Wait for "3" Seconds
    Then Verify Title displaying as "Pay Headers"

    #Step 20 & Expected Result 2 (b)
    Then Wait for Email to Receive On Email
    Then Verify Content "Pay settlements are attached" in the email body with Subject "Pay Settlements"

    Then Set "OrgEmail" with "EnvData=>EmailID"
    Then Verify recipient "SysData=>OrgEmail" is present in the email as "To" with Subject "Pay Settlements"

    Then Set "AttachmentName1" with "Dave Fleet Carrier One 8 Pay Settlement " and "SysData=>Current_Month_Range"
    Then Set "Final_Attachment_1" with "SysData=>AttachmentName1" and ".pdf"
    Then Verify the email attachment has "SysData=>Final_Attachment_1" as an attachment with subject "Pay Settlements"

    Then Set "AttachmentName2" with "Bruce Fleet Carrier Two 8 Pay Settlement " and "SysData=>Current_Month_Range"
    Then Set "Final_Attachment_2" with "SysData=>AttachmentName2" and ".pdf"
    Then Verify the email attachment has "SysData=>Final_Attachment_2" as an attachment with subject "Pay Settlements"
    Then Reset Time to get New Email

    #Step 21
    Then Open "Drivers" from App Launcher
    Then Search and Select "Dave Fleet Carrier One 8" from List
    Then Wait for "2" Seconds

    # Step 22
    Then Click on Edit icon on Label "User"
    Then Update details
      | User      |
      | User User |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "Driver_Url_1"

    #Additional Step to update driver email for expected d
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 8" from List
    Then Wait for "2" Seconds
    Then Scroll into Section "Employment / Personal Information"
    Then Click on Edit icon on Label "Email"
    Then Update details
      | Email      |
      | test@revenova.com |
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds
    Then Scroll into Section "Employment / Personal Information"
    Then Verify Details
      | Email      |
      | test@revenova.com |
    Then Capture the current URL for "Driver_Url_2"


    #Step 23
    Then Open "Pay Headers" from App Launcher
    Then Wait for "2" Seconds
    Then Select Multiple Records from List
      | Record1                    | Record2                   |
      | SysData=>PayHeaderID_Bruce | SysData=>PayHeaderID_Dave |

    # Step 24
    Then Click on "Email Pay Settlements" with Text
    Then Verify Message displaying with "Successfully queued job to generate and email out pay settlements"
    Then Wait for "5" Seconds

    #Step 25 - 27 (Email Verification - Commented out per user directive)
    Then Wait for Email to Receive On Email

    # Expected c & d
    Then Get "TextBody" from EmailMessage using Subject with value "Pay Settlement" & "ToAddress" with value "test@revenova.com" and Store into "ToList1"
    Then Verify Assertion for "ToList1" contains "Pay settlement is attached"

    Then Get "TextBody" from EmailMessage using Subject with value "Pay Settlement" & "ToAddress" with value "SysData=>OrgEmail" and Store into "ToList1"
    Then Verify Assertion for "ToList1" contains "Pay settlement is attached"


    #Step 28 & 29
    Then Navigate to stored URL for "Driver_Url_1"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "User"
    Then Clear "User" value from comboBox
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Navigate to stored URL for "Driver_Url_2"
    Then Wait for "2" Seconds
    Then Scroll into Section "Employment / Personal Information"
    Then Click on Edit icon on Label "Email"
    Then Enter Label "Email" Text as "SysData=>OrgEmail"
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds


    #Step 30 & 31
    Then Open "Pay Headers" from App Launcher
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Bruce Fleet Carrier Two 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID_Bruce"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID_Dave"
    Then Select Multiple Records from List
      | Record1                    | Record2                   |
      | SysData=>PayHeaderID_Bruce | SysData=>PayHeaderID_Dave |

    #Step 32 & Expected Result 5 (e)
    Then Click on "Email Combined Pay Settlement" with Text
    Then Wait for "5" Seconds
    Then Verify Message displaying with "Sent Combined Pay Settlement"
    Then Wait for "5" Seconds

    #Step 33 & Expected Result 6 (f) (Email Verification - Commented out per user directive)
    Then Wait for Email to Receive On Email
    Then Verify recipient "SysData=>OrgEmail" is present in the email as "To" with Subject "Collated Pay Settlement"
    Then Verify Content "Collated pay settlement is attached" in the email body with Subject "Collated Pay Settlement"
