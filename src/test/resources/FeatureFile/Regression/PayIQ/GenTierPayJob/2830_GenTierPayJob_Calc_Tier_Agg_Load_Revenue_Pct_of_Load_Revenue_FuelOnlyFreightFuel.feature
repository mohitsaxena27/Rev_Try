Feature: 2830 - GenTierPayJob- Calc Tier: Agg. Load Revenue/Pct of Load Revenue FuelOnly/Freight+Fuel

  @API @Regression @PayIQ @WEB @SingleCurrency @2830 @GenTierPayJob @PayIQ_Logs
  Scenario: 2830 - GenTierPayJob- Calc Tier: Agg. Load Revenue/Pct of Load Revenue FuelOnly/Freight+Fuel

    When Login into Salesforce

    # Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Wait for "3" Seconds
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List
    # Step 3
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

    # Step 4
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Revenue (Quoted)" and "From (>)" as "100.00" and "To (<=)" as "200.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Capture the current URL for "Calculation_Tier"

    # Step 5
    Then Click on Edit icon on Label "Criteria Revenue Number"
    Then Update details
      | Criteria Revenue Number |Calculation Revenue Number|
      | Fuel Only               |Fuel Only                 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Verify Details
      | Criteria Revenue Number |Calculation Revenue Number|
      | Fuel Only               |Fuel Only                 |

    # Step 6 -
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Wait for "2" Seconds
    Then Capture the current URL for "Load_1L"

    # Step 7
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date |
      | Joe Revenova PayIQ   | 0                          |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact) |
      | Joe Revenova PayIQ   |

    # Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "10"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "160"
    Then Add "Load" "Customer Quote Items" "Other" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "25"
    Then "Save" Customer Quotes
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Save was successful."

    # Step 9 & 10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 11 & 12
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Wait for "1" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Wait for "2" Seconds

    # Expected Result a
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD 16.00  | Pay Header- |
    Then Scroll into Section "Load Financials"
    Then Verify Details
      | Converted Fuel (Quoted) |
      | USD 160.00              |
    Then Capture the current URL for "Pay_Details"

    # Step 13 - Expected Result B
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Fuel Only (Quoted)] <= [To] = 100 < 160 <= 200"

    # Step 14 - Expected Result C
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Load Fuel Only (Quoted)] x [Percent] = 160 x 10% = 16 USD"

    # Step 15 & 16
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "1" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Total Pay | Date Range |
      |           |            |
    # Expected Result D
    Then Then Verify "Total Pay" is at least "USD 16.00"
    Then Verify "Date Range" is within current month


    # Step 17 & 18
    Then Navigate to stored URL for "Calculation_Tier"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Criteria Revenue Number"
    Then Update details
      | Criteria Revenue Number |Calculation Revenue Number|
      | Freight + Fuel          |Freight + Fuel            |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Verify Details
      | Criteria Revenue Number |Calculation Revenue Number|
      | Freight + Fuel          |Freight + Fuel            |

    # Step 19 & 20
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "5" Seconds

    # Step 21, 22 & 23
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Wait for "1" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Wait for "2" Seconds

    # Step 24 & Expected Result E
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD 17.00  | Pay Header- |

    Then Scroll into Section "Load Financials"
    Then Verify Details
      | Converted Freight (Quoted) | Converted Fuel (Quoted) |
      | USD 10.00                  | USD 160.00              |

    # Step 25 - Expected Result F
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Freight + Fuel (Quoted)] <= [To] = 100 < 170 <= 200"

    # Step 26 - Expected Result G
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Load Freight + Fuel (Quoted)] x [Percent] = 170 x 10% = 17 USD"

    # Step 27
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "1" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Total Pay | Date Range |
      |           |            |

    #Step 28 &Expected Result H
    Then Then Verify "Total Pay" is at least "USD 17.00"
    Then Verify "Date Range" is within current month