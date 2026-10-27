Feature:3348 - GenTierPayJob- Calc Method: % Load Contribution Within Bracket

  @API @Regression @PayIQ @WEB @SingleCurrency @3348 @GenTierPayJob
  Scenario: 3348 - GenTierPayJob- Calc Method: % Load Contribution Within Bracket

    When Login into Salesforce

    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Progressive Pay Percent" from List

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
    Then Get "Calculation Tier-" Name with "Percent" as "1.00%" and store in "Calc_TierID_1"
    Then Get "Calculation Tier-" Name with "Percent" as "5.00%" and store in "Calc_TierID_5"
    Then Get "Calculation Tier-" Name with "Percent" as "10.00%" and store in "Calc_TierID_10"

    #Step 4
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Indy Irrigation | Truckload | Dry Van 53'    | N             | N                 |

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

    #Step 6 ,7, 8 & 9
    Then Execute Load "1L" Clone with count "2" and Customer Quote as "False" and Carrier Quote as "False"
    Then Wait for "2" Seconds

    #Step 10
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds

    #Step 11
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Revenova PayIQ Carrier"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "2000"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "500"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    #Customer Quotes
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "2500"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "1000"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 12
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Customer Sales Rep | Carrier Sales Rep | Sales Lead (Contact) |
      |                    | Chatter Expert    |                      |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

    #Step 13
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>1L1C" from List
    Then Wait for "2" Seconds
    Then Capture the current URL for "Cloned_Load_1"

    #Step 14
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds
    Then Enter Carrier Service as "Revenova PayIQ Carrier"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "500"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    #Customer Quotes
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "5000"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "1000"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

     #Step 15
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Customer Sales Rep | Carrier Sales Rep | Sales Lead (Contact) |
      |                    | Chatter Expert    |                      |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

    #Step 16
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>1L2C" from List
    Then Wait for "2" Seconds
    Then Capture the current URL for "Cloned_Load_2"

    #Step 17
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds
    Then Enter Carrier Service as "Revenova PayIQ Carrier"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "3000"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "750"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    #Customer Quotes
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1750"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "250"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 18
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Customer Sales Rep | Carrier Sales Rep | Sales Lead (Contact) | PayIQ Locked |
      |                    | Chatter Expert    |                      | True         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

    #Step 19
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 20
    Then Go to "Logs" Tab
    Then Wait for "5" Seconds
    Then Update details
      | Load   |
      | SysData=>1L |
    Then Wait for "4" Seconds

# Expected Result A
    Then Verify Logs Contains as "Load did not contribute to {Calc_TierID_5}: (2,000 < [Running Aggregated Margin (Quoted)] <= 5,000). Prior running aggregate: 0 Load contribution to tier: 1,000"
    Then Verify Logs Contains as "Load did not contribute to {Calc_TierID_10}: (5,000 < [Running Aggregated Margin (Quoted)] <= (NULL)). Prior running aggregate: 0 Load contribution to tier: 1,000"
    Then Verify Logs Contains as "[Within {Calc_TierID_1} calculation] = 0 < [Running Aggregated Margin (Quoted)] <= 2,000 Prior Running aggregate: 0 Load contribution to tier: 1,000"
    Then Verify Logs Contains as "[{Calc_TierID_1} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = 1,000 x 1% = 10 USD"

    #Second Load
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Load   |
      | SysData=>1L1C |
    Then Wait for "4" Seconds
    # Expected Result B
    Then Verify Logs Contains as "PayIQ Program not open:"
    Then Verify Logs Contains as "[Within {Calc_TierID_1} calculation] = 0 < [Running Aggregated Margin (Quoted)] <= 2,000 Prior Running aggregate: 1,000 Load contribution to tier: 1,000"
    Then Verify Logs Contains as "[Within {Calc_TierID_5} calculation] = 2,000 < [Running Aggregated Margin (Quoted)] <= 5,000 Prior Running aggregate: 2,000 Load contribution to tier: 3,000"
    Then Verify Logs Contains as "[Within {Calc_TierID_10} calculation] = 5,000 < [Running Aggregated Margin (Quoted)] <= (NULL) Prior Running aggregate: 5,000 Load contribution to tier: 500"
    Then Verify Logs Contains as "[{Calc_TierID_1} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = 1,000 x 1% = 10 USD"
    Then Verify Logs Contains as "[{Calc_TierID_5} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = 3,000 x 5% = 150 USD"
    Then Verify Logs Contains as "[{Calc_TierID_10} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = 500 x 10% = 50 USD"

    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Load          |
      | SysData=>1L2C |
    Then Wait for "4" Seconds
    # Expected Result C
    Then Verify Text not displaying as "PayIQ Program not open:"

    #Step 21
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_1"
    Then Wait for "2" Seconds
    #Expected d
    Then Verify Details
         |Pay Amount|Pay Header|
         |USD 10.00 |Pay Header-|
    Then Get Details
         |Pay Header|
         |          |
    Then Scroll into Section "Participant"
    Then Verify Details
         |Participant Name     |PayIQ Program                        |Calculation Tier|
         |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_1|

    Then Navigate to stored URL for "Cloned_Load_1"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    #Expected e
