Feature: 2449 - Banyan API- Quote Operation (UpdateLoad)

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

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2449 @BanyanAPI @Debugging
  Scenario: 2449 - Banyan API- Quote Operation (UpdateLoad)

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

    #Step2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Banyan Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Greenbay Packers | 1            | NA                       | NA               | NA                   |
    Then Wait for "1" Seconds

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1200   | NA           | 2        | Pallets        | 45     | 42    | 48     | in             | 50         |

    Then Save Load With All details

    #Step3
    Then Go to "Freight Quote Assistant" Tab
    Then Close Toast message
    And "Without Capture" and Close all the Toast messages from Bottom

    #Step4
    Then Go to "Summary" Tab
    Then Click on link "Load Accessorials"
    Then Click on button "New"

    #Step5
    Then Select "Unspecified Limited Access Pickup" from "Accessorials" list and click on "Add to Pickup Stop 1 >>"
    Then Update the "Unspecified Limited Access Pickup" accessorial data
      | Provider  |
      | Carrier |

    #Step6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    #Expected a
    Then Capture the attribute "value" for "Carrier Quote Reference"

    #Step7
    Then Click on Native "Refresh Quotes" icon

    #Step8
    And "Capture" and Close all the Toast messages from Bottom
    #Expected b
    And Update and verify payload for "UpdateLoad" with "TC2449_RequestBody_Expected.json"
      |Load id|
      |Transactional     |