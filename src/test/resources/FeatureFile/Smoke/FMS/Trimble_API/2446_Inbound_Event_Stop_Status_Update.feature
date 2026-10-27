Feature: 2446 - Trimble API- Inbound Event: Stop Status Update

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @2446
  Scenario: 2446 - Trimble API- Inbound Event: Stop Status Update

    When Login into Salesforce
   #Step1
    Then Open "Loads" from App Launcher
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
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
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | 1445-1530     | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    #Step 2
    Then Save Load With All details
   #Step3
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
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
    Then Wait for "5" Seconds
  #Step 6
    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time |
      | Load Stop   | Stop 1P - Boston Beans  | 0            | 8:30 AM      |
    Then Verify "2" leg details
      | Start Type    | Location                |Due Out Date|
      | Load Stop     | Stop 1P - Boston Beans  | 0          |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Denver Deli Meats     | 3                | 2:45 PM      |3:30 PM|

    Then Update "1" Segment details
      |Search                                |Driver                                        |Driver Confirmation Status |
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
    Then Wait for "2" Seconds
    Then Click on button with Title "Trimble Trip Management Alerts"
    Then Wait for "2" Seconds
    Then Edit the following to "Move selection to Active"
         |Stop Status|
         |Stop Status|
    Then Click on button with Title "Save & Close" on Modal Footer
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
   #Step 9
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."

    #Step 10, 11, 12
    Then Wait for "30" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "API Trip Id"
    Then Get "Id" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "TripPlanSegment_SFID"

    #Step 13
    Then Get "arrivedQT1_2446.txt" files and update below Attributes
      |{tripPlanSegments_SFID}                  |{tripId}      |
      |SysData=>TripPlanSegment_SFID            |SysData=>API Trip Id|

    #Step 14, 15
    Then Set "NavigateUrl" Link to "/lightning/o/rtms__QueuedTransaction__c/home"
    Then Open New Tab with url "SysData=>NavigateUrl"
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |Payload 1                |Payload 2|
      |TrimbleInbound    |Inbound  |Pending|application/json|SysData=>{FinalUpdatedText}|       |
    Then Wait for "5" Seconds
    Then Click on "SaveEdit" button
    #Step 16
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "6" Seconds
    Then Close and Switch to Previous Window

    #Step 17, 18 , 19
    Then Wait for "5" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds

    #Step 20
    Then Click on button "Trip Events" on Trip Plan
    Then Verify Text displaying as "Trip Events - Trip Plan-"
    #Expected Result a
    Then Verify details for all Enabled fields
      |Trip Plan Leg|Event Type          |Is Alert|Date           |Time    |Event Detail                  |
      |Leg 1        |Arrival             |True    |Jul 14, 2024   |11:28 AM|Stop Status Update. Address: 976 South Union Avenue Los Angeles CA 90015|
     Then Get Trip Event Name on "Trip_Event_1"
    #Step 21
    Then Click on button "Close" on Trip Event
    Then Wait for "1" Seconds
    #Step 22
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    #Expected Result b
    Then Verify "1" leg details
      | Arrival Date  | Arrival Time |
      | Jul 14, 2024  | 12:28 PM     |

     #Step 23, 24 , 25
    Then Get "departedQT2_2446.txt" files and update below Attributes
      |{tripPlanSegments_SFID}                  |{tripId}      |
      |SysData=>TripPlanSegment_SFID            |SysData=>API Trip Id|
    Then Set "NavigateUrl" Link to "/lightning/o/rtms__QueuedTransaction__c/home"
    Then Open New Tab with url "SysData=>NavigateUrl"
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |Payload 1                |Payload 2|
      |TrimbleInbound    |Inbound  |Pending|application/json|SysData=>{FinalUpdatedText}|       |
    Then Wait for "5" Seconds
    Then Click on "SaveEdit" button
    #Step 26
    Then Go to Home Page
    Then Wait for "70" Seconds
    Then Close and Switch to Previous Window

    #Step 27, 28 , 29
    Then Wait for "5" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds

    Then Click on button "Trip Events" on Trip Plan
    Then Verify Text displaying as "Trip Events - Trip Plan-"
    #Expected Result c
    Then Verify details for all Enabled fields
      |Trip Plan Leg|Event Type            |Is Alert|Date_2           |Time_2    |Event Detail                  |
      |Leg 2        |Departure             |True    |Jul 15, 2024     |6:24 AM|Stop Status Update. Address: 100 South Union Avenue Los Angeles CA 90015|
    Then Get Trip Event Name on "Trip_Event_2"

      #Step 30
    Then Click on button "Close" on Trip Event
    Then Wait for "1" Seconds
    #Step 31
    Then Wait for "2" Seconds
    #Expected Result d
    Then Verify "2" leg details
      | Departure Date | Departure Time |
      | Jul 15, 2024   | 5:24 AM        |
    #Step 32 & 33
    Then Click on button with Title "Trimble Trip Management Alerts"
    Then Wait for "2" Seconds
    Then Edit the following to De-Select "Move selection to Inactive"
         |Stop Status|
         |Stop Status|
    Then Click on button with Title "Save & Close" on Modal Footer
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds

         #Step 34, 35 , 36
    Then Get "arrivedQT3_2446.txt" files and update below Attributes
      |{tripPlanSegments_SFID}                  |{tripId}      |
      |SysData=>TripPlanSegment_SFID            |SysData=>API Trip Id|
    Then Set "NavigateUrl" Link to "/lightning/o/rtms__QueuedTransaction__c/home"
    Then Open New Tab with url "SysData=>NavigateUrl"
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |Payload 1                |Payload 2|
      |TrimbleInbound    |Inbound  |Pending|application/json|SysData=>{FinalUpdatedText}|       |
    Then Wait for "5" Seconds
    Then Click on "SaveEdit" button
    #Step 37
    Then Go to Home Page
    Then Wait for "70" Seconds
    Then Close and Switch to Previous Window

    #Step 38, 39 , 40
    Then Wait for "5" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
    Then Click on button "Trip Events" on Trip Plan
    Then Verify Text displaying as "Trip Events - Trip Plan-"
    #Expected Result e
    Then Verify "2" Records are displaying with data "SysData=>Trip_Event_1"
    Then Verify "2" Records are displaying with data "SysData=>Trip_Event_2"
    #Step 41
    Then Click on button "Close" on Trip Event
    Then Wait for "1" Seconds
    #Step 42
    Then Wait for "2" Seconds
    #Expected Result f
    Then Verify "1" leg details
      | Arrival Time |
      | 2:28 PM     |

    ###****Updating this TestCase
    #Step 43
    Then Click on button "Close" on Trip Plan
    #Step 44
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Enable Routing Consolidate Locations |
      | True                 |
    And Click on Button with Value "Save" -
    Then Wait for "1" Seconds
    Then Switch to Parent Frame

    #Step 45
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Chicago Pizza  |Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      |Fleet|
      |True |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | 0915            | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New Orleans Saints|  3             | NA                       | 1315-1345    | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details

    #Step46
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
#    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

    #Step 47
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds

    #Step 48
    Then Update "1" Segment details
      |Search        |Driver                     |Driver Confirmation Status |Load|
      |Tractor 1009      |Bruce Fleet Carrier Two 9  |Accepted                   |SysData=>2L|

    Then Update "1" leg details
      | Start Type  | Location |
      | Location    | Chicago Bears      |
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |1           |6:00 AM     |
    Then Update "2" leg details
      | Due Out Time|
      | 10:30 AM     |
    Then Wait for "2" Seconds
    #Step 49
    Then Click on "Add Leg Below" on "1" Leg
    Then Wait for "3" Seconds
    #Step 50
    Then Update "2" leg details
      | Due Out Date | Due Out Time | End Type | Location_2        | Appointment Date  |Appointment Start Time|Appointment End Time|
      | 1            | 9:45 AM      | Location | New Orleans Saints | 2                |6:15 AM      |7:00 AM                      |
    Then Wait for "1" Seconds

    #Step 51
    Then Update "3" leg details
         |Due Out Date|
         |3           |

    #Step 52
     Then Verify Segment "1" "Consolidate Same Locations When Routing" is "True"
  #Step 53
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID_2"
    Then Verify "1" Segment Status as "Configured"

  #Step 54
    Then Update "1" Segment details
      | Status     |
      | Dispatched  |
    Then Wait for "2" Seconds
    Then Click on button with Title "Trimble Trip Management Alerts"
    Then Wait for "2" Seconds
    Then Edit the following to "Move selection to Active"
      |Stop Status|
      |Stop Status|
    Then Click on button with Title "Save & Close" on Modal Footer
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
   #Step 55
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

      #Step 56 & 57

    Then Wait for "40" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>2LRI" and Store onto "API Trip Id"
    Then Get "Id" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>2LRI" and Store onto "TripPlanSegment_SFID_2"


     #Step 58
    Then Get "departedQT4_2446.txt" files and update below Attributes
      |{tripPlanSegments_SFID}                  |{tripId}      |
      |SysData=>TripPlanSegment_SFID_2          |SysData=>API Trip Id|

    #Step 59, 60
    Then Set "NavigateUrl" Link to "/lightning/o/rtms__QueuedTransaction__c/home"
    Then Open New Tab with url "SysData=>NavigateUrl"
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |Payload 1                |Payload 2|
      |TrimbleInbound    |Inbound  |Pending|application/json|SysData=>{FinalUpdatedText}|       |
    Then Wait for "5" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "6" Seconds
    Then Capture the current URL for "QueuedTransaction"
    #Step 61
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    #Step 62
    Then Delete "QueuedTransactionJob" job
    Then Wait for "6" Seconds

    Then Close and Switch to Previous Window

    #Step 63, 64 , 65
    Then Wait for "3" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds

    #Step 66
    Then Click on button "Trip Events" on Trip Plan
    Then Verify Text displaying as "Trip Events - Trip Plan-"
    #Expected Result g
    Then Get Trip Event Name on "Trip_Event_1"
    Then Verify Assertion for "Trip_Event_1" contains "Trip Event"
    Then Verify details for all Enabled fields
      |Trip Plan                       |Trip Plan Segment|Trip Plan Leg|Event Type          |Is Alert|Date           |Time    |Event Detail                  |
      |SysData=>Trip_Plan_ID_2         |Segment 1        |Leg 2        |Departure             |True    |Jul 15, 2024   |6:24 AM|Stop Status Update. Address: 5800 Airline Dr. Metairie LA 70003|
    Then Verify details for all Enabled fields
      |Action Taken|Addressed By|
      |            |NA          |
    #Step 67
    Then Click on button "Close" on Trip Event
    Then Wait for "1" Seconds
   #Step 68
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    #Expected Result h
    Then Verify "2" leg details
      | Departure Date | Departure Time |
      | Jul 15, 2024   | 6:24 AM        |
    Then Verify "3" leg details
      | Departure Date | Departure Time |
      | Jul 15, 2024   | 6:24 AM        |

    #Step 69
    Then Update "1" Segment details
      |Status|Driver Confirmation Status |Consolidate Same Locations When Routing|
      |Pending|Pending                   |False                                  |
    Then Update "2" leg details
      | Departure Date | Departure Time |
      |    |         |
    Then Update "3" leg details
      | Departure Date | Departure Time |
      |    |         |

    #Step 70
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds

    #Step 71
    Then Update "1" Segment details
      | Status     |
      | Dispatched  |
    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
      #Step 72 & 73
    Then Open New Tab with url "SysData=>QueuedTransaction"
    Then Wait for "2" Seconds
    #Step 74
    Then Click on "Clone" button
    Then Wait for "2" Seconds
    #Step 75
    Then Verify Text displaying as "New Queued Transaction" -
    Then Update details -
      |Status |Processing Time|Status (Indexed)|Fingerprint|
      |Pending|               |                |           |
    Then Wait for "5" Seconds
    #Step 76
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 77
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    #Step 78
    Then Delete "QueuedTransactionJob" job
    Then Wait for "6" Seconds
    Then Close and Switch to Previous Window
    #Step 79, 80, 81
    Then Wait for "3" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds

   #Step 82
    #Expected Result h
    Then Verify "2" leg details
      | Departure Date | Departure Time |
      | Jul 15, 2024   | 6:24 AM        |
    Then Verify "3" leg details
      | Departure Date | Departure Time |
      | NA   | NA        |