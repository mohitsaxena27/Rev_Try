Feature:2954 - Pay Detail- Team Pay Multi Currency Conversion/Separation

  @API @Regression @PayIQ  @WEB @SingleCurrency @2954 @PayIQ_Logs
  Scenario: 2954 - Pay Detail- Team Pay Multi Currency Conversion/Separation

    When Login into Salesforce
    Then Delete All Records with "rtms9__Participant_Name__c" as "Test User1 (User)" for "rtms9__Pay_Header__c"

    #Step 1
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Set URL with "-setup.com/lightning/setup/ManageUsers/home" and store into "Manage User URL"
    Then Navigate to stored URL for "Manage User URL"
    Then Switch to Frame by Title "All"
    Then Click on "U" with Text -
    Then Switch to Parent Frame
    Then Wait for "5" Seconds
    Then Switch to Frame by Title "All"
    Then Wait for "5" Seconds
    Then Click on "User1, Test" with Text -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "User: Test User1 ~ Salesforce - Enterprise Edition"
    Then Capture the current URL for "User_setup"
    Then Click on "edit" button -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "User Edit"
    Then Scroll down with "15" Times
    Then Select "CAD - Canadian Dollar" with Id "defaultcurrencyisocode" -
    Then Click on button with Title "Save" -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 2 & 3
    Then Search and Select "Contact" "Joe Texas Rangers" from the Global search

    #Step 4
    Then Go to "Details" Tab
    Then Scroll into Section "System Information"
    Then Click on Edit icon on Label "Contact Currency"
    Then Update details
      |Contact Currency|
      |EUR - Euro|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Contact Currency|
      |EUR - Euro|

    #Step 5 & 6
    Then Open "Fleet Management" from App Launcher
    Then Search and Select "Contact" "Joe Detroit Tigers" from the Global search
    Then Go to "Details" Tab
    Then Scroll into Section "System Information"
    Then Click on Edit icon on Label "Contact Currency"
    Then Update details
      |Contact Currency|
      |MXN - Mexican Peso|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Contact Currency|
      |MXN - Mexican Peso|

    #Step 7 & 8
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Margin (Quoted)" from List


    #Step 9
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

    #Step 10
    Then Scroll Until Related List for "Participants"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Participants" section
    Then Update details
      | Type | Team Name  |
      | Team | Team Money |
    Then Click on "SaveEdit" button

    #Step 11
    Then Click on "Participant-" with "Type" as "Team" and "Name" as "Team Money"
    Then Wait for "2" Seconds
    Then Set Key "Participant_SFID" page Record Id with "rtms9__Participant__c"

    #Step 12
    Then Click on "New" button on "Team Members" section
    Then Update details
      | Type | Contact  |
      | Contact | Joe Kansas City Royals |
    Then Click on "SaveAndNew" button

    #Step 13
    Then Click on "SaveAndNew" button
    Then Wait for "2" Seconds
    Then Update details
      | Type | Contact  |
      | Contact | Joe Texas Rangers |

    #Step 14
    Then Click on "SaveAndNew" button
    Then Wait for "2" Seconds
    Then Update details
      | Type | Contact  |
      | Contact | Joe Detroit Tigers |

    #Step 15 & 16
    Then Click on "SaveAndNew" button
    Then Wait for "2" Seconds
    Then Update details
      | Type | User  |
      | User | Test User1 |
    Then Click on "SaveEdit" button

    #Step 17 & 18
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Click on "Calculation Tier-" with "Calculation Description" as "Percent of Load Margin (Quoted)" and "From (>)" as "50.00" and "To (<=)" as "100.00"
    Then Wait for "2" Seconds
    Then Get Details
      |Calculation Tier ID|
      |                   |

    #Step 19
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
    Then  Capture the current URL for "Load_1L"

    #Step 20
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)   | Custom PayIQ Eligible Date |
      | Joe Kansas City Royals | 0                          |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact)   |
      | Joe Kansas City Royals |

    #Step 21
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "50"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "50"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 22
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 23
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 24
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds

    #Step 25
    Then Scroll Until Related List for "Participant Matches"
    Then Click on "Participant Match-" with "Participant Name" as "Team Money (Team)"
    Then Get Details
    |Participant Match ID|
    |                    |
    Then Navigate to stored URL for "Load_1L"

    #Step 26 & expected a
    Then Click on link "Pay Details"
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Details"
    Then Zoom Current Screen by "70"
    Then Verify table has "6" records with "Participant Name" as "Joe Kansas City Royals (Contact)"
    Then Verify table has "6" records with "Participant Name" as "Joe Texas Rangers (Contact)"
    Then Verify table has "6" records with "Participant Name" as "Joe Detroit Tigers (Contact)"
    Then Verify table has "6" records with "Participant Name" as "Test User1 (User)"
    Then Zoom Current Screen by "100"

    #Step 27
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Kansas City Royals (Contact)" and "Calculation Tier" as "SysData=>Calculation Tier ID"

    #Step 28 & expected b
    Then Verify Details
      | Qty     | Pay Amount | Converted Margin (Quoted) |Participant Match|
      | $100.00 | USD 2.50   | USD 100.00                |SysData=>Participant Match ID|

    #Step 29 & expected c
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Team Pay] = [{Calculation Tier ID} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 10 x (1 / 4) = 2.5 USD"
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Set Key "Pay_Header1_SFID" page Record Id with "rtms9__Pay_Header__c"

    #Step 30 & 31
    Then Navigate to stored URL for "Pay_Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Texas Rangers (Contact)" and "Calculation Tier" as "SysData=>Calculation Tier ID"

    #Step 32 & expected d
    Then Verify Details
      | Qty    | Pay Amount          | Converted Margin (Quoted) |Participant Match|
      | €92.00 | EUR 2.30 (USD 2.50) | EUR 92.00 (USD 100.00)    |SysData=>Participant Match ID|

    #Step 33 & expected e
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Team Pay] = [{Calculation Tier ID} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 9.2 x (1 / 4) = 2.3 EUR"
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Set Key "Pay_Header2_SFID" page Record Id with "rtms9__Pay_Header__c"

    #Step 34 & 35
    Then Navigate to stored URL for "Pay_Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Detroit Tigers (Contact)" and "Calculation Tier" as "SysData=>Calculation Tier ID"
    #Step 32 & expected f
    Then Verify Details
      | Qty       | Pay Amount           | Converted Margin (Quoted) |Participant Match|
      | $1,878.00 | MXN 46.95 (USD 2.50) | MXN 1,878.00 (USD 100.00) |SysData=>Participant Match ID|

    #Step 37 & expected g
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Team Pay] = [{Calculation Tier ID} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 187.8 x (1 / 4) = 46.95 MXN"
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Set Key "Pay_Header3_SFID" page Record Id with "rtms9__Pay_Header__c"

    #Step 38 & 39
    Then Navigate to stored URL for "Pay_Details"
    Then Zoom Current Screen by "70"
    Then Click on "Pay Detail-" with "Participant Name" as "Test User1 (User)" and "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Zoom Current Screen by "100"

    #Step 32 & expected h
    Then Verify Details
      | Qty     | Pay Amount          | Converted Margin (Quoted) |Participant Match|
      | $134.00 | CAD 3.35 (USD 2.50) | CAD 134.00 (USD 100.00)   |SysData=>Participant Match ID|

    #Step 37 & expected i
    Then Go to "Logs" Tab
    Then Verify Logs displaying as "[Team Pay] = [{Calculation Tier ID} Pay Amount] x [Team Member Pay Ratio] = [Pay Amount] x (1 / [Team Size]) = 13.4 x (1 / 4) = 3.35 CAD"
    Then Go to "Details" Tab
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Set Key "Pay_Header4_SFID" page Record Id with "rtms9__Pay_Header__c"