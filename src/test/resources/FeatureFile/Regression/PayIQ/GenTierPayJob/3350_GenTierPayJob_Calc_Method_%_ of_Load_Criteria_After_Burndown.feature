Feature:3350 - GenTierPayJob- Calc Method: % of Load Criteria After Burndown

  @API @Regression @PayIQ @WEB @SingleCurrency @3350 @PayIQ_Logs
  Scenario: 3350 - GenTierPayJob- Calc Method: % of Load Criteria After Burndown

    When Login into Salesforce

    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Burndown" from List

    #Step 2
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

    #Step 3
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Percent" as "5.00%"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Set "Calc_TierID_5" with "SysData=>Calculation Tier ID"
    Then Navigate to stored URL for "PayIQ_Program_1"

    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Percent" as "10.00%"
    Then Wait for "3" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Set "Calc_TierID_10" with "SysData=>Calculation Tier ID"

    #Step 4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Indy Irrigation | Truckload |   NA         | NA             | NA                 |

    Then Wait for "2" Seconds

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

    #Step 5
    Then Capture the current URL for "Load_1L"

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "500"

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 7
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
    | Carrier Sales Rep |
    | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Indy Irrigation | Truckload |   NA         | NA             | NA                 |
    Then Wait for "2" Seconds

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
    Then Capture the current URL for "Load_2L"

    #Step 10
    Then Wait for "2" Seconds
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "3500"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "1000"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 11
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
   | Carrier Sales Rep |
   | Chatter Expert    |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

    #Step 12
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "10" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

     #Step 13.a & expected a
    Then Go to "Logs" Tab
    Then Update details
      |     Load     | Type          |
      | SysData=>1L  | Qualification |
    Then Click on button "Refresh"
    Then Wait for "4" Seconds
    Then Scroll down with "5" Times
    Then Verify Normalized Text displaying as "Burndown amount (2,000) not yet met. Running Aggregate: 1,500"

    #Step 13.b & expected b
    Then Go to "Logs" Tab
    Then Update details
      |     Load     | Type          |
      | SysData=>2L  | Qualification |
    Then Click on button "Refresh"
    Then Wait for "4" Seconds
    Then Scroll down with "7" Times
    Then Verify Logs Contains as "Metric 5,000 did not fall within {Calc_TierID_10} (6,000 < [Aggregated Freight Only (Quoted)] <= (NULL))"
    Then Verify Logs Contains as "[Within {Calc_TierID_5} calculation] = [From] < [Aggregated Freight Only (Quoted)] <= [To] = 2,000 < 5,000 <= 6,000"

    Then Update details
      |     Load     | Type          |
      | SysData=>2L  | Math     |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Logs Contains as "[{Calc_TierID_5} Pay Amount] = [Load Contribution to Aggregate Less Burndown] x [Percent] = 3,000 x 5% = 150 USD"

    #Step 14
     Then Navigate to stored URL for "Load_1L"
    #step 15
    Then Go to "PayIQ" Tab

    Then Scroll Until Related List for "Pay Details"
    #expected c
    Then Verify Table "Pay Details" row count is "0"
    #step 16
    Then Navigate to stored URL for "Load_2L"
    #step 17
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "5500"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 18
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Chatter Expert (User)"
    Then Wait for "2" Seconds
    #Expected Result d
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount  | Pay Header |
      | USD 150.00 |   Pay Header-  |
    Then Scroll into Section "Pay Rule"
    Then Verify Details
      | PayIQ Program  | Calculation Tier|
      | PayIQ Program Burndown|  SysData=>Calc_TierID_5 |
      #Step 19
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Approved       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Approved       |

    #Step 20
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "7" Seconds
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 21.a
    Then Go to "Logs" Tab
#   Then Click on "Refresh" button
    Then Update details
      | Load   |
      | SysData=>1L |
    Then Wait for "2" Seconds

   # Expected Result e
    Then Update details
      |     Load     | Type          |
      | SysData=>1L  | Qualification |
    Then Click on button "Refresh"
    Then Wait for "4" Seconds
    Then Verify Logs Contains as "Burndown amount (2,000) not yet met. Running Aggregate: 1,500"

   #Step 21.b
    Then Update details
      |     Load     | Type          |
      | SysData=>2L  | Qualification |
    # Expected Result f
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Scroll down with "9" Times
    
    Then Verify Normalized Text displaying as "PayIQ Program not open: PayIQ Program 1936"

    Then Verify Logs Contains as "[Within {Calc_TierID_10} calculation] = [From] < [Aggregated Freight Only (Quoted)] <= [To] = 6,000 < 7,000 <= (NULL)"

    Then Verify Logs Contains as "Metric 7,000 did not fall within {Calc_TierID_5} (2,000 < [Aggregated Freight Only (Quoted)] <= 6,000)"

    Then Verify Logs Contains as "[Within {Calc_TierID_5} calculation] = [From] < [Aggregated Freight Only (Quoted)] <= [To] = 2,000 < 5,000 <= 6,000"


    Then Update details
      |     Load     | Type    |
      | SysData=>2L  | Math    |
    Then Verify Logs Contains as "[{Calc_TierID_5} Pay Amount] = [Load Contribution to Aggregate Less Burndown] x [Percent] = 3,000 x 5% = 150 USD"

    Then Verify Logs Contains as "[Adjusted Pay (For No Longer In Tier)] = - [Amount Already Paid] = - (150) = -150 USD"

    Then Verify Logs Contains as "[{Calc_TierID_10} Pay Amount] = [Load Contribution to Aggregate Less Burndown] x [Percent] = 5,000 x 10% = 500 USD"

    #Step 22
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds

    Then Go to "PayIQ" Tab

    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times

    # Expected Result g
    Then Verify Table "Pay Details" row count is "0"

    #Step 23
    Then Navigate to stored URL for "Load_2L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times

    #Expected Result h
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 150.00"
    Then Verify Details
      | Participant Name      | Pay Amount  |    Calculation Tier     | Pay Header | PayIQ Program          |
      | Chatter Expert (User) | USD 150.00  | SysData=>Calc_TierID_5 |Pay Header-  | PayIQ Program Burndown |

    Then Navigate to stored URL for "Load_2L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Click on "Pay Detail-" with "Pay Amount" as "USD -150.00"
    Then Verify Details
      | Participant Name      | Pay Amount  | Calculation Tier       | Pay Header  | PayIQ Program          |
      | Chatter Expert (User) | USD -150.00 | SysData=>Calc_TierID_5 | Pay Header-  | PayIQ Program Burndown |

    Then Navigate to stored URL for "Load_2L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 500.00"
    Then Verify Details
      | Participant Name      | Pay Amount  |    Calculation Tier     | Pay Header  |PayIQ Program           |
      | Chatter Expert (User) | USD 500.00  | SysData=>Calc_TierID_10 |Pay Header-  | PayIQ Program Burndown |