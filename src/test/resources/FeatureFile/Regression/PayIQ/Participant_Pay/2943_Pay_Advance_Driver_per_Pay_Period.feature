Feature:2943 - Pay Advance- Driver- per Pay Period

  @API @Regression @PayIQ  @WEB @SingleCurrency @2943
  Scenario: 2943 - Pay Advance- Driver- per Pay Period
    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"
    Then Delete All Records with name "Pay Adjustment-" for "rtms9__Pay_Adjustment__c"
    #Step 1 & 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans        | Truckload | Dry Van 53'    | N             | N                 |
    Then Store date with month offset 1 and day 1 in format MMM d, yyyy into "FirstOfNextMonth"
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date                        | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | SysData=>FirstOfNextMonth            | NA                       | NA               | NA                   |
    Then Store date with month offset 1 and day 4 in format MMM d, yyyy into "FourthOfNextMonth"
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats  | SysData=>FourthOfNextMonth       | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas   | 1500  | NA           | NA       | NA             |
    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"
    #Step 3 & 4
    Then Go to "PayIQ" Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      |Customer Sales Rep|Sales Lead (Contact)|Custom PayIQ Eligible Date|
      |User User         |Joe Revenova PayIQ  |SysData=>FirstOfNextMonth |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Customer Sales Rep|
      |User User         |
    #Step 5 & 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "75"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    #Step 7
    Then Open "Pay Advances" from App Launcher
    Then Recently Viewed to All
    Then Get "Pay Advance-" Name with "Payee Name" as "Joe Revenova PayIQ (Contact)" and store in "Pay_Advance_1"
    Then Click on "Pay Advance-" with "Payee Name" as "Joe Revenova PayIQ (Contact)"
    Then Scroll into Section "Financials"
    Then Get Details
      |Paid Amount|Remaining Balance|
      |           |                 |
    Then Scroll into Section "Pay Adjustment Plan"
    Then Get Details
      |Amount Per Pay Period|
      |                     |
    Then Set "PaidAmount_1" with "SysData=>Paid Amount"
    Then Set "Remaining_Balance_1" with "SysData=>Remaining Balance"
    Then Set "Amount_Per_Pay_Period_1" with "SysData=>Amount Per Pay Period"
    Then Capture the current URL for "Pay_Advance1"

#    #Step 8 and 9
    Then Open "Pay Advances" from App Launcher
    Then Click on "New" with Text
    Then Store date with month offset 0 and day 14 in format MMM d, yyyy into "FourteentDayOfCurrentMonth"
    Then Update details
      |Transaction Date|Category|Payee Type|User|Qty |Rate|Adjustment Plan|Percent Per Pay Period|Type|Description|
      |SysData=>FourteentDayOfCurrentMonth |Deduction|User      |User User|5.00|10.00|Percent per Pay Period|1.5     |Other|testing   |
    Then Click on "SaveEdit" button on Details Page
    Then Verify Message displaying as "Pay Advance-"
    Then Scroll into Section "Financials"
    Then Get Details
      |Paid Amount|Remaining Balance|Pay Advance ID|
      |           |                 |              |
    Then Scroll into Section "Pay Adjustment Plan"
    Then Get Details
      |Percent Per Pay Period|
      |                     |
    Then Set Key "Pay_Advance_SFID_1" page Record Id with "rtms9__Pay_Advance__c"

    Then Set "PaidAmount_2" with "SysData=>Paid Amount"
    Then Set "Remaining_Balance_2" with "SysData=>Remaining Balance"
    Then Set "Pay_Advance_ID_2" with "SysData=>Pay Advance ID"
    Then Capture the current URL for "Pay_Advance_2_Url"

   #Step 10 and 11
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

   #Step 12
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "10" Seconds
    #Step 13
    #Step 14
    Then Set Payroll "Next" Month Range on To "Next_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ (Contact)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID1"
    Then Open "Pay Headers" from App Launcher
    Then Search and Select "SysData=>PayHeaderID1" from List
    #Step 15 and expected result a
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Addition" and "Type" as "Other" and "Qty" as "1.00"
    Then Verify Details
      |Category|Source                |Type |Qty |Rate    |Item Total|
      |Addition|SysData=>Pay_Advance_1 |Other|1.00|USD 0.50|USD 0.50|
    #Step 16
    Then Get Details
      |Item Total|
      |          |
    Then Set "Item_Total_1" with "SysData=>Item Total"
    #Step 17
    Then Open "Pay Headers" from App Launcher
    #Step 18
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User (User)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID2"
    Then Search and Select "SysData=>PayHeaderID2" from List
   #Step 19 and expected result b
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Category" as "Deduction" and "Type" as "Other" and "Qty" as "1.00"
    Then Wait for "2" Seconds
    Then Verify Details
      |Category|Source                     |Type |Qty |Rate    |Item Total|
      |Deduction|SysData=>Pay_Advance_ID_2 |Other|1.00|USD 0.75|USD -0.75|
    #Step 20
    Then Get Details
      |Item Total|
      |          |
    Then Set "Item_Total_2" with "SysData=>Item Total"
  #Step 21
    Then Navigate to stored URL for "Pay_Advance1"
    Then Scroll into Section "Financials"
    Then Get Details
      |Paid Amount|Remaining Balance|
      |           |                 |
    Then Set "SysData=>PaidAmount_1" "increased" by "0.5" and store into "Increased_Amount"
    Then Set "SysData=>Remaining_Balance_1" "decreased" by "0.5" and store into "Decreased_Amount"
    Then Set "Final_Paid_Amount" with "USD " and "SysData=>Increased_Amount"
    Then Set "Final_Remaining_Amount" with "USD " and "SysData=>Decreased_Amount"
     #Expected c
    Then Verify Assertion for "Paid Amount" contains "USD 0.50" or "USD 1.00"
    Then Verify Assertion for "Remaining Balance" contains "USD 10.50" or "USD 10.00"

    #Step 22
    Then Navigate to stored URL for "Pay_Advance_2_Url"
    Then Scroll into Section "Financials"
    Then Get Details
      |Paid Amount|Remaining Balance|
      |           |                 |
    Then Set "SysData=>PaidAmount_2" "decreased" by "-0.75" and store into "Decreased_Amount"
    Then Set "SysData=>Remaining_Balance_2" "increased" by "-0.75" and store into "Increased_Amount"
    Then Set "Final_Paid_Amount" with "USD " and "SysData=>Decreased_Amount"
    Then Set "Final_Remaining_Amount" with "USD " and "SysData=>Increased_Amount"

    #Expected d
    Then Verify Assertion for "Paid Amount" contains "USD -0.75" or "USD -1.50"
    Then Verify Assertion for "Remaining Balance" contains "USD -49.25" or "USD -48.50"
