Feature: 2304 - SMC3 EVA API- Status Operation: LTL Tracking

  @API @Regression @WEB @TMS @Smoke @API_Operation @SingleCurrency @2304 @SMC3EVAAPI @Debugging
  Scenario: 2304 - SMC3 EVA API- Status Operation: LTL Tracking

    When Login into Salesforce
    Then Delete Field with Title "SMC3EVAStatusOperation"
    Then Delete All Records with name "L-" for "rtms__Load__c"

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

    #Step2 & 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 5             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | NA        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 4500   | NA           | 10       | Pallets        | 24     | 48    | 48     | NA             | 50         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom

    # Step 5
    Then Click on View Quotes
    Then Wait for "2" Seconds

    # Expected a
    Then Verify Text displaying as "SMC3 EVA Carrier - SMC3 EVA"

    # Step 6 & 7
    Then Select exact "SMC3 EVA Carrier - SMC3 EVA" from View Quotes
    Then Wait for "1" Seconds
    Then Click on Native "Tender" icon
    And "Capture" and Close all the Toast messages from Bottom
    # Expected b
    Then Verify Message "Load tendered successfully." displaying stored during enabled logging

    #Step 8
    Then Go to "Details" Tab
    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on Label "RFP"
    Then Update details
      | PO Number |
      | A2304     |
    Then Scroll into Section "Shipment IDs"
    Then Update details
      | Bill of Lading Number | PRO Number |
      | BOL2304               | PRO2304    |
    Then Click on "SaveEdit" button
    Then Wait for "5" Seconds
    Then Verify Details
      | PO Number | Bill of Lading Number | PRO Number |
      | A2304     | BOL2304               | PRO2304    |

    # Step 9
    Then Go to "Shipment" Tab
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Wait for "2" Seconds
    Then Update details
      | Pickup/Delivery Number |
      | 2304#,.)(-/                |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Collapse "Details" for "1" Load

    # Step 10
    Then Go to "Summary" Tab

    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -
    # Step 11 & Expected c
    Then Verify details for all Enabled fields
      | Tracking Provider |
      | SMC3 EVA          |

    # Step 11.a
    Then Click on Native "On" button -
    Then Wait for "3" Seconds
