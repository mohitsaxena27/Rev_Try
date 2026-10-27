Feature: 2434 - Trimble API- Update Stop Status Operation

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @2434
  Scenario: 2434 - Trimble API- Update Stop Status Operation

    When Login into Salesforce
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
#   #Step1
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
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 1030            | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | 1445-1530     | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    #Step 2
    Then Save Load With All details
   #Step3
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
  #Step 4
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

  #Step 5
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

  #Step 6
    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time |
      | Load Stop   | Stop 1P - Boston Beans  | 0            | 10:30 AM      |
    Then Verify "2" leg details
      | Start Type    | Location                |Due Out Date|
      | Load Stop     | Stop 1P - Boston Beans  | 0          |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Denver Deli Meats     | 3                | 2:45 PM      |3:30 PM|

    Then Update "1" Segment details
      |Search                                 |Driver                                        |Driver Confirmation Status |
      |Tractor Two Thousand Four Hundred and Seven|QA Driver Two Thousand Four Hundred and Seven |Accepted                   |

    Then Update "1" leg details
      | Start Type  | Location |
      | Location    | Chicago Blackhawks      |
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |0           |1:15 AM     |

    Then Update "2" leg details
      | Due Out Time|
      | 12:30 PM     |
    Then Wait for "2" Seconds

  #Step 7
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

  #Step 8
    Then Update "1" Segment details
      | Status     |
      | Dispatched  |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

   #Step 9
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    #Step 10
    Then Update "1" leg details
      | Arrival Date | Arrival Time |
      | 1            | 8:30 AM      |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Update "1" leg details
      | Departure Date | Departure Time |
      | 1             | 10:00 AM        |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 11
    Then Update "2" leg details
      | Arrival Date | Arrival Time |
      | 4            | 6:00 AM      |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Departure Date | Departure Time |
      | 4              | 8:00 AM        |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

#    Then Update "2" leg details
#      | Arrival Date | Arrival Time | Departure Date | Departure Time |
#      | 4            | 6:00 AM      | 4              | 8:00 AM        |
#   #Step 12
#    Then Click on button with Title "Save"
#    Then Verify Message displaying as "Save was successful."
#    Then Wait for "8" Seconds

    #Step 13
    Then Wait for "40" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "API Trip Id"

    Then Wait for "60" Seconds
     #Step 14, 15 & 16
    Then Get Trimble Trip Management External OrderIds

    #Expected a
    Then Verify Assertion for "Name" contains "{Trip_Plan_ID} Segment 1"
#    Then Verify Assertion for "tripStatus" contains "Completed"

    #Stop 1 Validation
    Then Verify "stop1_actualArrivalTime" time is rendered with day "1" at "CDT:08:30:00-04:00 or CST:08:30:00-05:00"

    Then Verify Assertion for "stop1" contains "stopStatus:Completed"
    Then Verify Assertion for "stop1" contains "stopArrivalStatus:Early"
    Then Verify Assertion for "stop1" contains "[address:[zip:02215, country:United States, StreetAddress:526 Beacon Street, city:Boston, county:Suffolk, state:MA], label:, coords:[lon:-71.090931, lat:42.350802]]"
    Then Verify Assertion for "stop1" contains "stopSequence:0"

    #Stop 2 Validation
    Then Verify "stop2_actualArrivalTime" time is rendered with day "4" at "CDT:06:00:00 or CST:06:00:00"
    Then Verify "stop2_actualDepartureTime" time is rendered with day "4" at "CDT:08:00:00-06:00 or CST:08:00:00-06:00"

    Then Verify Assertion for "stop2" contains "stopStatus:Completed"
    Then Verify Assertion for "stop2" contains "stopArrivalStatus:Early"
    Then Verify Assertion for "stop2" contains "[address:[zip:80204, country:United States, StreetAddress:1435 North Fox Street, city:Denver, county:Denver, state:CO], label:, coords:[lon:-104.99565, lat:39.739173]]"
    Then Verify Assertion for "stop2" contains "stopSequence:1"
