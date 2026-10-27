Feature: 2627 - Trip Plan Status- Single Segment Pending

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trip_Plan @2627
  Scenario: 2627 - Trip Plan Status- Single Segment Pending

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
      | N       | 2D   | Account_Address | Chicago Pizza    |  3             | NA                       |  1530     | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

    #Step 3
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected a
    Then Verify Details
      |Load Status  |
      |Unassigned       |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Unplanned      |

    #Step4
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

    #Step 5
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

  #Step 6
    Then Update "1" leg details
      | Start Type  | Location |
      | Location    | New England Patriots      |
    Then Update "1" leg details
      |Due Out Date|
      |0           |
    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

     # Expected Result b
    Then Verify details for all Enabled fields
      |Status|
      |Pending|
    Then Verify "1" Segment details
      |Driver Confirmation Status |Status|
      |Pending                   |Pending|
    #Step 7
    Then Open New Tab with url "SysData=>Load_Details"
    #Step 8
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected c
    Then Verify Details
      |Load Status  |
      |Unassigned       |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Partially Planned      |

   #Step 9 & 10
    Then Close and Switch to Previous Window
    Then Wait for "2" Seconds

    #Step 11
    Then Update "1" Segment details
      |Search    |Driver                    |
      |Tractor 1010  |Dave Fleet Carrier One 10 |
    Then Update "1" leg details
      |Due Out Time|
      |6:30 AM     |
    Then Update "2" leg details
      |Due Out Time|
      |9:30 AM     |

    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

     # Expected Result d
    Then Verify details for all Enabled fields
      |Status|
      |Pending|
    Then Verify "1" Segment details
      |Driver Confirmation Status |Status|
      |Pending                   |Pending|

    #Step 12
    Then Open New Tab with url "SysData=>Load_Details"
    #Step 13
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected e
    Then Verify Details
      |Load Status  |
      |Unassigned       |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Partially Planned      |

    #Step 14 & 15
    Then Close and Switch to Previous Window
    Then Wait for "2" Seconds

    #Step 16
    Then Click on button with Title "Confirm Driver"
    Then Verify Message displaying as "The driver confirmation email was sent."

     # Expected Result f
    Then Verify details for all Enabled fields
      |Status|
      |Pending|
    Then Verify "1" Segment details
      |Driver Confirmation Status  |Status|
      |Requested                   |Pending|

    #Step 17
    Then Open New Tab with url "SysData=>Load_Details"
    #Step 18
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected g
    Then Verify Details
      |Load Status  |
      |Tendered       |
    Then Scroll into Section "Assigned Carrier Information"
    Then Verify Details
     |Carrier|Vendor|Carrier Service|
     |Fleet Carrier One|Fleet Carrier One|Fleet Carrier One - Truckload|
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Partially Planned      |

    #Step 19 & 20
    Then Close and Switch to Previous Window
    Then Wait for "2" Seconds

    #Step 21
    Then Update "1" Segment details
      |Driver Confirmation Status |Status|
      |Accepted                   |Dispatched|
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 21.b
    Then Click on button with Title "Undispatch"
    Then Verify Message displaying with Text "The driver was undispatched successfully."
    Then Wait for "6" Seconds
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "2" Seconds
     # Expected Result h
    Then Verify details for all Enabled fields
      |Status|
      |Pending|
    Then Verify "1" Segment details
      |Driver Confirmation Status  |Status|
      |Pending                     |Pending|

    #Step 22
    Then Open New Tab with url "SysData=>Load_Details"
    #Step 23
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected i
    Then Verify Details
      |Load Status  |
      |Assigned       |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Partially Planned      |

    #Step 24 & 25
    Then Close and Switch to Previous Window
    Then Wait for "2" Seconds

    #Step 26
    Then Update "1" Segment details
      |Driver Confirmation Status   |
      |Accepted                     |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 27
    Then Click on button "Close" on Trip Plan

    #Step 28
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 29
    Then Update "1" Segment details
      | Load   |
      | SysData=>1L |
    Then Wait for "1" Seconds
    Then Update "1" leg details
      | Start Type | Location             | Due Out Date |
      | Location   | Boston Red Sox       | 0            |

    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID_3"

      # Expected Result j
    Then Verify details for all Enabled fields
         |Status|
         |Pending|
    Then Verify "1" Segment details
      |Driver Confirmation Status |Status|
      |Pending                   |Pending|

    #Step 30
    Then Open New Tab with url "SysData=>Load_Details"
    #Step 31
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected k
    Then Verify Details
      |Load Status  |
      |Assigned       |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Partially Planned      |
