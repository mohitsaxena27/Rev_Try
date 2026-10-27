Feature: 2409 - Fleet Management Job 2- Pass 4- Sync Fleet Assets

#  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @2409 @Catena @Motive
  Scenario: 2409 - Fleet Management Job 2- Pass 4- Sync Fleet Assets

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
    Then Wait for "2" Seconds
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
    Then Switch to Parent Frame
    #Step 3
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step 4
    Then Get "AxleGetFleetDataFromFleetCodeOperation-2409.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-2409.txt"

    #Step 5 & 6.a
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-2409.txt" with Title "AxleGetFleetDataFromFleetCodeOperation"
#
#    #Step 7
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 3                             |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 8
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

#**************************************************************
    #Step 9
    Then Get Access token using "2409_GetAccessToken.json" and store in "Access_Token"

   #Step 10 & 11
#    Then Get Fleet Code using "Access_Token"
    Then Get Fleet Code using "Access_Token" for Fleet ID "SysData=>Customer_Number"

   #Step 12, 1 and 2
    Then Set "VIN" value as "VIN+{currentDate=>MMddyyyyhhmm}+VN"
    Then Set "name" value as "{currentDate=>MMddyyhhmm}"
    Then Set "license_plate_number" value as "{currentDate=>MMddyyhhmm}"

    Then Update payload on "2409_Vehicle_RequestBody.json"
      | Customer_Number          | AxleID          | Name          | VIN          | License_plate_number          |
      | SysData=>Customer_Number | SysData=>AxleID | SysData=>name | SysData=>VIN | SysData=>license_plate_number |

    Then Create a Vehicle using updated payload
#**************************************************************

    #Step 3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 4                             |
    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
    Then Update details -
      |Fleet Management Job Last Run|
      |SysData=>FinalDate      |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #Step 4
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "30" Seconds
    Then Refresh current Page
    Then Wait for "2" Seconds
    #Step 5
    Then Open "Fleet Assets" from App Launcher
    Then Wait for "2" Seconds
    Then Search and Select "SysData=>name" from List
    Then Wait for "3" Seconds

    #Expected a)
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name | Year | Vehicle Make | Vehicle Model | VIN          | License Plate Number          |
      | Tractor | Fleet Carrier One | Available | SysData=>name    | 2021 | Peterbilt    | 389           | SysData=>VIN | SysData=>license_plate_number |

    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID      | ELD Brand | ELD Serial Number |
      | SysData=>ID | Motive    | NA                |

#*************************************************************
    #Step 6 & 7
    Then Get Fleet details using "SysData=>fleet_id"

   # Expected b)
    Then Search "QA2409ELD" doesn't present in response
    Then Search "QA2409VIN" doesn't present in response
#*************************************************************
  #Step 8 & 9 a,b,c,d

    Then Get "AxleGetVehiclesOperation-2409scenario2.txt" files and update below Attributes
      | {fleet_id}               | ID          | {VIN}        |
      | SysData=>Customer_Number | SysData=>ID | SysData=>VIN |
    Then Save it with FileName "AxleGetVehiclesOperation-2409scenario2.txt"

  #Step 10, 11, 12
 #   Then Upload File "AxleGetVehiclesOperation-2409scenario2.txt" in Asset Library with Title "AxleGetVehiclesOperation"
    Given Upload File "U_AxleGetVehiclesOperation-2409scenario2.txt" with Title "AxleGetVehiclesOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetVehiclesOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetVehiclesOperation" -
    Then Enter File Label "API Name" Text as "AxleGetVehiclesOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

  #Step13
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

  #Step14
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "SysData=>name" from List
    Then Wait for "3" Seconds

  #Expected C
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name | Year | Vehicle Make | Vehicle Model | VIN          | License Plate Number          |
      | Tractor | Fleet Carrier One | Available | SysData=>name    | 2021 | Peterbilt    | 389           | SysData=>VIN | SysData=>license_plate_number |

    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID     | ELD Brand | ELD Serial Number |
      | ELD2409VIN | Motive    | DEVICE2           |

  #Step15
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID      |
      | SysData=>ID |
    And Click on Native "Save" button

  #Step16
    Then Delete Field with Title "AxleGetVehiclesOperation"

  #Step17
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

  #Step18
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "SysData=>name" from List
    Then Wait for "3" Seconds

  #Expected D
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name | Year | Vehicle Make | Vehicle Model | VIN          | License Plate Number          |
      | Tractor | Fleet Carrier One | Available | SysData=>name    | 2021 | Peterbilt    | 389           | SysData=>VIN | SysData=>license_plate_number |

    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID      | ELD Brand | ELD Serial Number |
      | SysData=>ID | Motive    | NA                |

  #Step 19 & 20
    Then Get "AxleGetVehiclesOperation-2409scenario4.txt" files and update below Attributes
      | {fleet_id}               | ID          |
      | SysData=>Customer_Number | SysData=>ID |
    Then Save it with FileName "AxleGetVehiclesOperation-2409scenario4.txt"

  #Step 21, 22, 23
    Given Upload File "U_AxleGetVehiclesOperation-2409scenario4.txt" with Title "AxleGetVehiclesOperation" and Description "200"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetVehiclesOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetVehiclesOperation" -
    Then Enter File Label "API Name" Text as "AxleGetVehiclesOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

  #Step 24
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

  #Step 25
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "QA2409VIN" from List
    Then Wait for "3" Seconds

  #Expected e
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name | Year | Vehicle Make | Vehicle Model | VIN     | License Plate Number | License Plate State |
      | Tractor | Fleet Carrier One | Available | QA2409VIN        | 2021 | Kenworth     | T680          | 2409VIN | 2409PL1              | IL                  |

    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID   | ELD Brand | ELD Serial Number |
      | 2409ELD2 | Motive    | DEVICE2409        |

  #Step 26
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "QA2409ELD" from List
    Then Wait for "3" Seconds

  #Expected f
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name | Year | Vehicle Make | Vehicle Model | VIN      | License Plate Number |
      | Tractor | Fleet Carrier One | Available | QA2409ELD        | 2022 | Kenworth     | W900          | 2409VIN2 | 2409PL2              |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID | ELD Brand | ELD Serial Number |
      | NA     | NA        | NA                |