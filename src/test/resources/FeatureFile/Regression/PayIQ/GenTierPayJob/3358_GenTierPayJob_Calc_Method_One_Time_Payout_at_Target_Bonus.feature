Feature:3358 - GenTierPayJob- Calc Method: One-Time Payout at Target (Bonus)

  @API @Regression @PayIQ @WEB @SingleCurrency @3358 @PayIQ_Logs
  Scenario: 3358 - GenTierPayJob- Calc Method: One-Time Payout at Target (Bonus)

    When Login into Salesforce
     #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program One-Time Payout - Count" from List
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
    Then Wait for "4" Seconds
    Then Get Details
      |Calculation Tier ID|
      |                   |
  #Step 4
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Indy Irrigation | Truckload | N              | N             | N                 |

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
    Then  Capture the current URL for "Load_1L"
    #Step 6,7,8
    Then Execute Load "1L" Clone with count "2" and Customer Quote as "False" and Carrier Quote as "False"
    Then Wait for "2" Seconds

    #Step9
    Then Navigate to stored URL for "Load_1L"
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds


#Step10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step11 $ Expected result a
    Then Go to "Logs" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Load   |
      | SysData=>1L |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify logs in PayIQ Admin displaying as "Metric 1 did not meet {Calculation Tier ID} bonus threshold [Load Count]"

    #Step12 Expected Result b
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds

    Then Scroll Until Related List for "Pay Details"
    Then Verify "Pay Details" count displaying as "0"

    #Step13
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>1L1C" from List
    Then Wait for "2" Seconds
    Then Capture the current URL for "Cloned_Load_1"
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step14
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>1L2C" from List
    Then Wait for "2" Seconds
    Then Capture the current URL for "Cloned_Load_2"
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Chatter Expert    |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step15
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step16
    Then Go to "Logs" Tab
    Then Wait for "5" Seconds
    Then Update details
      | Load   |
      | SysData=>1L |
    Then Wait for "4" Seconds
    Then Verify logs in PayIQ Admin displaying as "Metric 1 did not meet {Calculation Tier ID} bonus threshold [Load Count]"
    Then Update details
      | Load   |
      | SysData=>1L1C |
    Then Wait for "4" Seconds
    Then Verify logs in PayIQ Admin displaying as "[Meets Target {Calculation Tier ID} calculation] = [From] <= [Load Count] = 2 <= 2"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate (Bonus)] = 10 USD"
    Then Update details
      | Load   |
      | SysData=>1L2C |
    Then Wait for "4" Seconds
    Then Verify logs in PayIQ Admin displaying as "[Meets Target {Calculation Tier ID} calculation] = [From] <= [Load Count] = 2 <= 3"
    Then Verify logs in PayIQ Admin displaying as "[{Calculation Tier ID} Pay Amount] = 0; Did not create zero amount pay detail"

    #Steps 17
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Verify "Pay Details" count displaying as "0"

    #Step18
    Then Navigate to stored URL for "Cloned_Load_1"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    #Expected g
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Verify Table With Header
      | Participant Name                | Pay Amount | Calculation Tier             |Pay Header                 | PayIQ Program          |
      | Chatter Expert (User)           | USD 10.00  | SysData=>Calculation Tier ID |Pay Header-| PayIQ Program One-Time Payout - Count |

#Step 19
    Then Navigate to stored URL for "Cloned_Load_2"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Verify "Pay Details" count displaying as "0"

