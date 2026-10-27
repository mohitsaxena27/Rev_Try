Feature:1365 - Carrier Rate Entry- Mileage Override Per Mile

  @Regression @smoke @WEB @Admin @SingleCurrency  @Carrier_Rate_Entry @1365
  Scenario: 1365 - Carrier Rate Entry- Mileage Override Per Mile

    When Login into Salesforce
# Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Scroll into Section "General Information"
    Then Update details
      | Transportation Profile | Mode       | Lane        | Category | Rate Type |Status|Expiration Date|Pricing Notes|
      | Revenova HQ        |Truckload  | US to US | Carrier  | Freight  |Accepted|1                     |123!@#$%$    |
    Then Wait for "2" Seconds
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      |Carrier Service                    |
      |Stored Rate Carrier Two - Truckload    |
    Then Scroll into Section "Base Rate Calculation"
    Then Update details
    |Rate Method|Rate|
    |  Per Mile         |1.2|
#    Then Enter Label "Distance override" Text as "60.587"
#    Then Enter Label "Distance override" as "60.587"
    Then Update details
    |Distance Override|
    | 60.587                |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Capture the current URL for "Rate_Entry_Page"
    Then Set Key "Rate_Entry_SFID" page Record Id with "rtms__RateEntry__c"
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_Name"
    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Revenova HQ |Truckload       | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Material    |6500  |NA          |NA       |NA       |
    Then Save Load With All details
    Then Capture the current URL for "Load_Url"
    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Verify Message displaying as "Stored Rate Quote(s) created."
    Then Wait for "5" Seconds

    #Expected a
    Then Verify "Carrier Quote Items" "Net Freight Charges" with details "Per Mile,,60.587,,1.2,,USD 72.70"
    Then Verify Carrier Rate Entry "Rate_Entry_Name" on Carrier Quotes



