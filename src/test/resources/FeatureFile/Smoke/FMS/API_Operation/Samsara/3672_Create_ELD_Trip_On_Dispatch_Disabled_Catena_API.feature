Feature: 3672 - TMS Admin Configuration- Create ELD Trip On Dispatch- Disabled- Catena API

  @API @Regression @WEB @Smoke @API_Operation @SingleCurrency @Admin @TMS_Config @3672 @Debugging
  Scenario: 3672 - TMS Admin Configuration- Create ELD Trip On Dispatch- Disabled- Catena API

    # Step 1
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Create ELD Trip On Dispatch |
      | True                       |
    Then Select Fleet Management Job as "FleetManagementJob4"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 2
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job

    # Step 3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    Then Set Field Value "Customer Number" into "Customer_Number" Value

    # Step 4
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bob Test" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Set Field Value "ELD ID" into "Driver_ELD_ID" Value
    Then Click on "Cancel" button

    # Step 5
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "test-vehicle" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Information"
    Then Click on Edit icon on Label "ELD ID"
    Then Set Field Value "ELD ID" into "Fleet_Asset_ELD_ID" Value
    Then Click on "Cancel" button

    # Step 6 : Select 'Trip Planning’> Select 'Plan Trip' button
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "3" Seconds
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "2" Seconds

    # Step 7
    Then Update "1" Segment details
      | Search       | Driver   |
      | test-vehicle | Bob Test |
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      | Load   |
      | A-1268 |
    Then Wait for "5" Seconds
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "1" Seconds
    Then Update "1" leg details
      | Start Type | Location             | Due Out Date | Due Out Time |
      | Location   | Joliet Jazz Supplies | 0            | 12:00 AM     |
    Then Update "1" leg details
      | End Type | Location_2     | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Miami Dolphins | 1                | 12:15 AM               | 12:30 AM             |

    # Step 7
    Then Click on button with Title "Add Trailer"
    Then Update "1" leg details
      | Search       | Action | Cargo Status |
      | Trailer 2034 | Pickup | Empty        |
    Then Click on button with Title "Done"
    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Verify Message displaying as "Save was successful."
    And "Without Capture" and Close all the Toast messages from Bottom

    # Step 9
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    # Step 10 Step 11, 12 and 13
    Then Set key "Trip_Plan_SFID" for Object "rtms__TripPlan__c" and Name "SysData=>Trip_Plan_ID"
    Then Get "Id" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>Trip_Plan_SFID" and Store onto "Trip_Plan_Segment_ID"

   #  Step 14
    Then Click on button with Title "Dispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."

