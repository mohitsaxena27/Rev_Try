Feature: 2964 - GenerateAccessorialPayJob- Customer Invoice Accessorial- Payable boolean

  @API @Regression @PayIQ @WEB @SingleCurrency @2964
  Scenario: 2964 - GenerateAccessorialPayJob- Customer Invoice Accessorial- Payable boolean

    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"
    
    # Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
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
      | Type                         | Accessorial     | Rule      | Amount |
      | Customer Invoice Accessorial | Blind Shipments | Flat Rate | 29.64  |

    # Step 5
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Accessorial Rule-"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Customer Invoice Accessorial" and "Accessorial" as "Blind Shipments"
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
      | 1         | P1     | D2       | Grapes      | 1500   | NA           | NA       | NA             |
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
    Then Add "Load" "Customer Quote Items" "Blind Shipments" Accessorial with Unit as "Per Cwt" Qty as "15" and Price "0.33"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    # Step 9
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 10, 11, 12 &Expected Result 1(a)
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User (User)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderName"

    #Step 11
    Then Search and Select "SysData=>PayHeaderName" from List
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Header"

    # Step 12 & Expected Result 1(a)
#    Then Scroll Until Related List for "Pay Details"
#    Then Verify table with "Pay Detail ID" as "Pay Detail-" does not have "Paid From" as "SysData=>1L"

    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Paid_From__c" with value "SysData=>1L" & "rtms9__Accessorial__c" with value "Blind Shipments" and Store into "Actual"
    Then Verify Assertion for "Actual_count" contains "0"


    # Step 13 & 14
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Click on button with Title "Locked"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Update details
      | Payable |
      | True    |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    # Step 15
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 16 & 17, 18 & Expected Result 2(b)
#    Then Navigate to stored URL for "Pay_Header"
#
#    # Step 18 & Expected Result 2(b)
#    Then Scroll Until Related List for "Pay Details"
#    Then Verify table with "Pay Detail ID" as "Pay Detail-" does not have "Paid From" as "SysData=>1L"

    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Paid_From__c" with value "SysData=>1L" & "rtms9__Accessorial__c" with value "Blind Shipments" and Store into "Actual"
    Then Verify Assertion for "Actual_count" contains "0"

    # Step 19
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Click on button with Title "Update Invoice"
    Then Verify Message displaying as "The invoice was successfully updated."
    # Step 20
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"
    
    #Step 21 & 22
    Then Navigate to stored URL for "Pay_Header"
    Then Wait for "2" Seconds
    #Step 23 & expected Result 3(c)
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "3" Seconds
    Then Verify "Pay Details" Table Details
      | Type                                          | Rate   | Pay Amount | Paid From Type | Paid From   | Accessorial     |
      | Customer Invoice Accessorial: Blind Shipments | $29.64 | USD 29.64  | Load           | SysData=>1L | Blind Shipments |


