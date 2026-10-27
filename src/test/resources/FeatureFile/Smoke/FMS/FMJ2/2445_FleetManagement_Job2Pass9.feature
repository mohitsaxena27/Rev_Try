Feature: 2445 - Fleet Management Job 2- Pass 9- Driver Log Entry Deletion
  Background: Pre- Test
    Then Delete Field with Title "AxleGetDriverHOSLogsOperation"
    Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"

  #  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @Catena @Motive @2445
  Scenario: 2445 - Fleet Management Job 2- Pass 9- Driver Log Entry Deletion

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

    #Step 1.a)
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    Then Set Field Value "Customer Number" into "Customer_Number" Value

    #Step2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"

    #Step 2.a)
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Fleet Management" -

    #Step 2.b)
    Then Select Fleet Management Job as "FleetManagementJob2"
    Then Update details -
      | Fleet Management Pass Counter |
      | 1                             |

    #Step 2.c)
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 3
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    #Step 4
    Then Get "AxleGetFleetDataFromFleetCodeOperation-2445.txt" files and update below Attributes
      | {fleet_id}                 |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-2445.txt"

    #Step 5,6 & 7
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-2445.txt" with Title "AxleGetFleetDataFromFleetCodeOperation"

    #Step 8
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

    #Step 9
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    #Step 10
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |Fleet Management Job Last Run|
      | 8                             |-5                           |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 11 & 12
    Then Get "AxleGetDriverHOSLogsOperation2-2445a.txt" files and update below Attributes
      | {fleet_id}                 |{CurrentDate-1}|{CurrentDate-3}|{CurrentDate-2}|
      | SysData=>Customer_Number   |-1             |-3             |-2             |
    Then Save it with FileName "AxleGetDriverHOSLogsOperation2-2445a.txt"

     #Step 13, 14 , 15, 16 , 18, 19 & 20
    Given Upload File "U_AxleGetDriverHOSLogsOperation2-2445a.txt" with Title "AxleGetDriverHOSLogsOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetDriverHOSLogsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetDriverHOSLogsOperation" -
    Then Enter File Label "API Name" Text as "AxleGetDriverHOSLogsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    #Step 20
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "5" Seconds

    #Step 21
    Then Set "LogName" with "QA Driver Two Thousand Four Hundred Forty Five - Date(yyyy-MM-dd)=>-1"
    Then Wait for "45" Seconds
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "SysData=>LogName" from List
    Then Wait for "1" Seconds
    Then Set Key "DriverLog" page Record Id with "rtms__DriverLog__c"

    Then Go to "Related" Tab
    Then Verify Table "Driver Log Entries" row count is "2"

    #Step 22
    Then Delete Field with Title "AxleGetDriverHOSLogsOperation"

    #Step 23 & 24
    Then Get "AxleGetDriverHOSLogsOperation2-2445b.txt" files and update below Attributes
      | {fleet_id}                 |{CurrentDate-1}|{CurrentDate-3}|{CurrentDate-2}|
      | SysData=>Customer_Number   |-1             |-3             |-2             |
    Then Save it with FileName "AxleGetDriverHOSLogsOperation2-2445b.txt"

     #Step 25, 26 , 27 & 28
    Given Upload File "U_AxleGetDriverHOSLogsOperation2-2445b.txt" with Title "AxleGetDriverHOSLogsOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetDriverHOSLogsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetDriverHOSLogsOperation" -
    Then Enter File Label "API Name" Text as "AxleGetDriverHOSLogsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    #Step 29
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      |                               |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame


    #Step 30 & 31
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step 32
    Then Verify and Delete "FleetManagementJob2" from Scheduled Jobs

    #Step 33
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "SysData=>LogName" from List
    Then Wait for "1" Seconds
    Then Go to "Related" Tab
    Then Verify Table "Driver Log Entries" row count is "3"

    Then Verify Table data for Log With Time
         |DaysAgo| Start Time              | End Time            |
         |3      | 1:08 PM                | 1:38 PM               |
         |3      | 12:07 PM               | 12:37 PM             |
         |2      | 12:07 PM               | 12:37 PM             |