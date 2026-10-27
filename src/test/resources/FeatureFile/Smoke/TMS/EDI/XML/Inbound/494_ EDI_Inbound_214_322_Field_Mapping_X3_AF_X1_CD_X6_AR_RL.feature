Feature: 494 - EDI Inbound 214/322- Field Mapping: X3+AF+X1+CD+X6+AR+RL

  @Regression @TMS @Smoke @WEB @API  @SingleCurrency @EDI @494
  Scenario: 494 - EDI Inbound 214/322- Field Mapping: X3+AF+X1+CD+X6+AR+RL

    When Login into Salesforce
    #-----------------------------------------------------
    #Step 1`
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Cleo" in the "Search Credentials..." search box
    Then Select the "Cleo" record from the lookup field results
    And Update details for "Cleo" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Search text "Custom EDI" in the "Search Credentials..." search box
    Then Select the "Custom EDI" record from the lookup field results
    And Update details for "Custom EDI" service
      | Enabled |
      | False   |
    And Click on Native "Save" button

    #Step2
    Then Go to "Home" Object
    Then Verify and Delete "EDIWatcherJob" from Scheduled Jobs

    #Step 3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Freeze Load Number |
      | False               |
    Then Scroll into Section "Debugging" -
    Then Update details -
       | Enable Packet Replay |
       | True                 |
    And Update the Custom Select option "Logging User" as "User User"
   Then Scroll into Section "EDI Setup" -
    Then Update details -
      |Use REST API for EDI|
      |False               |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
    |EDI Enabled|Enable EDI Transaction Logging|
    |True       |True                          |
    And Update the Custom Select option "EDI Administrator" as "User User"
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    Then Update details -
    |Inbound 204|Inbound 990|Inbound 214|Inbound 210|Inbound 824|Inbound 322|Inbound 410|Outbound 990|Outbound 204|Outbound 210|Outbound 214|Outbound 404|Outbound 998|
    |True       |True       |True       |True       |True       |True       |True       |True        |True        |True        |True        |True        |True        |

    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

     #Step 4, 5, 6
    Given Upload File "KleinschmidtGetLoadStatusesOperation(Test Case 494).xml" with Title "KleinschmidtGetLoadStatusesOperation"

    #Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Intermodal | Container 40  | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load-494A"

    #Step 8
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number|Waybill Number|Booking Number|Seal Number|
      |Load-494A |BOL494          |Inbound322   |SEAL494    |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-494A"
    Then Verify Details
      |Load Number      |
      |Load-494A |

    # Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_1"

    #Step 10
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load-494B"
    #Steps 11
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number      |
      |Load-494B         |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-494B"
    Then Verify Details
      |Load Number      |
      |Load-494B |

    # Step 12
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_2"

       #Step 13
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |3L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load-494C"
    #Steps 14
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number      |
      |Load-494C         |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-494C"
    Then Verify Details
      |Load Number      |
      |Load-494C |

    # Step 15
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_3"

    #Step 16
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |4L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load-494D"
    #Steps 17
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number      |
      |Load-494D         |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-494D"
    Then Verify Details
      |Load Number      |
      |Load-494D |

    # Step 18
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_4"

    #Step 19
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |5L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Account_Address | Kansas City Chiefs    | 0              | NA                       | NA               | NA                   |

     Then Add Location Details
       | Add_Loc | Type | Address_Type     | Value                        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
       | N       | 2P   | Account_Address  | Joe's Kansas City Bar    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Same_as_Customer | NA              |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D3      |Material     |6500 |NA          |NA       |NA       |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |2        |P2    |D3      |Bananas     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load-494E"
    #Steps 20
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number      |
      |Load-494E         |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-494E"
    Then Verify Details
      |Load Number      |
      |Load-494E |

    # Step 21
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_5"

    #Step 22
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |6L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Kansas City Chiefs    | 0              | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value                        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2P   | Account_Address | Joe's Kansas City Bar    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Same_as_Customer | NA              |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D3      |Material     |6500 |NA          |NA       |NA       |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |2        |P2    |D3      |Bananas     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load-494F"
    #Steps 23
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number      |
      |Load-494F         |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-494F"
    Then Verify Details
      |Load Number      |
      |Load-494F |

    # Step 24
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_6"

    #Step 25
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
    Then Set "CurrentTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "2" Seconds
    Then Refresh current Page
    #Step 26
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected a
    Then Verify "Departed Kansas City Chiefs - Stop 1" data is created with following details
      |Type             |Reported Location	|Status As Of            |Update Received At(Date)  |Source   |
      |Location Update	|Kansas City, MO US |SysData=>CurrentTime    |SysData=>CurrentTime      |User User|

    #Step 27
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |7L       | Boston Beans | Intermodal | Container 40     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Pizza    | 0              | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value                        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2P   | Account_Address | Joe's Kansas City Bar    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Same_as_Customer | NA              |  2            | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D3      |Material     |6500 |NA          |NA       |NA       |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |2        |P2    |D3      |Bananas     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load-494G"

    #Steps 28
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number|Waybill Number|Booking Number|Seal Number|
      |Load-494G |WBOL494          |494G   |SEALTEST    |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-494G"
    Then Verify Details
      |Load Number      |
      |Load-494G |

    # Step 29
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_7"

    #Step 30
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |8L       | Boston Beans | Intermodal | Container 40     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Boston Red Sox    | 0              | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value                        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2P   | Account_Address | Carolina Panthers    | 1              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Account_Address | Dallas Cowboys  |  2            | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D3      |Material     |6500 |NA          |NA       |NA       |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |2        |P2    |D3      |Bananas     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load-494H"

    #Steps 31
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number|
      |Load-494H |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-494H"
    Then Verify Details
      |Load Number      |
      |Load-494H |

    # Step 32
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_7"

    #Step 33
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

