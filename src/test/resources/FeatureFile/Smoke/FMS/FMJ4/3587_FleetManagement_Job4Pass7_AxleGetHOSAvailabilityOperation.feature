Feature: 3587 - Fleet Management Job 4- Pass 7- AxleGetHOSAvailabilityOperation

  Background: Pre- Test
    Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"
    Then Delete Field with Title "AxleGetDriversOperation"
    Then Delete Field with Title "AxleGetHOSAvailabilityOperation"

#  @API @WEB @Regression  @smoke @FMS @SingleCurrency @3587 @Catena
  Scenario: 3587 - Fleet Management Job 4- Pass 7- AxleGetHOSAvailabilityOperation

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

    # Step 1.b
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
    Then Update details -
      | Fleet Management Pass Counter |
      |                               |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

     # Step 3
    Then Open "Drivers" from App Launcher
    Then Search and Select "Driver Three Five Eight Seven" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details -
      | ELD ID  | ELD Enabled | ELD Brand |
      | 4389365 | True        | Motive    |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Verify details for
      | ELD ID  |
      | 4389365 |
    Then Capture the current URL for "Driver_1"

    # Step 4
    Then Get "AxleGetDriversOperation-3587.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetDriversOperation-3587.txt"

    # Step 5
    Then Get "AxleGetFleetDataFromFleetCodeOperation-3587.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-3587.txt"

    # Step 6,7
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-3587.txt" with Title "AxleGetFleetDataFromFleetCodeOperation" and Description "200"
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

    # Step 8
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "1" Seconds

    # Step 9,10
    Given Upload File "U_AxleGetDriversOperation-3587.txt" with Title "AxleGetDriversOperation" and Description "200"
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


    # Step 11
    Then Get "AxleGetHOSAvailabilityOperation-3587a.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetHOSAvailabilityOperation-3587a.txt"

    # Step 12 ,13
    Given Upload File "U_AxleGetHOSAvailabilityOperation-3587a.txt" with Title "AxleGetHOSAvailabilityOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetHOSAvailabilityOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetHOSAvailabilityOperation" -
    Then Enter File Label "API Name" Text as "AxleGetHOSAvailabilityOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    # Step 14
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "3" Seconds

    # Step 15 Expected Result a
    Then Navigate to stored URL for "Driver_1"
    Then Wait for "3" Seconds
    Then Scroll into Section "HOS"
    Then Verify details for
      | Shift Time Remaining | Cycle Time Remaining | Time Until Break | Drive Time Remaining |
      | 7.95                 | 9.38                 | 4.58             | 6.58                 |

    # Step 16
    Then Delete Field with Title "AxleGetHOSAvailabilityOperation"
    Then Delete Field with Title "AxleGetHOSAvailabilityOperation"

    # Step 17
    Then Get "AxleGetHOSAvailabilityOperation-3587b.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetHOSAvailabilityOperation-3587b.txt"

    # Step 18 &19
    Given Upload File "U_AxleGetHOSAvailabilityOperation-3587b.txt" with Title "AxleGetHOSAvailabilityOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetHOSAvailabilityOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetHOSAvailabilityOperation" -
    Then Enter File Label "API Name" Text as "AxleGetHOSAvailabilityOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    # Not mentioned
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
    Then Update details -
      | Fleet Management Job Last Run |
      | SysData=>FinalDate            |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

     # Step 20
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "3" Seconds

    # Step 21 - Expected Result b
    Then Navigate to stored URL for "Driver_1"
    Then Wait for "3" Seconds
    Then Scroll into Section "HOS"
    Then Verify details for
      | Shift Time Remaining | Cycle Time Remaining | Time Until Break | Drive Time Remaining |
      | 5.17                 | 6.61                 | 0.00             | 3.81                 |