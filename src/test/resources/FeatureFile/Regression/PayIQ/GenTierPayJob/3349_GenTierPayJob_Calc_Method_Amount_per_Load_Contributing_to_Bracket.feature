Feature:3349 - GenTierPayJob- Calc Method: Amount per Load Contributing to Bracket

  @API @Regression @PayIQ  @WEB @SingleCurrency @3349 @PayIQ_Logs
  Scenario: 3349 - GenTierPayJob- Calc Method: Amount per Load Contributing to Bracket

    When Login into Salesforce

    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Progressive Pay Amount" from List

    #Step 2
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
    Then Click on "Calculation Tier-" with "Amount" as "USD 3.00"
    Then Wait for "2" Seconds
    Then Get Details
    |Calculation Tier ID|
    |                   |
    Then Set "Calculation Tier1" with "SysData=>Calculation Tier ID"
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Click on "Calculation Tier-" with "Amount" as "USD 10.00"
    Then Wait for "2" Seconds
    Then Get Details
      |Calculation Tier ID|
      |                   |
    Then Set "Calculation Tier2" with "SysData=>Calculation Tier ID"

    #Step 4 & 5
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Indy Irrigation | Truckload | NA             | N             | N                 |
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
    Then  Capture the current URL for "Load_1L"

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1700"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "500"
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."

    #Step 7
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert   |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Chatter Expert   |

    #Step 8 & 9
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Indy Irrigation | Truckload | NA             | N             | N                 |
    Then Wait for "1" Seconds
    Then Store date "0" days and "1" "months" from current date into "FutureDate1"
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date        | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | SysData=>FutureDate1 | NA                       | NA               | NA                   |
    Then Store date "2" days and "1" "months" from current date into "FutureDate2"
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date        | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | NFL Hall of Fame | SysData=>FutureDate2 | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Pieces      | 7500   | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_2L"

    #Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "600"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "300"
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."

    #Step 11
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert   |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Chatter Expert   |

    #Step 12
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 13
    Then Go to "Logs" Tab
    Then Update details
      | Load        |
      | SysData=>1L |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Expected a
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "[Within {Calculation Tier1} calculation] = 0 < [Running Aggregated Full Revenue (Quoted)] <= 2,000 Prior Running aggregate: 0 Load contribution to tier: 2,000"
    Then Verify logs in PayIQ Admin displaying as "[Within {Calculation Tier2} calculation] = 2,000 < [Running Aggregated Full Revenue (Quoted)] <= 3,000 Prior Running aggregate: 2,000 Load contribution to tier: 200"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier1} Pay Amount] = [Flat Rate] = 3 USD"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier2} Pay Amount] = [Flat Rate] = 10 USD"

    #Expected b
    Then Update details
      | Load        |
      | SysData=>2L |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify logs in PayIQ Admin displaying as "Load did not contribute to {Calculation Tier2}: (2,000 < [Running Aggregated Full Revenue (Quoted)] <= 3,000). Prior running aggregate: 0 Load contribution to tier: 900"
    Then Verify logs in PayIQ Admin displaying as "[Within {Calculation Tier1} calculation] = 0 < [Running Aggregated Full Revenue (Quoted)] <= 2,000 Prior Running aggregate: 0 Load contribution to tier: 900"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier1} Pay Amount] = [Flat Rate] = 3 USD"

    #Step 14 & Expected c
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Verify Table "Pay Details" row count is "2"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 3.00" and "Calculation Tier" as "SysData=>Calculation Tier1"
    Then Verify Details
      | Participant Name      | Calculation Tier           | Pay Amount | Pay Header  | PayIQ Program                        |
      | Chatter Expert (User) | SysData=>Calculation Tier1 | USD 3.00   | Pay Header- | PayIQ Program Progressive Pay Amount |
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Get Details
      | Pay Header ID |
      |               |
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 10.00" and "Calculation Tier" as "SysData=>Calculation Tier2"
    Then Verify Details
      | Participant Name      | Calculation Tier           | Pay Amount | Pay Header          | PayIQ Program                        |
      | Chatter Expert (User) | SysData=>Calculation Tier2 | USD 10.00  | SysData=>Pay Header ID | PayIQ Program Progressive Pay Amount |

    #Step 15 & Expected d
    Then Navigate to stored URL for "Load_2L"
    Then Scroll Until Related List for "Pay Details"
    Then Verify Table "Pay Details" row count is "1"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 3.00" and "Calculation Tier" as "SysData=>Calculation Tier1"
    Then Verify Details
      | Participant Name      | Calculation Tier           | Pay Amount | Pay Header  | PayIQ Program                        |
      | Chatter Expert (User) | SysData=>Calculation Tier1 | USD 3.00   | Pay Header- | PayIQ Program Progressive Pay Amount |
    Then Navigate to stored URL for "Load_2L"
    Then Wait for "4" Seconds
    Then Expand "Details" for "1" Load
    Then Click on Edit icon with Field Name "1P" "Location"
    Then Update details
      | Expected Date |
      | 0             |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Collapse "Details" for "1" Load
    Then Wait for "2" Seconds

    #Step 16
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 17
    Then Go to "Logs" Tab
    Then Click on button "Refresh"
    Then Update details
      | Load        |
      | SysData=>1L |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Expected e
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "[Within {Calculation Tier1} calculation] = 0 < [Running Aggregated Full Revenue (Quoted)] <= 2,000 Prior Running aggregate: 0 Load contribution to tier: 2,000"
    Then Verify logs in PayIQ Admin displaying as "[Within {Calculation Tier2} calculation] = 2,000 < [Running Aggregated Full Revenue (Quoted)] <= 3,000 Prior Running aggregate: 2,000 Load contribution to tier: 200"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier1} Pay Amount] = [Flat Rate] = 3 USD"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier2} Pay Amount] = [Flat Rate] = 10 USD"

    #Expected f
    Then Go to "Logs" Tab
    Then Click on button "Refresh"
    Then Update details
      | Load        |
      | SysData=>2L |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify logs in PayIQ Admin displaying as "Load did not contribute to {Calculation Tier1}: (0 < [Running Aggregated Full Revenue (Quoted)] <= 2,000). Prior running aggregate: 2,200 Load contribution to tier: 900"
    Then Verify logs in PayIQ Admin displaying as "[Within {Calculation Tier2} calculation] = 2,000 < [Running Aggregated Full Revenue (Quoted)] <= 3,000 Prior Running aggregate: 2,200 Load contribution to tier: 800"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier2} Pay Amount] = [Flat Rate] = 10 USD"

    #Step 18 & Expected g
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Verify Table "Pay Details" row count is "2"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 3.00" and "Calculation Tier" as "SysData=>Calculation Tier1"
    Then Verify Details
      | Participant Name      | Calculation Tier           | Pay Amount | Pay Header          | PayIQ Program                        |
      | Chatter Expert (User) | SysData=>Calculation Tier1 | USD 3.00   | SysData=>Pay Header ID | PayIQ Program Progressive Pay Amount |
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 10.00" and "Calculation Tier" as "SysData=>Calculation Tier2"
    Then Verify Details
      | Participant Name      | Calculation Tier           | Pay Amount | Pay Header          | PayIQ Program                        |
      | Chatter Expert (User) | SysData=>Calculation Tier2 | USD 10.00  | SysData=>Pay Header ID | PayIQ Program Progressive Pay Amount |

    #Step 19 & Expected h
    Then Navigate to stored URL for "Load_2L"
    Then Scroll Until Related List for "Pay Details"
    Then Verify Table "Pay Details" row count is "1"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 10.00" and "Calculation Tier" as "SysData=>Calculation Tier2"
    Then Verify Details
      | Participant Name      | Calculation Tier           | Pay Amount | Pay Header  | PayIQ Program                        |
      | Chatter Expert (User) | SysData=>Calculation Tier2 | USD 10.00   | Pay Header- | PayIQ Program Progressive Pay Amount |


