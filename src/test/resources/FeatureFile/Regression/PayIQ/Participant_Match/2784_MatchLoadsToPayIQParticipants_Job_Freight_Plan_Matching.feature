Feature: 2784 - MatchLoadsToPayIQParticipants Job - Freight Plan Matching

  @API @Regression @PayIQ @WEB @SingleCurrency @2784
  Scenario: 2784 - MatchLoadsToPayIQParticipants Job - Freight Plan Matching

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"
    # Pre-Condition
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
    Then Scroll Until Related List for "Participants"
    Then Click on "New" button on "Participants" section
    Then Update details
      | Type | User       |
      | User | Test User1 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Participants"
    Then Get "Participant-" Name with "Name" as "Test User1" and store in "Participant_Name_1"
    Then Scroll down with "3" Times
    Then Wait for "2" Seconds
    Then Click on "Participant-" with "Name" as "Test User1"
    Then Wait for "2" Seconds
    Then Verify Details
      | Type | User       |
      | User | Test User1 |
    Then Set Key "Participant_SFID" page Record Id with "rtms9__Participant__c"

    # Step 1
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
    Then Wait for "2" Seconds
    Then Capture the current URL for "Load_1L"

    # Step 2
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact)    |
      | Second User        | Joe Philadelphia Eagles |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep | Sales Lead (Contact)    |
      | Second User        | Joe Philadelphia Eagles |

    # Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Grand Rapids Kayaks | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Texas Rangers | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Rapids      | 999    | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_2L"

    # Step 4
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact)    |
      | Second User        | Joe Philadelphia Eagles |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep | Sales Lead (Contact)    |
      | Second User        | Joe Philadelphia Eagles |

    # Step 5
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Select Multiple Records from List
      | Record1     | Record2     |
      | SysData=>1L | SysData=>2L |
    Then Click on "Freight Plan" with Text
    Then Wait for "5" Seconds

    # Step 6
    Then Freight Plan - Click on Checkbox with Location "Grand Rapids, MI"
    Then Freight Plan - Click on Dropdown with Location "Philadelphia Eagles"
    Then Click on "New Load" with Text
    Then Update details
      | Mode      |
      | Truckload |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"

    # Step 7
    Then Freight Plan - Click on Template Panel
    Then Wait for "2" Seconds

    # Step 8
    Then Click on button with Title "Add"
    Then Enter value "Pittsburgh Pirates" with Input having "placeholder" as "Search Locations"
    Then Select Search Result "Pittsburgh Pirates - Pittsburgh, PA"
    Then Wait for "2" Seconds
    Then Click on Title button "Refresh" is displaying with Object "rtms-freightplantemplate_freightplantemplate"
    Then Wait for "2" Seconds
    Then Click on button with Title "Hide Filter/Template Panel"

    # Step 9
    Then Freight Plan - Click on Checkbox with Location "Grand Rapids, MI_2"
    Then Freight Plan - Click on Dropdown with Location "Pittsburgh, PA" inline with "Texas Rangers"
    Then Freight Plan - Select Option "SysData=>FP_Carrier_Load_1" from Dropdown
    Then Wait for "3" Seconds

    # Step 10
    Then Freight Plan - Click on Checkbox with Location "Pittsburgh, PA"
    Then Freight Plan - Click on Dropdown with Location "Texas Rangers" inline with "Grand Rapids Kayaks"
    Then Click on "New Load" with Text
    Then Update details
      | Mode      |
      | Truckload |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Freight Plan - Verify and get the "2" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_2"

    # Step 11
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_1" from List

    # Step 12
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep | Sales Lead (Contact)    |
      | Test User1        | Joe Philadelphia Eagles |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep | Sales Lead (Contact)    |
      | Test User1        | Joe Philadelphia Eagles |
    Then Go to "Shipment" Tab
    Then Expand "Details" for "3" Load
    Then Click on Edit icon with Field Name "3D" "Expected Date"
    Then Update details
      | Expected Date |
      | 1             |
    Then Click on "3D" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    # Step 13
    Then Click on button with Title "Go to Freight Plan"
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan1"

    # Step 14 & 15
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_2" from List

    # Step 16
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep | Sales Lead (Contact)    |
      | Test User1        | Joe Philadelphia Eagles |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep | Sales Lead (Contact)    |
      | Test User1        | Joe Philadelphia Eagles |
    Then Go to "Shipment" Tab
    Then Expand "Details" for "1" Load
    Then Click on Edit icon with Field Name "1P" "Location"
    Then Update details
      | Expected Date |
      | 1             |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Collapse "Details" for "1" Load
    Then Wait for "2" Seconds
    Then Scroll Up with "5" Times
    # Step 17 & 18
    Then Click on button with Title "Go to Freight Plan"
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan2"

    # Step 19
    Then Open "PayIQ Admin" from App Launcher
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 20
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Go to "PayIQ Generated" Tab
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds
    Then Store date with offset "0" as "Today"
    Then Store date with offset "1" as "Tomorrow"
    Then Store date with offset "2" as "TwoDaysDate"

    Then Set "MatchedTo1" with "SysData=>1L" and " / " and "SysData=>Freight_Plan1"
    Then Set "MatchedTo2" with "SysData=>2L" and " / " and "SysData=>Freight_Plan2"
    Then Set "MatchedTo3" with "SysData=>FP_Carrier_Load_1" and " / " and "SysData=>Freight_Plan1"
    Then Set "MatchedTo4" with "SysData=>FP_Carrier_Load_1" and " / " and "SysData=>Freight_Plan2"
    Then Set "MatchedTo5" with "SysData=>FP_Carrier_Load_2" and " / " and "SysData=>Freight_Plan2"

    # Expected Result a
    Then Verify "Participant Matches" Table Details
      | Participant Name                  | Matched To Type | Matched To          | Eligible Date     |
      | Joe Philadelphia Eagles (Contact) | Load            | SysData=>MatchedTo1 | SysData=>Today    |
      | Joe Philadelphia Eagles (Contact) | Load            | SysData=>MatchedTo2 | SysData=>Today    |
      | Joe Philadelphia Eagles (Contact) | Load            | SysData=>MatchedTo3 | SysData=>Today    |
      | Joe Philadelphia Eagles (Contact) | Load            | SysData=>MatchedTo4 | SysData=>Today    |
      | Joe Philadelphia Eagles (Contact) | Load            | SysData=>MatchedTo5 | SysData=>Tomorrow |

    # Expected Result b
    Then Verify "Participant Matches" Table Details
      | Participant Name   | Matched To Type | Matched To          | Eligible Date        |
      | Second User (User) | Load            | SysData=>MatchedTo1 | SysData=>TwoDaysDate |
      | Second User (User) | Load            | SysData=>MatchedTo2 | SysData=>TwoDaysDate |

    # Expected Result c
    Then Verify "Participant Matches" Table Details
      | Participant Name  | Matched To Type | Matched To          | Eligible Date     |
      | Test User1 (User) | Load            | SysData=>MatchedTo3 | SysData=>Today    |
      | Test User1 (User) | Load            | SysData=>MatchedTo4 | SysData=>Today    |
      | Test User1 (User) | Load            | SysData=>MatchedTo5 | SysData=>Tomorrow |
