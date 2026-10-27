Feature: 2418 - Trimble API- Cancel Trip Operation

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @2418
  Scenario: 2418 - Trimble API- Cancel Trip Operation

    When Login into Salesforce

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
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830-1650           | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | 1445-1600       | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    #Step 2
    Then Save Load With All details
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
    Then Click on View Manager icon
    Then Verify Text displaying as "View Manager"
    Then Wait for "4" Seconds
    Then Select View Manager as "Revenova Loads"
    Then Wait for "4" Seconds
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

  #Step 6
    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time | Appointment End Time|
      | Load Stop   | Stop 1P - Boston Beans  | 0            | 8:30 AM      | 4:50 PM  |
    Then Verify "2" leg details
      | Start Type    | Location                |Due Out Date|
      | Load Stop     | Stop 1P - Boston Beans  | 0          |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Denver Deli Meats     | 3                | 2:45 PM      |4:00 PM                      |

    Then Update "1" Segment details
      |Search                                 |Driver                                       | Driver Confirmation Status |
      |Tractor Two Thousand Four Hundred and Seven| QA Driver Two Thousand Four Hundred and Seven | Accepted |

    Then Update "1" leg details
      |Start Type         |Location                            |
      | Terminal  | Georgia Terminal |
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |0           | 5:15 AM     |

    Then Update "2" leg details
      | Due Out Time|
      | 12:30 PM     |
  #Step 7
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "7" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Verify "1" Segment details
        |Status|
        |Configured|

     #Step 8
    Then Click on button with Title "Add Segment Above"
    Then Wait for "4" Seconds

   #Step 9
    Then Update "1" Segment details
      |Search                                 |Driver                                       | Driver Confirmation Status |
      |Tractor Two Thousand Four Hundred and Eighteen | QA Driver Two Thousand Four Hundred and Seven | Accepted |

    Then Update "1" leg details
      |Start Type         |Location                            |
      | Border Crossing  | Canada Border Services Agency  |
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |0           | 12:30 AM     |

    Then Update "1" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Terminal    | Missouri Terminal                 |0               | 2:00 AM               |2:00 AM                      |
     #Step 10
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Update "1" Segment details
      |   Status |
      | Dispatched |
    Then Click on button with Title "Save"
    Then Verify Message displaying with Text "Save was successful."
     Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Wait for "4" Seconds

      #Step 11
    Then Click on button with Title "Add Segment Below"
    Then Wait for "4" Seconds

    #Step 12
    Then Update "2" Segment details
      |Search                                |Driver                                       |Driver Confirmation Status |
      | Tractor Two Thousand Four Hundred and Eighteen half |QA Driver Two Thousand Four Hundred and Seven|Accepted                   |

    Then Update "2" leg details
      | Start Type            | Location          |Due Out Date|Due Out Time|
      | Terminal     | Missouri Terminal          | 0          | 2:15 AM|
    Then Update "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Terminal    | Georgia Terminal                 |0               | 5:00 AM               |  5:00 AM                      |

     #Step 13
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Update "2" Segment details
      |   Status |
      | Dispatched |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."

    #Step 14
    Then Wait for "40" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" & "name" with value "Segment 1" and Store onto "Segment_1_API_ID"
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" & "name" with value "Segment 2" and Store onto "Segment_2_API_ID"
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" & "name" with value "Segment 3" and Store onto "Segment_3_API_ID"

     #Step 15,16,17,18
#    Then Close and Switch to Previous Window
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds

    #Step 19
    Then Click on "Remove Segment" on "3" Segment
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "15" Seconds

    #Step 20 , 21 & 22
     Then Get Trip Status and Name from Trimble for Trip Id "Segment_3_API_ID"
    #Expected Result a
    Then Verify Assertion for "Name" contains "{Trip_Plan_ID} Segment 3"
    Then Verify Assertion for "tripStatus" contains "Canceled"

    #Step 23 , 24 & 25,26, 27 & 28
    Then Update "1" Segment details
      | Status |
      | Configured  |
    Then Click on button with Title "Save"
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "2" Seconds
    #Step 29
    Then Click on button with Title "Undispatch"
    Then Verify Message displaying with Text "The driver was undispatched successfully."
    Then Wait for "15" Seconds
    #Step 30 , 31 & 32
    Then Get Trip Status and Name from Trimble for Trip Id "Segment_2_API_ID"
    #Expected Result b
    Then Verify Assertion for "Name" contains "{Trip_Plan_ID} Segment 2"
    Then Verify Assertion for "tripStatus" contains "Canceled"

    #Step 32 , 33 & 34
    Then Get Trip Status and Name from Trimble for Trip Id "Segment_1_API_ID"
    #Expected Result c
    Then Verify Assertion for "Name" contains "{Trip_Plan_ID} Segment 1"
    Then Verify Assertion for "tripStatus" contains "Canceled"

    #Step 36
    Then Wait for "40" Seconds
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" & "name" with value "Segment 1" and Store onto "Segment_1_API_ID_Updated"

    #Expected d
    Then Verify Assertion for "Segment_1_API_ID_Updated" contains ""

