Feature: 3590 - Fleet Management Job 4- Pass 8- AxleGetDriverHOSLogsOperation Scheduled AKR

  Background: Pre- Test
    Then Delete Field with Title "AxleGetDriverHOSLogsOperation"
    Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"

#  @API @Regression @WEB @smoke @FMS @SingleCurrency @3590 @Catena
  Scenario: 3590 - Fleet Management Job 4- Pass 8- AxleGetDriverHOSLogsOperation Scheduled AKR

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

    # Step 3 to Step 7
    Then Get Access token using "3590_GetAccessToken.json" and store in "Access_Token"
    Then Get Fleet Code using "Access_Token" for Fleet ID "SysData=>Customer_Number"

    # Step 8
    Then Get "AxleGetFleetDataFromFleetCodeOperation-3590.txt" files and update below Attributes
      | {fleet_id}               | {fleet_code}        | {axle_tsp_id}   |
      | SysData=>Customer_Number | SysData=>fleet_code | SysData=>Samsara_AxleID |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-3590.txt"

    # Step 9,10
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-3590.txt" with Title "AxleGetFleetDataFromFleetCodeOperation"
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

     # Step 11
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job

    #Step 12 & 13 & 14
    Then Get Driver "Driver Three Five Nine Zero" Details using "Access_Token"

    #Step 15
    Then Open "Drivers" from App Launcher
    Then Search and Select "Driver Three Five Nine Zero" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID             | ELD Enabled | ELD Brand |
      | SysData=>Driver_id | True        | Samsara   |
    And Click on Native "Save" button
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Configuration"
    Then Verify details for
      | ELD ID             |
      | SysData=>Driver_id |

    # Step 16
    Then Get "AxleGetDriverHOSLogsOperation2-3590a.txt" files and update below Attributes
      | {fleet_id}               |  {driver_id}        |
      | SysData=>Customer_Number |  SysData=>Driver_id |
    Then Save it with FileName "AxleGetDriverHOSLogsOperation2-3590a.txt"

    # Step 17,18
    Given Upload File "U_AxleGetDriverHOSLogsOperation2-3590a.txt" with Title "AxleGetDriverHOSLogsOperation" and Description "200"

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

    # Step 19
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Job Last Run |
      | -1                            |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Refresh current Page

    #Step 20
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "10" Seconds
    Then Refresh current Page

    # Step 21 # Expected Result A
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "Driver Three Five Nine Zero - 2024-07-14" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "General Information"
    Then Verify details for
      | Start Time          | End Time            |
      | 7/14/2024, 12:00 AM | 7/14/2024, 11:59 PM |
    Then Scroll into Section "Day Summary"
    Then Verify details for
      | Active Duration | Driving Distance (Miles) | Driving Duration | Driving Distance (Kilometers) | On Duty Duration | Personal Conveyance Distance (mi) | Off Duty Duration | Personal Conveyance Distance (km) | Personal Conveyance Duration | Yard Move Distance (Miles) | Sleeper Berth Duration | Yard Move Distance (Kilometers) | Waiting Time Duration | Yard Move Duration |
      | 2.00            | 300.000                  | 6.00             | 482.803                       | 2.00             | 62.137                            | 12.00             | 100.000                         | 0.00                         | 0.000                      | 0.00                   | 0.000                           | 0.00                  | 0.00               |
    Then Scroll into Section "Certification"
    Then Set Log entry date as "7/14/2024, 2:06 AM" for "Certified_as_of"
    Then Verify details for
      | Certification Status | Certified as of    |
      | Certified            | SysData=>Certified_as_of |
    Then Verify Label Checkbox
      | Short Haul Exemption Active | Adverse Driving Exemption Claimed | Big Day Exemption Claimed |
      | false                       | false                             | false                     |

    # Step 22 # Expected Result B
    Then Go to "Related" Tab
    Then Click on "Log Entry" link for Start time "7/14/2024"
    Then Scroll into Section "General Information"
    Then Set Log entry date as "7/14/2024, 2:08 PM" for "Start Time"
    Then Set Log entry date as "7/14/2024, 2:38 PM" for "End Time"
    Then Verify details for
      | Start Time          | End Time          |
      | SysData=>Start Time | SysData=>End Time |
    Then Get Details
      | Batch ID |
      |          |
    Then Scroll into Section "HOS Entry"
    Then Verify details for
      | Status  | Geolocation          | Duration (Hours) | Comments           |
      | Driving | 41.25716, -95.995102 | 0.50             | Going to warehouse |

    # Step 23  # Expected Result C
    Then Navigate Browser Back
    Then Click on "Log Entry" link for Start time "7/15/2024"
    Then Scroll into Section "General Information"
    Then Set Log entry date as "7/15/2024, 2:08 PM" for "Start Time"
    Then Set Log entry date as "7/15/2024, 2:38 PM" for "End Time"
    Then Verify details for
      | Start Time          | End Time          | Batch ID          |
      | SysData=>Start Time | SysData=>End Time | SysData=>Batch ID |
    Then Scroll into Section "HOS Entry"
    Then Verify details for
      | Status  | Geolocation            | Duration (Hours) | Comments              |
      | Driving | 38.412279, -104.413179 | 0.50             | Arriving at truckstop |

    # Step 24
    Then Delete Field with Title "AxleGetDriverHOSLogsOperation"

    # Step 25
    Then Get "AxleGetDriverHOSLogsOperation2-3590b.txt" files and update below Attributes
      | {fleet_id}               | {id}               | {driver_id}        |
      | SysData=>Customer_Number | SysData=>Driver_id | SysData=>Driver_id |
    Then Save it with FileName "AxleGetDriverHOSLogsOperation2-3590b.txt"

    # Step 26,27
    Given Upload File "U_AxleGetDriverHOSLogsOperation2-3590b.txt" with Title "AxleGetDriverHOSLogsOperation" and Description "200"
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

    # Step 28
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Job Last Run |
      | -1                            |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Refresh current Page

    #Step 29
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "10" Seconds
    Then Refresh current Page

    # Step 30 # Expected Result D
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "Driver Three Five Nine Zero - 2024-07-14" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "General Information"
    Then Verify details for
      | Start Time          | End Time            |
      | 7/14/2024, 12:00 AM | 7/14/2024, 11:59 PM |
    Then Scroll into Section "Day Summary"
    Then Verify details for
      | Active Duration | Driving Distance (Miles) | Driving Duration | Driving Distance (Kilometers) | On Duty Duration | Personal Conveyance Distance (mi) | Off Duty Duration | Personal Conveyance Distance (km) | Personal Conveyance Duration | Yard Move Distance (Miles) | Sleeper Berth Duration | Yard Move Distance (Kilometers) | Waiting Time Duration | Yard Move Duration |
      | 2.00            | 300.000                  | 6.00             | 482.803                       | 2.00             | 62.137                            | 12.00             | 100.000                         | 0.00                         | 0.000                      | 0.00                   | 0.000                           | 0.00                  | 0.00               |
    Then Scroll into Section "Certification"
    Then Set Log entry date as "7/14/2024, 2:06 AM" for "Certified_as_of"

    Then Verify details for
      | Certification Status | Certified as of    |
      | Certified            | SysData=>Certified_as_of |
    Then Verify Label Checkbox
      | Short Haul Exemption Active | Adverse Driving Exemption Claimed | Big Day Exemption Claimed |
      | false                       | false                             | false                     |

    # Step 31,32 # Expected Result E ,G
    Then Go to "Related" Tab
    Then Click on "Log Entry" link for Start time "7/14/2024"
    Then Scroll into Section "General Information"
    Then Set Log entry date as "7/14/2024, 2:08 PM" for "Start Time"
    Then Set Log entry date as "7/14/2024, 2:38 PM" for "End Time"
    Then Verify details for
      | Start Time          | End Time          | Batch ID          |
      | SysData=>Start Time | SysData=>End Time | SysData=>Batch ID |
    Then Scroll into Section "HOS Entry"
    Then Verify details for
      | Status  | Geolocation          | Duration (Hours) | Comments           |
      | Driving | 41.25716, -95.995102 | 0.50             | Going to warehouse |

     # Expected Result F
    Then Navigate Browser Back
    Then Click on "Log Entry" link for Start time "7/15/2024"
    Then Scroll into Section "General Information"
    Then Set Log entry date as "7/15/2024, 2:08 PM" for "Start Time"
    Then Set Log entry date as "7/15/2024, 2:38 PM" for "End Time"
    Then Verify details for
      | Start Time          | End Time          | Batch ID          |
      | SysData=>Start Time | SysData=>End Time | SysData=>Batch ID |
    Then Scroll into Section "HOS Entry"
    Then Verify details for
      | Status  | Geolocation            | Duration (Hours) | Comments              |
      | Driving | 38.412279, -104.413179 | 0.50             | Arriving at truckstop |

   # Expected Result G
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "Driver Three Five Nine Zero - 2024-07-15" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "General Information"
    Then Verify details for
      | Start Time          | End Time            |
      | 7/15/2024, 12:00 AM | 7/15/2024, 11:59 PM |
    Then Scroll into Section "Day Summary"
    Then Verify details for
      | Active Duration | Driving Distance (Miles) | Driving Duration | Driving Distance (Kilometers) | On Duty Duration | Personal Conveyance Distance (mi) | Off Duty Duration | Personal Conveyance Distance (km) | Personal Conveyance Duration | Yard Move Distance (Miles) | Sleeper Berth Duration | Yard Move Distance (Kilometers) | Waiting Time Duration | Yard Move Duration |
      | 4.58            | 261.597                  | 8.78             | 421.000                       | 4.78             | 100.000                           | 9.22              | 160.934                         | 1.00                         | 0.621                      | 7.00                   | 1.000                           | 0.73                  | 1.58               |
    Then Scroll into Section "Certification"
    Then Verify details for
      | Certification Status | Certified as of |
      | Pending              | NA              |
    Then Verify Label Checkbox
      | Short Haul Exemption Active | Adverse Driving Exemption Claimed | Big Day Exemption Claimed |
      | true                        | true                              | false                     |

    # Step 33 # Expected Result H
    Then Go to "Related" Tab
    Then Click on "Log Entry" link for Start time "7/15/2024"
    Then Scroll into Section "General Information"
    Then Set Log entry date as "7/15/2024, 3:18 PM" for "Start Time"
    Then Set Log entry date as "7/15/2024, 3:48 PM" for "End Time"
    Then Verify details for
      | Start Time          | End Time          |
      | SysData=>Start Time | SysData=>End Time |
    Then Get Details
      | Batch ID |
      |          |
    Then Verify details for
      | Batch ID          |
      | SysData=>Batch ID |
    Then Scroll into Section "HOS Entry"
    Then Verify details for
      | Status        | Geolocation          | Duration (Hours) | Comments                      |
      | No Status     | 41.25716, -95.995102 | 0.50             | In the yard, waiting on shunt |

    # Step 34  # Expected Result I
    Then Navigate Browser Back
    Then Click on "Log Entry" link for Start time "7/16/2024"
    Then Scroll into Section "General Information"
    Then Set Log entry date as "7/16/2024, 6:06 AM" for "Start Time"
    Then Set Log entry date as "7/16/2024, 6:41 AM" for "End Time"
    Then Verify details for
      | Start Time          | End Time          | Batch ID          |
      | SysData=>Start Time | SysData=>End Time | SysData=>Batch ID |
    Then Scroll into Section "HOS Entry"
    Then Verify details for
      | Status        | Geolocation            | Duration (Hours) | Comments |
      | No Status     | 38.412279, -104.413179 | 0.58             | NA       |