Feature:2817 - GenTierPayJob- Calc Tier: Load Margin/Percent of Load Margin(SlidingScale)Quoted.

  @API @Regression @PayIQ  @WEB @SingleCurrency @2817 @GenTierPayJob
  Scenario: 2817 - GenTierPayJob- Calc Tier: Load Margin/Percent of Load Margin(SlidingScale)Quoted.


    When Login into Salesforce

    #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Margin (Quoted)" from List
    #Step 3
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

    #Step 4
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Margin (Quoted - Sliding Scale)" and "From (>)" as "25.00" and "To (<=)" as "50.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Set "Calculation_Tier_1" with "SysData=>Calculation Tier ID"


    #Step 5 - Second Calculation Tier
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Margin (Quoted - Sliding Scale)" and "From (>)" as "50.00" and "To (<=)" as "100.00"
    Then Wait for "3" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Set "Calculation_Tier_2" with "SysData=>Calculation Tier ID"


    #Step 6
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
    Then Capture the current URL for "Load_1L"

    #Step 7
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date |
      | Joe Revenova PayIQ   | 0                          |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact) |
      | Joe Revenova PayIQ   |

    #Step  8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "25"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 9
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "10" Seconds

    #Step 10
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 11
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds

   #Step 12 & Expected a
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation_Tier_1"
    Then Wait for "1" Seconds
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD 5.00   | Pay Header- |
    Then Scroll into Section "Load Financials"
    Then Verify Details
      | Converted Margin (Quoted) |
      | USD 50.00                 |
    Then Capture the current URL for "Pay_Details"

    #Step 13 & Expected b
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Within {Calculation_Tier_1} calculation] = [From] < [Individual Margin (Quoted)] <= [To] = 25 < 50 <= 50"

    #Step 14 & Expected c
    Then Verify Logs Contains as "[{Calculation_Tier_1} Pay Amount] = [Load Margin (Quoted)] x [Percent] x MIN([Load Margin (Quoted)]/[Amount], 1.0) = 50 x 10% x MIN(50/49, 1.0) = 5 USD"

    #Step 15, 16 & Expected d
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Total Pay | Date Range |
      |           |            |
    Then Then Verify "Total Pay" is at least "USD 5.00"
    Then Verify "Date Range" is within current month

    #Step 17
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds

    #Step 18
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "26"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 19
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds

    #Step 20
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 21
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds

    #Step 22 & 23
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "12" Times
    Then Wait for "10" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation_Tier_2"
    Then Wait for "2" Seconds
    #24 & Expected  e
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD 2.63   | Pay Header- |
    Then Scroll into Section "Load Financials"
    Then Verify Details
      | Converted Margin (Quoted) |
      | USD 51.00                 |

    #Step 25 & Expected f
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Within {Calculation_Tier_2} calculation] = [From] < [Individual Margin (Quoted)] <= [To] = 50 < 51 <= 100"

    #Step 26 & Expected g
    Then Verify Logs Contains as "[{Calculation_Tier_2} Pay Amount] = [Load Margin (Quoted)] x [Percent] x MIN([Load Margin (Quoted)]/[Amount], 1.0) = 51 x 10% x MIN(51/99, 1.0) = 2.627 USD"

    #Step 27
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "3" Seconds
    #Expected h
    Then Verify "Pay Details" Table Details
      | Type                                            | Rate                  | Paid From Type | Paid From   |
      | Percent of Load Margin (Quoted - Sliding Scale) | 10% sliding to $99.00 | Load           | SysData=>1L |

