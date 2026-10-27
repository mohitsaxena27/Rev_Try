Feature: 3242 - Fleet Management Job 3- Pass 12- Load Attachments

  @API @Regression @Smoke @WEB @FMS @Fleet_Management_Job @SingleCurrency  @3242
  Scenario: 3242 - Fleet Management Job 3- Pass 12- Load Attachments

    When Login into Salesforce
    Then Delete All Records with name "Email-" for "rtms__InboundEmail2__c"

  #Step 1
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

  # Step 2.a
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | true                 |
    And Update the Custom Select option "Logging User" as "User User"

  # Step 2.b
    Then Scroll into Section "Fleet Management" -
    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
    Then Select Fleet Management Job as "FleetManagementJob3"
    Then Update details -
      | Fleet Management Enabled |Create ELD Trip On Dispatch|Fleet Management Job Last Run|
      | True                     |False                      |SysData=>FinalDate           |
    And Click on Button with Value "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame

  #Step 3
    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 8" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID |ELD Enabled|
      |51799001|True      |
    Then Click on "Save" button
    Then Wait for "2" Seconds

    Then Open "Drivers" from App Launcher
    Then Search and Select "Bruce Fleet Carrier Two 12" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID |
      |3242|
    Then Click on "Save" button
    Then Wait for "2" Seconds

  #Step 4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Chicago Pizza |Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      |Fleet|
      |True |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | 0900            | NA                    |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Joliet Jazz Supplies|  0            | NA                       | 1315-1345        | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

  #Step 5.a
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "3" Seconds
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      | Search                   | Driver                    |
      |Tractor ThreeTwoThreeZero | Bruce Fleet Carrier Two 8 |
    Then Wait for "2" Seconds
    Then Update "1" Segment details
      | Load        |
      | SysData=>1L |
    Then Wait for "5" Seconds
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Wait for "1" Seconds
    Then Update "1" leg details
      | Start Type | Location          | Due Out Date | Due Out Time |
      | Location   | Chicago White Sox | 0            | 6:00 AM      |
    Then Update "2" leg details
      | Due Out Time |
      | 10:30 AM     |

  #Step 5.b
    Then Click on button with Title "Save"
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Verify Message displaying with Text "Save was successful."
    Then Verify Message displaying as "Trip has been successfully created in the ELD."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Verify details for all Enabled fields
      | Status  |
      | Configured |
    Then Verify "1" Segment details
      | Driver Confirmation Status | Status     |
      | Accepted                   | Configured |

  #Step 5.c
    Then Click on "Dispatch" on "1" Segment
    Then Verify Message displaying with Text "Driver Dispatch was successful."
    Then Verify Message displaying as "Trip has been successfully updated in the ELD."
    Then Wait for "5" Seconds
    Then Click on button "Close" on Trip Plan

  # Step 6
    Then Get "Id" from "rtms__TripPlanSegment__c" using "rtms__Load__c" with value "SysData=>1LRI" and Store onto "Segment Id"
    Then Get "rtms__End_ELD_Id__c" from "rtms__TripPlanLeg__c" using "rtms__Trip_Plan_Segment__c" with value "SysData=>Segment Id" & "Name" with value "Leg 2" and Store onto "End ELd Id"

  # Step 7
    Then Get "SamsaraGetDocumentsOperation-3242.txt" files and update below Attributes
      | {routeStop_id}      |
      | SysData=>End ELd Id |
    Then Save it with FileName "SamsaraGetDocumentsOperation-3242.txt"

  # Step 8
    Given Upload File "U_SamsaraGetDocumentsOperation-3242.txt" with Title "SamsaraGetDocumentsOperation"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "SamsaraGetDocumentsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "SamsaraGetDocumentsOperation" -
    Then Enter File Label "API Name" Text as "SamsaraGetDocumentsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

  # Step 9
    Then Go to Home Page
    Then Wait for "5" Seconds
    Then Run "FleetManagementJob3" Job
    Then Wait for "40" Seconds

  # Step 10
    Then Navigate to stored URL for "Load_1"
    Then Go to "Documents" Tab
    Then Go to "Files" Tab
    Then Wait for "9" Seconds

  #Expected a
    Then Verify Text displaying as "Proof of Delivery3242A.jpg"

  # Step 11
    Then Open "Inbound Emails" from App Launcher
    Then Recently Viewed to All
    Then Wait for "2" Seconds
    Then Click on Partial Link Text "Email-" on Page
    Then Wait for "2" Seconds

  #Expected b
    Then Verify Text displaying as "Proof of Delivery3242B.jpg"
    Then Scroll into Section "Details"
    Then Scroll into Section "Message"
    Then Verify read-only label "Subject" is displaying with text value of "The driver document could not be associated with a Load."
    Then Verify read-only label "Body" is displaying with text value of "The driver document could not be associated with a Load."
