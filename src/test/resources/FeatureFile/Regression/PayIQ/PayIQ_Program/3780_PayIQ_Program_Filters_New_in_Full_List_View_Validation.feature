Feature:3780 - PayIQ Program - Filters - New in Full List View Validation

  @API @Regression @PayIQ  @WEB @SingleCurrency @3780 @PayIQ_Logs
  Scenario: 3780 - PayIQ Program - Filters - New in Full List View Validation

    When Login into Salesforce

    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program 1936" from List
    Then Wait for "2" Seconds
    Then Capture the current URL for "Pay_Program"

    #Step 2
    Then Scroll Until Related List for "Filters"
    Then Click on link "Filters"
    Then Wait for "3" Seconds

    #Step 3 & expected a
    Then Click on button "New"
    Then Update details
      | * Table | * Field          | * Operator |
      | Load    | Accounting Notes | Equal to   |
    Then Click on "save" button
    Then Wait for "4" Seconds
    Then Navigate to stored URL for "Pay_Program"
    Then Scroll Until Related List for "Filters"
    Then Click on link "Filters"
    Then Wait for "3" Seconds
    #Expected Result a
    Then Verify table has "1" records with "Table" as "Load"
    Then Click on "Filter-" with Contains Text
    Then Wait for "4" Seconds
    Then Set Key "Filter_SFID" page Record Id with "rtms9__Load_Filter__c"










