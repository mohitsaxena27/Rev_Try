Feature: 2248 - FourKites API- Stop Tracking Operation

  @API @Regression @TMS @Smoke @API @WEB @API_Operation @MultiCurrency @2248 @FourKitesAPI @Debugging
  Scenario: 2248 - FourKites API- Stop Tracking Operation
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
      | 1L       | Chicago Pizza | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Close Toast message
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

    # Step 4
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -

    # Step 5,6
    Then Update details -
      | Tracking Provider | Driver Phone |
      | FourKites         | 2179721878   |

    # Step 7
    Then Click on Native "On" button -
    Then Verify Message displaying as "Success - Carrier Banner"
    And "Without Capture" and Close all the Toast messages from Bottom

    # Step 8
    Then Close Modal
    Then Navigate to stored URL for "Load_1"

    # Step 9
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Get Details
      | Tracking Number |
      |                 |
    Then Verify "SysData=>Tracking Number" value is not empty

    #Step 10 Expected result a
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -
    Then Click on Native "Off" button -
    Then Wait for "3" Seconds
 #  Then Verify Message displaying as "Success - Carrier Banner"
#    Then Verify Success Message displaying as "Success - Carrier Banner"
    And "Capture" and Close all the Toast messages from Bottom
    Then Close Toast message

    # Step 11 Expected b
    Then Wait for "2" Seconds
    Then Verify Assertion for "delete_loads_Request_Payload" contains "SysData=>Tracking Number"

    # Step 12 Expected c
    Then Update and verify Response payload for "delete_loads" with "TC2248_2_Response_Expected.json"
      |{TrackingID}|
      |SysData=>Tracking Number             |
    Then Wait for "2" Seconds

   # Step 13
    Then Close Modal
    Then Navigate to stored URL for "Load_1"

    # Step 14 & 15
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Verify Details
      | Tracking Number |Tracking Provider |
      |               |                    |
