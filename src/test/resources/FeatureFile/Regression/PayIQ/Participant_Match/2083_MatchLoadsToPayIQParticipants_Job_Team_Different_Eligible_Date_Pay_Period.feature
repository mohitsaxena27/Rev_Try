Feature: PayIQ Participant Match - Team One - Custom Eligible Date

  @API @Regression @PayIQ @WEB @SingleCurrency @2083 @PayHeader
  Scenario: 2083 - PayIQ Participant Match - Team One - Custom Eligible Date

    When Login into Salesforce

    #Pre-Condition Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Team One" from List
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

    #Step 1
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | N            | N                |

    Then Wait for "1" Seconds

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Oakland Athletics | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Parts       | 2000   | NA           | NA       | NA             |

    Then Save Load With All details
    Then Wait for "5" Seconds

    #Step 2
    Then Capture the current URL for "Load_1L"

    #Step 3
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Custom PayIQ Eligible Date | Carrier Sales Rep | Sales Lead (Contact)  |
      | Second User        | 30                         | Test User1        | Joe Oakland Athletics |

    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 4
    Then Open "PayIQ Admin" from App Launcher
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 5
    Then Navigate to stored URL for "Load_1L"

    #Step 6
    #Step 6a - Expected Result A
    Then Scroll Until Related List for "Participant Matches"
    Then Scroll down with "2" Times
    Then Click on "Participant Match-" with "Participant Name" as "Team One (Team)"
    Then Verify Details
      |Participant Name|Eligible Date|PayIQ Program|
      |Team One (Team) |0            |PayIQ Program Team One|
    Then Get Details
      |Participant Match ID|
      |                    |
    Then Navigate to stored URL for "Load_1L"
    #Step 6b - Expected Result B
    Then Scroll Until Related List for "Pay Details"
    Then Verify "Pay Details" count displaying as "4"
    Then Verify "Pay Details" Table With Details
      | Participant Name                | Pay Amount | Participant Match             | PayIQ Program          |
      | Test User1 (User)               | USD 2.50   | SysData=>Participant Match ID | PayIQ Program Team One |
      | Second User (User)              | USD 2.50   | SysData=>Participant Match ID | PayIQ Program Team One |
      | Joe Carolina Panthers (Contact) | USD 2.50   | SysData=>Participant Match ID | PayIQ Program Team One |
      | Joe Oakland Athletics (Contact) | USD 2.50   | SysData=>Participant Match ID | PayIQ Program Team One |

    #Step 7
    Then Set First date of month into "FirstDateOfMonth"
    Then Set Last date of month into "LastDateOfMonth"

    Then Scroll Until Related List for "Participant Matches"
    Then Click on "Participant Match-" with "Participant Name" as "Team One (Team)"
    Then Wait for "2" Seconds
    Then Click on "Pay Period-" with Contains Text
    Then Wait for "2" Seconds
    #Step 7 - Expected Result C
    Then Verify Details
      | Period Beginning          | Period Ending            |
      | SysData=>FirstDateOfMonth | SysData=>LastDateOfMonth |