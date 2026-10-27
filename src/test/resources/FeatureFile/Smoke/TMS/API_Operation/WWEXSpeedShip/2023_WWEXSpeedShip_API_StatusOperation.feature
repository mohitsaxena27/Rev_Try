Feature: 2023 - WWEX SpeedShip API- Status Operation

  @API @Regression @TMS @Smoke  @WEB @API_Operation @SingleCurrency @2023 @WWEXSpeedShipAPI @Debugging
  Scenario: 2023 - WWEX SpeedShip API- Status Operation

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
      | Load_Num | Customer               | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | WWEXSpeedShip Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | 0800-0915        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 4500   | NA           | 1        | Pallets        | 24     | 48    | 48     | NA             | 50         |

    # Step 3
    Then Save Load With All details
    Then Capture the current URL for "Load-1"

    # Step 4
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "5" Seconds
    Then Verify Quotes returned
    Then Click on View Quotes
    Then Get "Carrier Service" and store in "Carrier_Service"
    Then Set Carrier Quote value on to "Carrier_Quote_Number"
    Then Get Carrier Name from Carrier Service "Carrier_Service" and store into "Carrier_Name"

    # Expected a
    And Verify Carrier Service displaying as "SysData=>Carrier_Service"

    # Step 5 & 6
    Then "Tender" Carrier
    And "Without Capture" and Close all the Toast messages from Bottom

    # Expected b
    Then Verify Message "Load tendered successfully." displaying stored during enabled logging

    # Step 7
    Then Search and Select "rtms__TransportationProfile__c" "SysData=>Carrier_Name" from the Global search
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Get Details
      | SCAC |
      |      |

    # Step 8
    Then Navigate to stored URL for "Load-1"
    Then Refresh current Page
    # Step 9
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

    # Step 10# Step 11
    Then Go to "Details" Tab
    Then Wait for "1" Seconds
    Then Scroll into Section "Shipment IDs"
    Then Get Details
      | Bill of Lading Number | PRO Number |
      |                       |            |

    # Step 12
    Then Click on Native "Request Carrier Status" icon

    # Step 13 & 14
    And "Capture" and Close all the Toast messages from Bottom

    # Expected d
    And Update and verify payload for "searchShipmentsFlow" with "Expected_d_RequestBody.json"
      | BOLNumber                      | SCAC_value    |
      | SysData=>Bill of Lading Number | SysData=>SCAC |

    # Expected e
    Then Get Attribute "response.orderedItemFulfillmentStatusList[0].status" store into "Status" from "searchShipmentsFlow" "Response"
    Then Get Attribute "response.orderedItemFulfillmentStatusList[0].fulfillmentStatusList[0].code" store into "Code" from "searchShipmentsFlow" "Response"
    Then Get Conditional Attribute "response.orderedItemFulfillmentStatusList[0].fulfillmentStatusList.find { it.code == 'CREATED' }.eventDateTime" store into "CreatedCode" from "searchShipmentsFlow" "Response"
    Then Get Conditional Attribute "response.orderedItemFulfillmentStatusList[0].fulfillmentStatusList.find { it.code == 'PENDING_PICKUP' }.eventDateTime" store into "PENDING_PICKUP_eventDateTime" from "searchShipmentsFlow" "Response"
    Then Get Attribute "response.orderedItemFulfillmentStatusList[0].fulfillmentStatusList[0].eventDateTime" store into "Event_DateAndTime" from "searchShipmentsFlow" "Response"
    Then Get Attribute "response.orderedItemFulfillmentStatusList[0].fulfillmentStatusList[0].actualEndTime" store into "actual_EndTime" from "searchShipmentsFlow" "Response"
    Then Get Attribute "response.orderedItemFulfillmentStatusList[0].fulfillmentStatusList[0].actualStartTime" store into "actual_StartTime" from "searchShipmentsFlow" "Response"
    Then Get Attribute "response.secondaryTxnIdV2List[0].type" store into "type" from "searchShipmentsFlow" "Response"
    Then Get Attribute "response.orderedItemFulfillmentStatusList[0].orderedItemId" store into "ordered_ItemId" from "searchShipmentsFlow" "Response"
    Then Get Attribute "response.speedshipTrackingURL" store into "TrackingLink" from "searchShipmentsFlow" "Response"
    Then Get Attribute "response.vendorPreferredName" store into "vendorPreferredName" from "searchShipmentsFlow" "Response"

    And Update and verify Response payload for "searchShipmentsFlow" with "Expected_e_ResponseBody.json"
      | {Code_Resp}   | {EventDateAndTime}         | {Type}        | {Value}                        | {Ordered_ItemId}        | {Tracking_Link}       | {Status}        | {TPName}              | {Scac}        | {PendingPickUpEventDateAndTime}       | {CreatedEventDateAndTime} |{vendorPreferredName}|
      | SysData=>Code | SysData=>Event_DateAndTime | SysData=>type | SysData=>Bill of Lading Number | SysData=>ordered_ItemId | SysData=>TrackingLink | SysData=>Status | SysData=>Carrier_Name | SysData=>SCAC | SysData=>PENDING_PICKUP_eventDateTime | SysData=>CreatedCode      |SysData=>vendorPreferredName|

    # Based on the codes returned in expected result E a, set the status in "Load_Status"
    Then Compare and Set "Status" on to "Load_Status"

    # Step 15
    Then Go to "Summary" Tab

    # Expected f
    Then Verify Banner Details
      | Load Status          |
      | SysData=>Load_Status |

    #Step till last with conditional Expected Result
    Then Verify expected result based on "Status"