#    Then Click on link "Pay Details"
#    Then Wait for "4" Seconds

    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_1"
    Then Wait for "2" Seconds

    Then Verify Details
      |Pay Amount|Pay Header          |
      |USD 10.00 |SysData=>Pay Header |

    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name     |PayIQ Program                        |Calculation Tier      |
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_1|


    Then Navigate Browser Back
    Then Wait for "3" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_5"
    Then Wait for "2" Seconds
    Then Verify Details
      |Pay Amount|Pay Header          |
      |USD 150.00 |SysData=>Pay Header |
    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name     |PayIQ Program                        |Calculation Tier      |
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_5|

    Then Navigate Browser Back
    Then Wait for "3" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_10"
    Then Wait for "2" Seconds
    Then Verify Details
      |Pay Amount|Pay Header          |
      |USD 50.00 |SysData=>Pay Header |

    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name     |PayIQ Program                        |Calculation Tier      |
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_10|


#    Then Verify "Pay Details" Table Details
#      | Participant Name                | Pay Amount | Calculation Tier       |Pay Header                  | PayIQ Program                         |
#      | Chatter Expert (User)           | USD 10.00  | SysData=>Calc_TierID_1 |SysData=>Pay Header         | PayIQ Program Progressive Pay Percent |
#      | Chatter Expert (User)           | USD 150.00 | SysData=>Calc_TierID_5 |SysData=>Pay Header         | PayIQ Program Progressive Pay Percent |
#      | Chatter Expert (User)           | USD 50.00  | SysData=>Calc_TierID_10|SysData=>Pay Header         | PayIQ Program Progressive Pay Percent |

     #Step 23
    Then Navigate to stored URL for "Cloned_Load_2"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    #Expected f
    Then Verify "Pay Details" count displaying as "0"

    Then Scroll Up with "6" Times
    Then Click on Edit icon on Label "PayIQ Locked"
    Then Update details
         |PayIQ Locked |
         |False        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

      #Step 24
    Then Open "PayIQ Admin" from App Launcher

    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 25
    Then Refresh current Page
    Then Go to "Logs" Tab
    Then Wait for "5" Seconds
    Then Update details
      | Load   |
      | SysData=>1L |
    Then Wait for "4" Seconds


     # Expected Result g
    Then Verify Logs Contains as "Load did not contribute to {Calc_TierID_5}: (2,000 < [Running Aggregated Margin (Quoted)] <= 5,000). Prior running aggregate: 0 Load contribution to tier: 1,000"
    Then Verify Logs Contains as "Load did not contribute to {Calc_TierID_10}: (5,000 < [Running Aggregated Margin (Quoted)] <= (NULL)). Prior running aggregate: 0 Load contribution to tier: 1,000"
    Then Verify Logs Contains as "[Within {Calc_TierID_1} calculation] = 0 < [Running Aggregated Margin (Quoted)] <= 2,000 Prior Running aggregate: 0 Load contribution to tier: 1,000"
    Then Verify Logs Contains as "[{Calc_TierID_1} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = 1,000 x 1% = 10 USD"

    #Second Load
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Load   |
      | SysData=>1L1C |
    Then Wait for "4" Seconds
    # Expected Result h
    Then Verify Logs Contains as "PayIQ Program not open:"
    Then Verify Logs Contains as "[Within {Calc_TierID_1} calculation] = 0 < [Running Aggregated Margin (Quoted)] <= 2,000 Prior Running aggregate: 1,000 Load contribution to tier: 1,000"
    Then Verify Logs Contains as "[Within {Calc_TierID_5} calculation] = 2,000 < [Running Aggregated Margin (Quoted)] <= 5,000 Prior Running aggregate: 2,000 Load contribution to tier: 3,000"
    Then Verify Logs Contains as "[Within {Calc_TierID_10} calculation] = 5,000 < [Running Aggregated Margin (Quoted)] <= (NULL) Prior Running aggregate: 5,000 Load contribution to tier: 500"
    Then Verify Logs Contains as "[{Calc_TierID_1} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = 1,000 x 1% = 10 USD"
    Then Verify Logs Contains as "[{Calc_TierID_5} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = 3,000 x 5% = 150 USD"
    Then Verify Logs Contains as "[{Calc_TierID_10} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = 500 x 10% = 50 USD"

    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Load   |
      | SysData=>1L2C |
    Then Wait for "4" Seconds
    # Expected Result i
    Then Verify Logs Contains as "Load did not contribute to {Calc_TierID_1}: (0 < [Running Aggregated Margin (Quoted)] <= 2,000). Prior running aggregate: 3,750 Load contribution to tier: -1,750"
    Then Verify Logs Contains as "[Within {Calc_TierID_5} calculation] = 2,000 < [Running Aggregated Margin (Quoted)] <= 5,000 Prior Running aggregate: 3,750 Load contribution to tier: -1,250"
    Then Verify Logs Contains as "[Within {Calc_TierID_10} calculation] = 5,000 < [Running Aggregated Margin (Quoted)] <= (NULL) Prior Running aggregate: 2,500 Load contribution to tier: -500"
    Then Verify Logs Contains as "[{Calc_TierID_5} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = -1,250 x 5% = -62.5 USD"
    Then Verify Logs Contains as "[{Calc_TierID_10} Pay Amount] = [Load Contribution to Tier Aggregate] x [Percent] = -500 x 10% = -50 USD"


    #Step 26
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Click on "Pay Detail-" with "Participant Name" as "Chatter Expert (User)" and "Calculation Tier" as "SysData=>Calc_TierID_1"
    Then Wait for "2" Seconds
    #Expected j
    Then Verify Details
      |Pay Amount|Pay Header|
      |USD 10.00 |Pay Header-|
    Then Get Details
      |Pay Header|
      |          |
    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name|PayIQ Program|Calculation Tier|
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_1|


     #Step 26
    Then Navigate to stored URL for "Cloned_Load_1"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    #Expected k
