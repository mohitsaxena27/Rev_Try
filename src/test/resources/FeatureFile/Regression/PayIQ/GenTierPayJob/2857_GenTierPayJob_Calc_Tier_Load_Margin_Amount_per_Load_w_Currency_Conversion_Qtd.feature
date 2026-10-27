Feature:2857 - GenTierPayJob- Calc Tier: Load Margin/Amount per Load w/ Currency Conversion Qtd

  @API @Regression @PayIQ  @WEB @SingleCurrency @2857 @PayIQ_Logs
  Scenario: 2857 - GenTierPayJob- Calc Tier: Load Margin/Amount per Load w/ Currency Conversion Qtd

    When Login into Salesforce

#   Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Margin (Quoted)" from List


    #Step 3
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

    #Step 4
    Then Click on "Calculation Tier-" with "Calculation Description" as "Amount per Load" and "From (>)" as "50.00" and "To (<=)" as "100.00"
    Then Wait for "2" Seconds
    Then Get Details
    |Calculation Tier ID|
    |                   |

    #Step 5 & 6
    Then Search and Select "Contact" "Joe Revenova PayIQ" from the Global search
    Then Go to "Details" Tab
    Then Scroll into Section "System Information"
    Then Click on Edit icon on Label "Contact Currency"
    Then Update details
    |Contact Currency|
    |CAD - Canadian Dollar|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Contact Currency|
      |CAD - Canadian Dollar|

    #Step 7
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Store date with month offset -1 and day 1 in format "MMM d, yyyy" into "FirstOfLastMonth"
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date             | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | SysData=>FirstOfLastMonth | NA                       | NA               | NA                   |
    Then Store date with month offset -1 and day 4 in format "MMM d, yyyy" into "FourthOfLastMonth"
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date              | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | SysData=>FourthOfLastMonth | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000   | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 8
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date |
      | Joe Revenova PayIQ   | SysData=>FirstOfLastMonth  |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact) |
      | Joe Revenova PayIQ   |

    #Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |Currency ISO Code|
      | Accepted |USD - U.S. Dollar|
    Then Enter "Customer Quote Items" "Net Freight Charges" as "50"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "20"
    Then Add "Load" "Customer Quote Items" "Other" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "30"
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."

    #Step 10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 11
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 12
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds

    #Step 13 & 14
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID" and "Participant Name" as "Joe Revenova PayIQ (Contact)"

    #Step 15 & expected a
    Then Verify Details
      | Pay Amount          | Converted Margin (Invoiced) | Pay Header  |
      | CAD 4.02 (USD 3.00) | CAD 134.00 (USD 100.00)     | Pay Header- |
    Then Capture the current URL for "Pay_Details"

    #Step 16 & expected b
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Margin (Quoted)] <= [To] = 67 < 134 <= 134"

    #Step 17 & expected c
    Then Verify Logs displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate] = 4.02 CAD"

    #Step 18
    Then Click on "PayIQ Log-" with "Type" as "Currency Conversion"
    Then Wait for "5" Seconds

    #Step 19 & expected d
    Then Store date with month offset -1 and day 1 in format "yyyy-MM-dd" into "FirstOfLastMonth"
    Then Get Details
      | Detail |
      |        |
    Then Set "Log1" with "[Calculation Amount] converted from USD to CAD (using dated exchange rate from " and "SysData=>FirstOfLastMonth" and ") => 3 USD = 4.02 CAD"
    Then Set "Log2" with "[Criteria From] converted from USD to CAD (using dated exchange rate from " and "SysData=>FirstOfLastMonth" and ") => 50 USD = 67 CAD"
    Then Set "Log3" with "[Criteria To] converted from USD to CAD (using dated exchange rate from " and "SysData=>FirstOfLastMonth" and ") => 100 USD = 134 CAD"
    Then Verify Assertion for "Detail" contains "SysData=>Log1"
    Then Verify Assertion for "Detail" contains "SysData=>Log2"
    Then Verify Assertion for "Detail" contains "SysData=>Log3"

    #Expected e
    Then Navigate to stored URL for "Pay_Details"
    Then Click on Partial Link Text "Pay Header-" on Page
    Then  Get Details
      | Total Pay |Date Range|
      |           |          |
    Then Capture the current URL for "Pay_Header"
    Then Then Verify "Total Pay" is at least "CAD 4.02"
    Then Set Payroll "Previous" Month Range on To "Previous_Month_Range"
    Then Verify Details
      |Date Range|
      |SysData=>Previous_Month_Range|
    Then Set Key "Pay_Header_SFID" page Record Id with "rtms9__Pay_Header__c"