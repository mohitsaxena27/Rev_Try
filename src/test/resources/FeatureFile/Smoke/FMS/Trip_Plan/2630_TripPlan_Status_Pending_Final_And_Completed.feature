Feature: 2630 - Trip Plan Status - Pending Final & Completed

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trip_Plan @2630
  Scenario: 2630 - Trip Plan Status - Pending Final & Completed

    When Login into Salesforce
   #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode | Lane        | Category | Rate Type |Status|Effective Date|Fleet Loads Only|
      | Boston Beans         | Truckload  | US to US | Carrier  | Freight  |Accepted|0            |True           |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      |Carrier Service              |Rate Method|Rate|
      |Fleet Carrier One - Truckload|Fixed Amount|1200 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_Name"
    Then Capture the current URL for "Rate_Entry_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans  |Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      |Fleet|
      |True |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830            | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza    |  4            | NA                       |  1530     | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    #Step 3 & 4
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

   #Step5
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

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
    Then Wait for "1" Seconds
    Then Click on "Add Leg Below" on "3" Leg
    Then Wait for "2" Seconds

  #Step8.b
    Then Update "1" Segment details
      | Search       | Driver                    |Driver Confirmation Status |Status|
      | Tractor 1029 | Dave Fleet Carrier One 29 |Accepted                   |Dispatched|

    Then Update "1" leg details
      | Start Type | Location       |
      | Location   | Boston Red Sox |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 0            | 6:30 AM      |

    Then Update "2" leg details
      | Due Out Time |
      | 9:30 PM      |
    Then Update "2" leg details
      | End Type | Location_2        |Appointment Date |
      | Terminal | Illinois Terminal |3                |


  #Step8.c
    Then Update "2" Segment details
      | Search   | Driver                    |Driver Confirmation Status |Status|
      | Tractor 1030 | Dave Fleet Carrier One 30 |Accepted                   |Dispatched|

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
      | Appointment Date |Appointment Start Time|
      | 4                | 8:30 AM      |

    Then Update "4" leg details
      | Due Out Date | Due Out Time |
      | 4            | 9:30 AM      |

    Then Update "4" leg details
      | End Type  | Location_2              |
      | Load Stop | Stop 2D - Chicago Pizza |

    Then Update "5" leg details
      | Due Out Date | Due Out Time |
      | 4            | 10:00 PM      |

    Then Update "5" leg details
      | End Type  | Location_2   |Appointment Date |Appointment Start Time|
      | Location  | Chicago Cubs |5                |2:00 AM               |

  #Step 8.d
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

  #Step8.e
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 9
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Arrival Date | Arrival Time | Departure Date | Departure Time |
      | 0            | 8:30 AM      | 0              | 9:00 AM        |
    Then Update "2" leg details
      | Arrival Date | Arrival Time |
      | 3            | 3:30 PM      |
    Then Wait for "1" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    # Expected Result a
    Then Verify details for all Enabled fields
      |Status|
      |Dispatched|
    Then Verify "1" Segment details
      |Driver Confirmation Status |Status|
      |Accepted                   |Pending Final|
    Then Verify "2" Segment details
      |Driver Confirmation Status |Status|
      |Accepted                   |Dispatched|

    #Step 10
    Then Open New Tab with url "SysData=>Load_Details"
    #Step 11
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected b
    Then Verify Details
      |Load Status  |
      |In Transit   |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Dispatched      |

    #Step 12
    Then Close and Switch to Previous Window
    Then Wait for "1" Seconds

    #Step 13
    Then Update "3" leg details
      | Arrival Date | Arrival Time | Departure Date | Departure Time |
      | 4            | 8:30 AM      | 4              | 9:00 AM        |
    Then Update "4" leg details
      | Arrival Date | Arrival Time |
      | 4            | 3:00 PM      |
    Then Wait for "1" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    # Expected Result c
    Then Verify details for all Enabled fields
      |Status|
      |Pending Final|
    Then Verify "1" Segment details
      |Driver Confirmation Status |Status|
      |Accepted                   |Pending Final|
    Then Verify "2" Segment details
      |Driver Confirmation Status |Status|
      |Accepted                   |Pending Final|

    #Step 14
    Then Open New Tab with url "SysData=>Load_Details"
    #Step 15
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected d
    Then Verify Details
      |Load Status  |
      |In Transit   |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Pending Final      |

    #Step 16
    Then Click on Edit icon on Label "Fleet Load Status"
    Then Update details
      |Fleet Load Status  |
      |Final      |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds
    Then Scroll into Section "Team Assignments & Status"

    #Expected e
    Then Verify Details
      |Load Status  |
      |Completed   |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Final              |

    #Step 17 , 18 & 19
    Then Close and Switch to Previous Window
    Then Wait for "1" Seconds
    Then Wait for "1" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "3" Seconds
    #Step 20 and #Expected f
    Then Verify details for all Enabled fields
      |Status|
      |Completed|
    Then Verify "1" Segment details
      |Driver Confirmation Status |Status|
      |Accepted                   |Completed|
    Then Verify "2" Segment details
      |Driver Confirmation Status |Status|
      |Accepted                   |Completed|
















