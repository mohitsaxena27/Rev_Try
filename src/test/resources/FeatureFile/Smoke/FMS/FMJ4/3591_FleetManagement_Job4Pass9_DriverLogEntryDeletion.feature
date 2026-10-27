Feature: 3591 - Fleet Management Job 4- Pass 9- Driver Log Entry Deletion AKR

  Background: Pre- Test
    Then Delete Field with Title "AxleGetDriverHOSLogsOperation"
    Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"

#  @API @Regression @WEB @smoke @FMS @SingleCurrency  @3591 @Catena
  Scenario: 3591 - Fleet Management Job 4- Pass 9- Driver Log Entry Deletion AKR

    When Login into Salesforce

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
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 3
    Then Open "Drivers" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "Driver Three Five Nine One" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID  | ELD Enabled | ELD Brand |
      | 5324660 | True        | Samsara   |
    And Click on Native "Save" button
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Verify Details
      | ELD ID  |
      | 5324660 |

    # Step 4
    Then Get "AxleGetFleetDataFromFleetCodeOperation-3591.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-3591.txt"

    # Step 5, 6
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-3591.txt" with Title "AxleGetFleetDataFromFleetCodeOperation" and Description "200"
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


    # Step 7
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job

    # Step 8 & 9
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Job Last Run |
      | -5                            |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 10
    Then Get "AxleGetDriverHOSLogsOperation2-3591a.txt" files and update below Attributes
      | {fleet_id}               | {CurrentDate-1} | {CurrentDate-3} | {CurrentDate-2} |
      | SysData=>Customer_Number | -1              | -3              | -2              |
    Then Save it with FileName "AxleGetDriverHOSLogsOperation2-3591a.txt"

    # Step 11 & 12 & 13
    Given Upload File "U_AxleGetDriverHOSLogsOperation2-3591a.txt" with Title "AxleGetDriverHOSLogsOperation" and Description "200"
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


    # Step 14
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Refresh current Page

    # Step 15
    Then Set "LogName" with "Driver Three Five Nine One - Date(yyyy-MM-dd)=>-1"
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "SysData=>LogName" from List
    Then Wait for "3" Seconds

    # Step 14
    Then Go to "Related" Tab
    Then Scroll into Section "Driver Log Entries"

    # Step 15 & Expected Result a
    Then Verify Table "Driver Log Entries" row count is "2"

    #Step 16
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Job Last Run |
      | -5                            |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 17
    Then Delete Field with Title "AxleGetDriverHOSLogsOperation"

    # Step 18
    Then Get "AxleGetDriverHOSLogsOperation2-3591b.txt" files and update below Attributes
      | {fleet_id}               | {CurrentDate-1} | {CurrentDate-3} | {CurrentDate-2} |
      | SysData=>Customer_Number | -1              | -3              | -2              |
    Then Save it with FileName "AxleGetDriverHOSLogsOperation2-3591b.txt"

    # Step 19 & 20
    Given Upload File "U_AxleGetDriverHOSLogsOperation2-3591b.txt" with Title "AxleGetDriverHOSLogsOperation" and Description "200"
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

    # Step 21
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Job Last Run |
      | -5                            |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 22
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job

    # Step 22
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "SysData=>LogName" from List
    Then Wait for "2" Seconds
    Then Go to "Related" Tab
    Then Scroll into Section "Driver Log Entries"
    Then Wait for "2" Seconds


    # Step 23 - Expected Result a
    Then Verify Table "Driver Log Entries" row count is "3"
    Then Click on link "Driver Log Entries"
    Then Wait for "2" Seconds
    Then Store Chicago date time with day offset -3 and time "1:07 PM" into "StartTime1"
    Then Store Chicago date time with day offset -3 and time "1:37 PM" into "EndTime1"
    Then Store Chicago date time with day offset -3 and time "2:08 PM" into "StartTime2"
    Then Store Chicago date time with day offset -3 and time "2:38 PM" into "EndTime2"
    Then Store Chicago date time with day offset -2 and time "1:07 PM" into "StartTime3"
    Then Store Chicago date time with day offset -2 and time "1:37 PM" into "EndTime3"

    Then Verify "Driver Log Entries" Table Details
      | Duration (Hours)| Start Time               | End Time |Status|
      | 0.50| SysData=>StartTime1   |  SysData=>EndTime1 |Driving|
      | 0.50 | SysData=>StartTime2   |  SysData=>EndTime2 |Driving    |
      | 0.50| SysData=>StartTime3   |  SysData=>EndTime3 |Driving   |
