Feature:2788 - MatchLoadsToPayIQParticipants Job - Filters
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2788
  Scenario: 2788 - MatchLoadsToPayIQParticipants Job - Filters

    When Login into Salesforce

#    Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "PayIQ Program Filters" from Search List

    #Step 2
    Then Click on Edit icon on Label "Status"
    Then Update details
          |Status|
          |Open|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Open|
    Then Capture the current URL for "PayIQ_Program_1"

#    Step 2
     Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Parts       | 5259   | NA           | NA       | NA             |
    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 3
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact)    |
      | Second User        | Joe Philadelphia Eagles |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Second User        |
    Then Go to "Details" Tab
    Then Scroll into Section "Carrier Requirements"
    Then Click on Edit icon on Label "Equipment Weight Units"
    Then Update details
    |Other Instructions|Team|
    |AbcTest123        |True|
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Other Instructions |
      | AbcTest123         |
    Then Click on Edit icon on Label "Equipment Weight Units"
    Then Update details
      |Team|
      |False|
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds

#    Step 4
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "7" Seconds
    #Step 5 & expected a
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Capture the current URL for "PayIQ_Admin"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Other Instructions contains Abc123, Actual: AbcTest123"

#    Step 6
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Carrier Requirements"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Equipment Weight Units"
    Then Update details
      | Other Instructions | Team |
      | Abc123             | True |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Other Instructions |
      | Abc123             |
    Then Click on Edit icon on Label "Equipment Weight Units"
    Then Update details
      |Team|
      |False|
    Then Click on "SaveEdit" button

    #Step 7 & expected b
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Other Carrier Capabilities contains HazMat Certified (US), Actual: null"

    #Step 8
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Carrier Requirements"
    Then Click on Edit icon on Label "Other Carrier Capabilities"
    Then Select "Other Carrier Capabilities" as "HazMat Certified (US)" from Dueling List
    Then Scroll into Section "Import/Export Information"
    Then Update details
      | Tender Accept Link |
      | www.abcd.com       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Other Carrier Capabilities |
      | HazMat Certified (US)       |

    #Step 9 & expected c
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Tender Accept Link != www.abcd.com, Actual: www.abcd.com"

#    Step 10
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Import/Export Information"
    Then Click on Edit icon on Label "Tender Accept Link"
    Then Update details
      | Tender Accept Link |
      |                  |
    Then Scroll into Section "Tracking Information"
    Then Update Legend details
      | Last Tracking Update, Date | Last Tracking Update, Time |
      | 01/01/3001                 | 9:00 AM                    |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

#    Step 11 & expected d
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Last Tracking Update != 01 Jan 3001 15:00:00 GMT, Actual: 3001-01-01 15:00:00"

    #Step 12
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Last Tracking Update"
    Then Update Legend details
      | Last Tracking Update, Date |
      |         NA                 |
    Then Scroll into Section "Load Summary"
    Then Update details
    |HazMat|
    |True|
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

    #Step 13 & expected e
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: HazMat = false, Actual: true"

    #Step 14
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "HazMat"
    Then Update details
      | HazMat | Cargo Value |
      | False  | 1000        |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Cargo Value  |
      | USD 1,000.00 |

    #Step 15 & expected f
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Cargo Value != 1000, Actual: 1000.0"

    #Step 16
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Cargo Value"
    Then Update details
      | Cargo Value |Total Weight|
      |             |5000        |
    Then Enter Label "Cargo Value" Text as ""
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Total Weight |
      | 5,000        |

    #Step 17 & expected g
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Total Weight = 5259, Actual: 5000.0"

    #Step 18
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Total Weight"
    Then Update details
      | Total Weight |
      | 5259         |
    Then Scroll into Section "Customer Order Information"
    Then Set "Order_date" with "01/01/2001"
    Then Update details
      | Order Date          |
      | SysData=>Order_date |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Order Date |
      | 1/1/2001   |

    #Step 19 & expected h
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Order Date != 01 Jan 2001, Actual: 2001-01-01 00:00:00"

    #Step 20
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on Label "Order Date"
    Then Update details
      | Customer            |Order Date|
      | Grand Rapids Kayaks |NA          |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer            |
      | Grand Rapids Kayaks |

    #Step 21 & expected i
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Customer = Chicago Pizza, Actual: Grand Rapids Kayaks"

    #Step 22
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on Label "Order Number"
    Then Wait for "1" Seconds
    Then Update details
       | Customer            |
       | Chicago Pizza |
    Then Scroll into Section "Team Assignments & Status"
    Then Update details
      | Load Status     |
      | Quotes Received |
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds
    Then Verify Details
      | Load Status     |
      | Quotes Received |

    #Step 23 & expected j
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Load Status any Unassigned;Assigned;Delivered, Actual: Quotes Received"

    #Step 24
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status |
      | Assigned    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 25
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "10.00"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."
    Then Store Customer Quote value on "Customer_Quote1"

    #Step 26 & expected k
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Go to "Logs" Tab
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Normalized Text displaying as "Filter from program \"PayIQ Program Filters\" not met: Quoted Margin $ = 0, Actual: 10.0"

    #Step 27

  Then Set key "Customer_Quote" for Object "rtms__CustomerQuote__c" and Name "SysData=>Customer_Quote1"
  Then Delete "rtms__CustomerQuote__c" with Id "Customer_Quote"

#    Step 28
    Then Navigate to stored URL for "PayIQ_Admin"
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 29 & expected l
    Then Navigate to stored URL for "Load_1L"
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Participant Matches"
    Then Store date "2" days and "0" "months" from current date into "Future_Date"
    Then Click on link "Participant Matches"
    Then Verify table has "1" records with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "PayIQ Program" as "PayIQ Program Filters" and "Eligible Date" as "SysData=>Future_Date"
    Then Store current date in format "M/d/yyyy" into "Today"
    Then Verify table has "1" records with "Participant Name" as "Second User (User)" and "PayIQ Program" as "PayIQ Program Filters" and "Eligible Date" as "SysData=>Today"

      #Step 30 & expected m
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Filters"
    Then Click on "Filter-" with "Field" as "Customer"
    Then Verify "Customer" Attribute "data-value" displaying as "Chicago Pizza"












