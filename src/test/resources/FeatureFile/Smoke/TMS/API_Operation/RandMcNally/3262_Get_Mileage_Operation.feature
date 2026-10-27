Feature: 3262 - Rand McNally API - Get Mileage Operation


  @API @Regression @WEB @TMS @Smoke  @FMS @SingleCurrency @FMS @Trimble_API @3262 @Debugging
  Scenario: 3262 - Rand McNally API - Get Mileage Operation

    When Login into Salesforce

    #Step1
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
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "Customer Mileage & Routing"
    Then Click on Edit icon on Label "Mileage API"
    Then Update details
      | Mileage API |
      | Rand McNally    |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Capture the current URL for "TP_1"

  #Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans |Truckload | NA     | N              | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA          | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Atlanta Braves   |  3             | NA                       | NA       | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas   | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
   # Step 4
    And "Without Capture" and Close all messages from Bottom
    Then Wait for "2" Seconds

    #Step 5 & 6
    Then Click on button with Title "Refresh Route"
    Then Wait for "4" Seconds
    And "Capture" and Close all messages from Bottom
    #Expected a
    Then Verify Assertion for "randmcnally_routetype_Request_Payload" contains ""
    #Expected b
    Then Verify Assertion for "randmcnally_routetype_Url" contains "location1=Boston%2CMA&location2=Atlanta%2CGA"
    #Expected c
    Then Get Attribute "MileageResult.Response.MileageRecord[0].f2_Miles" store into "f2_Miles" from "randmcnally_routetype" "Response"
    Then Verify "f2_Miles" is positive value

     #Step 7
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    #Expected d
    Then Convert "f2_Miles" into specific Number Format
    Then Verify Details
      | Distance (Miles) |
      | SysData=>f2_Miles|

   #Step 8 & Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Boston Beans |Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | N       | 1P   | City_State_PC   | Grovetown,GA,30813,US | 0             | NA               | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | N       | 2D   | City_State_PC   | Franklin, IN, 46131,US | 1             | NA               | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Materials    | 10000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details

     #Expected e
    Then Verify Message not displaying with "Warning - Load Details"
    Then Verify Message not displaying with "FAILURE - Routing failed - COUNTY QUALIFIER REQUIRED - Error Occurs in Location 2. - Rand McNally"

    #Step 10
    And "Without Capture" and Close all messages from Bottom
    Then Wait for "2" Seconds
    Then Verify Warning Message "FAILURE - Routing failed - COUNTY QUALIFIER REQUIRED - Error Occurs in Location 2. - Rand McNally" not stored during enabled logging

    #Step 11 & 12
    Then Click on button with Title "Refresh Route"
    Then Wait for "4" Seconds
    And "Capture" and Close all messages from Bottom
    #Expected f
    Then Verify Assertion for "randmcnally_routetype_Request_Payload" contains ""
    #Step 13 #Expected g
    Then Verify Assertion for "AddressLine" contains "Franklin,IN NOT VALID. DEFAULTING TO ZIP: 46131"
    #Step 14 #Expected h
    Then Verify Assertion for "randmcnally_routetype_Url" contains "location1=Grovetown%2CGA&location2=46131"
    #Step 15
    Then Get Attribute "MileageResult.Response.MileageRecord[0].f2_Miles" store into "f2_Miles" from "randmcnally_routetype" "Response"
    #Step 16
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    #Expected i
    Then Convert "f2_Miles" into specific Number Format
    Then Verify Details
      | Distance (Miles) |
      | SysData=>f2_Miles|

