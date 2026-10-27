Feature: 3667 - SMC3 EVA API- Quote Operation: Broker

  @API @TMS @Smoke @WEB @API_Operation @SingleCurrency @3667 @SMC3EVAAPI @Debugging
  Scenario: 3667 - SMC3 EVA API- Quote Operation: Broker

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
    Then Search and Select "rtms__TransportationProfile__c" "SMC3 EVA Customer Broker" from the Global search
    Then Wait for "2" Seconds
    Then Go to "Rates" Tab
    Then Capture the current URL for "TP_Page"
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA - Broker"
    Then Update details
      | Carrier Account Number | Payment Terms |
      | 3667                   | --None--      |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_1"

    #step 3
    Then Navigate to stored URL for "TP_Page"
    Then Go to "Rates" Tab
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "Jersey Express Lines - SMC3 EVA"
    Then Update details
      | Payment Terms |
      | --None--      |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_2"

    #step 4
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

    # Step 5
    Then Open "TMS Admin" from App Launcher
    Then Go to "Accessorials" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Limited Access Pick Up" with Text -
    Then Switch to Parent Frame
    Then Go to "Related" Tab
    Then Click on "LTDAP" link under "Related" tab

    Then Scroll into Section "General Information"
    Then Click on Edit icon on "Subcode"
    Then Update details
      | Subcode |
      | School  |
    Then Click on "SaveEdit" button
    Then Capture the current URL for "API_Accessorial"

    # Step 6 & 7 & 8
    Given Upload File "SMC3EVAQuoteOperation_Broker_3667_MXN_Response.json" with Title "SMC3EVAQuoteOperation"

    # Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer                 | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer Broker | LTL  | NA             | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | 0800-0915        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1500   | NA           | 1        | Pallets        | 24     | 48    | 48     | NA             | 50         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 1 | Stop 2   | Bananas     | 2000   | kg           | 2        | Bunches        | 30     | 60    | 65     | cm             | 92.5       |
    Then Update details
      | HazMat_2 |
      | True     |
    Then Wait for "3" Seconds
    Then Update details
      | HazMat Number Type | HazMat Number | HazMat Class/Division | HazMat Packaging Group |
      | --None--           |               | --None--              | --None--               |
    Then Scroll into Section "Load Accessorials"
    And Update details
      | Collect On Delivery |
      | true                |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 10
    Then Go to "Details" Tab
    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on "Customer Portal Threshold Surpassed"
    Then Update details
      | PO Number |
      | 3667      |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | PO Number |
      | 3667      |

    #Step 11
    Then Go to "Shipment" Tab
    Then Expand "Items" for "1" Load
    Then Click on "Item 1" with Text
    Then Wait for "2" Seconds
    Then Switch Window by index "1"
    Then Scroll into Section "Commodity Information"
    Then Click on Edit icon on "Item Description"
    Then Update details
      | NMFC Number |
      | 3667        |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | NMFC Number |
      | 3667        |

    # Step 12
    Then Close Current Tab
    Then Switch to Parent Window

    # Step 13
    Then Go to "Freight Quote Assistant" Tab
    And "Capture" and Close all the Toast messages from Bottom

    #Expected a
    Then  Verify Text displaying as "View Quotes (1)"
    # Step 14 & Expected b
  #  Then Verify url displaying with "Logging" as "https://qa.revenova.com:8083/proxyv1/pricing/broker/v1/app/SMCA"
    Then Verify url displaying with "SMCA" as "https://qa.revenova.com:8083/proxyv1/pricing/broker/v1/app/SMCA"

    # Step 15 & Expected c
    And Update and verify payload for "SMCA" with "3667_Request.json"
      | CurrentDateYYYYMMDD |
      | 0                   |

    Then Go to "Freight Quote Assistant" Tab

    # Step 16
    Then Click on "Carrier Quote" header link under "Carrier Quotes" tab
