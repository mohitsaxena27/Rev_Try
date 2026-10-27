Feature: 383 - Customer Rate Entry- Expiration Date

  @Regression @TMS @Smoke @API @WEB @MultiCurrency @Carrier @Carrier_Markup @383
  Scenario: 383 - Customer Rate Entry- Expiration Date

    When Login into Salesforce
    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Carrier Markup Groups" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Carrier Markup Group" -
    Then Switch to Parent Frame
    Then Update details
      |Name|
      |Carrier Service Markup|
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Carrier Markup Group \"Carrier Service Markup\" was created."
    Then Capture the current URL for "Carrier_Markup_Group"
    Then Set Key "CarrierMarkupGroup" page Record Id with "rtms__CarrierMarkupGroup__c"
    
    #Step 2
    Then Go to "Related" Tab
    Then Click on link "Carrier Markups"
    Then Click on button "New"
    Then Wait for "2" Seconds
    Then Update details
         |Markup Type|Mode     |Carrier Service                    |Target Markup Percent|Minimum Markup Percent|Minimum Markup Amount|Transaction Fee|
         |Freight    |Truckload|Stored Rate Carrier One - Truckload|10                   |0                     |0                    |0              |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    #Step 3
    Then Click on "Markup-" with Contains Text
    Then Wait for "2" Seconds
    Then Get Details
         |Name|
         |    |
    Then Capture the current URL for "Carrier_Markup"
    Then Set Key "CarrierMarkup" page Record Id with "rtms__CarrierMarkup__c"
    
    #Step 4
    Then Navigate to stored URL for "Carrier_Markup_Group"
    Then Go to "Related" Tab
    Then Click on link "Carrier Markups"
    Then Click on button "New"
    Then Wait for "2" Seconds
    Then Update details
      |Markup Type|Mode     |Carrier Service                    |Target Markup Percent|Minimum Markup Percent|Minimum Markup Amount|Transaction Fee|
      |Freight    |Truckload|Stored Rate Carrier Two - Truckload|100                   |0                     |0                    |0              |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Click on "Markup-" with Contains Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Carrier_Markup_2"
    Then Set Key "CarrierMarkup2" page Record Id with "rtms__CarrierMarkup__c"

    #Step 5
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode       | Lane        | Category | Rate Type |Status|
      | Global Default         | Truckload  | US to US | Carrier  | Freight  |Accepted|
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      |Carrier Service                    |Rate Method|Rate|
      |Stored Rate Carrier One - Truckload|Fixed Amount|100 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    #Step 6
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_Name"
    Then Capture the current URL for "Rate_Entry_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

    #Step 7
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Global Default" from List
    Then Wait for "2" Seconds
    Then Capture the current URL for "Global_Default_TP"
    Then Go to "Rates" Tab
    Then Scroll into Section "Customer Product and Pricing Information"
    Then Click on Edit icon on Label "Carrier Markup Group"
    Then Update details
         |Carrier Markup Group|
         |Carrier Service Markup|
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Verify "Carrier Markup Group" having value of "Carrier Service Markup"

    #Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Chicago Pizza |Truckload   | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Pizza    |5000  |NA          |NA       |NA       |
    Then Save Load With All details

     #Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "40" Seconds
      #Exected a
    Then Verify Customer "Freight Charges" displaying as "USD 110.00"
    Then Verify Customer Pricing Notes displaying as "Net Freight Charges"
    Then Verify Customer Rate Entry "Name" on Customer Quotes
    #Step 10
    Then Click on Customer Quote from FQA Page
    Then Go to "Details" Tab on Next to "Pricing" Tab
    #Expected b
    Then Scroll into Section "Rate Details"
    Then Verify Details
         |Freight Markup|
         |SysData=>Name |














