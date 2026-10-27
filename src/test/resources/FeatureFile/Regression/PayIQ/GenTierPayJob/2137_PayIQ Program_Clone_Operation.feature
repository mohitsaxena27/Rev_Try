Feature:2137 -  PayIQ Program- Clone Operation

  @API @Regression @PayIQ  @WEB @SingleCurrency @2137 @GenTierPayJob
  Scenario: 2137 -  PayIQ Program- Clone Operation

    When Login into Salesforce
    Then Delete All Records with name "Clone - PayIQProgram Aggregated Load Count (Quoted Calculations)" for "rtms9__PayIQ_Program__c"
    # Step 1
    Then Open "PayIQ Programs" from App Launcher
    # Step 1.a
    Then Search And Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from Search List
    Then Wait for "3" Seconds

    # Step 1.b
    Then Click on Edit icon on Label "Description"
    Then Update details
      | Description | Freight Plan Load Criteria | Payroll Description  | Payroll Type | Payroll Code |
      | 123%^&(     | All loads must be quoted   | payroll testing 5678 | XYZ          | Code         |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    # Step 1.c
    Then Scroll Until Related List for "Filters"
    Then Choose "New" button on "Filters" section
    Then Wait for "4" Seconds
    # Step 1.d
    Then Update details
      | * Table | * Field               | * Operator | Bill of Lading Number |
      | Load    | Bill of Lading Number | Equal to   | 1234567               |
    Then Click on "Save" with Text
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Filters"
    Then Click on "Filter-" with "Field" as "Bill of Lading Number" and "Value" as "1234567"
    Then Set Key "Filter_1" page Record Id with "rtms9__Load_Filter__c"
    Then Navigate Browser Back

    # Step 1.e
    Then Choose "New" button on "Filters" section
    Then Wait for "4" Seconds
    # Step 1.f
    Then Update details
      | * Table | * Field  | * Operator   | Customer       |
      | Load    | Customer | Equal to any | Revenova PayIQ |
    Then Click on "Add" with Text
    Then Wait for "5" Seconds
    Then Update details
      | Customer_2  |
      | Revenova HQ |
    Then Click on "Save" with Text
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Filters"
    Then Click on "Filter-" with "Field" as "Customer" and "Value" as "Revenova PayIQ;Revenova HQ"
    Then Set Key "Filter_2" page Record Id with "rtms9__Load_Filter__c"
    Then Navigate Browser Back

    # Step 1.g
    Then Choose "New" button on "Filters" section
    Then Wait for "4" Seconds
    # Step 1.h
    Then Update details
      | * Table | * Field | * Operator   |
      | Load    | HazMat  | Not equal to |
    Then Wait for "2" Seconds
    Then Click on "HazMat" with Text
    Then Click on "Save" with Text
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Filters"
    Then Click on "Filter-" with "Field" as "HazMat" and "Value" as "true"
    Then Set Key "Filter_3" page Record Id with "rtms9__Load_Filter__c"
    Then Navigate Browser Back

    # Step 2
    Then Click on Native "Clone" button
    Then Wait for "10" Seconds
    Then Set Key "Cloned_PayIQProgram" page Record Id with "rtms9__PayIQ_Program__c"
    Then Capture the current URL for "Cloned_PayIQ_Program"

    # Step 3 & Expected Result a
    Then Verify Details
      | Name                                                             | Description | Status  | Pay Schedule      | Number of Tiers | Freight Plan Load Criteria | Carrier Load Allocation | Payroll Description  | Payroll Type | Payroll Code |
      | Clone - PayIQProgram Aggregated Load Count (Quoted Calculations) | 123%^&(     | Pending | Test Pay Schedule | 18              | All loads must be quoted   | Cost Contribution       | payroll testing 5678 | XYZ          | Code         |

    # Sep 4 Expected Result b
    Then Scroll Until Related List for "Participants"
    Then Wait for "2" Seconds
    Then Verify "Participants" count displaying as "4"

    #  Step 5 Expected Result c
    Then Click on "Participant-" with "Type" as "Team" and "Name" as "Team Awesome"
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Team Members"
    Then Wait for "2" Seconds
    Then Verify "Team Members" count displaying as "2"

    # Step 6
    Then Navigate to stored URL for "Cloned_PayIQ_Program"
    Then Wait for "3" Seconds

    # Step 7 Expected Result d
    Then Scroll Until Related List for "Calculation Tiers"
    Then Wait for "2" Seconds
    Then Verify "Calculation Tiers" count displaying as "18"

    # Step 8 Expected Result e
    Then Scroll Until Related List for "Roles"
    Then Wait for "2" Seconds
    Then Verify "Roles" count displaying as "3"

    # Step 9 Expected Result f
    Then Scroll Until Related List for "Filters"
    Then Wait for "2" Seconds
    Then Verify "Filters" count displaying as "3"

    # Step 10,11 Expected Result g & h
    Then Go to "PayIQ Generated" Tab
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Participant Matches"
    Then Wait for "2" Seconds
    Then Verify "Participant Matches" count displaying as "0"

    Then Scroll Until Related List for "Pay Details"
    Then Wait for "2" Seconds
    Then Verify "Pay Details" count displaying as "0"

    # Step 12 Expected Result i
    Then Go to "Files" Tab
    Then Wait for "2" Seconds
    Then Verify "Files" count displaying as "0"