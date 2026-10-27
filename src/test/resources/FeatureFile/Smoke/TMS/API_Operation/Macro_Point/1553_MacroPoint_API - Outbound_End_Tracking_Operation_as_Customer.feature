Feature: 1553 - MacroPoint API - Outbound End Tracking Operation as Customer


  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @1553 @MacroPoint @Debugging
  Scenario: 1553 - MacroPoint API - Outbound End Tracking Operation as Customer
    When Login into Salesforce

    # Step 1
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

#    # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Expected_Date | Value | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | 0             | NA    | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details

    # Step 3
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Capture the current URL for "Load_1"

    # Step 4
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Click on button "Assign"
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

    # Step 5
    Then Go to "Summary" Tab
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -

    # Step 6
    Then Set "StartDay" with "MMMdd,yyyy=>0"
    Then Update details -
      | Tracking Provider | Start Day         | Start Time | Timezone     | Tracking Duration | Tracking Update Interval | Driver Phone |
      | MacroPoint        | SysData=>StartDay | 7:00 PM    | Central Time | 5 days            | 12 hours                 | 2179721878   |

    # Step 7
    Then Click on Native "On" button -
    Then Verify Message displaying as "Success - Carrier Banner"


    #Step 8
    And "Capture" and Close all the Toast messages from Bottom
    Then Get XML Attribute "/OrderResult/OrderID" or "/OrderResult/TrackingRequestID" from "createorder" "Response" and store onto "OrderID"


    #Step 9
    Then Scroll Up with "3" Times
    Then Click on Native "Load Tracking" icon
    Then Click on Native "Off" button -
    Then Verify Message displaying as "Success - Carrier Banner"
    And Wait for "2" Seconds

    # Step 10
    #expected Result a
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify url displaying with "SysData=>OrderID" as "https://macropoint-lite.com/api/1.0/orders/stoporder/{SysData=>OrderID}"


    # Step 11
    Then Scroll Up with "3" Times
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Get Details
      | Tracking Number |
      |                 |
    #expected Result b
    Then Verify "Tracking Number" is null or Empty










