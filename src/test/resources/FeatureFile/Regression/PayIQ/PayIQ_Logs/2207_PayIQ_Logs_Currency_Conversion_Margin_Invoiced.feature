Feature: 2207 - PayIQ Logs- Currency Conversion- Margin Invoiced

  @API @Regression @PayIQ @WEB @MultiCurrency @2207 @PayIQ_Logs
  Scenario: 2207 - PayIQ Logs- Currency Conversion- Margin Invoiced

    When Login into Salesforce

    #Step 1
    Then Search and Select "Contact" "Joe Revenova PayIQ" from the Global search
    Then Wait for "2" Seconds

    #Step 2
    Then Scroll into Section "System Information"
    Then Click on Edit icon on Label "Contact Currency"
    Then Update details
      | Contact Currency      |
      | CAD - Canadian Dollar |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Contact Currency      |
      | CAD - Canadian Dollar |
    Then Capture the current URL for "Contact_Page"


    #Step 3
    Then Open "PayIQ Programs" from App Launcher

    #Step 4
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

    #Step 5
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

    #Step 6
    Then Open "PayIQ Admin" from App Launcher

    #Step 7
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 8  & 9
    Then Open "Loads" from App Launcher
    Then Search and Select "PIQ-19" from List

    #Step 10
    Then Scroll Until Related List for "Participant Matches"
    Then Click on link "Participant Matches"

    Then Click on "Participant Match-" with "Participant Name" as "Joe Revenova PayIQ (Contact)"

    #Step 11 - Expected Result A
    Then Scroll into Section "Currency Converted Financials"
    Then Verify Details
      | Converted Margin (Invoiced) |
      | CAD 67.00 (USD 50.00)        |

    #Step 12
    Then Open "PayIQ Admin" from App Launcher
    Then Go to "Logs" Tab

    #Step 13
    Then Update details
      | Load   | Type                |
      | PIQ-19 | Currency Conversion |
    Then Wait for "2" Seconds

    #Step 14 - Expected Result B
    Then Verify Normalized Text displaying as "[Margin (Invoiced)] converted from USD to CAD (using dated exchange rate from 2024-01-01) => 50 USD = 67 CAD"

    #Step 15 - Verify Datetime Entered
    Then Verify Timestamp date is "Current Date"