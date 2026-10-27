Feature: 2049 - WWEX SpeedShip API- LoadStatusUpdateJob

  Background: Pre- Test
    Then Delete Field with Title "WWEXSpeedShipStatusOperation"

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2049 @WWEXSpeedShipAPI
  Scenario: 2049 - WWEX SpeedShip API- LoadStatusUpdateJob

    When Login into Salesforce

    # Step1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer               | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | WWEXSpeedShip Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | 0800-0915        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 4500   | NA           | 1        | Pallets        | 24     | 48    | 48     | NA             | 50         |

    # Step 2
    Then Save Load With All details
    Then Capture the current URL for "Load-1"

    # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "30" Seconds
    Then Verify Quotes returned
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."

    # Step 4
    Then Wait for "30" Seconds
    Then Go to "Summary" Tab
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

    # Step 5
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "Bill of Lading Number"
    Then Update details
      | Bill of Lading Number | PRO Number |
      | NUD10802076           | 123456     |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "PRO Number" having value of "123456"
    Then Verify "Bill of Lading Number" having value of "NUD10802076"

    # Step 6
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    Then Set "CurrentTime" with "h:mm a" Format and "America/Chicago" Timezone
    Then Set Current Hour in "SysData=>CurrentTime" and store in "currentHour"
    And Update the Custom Select option "Load Status Start Time" as "SysData=>currentHour"
    And Update the Custom Select option "Load Status API Frequency (Hrs)" as "2"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 7
    Given Upload File "WWEXSpeedShip Inbound Status Tracking Update.txt" with Title "WWEXSpeedShipStatusOperation"

    # Step 8
    Then Go to Home Page
    Then Run "LoadStatusUpdateJob" Job
    Then Wait for "6" Seconds

    # Step 9
    Then Navigate to stored URL for "Load-1"
    Then Go to "Summary" Tab

    # Step 10 & Expected b
    Then Verify Banner Details
      | Load Status |
      | Delivered   |

    #Step 11
    Then Click on "1P" "Departed" chevron

    # Expected c
    Then Verify details for all Enabled fields
      | Stop Status |
      | Departed    |
    Then Wait for "3" Seconds

    Then Refresh current Page

    # Step 12
    Then Click on "2D" "Departed" chevron

    # Expected d
    Then Verify details for all Enabled fields
      | Departure Date | Departure Time | Stop Status | Last Reported City | Last Reported State/Province | Last Reported Country |
      | Feb 2, 2024    | 09:38          | Departed    | WASHINGTON         | DC                           | US                    |