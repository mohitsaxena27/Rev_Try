Feature: 2860 - GenTierPayJob- Calc Tier: Load Revenue/Percent of Negative Load Margin Qtd

  @API @Regression @PayIQ @WEB @SingleCurrency @2860 @GenTierPayJob @PayIQ_Logs
  Scenario: 2860 - GenTierPayJob- Calc Tier: Load Revenue/Percent of Negative Load Margin Qtd

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
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Margin (Quoted)" and "From (>)" as "0.00" and "To (<=)" as "50.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Set "Calculation_Tier_1" with "SysData=>Calculation Tier ID"

    # Step 5
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Calculation Tiers"
    Then Click on link "Calculation Tiers"
    Then Wait for "2" Seconds
    Then Click on button with Title Text "New"
    Then Update details
      | Criteria    | Criteria Financials to Use | Criteria Aggregation Method   | From (>) | To (<=) | Calculation Method     | Calculation Financials to Use | Percent |
      | Load Margin | Quoted                     | Individual (do not aggregate) | -1000    | 0       | Percent of Load Margin | Quoted                          | 15      |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Get "Calculation Tier-" Name with "Percent" as "15.00%" and store in "Calculation_Tier_2"

    # Step 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | NA            | NA                |

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
    Then Wait for "2" Seconds

#    Then Click on Edit icon on Label "Customer Sales Rep"
#    Then Update details
#      | Customer Sales Rep | Carrier Sales Rep | Custom PayIQ Eligible Date |
#      | User User          | User User         | 0                          |
#    Then Click on "SaveEdit" button on Details Page
#    Then Wait for "2" Seconds
#    Then Verify Details
#      | Customer Sales Rep |
#      | User User          |

    # Step 7 & 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "30"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "20"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Wait for "2" Seconds
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "175"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "50"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    # Step 9 & 10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 11 & 12
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Wait for "2" Seconds

    # Step 13 & 14 and Expected Result 1(a)
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation_Tier_1" and "Participant Name" as "User User (User)"
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD -17.50 | Pay Header- |
    Then Scroll into Section "Load Financials"
    Then Verify Details
      | Converted Margin (Quoted) |
      | USD -175.00               |

    # Step 15 and Expected Result 2(b)
    Then Go to "Logs" Tab
    Then Wait for "3" Seconds
    Then Verify Logs displaying as "[Within {Calculation_Tier_1} calculation] = [From] < [Individual Full Revenue (Quoted)] <= [To] = 0 < 50 <= 50"

    # Step 16 and Expected Result 3(c)
    Then Verify Logs displaying as "[{Calculation_Tier_1} Pay Amount] = [Load Margin (Quoted)] x [Percent] = -175 x 10% = -17.5 USD"

    # Step 17 & 18
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Wait for "1" Seconds

    # Step 19 & 20 and Expected Result 4(d)
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation_Tier_2" and "Participant Name" as "User User (User)"
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD -26.25 | Pay Header- |

    # Step 21 and Expected Result 5(e)
    Then Go to "Logs" Tab
    Then Wait for "3" Seconds
    Then Verify Logs displaying as "[Within {Calculation_Tier_2} calculation] = [From] < [Individual Margin (Quoted)] <= [To] = -1,000 < -175 <= 0"

    # Step 22 and Expected Result 6(f)
    Then Verify Logs displaying as "[{Calculation_Tier_2} Pay Amount] = [Load Margin (Quoted)] x [Percent] = -175 x 15% = -26.25 USD"

    # Step 23 & 24 and Expected Result 7(g)
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "3" Seconds
    Then Scroll into Section "Totals"
    Then Get Details
      | Date Range |
      |            |
    Then Verify "Date Range" is within current month
