Feature: 3227 - TMS Admin Configuration- ELD Location Download (FMJ3)

  Background: Pre- Test
  Then Delete All Records with name "Account 3227" for "rtms__TransportationProfile__c"
  Then Delete All Records with name "Account 3227" for "Account"
    Then Delete All Records with name "Account 3227 Carrier" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "Account 3227 Carrier" for "Account"


  @Regression @Smoke @API @WEB @SingleCurrency @Customer_Invoice @Account @3227 @FMJ3
  Scenario: 3227 - TMS Admin Configuration- ELD Location Download (FMJ3)

    When Login into Salesforce

    #-----------------------------------------------------
    #Step1
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
    |Account Name|
    |Account 3227|
    Then Select "TMS Type" as "Customer" from Dueling List
    Then Select "TMS Type" as "Shipper/Consignee" from Dueling List
    Then Enter Address Search Text as "181 West Madison Street, Chicago, IL 60602"
    Then Wait for "2" Seconds
    Then Click on button with Title "181 West Madison Street"
    Then Update details
      | Timezone |
      | America/Chicago |
    Then Click on "SaveAndNew" button
    Then Verify Message displaying with "Account \"Account 3227\" was created."
    Then Wait for "2" Seconds
    #Step 2
    Then Update details
      |Account Name|
      |Account 3227 Carrier|
    Then Select "TMS Type" as "Carrier (Ground)" from Dueling List -
    Then Enter Address Search Text as "73 West Monroe Street, Chicago, Illinois 60603"
    Then Wait for "2" Seconds
    Then Click on button with Title "73 West Monroe Street"
    Then Update details
      | Timezone |
      | America/Chicago |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Account \"Account 3227 Carrier\" was created."

    #Step 3
    Then Samsara API - Create a Location using Request "First_Address_Json.txt" and Store Response into "First_Response"
    Then Get Attribute "data.id" store into "First_Address_ID" from "First_Response"

    Then Samsara API - Create a Location using Request "Second_Address_Json.txt" and Store Response into "Second_Response"
    Then Get Attribute "data.id" store into "Second_Address_ID" from "Second_Response"

#
#    Then Open New Tab with url "https://cloud.samsara.com/o/82103/fleet/config/addresses"
#    Then 1PW - Set "username" value of "Samsara - Customer Portal" on "Samsara_UN"
#    Then 1PW - Set "password" value of "Samsara - Customer Portal" on "Samsara_Pwd"
#    Then Wait for "4" Seconds
#    Then Login to Samsara Account with UserName as "SysData=>Samsara_UN" and Password as "SysData=>Samsara_Pwd"
#    Then Wait for "4" Seconds
#    Then Refresh current Page
#    #Step 4
#    Then Click on "Add place" with Text -
#    Then Verify Text displaying as "Create new place" -
#    Then Add Address with Name as "Account 3227" and Location as "181 West Madison Street, Chicago, IL 60602"
#
#    #Step 5
#    Then Click on "Add place" with Text -
#    Then Verify Text displaying as "Create new place" -
#    Then Add Address with Name as "Account 3227 Carrier" and Location as "73 West Monroe Street, Chicago, Illinois 60603"
#    Then Wait for "2" Seconds
#    #Step 6
#    Then Store ID for Added Address with Search "Account 3227"
#    Then Store ID for Added Address with Search "Account 3227 Carrier"
#    Then Close and Switch to Previous Window

     #Step 7 & 8
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    And Click on Button with Value "Save" -
    Then Wait for "2" Seconds
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"
    And Click on Button with Value "ELD Location Download" -
    Then Verify Text displaying as "Location download has started." -
    Then Switch to Parent Frame

    #Step 9
    Then Navigate to set up Page "-setup.com/lightning/setup/AsyncApexJobs/home"
    Then Wait for "2" Seconds
    Then Verify "2" Apex Job is processed with Apex Class as "FleetManagementEventHandler" and Apex Method as "getSamsaraAddresses"

    #Step 10
    Then Search and Select "Account 3227" Account from the Global search
    Then Wait for "2" Seconds
    Then Go to "Related" Tab next to "Details" Tab
    Then Scroll Until Related List for "Account ELD"
    Then Wait for "2" Seconds
    Then Click on "ELD-" with Contains Text
    #Expected a
    Then Verify Details
         |ELD Provider|ELD ID|
         |Samsara     |SysData=>Account_3227|

    #Step 11
    Then Search and Select "Account 3227 Carrier" Account from the Global search
    Then Wait for "4" Seconds
    Then Go to "Related" Tab next to "Details" Tab
    Then Scroll Until Related List for "Account ELD"
    Then Wait for "2" Seconds
    Then Click on "ELD-" with Contains Text
    #Expected b
    Then Verify Details
      |ELD Provider|ELD ID|
      |Samsara     |SysData=>Account_3227_Carrier|

