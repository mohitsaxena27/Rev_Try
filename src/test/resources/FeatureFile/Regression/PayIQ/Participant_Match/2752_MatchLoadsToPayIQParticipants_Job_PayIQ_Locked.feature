Feature: 2752 - MatchLoadsToPayIQParticipants Job - PayIQ Locked

  @API @Regression @PayIQ @WEB @SingleCurrency @2752 @PayIQ_Locked
  Scenario: 2752 - MatchLoadsToPayIQParticipants Job - PayIQ Locked

    When Login into Salesforce

    # Pre-Condition
    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "PayIQ Program 1936" from Search List
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

    # Step 1 & 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Parts       | 999    | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_1L"

    # Step 3
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Sales Lead (Contact)            | Customer Sales Rep | PayIQ Locked |
      | Joe Joe's Kansas City Bar-B-Que | Second User        | True         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep | PayIQ Locked |
      | Second User        | True         |

    # Step 4
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 5 & 6 and Expected Result a
    Then Navigate to stored URL for "Load_1L"
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Participant Matches"
    Then Verify "Participant Matches" count displaying as "0"
