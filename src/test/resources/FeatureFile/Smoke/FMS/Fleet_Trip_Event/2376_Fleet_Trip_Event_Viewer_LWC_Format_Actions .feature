Feature: 2376 - Fleet Trip Event Viewer LWC- Format/Actions


  @Regression @Smoke @WEB @FMS @SingleCurrency @Fleet_Trip_Event @2376
  Scenario: 2376 - Fleet Trip Event Viewer LWC- Format/Actions

    When Login into Salesforce
    Then Delete All Records with name "EManifest-" for "rtms__EManifest__c"
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
#    Step 1
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
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | 1530             | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    #Step 2
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

    #STep 3
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
     #Step 4
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

     #Step 5
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 6
    Then Update "1" Segment details
      | Search       | Driver                   |
      | Tractor 1002 | Dave Fleet Carrier One 2 |
    #Step 7
    Then Update "1" leg details
      | Start Type | Location    |
      | Location   | Revenova HQ |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 0            | 6:30 AM      |
    Then Update "2" leg details
      | Due Out Time |
      | 9:30 AM      |
    Then Wait for "2" Seconds
    #Step 8
    Then Click on button with Title "Add Segment Below"
    Then Wait for "2" Seconds
    #Step 9
    Then Click on "Add Leg Below" on "3" Leg
    Then Wait for "1" Seconds

    #Step 10
    Then Update "2" Segment details
      | Search       | Driver                   |
      | Tractor 1002 | Dave Fleet Carrier One 2 |
    Then Update "3" leg details
      | Start Type | Location          |
      | Location   | Denver Deli Meats |
    Then Update "3" leg details
      | Due Out Date | Due Out Time |
      | 3            | 4:00 PM      |

    Then Update "3" leg details
      | End Type | Location_2    |
      | Location | Chicago Pizza |
    Then Update "3" leg details
      | Appointment Date | Appointment Start Time |
      | 6                | 9:00 AM                |
    Then Verify "4" leg details
      | Start Type | Location      |
      | Location   | Chicago Pizza |
    Then Update "4" leg details
      | Due Out Date | Due Out Time |
      | 6            | 10:00 AM     |
    Then Update "4" leg details
      | End Type | Location_2  |
      | Location | Revenova HQ |
    Then Update "4" leg details
      | Appointment Date | Appointment Start Time |
      | 6                | 12:00 PM               |

   #Step 11
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

      #########Remove block
#    Then Set "Trip_Plan_ID" with "Trip Plan-57"
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

    #Step 12
    Then Click on button "Trip Events" on Trip Plan
