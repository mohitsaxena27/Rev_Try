Feature: 3505 - Banyan API- GetDocumentOperation

  @API @Regression @TMS @WEB @API_Operation @SingleCurrency @3505 @BanyanAPI @Debugging
  Scenario: 3505 - Banyan API- GetDocumentOperation

    When Login into Salesforce

  # Step 1
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

  # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Banyan Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | 0            | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 6500   | NA          | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |
    Then Save Load With All details

  # Step 3
    Then Capture the current URL for "Load_1"

   # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds
    Then Click on View Quotes
    Then Wait for "2" Seconds
    Then Select "Banyan Test 3PL Carrier - Banyan" from View Quotes
    Then Wait for "1" Seconds
    Then Click on Native "Tender" icon
    Then Verify Message displaying as "Load tendered successfully."

  # Step 5
    Then Click on "2D" "Arrived" chevron
    Then Update details
      | Arrival Date |
      | 0            |
    Then Click on "2D" "Save" button
    Then Wait for "8" Seconds
    Then Refresh current Page

  # Step 6
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Completed          |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Completed"
    Then Verify Details
      |Load Status      |
      |Completed         |

  # Step 7
    Then Go to Home Page
    Then Run "LoadStatusUpdateJob" Job
    Then Wait for "6" Seconds

  # Step 8 Expected result a
    Then Navigate to stored URL for "Load_1"
    Then Refresh current Page
    Then Go to "Documents" Tab
    Then Go to "Files" Tab
    Then Wait for "6" Seconds
    Then Verify Text displaying as "Banyan - BOL.pdf"