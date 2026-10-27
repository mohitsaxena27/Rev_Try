Feature: 2877 - Carrier Guest LWC - RFQ Load Board Functionality

  @Regression @Priority_1 @WEB @Carrier @Headed @Carrier_Guest @2877
  Scenario: 2877 - Carrier Guest LWC - RFQ Load Board Functionality

    When Login into Salesforce
    #Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Email Carrier Three" from List
    Then Go to "Settings" Tab
    Then Scroll into Section "Load Postings"
    Then Click on Edit icon on Label "Enable RFQ Load Board"
    Then Wait for "2" Seconds
    Then Update details -
      | Enable RFQ Load Board |
      | true                  |
    Then Click on "Save" button
    Then Wait for "1" Seconds
    Then Capture the current URL for "TP_Page"

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Denver Deli Meats | Truckload | Dry Van 53'    | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2D   | Account_Address | Chicago Cubs | 3             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Account_Address | Chicago Bears | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Material    | 33000  | NA           | NA       | NA             |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P1     | D3       | Paper       | 2000   | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_1L"
    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier Three - Truckload"
    Then "Tender" Carrier
    Then Wait for "2" Seconds

    #Step 4
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds

    #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Denver Deli Meats | Truckload | Dry Van 53'    | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bears | 4             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 6             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Material    | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_2L"

    #Step 6
    Then Go to "Details" Tab
    Then Click on Edit icon with Field Name "Load Status"
    Then Wait for "2" Seconds
    Then Update details
      | Load Status |
      | Assigned    |
    Then Scroll into Section "Carrier Sales Information"
    Then Wait for "1" Seconds
    Then Update details
      | Carrier Portal |
      | true           |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Chicago Pizza | Truckload | Dry Van 48'    | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Account_Address | Chicago Bears | 4             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | Account_Address | Chicago Cubs | 5             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value          | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Account_Address | Denver Broncos | 7             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D3       | Material    | 20000  | NA           | NA       | NA             |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P2     | D3       | Paper       | 20000  | NA           | 10       | Pallets        |
    Then Save Load With All details
    Then Capture the current URL for "Load_3L"
    #Step 8
    Then Go to "Details" Tab
    Then Scroll into Section "Carrier Sales Information"
    Then Click on Edit icon on Label "Carrier Portal"
    Then Update details
      | Carrier Portal | Offer Rate | Offer Rate Type |
      | true           | 1800       | Fixed Cost      |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 4L       | Revenova HQ | LTL  | NA             | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type  | Value                   | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | City_State_PC | Lake Forest,IL,60045,US | 4             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1500   | NA           | 2        | Pallets        | 48     | 48    | 48     | NA             | 50         |
    Then Save Load With All details
    Then Capture the current URL for "Load_4L"
    #Step 10
    Then Go to "Details" Tab
    Then Scroll into Section "Carrier Sales Information"
    Then Click on Edit icon on Label "Carrier Portal"
    Then Update details
      | Carrier Portal | Offer Rate | Offer Rate Type |
      | true           | 1.25       | Rate per Mile   |
    Then Wait for "1" Seconds
    Then Scroll into Section "Load Summary"
    Then Update details
      | Currency |
      | CAD - Canadian Dollar |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 11
    Then Set "Email_Subject" with "Load Tender for SysData=>1L"
    Then Wait for Email to Receive On Email
    Then Get "Accept Quote" link from Email for Subject "SysData=>Email_Subject"
    Then Launch browser and Navigate Link
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds
    Then Guest - Click on button with Text "Accept"
    Then Wait for "2" Seconds
    Then Guest - Verify Text displaying as "Carrier Load Confirm Accept Message"

    #Step 12
    Then Guest - Update details
      | Ship Date |
      | NA        |
    Then Guest - Click on button with Text "Search"
    Then Wait for "2" Seconds
    #Expected Result a
    Then Guest - Verify Text displaying as "Complete this field with format Dec 31, 2024."
    Then Guest - Verify text "Complete this field with format Dec 31, 2024." color is "Red"
    Then Guest - Verify no load result radio buttons are displayed
    Then Guest - Verify text "SysData=>2L" not displaying on Page -
    Then Guest - Verify text "SysData=>3L" not displaying on Page -
    Then Guest - Verify text "SysData=>4L" not displaying on Page -

    #Step 13
    Then Guest - Enter Label "City" Text as "Chicago, IL"
    Then Wait for "1" Seconds
    Then Guest - Enter Label "Distance" Text as "200"
    Then Wait for "1" Seconds
    Then Guest - Click on button with Text "mi"
    Then Wait for "1" Seconds
    Then Guest - Click on button with Text "km"
    Then Wait for "1" Seconds
    Then Guest - Enter Label "Postal Code" Text as "80024"
    Then Wait for "1" Seconds
    Then Guest - Update details
      | Ship Date | Delivery Date |
      | -4        | 0             |
    Then Wait for "1" Seconds
    Then Guest - Update details
      | Truckload | LTL  | Flatbed |
      | False     | True | True    |
    Then Wait for "1" Seconds
    Then Guest - Enter Label "Max Weight" Text as "10000"
    Then Wait for "1" Seconds
    Then Guest - Update details
      | Weight Units |
      | kg           |
    Then Wait for "2" Seconds

    #Step 14
    Then Guest - Click on button with Text "Reset"
    Then Wait for "3" Seconds
    Then Guest - Verify RFQ filter values
      | Pickup Country | Pickup City | Pickup State/Province | Pickup Postal Code | Pickup Search Type | Pickup Distance | Pickup Units | Dropoff Country | Dropoff City | Dropoff State/Province | Dropoff Postal Code | Dropoff Search Type | Ship Date | Delivery Date | Max Weight | Weight Units |
      | US             | Lake Forest | IL                   | 60045              | Radius             | 100             | mi           | US              | NA           | NA                    | NA                  | Country              | 3         | NA            | NA         | lbs          |
    Then Guest - Verify RFQ empty fields have no placeholder
      | Dropoff City | Dropoff State/Province | Dropoff Postal Code |
      | NA           | NA                     | NA                  |
    Then Guest - Verify RFQ mode states
      | Truckload | LTL   | Flatbed |
      | true      | false | false  |
    Then Guest - Verify Matching Loads row count is "0"
    Then Guest - Verify text "SysData=>2L" not displaying on Page -
    Then Guest - Verify text "SysData=>3L" not displaying on Page -
    Then Guest - Verify text "SysData=>4L" not displaying on Page -

    #Step 15
    Then Guest - Update details
      | Ship Date |
      | 4         |
    Then Guest - Click RFQ Search Button
    Then Wait for "3" Seconds

    #Expected Result c
    Then Guest - Scroll to Matching Loads
    Then Guest - Verify text "SysData=>2L" not displaying on Page -
    Then Guest - Verify text "SysData=>4L" not displaying on Page -
    Then Guest - Verify matching load row
      | Load Number | Radio Selected | Rate          | Rate Type  | Equipment  | Ship Date | Delivery Date | Weight |
      | SysData=>3L | false          | USD 1800.00  | Fixed Cost | Dry Van 48 | 4         | 7             | 40000 |

    #Step 16
    Then Guest - Update details
      | LTL  |
      | True |
    Then Guest - Click RFQ Search Button
    Then Wait for "3" Seconds
    Then Guest - Scroll to Matching Loads
    #Expected Result d
    Then Guest - Verify matching load row
      | Load Number | Radio Selected | Rate          | Rate Type    | Equipment  | Ship Date | Delivery Date | Weight |
      | SysData=>3L | false          | USD 1800.00  | Fixed Cost   | Dry Van 48 | 4         | 7             | 40000 |
    Then Guest - Verify matching load row
      | Load Number | Radio Selected | Rate       | Rate Type    | Equipment | Ship Date | Delivery Date | Weight |
      | SysData=>4L | false          | CAD 1.25   | Rate per Mile | NA        | 4         | NA            | 1500 |
    Then Guest - Verify text "SysData=>2L" not displaying on Page -
    Then Guest - Verify load result radio buttons are not selected

    #Step 17
    Then Guest - Enter Label "Max Weight" Text as "1300"
    Then Wait for "1" Seconds
    Then Guest - Update details
      | Weight Units |
      | kg           |
    Then Guest - Click RFQ Search Button
    Then Wait for "3" Seconds
    Then Guest - Scroll to Matching Loads
    #Expected Result e
    Then Guest - Verify text "SysData=>2L" not displaying on Page -
    Then Guest - Verify text "SysData=>3L" not displaying on Page -
    Then Guest - Verify matching load row
      | Load Number | Radio Selected | Rate     | Rate Type    | Equipment | Ship Date | Delivery Date | Weight |
      | SysData=>4L | false          | CAD 1.25 | Rate per Mile | NA        | 4         | NA            | 1500 |

    #Step 18
    Then Guest - Click on button with Text "Reset"
    Then Wait for "2" Seconds
    Then Guest - Update RFQ details
      | Pickup Search Type |
      | Country            |
    Then Wait for "1" Seconds
    Then Guest - Update RFQ details
      | Dropoff Postal Code |
      | 80204               |
    Then Wait for "1" Seconds
    Then Guest - Update details
      | Ship Date |
      | 4         |
    Then Wait for "1" Seconds
    Then Guest - Update details
      | Truckload | LTL  |
      | False     | True |
    Then Wait for "2" Seconds

    #Step 19
    Then Guest - Click RFQ Search Button
    Then Wait for "3" Seconds
    Then Guest - Scroll to Matching Loads
    #Expected Result f
    Then Guest - Verify text "SysData=>2L" not displaying on Page -
    Then Guest - Verify text "SysData=>3L" not displaying on Page -
    Then Guest - Verify matching load row
      | Load Number | Radio Selected | Rate     | Rate Type    | Equipment | Ship Date | Delivery Date | Weight |
      | SysData=>4L | false          | CAD 1.25 | Rate per Mile | NA        | 4         | NA            | 1500 |
    Then Close Guest Browser
