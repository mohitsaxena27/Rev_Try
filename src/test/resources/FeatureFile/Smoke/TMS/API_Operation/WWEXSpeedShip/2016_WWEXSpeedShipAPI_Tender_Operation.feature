Feature: 2016 - WWEX SpeedShip API- Tender Operation (quoteOrderFlow)

  Background: Pre- Test
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | false           | false                |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    Then Delete Field with Title "WWEXSpeedShipTenderOperation"

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2016 @WWEXSpeedShipAPI @Debugging
  Scenario: 2016 - WWEX SpeedShip API- Tender Operation (quoteOrderFlow)

  #  When Login into Salesforce
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

    #Step2, Step3 & Step4
    Given Upload File "WWEXSpeedShipTenderOperation- 2016.txt" with Title "WWEXSpeedShipTenderOperation"

    #Step5
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
    Then Save Load With All details

    #Step6
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "Bill of Lading Number"
    Then Enter Label "Bill of Lading Number" Text as "2016"
    Then Click on button "Save"

    #Step7
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom

    #Step8
    Then Verify Quotes returned

    #Step9
    Then Capture the attribute "value" for "Carrier Quote Reference"
    Then Click on Native "Tender" icon
    #Expected a
#    Then Verify Message displaying as "Success - Carrier Quote"
    And "Capture" and Close all the Toast messages from Bottom
    #Step10 Expected b
    And Update and verify payload for "quoteOrderFlow" with "TC2016_RequestBody_Expected.json"
      | Shipment Offer Id | Shipment Product Transaction Id |
      | Transactional     | Transactional                   |

    #Step 11 expected 11c
    Then Verify Details "Load Status" displaying as "Assigned"

    #Stp12
    And Verify below Attributes on "Details" Tab
      | Bill of Lading Number |
      | WBOL201620162016      |

    #Stp13
    Then Go to "Shipment" Tab
    Then Scroll into Section "Chicago Bulls"
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    #expected e
    And Verify details for
      |References |
      | Carrier Pickup Number: 2016AbC WWEX BOL: WBOL201620162016|
    Then Delete Field with Title "WWEXSpeedShipTenderOperation"
