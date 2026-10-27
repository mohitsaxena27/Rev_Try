Feature: 2411 - Trimble API- Update Trip Status Operation

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @2411
  Scenario: 2411 - Trimble API- Update Trip Status Operation

    When Login into Salesforce
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
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
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | 1445     | NA                   |
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
    Then Update "1" Segment details
      |Search                                 |Driver                                       |Driver Confirmation Status |
      |Tractor Two Thousand Four Hundred and Eleven|QA Driver Two Thousand Four Hundred and Eleven|Accepted                   |

    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time |
      | Load Stop   | Stop 1P - Boston Beans  | 0            | 8:30 AM      |
    Then Verify "2" leg details
      | Start Type    | Location                |Due Out Date|
      | Load Stop     | Stop 1P - Boston Beans  | 0          |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |
      | Load Stop   | Stop 2D - Denver Deli Meats     | 3                | 2:45 PM      |

    Then Update "1" leg details
      | Start Type          | Location | Country       | Street             | City    | State/Province | Postal Code |
      | Waypoint Address    | NA       | Canada        | Cite du Havre      | Montreal | Quebec            | H3C 3R5       |
    Then Click on "Save" on "1" Leg
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |0           |1:15 AM     |

    Then Update "2" leg details
      | Due Out Time|
      | 12:30 PM     |
  #Step 7 & 8
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

     #Step 9 & 10
     Then Wait for "40" Seconds
     Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "API Trip Id"

     #Step 11 , 12, 13 , 14  - Not use
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
    #Step 15
    Then Update "1" Segment details
      |  Status |
      | Dispatched     |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "12" Seconds
    #Step 16, 17 & 18
    Then Get Trimble Trip Management External OrderIds
    Then Store Current Date and Time in UTC on "CurrentUTCTime" with Format as "yyyy-MM-dd'T'HH:mm"
    #Expected a
    Then Verify Assertion for "Name" contains "{Trip_Plan_ID} Segment 1"
    Then Verify Assertion for "actualStartDate" contains "TimeData=>CurrentUTCTime" with Format as "yyyy-MM-dd'T'HH:mm"

    Then Verify Assertion for "tripStatus" contains "InProgress"
    Then Verify Assertion for "plannedStartLocation" contains "coords:[lon:-73.547948, lat:45.531854]"
    Then Verify Assertion for "externalOrderIds" contains "SysData=>1LRI"

