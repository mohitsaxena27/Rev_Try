Feature: 3624 - SMC3 EVA API- Quote Operation: Aggregate (Dynamic)

  @API @Smoke @TMS @Smoke @WEB @API_Operation @SingleCurrency @3624 @SMC3 @Debugging
  Scenario: 3624 - SMC3 EVA API- Quote Operation: Aggregate (Dynamic)

    When Login into Salesforce

    # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | true            | true                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "SMC3 EVA Customer Aggregate" from List
    Then Wait for "3" Seconds
    Then Go to "Rates" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA"
    Then Wait for "5" Seconds
    Then Update details
      | Status  |
      | Pending |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_1"

    #Step 3
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "SMC3 EVA Customer Aggregate" from List
    Then Wait for "3" Seconds
    Then Go to "Rates" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA - VLTL"
    Then Wait for "3" Seconds
    Then Update details
      | Status  |
      | Pending |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_2"

    #Step 4 to 6
#    Given Upload File "SMC3EVAQuoteOperation- Aggregate Dynamic 3624 CAD.json" with Title "SMC3EVAQuoteOperation"
    Given Upload File "SMC3EVAQuoteOperation_Aggregate_Dynamic_3624_CAD_Response.json" with Title "SMC3EVAQuoteOperation"


    #Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer                    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer Aggregate | LTL  | Reefer 53'     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 0             | NA                       | 1200-1245        | NA                   |
    Then Update details
      | Exhibition/Trade Show Pick Up |
      | True                          |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | NA               | True                 |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 15000  | NA           | 1        | Pallets        | 24     | 48    | 48     | NA             | 50         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 1 | Stop 2   | Bananas     | 2000   | kg           | 2        | Bunches        | 30     | 60    | 65     | cm             | 92.5       |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 3         | Stop 1 | Stop 2   | Kiwi        | 500    | lbs          | 26       | Pieces         | 3      | 6     | 4      | ft             | 400        |
    Then Update HazMat Details for "3" Line Items
      | HazMat |
      | True   |
    Then Update details
      | HazMat Number Type | HazMat Number |
      | UN                 | 3624          |
    Then Scroll into Section "Load Accessorials"
    And Update details
      | Protect From Freezing |
      | True                  |
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

     # Step 8
    Then Go to "Shipment" Tab
    Then Expand "Items" for "1" Load
    Then Click on "Item 2" with Text
    Then Wait for "1" Seconds
    Then Switch Window by index "1"
    Then Wait for "2" Seconds
    Then Scroll into Section "Handling Unit Information"
    Then Click on Edit icon with Field Name "Stackable"

    Then Update details
      | Stackable |
      | true      |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Switch to Parent Window

    # Step 9
    Then Go to "Freight Quote Assistant" Tab

    # Expected Result a
    Then  Verify Text displaying as "View Quotes (1)"

    #Step 10
    Then "Capture" and Close all the Toast messages from Bottom

    #Expected Result b

    Then Get Attribute "subRequests[0].headers[0].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[1].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[2].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[3].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[4].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[5].value" from "Logging" "Request"

    And Update and verify payload for "Logging" with "3624_Expected_result_b.json"
      | {LoadNumber} | {CurrentDateYYYYMMDD} | subRequests[0].headers[0].value | subRequests[0].headers[1].value | subRequests[0].headers[2].value | subRequests[0].headers[3].value | subRequests[0].headers[4].value | subRequests[0].headers[5].value |
      | SysData=>1L  | 0                     | Transactional                   | Transactional                   | Transactional                   | Transactional                   | Transactional                   | Transactional                   |

    #Step 11 and 12
    Then Go to "Freight Quote Assistant" Tab
    Then Click on Carrier Quote from FQA Page
    Then Wait for "5" Seconds
    Then Go to "Details" Tab

    #Expected Result C
    Then Verify Details
      | Carrier Account Number | Rate Type  | External Quote Id                    | Payer   | Payment Terms | Bill To     | Bill To Override | Expiration Date   | Freight Charges             | Discount                | Discount Percent | Net Freight Charges       | Fuel Surcharge         |
      | 0123456789             | CLASS 3624 | 4e3fd414-7f96-4fd0-942a-dc93837a2b69 | Shipper | Prepaid       | Revenova HQ | NA               | 1/7/2022, 5:59 PM | CAD 1,686.00 (USD 1,258.21) | CAD 416.43 (USD 310.77) | 24.70%           | CAD 1,269.57 (USD 947.44) | CAD 102.06 (USD 76.16) |
    Then Scroll into Section "Pricing Summary"
    Then Verify Details
      | Accessorial Charges     | Deficit Weight | Deficit Charge      | Carrier Total               | Deficit Rate | Service Class | Estimated Transit Time (Days) | Direct/Interline | Estimated Pickup Date | Estimated Delivery Date |
      | CAD 540.99 (USD 403.72) | NA             | CAD 0.00 (USD 0.00) | CAD 1,912.62 (USD 1,427.33) | NA           | GTD_AM_3624   | 3                             | Direct           | 1/5/2026              | 1/8/2026                |
    Then Scroll into Section "Contract Information"
    Then Verify Details
      | Effective Date | Carrier Quote Reference | Billable Weight |
      | 10/12/2021     | 903624                  | 3,624.00        |
    Then Verify Details
      | Origin Terminal Location                          |
      | 789 origin terminal way, Louisville, KY 40213 USA |
    Then Verify Details
      | Origin Terminal Phone | Origin Terminal Email | Origin Terminal Code | Origin Movement Type |
      | (123) 321-9987        | qa@revenova.com       | ABCD3624             | Interline            |
    Then Verify Details
      | Destination Terminal Location                        | Destination Terminal Phone | Destination Terminal Email | Destination Terminal Code | Destination Movement Type |
      | 101 destination terminal way, Calgary, AB T1Y2S2 USA | (523) 321-1234             | qaeva@gmail.com            | DCBA3624                  | Partner                   |

    # Step 13
    Then Scroll Up with "5" Times
    Then Go to "Related" Tab on Next to "Documents Status" Tab
    Then Click on link "Carrier Quote Accessorials"
    Then Select Records "Guaranteed" from List

    # Expected Result e
    Then Verify details for
      | Accessorial | Code | Charge                  | Unit       | Quantity | Name       |
      | Guaranteed  | GTD  | CAD 180.33 (USD 134.57) | Fixed Cost | 1.00     | Guaranteed |

    # Step 14
    Then Navigate Browser Back
    Then Select Records "3624 Description" from List

    # Expected Result e
    Then Verify details for
      | Accessorial | Code | Charge                  | Unit       | Quantity | Name             |
      | Other       | 3624 | CAD 180.33 (USD 134.57) | Fixed Cost | 1.00     | 3624 Description |

    # Step 15
    Then Navigate Browser Back
    Then Select Records "Collect On Delivery" from List

    #Expected Result e
    Then Verify details for
      | Accessorial         | Code | Charge                  | Unit       | Quantity | Name                |
      | Collect On Delivery | COD  | CAD 180.33 (USD 134.57) | Fixed Cost | 1.00     | Collect On Delivery |