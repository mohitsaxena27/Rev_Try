Feature:440 - TMS Admin Configuration - Delivered Load Trigger: Last Stop Departure Date

  @Regression @TMS @Smoke @WEB @SingleCurrency @Admin @TMS_Config @440
  Scenario: 440 - TMS Admin Configuration - Delivered Load Trigger: Last Stop Departure Date

    When Login into Salesforce
# Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    And Update the Custom Select option "Delivered Load Trigger" as "Last Stop Departure Date"
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
    Then Click on "2D" "Departed" chevron
    Then Update details
    |Departure Date|
    |-1            |
    Then Click on "2D" "Save" button
    Then Verify "2D" Shipment is "Departed"
    Then Wait for "5" Seconds
    Then Refresh current Page
  # Step 6
    Then Go to "Details" Tab
     #Expected a
    Then Verify details for
      |Load Status      |
      |Delivered        |

    # Step 7
    Then Open "Loads" from App Launcher
    Then Search and Select "B-1268" from List
    Then Wait for "1" Seconds
    #Step 8
    Then Execute Load "1L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"

    #Step 9
    Then Open Last Load from Cloned Load
    Then Wait for "4" Seconds
    Then Capture the current URL for "Cloned_Load"
    #Step 10
    Then Click on button with Title "Add Freight Plan"
    Then Wait for "5" Seconds

    #Step 11
    Then Click on button with Title "Create/Add To Carrier Load"
    Then Click on "New Load" with Text
    Then Update details
      |Mode|
      |Truckload|
    Then Click on button with Title "Save"
    #Step 12
    Then Freight Plan - Select the "1" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "2" Seconds
    #Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
   # Step 14
    Then Go to "Summary" Tab
    Then Click on "2D" "Departed" chevron
    Then Update details
      |Departure Date|
      |4            |
    Then Click on "2D" "Save" button
    Then Verify "2D" Shipment is "Departed"
    Then Wait for "5" Seconds
     # Step 15
    Then Click on "3D" "Departed" chevron
    Then Update details
      |Departure Date|
      |7            |
    Then Click on "3D" "Save" button
    Then Wait for "5" Seconds
    Then Close Current Tab
    Then Switch to Parent Window
  # Step 16
    Then Navigate to stored URL for "Cloned_Load"

 # Step 17
    Then Go to "Details" Tab
     #Expected b
    Then Verify details for
      |Load Status      |
      |Delivered        |


