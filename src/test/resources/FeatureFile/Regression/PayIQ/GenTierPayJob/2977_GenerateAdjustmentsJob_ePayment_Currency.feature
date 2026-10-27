Feature: 2977 - GenerateAdjustmentsJob- ePayment- Currency

  @API @Regression @PayIQ  @WEB @SingleCurrency @2977 @PayIQ_Logs
  Scenario: 2977 - GenerateAdjustmentsJob- ePayment- Currency
    When Login into Salesforce

   #Step 1

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Fleet Carrier One" from List
    Then Go to "Settlement" Tab
    Then Scroll into Section "ePayment Information"
    Then Click on Edit icon on Label "EPayment Authorized"
    Then Update details
      | EPayment Authorized |
      | EFS Money Code      |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds
    Then Capture the current URL for "TransportationProfile_1"

   #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | NA            | NA                |
    Then Store date with month offset 0 and day 25 in format MMM d, yyyy into "25OfNextMonth"
    Then Store date with month offset 0 and day 28 in format MMM d, yyyy into "28OfNextMonth"
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date          | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | SysData=>25OfNextMonth | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date          | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | SysData=>28OfNextMonth | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    #Step 3
    Then Capture the current URL for "Load_1L"

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "75"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"
    Then Update details
      | Status   |
      | Accepted |

    #Step 5
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    #Step 6
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Fleet Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "70"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"

    #Step 7
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 8
    Then Go to "EPayments" Tab
    Then Wait for "3" Seconds
    Then Click on link "EPayments"
    Then Click on button "New"

    #Step 9
    Then Update details
      | Load        | Transaction Type | Amount | Vendor            | Load Contact | Recipient                | Credit Deduction Amount | Funding Source |
      | SysData=>1L | Other            | 10     | Fleet Carrier One | Other        | Dave Fleet Carrier One 8 | Amount Only             | EFS            |
    Then Wait for "3" Seconds
    Then Update details
      | Currency |
      | CAD      |

    #Step 10
    Then Click on button "Issue"
    Then Verify Message displaying as "Success - EPayment"

    #Step 11
    Then Close Toast message

    #Step 12, 13 & 14
    Then API - Update "rtms__EPayment__c" Records with "rtms__Deductible__c" as "true" where "rtms__Load__c" as "SysData=>1LRI"

    Then Open "EPayments" from App Launcher
    Then Recently Viewed to All
    Then Click on "ePay-" with "Load" as "SysData=>1L"
    Then Wait for "2" Seconds
    Then Get Details
      | Name | Amount |
      |      |        |
    Then Capture the current URL for "Epay_Page"
    Then Set Key "Epay_SFID" page Record Id with "rtms__EPayment__c"

     #Step 15
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds

    #Step 16
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    #Step 17
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 18
    Then Update "1" Segment details
      | Driver                   | Load        |
      | Dave Fleet Carrier One 8 | SysData=>1L |
    Then Wait for "5" Seconds

    #Step 19
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

    #Step 20
    Then Update "1" leg details
      | Due Out Date           | Due Out Time | Appointment Date       | Appointment Start Time | Appointment End Time |
      | SysData=>25OfNextMonth | 8:00 AM      | SysData=>28OfNextMonth | 10:00 AM               | 10:00 AM             |

    #Step 21
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 22
    Then Update "1" leg details
      | Arrival Date           | Departure Date         |
      | SysData=>25OfNextMonth | SysData=>28OfNextMonth |

    #Step 23
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "4" Seconds

    #Step 24
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    #Step 25
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 26
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "10" Seconds
    #Step 27
    Then Open "Pay Headers" from App Launcher

    #Step 28
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

    #Step 29
    Then Scroll Until Related List for "Pay Adjustments"
    #Expected Result a
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other"
    Then Wait for "2" Seconds
    Then Verify Details
      | Rate     | Item Total |
      | USD 7.46 | USD -7.46  |











