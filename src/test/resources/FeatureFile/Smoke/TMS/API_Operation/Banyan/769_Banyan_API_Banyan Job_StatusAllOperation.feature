Feature: 769 - Banyan API- Banyan Job (StatusAllOperation + GetDocumentOperation)

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @769 @BanyanAPI @Debugging
  Scenario: 769 - Banyan API- Banyan Job (StatusAllOperation + GetDocumentOperation)

    When Login into Salesforce

  # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Wait for "2" Seconds
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
  # New Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Banyan" in the "Search Credentials..." search box
    Then Select the "Banyan" record from the lookup field results
    Then Wait for "3" Seconds
    And Update details for "Banyan" service
      | Proxy URL |
      | https://qa.revenova.com:8086 |
    And Click on Native "Save" button
    Then Wait for "4" Seconds

  # Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Banyan Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | NA            | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 6500   | NA          | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |
    Then Save Load With All details

  # Step 4
    Then Capture the current URL for "Load_1"

   # Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds
    Then Click on View Quotes
    Then Wait for "2" Seconds
    Then Select "Banyan Test 3PL Carrier - Banyan" from View Quotes
    Then Wait for "1" Seconds
    Then Click on Native "Tender" icon
    Then Verify Message displaying as "Load tendered successfully."

  # Step 6
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "Bill of Lading Number"
    Then Update details
      | Bill of Lading Number | PRO Number |
      | 3000555567            | 207000555  |
    Then Scroll into Section "Tracking IDs"
    Then Update details
      | API Load Id |
      | 63770511    |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "PRO Number" having value of "207000555"



  # Step 7,8,9
    Given Upload File "BanyanStatusAllOperation_769.txt" with Title "BanyanStatusAllOperation"

  # Step 10
    Then Go to Home Page
    Then Run "LoadStatusUpdateJob" Job
    Then Wait for "10" Seconds

  #Step 11      #Expected result a
    Then Navigate to stored URL for "Load_1"
    Then Go to "Summary" Tab
    Then Wait for "1" Seconds
    Then Go to "Shipment" Tab
    Then Scroll into Section "Banyan Customer"
    Then Verify details for
      | Stop Status |
      | Arrived     |
    Then Wait for "1" Seconds

  # Step 12 Expected result b
    Then Click on "1P" "Arrived" chevron
    Then Verify details for all Enabled fields
      | Carrier Status Comments               | Last Reported City | Last Reported State/Province | Last Reported Country |
      | En route to destination Lumberton, NC | Lumberton          | NC                           | US                    |
    Then Refresh current Page
    Then Scroll into Section "Boston Beans"
  # Step 13
    Then Click on "2D" "Arrived" chevron
    Then Update details
      | Arrival Date |
      | 0            |
    Then Click on "2D" "Save" button
    Then Verify "2D" Shipment is "Arrived"
    Then Wait for "8" Seconds
    Then Refresh current Page

  # Step 14
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered         |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      |Load Status      |
      |Delivered         |

  # Step 15
    Then Go to "Home" Object
    Then Verify and Delete "LoadStatusUpdateJob" from Scheduled Jobs

   # Step 16,17,18
    Given Upload File "BanyanGetDocumentOperation_Doc_Type_7_769.txt" with Title "BanyanGetDocumentOperation"

  # Step 19
    Then Go to Home Page
    Then Run "LoadStatusUpdateJob" Job
    Then Wait for "6" Seconds

  # Step 20 Expected result c
    Then Navigate to stored URL for "Load_1"
    Then Refresh current Page
    Then Go to "Documents" Tab
    Then Go to "Files" Tab
    Then Wait for "6" Seconds
    Then Verify Text displaying as "Weight Slip.png"


  # Step 21
    Then Go to "Summary" Tab
    Then Click on "2D" "Departed" chevron
    Then Update details
      | Arrival Date | Departure Date |
      | NA           | 0              |
    Then Click on "2D" "Save" button
    Then Verify "2D" Shipment is "Departed"
    Then Wait for "8" Seconds
    Then Refresh current Page

  # Step 22
    Then Go to "Home" Object
    Then Verify and Delete "LoadStatusUpdateJob" from Scheduled Jobs

  # Step 23
    Then Delete Field with Title "BanyanGetDocumentOperation"

  # Step 24,25
    Given Upload File "BanyanGetDocumentOperation_Doc_Type_0_769.txt" with Title "BanyanGetDocumentOperation"

  # Step 26
    Then Go to Home Page
    Then Run "LoadStatusUpdateJob" Job
    Then Wait for "6" Seconds


  # Step 27 Expected result d
    Then Navigate to stored URL for "Load_1"
    Then Refresh current Page
    Then Wait for "3" Seconds
    Then Go to "Documents" Tab
    Then Go to "Files" Tab
    Then Verify Text displaying as "Banyan BOL.png"

#   Step 28
    Then Navigate to stored URL for "Load_1"
    Then Scroll into Section "Boston Beans"
    Then Click on "2D" "Departed" chevron
    Then Update details
      | Departure Date |
      | NA             |
    Then Click on "2D" "Save" button
    Then Verify "2D" Shipment is "Departed"
    Then Wait for "4" Seconds

    # Step 29
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "2D" "Expected Date"
    Then Update details
      |Expected Date|
      |-1           |
    Then Click on "Save" Button with Type "submit"
    Then Wait for "4" Seconds
    Then Collapse "Details" for "2" Load
    
    # Step 30
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status |
      | Completed   |
    Then Click on "Save" button on Details Page
    Then Verify "Load Status" having value of "Completed"

   # Step 31
    Then Go to "Home" Object
    Then Verify and Delete "LoadStatusUpdateJob" from Scheduled Jobs

  # Step 32
    Then Delete Field with Title "BanyanGetDocumentOperation"

  # Step 33,34
    Given Upload File "BanyanGetDocumentOperation_Doc_Type_2_769.txt" with Title "BanyanGetDocumentOperation"

  # Step 35
    Then Go to Home Page
    Then Run "LoadStatusUpdateJob" Job
    Then Wait for "9" Seconds

   # Step 36 Expected result e
    Then Navigate to stored URL for "Load_1"
    Then Refresh current Page
    Then Go to "Documents" Tab
    Then Go to "Files" Tab
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Carrier BOL.png"

  # Step 37
    Then Delete Field with Title "BanyanGetDocumentOperation"

    # Step 38,39,40
    Given Upload File "BanyanGetDocumentOperation_Doc_Type_3_769.txt" with Title "BanyanGetDocumentOperation"

  # Step 41
    Then Go to Home Page
    Then Run "LoadStatusUpdateJob" Job
    Then Wait for "6" Seconds

  # Step 42 Expected result f
    Then Navigate to stored URL for "Load_1"
    Then Go to "Documents" Tab
    Then Go to "Files" Tab
    Then Wait for "9" Seconds
    Then Verify Text displaying as "Proof of Delivery.png"


