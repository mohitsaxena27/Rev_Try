Feature: 2522 - Fleet Trip Planner LWC- Leg Dates/Times Functionality

  @API @Regression @WEB @Smoke @SingleCurrency @TMS @Fleet_Trip_Planner @2522
   Scenario: 2522 - Fleet Trip Planner LWC- Leg Dates/Times Functionality

    Then Login into Salesforce
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
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | 0830            | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats    |  4            | NA                       |  1445-1515     | True                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

    #Step2
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
     #Step3
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds
#
#    Then Set "Trip_Plan_ID" with "Trip Plan-54"
#    Then Scroll into Section "View - Trip Plan"
#    Then Scroll down with "4" Times
#    Then Update details
#      |Trip Plan(s)|
#      |SysData=>Trip_Plan_ID       |
#    Then Click on "Refresh" under "View - Trip Plan" Section
#    Then Wait for "2" Seconds
#    Then Click on "SysData>Trip_Plan_ID" under "View - Trip Plan" Section
#    Then Wait for "2" Seconds
#    Then Verify Text displaying as "Plan Trip - Trip Plan" -

   #Step 4
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

     #Step 5
    Then Update "1" Segment details
      | Load   |
      | SysData=>1L |
    Then Wait for "1" Seconds

     #Expected a
    Then Verify "1" leg details
      | Start Type    | Location                |Due Out Date|Due Out Time|
      | Location      |                         |            |            |
    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 1P - Boston Beans  | 1                | 8:30 AM      |8:30 AM                      |
    Then Verify "1" leg Timezone is "undefined"
    Then Verify "2" leg details
      | Start Type    | Location                |Due Out Date|Due Out Time|
      | Load Stop     | Stop 1P - Boston Beans  | 1          |            |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Denver Deli Meats     | 4               | 2:45 PM      |3:15 PM|
    Then Verify "1" leg Timezone is "undefined"

    #Step 6
    Then Update "1" leg details
      |Appointment End Time|
      |10:15 AM |

    #Step 7
    Then Update "2" leg details
      |Appointment Start Time|Appointment End Time|
      |                      |                    |
    Then Wait for "1" Seconds

    #Step 8
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Expected b
    Then Verify "1" leg details
      | Start Type    | Location                |Due Out Date|Due Out Time|
      | Location      |                         |            |            |
    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 1P - Boston Beans  | 1                | 8:30 AM      |10:15 AM                      |
    Then Verify "1" leg Timezone is "undefined"
    Then Verify "2" leg details
      | Start Type    | Location                |Due Out Date|Due Out Time|
      | Load Stop     | Stop 1P - Boston Beans  | 1          |            |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Denver Deli Meats     | 4                |                       ||
    Then Verify "2" leg Timezone is "undefined"

    #Step 9
    Then Update "1" leg details
      | Start Type    | Location                |
      | Terminal      | Georgia Terminal        |

    #Step 10
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    #Expected c
    Then Verify Text displaying as "Do you want to save your changes before refreshing the page?"
    Then Verify "SteelBlue" backGround Color with Text of "Undo Changes and Refresh" Button is "Enabled"
    Then Verify "SteelBlue" backGround Color with Text of "Save and Refresh" Button is "Enabled"
    Then Verify "Close" icon is displaying

    #Step 11
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
    #Expected d
    Then Verify "1" leg details
      | Start Type    | Location                |
      | Location      |                         |

    #Step 12
    Then Update "1" leg details
      | Start Type    | Location                |
      | Location      | New England Patriots    |

    #Step 13
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on "Close" icon for close modal

    #Expected e
    Then Verify "1" leg details
      | Start Type    | Location                |
      | Location      | New England Patriots    |

     #Step 14
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Save and Refresh"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

     #Expected f
    Then Verify "1" leg details
      | Start Type    | Location                |
      | Location      | New England Patriots    |
    Then Verify "1" leg Timezone is "America/New_York"
    Then Verify "2" leg Timezone is "America/Denver"

    #Step 15 & 16
    Then Open New Tab with url "SysData=>Load_Details"
    Then Wait for "2" Seconds
    #Expected g
    Then Verify "1P" Stop Details
         |Appointment Time|
         |08:30-10:15     |
    Then Verify "2D" Stop Details
      |Appointment Time|
      |                |

    #Step 17
    Then Wait for "1" Seconds
    Then Expand "Details" for "1" Load
    Then Click on Edit icon with Field Name "1P" "Expected Date"
    Then Update details
      |Expected Date|Appointment Time     |
      |0            |2000        |
    #Step 18
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "1P" Details
      |Appointment Time|
      |20:00            |
    Then Collapse "Details" for "1" Load

    #Step 19
    Then Wait for "1" Seconds
    Then Expand "Details" for "2" Load
    Then Click on Edit icon with Field Name "2D" "Expected Date"
    Then Update details
      |Expected Date|Appointment Time     |
      |3            |0845-0915        |

    #Step 20
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "2D" Details
         |Appointment Time|
         |08:45-09:15        |
    Then Collapse "Details" for "2" Load

    #Step 21, 22 & 23
    Then Close and Switch to Previous Window
    Then Wait for "2" Seconds
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
     #Expected h
    Then Verify "1" leg details
      | Appointment Date |Appointment Start Time |Appointment End Time|
      | 1                | 8:30 AM      |10:15 AM                      |
    Then Verify "2" leg details
      |Due Out Date|Due Out Time|
      | 1          |            |
    Then Verify "2" leg details
      | Appointment Date |Appointment Start Time |Appointment End Time|
      | 4                |                       |                    |
    Then Wait for "2" Seconds

    #Step 24
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |1            | 6:00 AM   |
    Then Update "1" leg details
      | Appointment Date |Appointment Start Time |Appointment End Time|
      | 2                | 9:45 AM               |11:30 AM            |

    Then Update "2" leg details
      |Due Out Date|Due Out Time|
      | 3          |8:15 AM     |
    Then Update "2" leg details
      | Appointment Date |Appointment Start Time |Appointment End Time|
      | 7               | 5:00 PM      |6:30 PM|

     #Step 25
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 26
    Then Navigate to stored URL for "Load_Details"

    #Expected i
    Then Verify "1P" Stop Details
      |Expected Date|Appointment Time|
      |2            |09:45-11:30     |
    Then Verify "2D" Stop Details
      |Expected Date|Appointment Time|
      |7            |17:00-18:30     |
