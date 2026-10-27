Feature: 2433 - Fleet Management Job 2- Pass 5- AxleGetVehicleLocationsOperation

  #  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @Catena @Motive @2433
  Scenario: 2433 - Fleet Management Job 2- Pass 5- AxleGetVehicleLocationsOperation

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
    Then Switch to Parent Frame

    #Step 3
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step 4
    Then Get "AxleGetVehicleLocationsOperation-2433a.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetVehicleLocationsOperation-2433a.txt"

    #Step 5
    Then Get "AxleGetFleetDataFromFleetCodeOperation-2433.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-2433.txt"

    #Step 6 & 7
    Given Upload File "U_AxleGetVehicleLocationsOperation-2433a.txt" with Title "AxleGetVehicleLocationsOperation"

    #Step 6 & 8
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-2433.txt" with Title "AxleGetFleetDataFromFleetCodeOperation"

    #Step 9
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 3                             |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 10
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step 11
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter | Fleet Management Job Last Run |
      | 5                             | 1/1/2024 1:00 AM              |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 12
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "Tractor Two Thousand Four Hundred Thirty Three" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "ELD Information"
    Then Click on Edit icon on Label "ELD Last Update"
    Then Update details
      | Date_2 |
      |        |
    Then Click on Native "Save" button
    Then Wait for "3" Seconds

    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step 13
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "Tractor Two Thousand Four Hundred Thirty Three" from List
    Then Wait for "3" Seconds

    #Expected 13.a)
    Then Scroll into Section "Odometer Information"
    Then Verify details for
      | Last Odometer Reading | Odometer Unit | Last Location Change |
      | 1,397,491             | Miles         | NA                   |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD Last Update   | Current Location     | Geolocation          | Speed (mph) | Speed (kph) |
      | 7/8/2024, 3:15 AM | Omaha, Nebraska, USA | 41.25716, -95.995102 | 69.59       | 112.00      |

    #Step 14
    Then Delete Field with Title "AxleGetVehicleLocationsOperation"

    #Step 15
    Then Get "AxleGetVehicleLocationsOperation-2433b.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetVehicleLocationsOperation-2433b.txt"

    #Sep 16
    Given Upload File "U_AxleGetVehicleLocationsOperation-2433b.txt" with Title "AxleGetVehicleLocationsOperation"

    #Step 17
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step 18
    Then Open "Fleet Assets" from App Launcher
    Then Select Records "Tractor Two Thousand Four Hundred Thirty Three" from List
    Then Wait for "3" Seconds

    #Expected 18.b)
    Then Scroll into Section "Odometer Information"
    Then Get Details
      | Last Location Change |
      |                      |
    Then Verify details for
      | Last Odometer Reading | Odometer Unit | Last Location Change          |
      | 1,398,111             | Miles         | SysData=>Last Location Change |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD Last Update   | Current Location    | Geolocation            | Speed (mph) | Speed (kph) |
      | 7/9/2024, 3:10 AM | Tomahawk Truck Stop | 38.412279, -104.413179 | 55.00       | 88.51       |