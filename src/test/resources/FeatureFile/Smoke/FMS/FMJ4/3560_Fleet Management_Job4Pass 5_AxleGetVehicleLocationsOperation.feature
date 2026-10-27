Feature: 3560 - Fleet Management Job 4- Pass 5- AxleGetVehicleLocationsOperation AKR

  Background: Pre- Test
    Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"
    Then Delete Field with Title "AxleGetVehicleLocationsOperation"

#  @API  @Regression  @smoke @FMS @SingleCurrency  @3560 @Catena @WEB @Debugging
  Scenario: 3560 - Fleet Management Job 4- Pass 5- AxleGetVehicleLocationsOperation AKR

    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
     #Step 1a
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    #Step 1b
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
    Then Select Fleet Management Job as "FleetManagementJob4"
    Then Update details -
      | Fleet Management Pass Counter |
      |                               |
    #Step 2.c
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 3
    Then Get "AxleGetFleetDataFromFleetCodeOperation-3560.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-3560.txt"

    Then Get "AxleGetVehicleLocationsOperation-3560a.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetVehicleLocationsOperation-3560a.txt"

     #Step 5,6, 7, 8
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-3560.txt" with Title "AxleGetFleetDataFromFleetCodeOperation"
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

    Given Upload File "U_AxleGetVehicleLocationsOperation-3560a.txt" with Title "AxleGetVehicleLocationsOperation"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetVehicleLocationsOperation" -
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetVehicleLocationsOperation" -
    Then Enter File Label "API Name" Text as "AxleGetVehicleLocationsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

     #Step 9
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds

    #Step 10
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Job Last Run |
      | 1/1/2024 12:00 AM             |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

   #Step 11
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "1" Seconds

    #Step 12
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "T THREESIXSIX-ZERO" from List
    Then Wait for "3" Seconds
    Then Capture the current URL for "Fleet_Asset_1"

    #Expected 12.a)
    Then Scroll into Section "Odometer Information"
    Then Verify details for
      | Last Odometer Reading | Odometer Unit | Last Location Change |
      | 1,397,491             | Miles         | NA                   |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD Last Update   | Current Location     | Geolocation          | Speed (mph) | Speed (kph) |
      | 7/8/2024, 3:15 AM | Omaha, Nebraska, USA | 41.25716, -95.995102 | 69.59       | 112.00      |

    #Step13
    Then Delete Field with Title "AxleGetVehicleLocationsOperation"

    #Step 14
    Then Get "AxleGetVehicleLocationsOperation-3560b.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetVehicleLocationsOperation-3560b.txt"

    #Step 15,16
    Given Upload File "U_AxleGetVehicleLocationsOperation-3560b.txt" with Title "AxleGetVehicleLocationsOperation"
    Then Open "Files" from App Launcher
    Then Go to "Libraries" Tab
    Then Click on button with Title "Asset Library"
    Then Wait for "1" Seconds
    Then Click on "Upload Asset File" with Text
    Then Click on button with Title "AxleGetVehicleLocationsOperation"
    Then Click on "Add" with Text -
    Then Wait for "2" Seconds
    Then Enter File Label "Asset File Name" Text as "AxleGetVehicleLocationsOperation" -
    Then Enter File Label "API Name" Text as "AxleGetVehicleLocationsOperation" -
    Then Select CheckBox for "Let guest users see this asset file on public and login pages"
    Then Select CheckBox for "Make asset file available to Salesforce org users"
    Then Click on button with Text "Save" on Modal
    Then Verify Message displaying as "Asset created successfully"

    #Step 17
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Job Last Run |
      | 1/1/2024 12:00 AM             |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds
    #Step 17b
    Then Get Date and Time for "Previous Run Time" of "FleetManagementJob4" onto "PreviousRunTime"
    #Step 18
    Then Navigate to stored URL for "Fleet_Asset_1"
    Then Wait for "3" Seconds

    #Expected 18.b)
    Then Scroll into Section "Odometer Information"
    Then Verify details for
      | Last Odometer Reading | Odometer Unit |
      | 1,398,111             | Miles         |
    Then Get Details
      | Last Location Change |
      |                      |
    Then Verify "SysData=>Last Location Change" and "SysData=>PreviousRunTime" in format "M/d/yyyy, h:mm a"
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD Last Update   | Current Location    | Geolocation            | Speed (mph) | Speed (kph) |
      | 7/9/2024, 3:10 AM | Tomahawk Truck Stop | 38.412279, -104.413179 | 55.00       | 88.51       |