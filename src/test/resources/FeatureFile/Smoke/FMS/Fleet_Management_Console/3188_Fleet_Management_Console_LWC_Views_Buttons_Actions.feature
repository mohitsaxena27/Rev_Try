Feature: 3188 - Fleet Management Console LWC - Views: Buttons/Actions

  @Regression @Smoke @WEB @FMS @SingleCurrency @Fleet_Management_Console @3188
  Scenario: 3188 - Fleet Management Console LWC - Views: Buttons/Actions

    When Login into Salesforce
    #Step 1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "4" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "2" Seconds
    Then Click on View Manager icon
    Then De-Select View Manager as "Division Two Tractors"
    Then Wait for "1" Seconds
    Then Scroll into Section "View - Fleet Asset"
    #Step 2
    Then Verify Title displaying as "Division One Tractors"
    Then Click on "Collapse Header" under "View - Fleet Asset" Section
    #Expected Result a
    Then Verify All Filter are not displaying for "View - Fleet Asset"
    Then Verify title "Edit" under "View - Fleet Asset" Section
    Then Verify title "Expand Header" under "View - Fleet Asset" Section
    Then Verify title "Collapse Grid" under "View - Fleet Asset" Section
    Then Verify title "Display Text Headers" under "View - Fleet Asset" Section
    Then Verify title "Grid Column Sort Order" under "View - Fleet Asset" Section
    Then Verify title "Grid Column Selection" under "View - Fleet Asset" Section
    Then Verify title "Reorder" under "View - Fleet Asset" Section
    Then Verify title "Remove" under "View - Fleet Asset" Section
    Then Verify title "Clone" under "View - Fleet Asset" Section
    Then Verify title "Refresh" under "View - Fleet Asset" Section
    Then Verify details for all Enabled fields
    |View - Fleet Asset|
    |Division One Tractors |

    #Step 3
    Then Click on "Collapse Grid" under "View - Fleet Asset" Section
    #Expected Result b
    Then Verify data grid not displaying for "View - Fleet Asset"

    #Step 4
    Then Click on "Expand Header" under "View - Fleet Asset" Section
    #Expected Result c
    Then Verify All Filter are displaying for "View - Fleet Asset"

    #Step 5
    Then Click on "Expand Grid" under "View - Fleet Asset" Section
    #Expected Result d
    Then Verify data grid displaying for "View - Fleet Asset"

    #Step 6
    Then Click on "Display Text Headers" under "View - Fleet Asset" Section
    Then Wait for "4" Seconds
    #Expected Result e
    Then Verify "View - Fleet Asset" Table having Records
         |Related Records|Location History|Trip Plans|Trip Plan Count|Trip Events and Notification Logs|
         |Related Records|Location History|Trip Plans|Trip Plan Count|Trip Events and Notification Logs|
    #Step 7
    Then Click on "Display Image Headers" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    #Expected Result f
    Then Verify "View - Fleet Asset" Table not having Records
      |Related Records|Location History|Trip Plans|Trip Plan Count|Trip Events and Notification Logs|
      |Related Records|Location History|Trip Plans|Trip Plan Count|Trip Events and Notification Logs|

    #Step 8
    Then Click on Address "Search" under "View - Fleet Asset" Section
    Then Wait for "3" Seconds
    Then Enter Address Search Text as "Dharmapuri, Forest Colony, Tajganj, Agra, Uttar Pradesh 282001, India"
    Then Wait for "2" Seconds
    Then Click on button with Title "Forest Colony, Tajganj, Agra, Uttar Pradesh 282001, India"
    Then Wait for "2" Seconds
    Then Click button with Text "Save" on Modal

    #Step 9
    Then Scroll down with "10" Times
    Then Update "View - Fleet Asset" details
         |Radius|Units|
         |10    |Miles|
    Then Click on "Refresh" under "View - Fleet Asset" Section
    Then Wait for "10" Seconds
    #Expected Result g
    Then Verify "View - Fleet Asset" Table is empty

    #Step 10
    Then Clear Address search for "View - Fleet Asset"
     #Expected Result h
    Then Verify "View - Fleet Asset" details
         |Search Address|Radius|Units|
         |              |      |     |

    #Step 11
    Then Click on View Manager icon
    Then Select View Manager as "Revenova Loads"
    Then Wait for "2" Seconds
    Then Click on "Reorder" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    #Expected Result i
    Then Verify Text "Reorder" displaying on Modal
    Then Verify Text "Division One Tractors" displaying on Modal

    #Step 12
    Then Drag the row for "Division One Tractors" beneath the row for "Revenova Loads"
    Then Click button with Text "Save" on Modal

    #Expected j
    Then Scroll into Section "View - Fleet Load"
    Then Verify "View - Fleet Asset" is displaying below "View - Fleet Load"

     #Step 13
    Then Click on "Remove" under "View - Fleet Load" Section
    Then Wait for "4" Seconds
     #Expected k
    Then Verify Text not displaying as "View - Fleet Load"

    #Step 14
    Then Click on View Manager icon
    Then Wait for "2" Seconds
    #Expected l
    Then View Manager : Verify "Revenova Loads" is "Not Selected"
    Then Wait for "1" Seconds

    #Step 15
    Then Scroll into Section "View - Fleet Asset"
    Then Wait for "2" Seconds
    Then Click on "Clone" under "View - Fleet Asset" Section
    Then Wait for "4" Seconds
    Then Click on View Manager icon
    Then De-Select View Manager as "Division One Tractors"
    Then Wait for "1" Seconds
    Then Scroll into Section "View - Fleet Asset"

#    #Expected Result m
    Then Verify details for all Enabled fields
         |View - Fleet Asset|
         |Division One Tractors - Cloned|
    Then Wait for "2" Seconds

    #Step 16
    Then Update "View - Fleet Asset" details
      |Team|
      |Yes |
    #Step 17
    Then Click on "Grid Column Selection" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Add "Asset Ownership Type" into column selection
    #Step 18
    Then Click on button with Title "Close"
    #Step 19
    Then Update "View - Fleet Asset" details
         |Include Header Criteria|Include Grid Filters|
         |True                   |True|
    Then Wait for "1" Seconds
    Then Click on "Save" Text under "View - Fleet Asset" Section
    Then Wait for "2" Seconds

    #Step 20
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "3" Seconds
    #Step 21
    Then Scroll into Section "View - Fleet Asset"
    #Expected n
    Then Verify "View - Fleet Asset" details
      |Team|
      |Yes  |
    Then Verify "View - Fleet Asset" Table having Records
      |Asset Ownership Type|
      |Asset Ownership Type|