#    # Step 15
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify Message displaying with Text "Trip has been successfully created in the ELD."
    Then Get Access token using "3672_GetAccessToken.json" and store in "Access_Token"
    Then Get Fleet Code using "Access_Token" for Fleet ID "SysData=>Customer_Number"

    # Step 16 & Expected a
    And Update and verify payload for "trip" with "TC3672_CreateTrip_RequestBody_Expected.json"
      | Customer_Number       | Trip_Plan_Segment_ID        | Driver_ELD_ID      | Fleet_Asset_ELD_ID                    | {CurrentDate} |Axle_Tsp_Id|
      | SysData=>Customer_Number | SysData=>Trip_Plan_Segment_ID | SysData=>Driver_ELD_ID | SysData=>Fleet_Asset_ELD_ID | 0              | SysData=>Samsara_AxleID |

    # Step 17 & Expected b
    Then Verify url displaying with "trip" as "https://api.axleapi.com/v1/trip"

    # Step 18 & Expected c
    Then Get Attribute "id" store into "id" from "trip" "Response"
    Then Verify "SysData=>id" value is not empty
    # Step 19,20 & Expected d
    Then Verify Message "Trip has been successfully created in the ELD." displaying stored during enabled logging

    # Step 21, 22. 23 & Expected e & 24
    Then Get "rtms__ELD_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>Trip_Plan_SFID" and Store onto "Trip_Plan_Segment_ELD_ID"
    Then Verify Assertion for "Trip_Plan_Segment_ELD_ID" contains "SysData=>id"
    Then Wait for "3" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    And "Without Capture" and Close all the Toast messages from Bottom
      # Step 25
    Then Click on button with Title "Redispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."

    # Step 26
    Then "Capture" and Close all the Toast messages from Bottom

    # Step 27 & Expected f
    Then Get Attribute "dispatched_at" store into "dispatched_atData" from "Catena" "Request"

    And Update and verify payload for "Catena" with "TC3672_Expected_f_RequestBody.json"
      | Customer_Number       | Trip_Plan_Segment_ID        | Driver_ELD_ID      | Fleet_Asset_ELD_ID                    | {CurrentDate} |Axle_Tsp_Id          |dispatched_at|
      | SysData=>Customer_Number | SysData=>Trip_Plan_Segment_ID | SysData=>Driver_ELD_ID | SysData=>Fleet_Asset_ELD_ID  | 0              |SysData=>Samsara_AxleID |SysData=>dispatched_atData|

    # Step 28 & Expected g
    Then Verify url displaying with "Catena" as "https://api.axleapi.com/v1/trip/{SysData=>id}"

    # Step 29 & Expected h
    Then Get Attribute "id" store into "ReDispatch_id" from "Catena" "Response"
    Then Verify Assertion for "ReDispatch_id" contains "SysData=>id"

    # Step 30. 31 # Expected i
    Then Verify Message "Trip has been successfully updated in the ELD." displaying stored during enabled logging
    Then Close Toast message
    # Step 32
    Then Click on button with Title "Undispatch"
    Then Verify Message displaying with Text "The driver was undispatched successfully."

    # Step 33
    Then "Capture" and Close all the Toast messages from Bottom

    # Step 34 & Expected j
    Then Verify url displaying with "Catena" as "https://api.axleapi.com/v1/trip/{SysData=>id}"

    # Step 35 & Expected k
    And Update and verify Response payload for "Catena" with "TC3672_DispatchTrip_ResponseBody_Expected.json"
      | No Update Required |
      |  |

    # Step 36,37 # Expected l
    Then Verify Message "Trip has been successfully deleted in the ELD." displaying stored during enabled logging
    Then Close Toast message
    # Step 38
    Then Click on button "Close" on Trip Plan

    # Step 39
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | False           |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Enable Routing Consolidate Locations |
      | True                                 |
    Then Select Fleet Management Job as "FleetManagementJob4"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 40
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 8" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
         |ELD ID|ELD Enabled|ELD Brand|
         |5717766|True      |Samsara  |
    Then Click on "Save" button
    Then Wait for "4" Seconds

    #Step 41 & 42
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "3" Seconds
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "2" Seconds

    # Step 43
    Then Update "1" Segment details
      | Search       | Driver                    |
      | Tractor 1045 | Bruce Fleet Carrier Two 8 |
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Update "1" leg details
      | Start Type | Location      | Due Out Date | Due Out Time |
      | Location   | Chicago Bears | 1            | 6:00 AM      |

    Then Update "1" leg details
      | End Type | Location_2    | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Chicago Bears | 1                | 7:15 AM                | 7:45 AM              |

    Then Click on "Add Leg Below" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Start Type | Location      | Due Out Date | Due Out Time |
      | Location   | Chicago Bears | 1            | 8:30 AM      |

    Then Update "2" leg details
      | End Type | Location_2    | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Chicago Bears | 1                | 11:15 AM               | 11:45 AM             |

    # Step 44
    Then Click on button with Title "Add Segment Below"
    Then Wait for "2" Seconds

    # Step 45
    Then Update "2" Segment details
      | Search       | Driver                    |
      | Tractor 1046 | Bruce Fleet Carrier Two 8 |
    Then Wait for "2" Seconds
    Then Update "2" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Update "3" leg details
      | Start Type | Location      | Due Out Date | Due Out Time |
      | Location   | Chicago Bears | 1            | 12:15 PM     |

    Then Update "3" leg details
      | End Type | Location_2    | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Chicago Bears | 1                | 12:30 PM               | 12:45 PM             |

    Then Click on "Add Leg Below" on "3" Leg
    Then Wait for "2" Seconds
    Then Update "4" leg details
      | Start Type | Location      | Due Out Date | Due Out Time |
      | Location   | Chicago Bears | 1            | 1:15 PM      |

    Then Update "4" leg details
      | End Type | Location_2           | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Joliet Jazz Supplies | 1                | 4:15 PM                | 4:30 PM              |

    Then Click on "Add Leg Below" on "4" Leg
    Then Wait for "2" Seconds
    Then Update "5" leg details
      | Start Type | Location             | Due Out Date | Due Out Time |
      | Location   | Joliet Jazz Supplies | 1            | 5:00 PM      |

    Then Update "5" leg details
      | End Type | Location_2           | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Joliet Jazz Supplies | 1                | 5:15 PM                | 5:30 PM              |

    # Step 46
    Then Verify Segment "1" "Consolidate Same Locations When Routing" is "True"
    Then Verify Segment "2" "Consolidate Same Locations When Routing" is "True"

    # Step 47
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID_2"

    # Step 48
    Then Click on "Dispatch" on "1" Segment
    #49 & Expected m
    And Verify Error Message contains as "is missing from body; length of body.stops must be greater or equal than 2 but got value []*server.CreateRouteStopWithOrdersRequestObjectRequestBody(nil) (len=0)"
    # Step 50
    Then Click on "Add Leg Above" on "1" Leg
    Then Wait for "2" Seconds

    # Step 51
    Then Update "1" leg details
      | Start Type | Location          | Due Out Date | Due Out Time |
      | Terminal   | Illinois Terminal | 1            | 1:30 AM      |

    Then Update "1" leg details
      | End Type | Location_2    | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Chicago Bears | 1                | 5:30 AM                | 5:30 AM              |

    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    # Step 52
    Then Click on "Dispatch" on "1" Segment
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Verify Message displaying with Text "Trip has been successfully created in the ELD."
    Then Close Toast message
    Then Wait for "3" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "2" Seconds
    # Step 53
    Then Click on "Dispatch" on "2" Segment
        Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Verify Message displaying with Text "Trip has been successfully created in the ELD."
    Then Wait for "3" Seconds
    Then Click on button with Title "Save & Close"

    # Step  54, 55, 56, 57
    Then Set key "TripPlanID" for Object "rtms__TripPlan__c" and Name "SysData=>Trip_Plan_ID_2"
    Then Get "rtms__ELD_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>TripPlanID" & "name" with value "Segment 1" and Store onto "ELDID_Segment1"
    Then Get "rtms__ELD_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>TripPlanID" & "name" with value "Segment 2" and Store onto "ELDID_Segment2"

    # Step  58 & 59
    Then Get Access token using "3672_GetAccessToken.json" and store in "Access_Token"

    # Step 60 & 61
    Then Send Get Request for Trip details for "SysData=>ELDID_Segment1" with Access Token as "Access_Token"
    Then Get Attribute "trip.stops[1].stop_sequence" store into "StopNum" from "Trip_Details"
    # Expected n
    Then Verify Assertion for "StopNum" contains "2"
    
