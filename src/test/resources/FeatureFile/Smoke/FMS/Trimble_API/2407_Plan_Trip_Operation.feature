Feature: 2407 - Trimble API- Plan Trip Operation

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @2407
  Scenario: 2407 - Trimble API- Plan Trip Operation

    When Login into Salesforce
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
#   #Step1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      | Fleet |
      | True  |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | 0830             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | 1445-1530        | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    #Step 2 & 3
    Then Save Load With All details
   #Step4
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
  #Step 5
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

  #Step 6
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

  #Step 7
    Then Verify "1" leg details
      | End Type  | Location_2             | Appointment Date | Appointment Start Time |
      | Load Stop | Stop 1P - Boston Beans | 0                | 8:30 AM                |
    Then Verify "2" leg details
      | Start Type | Location               | Due Out Date |
      | Load Stop  | Stop 1P - Boston Beans | 0            |
    Then Verify "2" leg details
      | End Type  | Location_2                  | Appointment Date | Appointment Start Time | Appointment End Time |
      | Load Stop | Stop 2D - Denver Deli Meats | 3                | 2:45 PM                | 3:30 PM              |

    Then Update "1" Segment details
      | Search                                      | Driver                                        |
      | Tractor Two Thousand Four Hundred and Seven | QA Driver Two Thousand Four Hundred and Seven |
    Then Wait for "1" Seconds
    Then Click on "Add Driver" on "1" Segment
    Then Wait for "3" Seconds
    Then Update "1" Segment details
      | Driver_2                                           | Driver Confirmation Status |
      | QA Driver Two Thousand Four Hundred and Seven Team | Accepted                   |

    Then Update "1" leg details
      | Start Type | Location | Country | Street                 | City            | State/Province | Postal Code |
      | Address    | NA       | Mexico  | Francia 471, Versalles | Puerto Vallarta | Jalisco        | 48310       |
    Then Click on "Save" on "1" Leg
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 0            | 1:15 AM      |

    Then Update "2" leg details
      | Due Out Time |
      | 12:30 PM     |
    Then Wait for "2" Seconds
    #Step 8
    Then Click on button with Title "Tracking"
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Planned Duration (Dwell) |
      | 60                       |
  #Step 9 & 10
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "15" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

  #Step 11
    Then Wait for "40" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "API Trip Id"

     #Step 12, 13 , 14. 15  - Not use
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
     #Step 16
    Then Click on button with Title "View Trip" on "Segment 1"
    Then Wait for "5" Seconds
    #Expected Result a
    Then Switch Window by index "1"

    #Step 17
    Then Get Trimble Trip Management Details with API Trip Id as "API Trip Id" and store response onto "Response"
    Then Get Attribute "tripStatus" store into "Trip Status" from "Response"
    Then Get Attribute "name" store into "Trip Name_1" from "Response"
    Then Get Attribute "plannedStartLocation.address.StreetAddress" store into "plannedStartLocation_StreetAddress" from "Response"
    Then Get Attribute "plannedStartLocation.address.city" store into "plannedStartLocation_city" from "Response"
    Then Get Attribute "plannedStartLocation.address.state" store into "plannedStartLocation_state" from "Response"
    Then Get Attribute "plannedStartTime" store into "plannedStartTime" from "Response"

    Then Get Attribute "stops[0].location.address.StreetAddress" store into "Stop1_StreetAddress" from "Response"
    Then Get Attribute "stops[0].location.address.city" store into "Stop1_city" from "Response"
    Then Get Attribute "stops[0].location.address.state" store into "Stop1_state" from "Response"
    Then Get Attribute "stops[0].location.address.zip" store into "Stop1_zip" from "Response"

    Then Get Attribute "stops[0].earliestArrivalTime" store into "Stop1_earliestArrivalTime" from "Response"
    Then Get Attribute "stops[0].latestArrivalTime" store into "Stop1_latestArrivalTime" from "Response"

    Then Get Attribute "stops[1].location.address.StreetAddress" store into "Stop2_StreetAddress" from "Response"
    Then Get Attribute "stops[1].location.address.city" store into "Stop2_city" from "Response"
    Then Get Attribute "stops[1].location.address.state" store into "Stop2_state" from "Response"
    Then Get Attribute "stops[1].location.address.zip" store into "Stop2_zip" from "Response"
    Then Get Attribute "stops[1].location.address.StreetAddress" store into "Stop2_StreetAddress" from "Response"
    Then Get Attribute "stops[1].earliestArrivalTime" store into "Stop2_earliestArrivalTime" from "Response"
    Then Get Attribute "stops[1].latestArrivalTime" store into "Stop2_latestArrivalTime" from "Response"
    Then Get Attribute "stops[1].plannedDuration" store into "Stop2_plannedDuration" from "Response"

    #Expected b
    Then Verify Assertion for "Trip Status" contains "Planned"
    Then Verify Assertion for "Trip Name_1" contains "{Trip_Plan_ID} Segment 1"

    Then Set "plannedStartLocation1" with "SysData=>plannedStartLocation_StreetAddress" and ", " and "SysData=>plannedStartLocation_city"
    Then Set "plannedStartLocation" with "SysData=>plannedStartLocation1" and ", " and "SysData=>plannedStartLocation_state"
    Then Verify Assertion for "plannedStartLocation" contains "Avenida Francia, Puerto Vallarta, JA"
    Then Set "Exp_Departure_time" with "Date(yyyy-MM-dd)=>0" and "T06:15:00+00:00"
    Then Verify Assertion for "plannedStartTime" contains "SysData=>plannedStartTime"

    Then Set "plannedStartLocation1" with "SysData=>Stop1_StreetAddress" and ", " and "SysData=>Stop1_city"
    Then Set "plannedStartLocation2" with "SysData=>plannedStartLocation1" and ", " and "SysData=>Stop1_state"
    Then Set "plannedStartLocation" with "SysData=>plannedStartLocation2" and ", " and "SysData=>Stop1_zip"
    Then Set "Stop_Location" with "526 Beacon Street, Boston, MA, 02215" and "Back Street, Boston, MA, 02215"
    Then Verify Assertion for "Stop_Location" contains "SysData=>plannedStartLocation"


    Then Set "Exp_Stop1_earliestArrivalTime" with "Date(yyyy-MM-dd)=>0" and " 08:30"
    Then Validate API date time "SysData=>Stop1_earliestArrivalTime" with expected date time "SysData=>Exp_Stop1_earliestArrivalTime" in timezone "America/New_York"
    Then Set "Exp_Stop1_latestArrivalTime" with "Date(yyyy-MM-dd)=>0" and " 08:30"
    Then Validate API date time "SysData=>Stop1_latestArrivalTime" with expected date time "SysData=>Exp_Stop1_latestArrivalTime" in timezone "America/New_York"

    Then Set "plannedStartLocation1" with "SysData=>Stop2_StreetAddress" and ", " and "SysData=>Stop2_city"
    Then Set "plannedStartLocation2" with "SysData=>plannedStartLocation1" and ", " and "SysData=>Stop2_state"
    Then Set "plannedStartLocation" with "SysData=>plannedStartLocation2" and ", " and "SysData=>Stop2_zip"
    Then Verify Assertion for "plannedStartLocation" contains "1435 North Fox Street, Denver, CO, 80204"

    Then Set "Exp_Stop2_earliestArrivalTime" with "Date(yyyy-MM-dd)=>3" and " 14:45"
    Then Validate API date time "SysData=>Stop2_earliestArrivalTime" with expected date time "SysData=>Exp_Stop2_earliestArrivalTime" in timezone "America/Denver"
    Then Set "Exp_Stop2_latestArrivalTime" with "Date(yyyy-MM-dd)=>3" and " 15:30"
    Then Validate API date time "SysData=>Stop2_latestArrivalTime" with expected date time "SysData=>Exp_Stop2_latestArrivalTime" in timezone "America/Denver"
    Then Verify Assertion for "Stop2_plannedDuration" contains "60.0"
    Then Close Current Tab
    Then Switch to Parent Window

     #Step 18, 19 & 20
    Then Get Trimble Trip Management External OrderIds
    #Expected c
    Then Verify Assertion for "Name" contains "{Trip_Plan_ID} Segment 1"
    Then Verify Assertion for "tripStatus" contains "Planned"
    #Stop 1 Validation
    Then Verify "stop1_earliestArrivalTime" time is rendered with day "0" at "CDT:08:30:00-04:00 or CST:08:30:00-05:00"
    Then Verify "stop1_latestArrivalTime" time is rendered with day "0" at "CDT:08:30:00-04:00 or CST:08:30:00-05:00"
    Then Verify Assertion for "stop1" contains "plannedDuration:0.0"
    Then Verify Assertion for "stop1" contains "actualDuration:0.0"
    Then Verify Assertion for "stop1" contains "[address:[zip:02215, country:United States, StreetAddress:Back Street, city:Boston, county:Suffolk, state:MA], label:, coords:[lon:-71.090931, lat:42.350802]]" or "[address:[zip:02215, country:United States, StreetAddress:526 Beacon Street, city:Boston, county:Suffolk, state:MA], label:, coords:[lon:-71.090931, lat:42.350802]]"
    Then Verify Assertion for "stop1" contains "waypoint:false"
    Then Verify Assertion for "stop1" contains "stopSequence:0"
    Then Verify Assertion for "stop1" contains "stopType:Work"
    #Stop 2 Validation
    Then Set "Exp_Stop2_earliestArrivalTime" with "Date(yyyy-MM-dd)=>3" and " 14:45"
    Then Validate API date time "SysData=>stop2_earliestArrivalTime" with expected date time "SysData=>Exp_Stop2_earliestArrivalTime" in timezone "America/Denver"
    Then Set "Exp_Stop2_latestArrivalTime" with "Date(yyyy-MM-dd)=>3" and " 15:30"
    Then Validate API date time "SysData=>stop2_latestArrivalTime" with expected date time "SysData=>Exp_Stop2_latestArrivalTime" in timezone "America/Denver"

