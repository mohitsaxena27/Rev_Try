Feature: 1266 - API Credentials List LWC- Authorized Users - Existing User Actions

  @Regression @TMS @Priority_1 @WEB @Admin @SingleCurrency @1266
  Scenario: 1266 - API Credentials List LWC- Authorized Users - Existing User Actions

    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Wait for "3" Seconds
#    Then Click on button with Title "New"
    Then Click on button "New"
    Then Wait for "3" Seconds

    # Expected Result a
    Then Verify Text displaying as "New User"

    #Step 2
    Then Search text "User User" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "User User" user from lookup dropdown
    Then Wait for "2" Seconds
    Then Click on Native "Save" button
    Then Wait for "1" Seconds

    # Expected Result b
#    Then Verify Text displaying as "Warning"
    Then Verify Message displaying with "Warning - Credentials"
    Then Wait for "2" Seconds
    Then Verify Text displaying as "User User"

    #Step 3
    Then Click on "New" with Text
    Then Wait for "2" Seconds
    Then Search text "User Uer" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "User User" user from lookup dropdown
    Then Wait for "1" Seconds
#    Then Click on "Cancel" with Text
    Then Click button with Text "Cancel" on Modal
    Then Wait for "2" Seconds
    # Expected Result c
    Then Verify Text displaying as "User User"

    #Step 4
    Then Click on "New" with Text
    Then Wait for "2" Seconds
    Then Search text "User Uer" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "User User" user from lookup dropdown
    Then Wait for "2" Seconds
    Then Close Modal
    Then Wait for "2" Seconds
    # Expected Result d
    Then Verify Text displaying as "User User"

     #Step 5
    Then Click on Native "Close" icon
    Then Wait for "2" Seconds
    #Step 6
    Then Clear and search text "User User" in the "Search People..." search box
    Then Wait for "5" Seconds
    Then Select "User User" user from lookup dropdown
    Then Wait for "2" Seconds

    # Expected Result e
    Then Verify Text displaying as "User User"

     #Step 7
    Then Click on "User User" with Text
    Then Wait for "2" Seconds

    # Expected Result f
    Then Verify Text displaying as "User User"

     #Step 8
    Then Update details for "DAT" service
      | User Id          |
      | revenova_cnx1456 |
    Then Update checkbox "Truck Rates" as "true" for "DAT" credential card
    Then Click on Native "Save" button
    Then Wait for "3" Seconds

     # Expected Result g
    Then Click on "User User" with Text
    Then Wait for "2" Seconds
    Then Verify details for all Enabled fields
      | User Id          |
      | revenova_cnx1456 |

    #Step 9
    Then Update checkbox "Enabled" as "true" for "DAT" credential card
    Then Update checkbox "Test Mode" as "true" for "DAT" credential card
    Then Click on Native "Save" button
    Then Wait for "3" Seconds

    #Expected h
    Then Click on "User User" with Text
    Then Wait for "2" Seconds
    Then Verify details for "DAT" credential card
      | Enabled | Test Mode |
      | true    | true      |

    #Step 10
    Then Update details for "DAT" service
      | User Id            |
      | revenova_cnx1456/* |
    Then Update checkbox "Truck Rates" as "false" for "DAT" credential card
    Then Click on Native "Cancel" button
    Then Wait for "2" Seconds

    #Expected i
    Then Verify details for "DAT" credential card
      | User Id          | Truck Rates |
      | revenova_cnx1456 | true        |


    #Step 11
    Then Clear field "Password 1" on "DAT" credential card
    Then Update checkbox "Load Posting" as "true" for "DAT" credential card
    Then Click on Native "Close" button
    Then Wait for "2" Seconds

    #Expected j
    Then Verify url contains "rtms__TMS_Admin2"
    Then Verify Text not displaying as "Authorized Users"
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Wait for "3" Seconds
    Then Click on "User User" with Text
    Then Wait for "2" Seconds
    Then Verify details for "DAT" credential card
      | Password 1 | Load Posting |
      | not null   | True        |

    #Step 12
    Then Wait for "2" Seconds
     #Expected k
    Then Verify Text displaying as "Auth"

    #Step 13
    Then Click on "Auth" with Text
    Then Wait for "3" Seconds
    #Expected l
    Then Switch Window by index "1"
    Then Verify url contains "truckstop"





