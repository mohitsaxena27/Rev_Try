Feature:426 - Carrier Rate Entry- Status Logic

  @Regression @TMS @Smoke @WEB @Admin @SingleCurrency  @Carrier_Rate_Entry @426
  Scenario: 426 - Carrier Rate Entry- Status Logic

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
      | Transportation Profile | Mode       | Lane        | Category | Rate Type |Status|
      | Boston Beans        | LTL  | US to US | Carrier  | Freight  |Accepted|
    Then Wait for "2" Seconds
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      |Carrier Service                    |Rate Method|Rate|
      |Stored Rate Carrier One - LTL      |Fixed Amount|1200 |
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
      |1L       | Boston Beans  |LTL       | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza     |  2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Pizza    |5000  |NA          |NA       |NA       |
    Then Save Load With All details
    Then Capture the current URL for "Load_Url"
    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Verify Message displaying as "Stored Rate Quote(s) created."
    Then Wait for "5" Seconds
    #Expected a
    Then Verify "Carrier Service" Link value displaying as "Stored Rate Carrier One - LTL"
    Then Verify Carrier Rate Entry "Rate_Entry_Name" on Carrier Quotes

    #Step 4
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
         |Status|
         |Pending|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    
    #Step 5
    Then Navigate to stored URL for "Load_Url"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Click on button with Title "Refresh Quotes"
    Then Wait for "8" Seconds
    #Expected b
    Then Verify Text displaying as "New Carrier Quote"
    Then Verify "Carrier Service" having value of ""
    Then Verify Carrier "Quote Total" displaying as "0"

    #Step 6
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
      |Status|
      |Quoted|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 7
    Then Navigate to stored URL for "Load_Url"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Click on button with Title "Refresh Quotes"
    Then Wait for "3" Seconds
    #Expected c
    Then Verify Text displaying as "New Carrier Quote"
    Then Verify "Carrier Service" having value of ""
    Then Verify Carrier "Quote Total" displaying as "0"

    #Step 8
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
      |Status|
      |Rejected|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 9
    Then Navigate to stored URL for "Load_Url"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Click on button with Title "Refresh Quotes"
    Then Wait for "3" Seconds
    #Expected d
    Then Verify Text displaying as "New Carrier Quote"
    Then Verify "Carrier Service" having value of ""
    Then Verify Carrier "Quote Total" displaying as "0"

   #Step 10
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
      |Status|
      |Cancelled|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 11
    Then Navigate to stored URL for "Load_Url"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Click on button with Title "Refresh Quotes"
    Then Wait for "3" Seconds
    #Expected e
    Then Verify Text displaying as "New Carrier Quote"
    Then Verify "Carrier Service" having value of ""
    Then Verify Carrier "Quote Total" displaying as "0"

    #Step 12
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
      |Status|
      |Accepted|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 13
    Then Navigate to stored URL for "Load_Url"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Click on button with Title "Refresh Quotes"
    Then Verify Message displaying as "Stored Rate Quote(s) created."
    Then Wait for "4" Seconds
    #Expected f
    Then Verify "Carrier Service" Link value displaying as "Stored Rate Carrier One - LTL"
    Then Verify Carrier Rate Entry "Rate_Entry_Name" on Carrier Quotes