Feature:3671 - TMS Admin Configuration- Create ELD Trip On Dispatch- Disabled- Catena API- FMJ4

  @Regression @Smoke @WEB @FMS @API_Operation @Catena_API @SingleCurrency  @3671 @Debugging
  Scenario: 3671 - TMS Admin Configuration- Create ELD Trip On Dispatch- Disabled- Catena API- FMJ4

    When Login into Salesforce

    # Step 1
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
      | False                       |
    Then Select Fleet Management Job as "FleetManagementJob4"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 2
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

    # Step 3
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds
    Then Delete "FleetManagementJob4" job

   # Step 4
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bob Test" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Set Field Value "ELD ID" into "Driver_ELD_ID" Value
    Then Click on "Cancel" button
    Then Wait for "1" Seconds

  # Step 5
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "test-vehicle" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Information"
    Then Click on Edit icon on Label "ELD ID"
    Then Set Field Value "ELD ID" into "Fleet_Asset_ELD_ID" Value
    Then Click on "Cancel" button
    Then Wait for "1" Seconds

    # Step 6
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

     # Step 7 & 8
    Then Update "1" Segment details
      | Search       | Driver   |
      | test-vehicle | Bob Test |
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      | Load   |
      | A-1268 |
    Then Wait for "5" Seconds
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "1" Seconds
    Then Update "1" leg details
      | Start Type | Location             | Due Out Date | Due Out Time |
      | Location   | Joliet Jazz Supplies | 0            | 12:00 AM     |
    Then Update "1" leg details
      | End Type | Location_2     | Appointment Date | Appointment Start Time | Appointment End Time |
      | Location | Miami Dolphins | 1                | 12:15 AM               | 12:30 AM             |
    Then Click on button with Title "Add Trailer"
    Then Update "1" leg details
      | Search       | Action | Cargo Status |
      | Trailer 2034 | Pickup | Empty        |
    Then Click on button with Title "Done"
    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Verify Message displaying with Text "Save was successful."
    # Step 9
    And "Without Capture" and Close all the Toast messages from Bottom

    # Step 10
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

   # Step 11, 12 , 13 and 14
    Then Set key "Trip_Plan_SFID" for Object "rtms__TripPlan__c" and Name "SysData=>Trip_Plan_ID"
    Then Get "Id" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>Trip_Plan_SFID" and Store onto "Trip_Plan_Segment_ID"

   # Step 15
    Then Verify Text displaying as "Plan Trip" -
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Click on button with Title "Save"
    Then Verify Message displaying with Text "Save was successful."

    # Step 16
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify Message displaying with Text "Trip has been successfully created in the ELD."
    Then Get Access token using "3671_GetAccessToken.json" and store in "Access_Token"
    Then Get Fleet Code using "Access_Token" for Fleet ID "SysData=>Customer_Number"

   # Step 17 Expected Result a
    And Update and verify payload for "trip" with "TC3671_CreateTrip_RequestBody_Expected.json"
      | Customer_Number       | Trip_Plan_Segment_ID        | Driver_ELD_ID      | Fleet_Asset_ELD_ID                    | {CurrentDate} |Axle_Tsp_Id|
      | SysData=>Customer_Number | SysData=>Trip_Plan_Segment_ID | SysData=>Driver_ELD_ID | SysData=>Fleet_Asset_ELD_ID | 0              | SysData=>Samsara_AxleID |

   # Step 18 & Expected b
    Then Verify url displaying with "trip" as "https://api.axleapi.com/v1/trip"

    # Step 19 & Expected c
    Then Get Attribute "id" store into "id" from "trip" "Response"
    Then Verify "SysData=>id" value is not empty
    # Step 20, 21 & Expected d
    Then Verify Message "Trip has been successfully created in the ELD." displaying stored during enabled logging
    Then Close Toast message
    #Step 22 & 23 & Expected e & f
    Then Verify Title "Resend Trip to ELD" is displaying with background color "SteelBlue"
    Then Verify "Resend Trip to ELD" is displaying before "Add Driver"
      # Step 24, 25 & 26 & Expected g & 27
    Then Get "rtms__ELD_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>Trip_Plan_SFID" and Store onto "Trip_Plan_Segment_ELD_ID"
    Then Verify Assertion for "Trip_Plan_Segment_ELD_ID" contains "SysData=>id"

