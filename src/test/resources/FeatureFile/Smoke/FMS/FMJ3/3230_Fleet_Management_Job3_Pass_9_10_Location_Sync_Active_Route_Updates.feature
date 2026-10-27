Feature: 3230- Fleet Management Job 3- Pass 9_10 - Location Sync/Active Route Updates

  Background: Pre-Test
    # Samsara precondition
    Then Delete All Records with name "Account 3230" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "Account 3230" for "Account"
    Then Delete all Samsara addresses with name "Account 3230"
    Then Samsara API - Create a Location using Request "Account_3230_Address_Json.txt" and Store Response into "Account_3230_Address_Response"
    Then Get Attribute "data.id" store into "Account_3230" from "Account_3230_Address_Response"

  @API @Regression @WEB @smoke @FMS @Fleet_Management_Job @SingleCurrency  @3230
  Scenario: 3230 - Fleet Management Job 3- Pass 9+10- Location Sync/Active Route Updates

    When Login into Salesforce
#    Then Set "Account_3230" with "4000003757543"
  #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    Then Update details -
      | Fleet Management Enabled |Enable Routing Consolidate Locations|
      | True                     | True                               |
    And Click on Button with Value "Save" -
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

  #Step 2
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 8" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Wait for "2" Seconds
    Then Click on Edit icon with Field Name "ELD Enabled"
    Then Update details
      |ELD ID|ELD Enabled|
      |51799001|True     |
    Then Click on "Save" button
    Then Wait for "2" Seconds

  #Step 3
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |Account 3230|
    Then Select "TMS Type" as "Shipper/Consignee" from Dueling List -
    Then Click on "SaveEdit" button
    Then Wait for "10" Seconds
    Then Scroll into Section "Address Information"
    Then Click on Edit icon with Field Name "Shipping Address"
    Then Update Legend details
      | Shipping Address, Address Search                                             | Billing Address, Address Search                                              |
      | 181 W Madison, Chicago, IL 60602  =>181 West Madison Street      | 181 W Madison, Chicago, IL 60602 =>181 West Madison Street |
    Then Update details
        |Timezone|
        |America/Chicago|
    Then Click on button "Save"
    Then Wait for "3" Seconds
    Then Verify details for
      | Timezone              |
      | America/Chicago       |

  #Step 4
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"
    And Click on Button with Value "ELD Location Download" -
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Location download has started." -
    Then Scroll into Section "Fleet Management" -
    Then Wait for "2" Seconds
    Then Update details -
      |Fleet Management Job Last Run|
      |-3                           |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

  #Step 5
     Then Search and Select "Account 3230" Account from the Global search
     Then Wait for "2" Seconds
     Then Scroll into Section "Address Information"
     Then Click on Edit icon with Field Name "Shipping Address"
     Then Update details
      | Shipping Street           |
      | 181 W Madison, Suite 3715 |
     Then Click on button "Save"
     Then Wait for "3" Seconds

  #Step 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Chicago Pizza |Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      | Fleet |
      | True  |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value           | Expected_Date| Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address  | Account 3230    | 0            | NA                       | 0900             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Joliet Jazz Supplies|  0            | NA                       | 1315-1345        | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

  #Step 7.a
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "3" Seconds
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      | Search                   | Driver                    |
      |Tractor ThreeTwoThreeZero | Bruce Fleet Carrier Two 8 |
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      | Load        |
      | SysData=>1L |
    Then Wait for "5" Seconds
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Wait for "1" Seconds
    Then Update "1" leg details
      | Start Type | Location          | Due Out Date | Due Out Time |
      | Location   | Chicago White Sox | 0            | 6:00 AM      |
    Then Update "2" leg details
      | Due Out Time |
      | 10:30 AM     |

  #Step 7.b
    Then Click on button with Title "Save"
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Verify details for all Enabled fields
      | Status  |
      | Configured |
    Then Verify "1" Segment details
      | Driver Confirmation Status | Status     |
      | Accepted                   | Configured |

  #Step 8
    Then Click on "Dispatch" on "1" Segment
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Verify Message displaying as "Trip has been successfully"
    Then Wait for "5" Seconds
    Then Click on button "Close" on Trip Plan

  # Step 9
    Then Open New Tab with url "https://cloud.samsara.com/o/82103/fleet/dispatch/v2"
    Then Wait for "5" Seconds
    #Then 1PW - Set "username" value of "Samsara - Customer Portal" on "Samsara_UN"
    #Then 1PW - Set "password" value of "Samsara - Customer Portal" on "Samsara_Pwd"
    Then Login to Samsara Account with UserName as "dcraigmile@revenova.com" and Password as "revenova12345"
    Then Wait for "4" Seconds
    Then Refresh current Page
    Then Search Samsara routes for "1L" and click the matching route
    Then Click Samsara route action "Scheduled" for location "Chicago White Sox"
    Then Click Samsara "View details" for location "Chicago White Sox"
    Then Wait for "2" Seconds

  # Step 10
    Then Click Samsara route "Edit"
    Then Wait for "2" Seconds
 #   Then Set Samsara actual arrival time to "2" hours before current time
    Then Set Samsara actual arrival time to "12" hours before current time
 #   Then Set Samsara actual departure time to "1" hours before current time
    Then Set Samsara actual departure time to "11" hours before current time
    Then Wait for "2" Seconds
    Then Click Samsara route "Save"
    Then Verify Message displaying with "Timestamps updated. Changes will be visible on the dashboard shortly."
    Then Wait for Samsara schedule edit modal to close

    #step 11
    Then Click Samsara route "Back"
    Then Wait for "2" Seconds
    Then Click Samsara route action "En Route" for location "Account 3230"
    Then Click Samsara "View details" for location "Account 3230"
    Then Click Samsara route "Edit"
    Then Wait for "2" Seconds
 #   Then Set Samsara actual arrival time to "30" minutes before current time
    Then Set Samsara actual arrival time to "660" minutes before current time
 #   Then Set Samsara actual departure time to "0" hours before current time
    Then Set Samsara actual departure time to "630" hours before current time
    Then Wait for "4" Seconds
    Then Click Samsara route "Save"
    Then Wait for "2" Seconds
    Then Verify Message displaying with "Timestamps updated. Changes will be visible on the dashboard shortly."
    Then Wait for Samsara schedule edit modal to close
    Then Store Samsara displayed actual arrival as "Samsara_Actual_Arrival" and departure as "Samsara_Actual_Departure"
    Then Wait for "5" Seconds
    Then Close and Switch to Previous Window

  # Step 12
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Store current Chicago Time in format of "MM/dd/yyyy, h:mm a" on to "CurrentTime"
    Then Wait for "6" Seconds

  # Step 13
    Then Navigate to stored URL for "Load_1"
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

  # Step 14
    Then Go to "Snapshot" Tab
    Then Verify Details
      |Driver Name              |
      |Bruce Fleet Carrier Two 8|
    Then Verify tracking details
      |Arrival Date|Arrival Time|Departure Date|Departure Time|
      |SysData=>Samsara_Actual_Arrival_Date|SysData=>Samsara_Actual_Arrival_Time|SysData=>Samsara_Actual_Departure_Date|SysData=>Samsara_Actual_Departure_Time|

  # Step 15
    Then Navigate to stored URL for "Load_1"
    Then Refresh current Page
    Then Wait for "5" Seconds
    Then Scroll into Section "Shipment"

  # Expected c
    Then Load Summary - Click on "1P" "Account 3230" Text
    Then Wait for "3" Seconds
    Then Verify details for
      | Arrival Date                        | Arrival Time                         | Departure Date                         |Departure Time |Carrier Status as of|
      |SysData=>Samsara_Actual_Arrival_Date | SysData=>Samsara_Actual_Arrival_Time | SysData=>Samsara_Actual_Departure_Date | SysData=>Samsara_Actual_Departure_Time | SysData=>CurrentTime |

  # Step 16
    Then Samsara API - Get a Location using Id "Account_3230"
    Then Get Attribute "data.formattedAddress" store into "Samsara_Address" from "Account_3230_Response"
    Then Verify Assertion for "Samsara_Address" contains "181 W Madison, Suite 3715, Chicago, IL 60602"

  # Step 17
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer          |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Denver Deli Meats |Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      | Fleet |
      | True  |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value |Expected_Date| Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0            | NA                       | 0915            | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value       | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Account 3230|  3            | NA                       | 1315-1345        | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_2"

  #Step 18 & 19
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "3" Seconds
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "2" Seconds

  #Step 20
    Then Update "1" Segment details
      | Search      | Driver                    |
      |Tractor 1044 | Bruce Fleet Carrier Two 8 |
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      | Load        |
      | SysData=>2L |
    Then Wait for "5" Seconds
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Wait for "1" Seconds
    Then Update "1" leg details
      | Start Type | Location      | Due Out Date | Due Out Time |
      | Location   | Denver Broncos| 0            | 6:00 AM      |
    Then Update "2" leg details
      | Due Out Time |
      | 10:30 AM     |

  #Step 21
    Then Click on "Add Leg Below" on "1" Leg
    Then Wait for "2" Seconds

  #Step 22
    Then Update "2" leg details
      | Due Out Date | Due Out Time |
      | 0            | 10:00 AM     |
    Then Wait for "1" Seconds
    Then Update "2" leg details
      | End Type | Location_2        | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Denver Deli Meats | 0                | 10:15 AM               | 10:45 AM             |
    Then Wait for "1" Seconds

  #Step 23
    Then Verify Segment "1" "Consolidate Same Locations When Routing" is "True"
    Then Click on button with Title "Save"
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID_2"
    Then Verify "1" Segment details
      | Driver Confirmation Status | Status     |
      | Accepted                   | Configured |

  #Step 24
    Then Click on "Dispatch" on "1" Segment
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Verify Message displaying as "Trip has been successfully "
    Then Wait for "5" Seconds

  #Step 25
    Then Set key "TripPlanID" for Object "rtms__TripPlan__c" and Name "SysData=>Trip_Plan_ID_2"
    Then Get "rtms__ELD_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>TripPlanID" & "name" with value "Segment 1" and Store onto "Route"

  #Step 26 & 27
    Then Samsara API - Get Route Details using ELD Id "Route"
  #Expected e
    Then Get Attribute "data.stops[0].name" store into "Stop_Name_1" from "Route_Response"
    Then Get Attribute "data.stops[0].scheduledArrivalTime" store into "Stop1_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[1].name" store into "Stop_Name_2" from "Route_Response"
    Then Get Attribute "data.stops[1].scheduledArrivalTime" store into "Stop2_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[1].scheduledDepartureTime" store into "Stop2_Planned_Departure" from "Route_Response"
    Then Get Attribute "data.stops[2].name" store into "Stop_Name_3" from "Route_Response"
    Then Get Attribute "data.stops[2].scheduledArrivalTime" store into "Stop3_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[2].scheduledDepartureTime" store into "Stop3_Planned_Departure" from "Route_Response"
    
    Then Set "TodayDate" with "Date(yyyy-MM-dd)=>0"
    Then Set "ThirdDate" with "Date(yyyy-MM-dd)=>3"
    Then Set "Exp_Stop1_Planned_Arrival" with "SysData=>TodayDate" and "T11:00:00.000Z"
    Then Set "Exp_Stop2_Date" with "SysData=>TodayDate" and "T15:15:00.000Z"
    Then Set "Exp_Stop3_Date" with "SysData=>ThirdDate" and "T18:45:00.000Z"

    Then Verify Assertion for "Stop_Name_1" contains "Denver Broncos"
    Then Verify Assertion for "Stop1_Planned_Arrival" contains "SysData=>Exp_Stop1_Planned_Arrival"
    Then Verify Assertion for "Stop_Name_2" contains "Denver Deli Meats"
    Then Verify Assertion for "Stop2_Planned_Arrival" contains "SysData=>Exp_Stop2_Date"
    Then Verify Assertion for "Stop2_Planned_Departure" contains "SysData=>Exp_Stop2_Date"
    Then Verify Assertion for "Stop_Name_3" contains "Account 3230"
    Then Verify Assertion for "Stop3_Planned_Arrival" contains "SysData=>Exp_Stop3_Date"
    Then Verify Assertion for "Stop3_Planned_Departure" contains "SysData=>Exp_Stop3_Date"

  #Step 28
    Then Click on "Add Leg Below" on "3" Leg
    Then Wait for "2" Seconds

  #Step 29
    Then Update "4" leg details
      | Due Out Date | Due Out Time |
      | 3            | 2:00 PM     |
    Then Wait for "1" Seconds
    Then Update "2" leg details
      | End Type | Location_2   | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Account 3230 | 3                |                        |                      |
    Then Wait for "1" Seconds

  #Step 30
    Then Click on button with Title "Save"
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

  #Step 31
    Then Click on button with Title "Redispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Verify Message displaying as "Trip has been successfully updated in the ELD."
    Then Wait for "20" Seconds

  #Step 32
    Then Samsara API - Get Route Details using ELD Id "Route"
  #Expected f
    Then Get Attribute "data.stops[0].name" store into "Stop_Name_1" from "Route_Response"
    Then Get Attribute "data.stops[0].scheduledArrivalTime" store into "Stop1_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[1].name" store into "Stop_Name_2" from "Route_Response"
    Then Get Attribute "data.stops[1].scheduledArrivalTime" store into "Stop2_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[1].scheduledDepartureTime" store into "Stop2_Planned_Departure" from "Route_Response"
    Then Get Attribute "data.stops[2].name" store into "Stop_Name_3" from "Route_Response"
    Then Get Attribute "data.stops[2].scheduledArrivalTime" store into "Stop3_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[2].scheduledDepartureTime" store into "Stop3_Planned_Departure" from "Route_Response"

    Then Set "TodayDate" with "Date(yyyy-MM-dd)=>0"
    Then Set "ThirdDate" with "Date(yyyy-MM-dd)=>3"
    Then Set "Exp_Stop1_Planned_Arrival" with "SysData=>TodayDate" and "T11:00:00.000Z"
    Then Set "Exp_Stop2_Date" with "SysData=>TodayDate" and "T15:15:00.000Z"
    Then Set "Exp_Stop3_Date" with "SysData=>ThirdDate" and "T18:45:00.000Z"

    Then Verify Assertion for "Stop_Name_1" contains "Denver Broncos"
    Then Verify Assertion for "Stop1_Planned_Arrival" contains "SysData=>Exp_Stop1_Planned_Arrival"
    Then Verify Assertion for "Stop_Name_2" contains "Denver Deli Meats"
    Then Verify Assertion for "Stop2_Planned_Arrival" contains "SysData=>Exp_Stop2_Date"
    Then Verify Assertion for "Stop2_Planned_Departure" contains "SysData=>Exp_Stop2_Date"
    Then Verify Assertion for "Stop_Name_3" contains "Account 3230"
    Then Verify Assertion for "Stop3_Planned_Arrival" contains "SysData=>Exp_Stop3_Date"
    Then Verify Assertion for "Stop3_Planned_Departure" contains "SysData=>Exp_Stop3_Date"

  #Step 33
    Then Wait for "2" Seconds
    Then Update "4" leg details
      | Appointment Start Time | Appointment End Time |
      | 2:30 PM                |3:15 PM               |
    Then Wait for "1" Seconds

  #Step 34
    Then Click on button with Title "Save"
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "2" Seconds

  #Step 35
    Then Click on button with Title "Redispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Verify Message displaying as "Trip has been successfully updated in the ELD."
    Then Wait for "20" Seconds

  #Step 36
    Then Samsara API - Get Route Details using ELD Id "Route"
  #Expected g
    Then Get Attribute "data.stops[0].name" store into "Stop_Name_1" from "Route_Response"
    Then Get Attribute "data.stops[0].scheduledArrivalTime" store into "Stop1_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[1].name" store into "Stop_Name_2" from "Route_Response"
    Then Get Attribute "data.stops[1].scheduledArrivalTime" store into "Stop2_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[1].scheduledDepartureTime" store into "Stop2_Planned_Departure" from "Route_Response"
    Then Get Attribute "data.stops[2].name" store into "Stop_Name_3" from "Route_Response"
    Then Get Attribute "data.stops[2].scheduledArrivalTime" store into "Stop3_Planned_Arrival" from "Route_Response"
    Then Get Attribute "data.stops[2].scheduledDepartureTime" store into "Stop3_Planned_Departure" from "Route_Response"

    Then Set "TodayDate" with "Date(yyyy-MM-dd)=>0"
    Then Set "ThirdDate" with "Date(yyyy-MM-dd)=>3"
    Then Set "Exp_Stop1_Planned_Arrival" with "SysData=>TodayDate" and "T11:00:00.000Z"
    Then Set "Exp_Stop2_Date" with "SysData=>TodayDate" and "T15:15:00.000Z"
    Then Set "Exp_Stop3_Date" with "SysData=>ThirdDate" and "T18:45:00.000Z"

    Then Verify Assertion for "Stop_Name_1" contains "Denver Broncos"
    Then Verify Assertion for "Stop1_Planned_Arrival" contains "SysData=>Exp_Stop1_Planned_Arrival"
    Then Verify Assertion for "Stop_Name_2" contains "Denver Deli Meats"
    Then Verify Assertion for "Stop2_Planned_Arrival" contains "SysData=>Exp_Stop2_Date"
    Then Verify Assertion for "Stop2_Planned_Departure" contains "SysData=>Exp_Stop2_Date"
    Then Verify Assertion for "Stop_Name_3" contains "Account 3230"
    Then Verify Assertion for "Stop3_Planned_Arrival" contains "SysData=>Exp_Stop3_Date"
    Then Verify Assertion for "Stop3_Planned_Departure" contains "SysData=>Exp_Stop3_Date"