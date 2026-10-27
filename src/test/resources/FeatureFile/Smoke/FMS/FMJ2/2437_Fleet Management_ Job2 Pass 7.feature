
Feature: 2437 - Fleet Management Job 2 - Pass 7 - AxleGetHOSAvailabilityOperation

  #  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @Catena @Motive @2437
  Scenario: 2437 - Fleet Management Job 2 - Pass 7 - AxleGetHOSAvailabilityOperation

    When Login into Salesforce

#    # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    # Step 1.a)
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    Then Set Field Value "Customer Number" into "Customer_Number" Value

#    # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    Then Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Fleet Management" -

    # Step 2.b – Fleet Mgmt setup
    Then Select Fleet Management Job as "FleetManagementJob2"
    Then Update details -
      | Fleet Management Pass Counter |
      | 1                             |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 3 – Update Driver fields
    Then Open "Drivers" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Thirty Seven" from List
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details -
      | ELD ID    | ELD Brand |
      | 4389365   | Motive    |
    And Click on Native "Save" button
    Then Scroll into Section "ELD Configuration"
    Then Verify "ELD ID" having value of "4389365"


    # Step 4 – Run job
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    # Step 5 – Update AxleGetDriversOperation-2437
    Then Get "AxleGetDriversOperation-2437.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetDriversOperation-2437.txt"

    # Step 6 – Update AxleGetFleetDataFromFleetCodeOperation-2437
    Then Get "AxleGetFleetDataFromFleetCodeOperation-2437.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-2437.txt"

    # Step 7,8 – Upload updated files
    Then Upload File "U_AxleGetDriversOperation-2437.txt" with Title "AxleGetDriversOperation"
#    Then Upload File "U_AxleGetFleetDataFromFleetCodeOperation-2437.txt" with Title "AxleGetFleetDataFromFleetCodeOperation"
    Then Upload File "U_AxleGetFleetDataFromFleetCodeOperation-2437.txt" with Title "AxleGetFleetDataFromFleetCodeOperation" and Description "200"

    # Step 9 – Increase Pass Counter to 3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 3                             |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 10 – Run job again
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job

    # Step 11, 12 – Update AxleGetHOSAvailabilityOperation-2437a
    Then Get "AxleGetHOSAvailabilityOperation-2437a.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetHOSAvailabilityOperation-2437a.txt"

    # Step 13,14  15– Upload Asset Library file 2437a
#    Given Upload File "U_AxleGetHOSAvailabilityOperation-2437a.txt" with Title "AxleGetHOSAvailabilityOperation"
    Given Upload File "U_AxleGetHOSAvailabilityOperation-2437a.txt" with Title "AxleGetHOSAvailabilityOperation" and Description "200"
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

#    # Step 16 – Increase Pass Counter to 7
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 7                             |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 17 – Run job
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds
    Then Refresh current Page
    # Step 18 – Verify Expected Result (a)
    Then Open "Drivers" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Thirty Seven" from List
    Then Scroll into Section "HOS"
    Then Verify details for
      | Shift Time Remaining | Cycle Time Remaining | Time Until Break | Drive Time Remaining |
      | 7.95                 | 9.38                 | 4.58             | 6.58                  |

    # Step 19 – Delete previous operation file
    Then Delete Field with Title "AxleGetHOSAvailabilityOperation"

#    # Step 20 – Update 2437b new file
    Then Get "AxleGetHOSAvailabilityOperation-2437b.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetHOSAvailabilityOperation-2437b.txt"

    # Step 21,23 – Upload new Asset Library file 2437b
#    Given Upload File "U_AxleGetHOSAvailabilityOperation-2437b.txt" with Title "AxleGetHOSAvailabilityOperation"
    Given Upload File "U_AxleGetHOSAvailabilityOperation-2437b.txt" with Title "AxleGetHOSAvailabilityOperation" and Description "200"
    Then Go to Home Page
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetHOSAvailabilityOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetDriverHOSLogsOperation" -
    Then Enter File Label "API Name" Text as "AxleGetDriverHOSLogsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    # Step 24 – Run job again
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds
    Then Refresh current Page
    # Step 25 – Verify Expected Result (b)
    Then Open "Drivers" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Thirty Seven" from List
    Then Scroll into Section "HOS"
    Then Verify details for
      | Shift Time Remaining | Cycle Time Remaining | Time Until Break | Drive Time Remaining |
      | 5.17                 | 6.61                 | 0.00             | 3.81                  |

