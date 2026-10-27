Feature: 2813 - Truckerstop API - Post Loads Operation: Update

  @Regression @TMS @Smoke @API @WEB @Load_Posting_And_Tracking @SingleCurrency @Truckerstop @28131 @Debugging
  Scenario: 2813 - Truckerstop API - Post Loads Operation: Update

    When Login into Salesforce

    # Step 1
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
    Then Wait for "1" Seconds
    Then Switch to Parent Frame

    # Step 2
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
      | Add_Loc | Type | Address_Type  | Value                  | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3D   | City_State_PC | Des Moines,IA,50301,US | 2             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type | Value                  | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | GeoLocation  | 38.521860, -104.523780 | 3             | NA                       | 1445             | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                      | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 - Boston Beans 526 Beacon Street, Boston MA 02215 US | Stop 3   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                         | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 2 - Chicago Pizza 181 W. Madison St., Chicago IL 60602 US | Stop 4   | Grapes      | 8000   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"
    Then "Without Capture" and Close all the Toast messages from Bottom

    # Step 3
    Then Scroll into Section "Load Postings (0)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate | Offer Rate Type | Load Posting Description |
      | 1          | Fixed Cost      | testing                  |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    # Step 4
    Then Select the + action next to the "Truckstop 2" integration listing
    Then Verify Message displaying with Text "Truckstop 2: This load was successfully posted."
    Then "Capture" and Close all the Toast messages from Bottom

    # Step 5
    Then Get Attribute "loadId" from "load" "Response"

    # Step 6
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "1P" "Location"
    Then Update Location as "Indianapolis Colts"
    Then Update details
      | Appointment Time |
      | 0700-1100        |

    Then Click on "Save" Button with Type "submit"
    Then Wait for "4" Seconds
    Then Collapse "Details" for "1" Load

    # Step 7
    Then Wait for "2" Seconds
    Then Click on button with Title "Refresh Route"
    Then "Without Capture" and Close all the Toast messages from Bottom

    # Step 8
    Then Get "Distance (Miles)" from "rtms-loadbanner_loadbanner"

    # Step 9
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Total Weight"
    Then Update details
      | Total Weight |
      | 15000        |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Total Weight" Field Value Update with "15,000"

    # Step 10
    Then Scroll into Section "Load Postings (1)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate | Offer Rate Type | Full Truckload | Truck Length |
      | 1.50       | Rate per Mile   | False          | 53           |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    # Step11
    Then Select Mode Picklist as "Van or Reefer" & Book it Now Option as "False" for "Truckstop 2"

    # Step 12
    Then Click on Title button "Update" is displaying with Object "rtms-loadposting_loadposting"

    # Expected a
    Then "Capture" and Close all the Toast messages from Bottom
    Then Verify Message "Truckstop 2: This load was successfully re-posted." displaying stored during enabled logging

    # Expected b
    Then "Multiply" "SysData=>Distance (Miles)" value with "1.5" and store in "Amount"
    And Update and verify payload for "SysData=>loadId" with "TC2813_Requestbody_Expected_b.json"
      | LoadNum     | amt             | {CurrentDate} | {CurrentDate+1} |
      | SysData=>1L | SysData=>Amount | 0             | 1               |

    Then Get Attribute "loadId" from "load" "Response"
    Then Verify url displaying with "SysData=>loadId" as "https://api-int.truckstop.com/loadmanagement/v2/load/{SysData=>loadId}"