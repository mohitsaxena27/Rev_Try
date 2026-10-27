Feature:2787 - Samsara API- Upsert Route Operation

  @Regression @Smoke @WEB @FMS @API_Operation @SingleCurrency @Samsara_API @2787 @Debugging
  Scenario: 2787 - Samsara API- Upsert Route Operation

    When Login into Salesforce
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

#    Step 2
#    Then Search "Accounts" as "Kansas City Chiefs" -
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Kansas City Chiefs" from List
    Then Select Records "Kansas City Chiefs" from List
    Then Go to "Related" Tab
    Then Click on "New" for "Account ELD" Records
    Then Update details
    |ELD ID|
    |256496082 |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Account ELD"
    #Step 3
    Then Open "Drivers" from App Launcher
    #Step 4
    Then Search and Select "Bruce Fleet Carrier Two 1" from List
    Then Wait for "3" Seconds
    #Step 5
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID |ELD Enabled|ELD Exempt|ELD Exempt Reason|
      |6855466 |True      |True      |NA               |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "ELD ID" having value of "6855466"
    # Step6
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load
    #Step 7
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    #Step 8
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Search   | Driver                    | Driver Confirmation Status |
      | Tractor 1003 | Bruce Fleet Carrier Two 1 | Accepted                   |
    Then Wait for "1" Seconds
    Then Scroll into Last of Webpage
    #Step 8b
    Then Update "1" leg details
      | Start Type | Location | Country       | Street             | City    | State/Province | Postal Code |
      | Address    | NA       | United States | 401 E Jefferson St | Phoenix | Arizona        | 85004       |
    Then Click on "Save" on "1" Leg
    Then Update "1" leg details
      | Due Out Date | Due Out Time | End Type | Location_2         | Appointment Date |
      | 1            | 5:00 AM      | Location | Kansas City Chiefs | 2                |

    #Step 8c
    Then Click on "Add Leg Below" on "1" Leg
    Then Wait for "3" Seconds
    Then Update "2" leg details
      | Due Out Date | Due Out Time | End Type | Location_2        | Appointment Date |
      | 3            | 5:00 AM      | Terminal | Missouri Terminal | 7                |
    Then Wait for "1" Seconds
    #Step 8d
    Then Click on button with Title "Save"
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

     #Step 8e
    Then Click on button with Title "Dispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify Success Message displaying as "Trip has been successfully created in the ELD."
    Then Get Attribute "data.id" from "routes" "Response"
    Then Get Attribute "data.stops[0].id" from "routes" "Response"
    Then Get Attribute "data.stops[1].id" from "routes" "Response"
    Then Get Attribute "data.stops[2].id" from "routes" "Response"
    #Step 9
    #Expected a
    And TimeZone Specific - Update and verify payload for "routes" with "TC2787_RequestBody_Expected.json"
      | Trip_Plan_ID  | {CurrentDate+1} | {CurrentDate+2} | {CurrentDate+7} |
      | Transactional | 1               | 2               | 7               |
    #Expected b
    And TimeZone Specific - Update and verify Response payload for "routes" with "TC2787_Response_Body_Expected.json"
      | Trip_Plan_ID  | {CurrentDate+1} | {CurrentDate+2} | {CurrentDate+7} | data.id       | data.stops[0].id | data.stops[1].id | data.stops[2].id |
      | Transactional | 1               | 2               | 7               | Transactional | Transactional    | Transactional    | Transactional    |

    #Step 10
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date | Arrival Time | Departure Date | Departure Time |
      | 2            | 4:00 PM      | 3              | 5:00 AM        |

    #Step 11
    Then Click on button with Title "Save"
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "5" Seconds
    Then Click on button with Title "Redispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify Success Message displaying as "Trip has been successfully updated in the ELD."
    #Expected c
    And TimeZone Specific - Update and verify payload for "SysData>data.id" with "TC2787_2_RequestBody_Expected.json"
      | Trip_Plan_ID  | {CurrentDate+1} | {CurrentDate+2} | {CurrentDate+7} |
      | Transactional | 1               | 2               | 7               |

    #Step 12
    Then Click on button "Close" on Trip Plan
    #Step 13
    Then Open "Trip Plan Segments" from App Launcher
    Then Recently Viewed to All
    Then List View Control
      | ELD Trip Id | Trip Plan |
      | ELD Trip Id | Trip Plan |

    #Step 14 and Expected Result d
    Then Wait for "2" Seconds
    Then Verify Trip Plan Segment Records With Trip Plan "Trip_Plan_ID" and ELD Trip Id as "SysData>data.id"
    #Step 15
    Then Open "Drivers" from App Launcher
    #Step 16
    Then Select Records "Bruce Fleet Carrier Two 1" from List
    Then Wait for "3" Seconds
    #Step 17
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID |ELD Enabled|ELD Exempt |
      |       |False      |False      |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "ELD ID" having value of ""
   #Step18
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    #Step 19
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    #Step 20
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    #Step 21
    Then Update details
        |Trip Plan Start Date|
        |Tomorrow            |
    Then Wait for "1" Seconds
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 22
    Then Click on button with Title "Redispatch"
    #expected e
    Then Verify Message displaying as "Driver Dispatch was successful."
    Then Verify no Request & Response  Rendered
    Then Click on button "Close" on Trip Plan
