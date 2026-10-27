Feature: 2451 - Banyan API- Tender Operation (BookLoad)

  Background: Pre- Test
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | false           | false                |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    Then Delete Field with Title "BanyanQuoteOperation"

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2451 @BanyanAPI @Debugging
  Scenario: 2451 - Banyan API- Tender Operation (BookLoad)

  # Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | True            | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

  # Step 2 & 3
    Then Upload File "BanyanTenderOperation-2451.txt" with Title "BanyanTenderOperation"

  # Step 4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Banyan Customer | LTL  | Dry Van 53     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | 0800-0915        | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New Orleans Saints | NA            | NA                       | 0800-0915        | NA                   |
    And Update details
      | Unspecified Limited Access Delivery |
      | true                                |
    Then Wait for "1" Seconds

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1200   | NA           | 2        | Pallets        | 45     | 42    | 48     | in             | 92.5       |

    Then Save Load With All details

  # Step 5
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom

  # Step 6
    Then Capture the attribute "value" for "Carrier Quote Reference"

  # Step 7
    Then Click on Native "Tender" icon
    And "Capture" and Close all the Toast messages from Bottom

  # Step 8 and expected 8a
    And Update and verify payload for "BookLoad" with "TC2451_RequestBody_Expected2.json"
      | Load id       | Quote Id      |
      | Transactional | Transactional |

  # expected 9b
    And Update and verify payload for "UpdateLoad" with "TC2451_RequestBody_Expected1.json"
      | Load id       |
      | Transactional |

  # Step 10
    Then Go to "Summary" Tab
    Then Go to "Shipment" Tab

  # Expected c
    Then Verify "1P" Stop Details
      | Expected Date |
      | 1/29/2020     |
    Then Verify "2D" Stop Details
      | Expected Date |
      | 2/3/2020      |

  # Step 11
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"

  # Expected d
    Then Verify Details
      | Bill of Lading Number | PRO Number |
      | REVBOL2451            | PRO2451    |
    Then Scroll into Section "Tracking IDs"
    Then Verify Details
      | API Load Id |
      | 28079563    |
