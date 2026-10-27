Feature: 2084 - Match Loads To PayIQ Participants Job - Team

  @API @Regression @PayIQ @WEB @SingleCurrency @2084 @PayIQProgram
  Scenario: 2084 - Match Loads To PayIQ Participants Job - Team

    When Login into Salesforce

    #Pre-Condition
    #Step 1
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

    #Step 1 - Create Quick Entry Shipment
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials | Fleet |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | NA            | NA                | NA    |

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
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Carrier Sales Rep | Sales Lead (Contact)  |
      | Second User        | Test User1        | Joe Oakland Athletics |

    #Step 3
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 4
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 5
    Then Navigate to stored URL for "Load_1L"

    #Step 6 and Expected Result 6(a)
    Then Scroll into Section "Participant Matches"
    #Capture Participant Match ID for Expected Result 6(b)
    Then Click on "Participant Match-" with "Participant Name" as "Team One (Team)"
    Then Verify Details
      | Participant Match ID | Participant Name | Eligible Date | PayIQ Program          |
      | Participant Match-   | Team One (Team)  | 0             | PayIQ Program Team One |
    Then Get Details
      | Participant Match ID |
      |                      |
    Then Capture the current URL for "Participant_Match_ID"

    #Step 7
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Verify "Pay Details" count displaying as "4"
    #Expected Result 7(b)
    Then Verify "Pay Details" Table With Details
      | Participant Name                | Pay Amount | Participant Match             | PayIQ Program          |
      | Test User1 (User)               | USD 2.50   | SysData=>Participant Match ID | PayIQ Program Team One |
      | Second User (User)              | USD 2.50   | SysData=>Participant Match ID | PayIQ Program Team One |
      | Joe Oakland Athletics (Contact) | USD 2.50   | SysData=>Participant Match ID | PayIQ Program Team One |
      | Joe Carolina Panthers (Contact) | USD 2.50   | SysData=>Participant Match ID | PayIQ Program Team One |