Feature: 2452 - Fleet Management Job 2 - Update Load Location from Fleet Asset

  Background: Pre- Test
    When Login into Salesforce

#    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob2"
    Then Update details -
      | Fleet Management Enabled | Fleet Management Pass Counter |
      | True                     | 1                             |
    Then Click on Button with Value "Save" -
    Then Switch to Parent Frame
    #Step 2
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job


  #  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @Catena @Motive @2452
  Scenario: 2452 - Fleet Management Job 2 - Update Load Location from Fleet Asset (End-to-End Flow)

#    # Step 1 - Disable Samsara Integration
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | False   |
    Then Click on button with Title "Save"
    #Step 1.a)
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    Then Set Field Value "Customer Number" into "Customer_Number" Value

    # Step 2 - Enable Fleet Management Job 2 Configuration
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob2"
    Then Update details -
      | Fleet Management Enabled | Fleet Management Pass Counter |
      | true                     | 10                            |
    Then Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 3
    Then Get Access token using "2452_GetAccessToken.json" and store in "Access_Token"
    #Step 4
     Then Get Driver "Bruce Fleet Carrier Two 8" Details using "Access_Token"

      # Step 5 - Update Driver ELD ID
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 8" from List
    Then Verify Text displaying as "Bruce Fleet Carrier Two 8"
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID               |ELD Brand|ELD Enabled|
      | SysData=>Driver_id   |Samsara    |True       |
    Then Click on button with Title "Save"
    Then Wait for "4" Seconds
    Then Verify "ELD ID" having value of "SysData=>Driver_id"


    # Step 6
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
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    #Step 7
    Then Save Load With All details
    #Step 8
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    # Step 9, 10
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Verify button is present with "Driver Assignment"
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds

   # Step 11
    Then Update "1" Segment details
      | Load        |
      | SysData=>1L |
     Then Wait for "5" Seconds

    #Step12
    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time |
      | Load Stop   | Stop 1P - Boston Beans  | 1            | 8:30 AM      |
    Then Verify "2" leg details
      | Start Type    | Location               |Due Out Date|
      | Load Stop     | Stop 1P - Boston Beans  | 1          |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Los Angeles Lighting  | 7                | 2:45 PM      |3:30 PM                      |
   #Step 12.b
    Then Update "1" Segment details
      | Driver                                        | Search                                  | Driver Confirmation Status |
      | Bruce Fleet Carrier Two 8                     | Tractor Two Thousand Four Hundred Fifty Two | Accepted                   |
    Then Update "1" leg details
      | Start Type | Location             | Due Out Date | Due Out Time |
      | Location   | Los Angeles Lighting | 0            | 1:15 AM      |
    Then Update "2" leg details
      | Due Out Time |
      | 12:30 PM     |

      # step 13
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Verify "1" Segment Status as "Configured"

    # Step 14
    Then Update "1" Segment details
      | Status |
      | Dispatched     |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Set key "Trip_Plan_ID_1" for Object "rtms__TripPlan__c " and Name "SysData=>Trip_Plan_ID"
    Then Click on button with Title "Close"
    Then Wait for "2" Seconds

     #Step 15
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "Tractor Two Thousand Four Hundred Fifty Two" from List

    # Step 16 & 17
    Then Scroll into Section "ELD Information"
    Then Click on Edit icon on Label "ELD Last Update"
    Then Set "ELD_Last_Update" Date with "0" days
    Then Set "ELD_Last_Update" Time with "60" min before
    Then Update details
      | Latitude  | Longitude  |
      | 41.257169 | -95.995102 |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds

    #Step 18
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      |Fleet Management Job Last Run|
      |SysData=>ELD_Last_Update      |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 19
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Set "PreviousRunTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "6" Seconds

    # Step 20
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    #Expected a
    Then Verify Details
      | Last Reported Geolocation |
      | 41.257169, -95.995102     |

    # Step 21
    Then Refresh current Page
    #Expected b
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "1" Seconds
    Then Verify "" data is created with following details
      | Type            | Reported Location | Comments |Status As Of|Update Received At| Source |
      | Location Update | Omaha, NE US      | NA       | SysData=>PreviousRunTime           |SysData=>PreviousRunTime                 |ELD    |

    # Step 22
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "Tractor Two Thousand Four Hundred Fifty Two" from List
    # Step 23
    Then Scroll into Section "ELD Information"
    Then Click on Edit icon on Label "ELD Last Update"
    Then Set "ELD_Last_Update" Date with "0" days
    Then Set "ELD_Last_Update" Time with "30" min before
    Then Update details
      | Latitude | Longitude  |
      | 39.71136 | -105.34851 |
    Then Click on button with Title "Save"
    Then Wait for "2" Seconds

    # Step 24
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Set "PreviousRunTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    Then Wait for "6" Seconds

    # Step 25
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Go to "Details" Tab

    # Expected results C
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Last Reported Geolocation |
      | 39.71136, -105.34851     |

    # Step 26
    Then Refresh current Page

  # Expected results d
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "1" Seconds
    Then Verify "" data is created with following details
      | Type            | Reported Location     | Comments |Status As Of|Update Received At|Source |
      | Location Update | Evergreen, CO US      | NA       |SysData=>PreviousRunTime           |SysData=>PreviousRunTime                 |ELD    |

