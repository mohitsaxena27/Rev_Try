Feature:3371 - GenTierPayJob- Calc Method: Amt Contrbn- Revoke Payout If Dipped Under Threshold
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @3371
  Scenario: 3371 - GenTierPayJob- Calc Method: Amt Contrbn- Revoke Payout If Dipped Under Threshold

    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"

 #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Progressive Pay Amount" from List

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

#Step 3
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Get "Calculation Tier-" Name with "Amount" as "USD 3.00" and store in "Calculation Tier ID_1"
    Then Get "Calculation Tier-" Name with "Amount" as "USD 10.00" and store in "Calculation Tier ID_2"

   #Step 4
    Then Scroll Until Related List for "Calculation Tiers"
    Then Click on "Calculation Tier-" with "Amount" as "USD 3.00" and "From (>)" as "0.00" and "To (<=)" as "2,000.00"
    Then Wait for "4" Seconds
    Then Capture the current URL for "CalculationTier1"

    Then Scroll into Section "Tier Calculation Settings"
    Then Click on Edit icon on Label "Revoke Payout If Dipped Under Threshold"
    Then Update details
      |Revoke Payout If Dipped Under Threshold|
      |true|
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Revoke Payout If Dipped Under Threshold|
      |true|
    Then Set Key "Load_ID" page Record Id with "rtms__Load__c"


  #Step 5
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Calculation Tiers"
    Then Click on "Calculation Tier-" with "Amount" as "USD 10.00" and "From (>)" as "2,000.00" and "To (<=)" as "3,000.00"
    Then Wait for "4" Seconds
    Then Capture the current URL for "CalculationTier2"
    Then Scroll into Section "Tier Calculation Settings"
    Then Click on Edit icon on Label "Revoke Payout If Dipped Under Threshold"
    Then Update details
      |Revoke Payout If Dipped Under Threshold|
      |true|
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Revoke Payout If Dipped Under Threshold|
      |true|

    #Step 6 and 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Indy Irrigation | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | NFL Hall of Fame  | 2        | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       |  Pieces  | 7500  | NA           | NA       | NA     |
    Then Save Load With All details
    Then Capture the current URL for "Load_1L"

    #Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "800"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 9
    Then Go to "PayIQ" Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      |Carrier Sales Rep|
       |Chatter Expert   |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Carrier Sales Rep|
      |Chatter Expert   |

    #Step 10 and 11
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Indy Irrigation | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | NFL Hall of Fame  | 2        | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       |  Pieces  | 7500  | NA           | NA       | NA     |
    Then Save Load With All details
    Then  Capture the current URL for "Load_2L"

    #Step 12
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "-300"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "-400"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 13 & 14
    Then Go to "PayIQ" Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      |Carrier Sales Rep|
      |Chatter Expert   |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Carrier Sales Rep|
      |Chatter Expert   |

    #Step 15
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

  #Step 16 and expected result a and b
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
    |Load|
    |SysData=>1L|
    Then Wait for "4" Seconds
    Then Verify Normalized Text displaying as "PayIQ Program not open: PayIQProgram Individual Load Margin (Quoted)"
    Then Scroll down with "5" Times
    Then Verify Logs displaying as "[Within {Calculation Tier ID_1} calculation] = 0 < [Running Aggregated Full Revenue (Quoted)] <= 2,000 Prior Running aggregate: 0 Load contribution to tier: 2,000"
    Then Verify Logs displaying as "[Within {Calculation Tier ID_2} calculation] = 2,000 < [Running Aggregated Full Revenue (Quoted)] <= 3,000 Prior Running aggregate: 2,000 Load contribution to tier: 300"
    Then Verify Logs displaying as "[{Calculation Tier ID_1} Pay Amount] = [Flat Rate] = 3 USD"
    Then Verify Logs displaying as "[{Calculation Tier ID_2} Pay Amount] = [Flat Rate] = 10 USD"

    Then Update details
      |Load|
      |SysData=>2L|
    Then Wait for "4" Seconds
    Then Verify Normalized Text displaying as "PayIQ Program not open: PayIQProgram Individual Load Margin (Quoted)"
    Then Verify Logs displaying as "[Within {Calculation Tier ID_1} calculation] = 0 < [Running Aggregated Full Revenue (Quoted)] <= 2,000 Prior Running aggregate: 1,600 Load contribution to tier: -400"
    Then Verify Logs displaying as "[Within {Calculation Tier ID_2} calculation] = 2,000 < [Running Aggregated Full Revenue (Quoted)] <= 3,000 Prior Running aggregate: 1,200 Load contribution to tier: -300"
    Then Verify Logs displaying as "[{Calculation Tier ID_1} Pay Amount] = [Flat Rate] = -3 USD"
    Then Verify Logs displaying as "[{Calculation Tier ID_2} Pay Amount] = [Flat Rate] = -10 USD"

#Step 17 and expected result c
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Get "Pay Header-" Name with "Pay Amount" as "USD 3.00" and store in "Pay_Header_1"
    Then Verify "Pay Details" Table Details
      |Participant Name     |Pay Amount|Calculation Tier              |Pay Header|PayIQ Program|
      |Chatter Expert (User)|USD 3.00  |SysData=>Calculation Tier ID_1|SysData=>Pay_Header_1|PayIQ Program Progressive Pay Amount|
      |Chatter Expert (User)|USD 10.00 |SysData=>Calculation Tier ID_2|SysData=>Pay_Header_1|PayIQ Program Progressive Pay Amount|

    #Step 18 and expected result d
    Then Navigate to stored URL for "Load_2L"
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Verify "Pay Details" Table Details
      |Participant Name     |Pay Amount|Calculation Tier              |Pay Header           |PayIQ Program|
      |Chatter Expert (User)|USD -3.00 |SysData=>Calculation Tier ID_1|SysData=>Pay_Header_1|PayIQ Program Progressive Pay Amount|
      | Chatter Expert (User)|USD -10.00 |  SysData=>Calculation Tier ID_2|SysData=>Pay_Header_1|PayIQ Program Progressive Pay Amount|