Feature: 1113 - Carrier Banner LWC- Remove Carrier Button Visibility

  @Regression @Priority_1 @TMS @WEB @SingleCurrency @Mail @Carrier @Carrier_Banner @1113
  Scenario: 1113 - Carrier Banner LWC- Remove Carrier Button Visibility

    When Login into Salesforce

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  4            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |
    Then Save Load With All details
    Then Wait for "5" Seconds

    #Steps 2 & expected a
    Then Verify Button with Title not displaying as "Remove Carrier" -

    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Wait for "1" Seconds
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 4 & expected b
    Then Go to "Summary" Tab
    Then Verify Button with Title displaying as "Remove Carrier" -