Feature: 1206 - Customer Rate Entry- Expiration Date

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Customer @Customer_Rate_Entry @1206
  Scenario: 1206 - Customer Rate Entry- Expiration Date


    When Login into Salesforce
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode | Lane        | Category | Rate Type |Status|Expiration Date|
      | Chicago Pizza         | Drayage  | US to US | Customer  | Freight  |Accepted|1            |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      |Rate Method|Rate|
      |Fixed Amount|1200 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_Name"
    Then Capture the current URL for "Rate_Entry_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

    #Step2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Chicago Pizza |Drayage   | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Material    |6500  |NA          |NA       |NA       |
    Then Save Load With All details

     #Step3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
      #Exected a
    Then Verify Customer "Freight Charges" displaying as "USD 1,200.00"
    Then Verify Customer "Quote Total" displaying as "USD 1,200.00"
    Then Verify Customer Rate Entry "Rate_Entry_Name" on Customer Quotes
    #Step 4
    Then Navigate to stored URL for "Rate_Entry_Link"
    Then Wait for "2" Seconds
    Then Update details
          |Expiration Date|
          |-1             |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    #Step5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Chicago Pizza |Drayage   | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Material    |6500  |NA          |NA       |NA       |
    Then Save Load With All details

     #Step6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    #Expected b
    Then Verify No Customer Quote Returned













