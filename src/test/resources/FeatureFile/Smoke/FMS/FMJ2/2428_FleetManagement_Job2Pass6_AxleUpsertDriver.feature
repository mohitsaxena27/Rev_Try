Feature: 2428 - Fleet Management Job 2- Pass 6- AxleUpsertDriver

  Background: Pre- Test
    Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"

  #  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @Catena @Motive @2428
  Scenario: 2428 - Fleet Management Job 2- Pass 6- AxleUpsertDriver

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

    #Step 4
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 5 & 6
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    #Step 7
    Then Get "AxleGetFleetDataFromFleetCodeOperation-2428.txt" files and update below Attributes
      | {fleet_id}                 |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-2428.txt"

    #Step 8,9 & 10, 11
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-2428.txt" with Title "AxleGetFleetDataFromFleetCodeOperation" and Description "200"

    #Step 12 & 13
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

    #Step 14 & 15
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    #Step 16
    Then Set DateTime In Word with Key "DriverName"
    Then Set "DriverUserName" with "2428CurrentDateTime"
    Then Set "CDL#" with "CurrentDateTime"
    Then Open "Drivers" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Driver Name               |Status   |Type     |Contact                            |
      |SysData=>DriverName       |Available|Employee |QA Contact Twenty Four Twenty Eight|
    Then Scroll into Section "ELD Configuration"
    Then Update details
      |ELD Enabled|ELD Brand|Username               |Timezone|Driver Ruleset Override|
      |True       |Samsara  |SysData=>DriverUserName|America/Chicago  |True|
    Then Update details -
      |Cycle Override|Restart Override|Rest Break Override|Jurisdiction Override|
      |California Flammable Liquid (8/80)|72-Hour Restart|California Mealbreak (off-duty/sleeper)|DC|
    Then Scroll into Section "Employment / Personal Information"
    Then Update details
      |CDL #             |CDL Country|CDL State/Province|
      |SysData=>CDL#     |United States|IL              |

    #Step 17
    Then Click on "SaveEdit" button -
    Then Verify Message displaying as "was created."
    Then Verify Text displaying as "SysData=>DriverName"
    Then Set Key "Driver_SFID" page Record Id with "rtms__Driver__c"

    #Step 18-23 (N/A)
    #Step 24
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

    #Step 25 & 26
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

     #Step 27
#    Then Wait for Email to Receive On Email
#    #Expected a)
#    Then Set "EmailContent" with Email Text as "Pass 6: Catena Returned Error Code: 400 And Message: Error from TSP: samsara POST https://api.samsara.com/fleet/drivers returned 400: {\"message\":\"Invalid driver US override UsStateToOverride string  for cycle California Flammable Liquid (8/80)\",\"requestId\":\"rbvyfljg-lhlaxcuo\"} For Object: rtms__Driver__c Name: {DriverName} Id: {DriverID}---(rtms)"
#    Then Verify Content "SysData=>EmailContent" in the email with Subject "Fleet Management Job 2"

    #Step 28
    Then Open "Drivers" from App Launcher
    Then Search and Select "SysData=>DriverName" from List
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "Cycle Override"
    Then Update details
      |Cycle Override             |
      |USA Passenger (7/60)       |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "Cycle Override" having value of "USA Passenger (7/60)"

     #Step 29 & 30
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

     #Step 31
#    Then Wait for Email to Receive On Email
#    #Expected b)
#    Then Set "EmailContent" with Email Text as "Pass 6: Catena Returned Error Code: 400 And Message: Error from TSP: samsara POST https://api.samsara.com/fleet/drivers returned 400: {\"message\":\"The California Mealbreak restbreak can only be set for California rulesets.\",\"requestId\":\"cxnvkduk-eekoakmj\"} For Object: rtms__Driver__c Name: {DriverName} Id: {DriverID}---(rtms)"
#    Then Verify Content "SysData=>EmailContent" in the email with Subject "Fleet Management Job 2"

    #Step 32
    Then Open "Drivers" from App Launcher
    Then Search and Select "SysData=>DriverName" from List
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "Cycle Override"
    Then Update details
      |Rest Break Override             |
      |Property (off-duty/sleeper)       |
    Then Click on "SaveEdit" button on Details Page
    Then Verify "Rest Break Override" having value of "Property (off-duty/sleeper)"

     #Step 33 & 34
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

     #Step 35
#    Then Wait for Email to Receive On Email
#    #Expected c)
#    Then Set "EmailContent" with Email Text as "{DriverName}"
#    Then Verify Content "SysData=>EmailContent" not in the email with Subject "Fleet Management Job 2"


    #Step 36 & 36.1
    Then Get Access token using "2428_GetAccessToken.json" and store in "Access_Token"
    #Step 36.2 & 36.3 & 36.4
    Then Get Driver "SysData=>DriverName" Details using "Access_Token"

    #Expected d
    Then Verify Key "Driver_fleet_id" with value "SysData=>Customer_Number"
    Then Verify Key "Driver_tsp_source" with value "samsara"
    Then Verify Key "Driver_name" with value "SysData=>DriverName"
    Then Verify Key "Driver_username" with value "SysData=>DriverUserName"
