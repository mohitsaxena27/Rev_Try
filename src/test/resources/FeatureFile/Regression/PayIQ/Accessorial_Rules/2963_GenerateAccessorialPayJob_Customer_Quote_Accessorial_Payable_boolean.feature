Feature: 2963 - GenerateAccessorialPayJob- Customer Quote Accessorial- Payable boolean

  @API @Regression @PayIQ @WEB @SingleCurrency @2963
  Scenario: 2963 - GenerateAccessorialPayJob- Customer Quote Accessorial- Payable boolean

    When Login into Salesforce

    # Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    # Step 2
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

    # Step 3
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Accessorial Rules" section
    # Step 4
    Then Update details
      | Type                       | Accessorial          | Rule      | Amount |
      | Customer Quote Accessorial | Detention at Pick Up | Flat Rate | 15     |
    # Step 5
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Accessorial Rule-"
    Then Wait for "1" Seconds
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Customer Quote Accessorial" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "4" Seconds
    Then Get Details
      | Accessorial Rule ID |
      |                     |
    Then Capture the current URL for "Accessorial_Rules_1"
    Then Set Key "Accessorial_Rules_SFID_1" page Record Id with "rtms9__Accessorial_Rule__c"

    # Step 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer       | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova PayIQ | Truckload | Dry Van 53    | N             | N                 |
    Then Wait for "1" Seconds
    Then Store date with month offset 0 and day 25 in format "MMM d, yyyy" into "25thOfCurrentMonth"
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date               | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | SysData=>25thOfCurrentMonth | NA                       | NA               | NA                   |
    Then Store date with month offset 0 and day 28 in format "MMM d, yyyy" into "28thOfCurrentMonth"
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date               | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts | SysData=>28thOfCurrentMonth | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Apples      | 2963   | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_1L"

    # Step 7
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep |
      | User User          |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | User User          |

    # Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "75"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "10"
    Then Add "Stop 1" "Customer Quote Items" "Detention at Pick Up" Accessorial with Unit as "Per Cwt" Qty as "29.63" and Price "0.48"
    Then Wait for "1" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    # Step 9
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 10
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User (User)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderName"

    #Step 11
    Then Search and Select "SysData=>PayHeaderName" from List
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Header"

    # Step 12 & Expected Result 1(a)
    Then Scroll Until Related List for "Pay Details"
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Paid_From__c" with value "SysData=>1L" & "rtms9__Accessorial_Rule__c" with value "SysData=>Accessorial_Rules_SFID_1" and Store into "Pay"
    Then Verify Assertion for "Pay_count" contains "0"

    # Step 13
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Payable |
      | True    |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    # Step 14
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 15
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User (User)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderName"

    # Step 16
    Then Search and Select "SysData=>PayHeaderName" from List
    Then Wait for "2" Seconds
    # Step 17 & Expected Result 2(b)
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "3" Seconds
    Then Verify "Pay Details" Table Details
      | Type                                             | Rate   | Pay Amount | Paid From Type | Paid From   | Accessorial          |
      | Customer Quote Accessorial: Detention at Pick Up | $15.00 | USD 15.00  | Load           | SysData=>1L | Detention at Pick Up |