#    Step 34
    Then Go to "Home" Object
    Then Run "EDIWatcherJob" Job
    Then Get "Previous Run Time" of "EDIJob" onto "PreviousRunTimeOnly"
    Then Wait for "120" Seconds
    Then Set "SysData=>PreviousRunTimeOnly" minus "2" hours time onto "EDIJobCompletedTime"
    Then Get Date and Time for "Previous Run Time" of "EDIJob" onto "PreviousRunTime"
#    Load-494A Verification
#    Step 35
    Then Navigate to stored URL for "Load-494A"
    Then Go to "EDI" Tab
    #Expected b
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "322"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "214"
    Then Verify "EDI Transactions" "Event Code" is displaying as "X3"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "X3" as "SysData=>PreviousRunTime"

      #Step 36
    Then Go to "Summary" Tab
    #Expected c
    Then Verify Banner Details
      |Load Status|
      |Dispatched   |
    #Step 37
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    #Expected Result d
    Then Verify Details
      |Waybill Number|Booking Number|Seal Number|
      |way494A          |494BNA   |SEAL494     |
    #Step 38 & 39
    Then Refresh current Page
    #Expected e
    Then Verify "1P" "Arrived" chevron is highlighted with "SteelBlue"
     #Step 39
    Then Click on "1P" "Arrived" chevron
    Then Wait for "3" Seconds
    #Expected f
    Then Verify details for all Enabled fields
      | Arrival Date   | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments | Last Reported City | Last Reported State/Province | Last Reported Country |
      | Dec 23, 2018   |              | Arrived     | --None--       | Arrived at Pickup Location | Morrison            | CO                           | US                    |

    #Step 40
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected g
    Then Verify "Arrived at Pickup Location" data is created with following details
      |Type             |Reported Location	|Status As Of         |Update Received At  |Source   |
      |Location Update	|Morrison, CO US    |12/22/2018, 11:00 PM |SysData=>PreviousRunTime  |EDI      |

  #Load-494B Verification
    #Step 41
    Then Navigate to stored URL for "Load-494B"
    Then Go to "EDI" Tab
    #Expected h
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "AF"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "AF" as "SysData=>PreviousRunTime"

      #Step 42
    Then Go to "Summary" Tab
    #Expected i
    Then Verify Banner Details
      |Load Status|
      | In Transit   |
    #Step 43
    #Expected j
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"
    #Step 44
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    #Expected k
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Departure Date | Departure Time | Stop Status | Carrier Status       | Carrier Status Comments |Last Reported City | Last Reported State/Province | Last Reported Country |
      |              |              | Dec 23, 2018   | 09:00          | Departed    |  --None--                    | Departed Pickup Location with Shipment |    | --None--                     |--None--               |
    #Step 45
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected l
    Then Verify "Departed Pickup Location with Shipment" data is created with following details
      |Type             |Reported Location	|Status As Of         |Update Received At(Date)  |Source   |
      |Driver Event	    |   NA                |12/23/2018, 8:00 AM |SysData=>PreviousRunTime                         |EDI|

  #Load-494C Verification
    #Step 46
   Then Navigate to stored URL for "Load-494C"
    Then Go to "EDI" Tab
    #Expected m
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "X1"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "X1" as "SysData=>PreviousRunTime"

      #Step 47
    Then Go to "Summary" Tab
    #Expected n
    Then Verify Banner Details
      |Load Status|
      | Dispatched   |
    #Step 48
    #Expected o
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"
    #Step 49
    #Expected p
    Then Verify "2D" "Carrier Assigned" chevron is highlighted with "SteelBlue"
    #Step 50
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    #Expected q
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status       | Carrier Status Comments |Last Reported City | Last Reported State/Province | Last Reported Country |
      | Dec 22, 2018 | 08:45        | Departed    |  --None--                    | Arrived at Delivery Location |    | --None--                     |--None--               |

    #Step 51
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected r
    Then Verify "Arrived at Delivery Location" data is created with following details
      |Type             |Reported Location	|Status As Of         |Update Received At(Date)  |Source   |
      |Driver Event	    |   NA              |12/22/2018, 7:45 AM |SysData=>PreviousRunTime                          |EDI|

    #Load-494D Verification
    #Step 52
    Then Navigate to stored URL for "Load-494D"
    Then Go to "EDI" Tab
    #Expected s
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "CD"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "CD" as "SysData=>PreviousRunTime"

      #Step 53
    Then Go to "Summary" Tab
    #Expected t
    Then Verify Banner Details
      |Load Status|
      | Delivered   |

    #Step 54
    #Expected u
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"
    #Step 55
    #Expected v
    Then Verify "2D" "Departed" chevron is highlighted with "SteelBlue"
    #Step 56
    Then Click on "2D" "Departed" chevron
    Then Wait for "2" Seconds
    #Expected W
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time |Departure Date | Departure Time | Stop Status | Carrier Status       | Carrier Status Comments |Last Reported City | Last Reported State/Province | Last Reported Country |
      |              |              |Dec 23, 2018   | 08:00          | Departed    |  --None--                    | Carrier Departed Delivery Location |    | --None--                     |--None--               |

    #Step 57
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected x
    Then Verify "Carrier Departed Delivery Location" data is created with following details
      |Type             |Reported Location	|Status As Of         |Update Received At(Date)  |Source   |
      |Driver Event	    |   NA              |12/23/2018, 9:00 AM |SysData=>PreviousRunTime                          |EDI|

   #Load-494E Verification
    #Step 58
    Then Navigate to stored URL for "Load-494E"
    Then Go to "EDI" Tab
    #Expected y
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "X3"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "X3" as "SysData=>PreviousRunTime"

      #Step 59
    Then Go to "Summary" Tab
    #Expected z
    Then Verify Banner Details
      |Load Status|
      | In Transit   |
    #Step 60
    #Expected aa
    Then Verify "1P" "Carrier Assigned" chevron is highlighted with "SteelBlue"
    #Step 61
    #Expected ab
    Then Verify "2P" "Arrived" chevron is highlighted with "SteelBlue"
    #Step 62
    Then Click on "2P" "Arrived" chevron
    Then Wait for "2" Seconds
    #Expected ac
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status       | Carrier Status Comments |Last Reported City | Last Reported State/Province | Last Reported Country |
      | Oct 14, 2024 | 16:55        | Arrived    |  --None--                    | Arrived at Pickup Location |Kansas City    | KS                    |US               |

    #Step 63
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected ad
    Then Verify "Arrived at Pickup Location" data is created with following details
      |Type             |Reported Location	|Status As Of         |Update Received At(Date)  |Source   |
      |Location Update	|  Kansas City, KS US |10/14/2024, 4:55 PM |SysData=>PreviousRunTime                         |EDI|

     #Step 64
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    #Expected Result ae
    Then Verify Details
      |Last Reported Geolocation  |
      |34.02, -117.9495       |

     #Load-494F Verification
    #Step 65
   Then Navigate to stored URL for "Load-494F"
    Then Go to "EDI" Tab
    #Expected af
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "214"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "322"
    Then Verify "EDI Transactions" "Event Code" is displaying as "X6"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "X6" as "SysData=>PreviousRunTime"

      #Step 66
    Then Go to "Summary" Tab
    #Expected ag
    Then Verify Banner Details
      |Load Status|
      | In Transit   |
    #Step 67
    Then Click on "2P" "En Route" chevron
    Then Wait for "2" Seconds
    #Expected ah
    Then Verify details for all Enabled fields
      | Carrier ETA Date | Carrier ETA Time | Stop Status | Carrier Status       | Carrier Status Comments       |Last Reported City | Last Reported State/Province | Last Reported Country |
      |                  |                  | En Route    |  --None--            | En Route to Delivery Location |Springfield    | IL                    |US               |
    #Step 69
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected aj
    Then Verify "En Route to Delivery Location" data is created with following details
      |Type             |Reported Location	|Status As Of           |Update Received At(Date)  |Source   |
      |Location Update	|Springfield, IL US |10/14/2024, 12:55 PM   |SysData=>PreviousRunTime                         |EDI|

     #Step 68
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking Information"
    #Expected Result ai
    Then Verify Details
      |Last Tracking Update  |
      |10/14/2024, 12:55 PM       |

       #Load-494G Verification
    #Step 70
    Then Navigate to stored URL for "Load-494G"
    Then Go to "EDI" Tab
    #Expected ak
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "322"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "214"
    Then Verify "EDI Transactions" "Event Code" is displaying as "AR"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "AR" as "SysData=>PreviousRunTime"

      #Step 71
    Then Go to "Summary" Tab
    #Expected al
    Then Verify Banner Details
      |Load Status|
      |Dispatched   |
    #Step 72
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    #Expected Result am
    Then Verify Details
      |Waybill Number|Booking Number|Seal Number|
      |way494G          |494G    |SNG494     |
    #Step 73
    Then Go to "Shipment" Tab
    #Expected an
    Then Verify "1P" "Arrived" chevron is highlighted with "SteelBlue"
    #Step 74
    Then Click on "1P" "Arrived" chevron
    Then Wait for "2" Seconds
    #Expected ao
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status       | Carrier Status Comments          |Last Reported City | Last Reported State/Province | Last Reported Country |
      | Dec 23, 2018 |              | Arrived    |  --None--             | Rail Arrived at Destination Ramp |Morrison    | CO                    |US               |

    #Step 75
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected ap
    Then Verify "Rail Arrived at Destination Ramp" data is created with following details
      |Type             |Reported Location	|Status As Of           |Update Received At(Date)  |Source   |
      |Location Update	|Morrison, CO US    |12/23/2018, 12:00 AM   |SysData=>PreviousRunTime                          |EDI|

         #Load-494H Verification
    #Step 76
    Then Navigate to stored URL for "Load-494H"
    Then Go to "EDI" Tab
    #Expected aq
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "322"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "214"
    Then Verify "EDI Transactions" "Event Code" is displaying as "RL"
    Then Verify "Created Date" for "EDI Transactions" "Event Code" "RL" as "SysData=>PreviousRunTime"

      #Step 77
    Then Go to "Summary" Tab
    #Expected ar
    Then Verify Banner Details
      |Load Status|
      |In Transit   |
    #Step 78
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    #Expected Result as
    Then Verify Details
      |Waybill Number|Booking Number|Seal Number|
      |way494H          |494BNH    |SNH494     |
    #Step 79 & 80
    Then Go to "Shipment" Tab
    #Expected at
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"
    #Expected au
    Then Verify "2P" "Departed" chevron is highlighted with "SteelBlue"

    #Step 81
    Then Click on "2P" "Departed" chevron
    Then Wait for "2" Seconds
    #Expected av
    Then Verify details for all Enabled fields
      | Departure Date | Departure Time | Stop Status | Carrier Status       | Carrier Status Comments          |Last Reported City | Last Reported State/Province | Last Reported Country |
      | Dec 23, 2018 |              | Departed    |  --None--             | Rail Departure from Somewhere |Morrison    | CO                    |US               |
    #Step 82
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    #Expected aw
    Then Verify "Rail Departure from Somewhere" data is created with following details
      |Type             |Reported Location	|Status As Of           |Update Received At(Date)  |Source   |
      |Location Update	|Morrison, CO US    |12/23/2018, 12:00 AM   |SysData=>PreviousRunTime                          |EDI|