#    Then Verify Key "Driver_phone" with value "13125551212"
    Then Verify Key "Driver_status" with value "active"
    Then Verify Key "Driver_notes" with value "From TMS- Username: SysData=>DriverUserName"
    Then Verify Key "Driver_TimeZone" with value "America/Chicago"
    Then Verify Key "Driver_carrier_Name" with value "Fleet Carrier Two"
    Then Verify Key "Driver_dot_number" with value "3949562"
    Then Verify Key "Driver_license_number" with value "SysData=>CDL#"
    Then Verify Key "Driver_license_state" with value "IL"
    Then Verify Key "Driver_license_country" with value "US"
    Then Verify Key "Driver_work_rules.break" with value "Property (off-duty/sleeper)"
    Then Verify Key "Driver_work_rules.cycle" with value "USA Passenger (7/60)"
    Then Verify Key "Driver_work_rules.restart" with value "72-hour Restart"
    Then Verify Key "Driver_work_rules.shift" with value ""
    Then Verify Key "Driver_work_rules.jurisdiction" with value ""

   #Step 36.5 & 36.6
    Then Set "DriverUserName2" with "userCurrentDateTime"
    Then Set "CDL#" with "CurrentDateTimeA"
    Then Open "Drivers" from App Launcher
    Then Search and Select "SysData=>DriverName" from List
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "Username"
    Then Update details -
      |Username               |Timezone          |
      |SysData=>DriverUserName|America/New_York  |
    Then Update details -
      |Cycle Override|Restart Override|Rest Break Override|Jurisdiction Override|
      |USA Property (7/60)|24-Hour Restart|None|CT|
    Then Scroll into Section "Employment / Personal Information"
    Then Update details -
     |Phone        |CDL #             |CDL State/Province|
     |312-555-1212 |SysData=>CDL#     |NY              |
    #36.7
    Then Click on "SaveEdit" button on Details Page
    Then Scroll into Section "ELD Configuration"
    Then Verify "Timezone" having value of "America/New_York"

     #Step 36.8 & 36.9
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds
    #36.10
    Then Get Driver "SysData=>DriverName" Details using "Access_Token"
    #Expected e
    Then Verify Key "Driver_fleet_id" with value "SysData=>Customer_Number"
    Then Verify Key "Driver_tsp_source" with value "samsara"
    Then Verify Key "Driver_name" with value "SysData=>DriverName"
    Then Verify Key "Driver_username" with value "SysData=>DriverUserName"
    Then Verify Key "Driver_status" with value "active"
    Then Verify Key "Driver_notes" with value "From TMS- Username: SysData=>DriverUserName"
    Then Verify Key "Driver_TimeZone" with value "America/New_York"
    Then Verify Key "Driver_carrier_Name" with value "Fleet Carrier Two"
    Then Verify Key "Driver_dot_number" with value "3949562"
    Then Verify Key "Driver_license_number" with value "SysData=>CDL#"
    Then Verify Key "Driver_license_state" with value "NY"
    Then Verify Key "Driver_license_country" with value "US"
    Then Verify Key "Driver_work_rules.break" with value "None"
    Then Verify Key "Driver_work_rules.cycle" with value "USA Passenger (8/70)"
    Then Verify Key "Driver_work_rules.restart" with value "24-hour Restart"
    Then Verify Key "Driver_work_rules.shift" with value ""
    Then Verify Key "Driver_work_rules.jurisdiction" with value ""

    Then Set "TimeValue" with "SysData=>Driver_time"

   #Step 36.12
    Then Open "Drivers" from App Launcher
    Then Search and Select "SysData=>DriverName" from List
    Then Wait for "1" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "Timezone"
    Then Update details -
      |Timezone          |
      |America/Los_Angeles  |
    Then Update details -
      |Cycle Override|Restart Override|Rest Break Override|
      |California Motion Picture (8/80)|36-Hour Restart|California Mealbreak (off-duty/sleeper)|
    #36.13
    Then Click on "SaveEdit" button on Details Page
    Then Scroll into Section "ELD Configuration"
    Then Verify "Timezone" having value of "America/Los_Angeles"

     #Step 36.14 & 36.15
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds
    #36.16
    Then Get Driver "SysData=>DriverName" Details using "Access_Token"
    #Expected f
    Then Verify Key "Driver_fleet_id" with value "SysData=>Customer_Number"
    Then Verify Key "Driver_time" with value "SysData=>TimeValue"
    Then Verify Key "Driver_tsp_source" with value "samsara"
    Then Verify Key "Driver_name" with value "SysData=>DriverName"
    Then Verify Key "Driver_username" with value "SysData=>DriverUserName"
    Then Verify Key "Driver_status" with value "active"
    Then Verify Key "Driver_notes" with value "From TMS- Username: SysData=>DriverUserName"
    Then Verify Key "Driver_TimeZone" with value "America/New_York"
    Then Verify Key "Driver_carrier_Name" with value "Fleet Carrier Two"
    Then Verify Key "Driver_dot_number" with value "3949562"
    Then Verify Key "Driver_license_number" with value "SysData=>CDL#"
    Then Verify Key "Driver_license_state" with value "NY"
    Then Verify Key "Driver_license_country" with value "US"
    Then Verify Key "Driver_work_rules.break" with value ""
    Then Verify Key "Driver_work_rules.cycle" with value "USA Passenger (8/70)"
    Then Verify Key "Driver_work_rules.restart" with value "24-hour Restart"
    Then Verify Key "Driver_work_rules.shift" with value "US Interstate Property"
    Then Verify Key "Driver_work_rules.jurisdiction" with value ""






