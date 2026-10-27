Feature: 2311 - SMC3 EVA API- Status Operation PUSH Updates

  Background: Pre- Test
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "SMC3 EVA" in the "Search Credentials..." search box
    Then Select the "SMC3 EVA" record from the lookup field results
    Then Verify details for all Disabled or Readonly fields
      | Callback Endpoint Created |
      | False                      |
    And Click on Native "Save" button
    Then Wait for "3" Seconds

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2311 @SMC3EVAAPI
  Scenario: 2311 - SMC3 EVA API- Status Operation PUSH Updates

    # Step 1 & 2
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
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds

    # Expected a
    Then Click on View Quotes
    Then Verify Text displaying as "SMC3 EVA Carrier - SMC3 EVA"

    # Step 4
    Then Wait for "2" Seconds
    Then Select exact "SMC3 EVA Carrier - SMC3 EVA" from View Quotes
    Then Wait for "1" Seconds
    Then Click on Native "Tender" icon

    #Expected b
    Then Verify Message displaying as "Load tendered successfully."

    # Step 5
    Then Go to "Details" Tab

    # Expected c
    Then Verify Details "Load Status" displaying as "Assigned or In Transit"

    # Step 6
    Then Scroll into Section "Tracking IDs"

    # Expected d
    Then Verify Details
      | Tracking Provider |
      | SMC3 EVA          |

    # Step 7
    Then Wait for "900" Seconds
    Then Refresh current Page
    Then Go to "Shipment" Tab
    Then Click on "Tracking Log" with Text

    # Expected e
    Then Verify Tracking log count is greater than "1"