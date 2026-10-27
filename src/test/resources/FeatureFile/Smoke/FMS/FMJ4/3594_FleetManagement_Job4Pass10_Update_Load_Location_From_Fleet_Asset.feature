Feature: 3594 - Fleet Management Job 4- Pass 10- Update Load Location From Fleet Asset


#  @API @Regression @WEB @smoke @FMS @SingleCurrency  @3594 @Catena
  Scenario: 3594 - Fleet Management Job 4- Pass 10- Update Load Location From Fleet Asset

    When Login into Salesforce
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    Then Set Field Value "Customer Number" into "Customer_Number" Value
    Then Verify "SysData=>Customer_Number" value is not empty

    # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob4"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #Step 3, 4 & 5 & 6
    Then Get Access token using "3594_GetAccessToken.json" and store in "Access_Token"
    Then Get Driver "Bruce Fleet Carrier Two 8" Details using "Access_Token"

    # Step 7
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 8" from List
    Then Wait for "2" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID               |ELD Brand|ELD Enabled|
      | SysData=>Driver_id   |Samsara    |True       |
    Then Click on button with Title "Save"
    Then Wait for "4" Seconds
    Then Verify "ELD ID" having value of "SysData=>Driver_id"

   # Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      | Fleet |
      | True  |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | 0830             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | 7             | NA                       | 1445-1530        | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Mixed       | 13000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    # Step 9
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 10
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job

    # Step 11
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

# Step 12
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Load        |
      | SysData=>1L |
    Then Wait for "8" Seconds

# Step 12.a
    Then Verify "1" leg details
      | End Type  | Location_2             | Appointment Date | Appointment Start Time | Appointment End Time |
      | Load Stop | Stop 1P - Boston Beans | 1                | 8:30 AM                | 8:30 AM              |

# Step 12.b -
    Then Verify "2" leg details
      | Start Type | Location              | Due Out Date |
      | Load Stop  | Stop 1P - Boston Beans | 1            |

# Step 12.c
    Then Verify "2" leg details
      | End Type  | Location_2                     | Appointment Date | Appointment Start Time | Appointment End Time |
      | Load Stop | Stop 2D - Los Angeles Lighting | 7                | 2:45 PM                | 3:30 PM              |


    Then Update "1" Segment details
      | Search         | Driver                    | Driver Confirmation Status |
      | T THREEFIVENINE-FOUR | Bruce Fleet Carrier Two 8 | Accepted                   |
    Then Wait for "5" Seconds


    Then Update "1" leg details
      | Start Type | Location             | Due Out Date | Due Out Time |
      | Location   | Los Angeles Lighting | 0            | 1:15 AM      |
    Then Wait for "3" Seconds

    Then Update "2" leg details
      | Due Out Time |
      | 12:30 PM     |
    Then Wait for "3" Seconds

    # Step 13
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Verify "1" Segment details
      | Status     |
      | Configured |
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    # Step 14
    Then Click on button with Title "Dispatch"
    Then Verify Success Message displaying as "Trip has been successfully created in the ELD."
    Then Close Toast message
    Then Close Toast message
    Then Wait for "3" Seconds
    Then Verify "1" Segment details
      | Status     |
      | Dispatched |
    Then Wait for "3" Seconds
    Then Click on button with Title "Save & Close"
    Then Wait for "2" Seconds

    # Step 15
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "T THREEFIVENINE-FOUR" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Information"
    Then Click on Edit icon on Label "ELD Last Update"

    # Step 16
    Then Set "ELD_Last_Update" Date with "0" days
    Then Set "ELD_Last_Update" Time with "60" min before
    Then Update details
      | Latitude  | Longitude  |
      | 41.257169 | -95.995102 |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Information"
    Then Get Details
         |ELD Last Update|
         |               |
    Then Subtract 15 minutes from "SysData=>ELD Last Update" and store on "UpdatedDateTime"
    Then Capture the current URL for "Fleet_Asset1"


    # Step 17
#    Then Open "TMS Admin" from App Launcher
#    Then Go to "Configuration" Tab
#    Then Switch to Frame by Title "accessibility title"
#    Then Scroll into Section "Fleet Management" -
#    Then Update details -
#      | Fleet Management Job Last Run |
#      | SysData=>UpdatedDateTime      |
#    And Click on Button with Value "Save" -
#    Then Verify Text displaying as "Save was successful." -
#    Then Switch to Parent Frame
#    Then Wait for "2" Seconds

    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
    Then Update details -
      | Fleet Management Job Last Run |
      | SysData=>FinalDate            |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    # Step 18
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Get Date and Time for "Previous Run Time" of "FleetManagementJob4" onto "PreviousRunTime"

   # Step 19 & Expected Result a
    Then Navigate to stored URL for "Load_1"
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Last Reported Geolocation |
      | 41.257169, -95.995102     |

    # Step 20 & Expected b
    Then Refresh current Page
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "3" Seconds
    Then Verify "" data is created with following details
      | Type            | Reported Location | Comments | Status As Of             | Update Received At       | Source |
      | Location Update | Omaha, NE US      | NA       | SysData=>PreviousRunTime | SysData=>PreviousRunTime | ELD    |

    # Step 21
    Then Navigate to stored URL for "Fleet_Asset1"
    Then Scroll into Section "ELD Information"
    Then Click on Edit icon on Label "ELD Last Update"
    Then Set "ELD_Last_Update" Date with "0" days
    Then Set "ELD_Last_Update" Time with "30" min before
    Then Update details
      | Latitude | Longitude  |
      | 39.71136 | -105.34851 |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Information"
    Then Get Details
      |ELD Last Update|
      |               |
    Then Subtract 15 minutes from "SysData=>ELD Last Update" and store on "UpdatedDateTime"

#    Then Open "TMS Admin" from App Launcher
#    Then Go to "Configuration" Tab
#    Then Switch to Frame by Title "accessibility title"
#    Then Scroll into Section "Fleet Management" -
#    Then Update details -
#      | Fleet Management Job Last Run |
#      | SysData=>UpdatedDateTime      |
#    And Click on Button with Value "Save" -
#    Then Verify Text displaying as "Save was successful." -
#    Then Switch to Parent Frame

    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
    Then Update details -
      | Fleet Management Job Last Run |
      | SysData=>FinalDate            |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds


#    # Step 22
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds
    Then Get Date and Time for "Previous Run Time" of "FleetManagementJob4" onto "PreviousRunTime"

    # Step 23
    Then Navigate to stored URL for "Load_1"
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Last Reported Geolocation |
      | 39.71136, -105.34851      |

   # Step 24
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "2" Seconds
    Then Verify "" data is created with following details
      | Type            | Reported Location | Comments | Status As Of              | Update Received At        | Source |
      | Location Update | Evergreen, CO US  | NA       | SysData=>PreviousRunTime | SysData=>PreviousRunTime | ELD    |