Feature: 3187 - HubTran API - Send Load Operation

  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @HubTran @3187
  Scenario: 3187 - HubTran API - Send Load Operation

#    Pre-Requisite to execute this Test:
#    1. Install  1Password CLI on Jenkins Server
#    Install Command: winget install AgileBits.1Password.CLI
#    setx OP_SERVICE_ACCOUNT_TOKEN "your_token_here"
#    Test - op item get "HubTran Portal" --vault "Saksoft (External QA Support)" --fields label=username


    When Login into Salesforce
  # Steps 1
    Then 1PW - Set "password 2" value of "HubTran Environment One" on "Hubtran_Password_2"

  #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Freeze Load Number |
      | False              |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 3
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Email Carrier Two" from List
    Then Scroll into Section "Fleet Summary"
    Then Click on Edit icon on Label "SCAC"
    Then Enter Label "SCAC" Text as "AABB"
    Then Scroll into Section "US Registration"
    Then Enter Label "MC/MX/FF Number" Text as "MC112233"
    Then Enter Label "US DOT Number" Text as "11223344"
    Then Click on "Save" button
    Then Wait for "1" Seconds
    Then Verify "US DOT Number" having value of "11223344"
    Then Capture the current URL for "TP_Page"

    #Step 3.b
    Then Go to "Settlement" Tab
    Then Click on Edit icon on Label "Vendor Invoice Processor"
    Then Update details
         |Vendor Invoice Processor|
         | TriumphPay Audit       |
    Then Click on "Save" button
    Then Wait for "1" Seconds
    Then Verify "Vendor Invoice Processor" having value of "TriumphPay Audit"

    #Step 4 & 5
    Then Set key "ECT_AccountID" for Object "Account" and Name "Email Carrier Two"

    #Step 6 & 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Joliet Jazz Supplies | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 3            | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Music       | 8000   | NA          | 4         | Pieces        | 42     | 42    | 42     | NA             | 50         |
    Then Update details
      |HazMat|
      |True  |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 8
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Wait for "2" Seconds
    Then Update details
      | Pickup/Delivery Number  |
      | 31 |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Collapse "Details" for "1" Load
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Update details
      | Pickup/Delivery Number |
      | 87                |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."

    #Step 9 & 10
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Set "Load_CurrentDateTime" with "ddMMYY-HHMM=>0"
#    Then Update details
#      | Load Number |
#      | SysData=>Load_CurrentDateTime  |
    Then Enter Label "Load Number" Text as "SysData=>Load_CurrentDateTime"
    Then Wait for "1" Seconds
    Then Scroll into Section "Shipment IDs"
    Then Update details
      | PRO Number |PO Number|
      | 100001     |200002     |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Wait for "PRO Number" Field Value Update with "100001"
    Then Verify Details
      | PRO Number |
      | 100001  |

    #Step 11
    Then Go to "Quotes/Invoices" Tab
    Then Click on Edit icon on Label "Accounting Notes"
    Then Enter Label "Accounting Notes" TextArea as "TEST NOTE"
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Verify Details
      |Accounting Notes|
      |TEST NOTE       |

    #Step 12
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier Two - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "2000"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "200"
    Then Enter "Carrier Quote Items" "Hazardous Material Handling" as "50"
    Then Wait for "2" Seconds
    Then Add "Load" "Carrier Quote Items" "Blind Shipments" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "0"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Store Carrier Quote value on "Carrier_Quote"

    #Step 13
    Then Click on Carrier Quote from FQA Page
    Then Wait for "2" Seconds

    #Step 14
    Then Set Key "Carrier_Quote_SFID" page Record Id with "rtms__CarrierQuote__c"
    Then Capture the current URL for "Carrier_Quote_Page"
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "1" Times
    Then Click on link "Carrier Quote Accessorials"
    Then Wait for "1" Seconds
    Then Click on "Hazardous Material Handling" with Text
    Then Wait for "2" Seconds

    #Step 15
    Then Set Key "Hazardous_Carrier_Quote_Accessorial_SFID" page Record Id with "rtms__CarrierQuoteAccessorial__c"

    #Then 16 & 17
    Then Navigate Browser Back
    Then Wait for "1" Seconds
    Then Click on "Blind Shipments" with Text
    Then Wait for "2" Seconds
    Then Set Key "Blind_Shipments_Carrier_Quote_Accessorial_SFID" page Record Id with "rtms__CarrierQuoteAccessorial__c"

#    Step 18
    Then Navigate to stored URL for "Load_1"


#   Step 19
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Get Details
      |Bill of Lading Number|
      |                     |
    Then Go to "Shipment" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Philadelphia Eagles"
    Then Load Summary - Click on "2D" "Philadelphia Eagles" Text
    Then Wait for "2" Seconds

    #Step 20
    Then Set Key "Stop2_SFID" page Record Id with "rtms__Stop__c"
    Then Navigate to stored URL for "Load_1"

    #Step 21
    Then Scroll into Section "Joliet Jazz Supplies"
    Then Expand "Items" for "1" Load
    Then Click on "Item 1" with Text
    Then Wait for "1" Seconds
    Then Switch Window by index "1"
    Then Wait for "2" Seconds
    #Step 22
    Then Set Key "Item1_SFID" page Record Id with "rtms__LineItem__c"
    Then Close Current Tab
    Then Switch to Parent Window
    Then Wait for "1" Seconds

    #Step 23
    Then Load Summary - Click on "1P" "Joliet Jazz Supplies" Text
    Then Wait for "2" Seconds

      #Step 24
    Then Set Key "Stop1_SFID" page Record Id with "rtms__Stop__c"

    #Step 25
    Then Set key "Joliet_Jazz_Supplies_AccountID" for Object "Account" and Name "Joliet Jazz Supplies"

    #Step 26 & 27
    Then Triumphpay - Get Load details for "SysData=>Load_CurrentDateTime" with Authorization of "Hubtran_Password_2"
    Then Get Attribute "load.id" and store into "TriumphPayID" from "Triumphpay_API_Response"
    Then Get Attribute "load.tms_created_at" and store into "tms_created_at" from "Triumphpay_API_Response"
    Then Get Attribute "load.tms_updated_at" and store into "tms_updated_at" from "Triumphpay_API_Response"
    Then TimeZone Specific - Verify Json "Triumphpay_API_Response" with File "Triumphpay_Response.json"
      |{load_id}                    |{external_id}         |{Carrier_external_id} |{Joliet_External_Id}                    |{Stop_1_Id}        |{Stop_2_Id}         |{Line_Item_Id}     |{Carrier_Quote_Id}    |{Carrier_Quote_SFId}|{Blind_Shipment_SFID}                                         |{Hazardous_SFID}                                 |{Bill_of_Lading_Number}       |{CurrentDate}|{CurrentDate+1}|{CurrentDate+3}|{CurrentDate+4}|{TriumphPayID}       |{tms_created_at}       |{tms_updated_at}|
      |SysData=>Load_CurrentDateTime|SysData=>1LRI|SysData=>ECT_AccountID|SysData=>Joliet_Jazz_Supplies_AccountID|SysData=>Stop1_SFID|SysData=>Stop2_SFID |SysData=>Item1_SFID|SysData=>Carrier_Quote|SysData=>Carrier_Quote_SFID|SysData=>Blind_Shipments_Carrier_Quote_Accessorial_SFID|SysData=>Hazardous_Carrier_Quote_Accessorial_SFID|SysData=>Bill of Lading Number|0            |1              |3              |4              |SysData=>TriumphPayID|SysData=>tms_created_at|SysData=>tms_updated_at|