#         #########Remove block
#    Then Open "Fleet Management Console" from App Launcher
#    Then Wait for "6" Seconds
#    Then Fleet Management Console - Wait for Page Load
#    Then Update details
#      | Page          |
#      | Trip Planning |
#    Then Wait for "3" Seconds
#    Then Set "Trip_Plan_ID" with "Trip Plan-60"
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
#    Then Set "Driver_ELD_ID" with "5717550"
#    Then Set "Fleet_Asset_ELD_ID" with "4455972"
#    Then Set "Customer_Number" with "165964"
#    Then Set "id" with "8234019c-37bc-4039-a001-3ea57a5f85f6"
#    Then Set "Trip_Plan_Segment_ELD_ID" with "8234019c-37bc-4039-a001-3ea57a5f85f6"
#    Then Set "Samsara_AxleID" with "164551"
#    Then Set "Trip_Plan_Segment_ID" with "a30Ru0000089hXNIAY"



    # Step 28
    Then Click on button with Title "Resend Trip to ELD"
    #Step 29
    Then "Capture" and Close all the Toast messages from Bottom
   #Step 30 & Expected h
    And Update and verify payload for "Catena" with "TC3671_Expected_h_RequestBody.json"
      | Customer_Number       | Trip_Plan_Segment_ID        | Driver_ELD_ID      | Fleet_Asset_ELD_ID                    | {CurrentDate} |Axle_Tsp_Id              |dispatched_at|
      | SysData=>Customer_Number | SysData=>Trip_Plan_Segment_ID | SysData=>Driver_ELD_ID | SysData=>Fleet_Asset_ELD_ID  | 0              |SysData=>Samsara_AxleID |SysData=>dispatched_atData|

   # Step 31 & Expected i
    Then Verify url displaying with "Catena" as "https://api.axleapi.com/v1/trip/{SysData=>id}"

    # Step 32 & Expected j
    Then Get Attribute "id" store into "ReDispatch_id" from "Catena" "Response"
    Then Verify Assertion for "ReDispatch_id" contains "SysData=>id"

    # Step 33. 34 # Expected k
    Then Verify Message "Trip has been successfully updated in the ELD." displaying stored during enabled logging
    Then Close Toast message
    #Step 35
    Then Wait for "3" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    #Step 36
    And "Without Capture" and Close all the Toast messages from Bottom
    #Step 37
    Then Click on button with Title "Dispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."

   # Step 38
    And "Capture" and Close all the Toast messages from Bottom

   #Step 39 & Expected l
    And Update and verify payload for "Catena" with "TC3671_Expected_h_RequestBody.json"
      | Customer_Number       | Trip_Plan_Segment_ID        | Driver_ELD_ID      | Fleet_Asset_ELD_ID                    | {CurrentDate} |Axle_Tsp_Id              |dispatched_at|
      | SysData=>Customer_Number | SysData=>Trip_Plan_Segment_ID | SysData=>Driver_ELD_ID | SysData=>Fleet_Asset_ELD_ID  | 0              |SysData=>Samsara_AxleID |SysData=>dispatched_atData|

   # Step 40 & Expected m
    Then Verify url displaying with "Catena" as "https://api.axleapi.com/v1/trip/{SysData=>id}"

    # Step 41 & Expected n
    Then Get Attribute "id" store into "ReDispatch_id" from "Catena" "Response"
    Then Verify Assertion for "ReDispatch_id" contains "SysData=>id"
    # Step 42. 43 # Expected o
    Then Verify Message "Trip has been successfully updated in the ELD." displaying stored during enabled logging
    Then Close Toast message

     #Step 44
    Then Wait for "3" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    #Step 45
    And "Without Capture" and Close all the Toast messages from Bottom

    # Step 46
    Then Click on button with Title "Undispatch"
    Then Verify Message displaying with Text "The driver was undispatched successfully."
    # Step 47
    Then "Capture" and Close all the Toast messages from Bottom

    # Step 48 & Expected p
    Then Verify url displaying with "Catena" as "https://api.axleapi.com/v1/trip/{SysData=>id}"

    # Step 49 & Expected q
    And Update and verify Response payload for "Catena" with "TC3671_DispatchTrip_ResponseBody_Expected.json"
      | No Update Required |
      |  |

    # Step 50 # Expected r
    Then Verify Message "Trip has been successfully deleted in the ELD." displaying stored during enabled logging
    Then Close Toast message
    Then Click on button "Close" on Trip Plan
