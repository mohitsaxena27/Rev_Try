Feature: 2386 - Fleet Management Console LWC - View Manager LWC - Format/Functionality

  @Regression @Smoke @WEB @FMS @SingleCurrency @Fleet_Management_Console @2386
  Scenario: 2386 - Fleet Management Console LWC - View Manager LWC - Format/Functionality

    When Login into Salesforce
    #Step 1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "2" Seconds
    #Step 2
    Then Click on View Manager icon
    #Expected Result a
    Then Verify Text displaying as "View Manager"
    Then Verify Text displaying as "View Manager" with "font-weight" as "bold"
    Then Verify details for all Enabled fields
         |View Type|
         |         |
    Then Verify "SteelBlue" Color with "White" Text of "New" Button is "Enabled"
    Then View Manager - Verify Table Header Icon & Name

    #Step 3 & Expected b
    Then De-Select View Manager as "Revenova Loads"
    Then Wait for "2" Seconds
    Then Verify only selected views from View Manager are rendered in Fleet Management Console

    #Step 4
    Then Select View Manager as "Revenova Loads"
    Then Wait for "10" Seconds
    #EXpected Result c
    Then Scroll into Section "View - Fleet Load"
    Then Verify "Revenova Loads" is displaying at the bottom, after all of the other selected views

    #Step 5
    Then View Manager - Deselect All Views
    Then Wait for "5" Seconds
    #Expected Result d
     Then Confirm all views in View Manager are unselected

    #Step 6
    Then View Manager - Select All Views
     #Step 7 & #Expected e
    Then Wait for "5" Seconds
    Then Confirm first 10 selected views render in order and 11th view does not render

    #Step 8 & Expected f
    Then Verify "Revenova Trip Plans" checkbox is disabled and unable to select

    #Step 9
     Then De-Select View Manager as "Division One Drivers (Seated)"

    #Step 10
    Then View Manager - Click on "Edit" for "Division One Drivers"

    #Step 11
    Then Update details
         |View Name         |Shared With|
         |Division 1 Drivers|User Two Group|
    Then De-Select "Fleet Management" from Multi-Select Field "Default For"
    Then Wait for "1" Seconds

    #Step 12
    Then Click button with Text "Save" on Modal
    Then Verify Message displaying as "Save was successful."

    #Expected g
    Then Verify View Manager Details for "Division 1 Drivers"
         |View Type    |Default For|Shared With|Owner|
         |Fleet Driver|Trip Planning|User Two Group|User User|

    #Step 13
    Then Scroll into Section "View - Fleet Driver"
    Then Click on "Grid Column Selection" under "View - Fleet Driver" Section
    Then Wait for "2" Seconds
    Then Add "Driver Name" into column selection
    #Step 14
    Then Click on button with Title "Close"
    #Step 15
    Then Update "View - Fleet Driver" details
      |Include Grid Filters|
      |True|
    Then Wait for "1" Seconds
    Then Click on "Save" Text under "View - Fleet Driver" Section
    Then Wait for "2" Seconds

    #Step 16
    Then View Manager - Click on "Clone" for "Division 1 Drivers"
    #Expected h
    Then Verify Message displaying as "Save was successful."
    Then Verify "Division 1 Drivers - Cloned" checkbox is not selected
    Then Verify View Manager Details for "Division 1 Drivers - Cloned"
      |View Type    |Default For|Shared With|Owner|
      |Fleet Driver|Trip Planning|User Two Group|User User|

    #Step 17
    Then De-Select View Manager as "Division 1 Drivers"
    Then De-Select View Manager as "Division Two Drivers"
    Then Select View Manager as "Division 1 Drivers - Cloned"
    Then Wait for "4" Seconds
     #Step 18 #Expected i
    Then Scroll into Section "View - Fleet Driver"
    Then Verify "View - Fleet Driver" Table having Icon & Records
#      |Fleet Driver|Related Records|Location History|Trip Plans|Trip Plan Count|Trip Events and Notification Logs|Company/Division|Domicile|ELD ID|Current Location|Engine State|Heading (Degrees)|Speed (mph)|Seated Driver|Final Planned Date|Final Planned Location|Driver Name|
#      |Fleet Driver|Related Records|Location History|Trip Plans|Trip Plan Count|Trip Events and Notification Logs|Company/Division|Domicile|ELD ID|Current Location|Engine State|Heading (Degrees)|Speed (mph)|Seated Driver|Final Planned Date|Final Planned Location|Driver Name|
      |Fleet Driver|Related Records|Location History|Trip Plans|Trip Plan Count|Trip Events and Notification Logs|Company/Division|Domicile|ELD ID|Final Planned Date|Final Planned Location|Driver Name|
      |Fleet Driver|Related Records|Location History|Trip Plans|Trip Plan Count|Trip Events and Notification Logs|Company/Division|Domicile|ELD ID|Final Planned Date|Final Planned Location|Driver Name|

    #Step 19
    Then Scroll into Section "View Manager"
    Then Delete "Division 1 Drivers - Cloned" View Manager
    #Expected Result j
    Then Verify Message displaying as "Delete was successful"
    Then Wait for "2" Seconds
    Then Verify Text not displaying as "Division 1 Drivers - Cloned"
    Then Select View Manager as "Division 1 Drivers"
    Then Wait for "5" Seconds

    #Step 20
    Then Scroll into Section "View - Fleet Driver"
    Then Click on "Grid Column Selection" under "View - Fleet Driver" Section
    Then Wait for "2" Seconds
    Then Add "Driver Manager" into column selection
    #Step 21
    Then Click on button with Title "Close"

     #Step 22
    Then Scroll into Section "View Manager"
    Then View Manager - Click on "Clone" for "Division 1 Drivers"
    Then Verify Message displaying as "Save was successful."

    #Step 23
    Then De-Select View Manager as "Division 1 Drivers"
    Then De-Select View Manager as "Division Two Drivers"
    Then Select View Manager as "Division 1 Drivers - Cloned"
    Then Wait for "4" Seconds

     #Step 24 #Expected k
    Then Scroll into Section "View - Fleet Driver"
    Then Verify "View - Fleet Asset" Table not having Records
         |Driver Manager|
         |Driver Manager|
    Then Scroll into Section "View Manager"
    Then Select View Manager as "Division 1 Drivers"

    #Step 25
    Then Update details
      | Page                 |
      | Trip Planning |
    Then Wait for "4" Seconds
    #Step 26 #Expected Result l
    Then Verify View Type dropdown having options
      |                 |
      | Fleet Driver |
      | Fleet Asset |
      | Trip Plan |
      | Fleet Load |
      | Freight Plan Load |
      | Fleet Map |
      | Fleet Calendar |

     #Step 27
    Then Update details
      | Page                 |
      | Appointment Setting |
    Then Wait for "4" Seconds
    #Step 28 #Expected Result m
    Then Verify View Type dropdown having options
      | Appointments |

     #Step 29
    Then Update details
      | Page                 |
      | Equipment Management |
    Then Wait for "4" Seconds
    #Step 30 #Expected Result n
    Then Verify View Type dropdown having options
      |                 |
      | Fleet Equipment |
      | Fleet Map       |
      |Fleet Calendar   |

     #Step 31
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "4" Seconds
    #Step 32 #Expected Result o
    Then Verify View Type dropdown having options
      |              |
      | Fleet Driver |
      | Fleet Asset |
      | Trip Plan |
      | Fleet Load |
      | Freight Plan Load |
      | Fleet Map |
      | Fleet Calendar |

