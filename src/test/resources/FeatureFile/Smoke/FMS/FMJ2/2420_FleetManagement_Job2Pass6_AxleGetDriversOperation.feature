Feature: 2420 - Fleet Management Job 2- Pass 6- AxleGetDriversOperation

  Background: Pre- Test
    Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"
    Then Delete Field with Title "AxleGetDriversOperation"

   #  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @Catena @Motive @2420
  Scenario: 2420 - Fleet Management Job 2- Pass 6- AxleGetDriversOperation

    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    #Step 2
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    Then Set Field Value "Customer Number" into "Customer_Number" Value

    #Step3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"

    #Step 3.a)
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Fleet Management" -

    #Step 3.b)
    Then Select Fleet Management Job as "FleetManagementJob2"
    Then Update details -
      | Fleet Management Pass Counter |
      | 1                             |

    #Step 3.c
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 4
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    #Step 5
    Then Get "AxleGetFleetDataFromFleetCodeOperation-2420.txt" files and update below Attributes
      | {fleet_id}                 |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-2420.txt"

    #Step 5,6 & 7
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-2420.txt" with Title "AxleGetFleetDataFromFleetCodeOperation"

    #Step 8
    Then Get "AxleGetDriversOperation-2420.txt" files and update below Attributes
      | {fleet_id}                 |
      | SysData=>Customer_Number   |
    Then Save it with FileName "AxleGetDriversOperation-2420.txt"

     #Step 9, 10, 11, 12 & 13
    Given Upload File "U_AxleGetDriversOperation-2420.txt" with Title "AxleGetDriversOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetDriversOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetDriversOperation" -
    Then Enter File Label "API Name" Text as "AxleGetDriversOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    #Step 14
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 3                             |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 15 & 16
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    #Step 17
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 6                             |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 18 & 19
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "20" Seconds
    Then Refresh current Page
    #Step 20
    Then Open "Drivers" from App Launcher
    Then Search and Select "Terry Trucker" from List
    Then Wait for "1" Seconds
    Then Set Key "Driver_Terry_Trucker" page Record Id with "rtms__Driver__c"

    #Expected a
    Then Verify Details
    |Driver Name  |Status   |Type|Contact|Company/Division|Confirmation Method|
    |Terry Trucker|Available|Employee|Terry Trucker|Fleet Carrier One|Email   |
    Then Scroll into Section "ELD Configuration"
    Then Verify Details
    |ELD ID |ELD Brand|Username    |Timezone|Cycle Override|Restart Override|Rest Break Override|
    |4444444|Samsara  |terrytrucker|       |USA Property (8/70)|36-Hour Restart|Property (off-duty/sleeper)|
    Then Verify Label Checkbox
    |ELD Enabled|
    |true       |
    Then Scroll into Section "Employment / Personal Information"
    Then Verify Details
    |Activation Status|Email|Phone|CDL #|CDL Country|Drivers License Country|CDL State/Province|
    |Active           |     |(312) 555-1212|PI3317|United States|United States|IL              |

   #Step 21
    Then Open "Drivers" from App Launcher
    Then Search and Select "Tom Fleet Carrier Two" from List
    Then Wait for "1" Seconds
    Then Set Key "Driver_Tom_Fleet_Carrier_Two" page Record Id with "rtms__Driver__c"

    #Expected b
    Then Verify Details
      |Driver Name         |Status   |Type|Contact|Company/Division|Confirmation Method|
      |Tom Fleet Carrier Two|Available|Independent Contractor|Tom Fleet Carrier Two|Fleet Carrier Two|Email   |
    Then Scroll into Section "ELD Configuration"
    Then Verify Details
      |ELD ID |ELD Brand|Username|Timezone|
      |5555555|Samsara  |tomfleetcarriertwo|America/Los_Angeles  |
    Then Verify Label Checkbox
      |ELD Enabled|
      |true       |
    Then Scroll into Section "Employment / Personal Information"
    Then Verify Details
      |Activation Status|Email|Phone|CDL #|CDL Country|Drivers License Country|CDL State/Province|
      |Active           |SysData=>ContactEmail |(312) 999-8888|PI3317B|United States|United States|CA              |

   #Step 22
    Then Open "Drivers" from App Launcher
    Then Search "Trevor Trucker" from List
    #Expected c
    Then Verify No Records found with this Text

    #Step 23 & 24
    Then Open "Drivers" from App Launcher
    Then Search and Select "Terry Trucker" from List
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      |ELD ID |Jurisdiction Override|
      |123456 |AK                   |
    Then Scroll into Section "Licenses / Certifications"
    Then Update details
      |CDL #     |
      |987654321 |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "ELD ID" having value of "123456"

     #Step 25 & 26
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    #Step 27
    Then Open "Drivers" from App Launcher
    Then Search and Select "Terry Trucker" from List
    Then Wait for "1" Seconds

    #Expected d
    Then Scroll into Section "ELD Configuration"
    Then Verify Details
      |ELD ID |
      |4444444|

     #Step 28
    Then Scroll into Section "Licenses / Certifications"
    #Expected Result e
    Then Verify Details
      |CDL #|
      |987654321|

   #Step 29
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Enable Packet Replay |
      | False                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

     #Step 30 & 31
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    #Step 32 & 32.1
    Then Get Access token using "2420_GetAccessToken.json" and store in "Access_Token"
    #Step 32.2 & 32.3 & 32.4
    Then Get Driver "QA Driver Two Thousand Four Hundred Twenty" Details using "Access_Token"
    Then Verify Key "Driver_TimeZone" with value "America/Chicago"
    Then Verify Key "Driver_work_rules.break" with value "Property (off-duty/sleeper)"
    Then Verify Key "Driver_work_rules.cycle" with value "USA Property (7/60)"
    Then Verify Key "Driver_work_rules.restart" with value "24-Hour Restart"
   #Step 32.5 & 32.6
    Then Open "Drivers" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Twenty" from List
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      |Timezone                    |Cycle Override|Restart Override|Rest Break Override|
      |America/North_Dakota/Center |Unrecognized Value from API|36-Hour Restart|None   |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "Timezone" having value of "America/North_Dakota/Center"

     #Step 32.7 & 32.8
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds
    #Step 32.9 & 32.10
    Then Get Driver "QA Driver Two Thousand Four Hundred Twenty" Details using "Access_Token"
    #Expected f
    Then Verify Key "Driver_TimeZone" with value "America/Chicago"
    Then Verify Key "Driver_work_rules.break" with value "Property (off-duty/sleeper)"
    Then Verify Key "Driver_work_rules.cycle" with value "USA Property (7/60)"
    Then Verify Key "Driver_work_rules.restart" with value "24-hour Restart"

    #Step 32.11
    Then Open "Drivers" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Twenty" from List
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "Cycle Override"
    Then Update details
      |Cycle Override             |
      |USA Passenger (7/60)       |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "Cycle Override" having value of "USA Passenger (7/60)"

     #Step 32.12 & 32.13
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds
    #Step 32.14 & Step 32.15
    Then Get Driver "QA Driver Two Thousand Four Hundred Twenty" Details using "Access_Token"

    #Expected g
     Then Verify Key "Driver_TimeZone" with value "America/North_Dakota/Center"
     Then Verify Key "Driver_work_rules.break" with value "None"
     Then Verify Key "Driver_work_rules.cycle" with value "USA Passenger (7/60)"
     Then Verify Key "Driver_work_rules.restart" with value "36-hour Restart"





