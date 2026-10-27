Feature:2793 - PayIQ Admin LWC - Log Filters

  @API @Regression @PayIQ  @WEB @SingleCurrency @2793
  Scenario: 2793 - PayIQ Admin LWC - Log Filters

    When Login into Salesforce

   # Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

    #Step 2 & 3
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

    #Step 4
    Then Click on "New" button on "Roles" section
    Then Update details
      | Parent Object | Lookup Type | Eligible Date Field |
      | Driver Log    | Driver      | Certified as of     |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Click on "Role-" with "Parent Object" as "Driver Log"
    Then Wait for "3" Seconds
    Then Set Key "Role_SFID_1" page Record Id with "rtms9__Load_Role__c"

    #Step 5
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Click on "New" button on "Roles" section
    Then Update details
      | Parent Object | Lookup Type | Eligible Date Field |
      | Trip Plan Leg | Driver      | Arrival Date        |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Click on "Role-" with "Parent Object" as "Trip Plan Leg"
    Then Wait for "3" Seconds
    Then Set Key "Role_SFID_2" page Record Id with "rtms9__Load_Role__c"

    #Step 6
    Then Open "Driver Logs" from App Launcher
    Then Wait for "3" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Driver                     | Driving Duration | On Duty Duration | Certification Status |
      | Bruce Fleet Carrier Two 26 | 30               | 40               | Certified            |
    Then Update Legend details
      | Start Time, Date | End Time, Date | Certified as of, Date | Start Time, Time | End Time, Time | Certified as of, Time |
      | 0                | 3              | 0                     | 12:00 PM         | 12:00 PM       | 12:00 PM              |
    Then Wait for "5" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Set Key "DriverLog_SFID" page Record Id with "rtms__DriverLog__c"
    Then Get Details
      | Driver Log Name |
      |                 |

    #Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Update details
      | Fleet |
      | True  |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 8
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date |
      | Joe Revenova PayIQ   | 0                          |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact) |
      | Joe Revenova PayIQ   |

    #Step 9 & 10
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    #Step 11
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds
    Then Update "1" Segment details
      | Search       | Driver                     | Load        |
      | Tractor 1001 | Bruce Fleet Carrier Two 26 | SysData=>1L |
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "3" Seconds
    Then Update "1" leg details
      | Due Out Time |
      | 6:00 AM      |

    #Step 12
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Get Trip Plan ID and store as "Trip_Plan_ID1"
    Then Click on button with Title "Close"
    Then Wait for "2" Seconds

    #Step 13 & 14
    Then Get "Id" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" & "name" with value "Segment 1" and Store onto "Segment_1_ID"
    Then Search and Select "rtms__TripPlanSegment__c" With ID "SysData=>Segment_1_ID" from the Global search
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Name"
    Then Update details
      | Name              |
      | Testing Segment 1 |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Name              |
      | Testing Segment 1 |
    
    Then Go to "Related" Tab
    Then Click on link "Trip Plan Legs"
    Then Wait for "2" Seconds
    Then Click on "Leg 1" with Text
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Leg Name"
    Then Update details
      | Leg Name      |
      | Testing Leg 1 |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Set Key "Leg_SFID_1" page Record Id with "rtms__TripPlanLeg__c"

    #Step 16
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds

    #Step 17
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 18 & expected a
    Then Go to "Logs" Tab
    Then Update details
      | Load        |
      | SysData=>1L |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"

    #Step 19 & expected b
    Then Update details
      | Load | Driver Log               |
      |      | SysData=>Driver Log Name |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify all values in the PayIQ Admin log Driver log column should be "SysData=>Driver Log Name"

    #Step 20 & expected c
    Then Update details
      | Driver Log | Trip Plan              |
      |            | SysData=>Trip_Plan_ID1 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Set "Trip_Plan_Leg" with "SysData=>Trip_Plan_ID1" and " / Testing Segment 1 / Testing Leg 1"
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"
    Then Verify all values in the PayIQ Admin log Trip Plan Leg column should be "SysData=>Trip_Plan_Leg"

    #Step 21 & expected d
    Then Update details
      | Trip Plan | Trip Plan Segment |
      |           | Testing Segment 1 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Set "Trip_Plan_Leg" with "SysData=>Trip_Plan_ID1" and " / Testing Segment 1 / Testing Leg 1"
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"
    Then Verify all values in the PayIQ Admin log Trip Plan Leg column should be "SysData=>Trip_Plan_Leg"

    #Step 22 & expected e
    Then Update details
      | Trip Plan Segment | Trip Plan Leg |
      |                   | Testing Leg 1 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Set "Trip_Plan_Leg" with "SysData=>Trip_Plan_ID1" and " / Testing Segment 1 / Testing Leg 1"
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"
    Then Verify all values in the PayIQ Admin log Trip Plan Leg column should be "SysData=>Trip_Plan_Leg"

    #Step 23 & expected f
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Trip Plan Segment | Trip Plan Leg |
      | Testing Segment 1 | Testing Leg 1 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Set "Trip_Plan_Leg" with "SysData=>Trip_Plan_ID1" and " / Testing Segment 1 / Testing Leg 1"
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"
    Then Verify all values in the PayIQ Admin log Trip Plan Leg column should be "SysData=>Trip_Plan_Leg"

    #Step 24 & expected g
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Trip Plan Segment | Trip Plan Leg | Trip Plan              |
      | Testing Segment 1 | Testing Leg 1 | SysData=>Trip_Plan_ID1 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Set "Trip_Plan_Leg" with "SysData=>Trip_Plan_ID1" and " / Testing Segment 1 / Testing Leg 1"
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"
    Then Verify all values in the PayIQ Admin log Trip Plan Leg column should be "SysData=>Trip_Plan_Leg"

    #Step 25 & expected h
    Then Update details
      | Trip Plan Leg |
      |               |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Set "Trip_Plan_Leg" with "SysData=>Trip_Plan_ID1" and " / Testing Segment 1 / Testing Leg 1"
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"
    Then Verify all values in the PayIQ Admin log Trip Plan Leg column should be "SysData=>Trip_Plan_Leg"

    #Step 26 & 27
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Trip Plan Segment | Trip Plan Leg | Trip Plan              |
      | Testing Segment 1 | Testing Leg 1 | SysData=>Trip_Plan_ID1 |
    Then Click on button "Refresh"
    Then Update details
      | Trip Plan |
      |           |
    Then Wait for "2" Seconds

    #expected i
    Then Verify Label "Trip Plan" field is empty
    Then Verify Label "Trip Plan Segment" field is empty
    Then Verify Label "Trip Plan Leg" field is empty

    #Step 28 & expected j
    Then Update details
      | Load        | Type          |
      | SysData=>1L | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"
    Then Verify PayIQ Admin log Type column "has" "Qualification"

    #Step 29
    Then Update details
      | Type |
      | Math |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Step 30 & expected k
    Then Verify all values in the PayIQ Admin log Load column should be "SysData=>1L"
    Then Verify PayIQ Admin log Type column "has" "Math"

    #Step 31 & 32
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    #Step 33
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds
    Then Update "1" Segment details
      | Search       | Driver                     |
      | Tractor 1002 | Bruce Fleet Carrier Two 27 |
    Then Update "1" leg details
      | Start Type | Location           | Due Out Date | Due Out Time | End Type | Location_2         | Appointment Date |
      | Location   | Chicago Blackhawks | 0            | 12:15 AM     | Location | Pittsburgh Pirates | 3                |
    Then Wait for "3" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Get Trip Plan ID and store as "Trip_Plan_ID2"
    Then Click on button with Title "Close"
    Then Wait for "2" Seconds

    #Step 34
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds

    #Step 35
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Wait for "1" Seconds
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 36
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Go to "Logs" Tab
    Then Update details
      | Type     | Trip Plan              |
      | --None-- | SysData=>Trip_Plan_ID1 |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Step 37 & expected l
    Then Enter Label "Trip Plan Segment" as "Segment 1"
    Then Wait for "2" Seconds
    Then Verify Title displaying as "Testing Segment 1"
    Then Verify Button with Title not displaying as "Segment 1" -

    #Step 38 & expected m
    Then Enter Label "Trip Plan Leg" as "Leg 1"
    Then Wait for "2" Seconds
    Then Verify Title displaying as "Testing Leg 1"
    Then Verify Button with Title not displaying as "Leg 1" -
