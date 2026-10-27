Feature:2789 - Samsara API- Delete Route Operation

  @Regression @Smoke @WEB @SingleCurrency @FMS @API_Operation @Samsara_API @2789 @Debugging
  Scenario: 2789 - Samsara API- Delete Route Operation

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

    #Step 2
    Then Open "Drivers" from App Launcher
    #Step 3
    Then Search and Select "Bruce Fleet Carrier Two 1" from List
    Then Wait for "3" Seconds
    #Step 4
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID  | ELD Enabled |
      | 6855466 | True        |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "ELD ID" having value of "6855466"
     #Step5
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load
    #Step 6
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 7
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 8
    Then Update "1" Segment details
       | Driver                    |Search | Driver Confirmation Status |
       | Bruce Fleet Carrier Two 1 |Tractor 1003| Accepted                   |
    Then Wait for "3" Seconds
   #Step 9
    Then Update "1" leg details
      | Start Type | Location             | Due Out Date | Due Out Time | End Type        | Location_2                 | Appointment Date |
      | Location   | Arizona Diamondbacks | 1            | 5:00 AM      | Border Crossing | Port Huron Border Crossing | 2                |
    #Step 10
    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying with Text "Save was successful."
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    #Step 11
    Then Click on button with Title "Dispatch"
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify Success Message displaying as "Trip has been successfully created in the ELD."
    Then Get Attribute "data.id" from "routes" "Response"
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds

    #Step 12
    Then Click on button with Title "Undispatch"
    Then Verify Message displaying with Text "The driver was undispatched successfully."
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify Success Message displaying as "Trip has been successfully deleted in the ELD."
    #Expected Result a
    Then Verify url displaying with "data.id"

    #Step 13
    Then Click on button "Close" on Trip Plan
    #Step 14
    Then Wait for "20" Seconds
    Then Set key "TripPlanID" for Object "rtms__TripPlan__c" and Name "SysData=>Trip_Plan_ID"
    Then Get "rtms__ELD_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Trip_Plan__c" with value "SysData=>TripPlanID" and Store onto "ELDID_Segment1"

    #Step 15 and Expected Result b
    Then Wait for "2" Seconds
    Then Verify "ELDID_Segment1" is null or Empty

