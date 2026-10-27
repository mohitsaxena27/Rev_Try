Feature: 538 - MacroPoint API - Outbound Start Tracking Operation as Customer


  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @538 @MacroPoint @Debugging
  Scenario: 538 - MacroPoint API - Outbound Start Tracking Operation as Customer
    When Login into Salesforce
    # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Update details -
      | Default MacroPoint Stop Sequencing On |
      | true                                  |
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | true            |
    And Update the Custom Select option "Logging User" as "User User"
    Then Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Email Carrier Two" from List
    Then Wait for "4" Seconds
    Then Go to "Carrier Operations" Tab
    Then Scroll into Section "US Registration"
    Then Click on Edit icon on "US DOT Number"
    Then Update details
      | US DOT Number |
      | 987654123     |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_1"

    # Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | NA             | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Expected_Date | Value | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Same_as_Customer | 1             | NA    | NA                       | 0830             | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | Account_Address | Los Angeles Lighting | 1             | NA                       | 1300-1950        | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Same_as_Customer | NA    | 3             | NA                       | 0400-0930        | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 3   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |


    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 2 | Stop 3   | Grapes      | 1200   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details

    # Step 4
    Then Capture the current URL for "Load_1"

    # Step 5
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "4" Seconds

    # Step 6
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Click on button "Assign"
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

    # Step 7
    Then Go to "Summary" Tab
    Then Wait for "1" Seconds
    Then Go to "Shipment" Tab
    Then Click on "1P" "Arrived" chevron
    Then Update details
      | Arrival Date | Arrival Time |
      | 1            | 0815         |
    Then Click on "1P" "Save" button
    Then Verify "1P" Shipment is "Arrived"
    Then Wait for "8" Seconds
    Then Refresh current Page

    # Step 8
    Then "Without Capture" and Close all the Toast messages from Bottom

    # Step 9
    Then Go to "Summary" Tab
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration"

    # Step 10
    Then Update details -
      | Tracking Provider | Timezone     | Tracking Duration | Tracking Update Interval | Tracking Notes                            | Tracking Update Email List         | Driver Phone |
      | MacroPoint        | Central Time | 5 days            | 12 hours                 | Customer required POD at time of delivery | QA@revenova.com, test@revenova.com | 217-972-1878 |
    # Step 11
    Then Click on Native "On" button -
    Then Verify Message displaying as "Success - Carrier Banner"
    And "Capture" and Close all the Toast messages from Bottom
    Then Set key "EmailCarrierID" for Object "Account" and Name "Email Carrier Two"

   # Expected Result a
    Then TimeZone Specific - Update and verify XML Request for "createorder" with "538_Expected_Result.xml"

      | {LoadNumber} | {CurrentDate+1} | {CurrentDate+3} | {EmailCarrierTwo}       |
      | SysData=>1L  | 1               | 3               | SysData=>EmailCarrierID |


    # Step 12
    And "Capture" and Close all the Toast messages from Bottom
    Then Get XML Attribute "/OrderResult/OrderID" or "/OrderResult/TrackingRequestID" from "createorder" "Response" and store onto "OrderID"


     # Step 13 # Expected Result b
    Then Go to "Summary" Tab
    Then Click on Native "Load Tracking" icon
    Then Verify Carrier Tracking Status as "On"
    Then Verify "SteelBlue" Color with "White" Text of "On" Button is "Enabled"


   # Step 14
    Then Close Toast message
    #Expected Result C
    Then Verify Title "Load Tracking" is displaying with background color "SteelBlue"


    # Step 15
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    #expected Result d
    Then Verify Details
      | Tracking Number   |
      | SysData=> OrderID |
