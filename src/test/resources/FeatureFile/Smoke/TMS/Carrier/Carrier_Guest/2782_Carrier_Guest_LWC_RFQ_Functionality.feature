Feature: 2782 - Carrier Guest LWC- RFQ Functionality

  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Headed @Carrier_Guest @2782
  Scenario: 2782 - Carrier Guest LWC- RFQ Functionality

    When Login into Salesforce
    #Step1
    Then Run "QueuedTransactionJob" Job
   # Step 2
     #Load1
    Then Open "Loads" from App Launcher
#    Then Open Load Number "L-346"
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Boston Beans |Truckload | Dry Van 53     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | NA               | NA                   |
    Then Update details
      |After Hours Pick Up|
      |True               |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza|  4             | NA                       | NA               | NA                   |
    Then Update details
      |After Hours Delivery|
      |True               |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | 2        | Pallets        | NA     | NA    | NA     | NA             | NA         |
    Then Scroll into Section "Load Accessorials"
    And Update details
      | Blind Shipments |
      | true            |
    Then Save Load With All details

     #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Wait for "1" Seconds
    Then Click on button with Title "Get Quote"
    Then Verify Message displaying as "1 Email Quote request(s) sent to Email Carrier One - Truckload."
    Then Set "Email_Subject" with "Quote Request for Load SysData=>1L"
    Then Wait for Email to Receive On Email
    #Step 4
    Then Get "Submit Quote" link from Email for Subject "SysData=>Email_Subject"
    Then Launch browser and Navigate Link
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds
    Then Guest - Verify Icon "standard:planogram" is displaying with background color "BrightBlue"

    #Step 5.a
    Then Guest - Enter Label "Freight Charge" Text as "TEM-K"
    Then Guest - Enter Label "Fuel Surcharge" Text as ""
    Then Guest - Click on Label "Freight Charge"
    Then Guest - Click on button with Text "Submit"
    #Expected Result a
    Then Guest - Verify Text displaying as "Enter a valid numeric value."
    Then Guest - Verify "SteelBlue" Color with "White" Text of "Submit" Button is "Enabled"
    #Step 5.b
    Then Guest - Update details
      |Freight Charge|Fuel Surcharge|Stop 1 - After Hours Pick Up|Stop 2 - After Hours Delivery|Blind Shipments|
      |500           |100           |100                         |100                          |100            |
    Then Wait for "3" Seconds
    #Expected b
    Then Guest - Verify details for all Disabled or Readonly fields
         |Carrier Total|
         |900.00       |
    #Step 5.c
    Then Guest - RFQ Select Currency as "CAD"
    Then Guest - Click on button with Text "Submit"
    #Expected c
    Then Guest - Verify Message displaying as "Carrier Quote Submit Message"
    Then Guest - Verify details for all Disabled or Readonly fields
      |Freight Charge|Fuel Surcharge|Stop 1 - After Hours Pick Up|Stop 2 - After Hours Delivery|Blind Shipments|Carrier Total|
      |500.00           |100.00          |100.00                         |100.00                          |100.00            |900.00          |
    Then Guest - Verify "LightGray" Color with "White" Text of "Submit" Button is "Disabled"
    Then Close Guest Browser
    Then Wait for "80" Seconds
    Then Refresh current Page
    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "2" Seconds
    Then Click on Carrier Quote from FQA Page
    Then Wait for "5" Seconds

    #Expected d
    Then Verify Carrier "Quote Total" displaying as "CAD 900.00"
    Then Verify "Carrier Quote Items" "Net Freight Charges" with details "Fixed Cost,,1,,500,,CAD 500.00"
    Then Verify "Carrier Quote Items" "Fuel Surcharge" with details "Fixed Cost,,1,,100,,CAD 100.00"
    Then Verify "Carrier Quote Items" "After Hours Pick Up" with details "Fixed Cost,,1,,100,,CAD 100.00"
    Then Verify "Carrier Quote Items" "After Hours Delivery" with details "Fixed Cost,,1,,100,,CAD 100.00"
    Then Verify "Carrier Quote Items" "Blind Shipments" with details "Fixed Cost,,1,,100,,CAD 100.00"

    #Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Boston Beans |Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza|  4             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000  |NA          |NA       |NA       |
    Then Save Load With All details

    #Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Wait for "1" Seconds
    Then Click on button with Title "Get Quote"
    Then Verify Message displaying as "1 Email Quote request(s) sent to Email Carrier One - Truckload."
    Then Set "Email_Subject_2" with "Quote Request for Load SysData=>2L"

    #Step 9
    Then Wait for Email to Receive On Email

    #Step 10
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 11
    Then Get "Submit Quote" link from Email for Subject "SysData=>Email_Subject_2"
    Then Launch browser and Navigate Link
    Then Guest - Move Element "Search..."
    Then Wait for "2" Seconds
    Then Guest - Verify Icon "standard:planogram" is displaying with background color "BrightBlue"
    #Expected e
    Then Guest - Verify Text displaying as "Carrier Quotation No Longer Available Message"
    Then Close Guest Browser