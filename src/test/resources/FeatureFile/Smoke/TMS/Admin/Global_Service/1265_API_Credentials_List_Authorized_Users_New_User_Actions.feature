Feature: 1265 - API Credentials List LWC - Authorized Users - New User Actions

  @Regression @TMS @Priority_1 @Admin @MultiCurrency @Credentials @1265
  Scenario: 1265 - API Credentials List LWC - Authorized Users - New User Actions

    When Login into Salesforce

    # Capture the original system-admin credential URLs for expected results b and f.
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Wait for "3" Seconds
    Then Verify Text displaying as "User User"
    Then Click on "User User" with Text
    Then Wait for "2" Seconds
    Then Verify details for "DAT" credential card
      | Service URL          | Test Service URL     |
      | capture system admin | capture system admin |
    Then Verify details for "DAT 2" credential card
      | Service URL          | Test Service URL     |
      | capture system admin | capture system admin |
    Then Verify details for "Truckstop Load Posting" credential card
      | Service URL          | Test Service URL     |
      | capture system admin | capture system admin |
    Then Verify details for "Truckstop Truck Search" credential card
      | Service URL          | Test Service URL     |
      | capture system admin | capture system admin |
    Then Verify details for "Truckstop Rates" credential card
      | Service URL          | Test Service URL     |
      | capture system admin | capture system admin |
    Then Verify details for "LoadLink (TransCore)" credential card
      | Service URL          | Test Service URL     |
      | capture system admin | capture system admin |
    Then Click on button with Title "Close"
    Then Verify detail section is closed

    #Step 1
    Then Wait for "3" Seconds
    Then Click on "New" with Text
    #Expected Result a
    Then Verify Text displaying as "New User"

    #Step 1a
    Then Search text "Chatter Expert" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "Chatter Expert" user from lookup dropdown
    Then Wait for "2" Seconds
    Then Click on Native "Save" button
    Then Wait for "3" Seconds
    #Expected Result b
    Then Verify Text displaying as "Chatter Expert"
    Then Ensure the "Authorized Users" is displayed with count "2"
    Then Verify Text displaying as "DAT"
    Then Verify Text displaying as "DAT 2"
    Then Verify Text displaying as "Truckstop Load Posting"
    Then Verify Text displaying as "Truckstop Truck Search"
    Then Verify Text displaying as "Truckstop Rates"
    Then Verify Text displaying as "LoadLink"
    Then Verify details for "DAT" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
#    Then Verify details for all Enabled fields
#      | Enabled | User Id  | Password 1 | Service URL                     | Test Service URL                        |
#      | false   | REQUIRED | REQUIRED   | https://cnx.dat.com/TfmiRequest | https://cnx.staging.dat.com/TfmiRequest |
    Then Verify details for "DAT 2" credential card
      | Enabled | User Id  | Password 1 | Service URL                     | Test Service URL                        |
      | false   | REQUIRED | REQUIRED   | https://__appName__.api.dat.com | https://__appName__.api.staging.dat.com |
    Then Verify details for "Truckstop Load Posting" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Verify details for "Truckstop Truck Search" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Verify details for "Truckstop Rates" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Verify details for "LoadLink (TransCore)" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Click on button with Title "Close"
    Then Verify detail section is closed

    #Step 2
    Then Click on "New" with Text
    Then Wait for "2" Seconds
    Then Search text "Email_Loop Site Guest User" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "Email_Loop Site Guest User" user from lookup dropdown
    Then Wait for "1" Seconds
    Then Click on Native "Cancel" button
    Then Wait for "2" Seconds
    #Expected Result c
    Then Ensure the "Authorized Users" is displayed with count "2"
    Then Verify Exact Text not displaying as "Email_Loop Site Guest User"
    Then Verify Text not displaying as "New User"
    Then Verify Text displaying as "Authorized Users"

    #Step 3
    Then Click on "New" with Text
    Then Wait for "2" Seconds
    Then Search text "API Site Guest User" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "API Site Guest User" user from lookup dropdown
    Then Wait for "1" Seconds
    Then Close Modal
    Then Wait for "2" Seconds
    #Expected Result d
    Then Ensure the "Authorized Users" is displayed with count "2"
    Then Verify Exact Text not displaying as "API Site Guest User"
    Then Verify Text not displaying as "New User"
    Then Verify Text displaying as "Authorized Users"

    #Step 4
    Then Click on "New" with Text
    Then Wait for "2" Seconds
    Then Search text "API Site Guest User" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "API Site Guest User" user from lookup dropdown
    Then Wait for "2" Seconds
    #Expected Result e
    Then Verify Text displaying as "New User"
    Then Verify Text displaying as "API Site Guest User"

    #Step 5
    Then Click on Native "Save" button
    Then Wait for "3" Seconds
    #Expected Result f
    Then Verify Text displaying as "API Site Guest User"
    Then Ensure the "Authorized Users" is displayed with count "3"
    Then Verify Text displaying as "DAT"
    Then Verify Text displaying as "DAT 2"
    Then Verify Text displaying as "Truckstop Load Posting"
    Then Verify Text displaying as "Truckstop Truck Search"
    Then Verify Text displaying as "Truckstop Rates"
    Then Verify Text displaying as "LoadLink"
    Then Verify details for "DAT" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Verify details for "DAT 2" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Verify details for "Truckstop Load Posting" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Verify details for "Truckstop Truck Search" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Verify details for "Truckstop Rates" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |
    Then Verify details for "LoadLink (TransCore)" credential card
      | Enabled | User Id  | Password 1 | Service URL          | Test Service URL     |
      | false   | REQUIRED | REQUIRED   | same as system admin | same as system admin |

    #Step 6
    Then Search text "Email_Loop Site Guest User" in the "Search People..." search box
    Then Wait for "2" Seconds
    Then Click on "New" with Text
    Then Wait for "2" Seconds
