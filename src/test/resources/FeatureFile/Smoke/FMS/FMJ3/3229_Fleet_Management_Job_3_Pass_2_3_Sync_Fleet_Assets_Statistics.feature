Feature: 3229 - Fleet Management Job 3- Pass 2+3- Sync Fleet Assets/Statistics*

  @API @Regression @Smoke @WEB @FMS @Fleet_Management_Job @SingleCurrency  @3229
  Scenario: 3229 - Fleet Management Job 3- Pass 2+3- Sync Fleet Assets/Statistics*

    When Login into Salesforce
    Then Set "Fleets_Name" with "T-9944 (Jeffrey)"
    Then Delete All Records with name "SysData=>Fleets_Name" for "rtms__FleetAsset__c"

     # Pre-Requisite
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    Then Set "LastDate" with "Date(M/d/yyyy)=>-1"
    Then Set "FinalDate" with "SysData=>LastDate" and " 9:30 AM"
    Then Update details -
      | Fleet Management Job Last Run |
      | SysData=>FinalDate            |
    And Click on Button with Value "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame

    #Step 1
    Then Get All "assets" and Store Response into "Samsara_Vehicle_Details"
    Then Get "id" from "Samsara_Vehicle_Details" where "name" is "SysData=>Fleets_Name" and store into "Vehicle_Id"
    Then Get "vin" from "Samsara_Vehicle_Details" where "name" is "SysData=>Fleets_Name" and store into "Vehicle_vin"
    Then Get "licensePlate" from "Samsara_Vehicle_Details" where "name" is "SysData=>Fleets_Name" and store into "Vehicle_licensePlate"
    Then Get "year" from "Samsara_Vehicle_Details" where "name" is "SysData=>Fleets_Name" and store into "Vehicle_year"
    Then Get "updatedAtTime" from "Samsara_Vehicle_Details" where "name" is "SysData=>Fleets_Name" and store into "updatedAtTime"

    #Step 2
    Then Get vehicle "fuelPercents" Stats for Vehicle Id "Vehicle_Id" and Store Response into "Samsara_Vehicle_Stats"
    Then Get Attribute "data[0].fuelPercent.value" store into "fuelPercent" from "Samsara_Vehicle_Stats"

    Then Get vehicle "batteryMilliVolts" Stats for Vehicle Id "Vehicle_Id" and Store Response into "Samsara_Vehicle_Stats"
    Then Get Attribute "data[0].batteryMilliVolts.value" store into "batteryMilliVolts" from "Samsara_Vehicle_Stats"


    Then Get vehicle "gps" Stats for Vehicle Id "Vehicle_Id" and Store Response into "Samsara_Vehicle_Stats"
    Then Get Attribute "data[0].gps.reverseGeo.formattedLocation" store into "Current_location" from "Samsara_Vehicle_Stats"
    Then Get Attribute "data[0].gps.time" store into "gpsTime" from "Samsara_Vehicle_Stats"
    Then Convert UTC time "SysData=>gpsTime" to Chicago time and store it on to "Exp_Time"
    Then Get vehicle "barometricPressurePa" Stats for Vehicle Id "Vehicle_Id" and Store Response into "Samsara_Vehicle_Stats"
    Then Get Attribute "data[0].barometricPressurePa.value" store into "barometricPressure" from "Samsara_Vehicle_Stats"
    Then Convert "barometricPressure" from Pascal to PSI and store into "barometricPressureInPSI"

    #Step 3
    Then Get All "gateways" and Store Response into "Samsara_gateway_Details"
    Then Get "serial" from "Samsara_gateway_Details" where "asset.id" is "SysData=>Vehicle_Id" and store into "gateway_Serial"
    Then Get "model" from "Samsara_gateway_Details" where "asset.id" is "SysData=>Vehicle_Id" and store into "gateway_model"

    #Step 4
    #Step 5
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Wait for "6" Seconds

    #Step 6
    Then Delete "FleetManagementJob3" job

    #Step 7
    Then Open "Fleet Assets" from App Launcher
    Then Search and Select "SysData=>Fleets_Name" from List
    Then Wait for "3" Seconds
    #Expected Result a
    Then Scroll into Section "General Information"
    Then Verify Details
         |Fleet Asset Name    |
         |SysData=>Fleets_Name|
    Then Scroll into Section "Equipment Information"
    Then Verify Details
         |Year|License Plate Number|VIN|
         |SysData=>Vehicle_year|SysData=>Vehicle_licensePlate|SysData=>Vehicle_vin|
    Then Scroll into Section "ELD Information"
    Then Verify Details
      | ELD ID              | ELD Serial Number      |ELD Model Number|
      | SysData=>Vehicle_Id   |SysData=>gateway_Serial|SysData=>gateway_model|
    Then Verify Details
      |ELD Last Update|
      |SysData=>Exp_Time|
    Then Verify Details
      |Fuel Percent Remaining|Current Location|Barometric Pressure (PSI)|
      |SysData=>fuelPercent  |SysData=>Current_location|SysData=>barometricPressureInPSI|
    Then Verify details for
      |Battery Voltage|
      |SysData=>batteryMilliVolts|
   #Step 8
   Then Click on Edit icon on Label "License Plate Number"
    Then Wait for "2" Seconds
    Then Update details
        |License Plate Number|
        |TEST3229            |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Scroll into Section "Equipment Information"
    Then Verify Details
      |License Plate Number|
      |TEST3229            |

     #Step 9
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Wait for "6" Seconds

    #Step 10
    Then Delete "FleetManagementJob3" job

    #Step 11
    Then Get All "assets" and Store Response into "Samsara_Vehicle_Details"
    Then Get "licensePlate" from "Samsara_Vehicle_Details" where "name" is "SysData=>Fleets_Name" and store into "Vehicle_licensePlate_Updated"

    #Expected b
    Then Verify Assertion for "Vehicle_licensePlate_Updated" contains "TEST3229"