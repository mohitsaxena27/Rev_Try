Feature: 2652 - Trip Plan Status- Multi Segment Pending

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trip_Plan @2652
  Scenario: 2652 - Trip Plan Status- Multi Segment Pending

    When Login into Salesforce
   #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode      | Lane     | Category | Rate Type | Status   | Effective Date | Fleet Loads Only |
      | Boston Beans           | Truckload | US to US | Carrier  | Freight   | Accepted | 0              | True             |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service               | Rate Method  | Rate |
      | Fleet Carrier One - Truckload | Fixed Amount | 1200 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_Name"
    Then Capture the current URL for "Rate_Entry_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      | Fleet |
      | True  |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | 0830             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 7             | NA                       | 1530             | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    #Step 3
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

    #Step 4
    Then Open "Drivers" from App Launcher
    Then Search and Select "Dave Fleet Carrier One 11" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD Exempt"
    Then Update details
      | ELD Exempt | ELD Exempt Reason    |
      | True       | Test ELD Exempt 2652 |
    Then Click on "Save" with Text

   #Step5
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds
    Then Capture the current URL for "FMC_Console"

  #Step 6
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

  #Step 7
    Then Click on button with Title "Add Segment Below"
    Then Wait for "2" Seconds

  #Step 8
    Then Click on "Add Leg Below" on "3" Leg
    Then Wait for "2" Seconds

  #Step8.b
    Then Update "1" Segment details
      | Search   | Driver                    |
      | Tractor 1011 | Dave Fleet Carrier One 11 |

    Then Update "1" leg details
      | Start Type | Location       |
      | Location   | Boston Red Sox |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 0            | 6:30 AM      |

    Then Update "2" leg details
      | End Type | Location_2        |
      | Terminal | Illinois Terminal |
    Then Update "2" leg details
      | Due Out Date | Due Out Time |
      | 3            | 3:30 PM      |
    Then Wait for "2" Seconds
  #Step8.c
    Then Wait for "2" Seconds
    Then Update "2" Segment details
      | Search  | Driver                    |
      | Tractor 1011 | Dave Fleet Carrier One 11 |

    Then Update "3" leg details
      | Start Type | Location          |
      | Terminal   | Illinois Terminal |
    Then Update "3" leg details
      | Due Out Date | Due Out Time |
      | 4            | 6:30 AM      |

    Then Update "3" leg details
      | End Type | Location_2  |
      | Location | Revenova HQ |
    Then Update "3" leg details
      | Due Out Date | Due Out Time |
      | 4            | 8:30 AM      |

    Then Update "4" leg details
      | Due Out Date | Due Out Time |
      | 4            | 9:00 AM      |

    Then Update "4" leg details
      | End Type  | Location_2              |
      | Load Stop | Stop 2D - Chicago Pizza |

  #Step 8.d
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

  #Step8.e
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

  #Step 9
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

#    #Step 10 & Expected Result a
    Then Verify details for all Enabled fields
      | Status  |
      | Pending |
    Then Verify "1" Segment details
      | Driver Confirmation Status | Status     |
      | Accepted                   | Configured |
    Then Verify "2" Segment details
      | Driver Confirmation Status | Status  |
      | Pending                    | Pending |

    #Step 10.a
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 11
    Then Navigate to stored URL for "Load_Details"

    #Step 12
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"

    #Expected b
    #Expected b.a
    Then Verify Details
      | Load Status |
      | Assigned    |
    #Expected b.b
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      | Fleet Load Status |
      | Planned           |
    Then Refresh current Page
    #Expected b.c
    Then Verify Banner Details
      | Carrier           |
      | Fleet Carrier One |

    #Step 12.a
    Then Refresh current Page

    #Step 13
#    Then Open "Fleet Management Console" from App Launcher
#    Then Wait for "6" Seconds
    Then Navigate to stored URL for "FMC_Console"
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    #Step 14
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      | Trip Plan Start Date |
      | This Month           |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step15
    Then Click on button with Title "Dispatch"
    Then Wait for "5" Seconds

    #Expected c)
    Then Verify details for all Enabled fields
      | Status  |
      | Pending |
    Then Verify "1" Segment details
      | Driver Confirmation Status | Status     |
      | Accepted                   | Dispatched |
    Then Verify "2" Segment details
      | Driver Confirmation Status | Status  |
      | Pending                    | Pending |

    #Step 15.a
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 16
    Then Navigate to stored URL for "Load_Details"

    #Step 17
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"

    #Expected D
    #Expected D.a
    Then Verify Details
      | Load Status |
      | Dispatched  |
    #Expected D.b
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      | Fleet Load Status |
      | Dispatched        |
    Then Refresh current Page
    #Expected D.c
    Then Verify Banner Details
      | Carrier           |
      | Fleet Carrier One |

    #Step 17.a
    Then Refresh current Page

    #Step 18
#    Then Open "Fleet Management Console" from App Launcher
#    Then Wait for "6" Seconds
    Then Navigate to stored URL for "FMC_Console"
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    #Step 19
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      | Trip Plan Start Date |
      | This Month           |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step20
    Then Click on button with Title "Undispatch"
    Then Verify Success Message displaying as "The driver was undispatched successfully."
    Then Wait for "5" Seconds

    #Expected e)
    Then Verify details for all Enabled fields
      | Status  |
      | Pending |
    Then Verify "1" Segment details
      | Driver Confirmation Status | Status  |
      | Pending                    | Pending |
    Then Verify "2" Segment details
      | Driver Confirmation Status | Status  |
      | Pending                    | Pending |

    #Step20.a
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 21
    Then Navigate to stored URL for "Load_Details"

    #Step 22
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"

    #Expected f
    #Expected f.a
    Then Verify Details
      | Load Status |
      | Assigned    |
    #Expected f.b
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      | Fleet Load Status |
      | Partially Planned |
    Then Refresh current Page
    #Expected f.c
    Then Verify Banner Details
      | Carrier           |
      | Fleet Carrier One |

    #Step 22.a
    Then Refresh current Page
    Then Wait for "5" Seconds
    #Step 23
#    Then Open "Fleet Management Console" from App Launcher
#    Then Wait for "6" Seconds
    Then Navigate to stored URL for "FMC_Console"
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    #Step 24
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      | Trip Plan Start Date |
      | This Month           |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step25
    Then Update "1" Segment details
      | Driver Confirmation Status | Status     |
      | Accepted                   | Dispatched |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step26
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    #Step26.a
    Then Update "1" leg details
      | Arrival Date | Arrival Time | Departure Date | Departure Time |
      | 0            | 8:30 AM      | 0              | 9:00 AM        |
    Then Wait for "3" Seconds

    #Expected g
    Then Verify details for all Enabled fields
      | Status  |
      | Pending |
    Then Verify "1" Segment details
      | Status     | Driver Confirmation Status |
      | Dispatched | Accepted                   |
    Then Verify "2" Segment details
      | Driver Confirmation Status | Status  |
      | Pending                    | Pending |

    #Step27
    Then Update "2" leg details
      | Arrival Date | Arrival Time | Departure Date | Departure Time |
      | 3            | 3:30 PM      | 3              | 4:00 PM        |
    Then Click on button with Title "Save"
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    #Expected h
    Then Verify details for all Enabled fields
      | Status  |
      | Pending |
    Then Verify "1" Segment details
      | Status        | Driver Confirmation Status |
      | Pending Final | Accepted                   |
    Then Verify "2" Segment details
      | Driver Confirmation Status | Status  |
      | Pending                    | Pending |