#    Then Click on modal button with text "Cancel"
    Then Click button with Text "Cancel" on Modal
    Then Wait for "2" Seconds
    #Expected Result g
    Then Ensure the "Authorized Users" is displayed with count "3"
    Then Verify Exact Text not displaying as "Email_Loop Site Guest User"
    Then Verify Text not displaying as "New User"
    Then Verify Text displaying as "Authorized Users"

    #Step 7
    Then Wait for "5" Seconds
    Then Clear and search text "Chatter Expert" in the "Search People..." search box
    Then Wait for "5" Seconds
    Then Select "Chatter Expert" user from lookup dropdown
    Then Wait for "2" Seconds
    #Expected Result h
    Then Verify Text displaying as "Chatter Expert"
    Then Ensure the "Authorized Users" is displayed with count "3"

    #Step 8
    Then Click on "API Site Guest User" with Text
    Then Wait for "2" Seconds
    #Expected Result i
    Then Verify Text displaying as "API Site Guest User"

    #Step 9
    Then Update details for "DAT" service
      | User Id          |
      | revenova_cnx1456 |
    Then Update checkbox "Truck Rates" as "true" for "DAT" credential card
    Then Click on Native "Save" button
    Then Wait for "3" Seconds
    #Expected Result j
    Then Verify detail section is closed
    Then Click on "API Site Guest User" with Text
    Then Wait for "2" Seconds
    Then Verify details for "DAT" credential card
      | User Id          | Truck Rates |
      | revenova_cnx1456 | true        |

    #Step 10
    Then Update checkbox "Enabled" as "true" for "DAT" credential card
    Then Update checkbox "Test Mode" as "true" for "DAT" credential card
    Then Click on Native "Save" button
    Then Wait for "3" Seconds
    #Expected Result k
    Then Verify detail section is closed
    Then Click on "API Site Guest User" with Text
    Then Wait for "2" Seconds
    Then Verify details for "DAT" credential card
      | Enabled | Test Mode |
      | true    | true      |

    #Step 11
    Then Update details for "DAT" service
      | User Id            |
      | revenova_cnx1456/* |
    Then Update checkbox "Truck Rates" as "false" for "DAT" credential card
    Then Click on Native "Cancel" button
    Then Wait for "2" Seconds
    #Expected Result l
    Then Verify details for "DAT" credential card
      | User Id          | Truck Rates |
      | revenova_cnx1456 | true        |

    #Step 12
    Then Clear field "Password 1" on "DAT" credential card
    Then Update checkbox "Load Posting" as "true" for "DAT" credential card
    Then Click on Native "Close" button
    Then Wait for "2" Seconds
    #Expected Result m
    Then Verify url contains "rtms__TMS_Admin2"
    Then Verify Text not displaying as "Authorized Users"

    #Step 13
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Wait for "3" Seconds
    Then Click on "API Site Guest User" with Text
    Then Wait for "2" Seconds
    Then Verify details for "DAT" credential card
      | Password 1 | Load Posting |
      | not null   | false        |
    Then Wait for "2" Seconds
    Then click on "Chatter Expert" user and select "Delete" from Show More Dropdown
#    Then Click on down-arrow for "Chatter Expert"
#    Then Click on button with Title "Delete"
    Then Wait for "3" Seconds
    #Expected Result n
    Then Ensure the "Authorized Users" is displayed with count "2"
    Then Verify Exact Text not displaying as "Chatter Expert"

    #Step 14
    Then Refresh current Page
    Then Wait for "3" Seconds
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Wait for "3" Seconds
    #Expected Result o
    Then Verify Exact Text not displaying as "Chatter Expert"

    #Step 15
    Then click on "User User" user and select "Clone" from Show More Dropdown
#    Then Click on down-arrow for "User User"
#    Then Click on button with Title "Clone"
    Then Wait for "4" Seconds

    #Step 16
    Then Wait for "2" Seconds
    Then Search text "Customer_Portal Site Guest User" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "Customer_Portal Site Guest User" user from lookup dropdown
    Then Wait for "2" Seconds
#    Then Click on modal button with text "Clone"
    Then Click button with Text "Clone" on Modal
    Then Wait for "3" Seconds
    Then Ensure the "Authorized Users" is displayed with count "3"
    Then Verify Text displaying as "Customer_Portal Site Guest User"

    #Step 17
    Then Click on "User User" with Text
    Then Wait for "2" Seconds
    #Expected Result p
    Then Verify Text displaying as "Auth"

    #Step 18
    Then Click on "Auth" with Text
    Then Wait for "3" Seconds
    #Expected Result q
    Then Switch to new Window
    Then Verify url contains "truckstop"

    #Step 19
    Then Close and Switch to Previous Window
    Then Click on Native "Close" button
    Then Wait for "2" Seconds
    #Expected Result r
    Then Verify url contains "rtms__TMS_Admin2"
    Then Verify Text not displaying as "Authorized Users"
