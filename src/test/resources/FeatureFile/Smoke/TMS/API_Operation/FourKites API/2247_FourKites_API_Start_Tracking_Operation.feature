Feature: 2247 - FourKites API- Start Tracking Operation

  @API @Regression @TMS @Smoke @API @WEB @API_Operation @MultiCurrency @2247 @FourKitesAPI @Debugging
  Scenario: 2247 - FourKites API- Start Tracking Operation
    When Login into Salesforce

   # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | Truckload | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | 0             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3P   | Account_Address | Los Angeles Lighting | 1             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 4D   | Same_as_Customer | NA    | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 3 | Stop 4   | Grapes      | 1200   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Set Key "LoadId_SFID" page Record Id with "rtms__Load__c"
    Then Capture the current URL for "Load_1"

    # Step 3 & 4
    Then Go to "Freight Quote Assistant" Tab
    Then Close Toast message
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    # Step 5
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Get Details
      | Bill of Lading Number |
      |                       |

    # Step 6
    Then Go to "Shipment" Tab
    Then Load Summary - Click on "1P" "Chicago Pizza" Text
    Then Wait for "2" Seconds
    Then Set Key "Stop1_SFID" page Record Id with "rtms__Stop__c"
    Then Navigate to stored URL for "Load_1"

    Then Load Summary - Click on "2D" "Los Angeles Lighting" Text
    Then Wait for "2" Seconds
    Then Set Key "Stop2_SFID" page Record Id with "rtms__Stop__c"
    Then Navigate to stored URL for "Load_1"

    Then Load Summary - Click on "3P" "Los Angeles Lighting" Text
    Then Wait for "2" Seconds
    Then Set Key "Stop3_SFID" page Record Id with "rtms__Stop__c"
    Then Navigate to stored URL for "Load_1"

    Then Load Summary - Click on "4D" "Chicago Pizza" Text
    Then Wait for "2" Seconds
    Then Set Key "Stop4_SFID" page Record Id with "rtms__Stop__c"
    Then Navigate to stored URL for "Load_1"

    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -

    # Step 7
    Then Update details -
      | Tracking Provider | Driver Phone |
      | FourKites         | 2179721878   |

    # Step 8 & 9
    Then Click on Native "On" button -
#    Then Verify Message displaying as "Success - Carrier Banner"
    Then Verify Success Message displaying as "Success - Carrier Banner"
    And "Capture" and Close all the Toast messages from Bottom

    # Expected a
    Then Update and verify payload for "tracking" with "2247_Expected_RequestBody.json"
      | BOL                            | Load1       | {CurrentDate} | {CurrentDate+1} | {CurrentDate+3} | Stop1_SFID          | Stop2_SFID          | Stop3_SFID          | Stop4_SFID          |
      | SysData=>Bill of Lading Number | SysData=>1L | 0             | 1               | 3               | SysData=>Stop1_SFID | SysData=>Stop2_SFID | SysData=>Stop3_SFID | SysData=>Stop4_SFID |

    # Step 10
    Then Close Modal

    # Step 11
    Then Verify Title "Load Tracking" is displaying with background color "SteelBlue"

    # Step 12
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Get Details
      | Tracking Number |
      |                 |

    # Expected c
    Then Verify "SysData=>Tracking Number" value is not empty

    # Step 13 & Expected d
    Then Verify Details
      | Tracking Provider |
      | FourKites         |