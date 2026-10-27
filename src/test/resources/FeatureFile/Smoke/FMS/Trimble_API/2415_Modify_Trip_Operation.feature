Feature: 2415 - Trimble API- Modify Trip Operation

  Background: Pre- Test
    When Login into Salesforce
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    #Pre-Step 1,2,3
    Then Search and Select "John Deere Parts Distribution Center" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | America/Chicago |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | America/Chicago|

    Then Search and Select "Timed Waypoint" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | America/Phoenix |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | America/Phoenix|
    Then Wait for "2" Seconds

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @2415
  Scenario: 2415 - Trimble API- Modify Trip Operation

   #Step1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans  |Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      |Fleet|
      |True |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830            | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | 1445-1530       | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    #Step 2 & 3
    Then Save Load With All details

   #Step4
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load

  #Step 5
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

  #Step 6
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

  #Step 7
    Then Update "1" Segment details
      |Search                                 |Driver                                       |Driver Confirmation Status |
      |Tractor Two Thousand Four Hundred and Seven|QA Driver Two Thousand Four Hundred and Seven|Accepted                   |

    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time |
      | Load Stop   | Stop 1P - Boston Beans  | 0            | 8:30 AM      |
    Then Verify "2" leg details
      | Start Type    | Location                |Due Out Date|
      | Load Stop     | Stop 1P - Boston Beans  | 0          |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Denver Deli Meats     | 3                | 2:45 PM      |3:30 PM                      |

    Then Update "1" leg details
      |Start Type         |Location                            |
      |Distribution Center|John Deere Parts Distribution Center|
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |0           |1:15 AM     |

    Then Update "2" leg details
      | Due Out Time|
      | 12:30 PM     |
  #Step 8 & 9
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
     #Step 10
    Then Wait for "40" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "API Trip Id"

     #Step 11 , 12, 13 , 14  - Not use
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds

    #Step 15
    Then Click on button with Title "View Trip"
    Then Wait for "5" Seconds
    Then Switch Window by index "1"

    #Step 16
    Then Get Trimble Trip Management Details with API Trip Id as "API Trip Id" and store response onto "Response"
    Then Get Attribute "vehicle.tspVehicleId" store into "VehicleID_1" from "Response"
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 17 & 18
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      |Search                                |
      |Tractor Two Thousand Four Hundred and Eleven|
    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 19
    Then Click on button with Title "View Trip"
    Then Wait for "6" Seconds
    Then Switch Window by index "1"

    #Step 20
    Then Wait for "10" Seconds
    Then Get Trimble Trip Management Details with API Trip Id as "API Trip Id" and store response onto "Response"
    Then Get Attribute "name" store into "Trip Name_1" from "Response"
    Then Get Attribute "vehicle.tspVehicleId" store into "VehicleID_2" from "Response"

    #Expected a
    Then Verify Assertion for "VehicleID_2" not contains "SysData=>VehicleID_1"
    Then Verify Assertion for "VehicleID_2" contains "Tractor Two Thousand Four Hundred and Eleven"
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 21
    Then Click on button with Title "Add Segment Above"
    Then Wait for "2" Seconds

    #Step 22
    Then Update "1" Segment details
      |Search                                |Driver                                       |Driver Confirmation Status |
      |Tractor Two Thousand Four Hundred and Eleven|QA Driver Two Thousand Four Hundred and Seven|Accepted                   |

    Then Update "1" leg details
      | Start Type            | Location                |Due Out Date|Due Out Time|
      | Waypoint Location     | Timed Waypoint          | 0          |12:30 AM|
    Then Update "1" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Terminal    | Missouri Terminal                 |0               | 2:00 AM               |2:00 AM                      |

     #Step 23
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 24
    Then Click on button with Title "View Trip" on "Segment 2"
    Then Wait for "6" Seconds
    Then Switch Window by index "1"

    #Step 25
    Then Wait for "10" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" & "name" with value "Segment 2" and Store onto "API Trip Id"
    Then Get Trimble Trip Management Details with API Trip Id as "API Trip Id" and store response onto "Response"
    Then Get Attribute "name" store into "Trip Name_2" from "Response"

    #Expected b
    Then Verify Assertion for "Trip Name_2" contains "{Trip_Plan_ID} Segment 2"
    Then Close Current Tab
    Then Switch to Parent Window
    Then Wait for "2" Seconds

  #########Remove block
