Feature: 2856 -  Carrier Guest LWC - Carrier Settlement: Functionality

  @Regression @TMS @Priority_1 @WEB  @2856
  Scenario: 2856 -  Carrier Guest LWC - Carrier Settlement: Functionality

    When Login into Salesforce

# Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Customer Invoice Documents" Tab
    Then Switch to Frame by Title "accessibility title"
    #Then "Bill Of Lading" : Select "Invoice Action" as "Always Include"
    Then "Bill Of Lading" : Select "Carrier Upload" as "True"
    Then Click on button "Save"
    Then Wait for "2" Seconds
    #Then Switch to Parent Frame

# Step 2
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job

# Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans  |Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000  |NA          |NA       |NA            |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

# Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

# Step 5
    Then Refresh current Page
    Then Go to "Details" Tab
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Load Status"
    Then Update details
      | Load Status |
      | Delivered   |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

# Step 6
    Then Go to "Summary" Tab
    Then Wait for "1" Seconds
    Then Click on Native "Request Carrier Status" icon
    Then Wait for "3" Seconds

# Step 7
    Then Set "Email_Subject" with "Load Status Request for SysData=>1L"
    Then Wait for Email to Receive On Email
    Then Get "Update Status" link from Email for Subject "SysData=>Email_Subject"
    Then Launch browser and Navigate Link
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds

# Step 8
    Then Guest - Verify Text displaying as "Delivered Loads"
    Then Guest - Verify Text displaying as "Carrier Load List"

# Step 9
    Then Guest - Click on button with Text "SysData=>1L"
    Then Wait for "2" Seconds
# Step 10
    Then Guest - Update details
      | Invoice Date | Invoice Total | Invoice Number | Reason for any additional charges |
      | 0            | 1000.00       | 2856           | egg prices                    |
    Then Wait for "2" Seconds

# Step 11
    Then Guest - Update details
      |Upload Files|
      |Logistics-logo-png2.png|
    Then Wait for "3" Seconds
    Then Guest - Click on button with Text "Done"
    Then Guest - Verify Message displaying as "Success - Load Settlement"
    Then Wait for "2" Seconds
    Then Guest - Verify Text displaying as "Carrier Invoice"
# Step 12
#    Then Guest - Move to Element "Stop-2"
    Then Guest - Update details
    | Upload POD images/photos here|
    | Bill Of Lading |
    Then Wait for "2" Seconds

# Step 13
#    Then Guest - Verify Text displaying as "Stop 2"
    Then Guest - Update details
      |Upload Files_2|
      |bighog.jpg|
    Then Wait for "25" Seconds
    Then Guest - Click on Upload Modal button with Text "Done"
    Then Wait for "3" Seconds
    Then Guest - Click on Stop 2 button with Text "Submit for Payment"
    Then Wait for "5" Seconds
    Then Guest - Verify Text displaying as "Bill Of Lading"

# Step 14
    Then Guest - Click on button with Text "Return to Load List"
    Then Wait for "3" Seconds
    Then Guest - Verify Text displaying as "Carrier Load List"

# Step 15
    Then Close Guest Browser
    Then Wait for "80" Seconds

# Step 16
    Then Refresh current Page
    Then Navigate to stored URL for "Load_1"
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds

    Then Scroll into Section "Carrier Quotes"
    Then Click on "Carrier Quote" with "Carrier Service" as "Email Carrier One - Truckload"
    Then Wait for "3" Seconds

    Then Go to "Settlement" Tab with More Menu
    Then Wait for "5" Seconds
    Then Scroll into Section "Vendor Invoice Summary"
    Then Verify details for
      | Vendor               | Vendor Invoice Number | Vendor Invoice Date | Vendor Settlement Total | Variance Description |
      | Email Carrier One    | 2856                  | 0                   | USD 1,000.00            | egg prices           |

# Step 17
    Then Navigate to stored URL for "Load_1"
    Then Go to "Documents" Tab
    Then Wait for "60" Seconds
    Then Refresh current Page
    Then Go to "Documents" Tab
    Then Wait for "5" Seconds

# Step 18 - Verify Bill of Lading file
    Then Verify Text displaying as "Bill Of Lading.jpeg"

# Step 19 - Verify Carrier Invoice file
    Then Verify Text displaying as "Carrier Invoice.png"

