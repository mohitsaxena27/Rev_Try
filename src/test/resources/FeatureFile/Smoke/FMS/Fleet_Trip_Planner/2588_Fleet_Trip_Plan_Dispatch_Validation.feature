Feature: 2588 - Fleet Trip Planner LWC- Dispatch Validation

  Background: Pre- Test
    When Login into Salesforce
    #Step 1
    Then Search and Select "Timed Waypoint" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone        |
      | America/Phoenix |
    Then Click on button "Save"
    Then Wait for "2" Seconds
    Then Verify details for
      | Timezone |
      | America/Phoenix       |
     #Step 2
    Then Open "Drivers" from App Launcher
    Then Search and Select "QA Driver Two Five Eight Eight" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Verify "ELD ID" value is not empty
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID |ELD Enabled|ELD Exempt|
      |       |True       |False     |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "ELD ID" having value of ""
    Then Capture the current URL for "Driver_QA_Driver_Two_Five_Eight_Eight"

  @API @Regression @Smoke @WEB @SingleCurrency @TMS @Fleet_Trip_Planner @2588
   Scenario: 2588 - Fleet Trip Planner LWC- Dispatch Validation

    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    And Update details for "Catena" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    #Step2
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "3" Seconds
    Then Fleet Management Console - Wait for Page Load
    #Step 3
    Then Update details
    |Page|
    |Trip Planning|
    #Step 4
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds
    #Step 5
    Then Update "1" Segment details
    |Search                                |Driver|Driver Confirmation Status |
    |Tractor Two Five Eight Eight|QA Driver Two Five Eight Eight|Accepted                   |
   #Step 6 & 7
    Then Update "1" leg details
      |Start Type|Location|
      |Location   |Arizona Diamondbacks|
    Then Update "1" leg details
    | Due Out Date | Due Out Time | End Type          | Location_2         | Appointment Date |
    | 1            | 5:00 AM      | Waypoint Location | Timed Waypoint     | 2                |
    #Step 8
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    #Step 9 & 10 &11
    Then Click on button with Title "Dispatch"
    #Expected a
    Then Verify Error Message displaying as "This driver cannot be dispatched as they have no ELD ID: QA Driver Two Five Eight Eight"
    #Step 12
    Then Open New Tab with url "SysData=>Driver_QA_Driver_Two_Five_Eight_Eight"
    #Step 13
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID     |
      |ABC123     |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "ELD ID" having value of "ABC123"
    Then Close and Switch to Previous Window
    #Step 14 & 15 & 16 & 17
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
     #Step 18 & 19 & 20
    Then Click on button with Title "Dispatch"
    #Expected b
    Then Verify Error Message displaying as "Samsara: The driver record has an invalid value for the ELD ID field."
     #Step 21
    Then Open New Tab with url "SysData=>Driver_QA_Driver_Two_Five_Eight_Eight"
    #Step 22 & 23
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID       |ELD Brand|
      |51808327     |Samsara  |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "ELD ID" having value of "51808327"
    Then Close and Switch to Previous Window
      #Step 24 & 25 & 26 & 27
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
     #Step 28 & 29
    Then Click on button with Title "Dispatch"
    #Expected c
    Then Verify Message displaying as "Driver Dispatch was successful."
    Then Wait for "4" Seconds
    Then Verify "Dispatch" button is not longer displaying
    Then Verify "Redispatch" button is displaying
    Then Verify "Undispatch" button is displaying

      #Step 30
    Then Open New Tab with url "SysData=>Driver_QA_Driver_Two_Five_Eight_Eight"
    #Step 31
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID       |
      |ABC123     |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "ELD ID" having value of "ABC123"
    Then Close and Switch to Previous Window
    #Step 32 & 33 & 34 & 35
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
     #Step 36 & 37
    Then Click on button with Title "Redispatch"
    #Expected d
    Then Verify Error Message displaying as "Samsara: The driver record has an invalid value for the ELD ID field."
    #Step 38 & 39
    Then Click on button with Title "Undispatch"
    #Expected e
    Then Verify Message displaying as "The driver was undispatched successfully."

     #Step 40
    Then Open New Tab with url "SysData=>Driver_QA_Driver_Two_Five_Eight_Eight"
    #Step 41 & 42
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID       |ELD Brand |ELD Enabled|ELD Exempt|ELD Exempt Reason|
      |           |--None--  |False      |True      |2588 testing     |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "ELD ID" having value of ""
    Then Close and Switch to Previous Window

    #Step 43 & 44 & 45 & 46
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
     #Step 47
    Then Update "1" Segment details
      |Driver Confirmation Status |
      |Accepted                   |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
     #Step 48
    Then Click on button with Title "Dispatch"
    #Expected f
    Then Verify Message displaying as "Driver Dispatch was successful."
    Then Wait for "4" Seconds
    Then Verify "Dispatch" button is not longer displaying
    Then Verify "Redispatch" button is displaying
    Then Verify "Undispatch" button is displaying
     #Step 49
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Click on button with Title "Redispatch"
    #Expected g
    Then Verify Message displaying as "Driver Dispatch was successful."
     #Step 50
    Then Wait for "1" Seconds
    Then Click on button with Title "Undispatch"
    #Expected h & Step 51
    Then Verify Message displaying as "The driver was undispatched successfully."

    #Step 52
    Then Open New Tab with url "SysData=>Driver_QA_Driver_Two_Five_Eight_Eight"
    #Step 53 & 54
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID       |ELD Brand |ELD Enabled|ELD Exempt|
      |ABC123       |Samsara   |True        |False     |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "ELD ID" having value of "ABC123"
    #Step 55
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    And Update details for "Samsara" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Close and Switch to Previous Window
    #Step 56 & 57 & 58 & 59
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
     #Step 60
    Then Update "1" Segment details
      |Driver Confirmation Status |
      |Accepted                   |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
     #Step 61
    Then Click on button with Title "Dispatch"
    #Expected i
    Then Verify Message displaying as "Driver Dispatch was successful."
    Then Wait for "4" Seconds
    Then Verify "Dispatch" button is not longer displaying
    Then Verify "Redispatch" button is displaying
    Then Verify "Undispatch" button is displaying
     #Step 62
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Click on button with Title "Redispatch"
    #Expected j
    Then Verify Message displaying as "Driver Dispatch was successful."
     #Step 63
    Then Click on button with Title "Undispatch"
    #Expected k
    Then Verify Message displaying as "The driver was undispatched successfully."
    Then Wait for "2" Seconds
    Then Click on button "Close" on Trip Plan
