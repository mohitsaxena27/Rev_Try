Feature: 1507 - Load Configuration LWC- Data Retention

  @API @Regression @Priority_1 @WEB @SingleCurrency @Load_Config @1507
  Scenario: 1507 - Load Configuration LWC- Data Retention
    When Login into Salesforce
    # Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type  | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | City_State_PC | Hershey,PA,17033,US | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3D   | GeoLocation  | 36.674669, -93.231166 | 4             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | Account_Address | Denver Deli Meats | 7             | NA                       | NA               | NA                   |
    # Step 2
    Then Click on Move Stops action for Stop "4D"
    Then Wait for "2" Seconds
    Then Click on "Move Down" action is displaying with Stop "2"
    Then Click button with Text "Done" on Modal
    Then Wait for "3" Seconds
    # Expected a
    Then Verify Load Stop details for "1P"
      | Location     | Expected Date |
      | Boston Beans | 0             |
    Then Verify Load Stop details for "2P"
      | City    | Postal Code | Expected Date |
      | Hershey | 17033       | 1             |
    Then Verify Load Stop details for "3D"
      | Location          | Expected Date |
      | Denver Deli Meats | 7             |
    Then Verify Load Stop details for "4D"
      | Latitude  | Longitude  | Expected Date |
      | 36.674669 | -93.231166 | 4             |
    # Step 3
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                      | Delivery                                                    | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 - Boston Beans 526 Beacon Street, Boston MA 02215 US | Stop 3 - Denver Deli Meats 1435 Fox St., Denver CO 80204 US | Mixed       | 5000   | NA           | 5        | Bags           | 30     | 30    | 30     | NA             | 50         |
    Then Update details
      | HazMat |
      | false  |
    Then Wait for "3" Seconds
    # Step 4 & 5
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 2 | Stop 4   | Unmixed     | 2000   | NA           | 2        | Bins           | 35     | 35    | 35     | NA             | 55         |
    Then Update details
      | HazMat |
      | true   |
    Then Wait for "3" Seconds
    Then Update details
      | HazMat Number Type | HazMat Number | HazMat Class/Division | HazMat Packaging Group | HazMat Contact   |
      | UN                 | 4411          | 1.4                   | II                     | Joe Boston Beans |
    # Step 6
    Then Scroll into Section "Load Accessorials"
    And Update details
      | Customs | Excess Value |
      | true    | true         |
    # Step 7
    Then Scroll into Section "HazMat Routing"
    Then Update details
      | HazMat Routing |
      | Caustic        |
    # Step 8
    Then Click on "Quick Entry" with Text
    Then Wait for "3" Seconds
    # Expected b
    Then Verify Load Stop details for "1P"
      | Location     | Expected Date |
      | Boston Beans | 0             |
    Then Verify Load Stop details for "2P"
      | City    | Postal Code | Expected Date |
      | Hershey | 17033       | 1             |
    Then Verify Load Stop details for "3D"
      | Location          | Expected Date |
      | Denver Deli Meats | 7             |
    Then Verify Load Stop details for "4D"
      | Latitude  | Longitude  | Expected Date |
      | 36.674669 | -93.231166 | 4             |
    Then Verify details for all Enabled fields
      | Pickup | Delivery | Description | Weight | HU Count | Handling Units |
      | P1     | D3       | Mixed       | 5,000  | 5        | Bags           |
    Then Verify details for all Enabled fields
      | Pickup_2 | Delivery_2 | Description_2 | Weight_2 | HU Count_2 | Handling Units_2 |
      | P2       | D4         | Unmixed       | 2,000    | 2          | Bins             |
    # Step 8.a
    Then Add Location Details
      | Add_Loc | Type | Address_Type  | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | City_State_PC | NA    | 2             | NA                       | NA               | NA                   |
    # Expected c
    Then Verify Load Stop details for "1P"
      | Location     | Expected Date |
      | Boston Beans | 0             |
    Then Verify Load Stop details for "2P"
      | City    | Postal Code | Expected Date |
      | Hershey | 17033       | 2             |
    Then Verify Load Stop details for "3D"
      | Location          | Expected Date |
      | Denver Deli Meats | 7             |
    Then Verify Load Stop details for "4D"
      | Latitude  | Longitude  | Expected Date |
      | 36.674669 | -93.231166 | 4             |
    # Step 8.b
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Account_Address | NA    | NA            | NA                       | NA               | NA                   |
    Then Wait for "2" Seconds
    # Expected d
    Then Verify Load Stop details for "3D"
      | Location | Expected Date |
      |          | 7             |
    # Step 9
    Then Click on "Detail Entry" with Text
    Then Wait for "3" Seconds
    # Expected e
    Then Verify Load Stop details for "1P"
      | Location     | Expected Date |
      | Boston Beans | 0             |
    Then Verify Load Stop details for "2P"
      | City    | Postal Code | Expected Date |
      | Hershey | 17033       | 2             |
    Then Verify Load Stop details for "3D"
      | Location          | Expected Date |
      | Denver Deli Meats | 7             |
    Then Verify Load Stop details for "4D"
      | Latitude  | Longitude  | Expected Date |
      | 36.674669 | -93.231166 | 4             |
    Then Verify details for all Enabled fields
      | Item Description | Weight | HU Count | Handling Units | Length | Width | Height | NMFC Class | HazMat |
      | Mixed            | 5,000  | 5        | Bags           | 30     | 30    | 30     | 50         | False  |
    Then Verify details for all Enabled fields
      | Item Description_2 | Weight_2 | HU Count_2 | Handling Units_2 | Length_2 | Width_2 | Height_2 | NMFC Class_2 | HazMat_2 |
      | Unmixed            | 2,000    | 2          | Bins             | 35       | 35      | 35       | 55           | True     |
    Then Verify details for all Enabled fields
      | HazMat Number Type | HazMat Number | HazMat Class/Division | HazMat Packaging Group | HazMat Contact   |
      | UN                 | 4411          | 1.4                   | II                     | Joe Boston Beans |
    Then Verify details for all Enabled fields
      | HazMat Routing |
      | Caustic        |
    # Step 10
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"
    # Step 11
    # Expected f
    Then Verify Banner Details
      | Mode Name | Equipment Type | Customer     |
      | Truckload | Dry Van 53'    | Boston Beans |
    # Step 12
    Then Go to "Shipment" Tab
    Then Wait for "3" Seconds
    # Expected g
    Then Verify "1P" Stop Text is "Boston Beans"
    Then Verify "1P" Stop with "526 Beacon Street"
    Then Verify "1P" Stop Details
      | Expected Date |
      | 0             |
    Then Expand "Items" for "1" Load
    Then Wait for "2" Seconds
    Then Click on "Edit" on "1" item
    Then Wait for "2" Seconds
    # Expected h
    Then Verify details for all Enabled fields
      | Weight | Handling Units | HU Count | NMFC Class | HazMat | Length | Width | Height |
      | 5,000  | Bags           | 5        | 50         | False  | 30     | 30    | 30     |
    Then Click on "Cancel" with Text
    Then Wait for "1" Seconds
    Then Collapse "Items" for "1" Load
    # Expected i
    Then Verify "2P" Stop Details
      | Expected Date |
      | 2             |
    Then Expand "Items" for "2" Load
    Then Wait for "2" Seconds
    Then Click on "Edit" on "1" item
    Then Wait for "2" Seconds
    # Expected j
    Then Verify details for all Enabled fields
      | Weight | Handling Units | HU Count | NMFC Class | HazMat | Length | Width | Height |
      | 2,000  | Bins           | 2        | 55         | True   | 35     | 35    | 35     |
    Then Click on "Cancel" with Text
    Then Wait for "1" Seconds
    Then Collapse "Items" for "2" Load
    # Expected k
    Then Verify "3D" Stop Text is "Denver Deli Meats"
    Then Verify "3D" Stop with "1435 Fox St"
    Then Verify "3D" Stop Details
      | Expected Date |
      | 7             |
    Then Expand "Items" for "3" Load
    Then Wait for "2" Seconds
    Then Click on "Edit" on "1" item
    Then Wait for "2" Seconds
    # Expected l
    Then Verify details for all Enabled fields
      | Weight | Handling Units | HU Count | NMFC Class | HazMat | Length | Width | Height |
      | 5,000  | Bags           | 5        | 50         | False  | 30     | 30    | 30     |
    Then Click on "Cancel" with Text
    Then Wait for "1" Seconds
    Then Collapse "Items" for "3" Load
    # Expected m
    Then Verify "4D" Stop Details
      | Expected Date |
      | 4             |
    Then Expand "Items" for "4" Load
    Then Wait for "2" Seconds
    Then Click on "Edit" on "1" item
    Then Wait for "2" Seconds
    # Expected n
    Then Verify details for all Enabled fields
      | Weight | Handling Units | HU Count | NMFC Class | HazMat | Length | Width | Height |
      | 2,000  | Bins           | 2        | 55         | True   | 35     | 35    | 35     |
    Then Click on "Cancel" with Text
    Then Wait for "1" Seconds
    Then Collapse "Items" for "4" Load
    # Step 13
    Then Click on "Route Options" with Text
    Then Wait for "2" Seconds
    # Expected o
    Then Verify Text displaying as "Caustic"
    # Step 14
    Then Scroll Until Related List for "Load Accessorials"
    # Expected p
    Then Verify "Load Accessorials" Table details with following Details
      | Load Accessorial: Name      |
      | Customs                     |
      | Excess Value                |
      | Hazardous Material Handling |
    # Step 15
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value          | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Account_Address | Denver Broncos | 3             | NA                       | NA               | NA                   |
    # Expected q
    Then Verify Load Stop details for "1P"
      | Location     |
      | Boston Beans |
    Then Verify Load Stop details for "2P"
      | Location          |
      | Denver Deli Meats |
    Then Verify Load Stop details for "3D"
      | Location       |
      | Denver Broncos |
    # Step 16
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | NA    | NA            | NA                       | NA               | NA                   |
    Then Click into field "Location" within "1P" and click out
    Then "Location" field highlights red as required
    # Step 17
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | NA            | NA                       | NA               | NA                   |
    # Expected r
    Then Verify Load Stop details for "1P"
      | Location     |
      | Boston Beans |
    Then Verify Text not displaying as "Complete this field."


