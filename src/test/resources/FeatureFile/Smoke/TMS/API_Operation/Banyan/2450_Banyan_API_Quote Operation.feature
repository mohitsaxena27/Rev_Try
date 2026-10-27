Feature: 2450 - Banyan API- Quote Operation (ImportForQuoteSync)

  Background: Pre- Test
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | false           | false                |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    Then Delete Field with Title "BanyanQuoteOperation"

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2450 @BanyanAPI @Debugging
  Scenario: 2450 - Banyan API- Quote Operation (ImportForQuoteSync)

  #  When Login into Salesforce
    #Step1
    Then Set "Org_id" with "EnvData=>Org_Id"

    #Step2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Customer Optional on Load Creation |
      | True                               |
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | True            | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 3
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Banyan Customer" from List
    Then Go to "Rates" Tab
    Then Click on Edit icon on Label "Carrier API Login Group"
    Then Update details
      | Carrier API Login Group |
      | Banyan2450TEST          |
    Then Click on "Save" button on Details Page
    Then Verify "Carrier API Login Group" having value of "Banyan2450TEST"
    Then Capture the current URL for "TP_Link"

    #Step 4 & 5
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode | Lane     | Category | Rate Type                | Status   |
      | Global Default         | LTL  | US to US | Carrier  | Freight+Fuel+Accessorial | Accepted |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service              | Rate Method |
      | Banyan Test Carrier - Banyan | API         |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_1"
    Then Capture the current URL for "Rate_Entry_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

    #Step6, 7, 8
    Given Upload File "BanyanQuoteOperation- 2450.txt" with Title "BanyanQuoteOperation"

    #Step9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Banyan Customer | LTL  | Dry Van 53     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | 1600             | NA                   |
    And Update details
      | Lift Gate Pick Up |
      | true              |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Greenbay Packers | NA            | NA                       | NA               | NA                   |
    Then Wait for "1" Seconds
    And Update details
      | Lift Gate Delivery |
      | true               |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | mixed       | 1200   | NA           | 8        | Pallets        | 24     | 48    | 48     | in             | 50         |

    Then Scroll into Section "Load Accessorials"
    And Update details
      | Blind Shipments |
      | true            |
    #Step 10
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

    #Step11
    Then Go to "Freight Quote Assistant" Tab
    #Step 12
    And "Capture" and Close all the Toast messages from Bottom

    #Expected a
    Then Verify Quotes returned
    #Expected b
    Then Get Attribute "AuthenticationData.ClientRefNum" store into "Client_Ref_Num" from "ImportForQuote_Sync" "Request"
    Then Verify Assertion for "Client_Ref_Num" contains "Banyan2450TEST"
    And Update and verify payload for "ImportForQuote_Sync" with "TC2450_RequestBody_Expected.json"
      | No Update Required |
      |                    |

    #Step13

    Then Click on "Carrier Quote" header link under "Carrier Quotes" tab
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section with Title "General Information"

    #Expected c
    Then Verify details for
      | Messages                       | Disclaimer                             |
      | Carrier Quote Number: 42441851 | GUARANTEED SERVICES QA Testing5678!!!* |
    Then Scroll into Section with Title "Pricing Summary"
    Then Verify details for
      | Freight Charges | Discount | Discount Percent | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Carrier Total |
      | USD 213.50      | USD 0.00 | 0.00%            | USD 213.50          | USD 0.00       | USD 190.00          | USD 403.50    |

    Then Scroll into Section with Title "Service Information"
    Then Verify details for
      | Service Class | Direct/Interline | Estimated Transit Time (Days) |
      | Standard      | Direct           | 3                             |
    Then Scroll into Section with Title "Contract Information"
    Then Verify details for
      | Carrier Quote Reference |
      | 28079557/245407860      |

   #Step14
    Then Click on "Liftgate Pickup" link under "Related" tab
    Then Scroll into Section with Title "General Information"

    #Expected d
    Then Verify details for
      | Accessorial       | Charge    | Code  | Unit       | Quantity | Name            |
      | Lift Gate Pick Up | USD 95.00 | SLFTG | Fixed Cost | 1.00     | Liftgate Pickup |
    Then Navigate Browser Back

    #Step15
    Then Click on "Liftgate Delivery" link under "Related" tab
    Then Scroll into Section with Title "General Information"

    #Expected e
    Then Verify details for
      | Accessorial        | Charge    | Code  | Unit       | Quantity | Name              |
      | Lift Gate Delivery | USD 95.00 | CLFTG | Fixed Cost | 1.00     | Liftgate Delivery |

    #Step 16
    Then Navigate to stored URL for "TP_Link"
    Then Go to "Rates" Tab
    Then Click on Edit icon on Label "Carrier API Login Group"
    Then Wait for "1" Seconds
    Then Enter Label "Carrier API Login Group" Text as ""
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify "Carrier API Login Group" having value of ""

    #Step 17
    Then Navigate to stored URL for "Load_Details"
    Then Go to "Freight Quote Assistant" Tab

    #Step 18
    Then Click on button with Title "Refresh Quotes"
    #Step 19
    And "Capture" and Close all the Toast messages from Bottom
    #Expected f
    Then Get Attribute "AuthenticationData.ClientRefNum" store into "Client_Ref_Num" from "UpdateLoad" "Request"
    Then Verify Assertion for "Client_Ref_Num" contains "SysData=>Org_id"

    #Step 20
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | NA       | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Banyan Customer | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Milwaukee Brewers | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | mixed       | 1300   | NA           | 9        | Crates         | 24     | 36    | 36     | in             | 55         |
    Then Save Load With All details

    #Step 21
    Then Go to "Freight Quote Assistant" Tab
    #Step 22
    And "Capture" and Close all the Toast messages from Bottom
    Then Get Attribute "AuthenticationData.ClientRefNum" store into "Client_Ref_Num" from "ImportForQuote_Sync" "Request"
    Then Get Attribute "Shipper.CompanyName" store into "CompanyName" from "ImportForQuote_Sync" "Request"
    Then Get Attribute "Shipper.LocationName" store into "LocationName" from "ImportForQuote_Sync" "Request"
    Then Get Attribute "Shipper.Dock.Name" store into "Dock_Name" from "ImportForQuote_Sync" "Request"
    Then Get Attribute "Shipper.Dock.Note" store into "Dock_Notes" from "ImportForQuote_Sync" "Request"
    Then Get Attribute "Shipper.Dock.CloseTime" store into "CloseTime" from "ImportForQuote_Sync" "Request"
    Then Get Attribute "Shipper.Dock.OpenTime" store into "OpenTime" from "ImportForQuote_Sync" "Request"
    Then Get Attribute "Shipper.Dock.ShipmentDateTime" store into "ShipmentDateTime" from "ImportForQuote_Sync" "Request"
    Then Get Attribute "Shipper.Dock.ConfirmationNumber" store into "ConfirmationNumber" from "ImportForQuote_Sync" "Request"
    Then Set "CloseTimeValue" with "Date(yyyy-MM-dd)=>0" and "T22:00:00"
    Then Set "OpenTimeValue" with "Date(yyyy-MM-dd)=>0" and "T09:00:00"
    Then Set "ShipmentDateTimeValue" with "Date(yyyy-MM-dd)=>0" and "T10:00:00"
    #Expected g
    Then Verify Assertion for "Client_Ref_Num" contains "SysData=>Org_id"
    Then Verify Assertion for "CompanyName" contains "Banyan Customer"
    Then Verify Assertion for "LocationName" contains "Banyan Customer"
    Then Verify Assertion for "Dock_Name" contains "Dock"
    Then Verify Assertion for "Dock_Notes" contains "Pickup Instructions"
    Then Verify Assertion for "OpenTime" contains "SysData=>OpenTimeValue"
    Then Verify Assertion for "CloseTime" contains "SysData=>CloseTimeValue"
    Then Verify Assertion for "ShipmentDateTime" contains "SysData=>ShipmentDateTimeValue"
    Then Verify Assertion for "ConfirmationNumber" contains ""