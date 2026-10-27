Feature: 1952 - WWEX SpeedShip API- Quote Operation

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
    Then Delete Field with Title "WWEXSpeedShipQuoteOperation"

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @1952 @WWEXSpeedShipAPI @Debugging
  Scenario: 1952 - WWEX SpeedShip API- Quote Operation

#    When Login into Salesforce
    #Step1
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

    #Step2, Step3
    Given Upload File "WWEXSpeedShipQuoteOperation -1952.txt" with Title "WWEXSpeedShipQuoteOperation"

    #Step4
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
#    Then Click on button with Title "Add Line Item"
    #Step4
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 1 | Stop 2   | Banana      | 2000   | kg           | 2        | Bales          | 30     | 60    | 60     | cm             | 125        |

    #Step5
    Then Save Load With All details

    #Step6
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "Bill of Lading Number"
    Then Update details
      | Bill of Lading Number | PRO Number | Booking Number |
      | BOL123                | PRO5678    | BN223          |
    Then Click on button "Save"

    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on Label "PO Number"
    Then Update details
      | PO Number |
      | PO77489   |
    Then Click on button "Save"

    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Cargo Value"
    Then Update details
      | Cargo Value | Commodity Condition |
      | 50,000      | New                 |
    Then Click on button "Save"

    Then Scroll into Section "Import/Export Information"
    Then Click on Edit icon on Label "Clearance Number"
    Then Update details
      | Clearance Number | Entry Number | Shipping & Handling |
      | CN1147           | EN663        | 10                  |
    Then Click on button "Save"

    #Step7
    Then Go to "Shipment" Tab
    Then Wait for "1" Seconds
    Then Scroll into Section "Chicago Bulls"
    Then Wait for "1" Seconds
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    And Update details
      | Instructions | References    | Pickup/Delivery Number |
      | Testing5678  | RefTest%^&*() | PDN*1                  |
    Then Click on button "Save"

    #Step8
    Then Go to "Freight Quote Assistant" Tab
    And "Capture" and Close all the Toast messages from Bottom

    #Step8
    Then Verify Quotes returned

    #Step9
    Then Click on Carrier Quote from FQA Page
    Then Go to "Details" Tab
    Then Scroll into Section "Pricing Summary"
    Then Verify details for
      | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Carrier Total |
      | USD 117.98          | USD 19.47      | USD 68.73           | USD 206.18    |

    Then Scroll into Section "Service Information"
    Then Verify details for
      | Service Class | Estimated Transit Time (Days) | Estimated Delivery Date |
      | STANDARD      | 1                             | 12/5/2023            |

    Then Scroll into Section "Contract Information"
    Then Verify details for
      | Carrier Quote Reference                                                     | Liability Coverage |
      | 2f6d0f66-6802-4c40-8dec-554707fd118a : 86989f4a-f9eb-41da-9c64-44fe979cbe54 | USD 17,818.48      |

    Then Scroll into Section "Terminal Information"
    Then Verify details for
      | Origin Terminal Code | Origin Movement Type | Destination Terminal Code | Destination Movement Type |
      | RXSUT                | Direct               | RXEGR                     | Direct                    |

    Then Go to "Related" Tab
    Then Wait for "2" Seconds
    Then Click on link "Carrier Quote Accessorials"
    Then Click on "CUSTOMER HANDLING CHARGE" with Text
    Then Verify details for
      | Name                     | Code | Unit       | Quantity | Charge    | Accessorial |
      | CUSTOMER HANDLING CHARGE | CHC  | Fixed Cost | 1        | USD 68.73 | Other       |
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Southeastern Freight" from List
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Verify "SCAC" having value of "SEFL"
    Then Delete Field with Title "WWEXSpeedShipQuoteOperation"
