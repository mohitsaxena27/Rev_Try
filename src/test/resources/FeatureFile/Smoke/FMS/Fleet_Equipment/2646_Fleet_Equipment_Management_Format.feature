Feature: 2646 - Fleet Equipment Management LWC- Format

  @Regression @Smoke @WEB @FMS @SingleCurrency @Fleet_Equipment @Fleet_Equipment_Management @2646
  Scenario: 2646 - Fleet Equipment Management LWC- Format

    When Login into Salesforce
    #Step1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "4" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page                 |
      | Equipment Management |
    Then Wait for "2" Seconds
    Then Click on button with Title "View Manager"
    Then Wait for "1" Seconds
    Then Update details
      | Select 3 items |
      | False      |
    Then Select View Manager as "Equipment Pool One"
    Then Scroll into Section "View - Fleet Equipment"
    #Expected a
    Then Verify Map is Rendering
    #Expected b
    Then Verify Text displaying as "Filters"
    Then Verify details for all Disabled or Readonly fields
      | Power Unit | Load | Current Location | Distance from Origin | Search Radius | Units | Search Origin | Search Destination |
      |            |      |                  |                      | 10            | Miles | false         | false              |
    Then Verify details for all Enabled fields
      | Origin | Destination |
      |        |             |

    Then Verify "Decrease" button is displaying and "disabled"
    Then Verify "Increase" button is displaying and "disabled"
    #Expected Result c
    Then Verify Header
      | Radio_Button           | Equipment Pool | Type | Equipment Type | Lot Status | Available Empties | Available Loaded | Minimum Allowed | Maximum Allowed | Current Pool Count | Aging Threshold (Days) |
      | Choose a Row to Select | Equipment Pool | Type | Equipment Type | Lot Status | Available Empties | Available Loaded | Minimum Allowed | Maximum Allowed | Current Pool Count | Aging Threshold (Days) |

    Then Select Records for "Illinois Terminal" on Fleet Equipment Page
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Fleet Asset"
    Then Verify Header
      | Empty checkbox | Fleet Asset | Related Records | Location History | Trip Plans | Trip Plan Count | Trip Events and Notification Logs | Type | Domicile | Current Location | Drop Location | Drop Location Datetime |
      | Choose a Row   | Fleet Asset | Related Records | Location History | Trip Plans | Trip Plan Count |Trip Events and Notification Logs | Type | Domicile | Current Location | Drop Location | Drop Location Datetime |
    #Step 2
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds
    Then Scroll into Last of Webpage
    Then Update "1" leg details
      | Start Type | Location          | End Type | Location_2        |
      | Terminal   | Illinois Terminal | Terminal | Illinois Terminal |
    #Step 3
    Then Click on "Find Equipment" on "1" Leg
    Then Wait for "6" Seconds

    #Step 4
    Then Verify Text displaying as "Find Equipment" -
    #Expected g
    Then Verify details for all Enabled fields
      | View - Fleet Equipment |
      | Equipment Pool One     |
    Then Verify Map is Rendering
     #Expected f
    Then Verify Text displaying as "Filters"
    Then Verify details for all Disabled or Readonly fields
      | Power Unit | Load | Current Location | Distance from Origin |
      |            |      |                  |                      |
    Then Verify details for all Enabled fields on Fleet Management Modal
      | Origin            | Destination       | Search Radius | Units | Search Origin | Search Destination |
      | Illinois Terminal | Illinois Terminal | 10            | Miles | true          | true               |

    Then Verify "Decrease" button is displaying and "enabled"
    Then Verify "Increase" button is displaying and "enabled"
    #Expected Result g
    Then Verify Header
      | Radio_Button           | Equipment Pool | Type | Equipment Type | Lot Status | Available Empties | Available Loaded | Minimum Allowed | Maximum Allowed | Current Pool Count | Aging Threshold (Days) |
      | Choose a Row to Select | Equipment Pool | Type | Equipment Type | Lot Status | Available Empties | Available Loaded | Minimum Allowed | Maximum Allowed | Current Pool Count | Aging Threshold (Days) |

    #Expected Result h
    Then Select Records for "Illinois Terminal" on Fleet Equipment Page
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Fleet Asset"
    Then Verify Header
      | Empty checkbox | Fleet Asset | Related Records | Location History | Trip Plans | Trip Plan Count | Trip Events and Notification Logs | Type | Domicile | Current Location | Drop Location | Drop Location Datetime |
      | Choose a Row   | Fleet Asset | Related Records | Location History | Trip Plans | Trip Plan Count | Trip Events and Notification Logs| Type | Domicile | Current Location | Drop Location | Drop Location Datetime |
