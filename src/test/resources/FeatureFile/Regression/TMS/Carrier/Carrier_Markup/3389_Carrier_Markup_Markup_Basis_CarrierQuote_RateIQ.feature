Feature: 3389 - Carrier Markup - Markup Basis: Carrier Quote + RateIQ

  @WEB @Regression @TMS  @API @MultiCurrency @Carrier @Carrier_Markup @3389
  Scenario: 3389 - Carrier Markup - Markup Basis: Carrier Quote + RateIQ

    When Login into Salesforce
    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    And Update the Custom Select option "RateIQ Rate Entry User" as "User User "
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Carrier Markup Groups" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Carrier Markup Group" -
    Then Switch to Parent Frame
    Then Update details
      | Name          |
      | Markup Basis1 |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Carrier Markup Group \"Markup Basis1\" was created."
    Then Capture the current URL for "Carrier_Markup_Group"
    Then Set Key "CarrierMarkupGroup" page Record Id with "rtms__CarrierMarkupGroup__c"

    #Step 3
    Then Go to "Related" Tab
    Then Click on link "Carrier Markups"
    Then Click on button "New"
    Then Wait for "2" Seconds
    Then Edit the following to "Move selection to Active"
      | Carrier Quote |
      | Carrier Quote |
    Then Update details
      | Markup Type  | Mode      | Target Markup Percent | Minimum Markup Percent | Minimum Markup Amount | Transaction Fee |
      | Freight+Fuel | Truckload | 10                    | 0                      | 0                     | 0               |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Click on "Markup-" with Contains Text
    Then Wait for "2" Seconds
    Then Get Details
      | Name |
      |      |
    Then Capture the current URL for "Carrier_Markup"
    #Step 4
    Then Set Key "CarrierMarkup" page Record Id with "rtms__CarrierMarkup__c"

    #Step 5
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Go to "Rates" Tab
    Then Scroll into Section "Customer Product and Pricing Information"
    Then Click on Edit icon on Label "Carrier Markup Group"
    Then Update details
      | Carrier Markup Group |
      | Markup Basis1        |
    Then Click on "Save" button on Details Page
    Then Verify "Carrier Markup Group" having value of "Markup Basis"
    Then Capture the current URL for "TP_Link"

    # Step 6
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode      | Lane     | Category | Rate Type    | Status   |
      | Boston Beans           | Truckload | US to US | Customer | Freight+Fuel | Accepted |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Rate Method   |
      | RateIQ+Markup |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    #Step 7
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_Name"
    Then Capture the current URL for "Rate_Entry_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

    #Step 8 & 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Cubs | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Beans       | 10000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

     #Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds

    # Expected a
    Then Verify Text displaying as "New Customer Quote"

    # Step 11
    Then Navigate to stored URL for "Carrier_Markup"
    Then Wait for "2" Seconds
    Then Scroll into Section "General Information"
    Then Click on Edit icon on Label "Markup Basis"
    Then Select "Markup Basis" as "RateIQ" from Dueling List
    Then De-Select "Markup Basis" as "Carrier Quote" from Dueling List
    Then Click on "Save" button
    Then Wait for "5" Seconds

    # Step 12
    Then Navigate to stored URL for "Rate_Entry_Link"
    Then Wait for "3" Seconds

    # Step 13
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Rate Method  | Rate |
      | Fixed Amount | 100  |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    # Step 14
    Then Navigate to stored URL for "Load_1"
    Then Wait for "3" Seconds

    # Step 15
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds

    # Expected b
    Then Verify Customer Rate Entry "Rate_Entry_Name" on Customer Quotes
    Then Verify Text not displaying as "SysData=>Name"