#    Then Verify "stop2_earliestArrivalTime" time is rendered with day "3" at "CDT:14:45:00-06:00 or CST:14:45:00-06:00"
#    Then Verify "stop2_latestArrivalTime" time is rendered with day "3" at "CDT:15:30:00-06:00 or CST:15:30:00-06:00"
    Then Verify Assertion for "stop2" contains "plannedDuration:60.0"
    Then Verify Assertion for "stop2" contains "actualDuration:0.0"
    Then Verify Assertion for "stop2" contains "[address:[zip:80204, country:United States, StreetAddress:1435 North Fox Street, city:Denver, county:Denver, state:CO], label:, coords:[lon:-104.99565, lat:39.739173]]"
    Then Verify Assertion for "stop2" contains "waypoint:false"
    Then Verify Assertion for "stop2" contains "stopSequence:1"
    Then Verify Assertion for "stop2" contains "stopType:Work"

    #Planned Start
    Then Verify "plannedStartTime" time is rendered with day "0" at "CDT:06:15:00 or CST:07:15:00"
    Then Verify Assertion for "plannedStartLocation" contains "[address:[zip:, country:Mexico, StreetAddress:Avenida Francia, city:Puerto Vallarta, county:Puerto Vallarta, state:JA], label:null, coords:[lon:-105.229359, lat:20.633685]]"
    #driverHoursOfService
    Then Verify Assertion for "driverHoursOfService" contains "remainingDriveTimeUntilBreak:936.0"
    Then Verify Assertion for "driverHoursOfService" contains "remainingDriveTime:30420.0"
    Then Verify Assertion for "driverHoursOfService" contains "remainingCycleDutyTime:57600.0"
    Then Verify Assertion for "driverHoursOfService" contains "remainingDriveTimeUntilBreakDriver2:null"
    Then Verify Assertion for "driverHoursOfService" contains "remainingDriveTimeDriver2:null"
    Then Verify Assertion for "driverHoursOfService" contains "remainingCycleDutyTimeDriver2:null"
    Then Verify Assertion for "externalOrderIds" contains "SysData=>1LRI"
