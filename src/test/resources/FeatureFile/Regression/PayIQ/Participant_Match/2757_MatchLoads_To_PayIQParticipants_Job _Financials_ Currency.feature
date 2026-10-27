Feature:2757 - MatchLoadsToPayIQParticipants Job - Financials Currency
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2757
  Scenario: 2757 - MatchLoadsToPayIQParticipants Job - Financials Currency

    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"
    Then Delete All Records with name "Pay Header-" for "rtms9__Pay_Header__c"

    #Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "PayIQ Program 2757" from Search List

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

    #Step 2 & 3
     Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles  | 2       | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Parts   | 999  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Close Toast message
    Then Capture the current URL for "Load_1L"

    #Step 4
    Then Go to "Details" Tab
    Then Wait for "1" Seconds
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Currency"
    Then Update details
      |Currency|
      |CAD - Canadian Dollar|
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Currency|
      |CAD - Canadian Dollar|

    #Step 5
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact)    |
      | Second User        | Joe Philadelphia Eagles |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Second User        |

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Update details
      |Status|Currency ISO Code |
      |Accepted|CAD - Canadian Dollar|
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    Then Enter Carrier Service as "Revenova PayIQ Carrier"
    Then Update details
      |Currency ISO Code_2|
      |CAD - Canadian Dollar|
    Then Wait for "3" Seconds
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "990"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "90"
    Then "Assign" Carrier
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 7
    Then Go to "Summary" Tab
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status |
      | Delivered   |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Load Status |
      | Delivered   |

    #Step 9
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 10
    Then Navigate to stored URL for "Load_1L"

    #step 11 and expected result a
    Then Scroll Until Related List for "Participant Matches"
    Then Verify Table "Participant Matches" row count is "2"

    #expected result b
    Then Click on "Participant Match-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "PayIQ Program" as "PayIQ Program 2757"
    Then Wait for "2" Seconds
    Then Scroll into Section "Currency Converted Financials"
    Then Verify Details
    |Converted Margin (Quoted)|Converted Revenue (Quoted)|Converted Freight (Quoted)|Converted Fuel (Quoted)|Converted Margin (Invoiced)|Converted Revenue (Invoiced)|Converted Freight (Invoiced)|Converted Fuel (Invoiced)|
    |USD 14.93                |USD 820.90                |USD 746.27                |USD 74.63              |USD 14.93                  |USD 820.90                  |USD 746.27                  |USD 74.63                |

   #expected result c
    Then Navigate Browser Back
    Then Click on "Participant Match-" with "Participant Name" as "Second User (User)" and "PayIQ Program" as "PayIQ Program 2757"
    Then Wait for "2" Seconds
    Then Scroll into Section "Currency Converted Financials"
    Then Verify Details
      |Converted Margin (Quoted)|Converted Revenue (Quoted)|Converted Freight (Quoted)|Converted Fuel (Quoted)|Converted Margin (Invoiced)|Converted Revenue (Invoiced)|Converted Freight (Invoiced)|Converted Fuel (Invoiced)|
      |USD 14.93               |USD 820.90             |USD 746.27              |USD 74.63             |USD 14.93                  |USD 820.90              |USD 746.27                |USD 74.63               |