#    #Step 13 & Expected Result a
    Then Set "Trip_Event_Heading_Text" with "Trip Events - " and "SysData=>Trip_Plan_ID"
    Then Trip Event - Verify Icon "standard:tour" is displaying with background color "Light Grey"
    Then Verify Text displaying as "SysData=>Trip_Event_Heading_Text"
    Then Trip Event : Verify "SteelBlue" Color with "White" Text of "Add" Button is "Enabled"
    Then Trip Event : Verify "SteelBlue" Color with "White" Text of "Close" Button is "Enabled"
    Then Verify table headers on Revenova Modals
      | Name              |
      | Trip Plan         |
      | Trip Plan Segment |
      | Trip Plan Leg     |
      | Type              |
      | Date/Time         |
      | Event Detail      |
      | Action Taken      |
      | Addressed By      |
      | Is Alert          |

    #Step 14
    Then Click on button with Title "Add"
    Then Wait for "2" Seconds
    Then Update details
      | Event Type           |
      | Driver Declined Load |
    #Expected b
    Then Verify details for all Required Enabled fields
      | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Event Type           |
      | SysData=>Trip_Plan_ID |                   |               | Driver Declined Load |
    Then Trip Event : Verify Text displaying as "Event Datetime"
    Then Verify details for all Required Enabled fields
      | Date | Time | Event Detail |
      |      |      |              |
    Then Trip Event : Verify Text displaying as "Addressed Datetime"
    Then Verify details for all Enabled fields
      | Addressed By | Date_2 | Time_2 | Is Alert | Action Taken |
      |              |        |        | False    |              |
    Then Trip Event : Verify Text displaying as "Driver"
    Then Trip Event : Verify Text displaying as "Driver Decline Reason"
    Then Trip Event : Verify Text displaying as "Driver Decline Comments"

    Then Trip Event : Verify "SteelBlue" Color with "White" Text of "Save" Button is "Enabled"
    Then Trip Event : Verify "SteelBlue" Color with "White" Text of "Save & Close" Button is "Enabled"
    Then Trip Event : Verify "SteelBlue" Color with "White" Text of "Cancel" Button is "Enabled"

    Then Set "Chatter_Feed_Text" with "Chatter Feed - " and "SysData=>Trip_Plan_ID"
    Then Verify Text displaying as "SysData=>Chatter_Feed_Text"
    Then Verify details for all Enabled fields
      | Post |
      |      |
    Then Verify "SteelBlue" Color with "White" Text of "Share" Button is "Enabled"
    Then Trip Event : Verify Text displaying as "Detail"
    Then Trip Event : Verify Text displaying as "Created Date"
    Then Trip Event : Verify Text displaying as "Created By"

    #Step 15
    Then Update details
      | Trip Plan Segment | Trip Plan Leg | Is Alert | Event Detail |
      | Segment 1         | Leg 2         | True     | Test Detail  |
    Then Update Legend details
      | Event Datetime, Date | Event Datetime, Time |
      | 3                    | 3:00 PM              |

     #Step 16
    Then Update details
      | Event Type |
      | Arrival    |

    #Expected c
    Then Trip Event : Verify Text not displaying as "Driver"
    Then Trip Event : Verify Text not displaying as "Driver Decline Reason"
    Then Trip Event : Verify Text not displaying as "Driver Decline Comments"

    #Step 17
    Then Trip Event : Click on button with Title "Save"
    #Expected d
    Then Verify Message displaying as "Save was successful."
    Then Verify Text displaying as "SysData=>Trip_Event_Heading_Text"

    #Step 18 & Expected e
    Then Verify "1" row is added in Trip Events table with below details
      | SelectCheckbox | Name         | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Type    | Date    | Time     | Event Detail | Action Taken | Addressed By | Is Alert |
      | False          | Trip Event-# | SysData=>Trip_Plan_ID | Segment 1         | Leg 2         | Arrival | Date=>3 | 03:00 PM | Test Detail  |              |              | true     |

    #Step 19
    Then Trip Event : Click on button with Title "Add"
    Then Wait for "2" Seconds
    #Expected f
    Then Verify details for all Required Enabled fields
      | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Event Type |
      | SysData=>Trip_Plan_ID |                   |               |            |
    Then Verify details for all Required Enabled fields
      | Date | Time | Event Detail |
      |      |      |              |
    Then Verify details for all Enabled fields
      | Addressed By | Date_2 | Time_2 | Is Alert | Action Taken |
      |              |        |        | False    |              |
    Then Verify "1" row is added in Trip Events table with below details
      | SelectCheckbox | Name         | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Type    | Date    | Time     | Event Detail | Action Taken | Addressed By | Is Alert |
      | False          | Trip Event-# | SysData=>Trip_Plan_ID | Segment 1         | Leg 2         | Arrival | Date=>3 | 03:00 PM | Test Detail  |              |              | true     |

    #Step 20
    Then Trip Event : Click on button with Title "Cancel"
    Then Wait for "2" Seconds

    #Expected g
    Then Trip Event - Verify Icon "standard:tour" is displaying with background color "Light Grey"
    Then Verify Text displaying as "SysData=>Trip_Event_Heading_Text"
    Then Trip Event : Verify "SteelBlue" Color with "White" Text of "Add" Button is "Enabled"
    Then Trip Event : Verify "SteelBlue" Color with "White" Text of "Close" Button is "Enabled"
    Then Verify "1" row is added in Trip Events table with below details
      | SelectCheckbox | Name         | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Type    | Date    | Time     | Event Detail | Action Taken | Addressed By | Is Alert |
      | False          | Trip Event-# | SysData=>Trip_Plan_ID | Segment 1         | Leg 2         | Arrival | Date=>3 | 03:00 PM | Test Detail  |              |              | true     |

    #Step 21
    Then Trip Event : Click on button with Title "Add"
    Then Wait for "2" Seconds
    Then Update details
      | Trip Plan Segment | Trip Plan Leg | Event Type | Is Alert | Event Detail  |
      | Segment 2         | Leg 4         | Departure  | True     | Test Detail 2 |
    Then Update Legend details
      | Event Datetime, Date | Event Datetime, Time |
      | 6                    | 12:30 PM             |
    #Step 22
    Then Trip Event : Click on button with Title "Save & Close"
    #Expected Result h
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Verify Text not displaying as "SysData=>Trip_Event_Heading_Text"

    #Step 23
    Then Click on button "Trip Events" on Trip Plan
    Then Wait for "2" Seconds
    #Expected Result i
    Then Verify details for all Required Enabled fields
      | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Event Type |
      | SysData=>Trip_Plan_ID | Segment 2         | Leg 4         | Departure  |
    Then Verify details for all Required Enabled fields
      | Date | Time     | Event Detail  |
      | 6    | 12:30 PM | Test Detail 2 |
    Then Verify details for all Enabled fields
      | Addressed By | Date_2 | Time_2 | Is Alert | Action Taken |
      |              |        |        | True     |              |
    Then Verify "1" row is added in Trip Events table with below details
      | SelectCheckbox | Name         | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Type      | Date    | Time     | Event Detail  | Action Taken | Addressed By | Is Alert |
      | True           | Trip Event-# | SysData=>Trip_Plan_ID | Segment 2         | Leg 4         | Departure | Date=>6 | 12:30 PM | Test Detail 2 |              |              | true     |

    Then Verify "2" row is added in Trip Events table with below details
      | SelectCheckbox | Name         | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Type    | Date    | Time     | Event Detail | Action Taken | Addressed By | Is Alert |
      | False          | Trip Event-# | SysData=>Trip_Plan_ID | Segment 1         | Leg 2         | Arrival | Date=>3 | 03:00 PM | Test Detail  |              |              | true     |

    #Step 24
    Then Trip Event : Select Event Records With "Type" as "Arrival"
    Then Wait for "2" Seconds
     #Expected Result J
    Then Verify details for all Required Enabled fields
      | Trip Plan             | Trip Plan Segment | Trip Plan Leg | Event Type |
      | SysData=>Trip_Plan_ID | Segment 1         | Leg 2         | Arrival    |
    Then Verify details for all Required Enabled fields
      | Date | Time    | Event Detail |
      | 3    | 3:00 PM | Test Detail  |
    Then Verify details for all Enabled fields
      | Addressed By | Date_2 | Time_2 | Is Alert | Action Taken |
      |              |        |        | True     |              |

    #Step 25
    Then Update details
      | Post                                 |
      | @Second User test Trip Event chatter |
    #Step 26
    Then Trip Event : Click on button with Title "Share"
    #Expected Result k
    Then Verify Message displaying as "Your comment was posted."
    Then Wait for "2" Seconds
    Then Verify chatter details
      | Detail                               | Created By | Created Date |
      | @Second User test Trip Event chatter | User User  | Date=>0      |
    #Step 27
    Then Trip Event : Click on button with Title "Close"
    Then Wait for "4" Seconds
    #Expected Result l
    Then Verify Text displaying as "SysData=>Trip_Plan_ID" -
    Then Verify Text not displaying as "SysData=>Trip_Event_Heading_Text"

    #Step 28
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds
    Then Navigate to stored URL for "Load_Details"
    #Step 29
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "1P" "Location"
    Then Update Location as "Boston Red Sox"
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Collapse "Details" for "1" Load

    #Step 30
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
     #Step 4
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