#    Then Set "Trip_Plan_ID" with "Trip Plan-17"
#    Then Scroll into Section "View - Trip Plan"
#    Then Scroll down with "4" Times
#    Then Update details
#      |Trip Plan Start Date|
#      |Today            |
#    Then Click on "Refresh" under "View - Trip Plan" Section
#    Then Wait for "2" Seconds
#    Then Click on "SysData>Trip_Plan_ID" under "View - Trip Plan" Section
#    Then Wait for "2" Seconds
#    Then Verify Text displaying as "Plan Trip - Trip Plan" -
#
    #Step 26
    Then Click on button with Title "Tracking"
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Start Type            | Location                |Planned Duration (Dwell)|
      | Location              | Chicago Bears           | 60         |
    Then Update "3" leg details
      | End Type             | Location_2                      |
      | Waypoint Location    | Timed Waypoint                  |
     #Step 27
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Verify "2" leg details
      | Start Type            | Location                |
      | Location              | Chicago Bears           |
        #Step 28
    Then Click on button with Title "View Trip" on "Segment 2"
    Then Wait for "2" Seconds
    Then Switch Window by index "1"

    #Step 29
    Then Get Trimble Trip Management Details with API Trip Id as "API Trip Id" and store response onto "Response"
    Then Get Attribute "plannedStartLocation.address.StreetAddress" store into "plannedStartLocation_streetAddress" from "Response"
    Then Get Attribute "plannedStartLocation.address.city" store into "plannedStartLocation_city" from "Response"
    Then Get Attribute "plannedStartLocation.address.state" store into "plannedStartLocation_state" from "Response"
    Then Get Attribute "plannedStartLocation.address.zip" store into "plannedStartLocation_zip" from "Response"

    Then Get Attribute "plannedStartTime" store into "plannedStartTime" from "Response"

    Then Get Attribute "stops[1].location.address.city" store into "Stop2_city" from "Response"
    Then Get Attribute "stops[1].location.address.state" store into "Stop2_state" from "Response"
    Then Get Attribute "stops[1].location.address.zip" store into "Stop2_zip" from "Response"

    Then Get Attribute "stops[0].currentETA" store into "ETA2" from "Response"
    Then Get Attribute "stops[0].currentETD" store into "DEPT2" from "Response"


    #Expected c
    Then Set "plannedStartLocation1" with "SysData=>plannedStartLocation_streetAddress" and ", " and "SysData=>plannedStartLocation_city"
    Then Set "plannedStartLocation2" with "SysData=>plannedStartLocation1" and ", " and "SysData=>plannedStartLocation_state"
    Then Set "plannedStartLocation" with "SysData=>plannedStartLocation2" and ", " and "SysData=>plannedStartLocation_zip"
    Then Verify Assertion for "plannedStartLocation" contains "Football Drive, Lake Forest, IL, 60045"

    #Step 30 & Expected d
    Then Set "stop2_Location1" with "SysData=>Stop2_city" and ", " and "SysData=>Stop2_state"
    Then Set "stop2_Location" with "SysData=>stop2_Location1" and ", " and "SysData=>Stop2_zip"
    Then Verify Assertion for "stop2_Location" contains "Tsaile, AZ, 86556"


     #Step 31 & Expected e
     Then Verify the datetime "SysData=>ETA2" is today and in future for timezone "America/New_York"
     Then Verify the datetime "SysData=>DEPT2" is today and in future for timezone "America/New_York"
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 32
    Then Wait for "1" Seconds
    Then Update "2" leg details
      |Due Out Date|Due Out Time|
      |-1          |2:15 AM|
    Then Update "3" leg details
       | Appointment Date |Appointment Start Time |Appointment End Time|
       |4                 | 3:45 PM               |4:30 PM                      |
     #Step 33
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    #Step 34
    Then Click on button with Title "View Trip" on "Segment 2"
    Then Wait for "2" Seconds
    Then Switch Window by index "1"

    #Step 35
    Then Wait for "10" Seconds
    Then Get Trimble Trip Management Details with API Trip Id as "API Trip Id" and store response onto "Response"
    Then Get Attribute "plannedStartTime" store into "plannedStartTime" from "Response"
    Then Get Attribute "stops[1].earliestArrivalTime" store into "Stop3_earliestArrivalTime" from "Response"
    Then Get Attribute "stops[1].latestArrivalTime" store into "Stop3_latestArrivalTime" from "Response"

    #Expected f
    Then Set "Exp_Stop1_DEPT1" with "Date(yyyy-MM-dd)=>-1" and "T07:15:00+00:00"
    Then Verify Assertion for "plannedStartTime" contains "SysData=>Exp_Stop1_DEPT1"
    #Step 36 & Expected g
    Then Set "Exp_Stop3_earliestArrivalTime" with "Date(yyyy-MM-dd)=>4" and " 16:45"
    Then Validate API date time "SysData=>Stop3_earliestArrivalTime" with expected date time "SysData=>Exp_Stop3_earliestArrivalTime" in timezone "America/Los_Angeles"
    Then Set "Exp_Stop3_latestArrivalTime" with "Date(yyyy-MM-dd)=>4" and " 17:30"
    Then Validate API date time "SysData=>Stop3_latestArrivalTime" with expected date time "SysData=>Exp_Stop3_latestArrivalTime" in timezone "America/Los_Angeles"
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 37
    Then Wait for "2" Seconds
    Then Click on button with Title "Tracking" if already pressed
    Then Wait for "2" Seconds
    Then Click on "Add Leg Below" on "3" Leg
    Then Wait for "2" Seconds
    #Step 38
      Then Verify "4" leg details
        | Start Type            | Location                |
        | Waypoint Location     | Timed Waypoint          |
      Then Update "4" leg details
       |Due Out Date|Due Out Time|
       | 4          |4:30 PM|
    Then Update "4" leg details
      | End Type    | Location_2                   | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Denver Deli Meats  | 5                | 8:00 AM      |8:00 AM                      |
     #Step 39
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 40
    Then Click on button with Title "View Trip" on "Segment 2"
    Then Wait for "2" Seconds
    Then Switch Window by index "1"

    #Step 41
    Then Wait for "10" Seconds
    Then Get Trimble Trip Management Details with API Trip Id as "API Trip Id" and store response onto "Response"
    Then Get Attribute "stops[2].earliestArrivalTime" store into "Stop4_earliestArrivalTime" from "Response"
    Then Get Attribute "stops[2].latestArrivalTime" store into "Stop4_latestArrivalTime" from "Response"

    Then Get Attribute "stops[2].location.address.StreetAddress" store into "Stop4_StreetAddress" from "Response"
    Then Get Attribute "stops[2].location.address.city" store into "Stop4_city" from "Response"
    Then Get Attribute "stops[2].location.address.state" store into "Stop4_state" from "Response"
    Then Get Attribute "stops[2].location.address.zip" store into "Stop4_zip" from "Response"

    #Expected h
