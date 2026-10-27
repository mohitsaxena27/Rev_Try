Feature: 2704 - DAT API- Post Load Operation: Update

  @API @Regression @TMS @Smoke @WEB @SingleCurrency @Load_Posting_And_Tracking @2704 @DATAPI @Debugging
  Scenario: 2704 - DAT API- Post Load Operation: Update

    When Login into Salesforce

    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | true            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame


    #Step2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Click on "User User" with Text
    Then Update checkbox "Enabled" as "false" for "DAT" credential card
    Then Update checkbox "Enabled" as "true" for "DAT 2" credential card
    Then Update details
      | Preferred Contact Method |
      | Primary Phone            |
    And Click on Native "Save" button
    And Wait for "2" Seconds
    #Step2 b
    Then Go to "Global Services" Tab
    Then Search text "DAT 2" in the "Search Credentials..." search box
    Then Select the "DAT 2" record from the lookup field results
    Then Update details
      | Enabled |
      | true    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds


    #Step3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 48     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Same_as_Customer | NA    | 0             | NA                       | 0830-1200        | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | Account_Address | Chicago Pizza | 1             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | Y       | 3D   | City_State_PC   | Des Moines,IA,50301,US | 2             | NA               | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | GeoLocation  | 38.521860, -104.523780 |  3             | NA                       | 1445               | NA                   |

        Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 3   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp| Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 2| Stop 4   | Grapes      | 8000   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

    #Step4
    Then Wait for "3" Seconds
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate | Offer Rate Type | Load Posting Description |
      | 1          | Fixed Cost      | testing                  |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step5
    Then Select the + action next to the "DAT" integration listing
    Then Verify Message displaying with Text "DAT 2: This load was successfully posted."
    Then "Capture" and Close all the Toast messages from Bottom

    #Step6
    Then Get Attribute "id" from "loads" "Response"

    #Step7
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Click on "User User" with Text
    Then Wait for "4" Seconds
    Then Update details
      | Preferred Contact Method |
      | Email            |
    And Click on Native "Save" button
    And Wait for "2" Seconds

    #Step 8
    Then Navigate to stored URL for "Load_Details"
    Then "Without Capture" and Close all the Toast messages from Bottom
#    Then Open "Loads" from App Launcher
#    Then Open Load Number "L-21"
    #Step 9
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "1P" "Expected Date"
    Then Update details
        |Expected Date|Shipping/Receiving Hours|
        |2            |1200-1300               |

    Then Click on "Save" Button with Type "submit"
    Then Wait for "4" Seconds
    Then Collapse "Details" for "1" Load

    #Step 10
    Then Expand "Details" for "4" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "4D" "Expected Date"
    Then Update details
      |Expected Date|Shipping/Receiving Hours|
      |7            |2000-2200               |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Collapse "Details" for "1" Load

    #Step 11
    Then Wait for "2" Seconds
    Then Click on button with Title "Refresh Route"
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Verify Message "Load route and map were updated." displaying stored during enabled logging

    #Step 12
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Total Weight"
    Then Update details
      | Total Weight |
      | 15000   |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Total Weight" Field Value Update with "15,000"
    Then Verify Details
      |Total Weight      |
      |15,000 |

       #Step 13
    Then Get Details
      |Distance (Miles)|
      |                |
    Then Wait for "4" Seconds

    #Step 14 & 15
    Then Scroll into Section "Load Postings (1)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate    | Offer Rate Type    | Load Posting Description |Full Truckload|Truck Length|
      | 1.50          | Rate per Mile      | THIS IS A TEST           |False|53                   |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom


    #step 16
    Then Wait for "2" Seconds
    Then Click on Title button "Update" is displaying with Object "rtms-loadposting_loadposting"
    #Expected a
    Then Verify Message displaying with Text "DAT 2: This load was successfully re-posted."
    Then "Capture" and Close all the Toast messages from Bottom
     #Step 17 & Expected b
    And Set "loadOfferRateUsd" as "SysData=>Distance (Miles)" into 1.5
    And Update and verify payload for "SysData=>id" with "TC2704_RequestBody_Expected.json"
      | Load_Number |{CurrentDate+2}|{CurrentDateWithSlash+2}|{CurrentDateWithSlash+7}|loadOfferRateUsd|
      | SysData=>1L |2              |2                       |7                       |UpdateData=>loadOfferRateUsd|
     #Step 18 & #Expected c
    Then Verify url displaying with "SysData=>id" as "https://freight.api.staging.dat.com/posting/v2/loads/{SysData=>id}"
