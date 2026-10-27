Feature: 2221 - SMC3 EVA API- GetProNumberOperation

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2221 @SMC3EVAAPI @Debugging
  Scenario: 2221 - SMC3 EVA API- GetProNumberOperation

    When Login into Salesforce
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 2
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | 0800-0915        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 4500   | NA           | 10       | Pallets        | 24     | 48    | 48     | NA             | 50         |

    # Step 3
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom

    # Step 5 & 6
    Then Click on View Quotes
    Then Wait for "2" Seconds
    Then Select exact "SMC3 EVA Carrier - SMC3 EVA" from View Quotes
    Then Wait for "1" Seconds
    Then Update details
      | Request PRO Number |
      | true               |
    Then "Tender" Carrier

    # Step 7,8 & 9
    And "Capture" and Close all the Toast messages from Bottom
    Then Get Attribute "revenovaId" store into "Revenova_Id" from "SMCA_Carrier" "Request"
    Then Get Attribute "transactionId" store into "Transaction_Id" from "SMCA_Carrier" "Response"
    Then Get Attribute "scac" store into "scac_Number" from "SMCA_Carrier" "Response"
    Then Get Attribute "proNumber" store into "pro_Number" from "SMCA_Carrier" "Response"

    # Expected b)
    Then Verify Message "Load tendered successfully." displaying stored during enabled logging

    # Expected c)
    And Update and verify payload for "SMCA_Carrier" with "2221_Expected_Request.json"
      | RevenovaId           |
      | SysData=>Revenova_Id |

    # Expected d)
    And Update and verify Response payload for "SMCA_Carrier" with "2221_Expected_Response.json"
      | TransactionId           | scacNumber           | Pro_Num             |
      | SysData=>Transaction_Id | SysData=>scac_Number | SysData=>pro_Number |

    # Step 10
    Then Go to "Details" Tab

    # Expected e)
    Then Verify Details "Load Status" displaying as "Assigned or In Transit"

    # Step 11
    Then Scroll into Section "Shipment IDs"
    Then Verify Details "PRO Number" displaying as "1234578 or SysData=>pro_Number"