#    Then Verify Message displaying as "Success - Carrier Banner"

    # Step 12, 13
    And "Capture" and Close all the Toast messages from Bottom
    Then Close Toast message
    Then Get Attribute "revenovaId" store into "revenova_Id" from "SMCA_Status" "Request"
    Then Get Attribute "transactionId" store into "transaction_Id" from "SMCA_Status" "Response"
    Then Get Attribute "shipmentInfo.weight" store into "Weight" from "SMCA_Status" "Response"
    Then Get Attribute "transit.pickupDate" store into "pickupDate" from "SMCA_Status" "Response"
    Then Get Attribute "transit.delivery.estimatedDate" store into "estimated_Date" from "SMCA_Status" "Response"
    Then Get Attribute "transit.delivery.estimatedTime" store into "estimated_Time" from "SMCA_Status" "Response"
    Then Get Attribute "transit.delivery.actualDate" store into "actual_Date" from "SMCA_Status" "Response"
    Then Get Attribute "transit.delivery.actualTime" store into "actual_Time" from "SMCA_Status" "Response"
    Then Get Attribute "transit.delivery.appointment.date" store into "date" from "SMCA_Status" "Response"
    Then Get Attribute "transit.delivery.appointment.startTime" store into "start_Time" from "SMCA_Status" "Response"
    Then Get Attribute "transit.delivery.appointment.endTime" store into "end_Time" from "SMCA_Status" "Response"
    Then Get Attribute "status.code" store into "Status_Code" from "SMCA_Status" "Response"
    Then Get Attribute "status.utc" store into "UTC" from "SMCA_Status" "Response"
    Then Get Attribute "status.city" store into "city" from "SMCA_Status" "Response"
    Then Get Attribute "status.stateProvince" store into "stateProvince" from "SMCA_Status" "Response"

    # Expected d
    And Update and verify payload for "SMCA_Status" with "Expected_Request.json"
      | revenova_Id   | {CurrentDateYYYYMMDD+5} |
      | Transactional | 5                     |

    # Expected e
    And Update and verify Response payload for "SMCA_Status" with "Expected_Response.json"
      | transaction_Id   | {Weight}      | {pickup_Date}         | {estimated_Date} | {estimated_Time}                     | {actual_Date}        | {actual_Time}        | {start_Time}        | {end_Time}        | {Date}            | {UTC}         | {Status_Code} |
      | Transactional    | SysData=>Weight | SysData=>pickupDate | SysData=>estimated_Date    | SysData=>estimated_Time    | SysData=>actual_Date | SysData=>actual_Time | SysData=>start_Time | SysData=>end_Time | SysData=>date     | SysData=>UTC | SysData=>Status_Code |

    # Step 14
    Then Close Toast message

    # Step 15
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"

    # Expected f & g
    Then Verify Details
      | Tracking Number         | Tracking Provider |
      | SysData=>transaction_Id | SMC3 EVA          |
   Then Refresh current Page
    # Step 16
    Then Go to "Shipment" Tab
    Then Wait for "2" Seconds
    Then Click on "1P" "Departed" chevron

    # Expected h
    Then Verify details for all Enabled fields
      |Departure Date    | Stop Status |
      |0                 | Departed    |
    Then Click on "Cancel" with Text
    Then Wait for "3" Seconds

    # Step 17
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds

    # Expected i
    Then Verify details for
      | Appointment Time    |
      | NA                  |
    Then Collapse "Details" for "2" Load
    Then Wait for "2" Seconds

    # Step 17.a
    Then Click on "2D" "En Route" chevron
    Then Wait for "2" Seconds

    # Expected j
    Then Verify details for all Enabled fields
      | Carrier ETA Date        | Carrier ETA Time        | Stop Status |
      | SysData=>estimated_Date | SysData=>estimated_Time | En Route    |

    # Step 17.b
    Then Click on "2D" "Departed" chevron
    Then Wait for "2" Seconds
    # Expected k
    Then Verify details for all Enabled fields
      | Departure Date        | Departure Time        | Stop Status |
      | SysData=>actual_Date | SysData=>actual_Time | Departed    |
    Then Click on "Cancel" with Text
    Then Wait for "3" Seconds

    # Step 18
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "1" Seconds

    # Expected l
    Then Set "Address" with "SysData=>city" and ", "
    Then Set "Location" with "SysData=>Address" and "SysData=>stateProvince"
    Then Convert "SysData=>UTC" into Chicago Timezone with Format "M/d/yyyy, h:mm a" and store into "ChicagoTime"
    Then Verify "Picked up from origin location at" data is created with following details
      | Status As Of         | Source   |
      | SysData=>ChicagoTime | SMC3 EVA |

    # Step 19
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"

    # Expected m
    Then Verify Details
      | Load Status Comments           |
      | SysData=> carrier_Description |

    # Step 19.a, 19.b, 19.c
    Then Scroll into Section "Load Summary"
    Then Convert "Weight" into US Number Format
    # Expected n, o, p
    Then Verify Details
      |Last Reported Location| Last Reported City | Last Reported State/Province | Weight From Carrier    |
      |SysData=>Location| SysData=>city     | SysData=>stateProvince  | SysData=>Weight |
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on "Load Status"
    Then Update details
      | Load Status |
      | Cancelled   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

      #Step 20
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      |Enable Packet Replay |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    # Step 21, 22,23
    Then Upload File "SMC3EVAStatusOperation - PickedUpWithUTC - 2304.json" with Title "SMC3EVAStatusOperation"

    # Step 24
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Boston Beans | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | NA            | NA                       | 0800-0915        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 6500   | NA           | 2        | Pallets        | 24     | 48    | 48     | NA             | 50         |

    # Step 25
    Then Save Load With All details
    Then Capture the current URL for "Load_2"

    # Step 26
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom

    # Step 27
    Then Click on View Quotes
    Then Wait for "2" Seconds
    Then Verify Text displaying as "SMC3 EVA Carrier - SMC3 EVA"
    Then Select exact "SMC3 EVA Carrier - SMC3 EVA" from View Quotes
    Then Wait for "1" Seconds
    Then Click on Native "Tender" icon

    # Step 28
    And "Without Capture" and Close all the Toast messages from Bottom


    # Step 29
    Then Load Summary - Click on "1P" "Boston Beans" Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Arrival/Departure Information"

    # Expected q
    Then Verify details for
      | Departure Date | Departure Time |
      | 2/19/2024      | 12:13      |

   # Step 30
    Then Navigate to stored URL for "Load_2"

   # Step 31
    Then Go to "Shipment" Tab
    Then Click on "Tracking Log" with Text

    # Expected r
    Then Verify "PICKED UP - We're here to Pickup" data is created with following details
      | Type            | Reported Location | Status As Of            | Source   |
      | Location Update | Boston, MA        | 2/19/2024, 11:13 AM     | SMC3 EVA |

    # Step 32
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Click on Edit icon on Label "Tracking Number"
    Then Update details
      | Tracking Number | API Load Id | Document Polling Number |
      |                 |             |                         |
    Then Wait for "1" Seconds
    Then Click on "Save" button
    Then Wait for "2" Seconds

    Then Verify Details
      | Tracking Number |
      |                 |

    # Step 33
    Then Go to "Home" Object
    Then Verify and Delete "SMC3EVAJob" from Scheduled Jobs

    # Step 34 & 35
    Then Delete Field with Title "SMC3EVAStatusOperation"

    # Step 36 & 37
    Then Upload File "SMC3EVAStatusOperation -InTransitWithUTC - 2304.json" with Title "SMC3EVAStatusOperation"

    # Step 38
    Then Go to Home Page
    Then Run "SMC3EVAJob" Job
    Then Wait for "6" Seconds

    # Step 39 & 40
    Then Navigate to stored URL for "Load_2"

    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "1" Seconds

    # Expected s
    Then Verify "IN TRANSIT - We're In Transit, here." data is created with following details
      | Type            | Reported Location | Status As Of           | Source   |
      | Location Update | Topeka, KS        | 2/19/2024, 1:13 PM | SMC3 EVA |

    # Step 41
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Click on Edit icon on Label "Tracking Number"
    Then Update details
      | Tracking Number | API Load Id | Document Polling Number |
      |                 |             |                         |
    Then Wait for "1" Seconds
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Tracking Number |
      |                 |

    # Step 42
    Then Go to "Home" Object
    Then Verify and Delete "SMC3EVAJob" from Scheduled Jobs

    # Step 43 & 44
    Then Delete Field with Title "SMC3EVAStatusOperation"

    # Step 45 & 46
    Then Upload File "SMC3EVAStatusOperation -DeliveredWithUTC - 2304.json" with Title "SMC3EVAStatusOperation"

    # Step 47
    Then Go to Home Page
    Then Run "SMC3EVAJob" Job
    Then Wait for "6" Seconds

    # Step 48
    Then Navigate to stored URL for "Load_2"

    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "1" Seconds

    # Step 49
    Then Load Summary - Click on "1P" "Boston Beans" Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Latest Carrier Update"

    # Expected t
    Then Verify details for
      | Stop Status |
      | Departed    |

    # Step 50
    Then Navigate to stored URL for "Load_2"

    # STep 51 & 52
    Then Load Summary - Click on "2D" "Los Angeles Lighting" Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Latest Carrier Update"

    # Expected u
    Then Verify details for
      | Stop Status | Departure Date | Departure Time |
      | Departed    | 2/19/2024      | 13:13      |

    # Step 53
    Then Navigate to stored URL for "Load_2"

    # Step 54 & 55
    Then Scroll into Section "Tracking Log"
    Then Wait for "3" Seconds
    Then Click on "Tracking Log" with Text
    Then Wait for "1" Seconds

    # Expected u
    Then Verify "DELIVERED - Shipment has been delivered to consignee" data is created with following details
      | Type            | Reported Location | Status As Of           | Source   |
      | Location Update | Los Angeles, LA   | 2/19/2024, 3:13 PM | SMC3 EVA |