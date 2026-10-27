Feature: 2527 - Fleet Trip Planner LWC- Manifest Builder Button Visibility

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @Border_Connect @FMS @Trip_Plan @2527
  Scenario: 2527 - Fleet Trip Planner LWC- Manifest Builder Button Visibility

    When Login into Salesforce
    #Pre-Requisite
    Then Search and Select "Canada Border Services Agency" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone        |
      | America/Chicago |
    Then Click on button "Save"
    Then Wait for "2" Seconds
    Then Verify details for
      | Timezone              |
      | America/Chicago       |

   #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Capture the current URL for "TMS_Admin"
    Then Go to "Global Services" Tab
    Then Search text "Border Connect" in the "Search Credentials..." search box
    Then Select the "Border Connect" record from the lookup field results
    Then Update details
      | Enabled |
      | false    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds

    #Step 2
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds

    Then Fleet Management Console - Wait for Page Load
    #Step 3
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    #Step 4
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    #Step 5
    Then Update "1" Segment details
      | Search   | Driver                    |
      | Tractor 1001 | Dave Fleet Carrier One 1  |
    Then Wait for "1" Seconds

    #Step 6
  Then Update "1" leg details
  | Start Type | Location       |
  | Terminal   | Illinois Terminal |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 1            | 5:00 AM      |
    Then Update "1" leg details
      | End Type | Location_2        |Appointment Date |
      | Location | Minnesota Vikings |2                |

  #Step 7
    Then Click on "Add Leg Below" on "1" Leg
    Then Wait for "1" Seconds
    #Step 8
    Then Update "2" leg details
      | Due Out Date | Due Out Time |
      | 2            | 8:00 AM      |
    Then Update "2" leg details
      | End Type        | Location_2                    |Appointment Date |
      | Border Crossing | Canada Border Services Agency |3                |
    #Step 9
    Then Click on "Add Leg Below" on "2" Leg
    Then Wait for "1" Seconds
    #Step 10
    Then Update "3" leg details
      | Due Out Date | Due Out Time |
      | 3            | 9:00 AM      |
    Then Update "3" leg details
      | End Type        | Location_2  |Appointment Date |
      | Location   | Manitoba Movers |4                |
  #Step 11
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
 #Expected Result a
   Then Verify "Manifest Builder" option not displaying on "2" Leg
    Then Wait for "1" Seconds
    Then Click on button "Close" on Trip Plan

    #Step 12
    Then Navigate to stored URL for "TMS_Admin"
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Border Connect" in the "Search Credentials..." search box
    Then Select the "Border Connect" record from the lookup field results
    Then Update details
      | Enabled |
      | true    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds

   #Step 13
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load
    #Step 14
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    #Step 15
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    #Step 16
    Then Update "1" Segment details
      | Search  | Driver                    |
      | Tractor 1001 | Dave Fleet Carrier One 1  |
    Then Wait for "1" Seconds

    #Step 17
    Then Update "1" leg details
      | Start Type | Location       |
      | Terminal   | Illinois Terminal |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 1            | 5:00 AM      |
    Then Update "1" leg details
      | End Type | Location_2        |Appointment Date |
      | Location | Minnesota Vikings |2                |

  #Step 18
    Then Click on "Add Leg Below" on "1" Leg
    Then Wait for "1" Seconds
    #Step 19
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 2            | 8:00 AM      |
    Then Update "2" leg details
      | End Type        | Location_2                    |Appointment Date |
      | Border Crossing | Canada Border Services Agency |3                |
  #Step 20
    Then Click on "Add Leg Below" on "2" Leg
    Then Wait for "1" Seconds
    #Step 21
    Then Update "3" leg details
      | Due Out Date | Due Out Time |
      | 3            | 9:00 AM      |
    Then Update "3" leg details
      | End Type        | Location_2      |Appointment Date |
      | Location        | Manitoba Movers |4                |
  #Step 22
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
 #Expected Result b
    Then Verify "Manifest Builder" option not displaying on "1" Leg
    Then Verify "Manifest Builder" option is displaying on "2" Leg
    Then Verify "Manifest Builder" option not displaying on "3" Leg
    Then Wait for "1" Seconds
    Then Click on button "Close" on Trip Plan


