#    #Step 31
#    Then Set "Trip_Plan_ID" with "Trip Plan-57"
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      | Trip Plan Start Date |
      | Today                |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    #Step 32
    Then Verify Text displaying as "Plan Trip - Trip Plan" -
    #Expected Result m
    Then Verify details for all Enabled fields
      | Status       |
      | Load Changed |
    Then Trip Plan - Status is highlighted "Yellow"
    #Step 33
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Fleet Asset"
    Then Update "View - Fleet Asset" details
      | Asset        |
      | Tractor 1002 |
    Then Click on "Refresh" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    #Expected n
    Then Verify Trip Event count is "3" for "Tractor 1002"

    #Step 34
    Then Click on Trip Event for "Tractor 1002"
    #Expected o
    Then Trip Event : Verify Trip Event Count is "3"
   #Step 35
    #Step 24
    Then Trip Event : Select Event Records With "Type" as "Load Changed"
    Then Wait for "2" Seconds
     #Expected Result p
    Then Verify details for all Required Enabled fields
      | Trip Plan             | Event Type   |
      | SysData=>Trip_Plan_ID | Load Changed |
    Then Verify details for all Required Enabled fields
      | Date | Event Detail                                                               |
      | 0    | The load's stops have been modified.  Please update Trip Plan accordingly. |
    Then Verify Label "Time" is displaying with Value of "SysData=>CurrentTime"
    Then Verify details for all Enabled fields
      | Is Alert |
      | True     |