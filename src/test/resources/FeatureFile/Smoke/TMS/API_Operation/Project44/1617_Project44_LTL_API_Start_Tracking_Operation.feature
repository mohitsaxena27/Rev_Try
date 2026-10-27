Feature: 1617 - Project44 LTL API- Start LTL Tracking Operation

  @API @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @1617 @Project44
  Scenario: 1617 - Project44 LTL API- Tender Operation

    When Login into Salesforce

    # Step1
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

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Project44 Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 6500   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |

    Then Save Load With All details

    # Step 3
    Then Set Key "LoadId_SFID" page Record Id with "rtms__Load__c"
    Then Capture the current URL for "Load_1"

    # Step 4 & 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Click on View Quotes
    Then Wait for "2" Seconds
    Then Select exact "Roadrunner Transportation Services - P44" from View Quotes
    Then Wait for "2" Seconds

    # Step 6
    Then "Assign" Carrier

    # Step 7
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Get Details
      | Bill of Lading Number |
      |                       |

    Then Go to "Summary" Tab
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -
    Then Update details -
      | Tracking Provider |
      | Project44         |
    Then Click on Native "On" button -
    Then Verify Error Message contains as "Capacity provider account set not found with code"
    And "Capture" and Close all the Toast messages from Bottom
    Then Close Toast message

    Then Set "Org_id" with "OrgData=>Org_Id"
    Then Set "EXTERNAL_Value" with "SysData=>Org_id" and "SysData=>LoadId_SFID"
    Then Set key "Roadrunner_AccountID" for Object "Account" and Name "Roadrunner Transportation Services"
    Then Set "Final_External_Value" with "SysData=>EXTERNAL_Value" and "SysData=>Roadrunner_AccountID"
    And Update and verify payload for "trackedshipments" with "TC1617_Expected_RequestBody.json"
      | BOL                            | External_Value                | {CurrentDate} | {CurrentDate+4} | sfid                 |
      | SysData=>Bill of Lading Number | SysData=>Final_External_Value | 0             | 4               | SysData=>LoadId_SFID |