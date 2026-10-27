Feature:3357 - GenTierPayJob-Calc Meth: One-Time Payout-Revoke Payout If Dipped Under Threshold

  @API @Regression @PayIQ @WEB @SingleCurrency @3357 @PayIQ_Logs
  Scenario: 3357 - GenTierPayJob-Calc Meth: One-Time Payout-Revoke Payout If Dipped Under Threshold

    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"

    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program One-Time Payout - Margin" from List

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
    Then Click on "Calculation Tier-" with "Amount" as "USD 10.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Capture the current URL for "Calculation_Tier"

    #Step 4
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

    #Step 5
    Then Capture the current URL for "Load_1L"

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Revenova PayIQ Carrier"
    Then Wait for "2" Seconds
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1750"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "250"
    Then Click on button with Title "Assign"
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "3500"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "500"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 7
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Indy Irrigation | Truckload | NA             | N             | N                 |
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

    #Step 9
    Then Capture the current URL for "Load_2L"

    #Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds

    Then Enter Carrier Service as "Revenova PayIQ Carrier"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1050"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "50"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    Then Update details
      | Status   |
      | Accepted |

    Then Enter "Customer Quote Items" "Net Freight Charges" as "1025"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "25"

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 11
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 12
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 13
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Click on button "Refresh"
    Then Update details
      | Load        |
      | SysData=>1L |
    Then Click on button "Refresh"
    Then Wait for "5" Seconds

    # Expected a
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "[Meets Target {Calculation Tier ID} calculation] = [From] <= [Running Aggregated Margin (Quoted)] = 2,000 <= 2,000"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate (Bonus)] = 10 USD"

    Then Click on button "Refresh"
    Then Update details
      | Load        |
      | SysData=>2L |
    Then Wait for "5" Seconds
    Then Click on button "Refresh"
    Then Wait for "3" Seconds

    #Expected b
    Then Verify logs in PayIQ Admin displaying as "Metric 1,950 did not meet {Calculation Tier ID} bonus threshold [Running Aggregated Margin (Quoted)]"

    #Step 14 & expected c
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Verify table has "1" records with "Participant Name" as "Chatter Expert (User)" and "Pay Amount" as "USD 10.00" and "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Click on "Pay Detail-" with "Participant Name" as "Chatter Expert (User)" and "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Wait for "3" Seconds
    Then Get Details
    |Pay Header|
    |          |

    #Step 15 & expected d
    Then Navigate to stored URL for "Load_2L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Verify "Pay Details" count displaying as "0"

    #Step 16
    Then Navigate to stored URL for "Calculation_Tier"
    Then Wait for "2" Seconds
    Then Scroll into Section "Tier Calculation Settings"
    Then Click on Edit icon on Label "Revoke Payout If Dipped Under Threshold"
    Then Update details
      | Revoke Payout If Dipped Under Threshold |
      | True                                    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 17
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 18
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Click on button "Refresh"
    Then Update details
      | Load        |
      | SysData=>1L |
    Then Click on button "Refresh"
    Then Wait for "5" Seconds

    #Expected e
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "[Meets Target {Calculation Tier ID} calculation] = [From] <= [Running Aggregated Margin (Quoted)] = 2,000 <= 2,000"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate (Bonus)] = 10 USD"

    Then Click on button "Refresh"
    Then Update details
      | Load        |
      | SysData=>2L |
    Then Wait for "5" Seconds
    Then Click on button "Refresh"
    Then Wait for "3" Seconds

    #Expected f
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "Metric 1,950 did not meet {Calculation Tier ID} bonus threshold [Running Aggregated Margin (Quoted)]"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate (Revoke Bonus)] = -10 USD"

    #Step 19 & expected g
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Verify table has "1" records with "Participant Name" as "Chatter Expert (User)" and "Pay Amount" as "USD 10.00" and "Pay Header" as "SysData=>Pay Header"

    #Step 20 & expected h
    Then Navigate to stored URL for "Load_2L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Verify table has "1" records with "Participant Name" as "Chatter Expert (User)" and "Pay Amount" as "USD -10.00" and "Pay Header" as "SysData=>Pay Header"

    #Step 21 & 22
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Indy Irrigation | Truckload | NA             | N             | N                 |
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
    Then Capture the current URL for "Load_3L"

    #Step 23
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "100"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 24
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 25 & 26
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 4L       | Indy Irrigation | Truckload | NA             | N             | N                 |
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
    Then Capture the current URL for "Load_4L"

    #Step 27
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "100"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "50"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 28
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 29
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 30
    Then Go to "Logs" Tab
    Then Click on button "Refresh"
    Then Update details
      | Load        |
      | SysData=>1L |
    Then Click on button "Refresh"
    Then Wait for "5" Seconds

    #Expected i
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "[Meets Target {Calculation Tier ID} calculation] = [From] <= [Running Aggregated Margin (Quoted)] = 2,000 <= 2,000"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate (Bonus)] = 10 USD"


    Then Go to "Logs" Tab
    Then Update details
      | Load        |
      | SysData=>2L |
    Then Click on button "Refresh"
    Then Wait for "5" Seconds
    #Expected j
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "Metric 1,950 did not meet {Calculation Tier ID} bonus threshold [Running Aggregated Margin (Quoted)]"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate (Revoke Bonus)] = -10 USD"

    Then Go to "Logs" Tab
    Then Update details
      | Load        |
      | SysData=>3L |
    Then Click on button "Refresh"
    Then Wait for "5" Seconds

    #Expected k
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "[Meets Target {Calculation Tier ID} calculation] = [From] <= [Running Aggregated Margin (Quoted)] = 2,000 <= 2,150"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate (Bonus)] = 10 USD"

    Then Go to "Logs" Tab
    Then Update details
      | Load        |
      | SysData=>4L |
    Then Click on button "Refresh"
    Then Wait for "5" Seconds

    #Expected l
    Then Verify Normalized Text displaying as "PayIQ Program not open"
    Then Verify logs in PayIQ Admin displaying as "[Meets Target {Calculation Tier ID} calculation] = [From] <= [Running Aggregated Margin (Quoted)] = 2,000 <= 2,300"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = 0; Did not create zero amount pay detail"

    #Step 31 & expected m
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Verify table has "1" records with "Participant Name" as "Chatter Expert (User)" and "Pay Amount" as "USD 10.00" and "Pay Header" as "SysData=>Pay Header"

    #Step 32 & expected n
    Then Navigate to stored URL for "Load_2L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Verify table has "1" records with "Participant Name" as "Chatter Expert (User)" and "Pay Amount" as "USD -10.00" and "Pay Header" as "SysData=>Pay Header"

    #Step 33 & expected o
    Then Navigate to stored URL for "Load_3L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Verify table has "1" records with "Participant Name" as "Chatter Expert (User)" and "Pay Amount" as "USD 10.00" and "Pay Header" as "SysData=>Pay Header"

    #Step 34 & expected p
    Then Navigate to stored URL for "Load_4L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Verify "Pay Details" count displaying as "0"