#    Then Click on link "Pay Details"
#    Then Wait for "2" Seconds

    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_1"
    Then Wait for "2" Seconds

    Then Verify Details
      |Pay Amount|Pay Header          |
      |USD 10.00 |SysData=>Pay Header |

    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name     |PayIQ Program                        |Calculation Tier      |
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_1|


    Then Navigate Browser Back
    Then Wait for "3" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_5"
    Then Wait for "2" Seconds
    Then Verify Details
      |Pay Amount|Pay Header          |
      |USD 150.00 |SysData=>Pay Header |
    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name     |PayIQ Program                        |Calculation Tier      |
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_5|

    Then Navigate Browser Back
    Then Wait for "3" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_10"
    Then Wait for "2" Seconds
    Then Verify Details
      |Pay Amount|Pay Header          |
      |USD 50.00 |SysData=>Pay Header |

    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name     |PayIQ Program                        |Calculation Tier      |
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_10|



#    Then Verify "Pay Details" Table Details
#      | Participant Name                | Pay Amount | Calculation Tier             |Pay Header                 | PayIQ Program          |
#      | Chatter Expert (User)               | USD 10.00   | SysData=>Calc_TierID_1 |SysData=>Pay Header         | PayIQ Program Progressive Pay Percent |
#      | Chatter Expert (User)               | USD 150.00   | SysData=>Calc_TierID_5 |SysData=>Pay Header         | PayIQ Program Progressive Pay Percent |
#      | Chatter Expert (User)               | USD 50.00   | SysData=>Calc_TierID_10 |SysData=>Pay Header         | PayIQ Program Progressive Pay Percent |

     #Step 27
    Then Navigate to stored URL for "Cloned_Load_2"
    Then Wait for "2" Seconds
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    #Expected l
#    Then Click on link "Pay Details"
#    Then Wait for "2" Seconds

    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_5"
    Then Wait for "2" Seconds

    Then Verify Details
      |Pay Amount|Pay Header          |
      |USD -62.50|SysData=>Pay Header |

    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name     |PayIQ Program                        |Calculation Tier      |
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_5|


    Then Navigate Browser Back
    Then Wait for "3" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calc_TierID_10"
    Then Wait for "2" Seconds
    Then Verify Details
      |Pay Amount|Pay Header          |
      |USD -50.00 |SysData=>Pay Header |
    Then Scroll into Section "Participant"
    Then Verify Details
      |Participant Name     |PayIQ Program                        |Calculation Tier      |
      |Chatter Expert (User)|PayIQ Program Progressive Pay Percent|SysData=>Calc_TierID_10|

#    Then Verify "Pay Details" Table Details
#      | Participant Name                | Pay Amount | Calculation Tier             |Pay Header                 | PayIQ Program          |
#      | Chatter Expert (User)               | USD -62.50   | SysData=>Calc_TierID_5 |SysData=>Pay Header         | PayIQ Program Progressive Pay Percent |
#      | Chatter Expert (User)               | USD -50.00   | SysData=>Calc_TierID_10 |SysData=>Pay Header         | PayIQ Program Progressive Pay Percent |
