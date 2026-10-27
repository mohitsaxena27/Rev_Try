Feature:3159 - Pay Advance- Change Transaction Date

  @API @Regression @PayIQ @WEB @MultiCurrency @3159 @PayAdvance
  Scenario: 3159 - Pay Advance- Change Transaction Date

    When Login into Salesforce

    #Step 1
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

    #Step 2
    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 3
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep|Sales Lead (Contact)|Custom PayIQ Eligible Date|
      | User User          |Joe Revenova PayIQ |SysData=>FirstOfNextMonth |

    #Step 4
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |Sales Lead (Contact)|
      |  User User           |Joe Revenova PayIQ |

    #Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "75"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"
    Then Update details
      | Status   |
      | Accepted |

    #Step 6
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   #Step 7
    Then Open "Pay Advances" from App Launcher
    Then Wait for "2" Seconds
    Then Click on "New" with Text
    Then Store date with month offset 2 and day 2 in format MMM d, yyyy into "SecondDayOfTwoMonths"
    Then Update details
      |Transaction Date            |Category|Payee Type|Contact           |Qty |Rate|Adjustment Plan      |Amount Per Pay Period|Type|Description|
      |SysData=>SecondDayOfTwoMonths|Addition|Contact   |Joe Revenova PayIQ|5.00|0.20|Amount per Pay Period|1                    |Other|Advance 3159|

    #step 8
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Pay Advance-"
    Then Set Key "Pay_Advance_SFID_1" page Record Id with "rtms9__Pay_Advance__c"
    Then Get Details
    |Pay Advance ID|
    |           |

    #Step 9
   Then Click on Edit icon on Label "Transaction Date"
   Then Update details
    |Transaction Date|
    |SysData=>FirstOfNextMonth |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "4" Seconds
    #Expected Result a
    Then Store date with month offset 1 and day 1 in format "M/d/yyyy" into "NextMonth1"

    Then Verify Details
       |Transaction Date|
       |SysData=>NextMonth1 |
    #Step 10
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    #Step 11
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

    #Step 12
    Then Wait for "5" Seconds
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "10" Seconds
    #Step 13
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Next" Month Range on To "Next_Month_Range"

    #Step 14
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ (Contact)" & "rtms9__Payroll_Description__c" with contains "SysData=>Next_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

    #Step 15 
    Then Scroll Until Related List for "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Click on "Pay Adjustment-" with "Source" as "SysData=>Pay Advance ID" and "Type" as "Other"
    Then Wait for "2" Seconds
    Then Get Details
    |Pay Adjustment ID|
    |                 |
   
  #Step 16 and expected result b
    Then Click on Partial Link Text "Pay Advance-" on Page
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Transaction Date"
    Then Update details
      |Transaction Date|
      |SysData=>SecondDayOfTwoMonths |
    Then Click on "SaveEdit" button on Details Page
    Then Verify Success Message displaying as "You cannot modify transaction date after a pay advance has started creating adjustments"

    #Step 17
    Then Go to "Generated Adjustments" Tab
    Then Wait for "2" Seconds
    Then Click If button with Title "Show 2 more actions" is enabled
    Then Click on "Delete" button
    Then Click on button with Title "Delete" on Modal
    Then Verify Message displaying as "Pay Adjustment SysData=>Pay Adjustment ID was deleted."

    #Step 18 and expected result c
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Transaction Date"
    Then Update details
      |Transaction Date|
      |SysData=>SecondDayOfTwoMonths |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds
    #Expected c
    Then Store date with month offset 2 and day 2 in format "M/d/yyyy" into "SecondMonth2"
    Then Verify Details
      |Transaction Date|
      |SysData=>SecondMonth2 |

