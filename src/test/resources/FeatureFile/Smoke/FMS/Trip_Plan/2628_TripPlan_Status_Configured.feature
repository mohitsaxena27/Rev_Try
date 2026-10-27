Feature: 2628 - Trip Plan Status- Configured

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trip_Plan @2628
  Scenario: 2628 - Trip Plan Status- Configured

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
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       |  1530     | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    #Step 3
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

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
    Then Update "1" Segment details
      |Search    |Driver                                        |
      |Tractor 1004  |Dave Fleet Carrier One 4 |
    Then Update "1" leg details
      | Start Type  | Location |
      | Location    | Revenova HQ      |
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |0           |6:30 AM     |

    Then Update "2" leg details
      | Due Out Time|
      | 9:30 AM     |
    Then Wait for "2" Seconds

  #Step 7
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 8
    Then Update "1" Segment details
      |Driver Confirmation Status |
      |Accepted                   |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 9 & Expected Result a
    Then Verify details for all Enabled fields
         |Status|
         |Configured|
    Then Verify "1" Segment details
      |Driver Confirmation Status |Status|
      |Accepted                   |Configured|

    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds
    #Step 10
    Then Navigate to stored URL for "Load_Details"
    #Step 11
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected b
    Then Verify Details
      |Load Status  |
      |Assigned       |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Planned      |
    Then Refresh current Page
    #Step 12 & Expected Result c
    Then Verify Banner Details
      |Carrier               |Carrier Total|
      |Fleet Carrier One     |USD 1,200.00         |
    Then Verify Banner details For Checkbox
       |Accepted|
       |True     |


