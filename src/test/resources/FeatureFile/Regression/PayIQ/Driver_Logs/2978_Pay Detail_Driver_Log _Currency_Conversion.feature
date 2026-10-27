Feature:2978 - Pay Detail - Driver Log Currency Conversion

  @API @Regression @PayIQ  @WEB @SingleCurrency @2978 @PayIQ_Logs
  Scenario: 2978 - Pay Detail - Driver Log Currency Conversion

    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"
    Then Delete All Records with name "Pay Header-" for "rtms9__Pay_Header__c"
#    Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Driver Pay - Driver Logs" from List

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
    Then Click on "Calculation Tier-" with "Calculation Description" as "Rate per Driver Log (Driving Duration) Hour" and "From (>)" as "0.00" and "To (<=)" as "50.00"
    Then Wait for "2" Seconds
    Then Get Details
      |Calculation Tier ID|
      |                   |

    #Step 5
    Then Open "Drivers" from App Launcher
    Then Search and Select "Dave Fleet Carrier One 10" from List
    Then Wait for "3" Seconds

    #Step 6
    Then Click on Edit icon on Label "Currency"
    Then Update details
    |Currency|
    |CAD - Canadian Dollar|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Currency|
      |CAD - Canadian Dollar|
    Then Capture the current URL for "Driver"

    #Step 7
    Then Open "Driver Logs" from App Launcher
    Then Wait for "3" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Driver                    | Remarks  |Driving Duration | On Duty Duration | Certification Status |
      | Dave Fleet Carrier One 10 | Currency |30               | 40               | Certified            |
    Then Update Legend details
      | Start Time, Date | End Time, Date | Certified as of, Date |
      | 0                | 3              | -2                    |
    Then Wait for "5" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Set Key "DriverLog_SFID" page Record Id with "rtms__DriverLog__c"
    Then Verify Details
    |Remarks  |
    |Currency |
    Then Capture the current URL for "DriverLogPage"

    #Step 8
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds

    #Step 9
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 10 , 11 & 12
    Then Navigate to stored URL for "DriverLogPage"
    Then Wait for "2" Seconds

    #Step 13
    Then Go to "PayIQ" Tab
    Then Click on "Pay Detail-" with "Participant Name" as "Dave Fleet Carrier One 10 (Driver)" and "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Wait for "4" Seconds
    Then Capture the current URL for "Pay_Details"

    #Step 14 & expected a
    Then Verify Details
    | Qty    | Pay Amount                  |
    | 30 hrs | CAD 2,010.00 (USD 1,500.00) |

    #Step 15
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then  Get Details
      | Pay Header ID |
      |               |
    Then Capture the current URL for "Pay_Header"
    Then Set Key "Pay_Header_SFID" page Record Id with "rtms9__Pay_Header__c"

    #Step 16
    Then Navigate to stored URL for "Pay_Details"
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab

    #Step 17 & expected b
    Then Store date "-2" days and "0" "months" from current date in format "yyyy-MM-dd" into "Past_date"
    Then Verify Logs displaying as "Currency Conversions:[Calculation Amount] converted from USD to CAD (using dated exchange rate from {Past_date}) => 50 USD = 67 CAD"
  











