Feature: 2438 - Fleet Management Job 2 - Pass 8 HOS & Fleet Code - AxleGetDriverHOSLogsOperation

  #  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @Catena @Motive @2438
  Scenario: 2438 - Fleet Management Job 2 - AxleGetDriverHOSLogsOperation (Asset Library)

    When Login into Salesforce

    #Step 1 - Disable Samsara
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    #Step 1.a) Note Customer Number (for steps 4,10,21)
    Then Search text "Catena" in the "Search Credentials..." search box
    Then Select the "Catena" record from the lookup field results
    Then Set Field Value "Customer Number" into "Customer_Number" Value

    #Step 2 - Configure Debugging & Fleet Management
    #Step 2.a – Debugging
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    Then Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Fleet Management" -

    #Step 2.b – Fleet Mgmt setup
    Then Select Fleet Management Job as "FleetManagementJob2"
    Then Update details -
      | Fleet Management Pass Counter |
      | 1                             |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 3 - Run initial job
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step4,1
    Then Get Access token using "2438_GetAccessToken.json" and store in "Access_token"

    #Step2
    Then Get Fleet Code using "Access_token" and for "samsara"

    #Step3 - Prepare and upload Fleet Code file
    Then Get "AxleGetFleetDataFromFleetCodeOperation-2438.txt" files and update below Attributes
      | {fleet_id}               | {fleet_code}       | {axle_tsp_id}     |
      | SysData=>Customer_Number | SysData=>FleetCode | SysData=>AxleID |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-2438.txt"

    #Step 4,5
    Then Upload File "U_AxleGetFleetDataFromFleetCodeOperation-2438.txt" with Title "AxleGetFleetDataFromFleetCodeOperation"

    #Step 6 - Increase pass counter to 3 and run
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 3                             |
    Then Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step7
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step8 - Update Driver ELD info
    Then Open "Drivers" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Thirty Eight" from List
    Then Scroll into Section "ELD Configuration"
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID  | ELD Brand |
      | 4389366 | Samsara   |
    And Click on Native "Save" button

    #Step9 - Prepare Asset file A and upload to Asset Library
    Then Get "AxleGetDriverHOSLogsOperation2-2438a.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetDriverHOSLogsOperation2-2438a.txt"

    #Step 10,11,12
    Given Upload File "U_AxleGetDriverHOSLogsOperation2-2438a.txt" with Title "AxleGetDriverHOSLogsOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetDriverHOSLogsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "API Name" Text as "AxleGetDriverHOSLogsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    #Step 13 - Set pass counter = 8 and run
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 8                             |
    Then Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 14
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "30" Seconds
    Then Refresh current Page
    #Step 15
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Thirty Eight - 2024-07-14" from List
    Then Wait for "3" Seconds

    #Expected A
    Then Scroll into Section "General Information"
    Then Verify details for
      | Start Time          | End Time            |
      | 7/14/2024, 12:00 AM | 7/14/2024, 11:59 PM |
    Then Scroll into Section "Day Summary"
    Then Verify details for
      | Active Duration | Driving Distance (Miles) | Driving Duration | Driving Distance (Kilometers) | On Duty Duration | Personal Conveyance Distance (mi) | Off Duty Duration | Personal Conveyance Distance (km) | Personal Conveyance Duration | Yard Move Distance (Miles) | Sleeper Berth Duration | Yard Move Distance (Kilometers) | Waiting Time Duration | Yard Move Duration |
      | 2.00            | 300.000                  | 6.00             | 482.803                       | 2.00             | 62.137                               | 12.00             | 100.000                                  | 0.00                         | 0.000                      | 0.00                   | 0.000                           | 0.00                  | 0.00               |

    Then Scroll into Section "Certification"
    Then Verify details for
      | Certification Status | Certified as of    |
      | Certified            | 7/14/2024, 2:06 AM |
    Then Verify Label Checkbox
      | Short Haul Exemption Active | Adverse Driving Exemption Claimed | Big Day Exemption Claimed |
      | false                       | false                             | false                     |

    #Step 16
    Then Go to "Related" Tab
    Then Click on "Log Entry" link for Start time "7/14/2024"

    #Expected B
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

    #Step17,18
    Then Navigate Browser Back
    Then Click on "Log Entry" link for Start time "7/15/2024"

    #Expected C
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

    # Step19 - Delete Asset A
    Then Delete Field with Title "AxleGetDriverHOSLogsOperation"

    # Step20 - Prepare Asset file B and upload
    Then Get "AxleGetDriverHOSLogsOperation2-2438b.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetDriverHOSLogsOperation2-2438b.txt"

   #Step21,22,23
    Given Upload File "U_AxleGetDriverHOSLogsOperation2-2438b.txt" with Title "AxleGetDriverHOSLogsOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetDriverHOSLogsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "API Name" Text as "AxleGetDriverHOSLogsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    #Step24
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step 25
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Thirty Eight - 2024-07-14" from List
    Then Wait for "3" Seconds

    # Expected D
    Then Scroll into Section "General Information"
    Then Verify details for
      | Start Time          | End Time            |
      | 7/14/2024, 12:00 AM | 7/14/2024, 11:59 PM |

    Then Scroll into Section "Day Summary"
    Then Verify details for
      | Active Duration | Driving Distance (Miles) | Driving Duration | Driving Distance (Kilometers) | On Duty Duration | Personal Conveyance Distance (mi) | Off Duty Duration | Personal Conveyance Distance (km) | Personal Conveyance Duration | Yard Move Distance (Miles) | Sleeper Berth Duration | Yard Move Distance (Kilometers) | Waiting Time Duration | Yard Move Duration |
      | 2.00            | 300.000                  | 6.00             | 482.803                       | 2.00             | 62.137                               | 12.00             | 100.000                                  | 0.00                         | 0.000                      | 0.00                   | 0.000                           | 0.00                  | 0.00               |

    Then Scroll into Section "Certification"
    Then Verify details for
      | Certification Status | Certified as of    |
      | Certified            | 7/14/2024, 2:06 AM |
    Then Verify Label Checkbox
      | Adverse Driving Exemption Claimed | Big Day Exemption Claimed |
      | false                             | false                     |

    #Step26
    Then Go to "Related" Tab
    Then Click on "Log Entry" link for Start time "7/14/2024"

    #Expected E
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

    #Step27,28
    Then Navigate Browser Back
    Then Click on "Log Entry" link for Start time "7/15/2024"

    #Expected F
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

    #Step29
    Then Open "Driver Logs" from App Launcher
    Then Search and Select "QA Driver Two Thousand Four Hundred Thirty Eight - 2024-07-15" from List
    Then Wait for "3" Seconds

    # Expected G
    Then Scroll into Section "General Information"
    Then Verify details for
      | Start Time          | End Time            |
      | 7/15/2024, 12:00 AM | 7/15/2024, 11:59 PM |

    Then Scroll into Section "Day Summary"
    Then Verify details for
      | Active Duration | Driving Distance (Miles) | Driving Duration | Driving Distance (Kilometers) | On Duty Duration | Personal Conveyance Distance (mi) | Off Duty Duration | Personal Conveyance Distance (km) | Personal Conveyance Duration | Yard Move Distance (Miles) | Sleeper Berth Duration | Yard Move Distance (Kilometers) | Waiting Time Duration | Yard Move Duration |
      | 4.58            | 261.597                  | 8.78             | 421.000                       | 4.78             | 100.000                              | 9.22              | 160.934                                  | 1.00                         | 0.621                      | 7.00                   | 1.000                           | 0.73                  | 1.58               |

    Then Scroll into Section "Certification"
    Then Verify details for
      | Certification Status | Certified as of |
      | Pending              | NA              |
    Then Verify Label Checkbox
      | Short Haul Exemption Active | Adverse Driving Exemption Claimed | Big Day Exemption Claimed |
      | true                        | true                              | false                     |

    #Step30,31
    Then Go to "Related" Tab
    Then Click on "Log Entry" link for Start time "7/15/2024"

    #Expected H
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
      | Status | Geolocation          | Duration (Hours) | Comments                      |
      | NA     | 41.25716, -95.995102 | 0.50             | In the yard, waiting on shunt |

    Then Navigate Browser Back

    #Step32,33
    Then Click on "Log Entry" link for Start time "7/16/2024"

    #Expected F
    Then Scroll into Section "General Information"
    Then Set Log entry date as "7/16/2024, 6:06 AM" for "Start Time"
    Then Set Log entry date as "7/16/2024, 6:41 AM" for "End Time"
    Then Verify details for
      | Start Time          | End Time          | Batch ID          |
      | SysData=>Start Time | SysData=>End Time | SysData=>Batch ID |
    Then Scroll into Section "HOS Entry"
    Then Verify details for
      | Status | Geolocation            | Duration (Hours) | Comments |
      | NA     | 38.412279, -104.413179 | 0.58             | NA       |