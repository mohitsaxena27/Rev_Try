Feature: 545 - P44 TL Tracking API- Outbound Start Tracking Operation

  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @Project44 @545 @Debugging
  Scenario: 545 - P44 TL Tracking API- Outbound Start Tracking Operation

    When Login into Salesforce

    # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | True            | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Email Carrier Two" from List
    Then Scroll into Section "Fleet Summary"
    Then Click on Edit icon on "SCAC"
    Then Enter Label "SCAC" Text as "SCAC"
    Then Scroll into Section "US Registration"
    Then Enter Label "US DOT Number" Text as "123456"
    Then Click on "Save" button
    Then Verify "US DOT Number" having value of "123456"

    # Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 48     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | 0830             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meat | 3             | NA                       | 1445             | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 5000   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | 50         |

    # Step 4
    Then Save Load With All details
    Then Set Key "LoadId_SFID" page Record Id with "rtms__Load__c"
    Then Capture the current URL for "Load_1"

    # Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Enter Carrier Service as "Email Carrier Two"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier."
    Then Refresh current Page

    # Step 6
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Get Details
      | Bill of Lading Number |
      |                       |

    # Step 7
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -

    # Step 8
    Then Update details -
      | Tracking Provider  | Driver Phone |
      | Project44 Tracking | 2179721878   |

    # Step 9
    Then Click on Native "On" button -
    And "Capture" and Close all the Toast messages from Bottom

    # Expected a
    Then Update and verify payload for "shipments" with "545_Expected_RequestBody.json"
      | BOL                            | {CurrentDate+1} | {CurrentDate+3} | SFID                 |
      | SysData=>Bill of Lading Number | 1               | 3               | SysData=>LoadId_SFID |

    # Expected b
    Then Verify Message "Success - Carrier Banner" displaying stored during enabled logging