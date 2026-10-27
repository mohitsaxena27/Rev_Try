Feature: 2840 - GenTierPayJob- Calc Tier: Load Rev Full Qtd/Pct of Load Rev Fuel Only Invoiced

  @API @Regression @PayIQ @WEB @MultiCurrency @2840 @GenTierPayJob @PayIQ_Logs
  Scenario: 2840 - GenTierPayJob- Calc Tier: Load Rev Full Qtd/Pct of Load Rev Fuel Only Invoiced

    When Login into Salesforce

    # Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
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
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Revenue (Quoted)" and "From (>)" as "100.00" and "To (<=)" as "200.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |

    # Step 5
    Then Scroll into Section with Title "Tier Calculation Settings"
    Then Click on Edit icon on Label "Calculation Financials to Use"
    Then Enter Label "To (<=)" Text as ""
    Then Update details
      | Calculation Revenue Number | Calculation Financials to Use |
      | Fuel Only                  | Invoiced                      |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Calculation Revenue Number | Calculation Financials to Use |
      | Fuel Only                  | Invoiced                      |
    Then Capture the current URL for "CalculationTier"

    # Step 6
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
    Then Wait for "3" Seconds
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
    Then Enter "Customer Quote Items" "Net Freight Charges" as "125"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "125"
    Then Add "Load" "Customer Quote Items" "Other" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "25"
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."

    # Step 9 & 10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 11, 12, 13, 14 & Expected Result 1(a), 2(b), 3(c)
    Then Go to "Logs" Tab
    Then Wait for "5" Seconds
    Then Update details
      | Load        |
      | SysData=>1L |
    Then Wait for "5" Seconds
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = 0; Did not create zero amount pay detail"
    Then Verify Logs Contains as "[{Calculation Tier ID} Pay Amount] = [Load Fuel Only (Invoiced)] x [Percent] = 0 x 10% = 0 USD"
    Then Verify Logs Contains as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Full Revenue (Quoted)] <= [To] = 100 < 275 <= (NULL)"

    # Step 15 & 16
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."

    # Step 17 & 18
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 19 & 20 & Expected Result 4(d)
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD 12.50  | Pay Header- |
    Then Scroll into Section "Load Financials"
    Then Verify Details
      | Converted Fuel (Invoiced) |
      | USD 125.00                |
    Then Capture the current URL for "Pay_Details"

    # Step 21 & Expected Result 5(e)
    Then Go to "Logs" Tab
    Then Wait for "3" Seconds
    Then Verify Logs Contains as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Full Revenue (Quoted)] <= [To] = 100 < 275 <= (NULL)"

    # Step 22 & Expected Result 6(f)
    Then Verify Logs displaying as "[{Calculation Tier ID} Pay Amount] = [Load Fuel Only (Invoiced)] x [Percent] = 125 x 10% = 12.5 USD"

    # Step 23, 24 & Expected Result 7(g)
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "3" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Total Pay | Date Range |
      |           |            |
    Then Then Verify "Total Pay" is at least "USD 12.50"
    Then Verify "Date Range" is within current month