Then Verify Quote Banner Details
    |Book It|
    |false  |
    # Step 17
    Then Go to "Details" Tab on Next to "Pricing" Tab

    # Expected Result d
    Then Scroll into Section with Title "General Information"
    Then Verify Details
      | Carrier Service                 | Vendor           | Carrier Account Number | Rate Type | External Quote Id | Payer   | Payment Terms | Bill To | Bill To Override | Expiration Date   |
      | Jersey Express Lines - SMC3 EVA | SMC3 EVA Carrier | 0123456789             | CLASS     | 3667-3667         | Shipper | Third Party   | NA      | NA               | 1/6/2026, 5:59 PM |

    Then Scroll into Section with Title "Pricing Summary"
    Then Verify Details
      | Freight Charges            | Discount                   | Discount Percent | Net Freight Charges      | Fuel Surcharge         | Accessorial Charges  | Deficit Weight | Deficit Charge       | Carrier Total            | Deficit Rate         |
      | MXN 14,221.02 (USD 757.24) | MXN 12,983.79 (USD 691.36) | 91.30%           | MXN 1,237.23 (USD 65.88) | MXN 533.49 (USD 28.41) | MXN 54.99 (USD 2.93) | 15             | MXN 93.32 (USD 4.97) | MXN 1,825.71 (USD 97.22) | MXN 14.99 (USD 0.80) |

    Then Scroll into Section with Title "Service Information"
    Then Verify Details
      | Service Class  | Direct/Interline | Estimated Transit Time (Days) | Estimated Pickup Date | Estimated Delivery Date |
      | Indirect Point | Direct           | 3                             | 1/2/2026              | 1/3/2026                |

    Then Scroll into Section with Title "Contract Information"
    Then Verify Details
      | Effective Date | Carrier Quote Reference | Billable Weight |
      | 1/2/2026       | 3667                    | 1,500.00        |

    Then Scroll into Section with Title "Terminal Information"
    Then Verify Details
      | Origin Terminal Location | Origin Terminal Phone | Origin Terminal Email | Origin Terminal Code | Origin Movement Type | Destination Terminal Location | Destination Terminal Phone | Destination Terminal Email | Destination Terminal Code | Destination Movement Type |
      | ATL                      | NA                    | NA                    | NA                   | Unspecified          | STL                           | NA                         | NA                         | NA                        | Unspecified               |

    # Step 18
    Then Go to "Related" Tab on Next to "Documents Status" Tab
    Then Wait for "2" Seconds

    Then Click on link "Carrier Quote Accessorials"
    Then Wait for "1" Seconds
    Then Click on "Hazardous material" with Text

    # Expected e
    Then Wait for "2" Seconds
    Then Scroll into Section "General Information"
    Then Verify Details
      | Accessorial                 | Charge               | Notes | Code | Unit       | Quantity | Name               |
      | Hazardous Material Handling | MXN 45.00 (USD 2.40) | NA    | HAZ  | Fixed Cost | 1.00     | Hazardous material |

    # step 19
    Then Navigate Browser Back
    Then Wait for "1" Seconds
    Then Click on "Other" with Text

    # Expected f
    Then Wait for "2" Seconds
    Then Scroll into Section "General Information"
    Then Verify Details
      | Accessorial | Charge              | Notes             | Code | Unit       | Quantity | Name  |
      | Other       | MXN 9.99 (USD 0.53) | Unitemized Amount | NA   | Fixed Cost | 1.00     | Other |

    # Step 20
    Then Navigate to stored URL for "Load_1"

    # Step 21
    Then Go to "Details" Tab
    Then Scroll into Section "Carrier Requirements"
    Then Click on Edit icon on "Equipment Weight"
    Then Update details
      | Equipment Type |
      | Reefer 53      |
    Then Click on "Save" button
    Then Wait for "2" Seconds

    # Step 22
    Then Go to "Shipment" Tab
    Then Expand "Items" for "2" Load
    Then Click on "Edit" on "2" item
    Then Update details
      | HazMat |
      | false  |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Collapse "Items" for "2" Load

    # Step 23
    Then Expand "Details" for "2" Load
    Then Click on Edit icon with Field Name "2D" "Expected Date"
    Then Update details
      | Expected Date |
      | 3             |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Collapse "Details" for "2" Load

    # Step 24
    Then Click on link "Load Accessorials"
    Then Click on button "New"
    Then Select "All Risk Insurance" from "Accessorials" list and click on "Add to Load >>"
    Then Wait for "2" Seconds
    Then Update the "All Risk Insurance" accessorial data
      | Provider |
      | Carrier  |

    Then Click on link "Load Accessorials"
    Then Verify Text displaying as "All Risk Insurance"
    Then Click on button "New"
    Then Select "Limited Access Pick Up" from "Accessorials" list and click on "Add to Pickup Stop 1 >>"
    Then Wait for "2" Seconds
    Then Update the "Limited Access Pick Up" accessorial data
      | Provider |
      | Carrier  |
    Then Wait for "3" Seconds

    Then Click on link "Load Accessorials"
    Then Verify Text displaying as "Limited Access Pick Up"
    Then Click on "Collect On Delivery" with Text
    Then Click on Native "Delete" button
    Then Click on button with Text "Delete" on Modal
    Then Wait for "2" Seconds
    Then Verify Text not displaying as "Collect On Delivery"

    # Step 25
    Then Navigate to stored URL for "Load_1"
    Then Click If button with Title "More Tabs" is enabled
    Then Go to "Insurance/Claims" Tab
    Then Scroll into Section "All Risk Insurance Policy Information"
    Then Click on Edit icon on "Cargo Value"
    Then Update details
      | Cargo Value | Insurance Amount |
      | 1,000.50    | 1,200.75         |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify details for
      | Cargo Value  | Insurance Amount |
      | USD 1,000.50 | USD 1,200.75     |

    # Step 26
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "6" Seconds
    Then Click on button with Title "Refresh Quotes"
    Then Wait for "1" Seconds
    And "Capture" and Close all messages from Bottom

    # Expected g
    And Update and verify payload for "Logging" with "3667_Expected_g_Request.json"
      | {CurrentDateYYYYMMDD} | {CurrentDateYYYYMMDD+3} |
      | 0                   | 3                       |