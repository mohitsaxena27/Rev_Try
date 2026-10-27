Feature:1235 - Customer Rate Entry- Status Logic

  @Regression @TMS @Smoke @WEB @Admin @SingleCurrency  @Customer_Rate_Entry @1235
  Scenario: 1235 - Customer Rate Entry- Status Logic

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
      | Transportation Profile | Mode         | Lane        | Category | Rate Type |Status|
      | Boston Beans        | LTL  | US to US | Customer  | Freight  |Accepted|
    Then Wait for "2" Seconds
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      |Rate Method|Rate|
      |Fixed Amount|1850 |
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
      |1L       | Boston Beans  |LTL       | Dry Van 48     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats     |  2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000  |NA          |NA       |NA       |
    Then Save Load With All details
    Then Capture the current URL for "Load_Url"
    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "20" Seconds
    #Expected a
    Then Verify Customer "Freight Charges" displaying as "USD 1,850.00"
    Then Verify Customer Rate Entry "Rate_Entry_Name" on Customer Quotes
    Then Store Customer Quote value on "Customer_Quotes"

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
    Then Wait for "2" Seconds
    Then Execute Load "1L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Wait for "1" Seconds
    #Step 6
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds

    #Expected b
    Then Verify No Customer Quote Returned
    Then Verify Text not displaying as "SysData=>Rate_Entry_Name"

    #Step 7
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
      |Status|
      |Quoted|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 8
    Then Navigate to stored URL for "Load_Url"
    Then Wait for "2" Seconds
    Then Execute Load "2L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Wait for "1" Seconds
    #Step 9
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    #Expected c
    Then Verify No Customer Quote Returned
    Then Verify Text not displaying as "SysData=>Rate_Entry_Name"

    #Step 10
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
      |Status|
      |Rejected|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 11
    Then Navigate to stored URL for "Load_Url"
    Then Wait for "2" Seconds
    Then Execute Load "3L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Wait for "1" Seconds
    #Step 12
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    #Expected d
    Then Verify No Customer Quote Returned
    Then Verify Text not displaying as "SysData=>Rate_Entry_Name"

   #Step 13
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
      |Status|
      |Cancelled|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 14
    Then Navigate to stored URL for "Load_Url"
    Then Wait for "2" Seconds
    Then Execute Load "4L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Wait for "1" Seconds
    #Step 15
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    #Expected e
    Then Verify No Customer Quote Returned
    Then Verify Text not displaying as "SysData=>Rate_Entry_Name"

    #Step 16
    Then Navigate to stored URL for "Rate_Entry_Page"
    Then Wait for "5" Seconds
    Then Update details
      |Status|
      |Accepted|
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

   #Step 17
    Then Navigate to stored URL for "Load_Url"
    Then Wait for "2" Seconds
    Then Execute Load "5L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Wait for "1" Seconds
    #Step 18
    Then Open Last Load from Cloned Load
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    #Expected f
    Then Verify Customer "Freight Charges" displaying as "USD 1,850.00"
    Then Verify Customer Rate Entry "Rate_Entry_Name" on Customer Quotes
    Then Store Customer Quote value on "Customer_Quotes"