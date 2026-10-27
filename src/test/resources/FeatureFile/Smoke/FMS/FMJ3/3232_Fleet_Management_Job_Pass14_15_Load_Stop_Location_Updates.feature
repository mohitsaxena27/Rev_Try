Feature: 3232 - Fleet Management Job 3 - Pass 14+15 - Load/Stop Location Updates*

  @API @Regression @Smoke @WEB @FMS @Fleet_Management_Job @SingleCurrency @3232
  Scenario: 3232 - Fleet Management Job 3 - Pass 14+15 - Load/Stop Location Updates*

    When Login into Salesforce
    Then Delete Field with Title "SamsaraGetMessagesOperation"
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "rip Plan" for "rtms__TripPlanSegment__c"

    Then Get All "fleet/drivers" and Store Response into "Samsara_Vehicle_Details"
    Then Get "id" from "Samsara_Vehicle_Details" where "name" is "Bruce Fleet Carrier Two 1" and store into "Driver_ELD"

    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 1" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID              | ELD Enabled |
      | SysData=>Driver_ELD | True        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "8" Seconds
    Then Verify Details
      | ELD ID              | ELD Enabled |
      | SysData=>Driver_ELD | True        |

    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    And Update details for "Catena" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

    # Step 2 a
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | true                 |
    And Update the Custom Select option "Logging User" as "User User"

    # Step 2 b
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    Then Update details -
      | Fleet Management Enabled | Fleet Management Job Last Run |
      | True                     | 5/30/2021 9:30 AM             |
    And Click on Button with Value "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame

    #Step 3
    Given Upload File "SamsaraGetVehicleStatisticsOperation-3232A.txt" with Title "SamsaraGetVehicleStatisticsOperation"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "SamsaraGetVehicleStatisticsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "SamsaraGetVehicleStatisticsOperation" -
    Then Enter File Label "API Name" Text as "SamsaraGetVehicleStatisticsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    # Step 4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      | Fleet |
      | True  |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | 0900             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Joliet Jazz Supplies | 0             | NA                       | 1315-1345        | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 5
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    # Step 5.a
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Search                    | Driver                    | Driver Confirmation Status | Load        |
      | Tractor ThreeTwoThreeZero | Bruce Fleet Carrier Two 1 | Accepted                   | SysData=>1L |
    Then Wait for "3" Seconds

    Then Update "1" leg details
      | Start Type | Location          |
      | Location   | Chicago White Sox |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 0            | 6:00 AM      |
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Due Out Time |
      | 10:30 AM     |
    Then Wait for "2" Seconds

    # Step 5.b
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Verify "1" Segment details
      | Status     |
      | Configured |
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    # Step 6
    Then Click on button with Title "Dispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Verify Success Message displaying as "Trip has been successfully created in the ELD."
    Then Close Toast message
    Then Close Toast message
    Then Wait for "3" Seconds
    Then Verify "1" Segment details
      | Status     |
      | Dispatched |
    Then Wait for "3" Seconds
    Then Click on button with Title "Save & Close"
    Then Wait for "2" Seconds

    # Step 7
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Wait for "6" Seconds
    Then Get Date and Time for "Previous Run Time" of "FleetManagementJob3" onto "PreviousRunTime_1"
    Then Convert Date Time format "PreviousRunTime_1" from "M/d/yyyy, hh:mm a" to "M/d/yyyy, h:mm a"

    # Step 8
    Then Verify and Delete "FleetManagementJob3" from Scheduled Jobs

    # Step 9
    Then Navigate to stored URL for "Load_1"

    # Expected a
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

    # Step 10
    Then Go to "Details" Tab

    # Expected b
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Last Reported City | Last Reported State/Province | Last Reported Country | Last Reported Geolocation |
      | Omaha              | NE                           | US                    | 41.257169, -95.995102     |
    Then Scroll into Section "Tracking Information"
    Then Verify Details
      | Last Tracking Update       | Last Tracking Update Source |
      | SysData=>PreviousRunTime_1 | ELD                         |
    Then Scroll into Section "Team Assignments & Status"
    Then Verify Details
      | Load Status Comments |
      | Bannockburn, IL      |
    Then Scroll into Section "Assigned Carrier Information"
    Then Verify Details
      | Driver                    | Driver Name               | Driver Phone | Tractor Number            |
      | Bruce Fleet Carrier Two 1 | Bruce Fleet Carrier Two 1 | 312-333-4444 | Tractor ThreeTwoThreeZero |

    # Step 11
    Then Go to "Shipment" Tab
    Then Load Summary - Click on "1P" "Chicago Pizza" Text
    Then Wait for "2" Seconds

    # Expected c
    Then Scroll into Section "Latest Carrier Update"
    Then Verify Details
      | Carrier Status as of       |
      | SysData=>PreviousRunTime_1 |
    Then Scroll into Section "In Transit Information"
    Then Verify Details
      | Miles Away | Kilometers Away |
      | 472.363    | 760.195         |

    # Step 12
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Job Last Run |
      | 9/15/2021 9:30 AM             |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 13
    Then Delete Field with Title "SamsaraGetVehicleStatisticsOperation"

    # Step 14
    Given Upload File "SamsaraGetVehicleStatisticsOperation-3232B.txt" with Title "SamsaraGetVehicleStatisticsOperation"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "SamsaraGetVehicleStatisticsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "SamsaraGetVehicleStatisticsOperation" -
    Then Enter File Label "API Name" Text as "SamsaraGetVehicleStatisticsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    # Step 15
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Wait for "6" Seconds
    Then Get Date and Time for "Previous Run Time" of "FleetManagementJob3" onto "PreviousRunTime_2"
    Then Verify and Delete "FleetManagementJob3" from Scheduled Jobs

    # Step 16
    Then Navigate to stored URL for "Load_1"

    # Expected d
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

    # Step 17
    Then Go to "Details" Tab

    # Expected e
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Last Reported City | Last Reported State/Province | Last Reported Country | Last Reported Geolocation |
      | Evergreen          | CO                           | US                    | 39.71136, -105.34851      |
    Then Scroll into Section "Tracking Information"
    Then Verify Details
      | Last Tracking Update       | Last Tracking Update Source |
      | SysData=>PreviousRunTime_2 | ELD                         |
    Then Scroll into Section "Team Assignments & Status"
    Then Verify Details
      | Load Status Comments |
      | Bannockburn, IL      |
    Then Scroll into Section "Assigned Carrier Information"
    Then Verify Details
      | Driver                    | Driver Name               | Driver Phone | Tractor Number            |
      | Bruce Fleet Carrier Two 1 | Bruce Fleet Carrier Two 1 | 312-333-4444 | Tractor ThreeTwoThreeZero |

    # Step 18
    Then Go to "Shipment" Tab
    Then Load Summary - Click on "1P" "Chicago Pizza" Text
    Then Wait for "2" Seconds

    # Expected c
    Then Scroll into Section "Latest Carrier Update"
    Then Verify Details
      | Carrier Status as of       |
      | SysData=>PreviousRunTime_2 |
    Then Scroll into Section "In Transit Information"
    Then Verify Details
      | Miles Away | Kilometers Away |
      | 1,027.983  | 1,654.379       |