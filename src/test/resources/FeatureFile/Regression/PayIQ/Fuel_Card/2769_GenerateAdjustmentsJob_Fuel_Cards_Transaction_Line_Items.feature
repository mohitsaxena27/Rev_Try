Feature:2769 - GenerateAdjustmentsJob- Fuel Cards Transaction Line Items

  @API @Regression @PayIQ  @WEB @SingleCurrency @2769 @PayHeader
  Scenario: 2769 - GenerateAdjustmentsJob- Fuel Cards Transaction Line Items

    When Login into Salesforce

   #Step 1
    Then Open "Fuel Cards" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 26 - 2691" from List

    #Step 2,3
    Then Go to "Related" Tab
    Then Click on "FCT-" with "Driver" as "Bruce Fleet Carrier Two 26"
    Then Wait for "2" Seconds
    Then Get Details
    |Transaction Date|
    |                |
    Then Capture month from date "SysData=>Transaction Date" and provide date "25" in format "MMM d, yyyy" and store into "TransactionMonth25"
    Then Capture month from date "SysData=>Transaction Date" and provide date "28" in format "MMM d, yyyy" and store into "TransactionMonth28"

  #Step 4
    Then Go to "Related" Tab
    Then Get "Item-" Name with "Category" as "Snack" and store in "Fuel_Item_1"
    Then Wait for "3" Seconds
    Then Capture the current URL for "Fuel_Card_Transaction"

    #Step 5 and 6
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

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

    #Step 7,8,9,10
    Then Scroll Until Related List for "Participants"
    Then Click on link "Participants"
    Then Wait for "5" Seconds
    Then Click on button with Title Text "New"
    Then Update details
      |Type|Driver                      |Pay Off Load Instead of Trip Plan Leg|
      |Driver|Bruce Fleet Carrier Two 26|True                                 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Close Toast message
    Then Capture the current URL for "Participants_1"
    Then Get "Participant-" Name with "Name" as "Bruce Fleet Carrier Two 26" and store in "Participants"
    Then Wait for "1" Seconds

    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 26" from List
    Then Click on Edit icon on Label "Contact"
    Then Update details
    |Contact|
    |Bruce Fleet Carrier Two 26|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Contact|
      |Bruce Fleet Carrier Two 26|
    Then Capture the current URL for "Driver_1"

    #Step 11
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans        | Truckload | Dry Van 53'    | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date                        | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | SysData=>TransactionMonth25          | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Tennessee Titans  | SysData=>TransactionMonth28    | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas   | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 12,13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "75"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 14,15,16
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 17,18
    Then Update "1" Segment details
      | Driver                   | Load |
      | Bruce Fleet Carrier Two 26 |SysData=>1L   |
    Then Wait for "5" Seconds
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

     #Step 19
    Then Update "1" leg details
      | Appointment Start Time | Appointment End Time |Due Out Time |
      | 10:00 AM                | 10:00 AM              |8:00 AM      |

   #Step 20
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "4" Seconds

    #Step 21
    Then Update "1" leg details
      | Arrival Date |
      | SysData=>TransactionMonth28 |

    Then Update "1" leg details
      | Departure Date |
      | SysData=>TransactionMonth28|

     #Step 22
    Then Click on button with Title "Save & Close"
    Then Wait for "5" Seconds
    Then Close Toast message
    Then Close Toast message

    #Step 23
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 24,25,26
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll Month Range from date "TransactionMonth25" on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Bruce Fleet Carrier Two 26 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "3" Seconds
    Then Set Key "Pay_Header_SFID_1" page Record Id with "rtms9__Pay_Header__c"

    #Step 27 and expected result a
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other"
    Then Verify Details
      |Category |Type |Qty |Rate    |Item Total|Transaction Date|Source|
      |Deduction|Other|1.00|USD 1.00 |USD -1.00|  0             |Fuel Card:|

    #Step 28,29,30
    Then Navigate to stored URL for "Fuel_Card_Transaction"

   #Step 31,32
    Then Go to "Related" Tab
    Then Get "Item-" Name with "Category" as "Water" and store in "Fuel_Item_2"
    Then Click on "Item-" with "Category" as "Water" and "Unit Price" as "0.750"
    Then Wait for "3" Seconds
    #Step 33
   Then Click on Edit icon on Label "Deductible"
    Then Update details
    |Deductible|
    |True      |
    Then Click on "SaveEdit" button on Details Page
    Then Verify Details
      |Deductible|
      |True      |
    Then Capture the current URL for "Fuel_Card"

    #Step 34
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 35,36
    Then Open "Pay Headers" from App Launcher
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "3" Seconds
    Then Set Key "Pay_Header_SFID_1" page Record Id with "rtms9__Pay_Header__c"

     #Step 38 and expected result b
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Item Total" as "USD -1.00"
    Then Verify Details
      |Category |Type |Qty |Rate    |Item Total|Transaction Date|Source|
      |Deduction|Other|1.00|USD 1.00 |USD -1.00|  0             |SysData=>Fuel_Item_1|
    Then Navigate Browser Back
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Item Total" as "USD -4.50"
    Then Verify Details
      |Category |Type |Qty |Rate    |Item Total|Transaction Date|Source|
      |Deduction|Other|1.00|USD 4.50 |USD -4.50|  0             |SysData=>Fuel_Item_2|
