Feature: 3660 - SMC3 EVA API- Quote Operation: Aggregate (Contract)

  @API @TMS @Smoke @WEB @API_Operation @SingleCurrency @3660 @SMC3EVAAPI @Debugging
  Scenario: 3660 - SMC3 EVA API- Quote Operation: Aggregate (Contract)

    When Login into Salesforce
    Then Delete Field with Title "SMC3EVAQuoteOperation"
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | True            | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step2
    Then Search and Select "rtms__TransportationProfile__c" "SMC3 EVA Customer Aggregate" from the Global search
    Then Wait for "2" Seconds
    Then Refresh current Page
    Then Go to "Rates" Tab
    Then Capture the current URL for "TP_Page"
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA - Dynamic"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_1"

    #step 3
    Then Navigate to stored URL for "TP_Page"
    Then Go to "Rates" Tab
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA - VLTL"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_2"

    #step 4
    Then Navigate to stored URL for "TP_Page"
    Then Go to "Rates" Tab
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA"
    Then Update details
      | Payment Terms | Bill To                |
      | --None--      | Chewbacca Credit Limit |
    Then Wait for "1" Seconds
    Then Update details
      | Bill To Override |
      |                  |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_3"

    #Step 5
    Then Open "TMS Admin" from App Launcher
    Then Go to "Document Options" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Link" Link Text "Global Defaults" on Page -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Payment Terms |
      | Third Party   |
    Then Click on Button with Value "Save" -
    Then Verify Message displaying with "Save was successful."
    Then Switch to Parent Frame
    Then Capture the current URL for "Document_Option"

    #Step 6 & 7 & 8
    Given Upload File "SMC3EVAQuoteOperation_Aggregate_Contract_3660_USD_Response.json" with Title "SMC3EVAQuoteOperation"

    #Step 9c
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer                    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer Aggregate | LTL  | Reefer 53      | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 4             | NA                       | 0800-0915        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1500   | NA           | 11       | Pallets        | 24     | 48    | 48     | NA             | 125        |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 10
    Then Go to "Freight Quote Assistant" Tab
    #Step 11
    And "Capture" and Close all the Toast messages from Bottom
    #Expected Result a
    Then  Verify Text displaying as "View Quotes (2)"
#    Then Verify Message "2 Web-Based Quote(s) returned." displaying stored during enabled logging
    #Expected b

    Then Get Attribute "subRequests[0].headers[0].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[1].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[2].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[3].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[4].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[5].value" from "Logging" "Request"

    And Update and verify payload for "Logging" with "3660_Request_Updated.json"
      | CurrentDateYYYYMMDD+1 | subRequests[0].headers[0].value | subRequests[0].headers[1].value | subRequests[0].headers[2].value | subRequests[0].headers[3].value | subRequests[0].headers[4].value | subRequests[0].headers[5].value |
      | 1                     | Transactional                   | Transactional                   | Transactional                   | Transactional                   | Transactional                   | Transactional                   |

    #Step 12
    Then Click on View Quotes
    Then Wait for "2" Seconds
     #Expected c
    Then Verify View Quotes for
      | Carrier_Service             | Carrier Total | Estimated_Transit_Time | Accepted | Tender_Hold |
      | SMC3 EVA Carrier - SMC3 EVA | USD 1,977.86  | 6                      | false    | false       |
      | SMC3 EVA Carrier - SMC3 EVA | USD 1,977.90  | 7                      | false    | false       |

    #Step 13
    Then Click on Carrier Quote from FQA Page
    #Step 14
    Then Go to "Details" Tab on Next to "Pricing" Tab
    #Expected d
    Then Verify Details
      | Carrier Account Number | Rate Type | External Quote Id            | Payer   | Payment Terms |
      | 0123456789             |           | 1e3fd414-7f96-4fd0-942a-5678 | Shipper | Third Party   |
    Then Verify Details
      | Bill To                | Bill To Override | Expiration Date   |
      | Chewbacca Credit Limit |                  | 1/7/2022, 5:59 PM |

    Then Scroll into Section "Pricing Summary"
    Then Verify Details
      | Freight Charges | Discount | Discount Percent | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Deficit Weight | Deficit Charge |
      |                 |          |                  | USD 1,977.86        |                |                     | 101            |                |
    Then Verify Details
      | Carrier Total | Deficit Rate | Service Class | Estimated Transit Time (Days) | Direct/Interline |
      | USD 1,977.86  | USD 50.00    | GTD_NOON      | 6                             | Unspecified      |
    Then Verify Details
      | Estimated Pickup Date | Estimated Delivery Date |
      | 1/5/2026              | 2/18/2026               |
    Then Scroll into Section "Contract Information"
    Then Verify Details
      | Effective Date | Carrier Quote Reference | Billable Weight |
      | 10/12/2021     | 903660                  | 3,660.00        |

    Then Verify Details
      | Origin Terminal Location                          | Destination Terminal Location                        |
      | 789 origin terminal way, Louisville, KY 40213 USA | 101 destination terminal way, Calgary, AB T1Y2S2 USA |
    Then Verify Details
      | Origin Terminal Phone | Origin Terminal Email | Origin Terminal Code | Origin Movement Type |
      |                       | qa@revenova.com       | ABCD3624             | Unspecified          |
    Then Verify Details
      | Destination Terminal Phone | Destination Terminal Email | Destination Terminal Code | Destination Movement Type |
      | (523) 321-1234             |                            | DCBA34624                 | Unspecified               |
   #Step 15
    Then Go to "Related" Tab on Next to "Pricing" Tab
    #Expected e
    Then Verify "Carrier Quote Accessorials" count displaying as "0"
