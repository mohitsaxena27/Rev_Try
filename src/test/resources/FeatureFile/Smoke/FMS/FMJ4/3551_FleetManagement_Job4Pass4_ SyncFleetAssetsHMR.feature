Feature: 3551 - Fleet Management Job 4- Pass 4- Sync Fleet Assets HMR

  Background: Pre- Test
    Then Delete Field with Title "AxleGetVehiclesOperation"
    Then Delete Field with Title "AxleGetFleetDataFromFleetCodeOperation"

#  @API @Regression @WEB @smoke @FMS @SingleCurrency  @3551 @Catena
  Scenario: 3551 -Fleet Management Job 4- Pass 4- Sync Fleet Assets HMR

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
    Then Update details
      | Enabled |
      | true    |
    And Click on Native "Save" button

    # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob4"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 3
    Then Get "AxleGetFleetDataFromFleetCodeOperation-3551.txt" files and update below Attributes
      | {fleet_id}               |
      | SysData=>Customer_Number |
    Then Save it with FileName "AxleGetFleetDataFromFleetCodeOperation-3551.txt"

    # Step 4,5
    Given Upload File "U_AxleGetFleetDataFromFleetCodeOperation-3551.txt" with Title "AxleGetFleetDataFromFleetCodeOperation" and Description "200"
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

    # Step 6
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "5" Seconds

    # Step 7,8, 9, 10
    Then Get Access token using "3551_GetAccessToken.json" and store in "Access_Token"
    Then Get Fleet Code using "Access_Token" for Fleet ID "SysData=>Customer_Number"

    # Step 9 to 15
    Then Set "VIN" value as "VIN+{currentDate=>MMddyyyyHHmm}+VN"
    Then Set "name" value as "{currentDate=>MMddyyHHmm}"
    Then Set "license_plate_number" value as "{currentDate=>MMddyyHHmm}"
    Then Update payload on "3551_Vehicle_RequestBody.json"
      | {Customer_Number}          | {AxleID}          | {Name}          | {VIN}          | {License_plate_number}          |
      | SysData=>Customer_Number | SysData=>AxleID | SysData=>name | SysData=>VIN | SysData=>license_plate_number |
    Then Create a Vehicle using updated payload

    # Step 16
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

    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "5" Seconds

    # Step 17 Expected Result a
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "SysData=>name" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name | Year | Vehicle Make | Vehicle Model | VIN          | License Plate Number          |
      | Tractor | Fleet Carrier One | Available | SysData=>name    | 2021 | Peterbilt    | 389           | SysData=>VIN | SysData=>license_plate_number |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID      | ELD Brand | ELD Serial Number |
      | SysData=>ID | Motive    | NA                |

    Then Capture the current URL for "Fleet_Assets"

    #  Step 18 &19  Expected Result b
    Then Get Fleet details using "SysData=>Customer_Number"
    Then Search "T THREEFIVEFIVE-ONE VIN" doesn't present in response
    Then Search "T THREEFIVEFIVE-ONE ELD" doesn't present in response

    # Step 20 & 21
    Then Get "AxleGetVehiclesOperation-3551scenario2.txt" files and update below Attributes
      | {fleet_id}               | {vehicle_id}          | {vin}        |
      | SysData=>Customer_Number | SysData=>ID | SysData=>VIN |
    Then Save it with FileName "AxleGetVehiclesOperation-3551scenario2.txt"
   # Step 22 & 23 & 24
    Given Upload File "U_AxleGetVehiclesOperation-3551scenario2.txt" with Title "AxleGetVehiclesOperation" and Description "200"
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

    # Step 25
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Refresh current Page
    Then Wait for "5" Seconds

    #Step 26
    Then Navigate to stored URL for "Fleet_Assets"
    Then Refresh current Page
    Then Wait for "3" Seconds
    #Expected Result c
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name | Year | Vehicle Make | Vehicle Model | VIN          | License Plate Number          | License Plate State |
      | Tractor | Fleet Carrier One | Available | SysData=>name    | 2021 | Peterbilt    | 389           | SysData=>VIN | SysData=>license_plate_number | NA                  |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID     | ELD Brand | ELD Serial Number |
      | ELD3551VIN | Motive    | DEVICE2           |
    Then Wait for "2" Seconds
    #Step 27
    Then Click on Edit icon on Label "ELD ID"
    Then Update details
      | ELD ID      |
      | SysData=>ID |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | ELD ID      |
      | SysData=>ID |

    # Step 28
    Then Delete Field with Title "AxleGetVehiclesOperation"

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

    #Step 29
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "2" Seconds

    # Step 30 & Expected Result d -
    Then Navigate to stored URL for "Fleet_Assets"
    Then Refresh current Page
    Then Wait for "3" Seconds
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name | Year | Vehicle Make | Vehicle Model | VIN          | License Plate Number          |
      | Tractor | Fleet Carrier One | Available | SysData=>name    | 2021 | Peterbilt    | 389           | SysData=>VIN | SysData=>license_plate_number |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID      | ELD Brand | ELD Serial Number |
      | SysData=>ID | Motive    | NA                |
    Then Get "AxleGetVehiclesOperation-3551scenario4.txt" files and update below Attributes
      | {fleet_id}               | {vehicle_id} |
      | SysData=>Customer_Number | SysData=>ID  |
    Then Save it with FileName "AxleGetVehiclesOperation-3551scenario4.txt"

    # Step 31 32,33, 34
    Then Get "AxleGetVehiclesOperation-3551scenario4.txt" files and update below Attributes
      | {fleet_id}               | {vehicle_id}          |
      | SysData=>Customer_Number | SysData=>ID |
    Then Save it with FileName "AxleGetVehiclesOperation-3551scenario4.txt"

    Given Upload File "U_AxleGetVehiclesOperation-3551scenario4.txt" with Title "AxleGetVehiclesOperation" and Description "200"
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

    # Step 35
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "60" Seconds
    Then Refresh current Page


    #Step 36 Expected Result e
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "T THREEFIVEFIVE-ONE VIN" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name        | Year | Vehicle Make | Vehicle Model | VIN      | License Plate Number | License Plate State |
      | Tractor | Fleet Carrier One | Available | T THREEFIVEFIVE-ONE VIN | 2025 | Volvo        | VNL 400       | 3551VIN1 | 3351PL1              | IL                  |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID   | ELD Brand | ELD Serial Number |
      | 3551ELD2 | Motive    | DEVICE3551        |
    Then Capture the current URL for "Fleet_Asset_2"

    # Step 37 Expected Result f
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "T THREEFIVEFIVE-ONE ELD" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "General Information"
    Then Verify details for
      | Type    | Company/Division  | Status    | Fleet Asset Name        | Year | Vehicle Make | Vehicle Model | VIN      | License Plate Number |
      | Tractor | Fleet Carrier One | Available | T THREEFIVEFIVE-ONE ELD | 2026 | Volvo        | VNL 860        | 3551VIN2 | 3351PL2              |
    Then Scroll into Section "ELD Information"
    Then Verify details for
      | ELD ID | ELD Brand | ELD Serial Number |
      | NA     |NA        | NA                |
    Then Capture the current URL for "Fleet_Asset_3"

