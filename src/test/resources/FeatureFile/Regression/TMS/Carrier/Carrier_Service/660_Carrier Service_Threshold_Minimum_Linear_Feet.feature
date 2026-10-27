Feature: 660 - Carrier Service- Threshold: Minimum Linear Feet

  @Regression @Priority_1 @WEB @SingleCurrency @Carrier @Carrier_Service @660
  Scenario: 660 - Carrier Service- Threshold: Minimum Linear Feet

    When Login into Salesforce

    #Steps1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Stored Rate Carrier Two" from List
    Then Click on "Carrier Service" Link Text "Stored Rate Carrier Two - LTL" on Page

    Then Scroll into Section "Load Weight & Volume Thresholds"
    Then Click on Edit icon on Label "Minimum Linear Feet"
    Then Enter Label "Minimum Linear Feet" Text as "6"
    Then Click on "Save" button
    Then Verify "Minimum Linear Feet" having value of "6"
    Then Capture the current URL for "Transportion_URL"

     #Steps 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Denver Deli Meats | LTL      | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  5             | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Material     |8000  |NA          |2       |Pallets       |45    |45   |45    |NA            |50        |
    Then Save Load With All details

    #Step3 and expected result a
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Verify Text displaying as "New Carrier Quote"
    Then Verify "Carrier Service" having value of ""
    Then Verify Carrier "Quote Total" displaying as "0"

    #Step 4
    Then Navigate to stored URL for "Transportion_URL"
    Then Scroll into Section "Load Weight & Volume Thresholds"
    Then Click on Edit icon on Label "Minimum Linear Feet"
    Then Enter Label "Minimum Linear Feet" Text as ""
    Then Click on "Save" button
    Then Verify "Minimum Linear Feet" having value of ""

    #Step 5 and expected result g
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Denver Deli Meats | LTL      | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  5             | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Material     |8000  |NA          |2       |Pallets       |45    |45   |45    |NA            |50        |
    Then Save Load With All details
    Then Go to "Freight Quote Assistant" Tab
    Then Verify Message displaying as "Stored Rate Quote(s) created."
    Then Verify "Carrier Service" Link value displaying as "Stored Rate Carrier Two - LTL"