  Feature: 1476 - Freight Plan- Line Item Sync - Two Siblings

  @API @Regression @TMS @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @1476
  Scenario: 1476 - Freight Plan- Line Item Sync - Two Siblings

    Then Login into Salesforce
  # Step1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Indy Irrigation | Truckload | Dry Van 53     | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value       | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address |Boston Beans | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 25000    | NA         | 5        | Pallets        |
    Then Save Load With All details

  # Step 2
    Then Go to "Shipment" Tab
    Then Click on button with Title "Add Freight Plan"

  # Step 3
    Then Wait for "2" Seconds
    Then Click on button with Title "Show Filter/Template Panel"
    Then Wait for "1" Seconds
    Then Verify "Freight Plan Template" tab is active
  # Step 4
    Then Click on "Add" icon under "Added Stops" within "Freight Plan Template"
    Then Freight Plan - "Search Locations" "Joliet Jazz Supplies" and select "Joliet Jazz Supplies - Joliet, IL"
  # Step 5
    Then Click on button with Title Text "Refresh_3" within "Freight Plan Template"
    Then Click on button with Title Text "Hide Panel" within "Freight Plan Template"
  # Step 6
    Then Wait for "2" Seconds
    Then Freight Plan - Click on Checkbox with Location "Indy Irrigation - Indianapolis"
    Then Freight Plan - Click on Dropdown with Location "Joliet, IL" inline with "Indy Irrigation"

  # Step 7
    Then Wait for "2" Seconds
    Then Click on "New Load" with Text
    Then Update details
      | Mode      |
      | Truckload |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"

    Then Freight Plan - Click on Checkbox with Location "Joliet, IL"
    Then Freight Plan - Click on Dropdown with Location "Boston Beans - Boston, MA" inline with "Indy Irrigation"

  # Step 5
    Then Click on "New Load" with Text

  # Step 6
    Then Update details
      | Mode      |
      | Truckload |
    And Click on Native "Save" button

  # Step 7
    Then Freight Plan - Verify and get the "2" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_2"

  # Step 8
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_1" from List

  # Step 9
    Then Wait for "1" Seconds
    Then Expand "Items" for "1" Load
    Then Click on "Edit" on "1" item
    Then Update details
      |Weight|HU Count|
      |30000 |2       |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Collapse "Items" for "1" Load

  # Step 10 & 11
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>1L" from List
    Then Wait for "2" Seconds

  # Step 12
    Then Expand "Items" for "1" Load
    Then the Stop Detail table should have the following items:
      | # | Item Number | Cargo Summary         | Pickup Stop          | Delivery Stop      |
      | 1 |Item 1 | 2 Pallets Bananas, 30000 lbs| Stop 1-Indy Irrigation| Stop 2-Boston Beans|

  # Step 13
    Then Wait for "2" Seconds
    Then Click on "Edit" on "1" item
    Then Update details
      |Weight|HU Count|
      |40000 |8       |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Collapse "Items" for "1" Load

  # Step 14,15 & 16
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_2" from List
    Then Wait for "2" Seconds

  # Step 17
    Then Expand "Items" for "1" Load
    Then The Item Detail table should have the following items:
      | # | Item Number | Cargo Summary                 | Load       | Pickup Stop                 | Delivery Stop      |
      | 1 | Item 1      |  8 Pallets Bananas, 40000 lbs |SysData=>1L | Stop 1-Joliet Jazz Supplies | Stop 2-Boston Beans|
