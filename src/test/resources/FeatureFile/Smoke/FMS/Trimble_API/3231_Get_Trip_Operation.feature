Feature: 3231 - Trimble API- Cancel Trip Operation


  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @3231
  Scenario: 3231 - Trimble API- Get Trip Operation

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
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | 1445-1530       | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details

    #Step 2
    Then Capture the current URL for "Load_1"

   #Step 3
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
      |Search                                 |Driver                                       |
      |Tractor Two Thousand Four Hundred and Seven| QA Driver Two Thousand Four Hundred and Seven |

    Then Update "1" leg details
      | Start Type         | Location                            |
      | Location | Chicago Blackhawks |

    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 0           | 1:15 AM     |

    Then Update "2" leg details
      | Due Out Time |
      | 12:30 PM     |

    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 7
    Then Update "1" Segment details
      |   Status   |Driver Confirmation Status |
      | Dispatched | Accepted |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "40" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "5" Seconds
    #Step 8
    Then Click on button with Title "Tracking"
    Then Scroll down with "4" Times
    Then Store Leg "1" "PTA" on to "Leg_1_PTA"
    Then Store Leg "2" "PTA" on to "Leg_2_PTA"

    Then Convert Date Time format "Leg_1_PTA" from "MMM d, yyyy, h:mm a" to "yyyy-MM-dd HH:mm"
    Then Convert Date Time format "Leg_2_PTA" from "MMM d, yyyy, h:mm a" to "yyyy-MM-dd HH:mm"
    
    #Step 9
    Then Wait for "20" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "API Trip Id"
    Then Get Trimble Trip Management Details with API Trip Id as "API Trip Id" and store response onto "Response"

    #Step 10 & 11
    Then Get Attribute "stops[0].currentETA" store into "PTA1" from "Response"
    Then Get Attribute "stops[1].currentETA" store into "PTA2" from "Response"

    #Expected a  & b
    Then Validate API date time "SysData=>PTA1" with expected date time "SysData=>Leg_1_PTA" in timezone "America/New_York"
    Then Validate API date time "SysData=>PTA2" with expected date time "SysData=>Leg_2_PTA" in timezone "America/Denver"

