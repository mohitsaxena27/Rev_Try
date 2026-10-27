Feature: 3586 - Fleet Management Job 4- Pass 6- AxleUpsertDriver

  Background: Pre- Test
  Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"

#  @API @Regression @WEB @smoke @FMS @SingleCurrency @3586 @Catena @Debugging
  Scenario: 3586 -Fleet Management Job 4- Pass 6- AxleUpsertDriver
    When Login into Salesforce

    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds

    # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    Then Set Field Value "Customer Number" into "Customer_Number" Value
    Then Verify "SysData=>Customer_Number" value is not empty
    Then Update details
      | Enabled |
      | true    |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

    # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob4"
#    Then Update details -
#      | Fleet Management Pass Counter |
#      |                               |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 3,4,5 & 6
    Then Get Access token using "3586_GetAccessToken.json" and store in "Access_Token"
    Then Get Fleet Code using "Access_Token" for Fleet ID "SysData=>Customer_Number"

    # Step 7
    Then Get "AxleGetFleetDataFromFleetCodeOperation-3586.txt" files and update below Attributes
      | {fleet_id}               | {fleet_code}        | {axle_tsp_id}   |
      | SysData=>Customer_Number | SysData=>fleet_code | SysData=>Samsara_AxleID |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-3586.txt"

    # Step 8 - Upload packet replay file
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-3586.txt" with Title "AxleGetFleetDataFromFleetCodeOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetFleetDataFromFleetCodeOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetFleetDataFromFleetCodeOperation" -
    Then Enter File Label "API Name" Text as "AxleGetFleetDataFromFleetCodeOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    # Step 9
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds
    Then Reset Time to get New Email

    # Step 10
    Then Set DateTime In Word with Key "Driver_Name"
    Then Open "Drivers" from App Launcher
    Then Click on button with Title "New"
    Then Wait for "3" Seconds
    Then Update details
      | Driver Name          | Status    | Type     | Contact                                | Domicile          |
      | SysData=>Driver_Name | Available | Employee | QA Contact Driver Three Five Eight Six | Fleet Carrier One |
   # Step 11
    Then Click on button with Title "Save"
    Then Verify Text displaying as "SysData=>Driver_Name"

#    Then Search and Select "August Sixth Twenty Six Seven Twenty Eight" from List
#    Then Set "Driver_Name" with "August Sixth Twenty Six Seven Twenty Eight"
#    Then Set "Driver_Username" with "augustsixthtwentysixsixthree"
    Then Remove " " and Set "SysData=>Driver_Name" on to "Driver_Username"
#    Then Set "CDL_Number_1" with "3586080626"
#    Then Capture the current URL for "Driver_Records"

# Step 12
    Then Scroll into Section "ELD Configuration"
    Then Wait for "3" Seconds
    Then Get Details
         |Username|
         |        |
    Then Set "CDL_Number_1" value as "3586+{currentDate=>MMddyy}"
    Then Click on Edit icon on Label "ELD Enabled"
    Then Wait for "1" Seconds
    Then Update details
      | ELD Enabled | ELD Brand | Timezone        | Driver Ruleset Override | Cycle Override         | Restart Override | Rest Break Override                         | Jurisdiction Override | CDL #                 | CDL State/Province |
      | True        | Samsara   | America/Chicago | True                    | Alaska Property (7/70) | 72-Hour Restart  | California Mealbreak (off-duty/sleeper)     | AK                    | SysData=>CDL_Number_1 | IL                 |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Verify Details
         |ELD Brand|
         |Samsara  |
    Then Capture the current URL for "Driver_Records"

   #step 13
    Then Refresh current Page
    Then Wait for "5" Seconds
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
    Then Update details -
      |Fleet Management Job Last Run|
      |SysData=>FinalDate      |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    # Step 14
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "3" Seconds
    Then Reset Time to get New Email

    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "3" Seconds
    Then Delete "FleetManagementJob4" job

    #Step 15 Expected Result a  Check this step
    Then Wait for Email to Receive On Email
    #Expected a)
  #  Then Set "EmailErrorMessage" with "The California Mealbreak restbreak can only be set for California rulesets" and "SysData=>Driver_Name"
    Then Verify Content "The California Mealbreak restbreak can only be set for California rulesets" in the email with Subject "Fleet Management Error"
    Then Verify Content "SysData=>Driver_Name" in the email with Subject "Fleet Management Error"
    Then Reset Time to get New Email

    # Step 16
    Then Navigate to stored URL for "Driver_Records"
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "Cycle Override"
    Then Update details
      | Cycle Override       | Rest Break Override          |
      | USA Passenger (7/60) | Property (off-duty/sleeper) |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Verify Details
      |Rest Break Override|
      |Property (off-duty/sleeper)  |

    #Step 17
    Then Refresh current Page
    Then Wait for "5" Seconds
