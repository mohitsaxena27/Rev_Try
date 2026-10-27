Feature:3174 -Pay Advance- No Pay Adjustment Added after Pay Header Settled

  @API @Regression @PayIQ @WEB @MultiCurrency @3174 @PayAdvance
  Scenario: 3174 -Pay Advance- No Pay Adjustment Added after Pay Header Settled

    When Login into Salesforce

    Then Store date with month offset 0 and day 28 in format MMM d, yyyy into "TwentyEightDayOfCurrentMonth"
    Then Store date with month offset 1 and day 1 in format MMM d, yyyy into "FirstDayOfNextMonth"
    Then Store date with month offset 0 and day 1 in format MMM d, yyyy into "FirstDayOfCurrentMonth"

    #Step 1 & 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer |NA | SysData=>TwentyEightDayOfCurrentMonth              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | SysData=>FirstDayOfNextMonth  | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 3 & 4
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact) | Custom PayIQ Eligible Date |
      | User User          | Joe Revenova PayIQ   | SysData=>FirstDayOfNextMonth       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds

    #Step 5 & 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "75"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 7 & 8
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

    #Step 9
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "7" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "15" Seconds

    #Step 10 & 11
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "User User (User)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Open "Pay Headers" from App Launcher
    Then Wait for "2" Seconds
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "2" Seconds

     #Step 12
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Paid       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Paid       |
    Then Set Key "Pay_Header_SFID_1" page Record Id with "rtms9__Pay_Header__c"
    Then Capture the current URL for "Pay_Header_1"

    #Step 13 & 14
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Next" Month Range on To "Next_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ (Contact)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID_1"
    Then Search and Select "SysData=>PayHeaderID_1" from List

    #Step 15
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Approved       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Approved     |
    Then Set Key "Pay_Header_SFID_2" page Record Id with "rtms9__Pay_Header__c"
    Then Capture the current URL for "Pay_Header_2"

    #Step 16
    Then Open "Pay Advances" from App Launcher
    Then Wait for "2" Seconds
    Then Click on "New" with Text
    Then Update details
      |Category|Type |      Transaction Date      |  Description   |  Payee Type  |  User   |Qty |Rate|   Adjustment Plan   |Amount Per Pay Period|
      |Addition|Other|SysData=>FirstDayOfCurrentMonth|  Addition 3174 |    User      |User User|5.00|0.10|Amount per Pay Period|         0.10       |

    #Step 17
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "4" Seconds
    Then Capture the current URL for "PayAdvance_Url"
    Then Set Key "Pay_Advance_SFID_1" page Record Id with "rtms9__Pay_Advance__c"
    Then Get Details
         |Pay Advance ID|
         |              |
    Then Set "PayAdvance_1" with "SysData=>Pay Advance ID"

   #Step 18 & 19
    Then Open "Pay Advances" from App Launcher
    Then Wait for "2" Seconds
    Then Click on "New" with Text
    Then Update details
     | Category|       Type   |        Transaction Date       |  Description  |   Payee Type|      Contact     |Qty |Rate|   Adjustment Plan   |Amount Per Pay Period|Wait For Next Period To Begin Adjusting|
     |Deduction|Hotel/Motel  | SysData=>FirstDayOfCurrentMonth|Deduction 3174 |   Contact   |Joe Revenova PayIQ|4.00|0.05|Amount per Pay Period|         0.05        |True                      |

    #Step 20
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "4" Seconds
    Then Capture the current URL for "PayAdvance_Url2"
    Then Set Key "Pay_Advance_SFID_2" page Record Id with "rtms9__Pay_Advance__c"
    Then Get Details
      |Pay Advance ID|
      |              |
    Then Set "PayAdvance_2" with "SysData=>Pay Advance ID"

    #Step 21
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "5" Seconds

    #Step 22 & expected a

    Then Navigate to stored URL for "Pay_Header_1"
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify table with "Pay Adjustment ID" as "Pay Adjustment-" does not have "Source" as "SysData=>PayAdvance_1"

     #Step 23
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Pending     |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 24 & expected b
    Then Navigate to stored URL for "Pay_Header_2"

    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify table with "Pay Adjustment ID" as "Pay Adjustment-" does not have "Source" as "SysData=>PayAdvance_2"

     #Step 25
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Pending       |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 26
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "5" Seconds

    #Step 27 & expected c
    Then Navigate to stored URL for "Pay_Header_1"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify table has "1" records with "Source" as "SysData=>PayAdvance_1"

     #Step 28
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Paid       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 29 & expected d
    Then Navigate to stored URL for "Pay_Header_2"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify table has "1" records with "Source" as "SysData=>PayAdvance_2"

     #Step 30
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Approved       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 31
    Then Navigate to stored URL for "Load_1"
    Then Wait for "3" Seconds
    Then Execute Load "1L" Clone with count "1" and Customer Quote as "True" and Carrier Quote as "False"

    #Step 32 & 33
    Then Open Last Load from Cloned Load
    Then Wait for "4" Seconds
    Then Capture the current URL for "Cloned_Load"

    #Step 34 & 35
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
    | Sales Lead (Contact) | Custom PayIQ Eligible Date |
    | Joe Revenova PayIQ   | SysData=>FirstDayOfNextMonth       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds

    #Step 36 & 37
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "25"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "15"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 38
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "5" Seconds

    #Step 39 & expected e
    Then Navigate to stored URL for "Pay_Header_1"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify table has "1" records with "Source" as "SysData=>PayAdvance_1"
    #Step 40 & expected f
    Then Navigate to stored URL for "Pay_Header_2"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify table has "1" records with "Source" as "SysData=>PayAdvance_2"


    #Step 41 & expected g
    Then Navigate to stored URL for "PayAdvance_Url"
    Then Wait for "3" Seconds
    Then Scroll into Section "Financials"
    Then Verify Details
      | Paid Amount |
      | USD 0.10   |

   #Step 42 & expected h
    Then Navigate to stored URL for "PayAdvance_Url2"
    Then Wait for "3" Seconds
    Then Scroll into Section "Financials"
    Then Verify Details
      | Paid Amount |
      | USD -0.05   |

