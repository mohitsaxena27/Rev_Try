Feature: 2955 - GenerateAdjustmentsJob- ePayment
  @API @Regression @PayIQ  @WEB @SingleCurrency @2955 @PayIQ_Logs
  Scenario: 2955 - GenerateAdjustmentsJob- ePayment
    When Login into Salesforce
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"


    #Step 1
    Then Open "Transportation Profiles" from App Launcher

    #Step 2
    Then Search and Select "Fleet Carrier One" from List
    Then Go to "Settlement" Tab
    Then Click on Edit icon on Label "EPayment Authorized"
    Then Update details
      |EPayment Authorized|
      |Comdata Comchek    |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds
    Then Capture the current URL for "TransportationProfile_1"

    #Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans        | Truckload | Dry Van 53'    | NA            | NA                |
    Then Store date with month offset 0 and day 25 in format MMM d, yyyy into "25OfNextMonth"
    Then Store date with month offset 0 and day 28 in format MMM d, yyyy into "28OfNextMonth"
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date             | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | SysData=>25OfNextMonth | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date          | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats   | SysData=>28OfNextMonth | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 4
    Then Capture the current URL for "Load_1L"

    #Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "75"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"
    Then Update details
      | Status   |
      | Accepted |

    #Step 6
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 7
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Fleet Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "70"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"

    #Step 8
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 9
    Then Go to "EPayments" Tab
    Then Wait for "2" Seconds
    Then Click on link "EPayments"
    Then Click on button "New"
    #Step 10
    Then Update details
      |Load       |Transaction Type|Amount|Vendor           |Load Contact|Recipient               |Credit Deduction Amount|Funding Source|
      |SysData=>1L|Other           |29.55 |Fleet Carrier One|Other       |Dave Fleet Carrier One 8|Amount Only            |Comdata       |

    #Step 11
    Then Click on button "Issue"
    Then Verify Message displaying as "Success - EPayment"

    #Step 12
    Then Close Toast message
    #Step 13
    Then Open "EPayments" from App Launcher

    #Step 14
    Then Recently Viewed to All
    Then Click on "ePay-" with "Load" as "SysData=>1L" and "Type" as "Comdata Comchek"
    Then Wait for "2" Seconds
    Then Verify Details
    |Deductible|
    |False     |
    Then Get Details
      |Name|
      |    |
    Then Capture the current URL for "Epay_Page"
    Then Set Key "Epay_SFID" page Record Id with "rtms__EPayment__c"

    #Step 15
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds

    #Step 16
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 17
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 18
    Then Update "1" Segment details
      | Driver                    |Load|
      | Dave Fleet Carrier One 8 |SysData=>1L|
    Then Wait for "3" Seconds

    #Step 19
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

    #Step 20
    Then Update "1" leg details
      | Due Out Date           | Due Out Time |
      | SysData=>25OfNextMonth | 8:00 AM      |
    Then Update "1" leg details
      |Appointment Date        |Appointment Start Time  |Appointment End Time    |
      |SysData=>28OfNextMonth  | 10:00 AM               | 10:00 AM               |

    #Step 21
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 22
    Then Update "1" leg details
      | Arrival Date                  | Departure Date                    |
      | SysData=>25OfNextMonth        |  SysData=>28OfNextMonth           |

    #Step 23
    Then Wait for "3" Seconds
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 24
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List
    #Step 25
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Open|
    Then Click on "SaveEdit" button
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 26
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 27
    Then Open "Pay Headers" from App Launcher
    #Step 28
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Header_Page"
    #Step 29
    Then Scroll Until Related List for "Pay Adjustments"
    Then Wait for "3" Seconds
    #Expected Result a
    Then Verify table with "Pay Adjustment ID" as "Pay Adjustment-" does not have "Rate" as "USD 29.55"


    #Step 30,31,32,33
    Then API - Update "rtms__EPayment__c" Records with "rtms__Deductible__c" as "true" where "rtms__Load__c" as "SysData=>1LRI"

    #Step 34
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 35
    #Step 36
    Then Navigate to stored URL for "Pay_Header_Page"
    #Step 37
    Then Scroll Until Related List for "Pay Adjustments"
    Then Wait for "3" Seconds
    #Expected Result b
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other"
    Then Set "SourceName" with "EPayment: " and "SysData=>Name"
    Then Wait for "3" Seconds
    Then Verify Details
      |Category    |Source                       |Type |Rate|
      |Deduction   |SysData=>SourceName |Other|29.55|


    #Step 38
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "2" Seconds
    #Step 39
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds

    #Step 40
    Then Click on Edit icon on "Pay Off Load Instead of Trip Plan Leg"
    Then Update details
    |Pay Off Load Instead of Trip Plan Leg|
    |True |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Capture the current URL for "Participant_1"

    #Step 41
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 42
    #Step 43
    Then Navigate to stored URL for "Pay_Header_Page"

    #Step 44
    Then Scroll Until Related List for "Pay Adjustments"
    #Expected Result c
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other"

    Then Verify Details
      |Category    |Source                       |Type |Rate|
      |Deduction   |SysData=>SourceName |Other|29.55|

    #Step 45
    Then Set "EpaymentUrl" with "OrgData=>application_url" and "/lightning/r/rtms__EPayment__c/" and "SysData=>Epay_SFID"
    Then Set "EpaymentEditUrl" with "SysData=>EpaymentUrl" and "/edit?count=1"
    Then Navigate to stored URL for "EpaymentEditUrl"
