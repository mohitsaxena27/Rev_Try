Feature: 2653 - Fleet Equipment Management- Equipment Pool- Format/Functionality

  @Regression @Smoke @WEB @FMS @SingleCurrency @Fleet_Equipment @Fleet_Equipment_Management @2653
  Scenario: 2653 - Fleet Equipment Management- Equipment Pool- Format/Functionality

    When Login into Salesforce
    #Step1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Illinois Terminal" from List
    Then Wait for "3" Seconds
    Then Click on More next to "Customer Operations"
    Then Go to "Equipment Pool" Tab
    #Expected a
    Then Verify Label Checkbox
      |Is Drop Location|
      |true            |
    Then Move hover on Tooltip for "Is Drop Location"
    Then Verify Text displaying as "Equipment Pool location." -
    Then Verify Text displaying as "Equipment Pools"
    Then Verify Header
    |Name|Equipment Type|Lot Status|Minimum Allowed|Maximum Allowed|Current Pool Count|
    |Name|Equipment Type|Lot Status|Minimum Allowed|Maximum Allowed|Current Pool Count|

    #Step 2
    Then Click on "New" for "Equipment Pools" Records
    #Expected b
    Then Verify Text displaying as "New Equipment Pool"
    Then Verify Text displaying as "Details"
    Then Verify details for all Enabled fields
      |Transportation Profile |Name|Equipment Type|Type     |Aging Threshold (Days)|Minimum Allowed|Maximum Allowed|Available Empties|Available Loaded|
      |Illinois Terminal      |    |--None--      |--None-- |                      |               |               |                 |                |
    Then Verify Static Field "Current Pool Count" value as "0"
    Then Verify Static Field "Lot Status" value as "In Range"
    Then Verify Text displaying as "Created By" 
    Then Verify Text displaying as "Last Modified By" 

    #Step 3
    Then Scroll Up with "5" Times
    Then Clear "Transportation Profile" value from comboBox
    #Expected c
    Then Verify "White" Color with "SteelBlue" Text of "Cancel" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "Save & New" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button is "Enabled"
    Then Update details
    |Transportation Profile|Name         |Equipment Type|Type   |Aging Threshold (Days)|Minimum Allowed|Maximum Allowed|Available Empties|Available Loaded|
    |Illinois Terminal     |Test Pool One|Chassis       |Secured|30             |5              |100            |26               |53              |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    #Step 4
    Then Click on Edit icon on Label "Is Drop Location"
    Then Update details
    |Is Drop Location|
    |False            |
   Then Click on button with Title "Save"
    Then Wait for "6" Seconds
    Then Verify Label Checkbox
      |Is Drop Location|
      |false            |
    #Step 5
   Then Click on "Test Pool One" with Text
    Then Wait for "2" Seconds
    #Expected d
    Then Verify Static Field "Transportation Profile" value as "Illinois Terminal"
    Then Verify Details
     |Name         |Equipment Type|Type   |Aging Threshold (Days)|Minimum Allowed|Maximum Allowed|Available Empties|Available Loaded|
      |Test Pool One|Chassis       |Secured|30             |5              |100            |26               |53              |
    Then Wait for "2" Seconds
    #Step 6
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "3" Seconds
    Then Verify button is present with "Driver Assignment"
    Then Update details
      | Page                 |
      | Equipment Management |
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Fleet Equipment"
    Then De-Select "Equipment Type" as "Trailer" on FMS
    Then Select "Equipment Type" as "Chassis" on FMS
    Then Click on "Refresh" under "View - Fleet Equipment" Section
    Then Scroll into Section "View - Fleet Asset"

    #Expected e
    Then No "Fleet Asset"records are rendered in the section

    #Step 7
    Then Wait for "1" Seconds
    Then Open "Transportation Profiles" from App Launcher
    Then Select Records "Illinois Terminal" from List
    Then Click on More next to "Customer Operations"
    Then Go to "Equipment Pool" Tab
    Then Click on Edit icon on Label "Is Drop Location"
    Then Update details
      | Is Drop Location |
      | True            |
    Then Click on button with Title "Save"
    Then Wait for "5" Seconds
    #Step 8
    Then Refresh current Page
   #Step 9
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "3" Seconds
    Then Update details
      | Page                 |
      | Equipment Management |
    Then Wait for "2" Seconds
    Then Scroll into Section "View - Fleet Equipment"
    Then De-Select "Equipment Type" as "Trailer" on FMS
    Then Select "Equipment Type" as "Chassis" on FMS
    #Step10
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    #Step 11
    Then Click on "Refresh" under "View - Fleet Equipment" Section
    #Expected f
    Then Verify Table data
      | Equipment Pool | Type    | Equipment Type | Lot Status | Available Empties | Available Loaded | Minimum Allowed | Maximum Allowed | Current Pool Count | Aging Threshold (Days) |
      | Test Pool One  | Secured | Chassis        | In Range   | 26                | 53               | 5               | 100             | 79                 | 30                     |