#    Then Open "TMS Admin" from App Launcher
#    Then Go to "Configuration" Tab
#    Then Switch to Frame by Title "accessibility title"
#    Then Scroll into Section "Fleet Management" -
#    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
#    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
#    Then Update details -
#      |Fleet Management Job Last Run|
#      |SysData=>FinalDate      |
#    And Click on Button with Value "Save" -
#    Then Verify Text displaying as "Save was successful." -
#    Then Switch to Parent Frame
#    Then Wait for "2" Seconds
#    Then Go to Home Page
#    Then Refresh current Page

    # Step 18
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds
    Then Delete "FleetManagementJob4" job
    Then Reset Time to get New Email

    #Step 19 Expected Result b
    Then Wait for Email to Receive On Email
    Then Verify no Content "SysData=>Driver_Name" in the email with Subject "Fleet Management Error"

    # Step 20
    Then Get Access token using "3586_GetAccessToken.json" and store in "Access_Token"
    Then Get Driver "SysData=>Driver_Name" Details using "Access_Token"
    Then Verify "SysData=>Driver_id" value is not empty

    #  Step 21 22 23 #Expected c
    Then Verify Key "Driver_fleet_id" with value "SysData=>Customer_Number"
    Then Verify Assertion for "Driver_time" contains "Date(yyyy-MM-dd)=>0"
    Then Verify Key "Driver_tsp_source" with value "samsara"
    Then Verify Key "Driver_name" with value "SysData=>Driver_Name"
    Then Verify Key "Driver_username" with value "SysData=>Driver_Username"
    Then Verify Key "Driver_phone" with value "13125555555"
    Then Verify Key "Driver_status" with value "active"
    Then Verify Key "Driver_notes" with value "From TMS- Username: SysData=>Driver_Username"
    Then Verify Key "Driver_TimeZone" with value "America/Chicago"

    Then Verify Key "Driver_carrier_Name" with value "Fleet Carrier One"
    Then Verify Key "Driver_dot_number" with value "0"
    Then Verify Key "Driver_license_number" with value "SysData=>CDL_Number_1"
    Then Verify Key "Driver_license_state" with value "IL"
    Then Verify Key "Driver_license_country" with value "US"
    Then Verify Key "Driver_work_rules.break" with value "Property (off-duty/sleeper)"
    Then Verify Key "Driver_work_rules.cycle" with value "USA Passenger (7/60)"
    Then Verify Key "Driver_work_rules.jurisdiction" with value ""
    Then Verify Key "Driver_work_rules.restart" with value "72-hour Restart"
    Then Verify Key "Driver_work_rules.shift" with value "US Interstate Property"

    # Step 24
    Then Navigate to stored URL for "Driver_Records"
    Then Wait for "3" Seconds
    Then Set "Updated_Username" value as "user+{currentDate=>MMddyyyy}"
    Then Set "CDL_Number_2" value as "3586+{currentDate=>MMddyyyy}"
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "Username"
    Then Update details
      | Username                  | Timezone         | Cycle Override       | Restart Override | Rest Break Override | Jurisdiction Override | Phone        | CDL #                 | CDL State/Province |
      | SysData=>Updated_Username | America/New_York | USA Property (7/60) | 24-Hour Restart  | None                | CT                    | 312-555-5555 | SysData=>CDL_Number_2 | NY                 |
    And Click on Native "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds

    #Step 25
    Then Refresh current Page
#    Then Open "TMS Admin" from App Launcher
#    Then Go to "Configuration" Tab
#    Then Switch to Frame by Title "accessibility title"
#    Then Scroll into Section "Fleet Management" -
#    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
#    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
#    Then Update details -
#      |Fleet Management Job Last Run|
#      |SysData=>FinalDate      |
#    And Click on Button with Value "Save" -
#    Then Verify Text displaying as "Save was successful." -
#    Then Switch to Parent Frame
#    Then Wait for "2" Seconds
#    Then Go to Home Page
#    Then Refresh current Page
#    Then Go to Home Page
#    Then Refresh current Page
#    Then Wait for "2" Seconds

    # Step 26
    Then Go to "Home" Tab
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds
    Then Delete "FleetManagementJob4" job

    # Step 27 - Refresh Catena driver data
    Then Get Driver "SysData=>Driver_Name" Details using "Access_Token"
    Then Verify "SysData=>Driver_id" value is not empty

    #  Step 28 Expected Result d
    Then Verify Key "Driver_fleet_id" with value "SysData=>Customer_Number"
    Then Verify Assertion for "Driver_time" contains "Date(yyyy-MM-dd)=>0"
    Then Verify Key "Driver_tsp_source" with value "samsara"
    Then Verify Key "Driver_name" with value "SysData=>Driver_Name"
    Then Verify Key "Driver_username" with value "SysData=>Driver_Username"
    Then Verify Key "Driver_phone" with value "13125555555"
    Then Verify Key "Driver_status" with value "active"
    Then Verify Key "Driver_notes" with value "From TMS- Username: SysData=>Updated_Username"
    Then Verify Key "Driver_TimeZone" with value "America/New_York"

    Then Verify Key "Driver_carrier_Name" with value "Fleet Carrier One"
    Then Verify Key "Driver_dot_number" with value "0"

    Then Verify Key "Driver_license_number" with value "SysData=>CDL_Number_2"
    Then Verify Key "Driver_license_state" with value "NY"
    Then Verify Key "Driver_license_country" with value "US"

    Then Verify Key "Driver_work_rules.break" with value "None"
    Then Verify Key "Driver_work_rules.cycle" with value "USA Property (7/60)"
    Then Verify Key "Driver_work_rules.jurisdiction" with value ""
    Then Verify Key "Driver_work_rules.restart" with value "24-hour Restart"
    Then Verify Key "Driver_work_rules.shift" with value "US Interstate Property"