#    Then Verify Total Address count is "4"
#    Then Store "4" "address" into "Location4"
#    Then Store "4" "ArrivalTime_Window" into "ATW4"
    #Step 42 & Expected i
    Then Set "Location43" with "SysData=>Stop4_StreetAddress" and ", " and "SysData=>Stop4_city"
    Then Set "Location42" with "SysData=>Location43" and ", " and "SysData=>Stop4_state"
    Then Set "Location4" with "SysData=>Location42" and ", " and "SysData=>Stop4_zip"

    Then Verify Assertion for "Location4" contains "1435 North Fox Street, Denver, CO, 80204"

    #Step 43 & Expected j
    Then Set "Exp_Stop4_earliestArrivalTime" with "Date(yyyy-MM-dd)=>5" and " 08:00"
    Then Validate API date time "SysData=>Stop4_earliestArrivalTime" with expected date time "SysData=>Exp_Stop4_earliestArrivalTime" in timezone "America/Denver"
    Then Set "Exp_Stop4_latestArrivalTime" with "Date(yyyy-MM-dd)=>5" and " 08:00"
    Then Validate API date time "SysData=>Stop4_latestArrivalTime" with expected date time "SysData=>Exp_Stop4_latestArrivalTime" in timezone "America/Denver"


    Then Close Current Tab
    Then Switch to Parent Window
     #Step 44
    Then Wait for "1" Seconds
    Then Click on button "Close" on Trip Plan

   #Step 45
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds
    Then Update "1" Segment details
      |Search                                |Driver                                       |Driver Confirmation Status |
      |Tractor Two Thousand Four Hundred and Seven|QA Driver Two Thousand Four Hundred and Seven|Accepted                   |

     Then Update "1" leg details
      | Start Type            | Location                |Due Out Date|Due Out Time|
      | Waypoint Location     | Timed Waypoint          | 0          |2:30 AM|
    Then Update "1" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Terminal    | Missouri Terminal                 |1               | 8:00 AM               |8:00 AM                      |
    #Step 46
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID_2"

    #Step 47 & 48
    Then Wait for "40" Seconds
    Then Set key "TripPlanID" for Object "rtms__TripPlan__c" and Name "SysData=>Trip_Plan_ID_2"
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>TripPlanID" and Store onto "API Trip Id"

    #Step 49, 50 & 51
     Then Get Trimble Trip Management External OrderIds
    #Expected k
     Then Verify Assertion for "externalOrderIds" contains "[]"
    #Step 52 , 53 , 54, 55, 56 & 57
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      |Load       |
      |SysData=>1L|
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Verify "1" Segment details
    |Load|
    |SysData=>1L|
    #Step 58,59,60
    Then Get Trimble Trip Management External OrderIds
    #Expected L
    Then Verify Assertion for "externalOrderIds" contains "SysData=>1LRI"
