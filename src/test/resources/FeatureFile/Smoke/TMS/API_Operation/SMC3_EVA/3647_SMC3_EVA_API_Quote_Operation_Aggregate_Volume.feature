Feature: 3647 - SMC3 EVA API- Quote Operation: Aggregate (Volume)


  @API @TMS @Smoke @WEB @API_Operation @SingleCurrency @3647 @SMC3 @Debugging
  Scenario: 3647 - SMC3 EVA API- Quote Operation: Aggregate (Volume)

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


    # Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "SMC3 EVA Customer Aggregate" from List
    Then Wait for "3" Seconds
    Then Go to "Rates" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA - Dynamic"
    Then Wait for "3" Seconds
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
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA"
    Then Wait for "3" Seconds
    Then Update details
      | Status  |
      | Pending |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_2"

    #Step 4
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "SMC3 EVA Customer Aggregate" from List
    Then Wait for "3" Seconds
    Then Go to "Rates" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Carrier Rate Entries"
    Then Open Carrier Rate Entry for "SMC3 EVA Carrier - SMC3 EVA - VLTL"
    Then Wait for "3" Seconds
    Then Update details
      | Payment Terms | Payer    | Bill To                       | Bill To Override |
      | --None--      | --None-- | Canada Border Services Agency | QA Rocks!*&      |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Capture the current URL for "Rate_Entry_3"

    # Step 5
    Then Open "TMS Admin" from App Launcher
    Then Go to "Document Options" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Link" Link Text "Global Defaults" on Page -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Payment Terms | Payer       |
      | Collect       | Third Party |
    Then Scroll Up with "2" Times
    Then Click on Button with Value "Save" -
    Then Verify Message displaying with "Save was successful"
    Then Switch to Parent Frame
    Then Capture the current URL for "Document_Option"


     #Step 6 to 8
    Then Wait for "2" Seconds
    Given Upload File "SMC3EVAQuoteOperation- Aggregate Volume 3647 USD.json" with Title "SMC3EVAQuoteOperation"
    Then Wait for "30" Seconds

    #  Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer                    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer Aggregate | LTL  | Reefer 53'     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 1             | NA                       | NA               | NA                   |


    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 4             | NA                       | NA               | NA                   |
    Then Update details
      | Residential Delivery |
      | True                 |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1500   | NA           | 1        | Pallets        | 24     | 48    | 48     | NA             | 50         |

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
      | HazMat Contact           |
      | Joe Joliet Jazz Supplies |
    Then Scroll into Section "Load Accessorials"
    And Update details
      | Collect On Delivery |
      | true                |
    #Step 10
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"


    # Step 10
    Then Go to "Details" Tab

    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Weight Units"
    Then Update details
      | Weight Units |
      | kg           |
    Then Scroll into Section "Import/Export Information"
    Then Update details
      | COD Amount |
      | 200.25     |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | COD Amount |
      | 200.25     |

    # Step 11
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "60" Seconds
    # Expected Result a
    Then Verify Text displaying as "View Quotes (1)"

    #Step 11 a)
    Then "Capture" and Close all the Toast messages from Bottom

    #Step 12
    Then Get Attribute "subRequests[0].headers[0].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[1].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[2].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[3].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[4].value" from "Logging" "Request"
    Then Get Attribute "subRequests[0].headers[5].value" from "Logging" "Request"

    And Update and verify payload for "Logging" with "3647_Expected_Result.json"
      | {CurrentDateYYYYMMDD+1} | subRequests[0].headers[0].value | subRequests[0].headers[1].value | subRequests[0].headers[2].value | subRequests[0].headers[3].value | subRequests[0].headers[4].value | subRequests[0].headers[5].value |
      | 1                       | Transactional                   | Transactional                   | Transactional                   | Transactional                   | Transactional                   | Transactional                   |

    #Step 13
    Then Click on Carrier Quote from FQA Page
    Then Wait for "5" Seconds
    Then Go to "Details" Tab

    #Expected Result C
    Then Verify Details
      | Carrier Account Number | Rate Type  | External Quote Id            | Payer       | Payment Terms | Bill To                       | Bill To Override | Expiration Date   | Freight Charges | Discount   | Discount Percent | Net Freight Charges | Fuel Surcharge |
      | 0123456789             | QA is Cool | 1e3fd414-7f96-4fd0-942a-5678 | Third Party | Collect       | Canada Border Services Agency | QA Rocks!*&      | 1/7/2022, 5:59 PM | USD 1,686.00    | USD 416.43 | 24.70%           | USD 1,269.57        | USD 102.06     |
    Then Scroll into Section "Pricing Summary"
    Then Verify Details
      | Accessorial Charges | Deficit Weight | Deficit Charge | Carrier Total | Deficit Rate | Service Class | Estimated Transit Time (Days) | Direct/Interline | Estimated Pickup Date | Estimated Delivery Date |
      | USD 65.23           | 101            | USD 75.00      | USD 1,436.86  | USD 50.00    | TD_PM         | 6                             | Direct           | 1/5/2026              | 2/18/2026               |
    Then Scroll into Section "Contract Information"
    Then Verify Details
      | Effective Date | Carrier Quote Reference | Billable Weight |
      | 10/12/2021     | 903647                  | NA              |
    Then Verify Details
      | Origin Terminal Location                          |
      | 789 origin terminal way, Louisville, KY 40213 USA |
    Then Verify Details
      | Origin Terminal Phone | Origin Terminal Email | Origin Terminal Code | Origin Movement Type |
      |                       | qa@revenova.com       | ABCD3624             | Interline            |
    Then Verify Details
      | Destination Terminal Location                        | Destination Terminal Phone | Destination Terminal Email | Destination Terminal Code | Destination Movement Type |
      | 101 destination terminal way, Calgary, AB T1Y2S2 USA | (523) 321-1234             | NA                         | DCBA34624                 | Partner                   |

    #Step 15
    Then Scroll Up with "5" Times
    Then Go to "Related" Tab on Next to "Documents Status" Tab
    Then Click on link "Carrier Quote Accessorials"
    Then Select Records "Other" from List

    #Expected Result d
    Then Verify details for
      | Accessorial | Code | Charge    | Notes             | Unit       | Quantity | Name  |
      | Other       | NA   | USD 65.23 | Unitemized Amount | Fixed Cost | 1.00     | Other |


















