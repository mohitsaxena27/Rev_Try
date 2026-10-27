Feature: 2710 - Load Detail LWC- Stop Location Updates

  @Regression @TMS @Smoke @API @WEB @Load @SingleCurrency @Load_Details @2710

  Scenario: 2710 - Load Detail LWC- Stop Location Updates

    When Login into Salesforce
    #Step1
    Then Wait for "2" Seconds
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Open "Stop" Object Manager
    Then Click on "Field Sets" with Text
    Then Open Field Sets "TMS12" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Delete Fields if any available with Field Set
    Then Add the Following Fields in this Order
    |Geolocation (Longitude)|Geolocation (Latitude)|Postal Code|State/Province|City |Country|Pickup/Delivery Number|References|Instructions |Shipping/Receiving Hours|Appointment Required|Appointment Time|Expected Date|Location|
    |Geolocation (Longitude)|Geolocation (Latitude)|Postal Code|State/Province|City |Country|Pickup/Delivery Number|References|Instructions |Shipping/Receiving Hours|Appointment Required|Appointment Time|Expected Date|Location|

    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 2
    Then Open "Transportation" from App Launcher

    #Step 3
    Then Search and Select "Boston Red Sox" Account from the Global search
    Then Go to "Contacts" Tab
    Then Click on "Joe Boston Red Sox" with Text
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Transportation Role"
    Then Edit the following to De-Select "Move selection to Available"
      |Shipping|
      |Shipping|
    Then Click on "Save" button
    Then Wait for "5" Seconds
    Then Verify "Transportation Role" having not contains value of "Shipping"

    #Step 4
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Red Sox" from List
    Then Click on Edit icon on Label "Shipping Hours"
    Then Update details
         |Shipping Hours|Pickup Appointment Required|
         |09:00-12:00   |True                       |
    Then Scroll into Section "Load Defaults"
    Then Scroll down with "2" Times
     Then Enter Label "Default Pickup Instructions" TextArea as "2710"
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "Shipping Hours" having value of "09:00-12:00"

    #Step 5
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Cincinnati Reds" from List
    Then Click on Edit icon on Label "Shipping Hours"
    Then Enter Label "Shipping Hours" Text as ""
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "Shipping Hours" having value of ""

    #Step 6 - Create Quick Entry Shipment
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL        | Dry Van 53     | Y             | N                 |
    Then Wait for "2" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | NA             | 1200-1800               | 1245               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | Y       | 3P   | City_State_PC   | Chicago,IL,60602,US | 3             | NA               | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 4D   | GeoLocation  | 32.715736,-117.161087 |  NA             | NA                       | NA               | NA                   |


    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description|Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Mixed     |8000 |NA          |NA       |NA       |NA        |NA   |NA    |NA            |NA        |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description|Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |2        |Stop 3    |Stop 4      |Stuff     |2000 |NA          |NA       |NA       |NA        |NA   |NA    |NA            |NA        |

    Then Save Load With All details
    #Step 7
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Location"
    Then Update Location as "Boston Red Sox"
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    #Expected a
    Then Verify "1P" Stop with "4 Jersey St, Boston, Massachusetts 02215"
    Then Verify Stop "1P" Details
      | Location       | Shipping/Receiving Hours | Instructions           |
      | Boston Red Sox | 09:00-12:00             | 2710 |
    Then Verify details For Checkbox
      |Appointment Required           |
      |True                           |
    Then Collapse "Details" for "1" Load

#     Step 8
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "References"
    Then Update details
      |Pickup/Delivery Number|References     |Instructions|
      |27102D         |2D2710        |27102D       |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    #     Step 9
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Location"
    Then Update Location as "Pittsburgh Pirates"
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
  #Expected b
    Then Verify "2D" Stop with "115 Federal Street, Pittsburgh, Pennsylvania 15212"
    Then Verify "2D" Stop with "Joe Pittsburgh Pirates"
    Then Verify "2D" Stop with "312-888-7777"
    Then  Verify Stop "2D" Details
      | Location            | Shipping/Receiving Hours|Appointment Time | Pickup/Delivery Number|References     |Instructions|
      | Pittsburgh Pirates | 09:00-22:00            |12:45 | 27102D         |2D2710        |Delivery Instructions       |
    Then Verify details For Checkbox
      |Appointment Required           |
      |False                           |
    Then Collapse "Details" for "2" Load

#     Step 10
    Then Expand "Details" for "3" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Location"
    Then Enter Location as "Denver Deli"
    Then Wait for "2" Seconds
    #Expected c
    Then Verify No Search Result displaying with "Denver Deli"

  #Step 11
    Then Wait for "1" Seconds
    Then Enter Location as "Chicago"
    Then Wait for "2" Seconds
    #Expected d
    Then Verify Search Result displaying with "Chicago Pizza"
    Then Click on "Cancel" Button with Type "button"
    Then Wait for "2" Seconds

       #Step 12
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Location"
    Then Update details
    |City|State/Province|Postal Code|Geolocation (Latitude)|Geolocation (Longitude)|
    |Cincinnati|OH      |45202      |                      |                       |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    #Expected e
    Then Verify "3P" Stop Text is "Stop 3"
    Then Verify "3P" Stop with "Cincinnati, OH 45202"

    #Step 13
    Then Click on Edit icon with Field Name "Location"
    Then Update Location as "Cincinnati Reds"
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    #Expected f
    Then Verify "3P" Stop Text is "Cincinnati Reds"
    Then Verify "3P" Stop with "100 Main St, Cincinnati, Ohio 45202"
    Then Verify "3P" Stop with "Joe Cincinnati Reds"
    Then Verify "3P" Stop with "312-888-7777"
    Then  Verify Stop "3P" Details
      | Location            | Shipping/Receiving Hours|Appointment Time | Pickup/Delivery Number|References     |Instructions|
      | Cincinnati Reds     |             | |          |        |Pickup Instructions       |
    Then Verify details For Checkbox
      |Appointment Required           |
      |False                           |
    Then Collapse "Details" for "3" Load

     #Step 14
    Then Expand "Details" for "4" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Location"
    Then Update details
    |City|State/Province|Postal Code|Geolocation (Latitude)|Geolocation (Longitude)|
    |    |--None--      |           |38.5781               |-121.4944              |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Click on button with Title "Refresh Route"
    Then Verify Message displaying as "Load route and map were updated."
    Then Wait for "2" Seconds
        #Expected g
    Then Verify "4D" Stop Text is "Stop 4"
    Then Verify "4D" Stop with "38.5781 -121.4944 Sacramento, CA 95814"
    Then Collapse "Details" for "4" Load
