Feature:2805 - GenTierPayJob- Calc Tier: Load Count/Amount Per Load

  @API @Regression @PayIQ  @WEB @SingleCurrency @2805 @GenTierPayJob
  Scenario: 2805 - GenTierPayJob- Calc Tier: Load Count/Amount Per Load

    When Login into Salesforce

    # Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List
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

    # Step 3
    Then Scroll Until Related List for "Participants"
    Then Click on link "Participants"
    Then Wait for "2" Seconds
    Then Click on button with Title Text "New"
    Then Update details
      | Type | User       |
      | User | Test User1 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Set Key "Participants_SFID_1" page Record Id with "rtms9__Participant__c"
    Then Navigate to stored URL for "PayIQ_Program_1"

    # Step 4 & 5
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Amount per Load" and "From (>)" as "0.00" and "To (<=)" as "10.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Calculation Tier ID |
      |                     |

    # Step 6 & 7
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 8 & 9
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-33" from List
    Then Wait for "3" Seconds
    Then Set Key "Load_ID" page Record Id with "rtms__Load__c"

    # Step 10
    Then Go to "PayIQ" Tab
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Wait for "2" Seconds
    Then Verify Details
      | Pay Amount | Pay Header   |
      | USD 1.00   | Pay Header-  |
    Then Capture the current URL for "Pay_Details"
    Then Get Details
      | Pay Header |
      |            |

    # Step 11 & Expected Result b
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Load Count] <= [To] = 0 < 10 <= 10"

    # Step 12 & Expected Result c
    Then Verify Logs displaying as "[{Calculation Tier ID} Pay Amount] = [Flat Rate] = 1 USD"

    # Step 13, 14 & Expected Result d
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Calculation Tier-" on Page
    Then Wait for "1" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Verify "Pay Details" Table Details
      | Participant Name | Paid From | Pay Header         |
      | Test User1 (User)| PIQ-30    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-31    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-32    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-33    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-34    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-35    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-36    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-37    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-38    | SysData=>Pay Header|
      | Test User1 (User)| PIQ-39    | SysData=>Pay Header|

    # Step 15 & Expected Result e:
    Then Scroll down with "5" Times
    Then Click on "Pay Header-" with "Participant Name" as "Test User1 (User)" and "Paid From" as "PIQ-33"
    Then Wait for "2" Seconds
    Then Set Key "PayHeader_ID" page Record Id with "rtms9__Pay_Header__c"
    Then Wait for "2" Seconds
    Then Get "rtms__Expected_Ship_Date2__c" from "rtms__Load__c" using "Id" with value "SysData=>Load_ID" and Store onto "ShipMonth"
    Then Get "rtms9__Date_Range__c" from "rtms9__Pay_Header__c" using "Id" with value "SysData=>PayHeader_ID" and Store onto "DateRange"
    Then Verify Expected Ship Date belongs to Date Range