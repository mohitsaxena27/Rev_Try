Feature:3365 - GenTierPayJob- Calc Tiers Bracket Rounding and Currency
  Background: Pre- Test
    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Update details
      |Quick Find      |
      |Manage Currencies|
    Then Wait for "1" Seconds
    Then Click on "Manage Currencies" with Text
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Currency ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "Manage Dated Exchange Rates" -
    Then Wait for "5" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "Continue" -
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Wait for "2" Seconds
    Then Click on button with Title "New Exchange Rates" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Dated Exchange Rates ~ Salesforce - Enterprise Edition"
    Then Set "YesterdayDate" with "Date(M/d/yyyy)=>-1"
   Then Add New Exchange Rate with Start Date as "SysData=>YesterdayDate" and CAD as "0.9999"
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Capture the current URL for "CurrencyExchanged"
    Then Close Current Tab
    Then Switch to Parent Window

  @API @Regression @PayIQ @WEB @SingleCurrency @3365 @PayIQ_Logs
  Scenario: 3365 - GenTierPayJob- Calc Tiers Bracket Rounding and Currency

    #Step 2 & 3
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Progressive Pay Amount" from List

    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program"

    #Step 4
    Then Scroll Until Related List for "Calculation Tiers"
    Then Get "Calculation Tier-" Name with "Amount" as "USD 3.00" and store in "Calc_TierID_3"
    Then Get "Calculation Tier-" Name with "Amount" as "USD 10.00" and store in "Calc_TierID_10"

    #Step 5 & 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Indy Irrigation | Truckload | NA             | NA            | NA                |

    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | NFL Hall of Fame | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Pieces      | 7500   | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load_1L"
    Then Wait for "5" Seconds

    #Step 7
    Then Go to "Summary" Tab
    Then Wait for "2" Seconds
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Currency"
    Then Update details
      |Currency|
      |CAD - Canadian Dollar     |
    Then Click on "Save" button on Details Page
    Then Wait for "1" Seconds
    Then Verify Details
      |Currency|
      |CAD - Canadian Dollar     |

    #Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   | Currency ISO Code     |
      | Accepted | CAD - Canadian Dollar |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000.0035"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "999.7839"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 9
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 10
    Then Open "PayIQ Admin" from App Launcher
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 11
    Then Go to "Logs" Tab
    Then Update details
      | Load        |
      | SysData=>1L |
    Then Wait for "6" Seconds
    Then Set "TodayTime" with "Date(yyyy-MM-dd)=>0"

    # Expected Result A
    Then Verify Logs Contains as "Load did not contribute to {Calc_TierID_10}: (2,000 < [Running Aggregated Full Revenue (Quoted)] <= 3,000). Prior running aggregate: 0 Load contribution to tier: 1,999.99"
    Then Verify Logs Contains as "[Within {Calc_TierID_3} calculation] = 0 < [Running Aggregated Full Revenue (Quoted)] <= 2,000 Prior Running aggregate: 0 Load contribution to tier: 1,999.99"
    Then Verify Logs Contains as "[{Calc_TierID_3} Pay Amount] = [Flat Rate] = 3 USD"

    # Currency Conversion Log
    Then Verify Logs Contains as "[Margin (Quoted)] converted from CAD to USD (using dated exchange rate from {TodayTime}) => 1,999.79 CAD = 1,999.99 USD"
    Then Verify Logs Contains as "[Revenue (Quoted)] converted from CAD to USD (using dated exchange rate from {TodayTime}) => 1,999.79 CAD = 1,999.99 USD"
    Then Verify Logs Contains as "[Freight (Quoted)] converted from CAD to USD (using dated exchange rate from {TodayTime}) => 1,000.004 CAD = 1,000.104 USD"
    Then Verify Logs Contains as "[Fuel (Quoted)] converted from CAD to USD (using dated exchange rate from {TodayTime}) => 999.784 CAD = 999.884 USD"

