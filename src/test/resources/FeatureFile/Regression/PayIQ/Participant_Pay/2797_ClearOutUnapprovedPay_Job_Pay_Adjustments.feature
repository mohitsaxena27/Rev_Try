Feature:2797 - ClearOutUnapprovedPay Job - Pay Adjustments

  @API @Regression @PayIQ @WEB @SingleCurrency @2797
  Scenario:2797 - ClearOutUnapprovedPay Job - Pay Adjustments

    When Login into Salesforce
    Then Delete All Records with name "L-" for "rtms__Load__c"
    Then Delete All Records with name "Pay Adjustment-" for "rtms9__Pay_Adjustment__c"
    # Pre-condition 1-2: Open PayIQ Program 1936 and set Status to Open
    Then Open "PayIQ Programs" from App Launcher
    Then Search And Select "PayIQ Program 1936" from Search List
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program_1"

    # Step 1: Create a new Quick Entry shipment
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Kayaks      | 999    | NA           | NA       | NA             |
    Then Save Load With All details

    # Step 2: Store the created Load record for later navigation
    Then Capture the current URL for "Load_1L"

    # Step 3: Set PayIQ fields on the Load
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)    | Customer Sales Rep |
      | Joe Philadelphia Eagles | Second User        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact)    | Customer Sales Rep |
      | Joe Philadelphia Eagles | Second User        |

    # Step 4: Execute PayIQ Jobs Now
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 5: Return to the created Load
    Then Navigate to stored URL for "Load_1L"

    # Step 6a: Validate and capture original Participant Match IDs
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Participant Matches"
    Then Verify Table "Participant Matches" row count is "2"
    Then Click on "Participant Match-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)"
    Then Get Details
      | Participant Match ID |
      |                      |
    Then Set "PM_Joe_Original" with "SysData=>Participant Match ID"

    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Participant Matches"
    Then Click on "Participant Match-" with "Participant Name" as "Second User (User)"
    Then Get Details
      | Participant Match ID |
      |                      |
    Then Set "PM_SecondUser_Original" with "SysData=>Participant Match ID"

    # Step 6b: Validate and capture original Pay Detail IDs
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Verify Table "Pay Details" row count is "2"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)"
    Then Get Details
      | Pay Detail ID | Pay Header |
      |               |            |
    Then Set "PD_Joe_Original" with "SysData=>Pay Detail ID"
    Then Set "PH_Joe_Original" with "SysData=>Pay Header"
    Then Capture the current URL for "PD_Joe_Original_URL"

    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Second User (User)"
    Then Get Details
      | Pay Detail ID | Pay Header |
      |               |            |
    Then Set "PD_SecondUser_Original" with "SysData=>Pay Detail ID"
    Then Set "PH_SecondUser_Original" with "SysData=>Pay Header"
    Then Capture the current URL for "PD_SecondUser_Original_URL"

    # Step 6c: Open Joe Philadelphia Eagles Pay Header
    Then Navigate to stored URL for "Load_1L"
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Header-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)"
    Then Wait for "3" Seconds
    Then Capture the current URL for "PH_Joe_Original_URL"

    # Step 7-11: Create Joe Philadelphia Eagles Pay Adjustments
    # Step 7. Category = Addition, Type = Fuel Purchase, Generated = TRUE, Qty = 1, Rate = 10, Status = Pending
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on link "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Update details
      | Category | Type          | Generated | Qty | Rate | Status  |
      | Addition | Fuel Purchase | True      | 1   | 10   | Pending |
    Then Click on "Save & New" with Text
    Then Wait for "3" Seconds

    # Step 8. Category = Deduction, Type = Tire Purchase, Generated = TRUE, Qty = 1, Rate = 20, Status = Under Review
    Then Update details
      | Category  | Type          | Generated | Qty | Rate | Status       |
      | Deduction | Tire Purchase | True      | 1   | 20   | Under Review |
    Then Click on "Save & New" with Text
    Then Wait for "3" Seconds

    # Step 9. Category = Addition, Type = Hotel/Motel, Generated = FALSE, Qty = 1, Rate = 15, Status = Approved
    Then Update details
      | Category | Type        | Generated | Qty | Rate | Status   |
      | Addition | Hotel/Motel | False     | 1   | 15   | Approved |
    Then Click on "Save & New" with Text
    Then Wait for "3" Seconds

    # Step 10. Category = Deduction, Type = Accident Insurance, Generated = FALSE, Qty = 1, Rate = 5, Status = Declined
    Then Update details
      | Category  | Type               | Generated | Qty | Rate | Status   |
      | Deduction | Accident Insurance | False     | 1   | 5    | Declined |
    Then Click on "Save" with Text
    Then Wait for "3" Seconds

    # Step 11a: Note Pay Adjustment IDs for Approved and Declined records
    Then Navigate to stored URL for "PH_Joe_Original_URL"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Type" as "Hotel/Motel"
    Then Get Details
      | Pay Adjustment ID |
      |                   |
    Then Set "PA_Joe_Approved" with "SysData=>Pay Adjustment ID"

    Then Navigate to stored URL for "PH_Joe_Original_URL"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Type" as "Accident Insurance"
    Then Get Details
      | Pay Adjustment ID |
      |                   |
    Then Set "PA_Joe_Declined" with "SysData=>Pay Adjustment ID"

    # Step 12-13: Open Second User Pay Header
    Then Navigate to stored URL for "Load_1L"
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Header-" with "Participant Name" as "Second User (User)"
    Then Wait for "3" Seconds
    Then Capture the current URL for "PH_SecondUser_Original_URL"

    # Step 14-18: Create Second User Pay Adjustments
    # Step 14. Category = Addition, Type = Fuel Purchase, Generated = TRUE, Qty = 1, Rate = 10, Status = Pending
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on link "Pay Adjustments"
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Update details
      | Category | Type          | Generated | Qty | Rate | Status  |
      | Addition | Fuel Purchase | True      | 1   | 10   | Pending |
    Then Click on "Save & New" with Text
    Then Wait for "3" Seconds

    # Step 15. Category = Deduction, Type = Tire Purchase, Generated = TRUE, Qty = 1, Rate = 20, Status = Under Review
    Then Update details
      | Category  | Type          | Generated | Qty | Rate | Status       |
      | Deduction | Tire Purchase | True      | 1   | 20   | Under Review |
    Then Click on "Save & New" with Text
    Then Wait for "3" Seconds

    # Step 16. Category = Addition, Type = Hotel/Motel, Generated = FALSE, Qty = 1, Rate = 15, Status = Approved
    Then Update details
      | Category | Type        | Generated | Qty | Rate | Status   |
      | Addition | Hotel/Motel | False     | 1   | 15   | Approved |
    Then Click on "Save & New" with Text
    Then Wait for "3" Seconds

    # Step 17. Category = Deduction, Type = Accident Insurance, Generated = FALSE, Qty = 1, Rate = 5, Status = Declined
    Then Update details
      | Category  | Type               | Generated | Qty | Rate | Status   |
      | Deduction | Accident Insurance | False     | 1   | 5    | Declined |
    Then Click on "Save" with Text
    Then Wait for "3" Seconds

    # Step 18a: Note Pay Adjustment IDs for all four records
    Then Navigate to stored URL for "PH_SecondUser_Original_URL"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Type" as "Fuel Purchase"
    Then Get Details
      | Pay Adjustment ID |
      |                   |
    Then Set "PA_SecondUser_Pending" with "SysData=>Pay Adjustment ID"

    Then Navigate to stored URL for "PH_SecondUser_Original_URL"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Type" as "Tire Purchase"
    Then Get Details
      | Pay Adjustment ID |
      |                   |
    Then Set "PA_SecondUser_UnderReview" with "SysData=>Pay Adjustment ID"

    Then Navigate to stored URL for "PH_SecondUser_Original_URL"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Type" as "Hotel/Motel"
    Then Get Details
      | Pay Adjustment ID |
      |                   |
    Then Set "PA_SecondUser_Approved" with "SysData=>Pay Adjustment ID"

    Then Navigate to stored URL for "PH_SecondUser_Original_URL"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Click on "Pay Adjustment-" with "Type" as "Accident Insurance"
    Then Get Details
      | Pay Adjustment ID |
      |                   |
    Then Set "PA_SecondUser_Declined" with "SysData=>Pay Adjustment ID"

    # Step 19: Set Payment Status to Approved on Second User Pay Header
    Then Navigate to stored URL for "PH_SecondUser_Original_URL"
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Approved       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Approved       |

    # Step 20: Execute PayIQ Jobs Now
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 21-22: Return to Load, check Participant Matches & Pay Details
    Then Navigate to stored URL for "Load_1L"
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Participant Matches"

    # Expected Result a: Verify 3 Participant Matches render
    Then Verify Table "Participant Matches" row count is "3"

    # Expected Result b: Verify 2 Pay Details render
    Then Scroll Until Related List for "Pay Details"
    Then Verify Table "Pay Details" row count is "2"

    # Step 22c & Expected Result c: Open Joe's Pay Header, check Pay Adjustments
    Then Navigate to stored URL for "PH_Joe_Original_URL"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify Table "Pay Adjustments" row count is "2"
    Then Verify table contains "1" records with "Category" as "Addition" and "Type" as "Hotel/Motel" and "Status" as "Approved"
    Then Verify table contains "1" records with "Category" as "Deduction" and "Type" as "Accident Insurance" and "Status" as "Declined"

    # Step 23 & Expected Result d: Open Second User Pay Header, check Pay Adjustments
    Then Navigate to stored URL for "PH_SecondUser_Original_URL"
    Then Scroll Until Related List for "Pay Adjustments"
    Then Verify Table "Pay Adjustments" row count is "4"
    Then Verify table contains "1" records with "Category" as "Addition" and "Type" as "Fuel Purchase" and "Status" as "Pending"
    Then Verify table contains "1" records with "Category" as "Deduction" and "Type" as "Tire Purchase" and "Status" as "Under Review"
    Then Verify table contains "1" records with "Category" as "Addition" and "Type" as "Hotel/Motel" and "Status" as "Approved"
    Then Verify table contains "1" records with "Category" as "Deduction" and "Type" as "Accident Insurance" and "Status" as "Declined"

