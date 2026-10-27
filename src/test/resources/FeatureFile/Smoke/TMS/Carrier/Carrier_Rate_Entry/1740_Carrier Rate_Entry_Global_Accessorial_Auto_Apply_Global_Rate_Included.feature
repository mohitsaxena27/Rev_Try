Feature: 1740 - Carrier Rate Entry- Global Accessorial Auto-Apply: Global Rate Included

  @Regression @TMS @WEB @Admin @SingleCurrency @Carrier_Rate_Entry @1740
  Scenario: 1740 - Carrier Rate Entry- Global Accessorial Auto-Apply: Global Rate Included

    When Login into Salesforce
      #Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Revenova HQ" from List
    Then Go to "Rates" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section with Title "Rating Automation Setting"
    Then Click on Edit icon on Label "Auto-Apply Accessorial Rating Source"
    Then Update details
      | Auto-Apply Accessorial Rating Source|
      | Customer + Global Rates              |
    Then Click on button "Save"
    Then Wait for "2" Seconds

      #Step 2 a
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Scroll into Section "General Information"
    Then Update details
      | Transportation Profile | Mode      | Lane     | Category | Rate Type | Status   |
      | Global Default         | Truckload | US to US | Carrier  | Freight   | Accepted |
    Then Wait for "2" Seconds
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service                        | Rate Method | Rate |
      | Stored Rate Carrier One - Truckload    | Per Pound   | 0.75 |
    Then Click on button "Save"
    Then Wait for "5" Seconds
#    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Capture the current URL for "Freight_Rate_Entry_Page"
    Then Set Key "Freight_Rate_Entry_SFID" page Record Id with "rtms__RateEntry__c"
    Then Verify and get Rate_Entry Number on kay "Freight_Rate_Entry_Name"

    #Step 2 b
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Scroll into Section "General Information"
    Then Update details
      | Transportation Profile | Mode      | Lane     | Category | Rate Type   | Status   | Accessorial        | Auto-Apply |
      | Global Default         | Truckload | US to US | Carrier  | Accessorial | Accepted | After Hours Pick Up | True       |
    Then Wait for "2" Seconds
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service                     | Rate Method | Rate |
      | Stored Rate Carrier One - Truckload | Per CWT     | 2.56 |
    Then Click on button "Save"
    Then Wait for "5" Seconds
    #Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Capture the current URL for "Accessorial_Rate_Entry_Page"
    Then Set Key "Accessorial_Rate_Entry_SFID" page Record Id with "rtms__RateEntry__c"
    Then Verify and get Rate_Entry Number on kay "Accessorial_Rate_Entry_Name"

    #Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ  | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 8600   | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_Url"
    Then Wait for "3" Seconds

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds

    #Expected a
    Then Verify "Carrier Service" Link value displaying as "Stored Rate Carrier One - Truckload"
    Then Verify Carrier "Net Freight Charges" displaying as "USD 6,450.00"
    Then Verify Carrier "Accessorial Charges" displaying as "USD 220.16"

Then Scroll down with "1" Times
   Then Verify Carrier Rate Entry "Freight_Rate_Entry_Name" on Carrier Quotes
    #Then Verify Carrier Rate Entry "Accessorial_Rate_Entry_Name" on Carrier Quotes








































































































