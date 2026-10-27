Feature: 1597 - Trucker Tools API- Outbound Stop Tracking Request

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @1597 @Trucker_Tool @Debugging
  Scenario: 1597 - Trucker Tools API- Outbound Stop Tracking Request


    When Login into Salesforce
    # Pre- Requisite
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | true            |
    And Update the Custom Select option "Logging User" as "User User"
    Then Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 48      | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date| Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    |0             | NA                       | NA             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats    | 3             | NA                       | NA        | NA                   |

       Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details

    # Step 2
    Then Capture the current URL for "Load_1"

    # Step 3
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Click on button "Assign"
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

    # Step 4
    Then Zoom Current Screen by "70"
    Then Go to "Summary" Tab
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration"

    # Step 6
    Then Update details -
      | Tracking Provider    |
      | Trucker Tools        |
    Then Wait for "3" Seconds
    # Step 7
    Then Update details
      |Start Time|Driver Phone|
      |1:00 AM   |2179721878  |
    Then Click on Native "On" button -
    Then Wait for "4" Seconds
    And "Capture" and Close all the Toast messages from Bottom
    Then Get Attribute "accountId" store into "accountId" from "LTL" "Request"
    Then Get Attribute "loadTrackExternalId" store into "loadTrackExternalId" from "LTL" "Request"
    Then Wait for "4" Seconds
    Then Click on Native "Off" button -
#    Then Try to Capture Success message before Debugging Log
    And "Capture" and Close all the Toast messages from Bottom
    #Expected a
    And Update and verify payload for "cancelLoadTrack" with "TC1597_RequestBody_Expected.json"
        |accountId         |loadTrackExternalId|
        |SysData=>accountId|SysData=>loadTrackExternalId|

    #Expected b
    Then Verify Message "Success - Carrier Banner" displaying stored during enabled logging
    Then Verify button with Text "Update Tracking" not displaying on Modal
    Then Close Toast message
    Then Close Toast message
    # Step 9
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    #expected Result c
    Then Get Details
      | Tracking Number   |Tracking Provider|
      |  ||
    Then Verify "Tracking Number" is null or Empty
    Then Verify "Tracking Provider" is null or Empty