#      # Step 17 - Create initial quick-entry load
#    Then Open "Loads" from App Launcher
#    Then Select Customer Details and Load Type
#      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
#      | 1L       | Boston Beans | Truckload | NA             | N              | N                 |
#
#    Then Add Location Details
#      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
#      | N       | 1P   | Same_as_Customer | NA    | Tomorrow      | NA                       | NA               | NA                  |
#
#    Then Add Location Details
#      | Add_Loc | Type | Address_Type  | Value                         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
#      | N       | 2D   | City_State_PC | West Bend,Wisconsin,53095,US  | 3             | NA                       | NA               | NA                  |
#
#    Then Add Line Items - Quick View
#      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
#      | 1         | P1     | D2       | Mixed       | 13000  | NA           | NA       | NA             |
#
#    #step 18, 19
#    Then Save Load With All details
#    #step 20
#    Then Verify Message displaying as "Save was successful."
#    And "Without Capture" and Close all messages from Bottom
#    #step21
#    Then Click on button with Title "Refresh Route"
#    Then Wait for "4" Seconds
#    And "Capture" and Close all messages from Bottom
#    #step22 Expected J
#    Then Verify Assertion for "randmcnally_routetype_Url" contains "location2=West+Bend%2CWI"
#    Then Verify Message not displaying with "FAILURE - Routing failed"
#    #step23 Expected K
#    Then Verify Assertion for "randmcnally_routetype_Response_Body" contains "\"f1_Location\":\"WEST BEND,WI\""
#    Then Verify Assertion for "randmcnally_routetype_Response_Body" contains "\"f2_Miles\":\"1119\""
#    #step24 Expected l
#    Then Get Attribute "MileageResult.Response.MileageRecord[0].f2_Miles" store into "f2_Miles" from "randmcnally_routetype" "Response"
#    Then Go to "Details" Tab
#    Then Scroll into Section "Load Summary"
#    Then Convert "f2_Miles" into specific Number Format
#    Then Verify Details
#      | Distance (Miles) |
#      | SysData=>f2_Miles |
#
#          # Step25 - Update Boston Beans shipping ZIP
#    Then Search and Select "Boston Beans" Account from the Global search
#    Then Go to "Details" Tab
#    Then Scroll into Section "Address Information"
#    Then Click on Edit icon on Label "Shipping Address"
#
#    Then Update details
#      | Shipping Zip/Postal Code |
#      | 02215-1702              |
#
#    Then Click on button "Save"
#
#    # Step 26
#    Then Open Load with "1L_LoadURL"
#
#  # Steps 27,28 - Add Stop 3D
#    Then Click on "Add Delivery" action is displaying with Stop "1"
#
#    Then Add More Location Details
#      | Add_Loc | Type | Address_Type  | Value                         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
#      | Y       | 3D   | City_State_PC | Red Deer,Alberta,T4R 2N7,CA   | 7             | NA                       | NA               | NA                  |
#
#    And "Without Capture" and Close all messages from Bottom
#
#    # Steps 29,30
#    Then Click on "Items" on "2" item
#    Then Click on "Add Line Item" on "2" item
#
#    Then Update details
#      | Item Number | Item Description | Weight |
#      | Item 2      | Mixed            | 13000 |
#
#    Then Click on button "Save"
#
#     # Step 31 - Refresh route
#    Then Click on button with Title "Refresh Route"
#    Then Wait for "4" Seconds
#    And "Capture" and Close all messages from Bottom
#
#    # step 32 Expected m
#    Then Verify Assertion for "randmcnally_routetype_Url" contains "location1=Boston%2CMA"
#    Then Verify Assertion for "randmcnally_routetype_Url" contains "location2=West+Bend%2CWI"
#    Then Verify Assertion for "randmcnally_routetype_Url" contains "location3=Red+Deer%2CAB"
#
#  # step 33 Expected n
#    Then Verify Assertion for "randmcnally_routetype_Response_Body" contains "\"f1_Location\":\"Total\",\"f2_Miles\":\"2702\""
#    Then Get Attribute "MileageResult.Response.MileageRecord[0].f2_Miles" store into "f2_Miles" from "randmcnally_routetype" "Response"
#   # step 34 Expected o
#    And "Without Capture" and Close all messages from Bottom
#    Then Go to "Details" Tab
#    Then Scroll into Section "Load Summary"
#    Then Convert "f2_Miles" into specific Number Format
#    Then Verify Details
#      | Distance (Miles) |
#      | SysData=>f2_Miles |
#
#
#
#
#
