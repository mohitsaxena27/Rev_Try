
Feature: 2933 - Pay Detail - Team Pay Amount Distribution

  @API @Regression @PayIQ @WEB @SingleCurrency @2933 @TeamPay @PayIQ_Logs
  Scenario: 2933 - Pay Detail - Team Pay Amount Distribution

    When Login into Salesforce

    # Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Wait for "3" Seconds
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

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
    Then Scroll Until Related List for "Participants"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Participants" section
    Then Update details
      | Type | Team Name      |
      | Team | Team Christmas |
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds

    # Step 5
    Then Click on "Participant-" with "Type" as "Team" and "Name" as "Team Christmas"
    Then Wait for "3" Seconds
    Then Set Key "Participant_SFID" page Record Id with "rtms9__Participant__c"

    # Step 6
    Then Click on "New" button on "Team Members" section
    Then Update details
      | Type | User       |
      | User | Test User1 |
    # Step 7
    Then Click on "SaveAndNew" button
    Then Wait for "4" Seconds
    Then Update details
      | Type    | Contact            |
      | Contact | Joe Dallas Cowboys |

    # Step 8 & 9
    Then Click on "SaveAndNew" button
    Then Wait for "4" Seconds
    Then Update details
      | Type    | Contact                |
      | Contact | Joe Kansas City Chiefs |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    # Step 10 & 11
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Amount per Load" and "From (>)" as "10.00" and "To (<=)" as "20.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Set "Calculation_Tier_Amount_Per_Load" with "SysData=>Calculation Tier ID"
    Then Set Key "Calculation_Tier_Amount_Per_Load_SFID" page Record Id with "rtms9__Calculation_Tier__c"


    # Step 12
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Margin with Min (Quoted)" and "From (>)" as "10.00" and "To (<=)" as "20.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |
    Then Set "Calculation_Tier_Percent_Of_Margin" with "SysData=>Calculation Tier ID"
    Then Set Key "Calculation_Tier_Percent_Of_Margin_SFID" page Record Id with "rtms9__Calculation_Tier__c"

    # Step 13
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | Truckload | Dry Van 53'    | N             | N                 |
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

    # Step 14
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date |
      | Joe Dallas Cowboys   | 0                          |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact) |
      | Joe Dallas Cowboys   |

    # Step 15 & 16
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 17 & 18
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Participant Matches"
    Then Click on "Participant Match-" with "Participant Name" as "Team Christmas (Team)"
    Then Wait for "3" Seconds
    Then Get Details
      | Participant Match ID |
      |                      |
    Then Set "Participant_Match_ID" with "SysData=>Participant Match ID"

    # Step 19 & Expected Result 1 (a)
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Details"

    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with value "Test User1 (User)" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PD1"
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with value "Joe Dallas Cowboys (Contact)" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PD2"
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with value "Joe Kansas City Chiefs (Contact)" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PD3"
    Then Verify Assertion for "PD1_count" contains "2"
    Then Verify Assertion for "PD2_count" contains "2"
    Then Verify Assertion for "PD3_count" contains "2"

    # Step 20 & 21 & Expected Result 2 (b)
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Test User1 (User)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Percent_Of_Margin_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_11"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_11" from the Global search
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Amount | Participant Match             |
      | USD 8.67   | SysData=>Participant_Match_ID |

    # Step 22 & Expected Result 3 (c)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Percent_Of_Margin} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 26 x (1 / 3) = 8.667 USD"

    # Step 23 & 24
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Test User1 (User)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Amount_Per_Load_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_12"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_12" from the Global search
    Then Wait for "2" Seconds
    # Step 25 & Expected Result 4 (d)
    Then Verify Details
      | Pay Amount | Participant Match             |
      | USD 0.67   | SysData=>Participant_Match_ID |

    # Step 26 & Expected Result 5 (e)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Amount_Per_Load} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 2 x (1 / 3) = 0.667 USD"

    # Step 27 & 28
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Joe Dallas Cowboys (Contact)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Percent_Of_Margin_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_13"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_13" from the Global search
    Then Wait for "2" Seconds

    # Step 29 & Expected Result 6 (f)
    Then Verify Details
      | Pay Amount | Participant Match             |
      | USD 8.67   | SysData=>Participant_Match_ID |

    # Step 30 & Expected Result 7 (g)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Percent_Of_Margin} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 26 x (1 / 3) = 8.667 USD"

    # Step 31 & 32
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Joe Dallas Cowboys (Contact)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Amount_Per_Load_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_14"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_14" from the Global search
    Then Wait for "2" Seconds
    # Step 33 & Expected Result 8 (h)
    Then Verify Details
      | Pay Amount | Participant Match             |
      | USD 0.67   | SysData=>Participant_Match_ID |

    # Step 34 & Expected Result 9 (i)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Amount_Per_Load} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 2 x (1 / 3) = 0.667 USD"

    # Step 35 & 36
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Joe Kansas City Chiefs (Contact)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Percent_Of_Margin_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_15"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_15" from the Global search
    Then Wait for "2" Seconds
    # Step 37 & Expected Result 10 (j)
    Then Verify Details
      | Pay Amount | Participant Match             |
      | USD 8.67   | SysData=>Participant_Match_ID |

    # Step 38 & Expected Result 11 (k)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Percent_Of_Margin} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 26 x (1 / 3) = 8.667 USD"

    # Step 39 & 40
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Joe Kansas City Chiefs (Contact)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Amount_Per_Load_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_16"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_16" from the Global search
    Then Wait for "2" Seconds

    # Step 41 & Expected Result 12 (l)
    Then Verify Details
      | Pay Amount | Participant Match             |
      | USD 0.67   | SysData=>Participant_Match_ID |

    # Step 42 & Expected Result 13 (m)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Amount_Per_Load} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 2 x (1 / 3) = 0.667 USD"

    # Step 43 & 44
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Participants"
    Then Scroll down with "4" Times
    Then Click on "Participant-" with "Type" as "Team" and "Name" as "Team Christmas"
    Then Wait for "3" Seconds

    # Step 45 & 46
    Then Click on "New" button on "Team Members" section
    Then Update details
      | Type    | Contact            |
      | Contact | Joe Baltimore PayIQ |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    # Step 47 & 48
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "42.25"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "40.00"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    # Step 49 & 50
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 51 & 52
    Then Navigate to stored URL for "Load_1L"
    Then Click on link "Pay Details"
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Details"

    # Step 53 & Expected Result 14 (n)
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with value "Test User1 (User)" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PD1"
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with value "Joe Dallas Cowboys (Contact)" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PD2"
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with value "Joe Kansas City Chiefs (Contact)" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PD3"
    Then Get count from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c" with value "Joe Baltimore PayIQ (Contact)" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PD4"

    Then Verify Assertion for "PD1_count" contains "6"
    Then Verify Assertion for "PD2_count" contains "6"
    Then Verify Assertion for "PD3_count" contains "6"
    Then Verify Assertion for "PD4_count" contains "6"

    # Step 54 & 55 & Expected Result 15 (o)
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Test User1 (User)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Percent_Of_Margin_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_1"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_1" from the Global search
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Amount |
      | USD 6.50   |

    # Step 56 & Expected Result 16 (p)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Percent_Of_Margin} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 26 x (1 / 4) = 6.5 USD"

    # Step 57 & 58
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Joe Dallas Cowboys (Contact)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Percent_Of_Margin_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_2"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_2" from the Global search
    Then Wait for "2" Seconds

    # Step 59 & Expected Result 17 (q)
    Then Verify Details
      | Pay Amount |
      | USD 6.50   |

    # Step 60 & Expected Result 18 (r)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Percent_Of_Margin} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 26 x (1 / 4) = 6.5 USD"

    # Step 61 & 62
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Joe Kansas City Chiefs (Contact)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Percent_Of_Margin_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_3"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_3" from the Global search
    Then Wait for "2" Seconds

    # Step 63 & Expected Result 19 (s)
    Then Verify Details
      | Pay Amount |
      | USD 6.50   |

    # Step 64 & Expected Result 20 (t)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Percent_Of_Margin} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 26 x (1 / 4) = 6.5 USD"

    # Step 65 & 66
    Then Get "Name" from "rtms9__Pay_Detail__c" using "rtms9__Participant_Name__c = 'Joe Baltimore PayIQ (Contact)' AND rtms9__Calculation_Tier__c" with value "SysData=>Calculation_Tier_Percent_Of_Margin_SFID" & "rtms9__Load__c" with value "SysData=>1LRI" and Store into "PayDetailName_4"
    Then Search and Select "rtms9__Pay_Detail__c" "SysData=>PayDetailName_4" from the Global search
    Then Wait for "2" Seconds


    # Step 67 & Expected Result 21 (u)
    Then Verify Details
      | Pay Amount |
      | USD 6.50   |

    # Step 68 & Expected Result 22 (v)
    Then Go to "Logs" Tab
    Then Verify Logs Contains as "[Team Pay] = [{Calculation_Tier_Percent_Of_Margin} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 26 x (1 / 4) = 6.5 USD"
