Feature:2834 - GenTierPayJob- Calc Tier: Load Margin/Percent of Load Margin w/Min Inv

  @API @Regression @PayIQ  @WEB @SingleCurrency @2834 @PayIQ_Logs
  Scenario: 2834 - GenTierPayJob- Calc Tier: Load Margin Percent of Load Margin w/Min Inv

    When Login into Salesforce

   #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Margin Percentage (Invoiced)" from List

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
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Margin with Min (Invoiced)" and "From (>)" as "50.00" and "To (<=)" as "100.00"
    Then Wait for "2" Seconds
    Then Get Details
    |Calculation Tier ID|
    |                   |

    #Step 5
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
      | 1         | P1     | D2       | Bananas     | 15000   | NA           | NA       | NA             |

    Then Save Load With All details

    Then  Capture the current URL for "Load_1L"

    #Step 6
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date |
      | Joe Revenova PayIQ   | 0                          |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact) |
      | Joe Revenova PayIQ   |

    #Step 7 & 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "50"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Save was successful."

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
    Then Wait for "1" Seconds
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Wait for "1" Seconds
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD 51.00  | Pay Header- |
    Then Scroll into Section "Load Financials"
    Then Verify Details
        |Converted Margin (Invoiced)|
        |USD 75.00                 |

    Then Capture the current URL for "Pay_Details"

    #Step 13 & expected b
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Margin Percentage (Invoiced)] <= [To] = 50 < 100 <= 100"

   #Step 14 & expected c
    Then Verify Logs displaying as "{Calculation Tier ID} Pay Amount 7.5 is below min of 51. [Pay Amount] = 51 USD"
    Then Verify Logs displaying as "[{Calculation Tier ID} Pay Amount] = [Load Margin (Invoiced)] x [Percent] = 75 x 10% = 7.5 USD"

    #Step 15, 16 & expected d
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "1" Seconds
    Then Scroll into Section "Totals"
    Then  Get Details
      | Total Pay |Date Range|
      |           |          |
    Then Then Verify "Total Pay" is at least "USD 51.00"
    Then Verify "Date Range" is within current month