#    Then Go to "EPayments" Tab
#    Then Wait for "3" Seconds
#    Then Click on link "EPayments"
#    Then Zoom Current Screen by "80"
#    Then Wait for "2" Seconds
#    Then Refresh current Page
#    Then Wait for "2" Seconds
#    Then click on "SysData=>Name" epayments and select "Edit" from Show More Dropdown

    #Step 46
    Then Wait for "2" Seconds
    Then Click on Native "Freeze" button
    Then Verify Message displaying as "Comchek frozen."

    #Step 47
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 48
    #Step 49
    Then Navigate to stored URL for "Pay_Header_Page"
    Then Wait for "2" Seconds

    #Step 50
    Then Scroll Until Related List for "Pay Adjustments"
    #Expected Result d
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other"
    Then Verify Details
      |Category    |Source                       |Type |Rate|
      |Deduction   |SysData=>SourceName |Other|29.55|

    #Step 51
#    Then Open "Loads" from App Launcher
#    Then Navigate to stored URL for "Load_1L"
#    Then Go to "EPayments" Tab
#    Then Wait for "3" Seconds
#    Then Click on link "EPayments"
#    Then Zoom Current Screen by "80"
#    Then Wait for "2" Seconds
#    Then Refresh current Page
#    Then Zoom Current Screen by "80"
#    Then Wait for "2" Seconds
#    Then click on "ePay- SysData=>Name" epayments and select "Edit" from Show More Dropdown
    Then Navigate to stored URL for "EpaymentEditUrl"

    #Step 52
    Then Wait for "2" Seconds
    Then Click on Native "UnFreeze" button
    Then Verify Message displaying as "Comchek unfrozen."

    #Step 53
#    Then Wait for "3" Seconds
#    Then Refresh current Page
#    Then Recently Viewed to All
#    Then Zoom Current Screen by "80"
#    Then Wait for "2" Seconds
#    Then click on "ePay- SysData=>Name" epayments and select "Edit" from Show More Dropdown
#    Then Wait for "3" Seconds
    Then Navigate to stored URL for "EpaymentEditUrl"
    Then Wait for "3" Seconds

    #Step 54
    Then Click on Native "Stop" button
    Then Verify Message displaying as "Comchek cancelled."

    #Step 55
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 56
    #Step 57
    Then Navigate to stored URL for "Pay_Header_Page"
    #Step 58
    Then Scroll Until Related List for "Pay Adjustments"
    #Expected Result e
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other"
    Then Verify Details
      |Category    |Source                       |Type |Rate|
      |Deduction   |SysData=>SourceName |Other|29.55|

    #Step 59
     Then Delete "rtms__EPayment__c" with Id "Epay_SFID"
     Then Wait for "2" Seconds
    #Step 60
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 61
    #Step 62
    Then Navigate to stored URL for "Pay_Header_Page"

    #Step 63
    Then Scroll Until Related List for "Pay Adjustments"
    #Expected Result f
    Then Verify table with "Pay Adjustment ID" as "Pay Adjustment-" does not have "Category" as "Deduction"


