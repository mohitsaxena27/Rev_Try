Feature:441 - TMS Admin Configuration - In-Transit Load Trigger: First Stop Arrival Date

  @Regression @TMS @Smoke @WEB @SingleCurrency  @Admin @TMS_Config @441
  Scenario: 441 - TMS Admin Configuration - In-Transit Load Trigger: First Stop Arrival Date


    When Login into Salesforce
# Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    And Update the Custom Select option "In Transit Load Trigger" as "First Stop Arrival Date"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

# Step 2
  #1st Load
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles|  1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |15000  |NA          |NA       |NA       |

    Then Save Load With All details

# Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
 # Step 4
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1500"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
 # Step 5
    Then Go to "Summary" Tab
    Then Click on "1P" "Arrived" chevron
    Then Update details
      |Arrival Date|
      |1            |
    Then Click on "1P" "Save" button
    Then Verify "1P" Shipment is "Arrived"
    Then Wait for "8" Seconds
    Then Refresh current Page
  # Step 6
    Then Go to "Details" Tab
     #Expected a
    Then Verify details for
      |Load Status      |
      |In Transit        |


