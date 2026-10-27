Feature: 3398 - EDI Inbound 214/322- Field Mapping: X3+AF+X1+CD+X6+AR+RL(JSON)

  @Regression @TMS @Smoke @WEB @API  @SingleCurrency @EDI @3398
  Scenario: 3398 - EDI Inbound 214/322- Field Mapping: X3+AF+X1+CD+X6+AR+RL (JSON)

    When Login into Salesforce

    #Pre-conditions
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI |
      | True        | True                 |
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "User User"

    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #-----------------------------------------------------
    #Step 1`
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Freeze Load Number |
      | False              |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode       | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Intermodal | Container 40   | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Banana      | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load-3398A"

    #Step 3 & 3.a
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number | Waybill Number | Booking Number | Seal Number |
      | Load-3398A  | BOL3398        | Inbound322     | SEAL3398    |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3398A"
    Then Verify Details
      | Load Number |
      | Load-3398A  |

    # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
#    Then Set Carrier Quote value on to "Carrier_Quote_1"

    #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Banana      | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load-3398B"

    #Steps 6
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3398B  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3398B"
    Then Verify Details
      | Load Number |
      | Load-3398B  |

    # Step 7
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_2"

    #Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Banana      | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load-3398C"

    #Steps 9
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3398C  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3398C"
    Then Verify Details
      | Load Number |
      | Load-3398C  |

    # Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_3"

    #Step 11
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 4L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Banana      | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load-3398D"

    #Steps 12
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3398D  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3398D"
    Then Verify Details
      | Load Number |
      | Load-3398D  |

    # Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_4"

    #Step 14
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 5L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Account_Address | Kansas City Chiefs | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | Account_Address | Joe's Kansas City Bar | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D3       | Material    | 6500   | NA           | NA       | NA             |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P2     | D3       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load-3398E"

    #Steps 15
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3398E  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3398E"
    Then Verify Details
      | Load Number |
      | Load-3398E  |

    #Step 16
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_5"

    #Step 17
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 6L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Kansas City Chiefs | 0             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2P   | Account_Address | Joe's Kansas City Bar | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D3       | Material    | 6500   | NA           | NA       | NA             |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P2     | D3       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load-3398F"

    #Steps 18
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3398F  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3398F"
    Then Verify Details
      | Load Number |
      | Load-3398F  |

    #Step 19
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_6"

    #Step 20
    Then Go to "Summary" Tab
    Then Wait for "1" Seconds
    Then Go to "Shipment" Tab
    Then Wait for "1" Seconds
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date |
      | 0              |
    Then Click on "1P" "Save" button
    Then Set "CurrentTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Refresh current Page

    #Step 21
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text

    #Expected a
    Then Verify "Departed Kansas City Chiefs - Stop 1" data is created with following details
      | Type            | Reported Location  | Status As Of         | Update Received At(Date) | Source    |
      | Location Update | Kansas City, MO US | SysData=>CurrentTime | SysData=>CurrentTime                        | User User |

    #Step 22
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode       | Equipment_Type | Details_Entry | Show_Accessorials |
      | 7L       | Boston Beans | Intermodal | Container 40   | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Pizza | 0             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                       | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2P   | Account_Address | Joe's Kansas City Bar-B-Que | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Same_as_Customer | NA    | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D3       | Material    | 6500   | NA           | NA       | NA             |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P2     | D3       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load-3398G"

    #Steps 23
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number | Waybill Number | Booking Number | Seal Number |
      | Load-3398G  | WBOL3398       | 3398G          | SEALTEST    |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3398G"
    Then Verify Details
      | Load Number |
      | Load-3398G  |

    # Step 24
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_7"

    #Step 25
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode       | Equipment_Type | Details_Entry | Show_Accessorials |
      | 8L       | Boston Beans | Intermodal | Container 40   | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value          | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Boston Red Sox | 0             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2P   | Account_Address | Carolina Panthers | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value          | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Account_Address | Dallas Cowboys | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D3       | Material    | 6500   | NA           | NA       | NA             |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P2     | D3       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load-3398H"

    #Steps 26
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3398H  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3398H"
    Then Verify Details
      | Load Number |
      | Load-3398H  |

    # Step 27
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_7"

    #Step 28
    Then Go to "Summary" Tab
    Then Wait for "1" Seconds
    Then Go to "Shipment" Tab
    Then Wait for "1" Seconds
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date |
      | 0              |
    Then Click on "1P" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 29
    Then Send Post Request for EDI with Json "Update_Loads_3398.txt" with Access Token as "Access_Token"

    #Step 30
    Then Set "API_CurrentTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "60" Seconds

    #Load-3398A Verification
    #Step 31
    Then Navigate to stored URL for "Load-3398A"
    Then Go to "EDI" Tab

    #Expected b
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "322"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "214"
    Then Verify "EDI Transactions" "Event Code" is displaying as "X3"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "X3" as "SysData=>API_CurrentTime"

    #Step 32
    Then Go to "Summary" Tab

    #Expected c
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

    #Step 33
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"

    #Expected Result d
    Then Verify Details
      | Waybill Number | Booking Number | Seal Number |
      | way3398A       | 3398BNA        | SEAL3398    |

    #Step 34
    Then Refresh current Page

    #Expected e
    Then Verify "1P" "Arrived" chevron is highlighted with "SteelBlue"

    #Step 35
    Then Click on "1P" "Arrived" chevron
    Then Wait for "3" Seconds

    #Expected f
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments    | Last Reported City | Last Reported State/Province | Last Reported Country |
      | Dec 23, 2018 |              | Arrived     | --None--       | Arrived at Pickup Location | Morrison           | CO                           | US                    |

    #Step 36
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text

    #Expected g
    Then Verify "Arrived at Pickup Location" data is created with following details
      | Type            | Reported Location | Status As Of         | Update Received At(Date) | Source |
      | Location Update | Morrison, CO US   | 12/22/2018, 11:00 PM | SysData=>API_CurrentTime | EDI    |

    #Load-3398B Verification
    #Step 37
    Then Navigate to stored URL for "Load-3398B"
    Then Go to "EDI" Tab

    #Expected h
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "AF"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "AF" as "SysData=>API_CurrentTime"

    #Step 38
    Then Go to "Summary" Tab

    #Expected i
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

    #Step 39
    #Expected j
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"

    #Step 40
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds

    #Expected k
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Departure Date | Departure Time | Stop Status | Carrier Status | Carrier Status Comments                | Last Reported City | Last Reported State/Province | Last Reported Country |
      |              |              | Dec 23, 2018   | 09:00          | Departed    | --None--       | Departed Pickup Location with Shipment |                    | --None--                     | --None--              |

    #Step 41
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text

    #Expected l
    Then Verify "Departed Pickup Location with Shipment" data is created with following details
      | Type         | Reported Location | Status As Of        | Update Received At(Date) | Source |
      | Driver Event | NA                | 12/23/2018, 8:00 AM | SysData=>API_CurrentTime | EDI    |

    #Load-3398C Verification
    #Step 42
    Then Navigate to stored URL for "Load-3398C"
    Then Go to "EDI" Tab

    #Expected m
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "X1"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "X1" as "SysData=>API_CurrentTime"

    #Step 43
    Then Go to "Summary" Tab

    #Expected n
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

    #Step 44
    #Expected o
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"

    #Step 45
    #Expected p
    Then Verify "2D" "Carrier Assigned" chevron is highlighted with "SteelBlue"

    #Step 46
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds

    #Expected q
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments      | Last Reported City | Last Reported State/Province | Last Reported Country |
      | Dec 22, 2018 | 08:45        | Departed    | --None--       | Arrived at Delivery Location |                    | --None--                     | --None--              |

    #Step 47
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text

    #Expected r
    Then Verify "Arrived at Delivery Location" data is created with following details
      | Type         | Reported Location | Status As Of        | Update Received At(Date) | Source |
      | Driver Event | NA                | 12/22/2018, 7:45 AM | SysData=>API_CurrentTime | EDI    |

    #Load-3398D Verification
    #Step 48
    Then Navigate to stored URL for "Load-3398D"
    Then Go to "EDI" Tab

    #Expected s
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "CD"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "CD" as "SysData=>API_CurrentTime"

    #Step 49
    Then Go to "Summary" Tab

    #Expected t
    Then Verify Banner Details
      | Load Status |
      | Delivered   |

    #Step 50
    #Expected u
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"

    #Step 51
    #Expected v
    Then Verify "2D" "Departed" chevron is highlighted with "SteelBlue"

    #Step 52
    Then Click on "2D" "Departed" chevron
    Then Wait for "2" Seconds

    #Expected W
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Departure Date | Departure Time | Stop Status | Carrier Status | Carrier Status Comments            | Last Reported City | Last Reported State/Province | Last Reported Country |
      |              |              | Dec 23, 2018   | 08:00          | Departed    | --None--       | Carrier Departed Delivery Location |                    | --None--                     | --None--              |

    #Step 53
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text

    #Expected x
    Then Verify "Carrier Departed Delivery Location" data is created with following details
      | Type         | Reported Location | Status As Of        | Update Received At(Date) | Source |
      | Driver Event | NA                | 12/23/2018, 9:00 AM | SysData=>API_CurrentTime | EDI    |

    #Load-3398E Verification
    #Step 54
    Then Navigate to stored URL for "Load-3398E"
    Then Go to "EDI" Tab

    #Expected y
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "X3"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "X3" as "SysData=>API_CurrentTime"

    #Step 55
    Then Go to "Summary" Tab

    #Expected z
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

    #Step 56
    #Expected aa
    Then Verify "1P" "Carrier Assigned" chevron is highlighted with "SteelBlue"

    #Step 57
    #Expected ab
    Then Verify "2P" "Arrived" chevron is highlighted with "SteelBlue"

    #Step 58
    Then Click on "2P" "Arrived" chevron
    Then Wait for "2" Seconds

    #Expected ac
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments    | Last Reported City | Last Reported State/Province | Last Reported Country |
      | Oct 14, 2024 | 16:55        | Arrived     | --None--       | Arrived at Pickup Location | Kansas City        | KS                           | US                    |

    #Step 59
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text

    #Expected ad
    Then Verify "Arrived at Pickup Location" data is created with following details
      | Type            | Reported Location  | Status As Of        | Update Received At(Date) | Source |
      | Location Update | Kansas City, KS US | 10/14/2024, 4:55 PM | SysData=>API_CurrentTime | EDI    |

    #Step 60
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    #Expected Result ae
    Then Verify Details
      | Last Reported Geolocation |
      | 34.02, -117.9495          |

    #Load-3398F Verification
    #Step 61
    Then Navigate to stored URL for "Load-3398F"
    Then Go to "EDI" Tab

    #Expected af
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "X6"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "X6" as "SysData=>API_CurrentTime"

    #Step 62
    Then Go to "Summary" Tab
    #Expected ag
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

    #Step 63
    Then Click on "2P" "En Route" chevron
    Then Wait for "2" Seconds
    #Expected ah
    Then Verify details for all Enabled fields
      | Carrier ETA Date | Carrier ETA Time | Stop Status | Carrier Status | Carrier Status Comments       | Last Reported City | Last Reported State/Province | Last Reported Country |
      |                  |                  | En Route    | --None--       | En Route to Delivery Location | Springfield        | IL                           | US                    |

    #Step 64
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected aj
    Then Verify "En Route to Delivery Location" data is created with following details
      | Type            | Reported Location  | Status As Of         | Update Received At(Date) | Source |
      | Location Update | Springfield, IL US | 10/14/2024, 12:55 PM | SysData=>API_CurrentTime | EDI    |

    #Step 65
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking Information"
    #Expected Result ai
    Then Verify Details
      | Last Tracking Update |
      | 10/14/2024, 12:55 PM |

    #Load-3398G Verification
    #Step 66
    Then Navigate to stored URL for "Load-3398G"
    Then Go to "EDI" Tab
    #Expected ak
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "322"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "214"
    Then Verify "EDI Transactions" "Event Code" is displaying as "AR"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "AR" as "SysData=>API_CurrentTime"

    #Step 67
    Then Go to "Summary" Tab
    #Expected al
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

    #Step 68
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    #Expected Result am
    Then Verify Details
      | Waybill Number | Booking Number | Seal Number |
      | way3398G       | 3398G          | SNG3398     |

    #Step 69
    Then Go to "Shipment" Tab
    #Expected an
    Then Verify "1P" "Arrived" chevron is highlighted with "SteelBlue"

    #Step 70
    Then Click on "1P" "Arrived" chevron
    Then Wait for "2" Seconds
    #Expected ao
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments          | Last Reported City | Last Reported State/Province | Last Reported Country |
      | Dec 23, 2018 |              | Arrived     | --None--       | Rail Arrived at Destination Ramp | Morrison           | CO                           | US                    |

    #Step 71
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected ap
    Then Verify "Rail Arrived at Destination Ramp" data is created with following details
      | Type            | Reported Location | Status As Of         | Update Received At(Date) | Source |
      | Location Update | Morrison, CO US   | 12/23/2018, 12:00 AM | SysData=>API_CurrentTime | EDI    |

    #Load-3398H Verification
    #Step 72
    Then Navigate to stored URL for "Load-3398H"
    Then Go to "EDI" Tab
    #Expected aq
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "322"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "214"
    Then Verify "EDI Transactions" "Event Code" is displaying as "RL"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "RL" as "SysData=>API_CurrentTime"

    #Step 73
    Then Go to "Summary" Tab
    #Expected ar
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

    #Step 74
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    #Expected Result as
    Then Verify Details
      | Waybill Number | Booking Number | Seal Number |
      | way3398H       | 3398BNH        | SNH3398     |

    #Step 75 & 76
    Then Go to "Shipment" Tab
    #Expected at
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"
    #Expected au
    Then Verify "2P" "Departed" chevron is highlighted with "SteelBlue"

    #Step 77
    Then Click on "2P" "Departed" chevron
    Then Wait for "2" Seconds
    #Expected av
    Then Verify details for all Enabled fields
      | Departure Date | Departure Time | Stop Status | Carrier Status | Carrier Status Comments       | Last Reported City | Last Reported State/Province | Last Reported Country |
      | Dec 23, 2018   |                | Departed    | --None--       | Rail Departure from Somewhere | Morrison           | CO                           | US                    |

    #Step 78
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected aw
    Then Verify "Rail Departure from Somewhere" data is created with following details
      | Type            | Reported Location | Status As Of         | Update Received At(Date) | Source |
      | Location Update | Morrison, CO US   | 12/23/2018, 12:00 AM | SysData=>API_CurrentTime | EDI    |