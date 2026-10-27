Feature: 2432 - Trimble API- Update Position Operation via FleetManagementJob3


  @API @Regression @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @2432 @Debugging
  Scenario: 2432 - Trimble API- Update Position Operation via FleetManagementJob3

    Then Delete Field with Title "SamsaraGetVehicleStatisticsOperation"
    When Login into Salesforce

    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    And Update details for "Catena" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

     # Step 2 a
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | true                 |
    And Update the Custom Select option "Logging User" as "User User"
     # Step 2 b
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    Then Update details -
      | Fleet Management Enabled | Fleet Management Job Last Run |
      | True                     |   5/30/2021 9:30 AM              |

   #Step 2.c)
    And Click on Button with Value "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame

     #Step 3
    Then Open "Fleet Assets" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "Tractor Two Thousand Four Hundred and Thirty Two" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Information"
    Then Click on Edit icon on Label "ELD Last Update"
    Then Update details
      | Date_2 |
      |        |
    Then Update details
      | Latitude  | Longitude  |
      |           |             |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds

   #Step4 & 5
    Given Upload File "SamsaraGetVehicleStatisticsOperation-2432.txt" with Title "SamsaraGetVehicleStatisticsOperation"
    Then Open "Files" from App Launcher
     #Step 4a
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    #Step 4b
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "SamsaraGetVehicleStatisticsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    #Step 4c
    Then Enter File Label "Asset File Name" Text as "SamsaraGetVehicleStatisticsOperation" -
    Then Enter File Label "API Name" Text as "SamsaraGetVehicleStatisticsOperation" -
    #Step 4d
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    #Step 4e
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

  #Step 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans |Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      |Fleet|
      |True |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830            | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | 1445-1530       | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details

  #Step 7
    Then Capture the current URL for "Load_1"

 #Step 8
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load

  #Step 9
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

  #Step 10
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

   #Step 11
    Then Update "1" Segment details
      | Load   |
      | SysData=>1L |
    Then Wait for "4" Seconds

    #Step 12
    Then Verify "1" leg details
      | End Type    | Location_2              | Appointment Date |Appointment Start Time |
      | Load Stop   | Stop 1P - Boston Beans  | 0            | 8:30 AM      |
    Then Verify "2" leg details
      | Start Type    | Location                |Due Out Date|
      | Load Stop     | Stop 1P - Boston Beans  | 0          |
    Then Verify "2" leg details
      | End Type    | Location_2                      | Appointment Date |Appointment Start Time |Appointment End Time|
      | Load Stop   | Stop 2D - Denver Deli Meats     | 3                | 2:45 PM               |3:30 PM|

    Then Update "1" Segment details
      |Search                                |Driver                                        |Driver Confirmation Status |
      |Tractor Two Thousand Four Hundred and Thirty Two|QA Driver Two Thousand Four Hundred and Seven |Accepted                   |

    Then Update "1" leg details
      | Start Type  | Location |
      | Location    |  Los Angeles Lighting    |
    Then Update "1" leg details
      |Due Out Date|Due Out Time|
      |0           |1:15 AM     |

    Then Update "2" leg details
      | Due Out Time|
      | 12:30 PM     |
    Then Wait for "2" Seconds

   #Step 13
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Verify "1" Segment details
      | Status     |
      | Configured |
   #Step 13.a
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 14
    Then Update "1" Segment details
      |Status|
      |Dispatched|
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 15
    Then Click on button "Close" on Trip Plan

    #Step 16
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Wait for "60" Seconds

    #Step 17,18,19,20
#    #Getting API Trip ID to get Expected Details from Trimble API
    Then Get "rtms__API_Trip_Id__c" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "API Trip Id"

    #Step 21 & Expected Result a
     Then Get Trimble GPS Information for Trip Id "API Trip Id"
     Then Verify Assertion for "CoOrdinate" contains "41.22679"
     Then Verify Assertion for "CoOrdinate" contains "-95.9544"
     Then Verify Assertion for "DeviceTime" contains "06/21/2021 11:38 AM"
     Then Verify Assertion for "Direction" contains "5"
     Then Verify Assertion for "Speed" contains "32"


