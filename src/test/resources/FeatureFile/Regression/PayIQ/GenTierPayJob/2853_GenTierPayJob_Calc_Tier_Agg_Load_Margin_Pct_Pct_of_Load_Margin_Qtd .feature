Feature:2853 - GenTierPayJob- Calc Tier: Agg. Load Margin Pct/Pct of Load Margin Qtd

  @API @Regression @PayIQ  @WEB @SingleCurrency @2853 @PayIQ_Logs
  Scenario: 2853 - GenTierPayJob- Calc Tier: Agg. Load Margin Pct/Pct of Load Margin Qtd

    When Login into Salesforce

   #Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Aggregated Margin Percentage (Quoted)" from List

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

   # Step 4
    Then Scroll Until Related List for "Participants"
    Then Click on link "Participants"
    Then Wait for "2" Seconds
    Then Click on button with Title Text "New"
    Then Update details
    |Type|User|
    |User|Test User1|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "Participants_1"
    Then Get "Participant-" Name with "Name" as "Test User1" and store in "Participant_Name_2"



    #Step 5
   Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Margin (Quoted)" and "From (>)" as "0.00" and "To (<=)" as "500.00"
    Then Wait for "2" Seconds
    Then Get Details
      |Calculation Tier ID|
      |                   |
    Then Capture the current URL for "Calculation_Tier"


  #Step 6
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Filters"
    Then Choose "New" button on "Filters" section
    Then Wait for "4" Seconds
    Then Update details
    |* Table |* Field             |* Operator|Other Instructions|
    |Load    |Other Instructions  |Equal to  |TierPay           |
    Then Click on "Save" with Text
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Filters"
    Then Get "Filter-" Name with "Value" as "TierPay" and store in "Filter_1"

    #Step 7 & 8
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

     #Step 9
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-39" from List
    Then Wait for "3" Seconds
    Then Set Key "Load_ID" page Record Id with "rtms__Load__c"

     #Step 10 & 11
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Wait for "1" Seconds

    #Step 12 and 13 and expected result a
    Then Get "Pay Header-" Name with "Calculation Tier" as "SysData=>Calculation Tier ID" and "Participant Name" as "Test User1 (User)" and store in "Pay Header"
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID" and "Participant Name" as "Test User1 (User)"
    Then Wait for "1" Seconds
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD 35.00  | Pay Header- |
    Then Capture the current URL for "Pay_Details"


    #Step 14 and expected result b
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Aggregated Margin Percentage (Quoted)] <= [To] = 0 < 96 <= 500"

     #Step 15 & expected c
    Then Verify Logs displaying as "[{Calculation Tier ID} Pay Amount] = [Load Margin (Quoted)] x [Percent] = 350 x 10% = 35 USD"

    #Step 16 and 17
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Calculation Tier-" on Page
    Then Wait for "1" Seconds

     #Step 16 and 17
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Verify "Pay Details" Table Details
      | Participant Name          | Paid From               | Pay Header          |
      | Test User1 (User)         | PIQ-30                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-31                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-32                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-33                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-34                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-35                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-36                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-37                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-38                 |  SysData=>Pay Header |
      | Test User1 (User)         | PIQ-39                 |  SysData=>Pay Header |

#Step 19 and 20 and expected result e
    Then Scroll down with "5" Times
    Then Click on "Pay Header-" with "Participant Name" as "Test User1 (User)" and "Paid From" as "PIQ-39"
    Then Wait for "2" Seconds
    Then Set Key "PayHeader_ID" page Record Id with "rtms9__Pay_Header__c"

    Then Wait for "2" Seconds
    Then Get "rtms__Expected_Ship_Date2__c" from "rtms__Load__c" using "Id" with value "SysData=>Load_ID" and Store onto "ShipMonth"
    Then Get "rtms9__Date_Range__c" from "rtms9__Pay_Header__c" using "Id" with value "SysData=>PayHeader_ID" and Store onto "DateRange"
   #Step 20 & Expected e
    Then Verify Expected Ship Date belongs to Date Range

