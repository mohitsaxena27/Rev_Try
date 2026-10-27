
Feature: 1271 - API Credentials List LWC - Authorized Users - New User Details

  @Regression @TMS @Priority_1 @WEB @Admin @MultiCurrency @Credentials @1271
  Scenario: 1271 - API Credentials List LWC - Authorized Users - New User Details

    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Wait for "3" Seconds
    Then Click on "New" with Text
    #Expected Result a
    Then Verify Text displaying as "New User"

    #Step 2
    Then Search text "Integration User" in the active "Search People..." search box
    Then Wait for "2" Seconds
    Then Select "Integration User" user from lookup dropdown
    Then Wait for "2" Seconds
    Then Click on Native "Save" button
    Then Wait for "3" Seconds
    #Expected Result b
    Then Verify Text displaying as "Integration User"
    Then Ensure the "Authorized Users" is displayed with count "2"
    Then Verify Text displaying as "DAT"
    Then Verify Text displaying as "DAT 2"
    Then Verify Text displaying as "Truckstop Load Posting"
    Then Verify Text displaying as "Truckstop Truck Search"
    Then Verify Text displaying as "Truckstop Rates"
    Then Verify Text displaying as "LoadLink"

    #Step 3a - Expected Result c (DAT card)
    Then Verify details for "DAT" credential card
      | Enabled | Test Mode | Load Posting | Truck Posting Search | Truck Rates | User Id  | Password 1 | Password 2 | Customer Number | Service URL                     | Test Service URL                             | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges | Service Class | Record Id | Code      |
      | false   | false     | false        | false                | false       | REQUIRED | REQUIRED   |            |                 | https://cnx.dat.com/TfmiRequest | https://cnx.staging.dat.com/TfmiRequest      |           | 45                |                          | DATAPI        | populated | populated |

    #Step 3b - Expected Result d (DAT 2 card)
    Then Verify details for "DAT 2" credential card
      | Enabled | Test Mode | Load Posting | Truck Posting Search | Truck Rates | User Id  | Password 1 | Password 2 | Customer Number | Service URL                        | Test Service URL                                  | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges | Service Class | Record Id | Code      |
      | false   | false     | false        | false                | false       | REQUIRED | REQUIRED   |            |                 | https://__appName__.api.dat.com    | https://__appName__.api.staging.dat.com           |           | 45                |                          | DATRESTAPI    | populated | populated |
    Then verify "Preferred Contact Method" dropdown options
      | Email           |
      | Primary Phone   |
      | Alternate Phone |

    #Step 3c - Expected Result e (Truckstop Load Posting card)
    Then Verify details for "Truckstop Load Posting" credential card
      | Enabled | Test Mode | Load Posting | User Id  | Password 1 | Password 2 | Customer Number | Service URL              | Test Service URL                 | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges | Service Class       | Record Id | Code      |
      | false   | false     | false        | REQUIRED | REQUIRED   |            |                 | https://api.truckstop.com| https://api-int.truckstop.com    |           | 45                |                          | InternetTruckstopAPI| populated | populated |

    #Step 3d - Expected Result f (Truckstop Truck Search card)
    Then Verify details for "Truckstop Truck Search" credential card
      | Enabled | Test Mode | Truck Posting Search | User Id  | Password 1 | Password 2 | Customer Number | Service URL                      | Test Service URL                 | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges | Service Class       | Record Id | Code      |
      | false   | false     | false                | REQUIRED | REQUIRED   |            |                 | https://webservices.truckstop.com| https://testws.truckstop.com:8080|           | 45                |                          | InternetTruckstopAPI| populated | populated |

    #Step 3e - Expected Result g (Truckstop Rates card)
    Then Verify details for "Truckstop Rates" credential card
      | Enabled | Test Mode | User Id  | Password 1 | Password 2 | Customer Number | Service URL                                                   | Test Service URL                                                   | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges | Service Class       | Record Id | Code      |
      | false   | false     | REQUIRED | REQUIRED   |            |                 | https://webservices.truckstop.com/v13/RateMate/RateMate.svc | https://testws.truckstop.com:8080/v13/RateMate/RateMate.svc        |           | 45                |                          | InternetTruckstopAPI| populated | populated |

    #Step 3f - Expected Result h (TransCore card)
    Then Verify details for "LoadLink (TransCore)" credential card
      | Enabled | Test Mode | Load Posting | Truck Posting Search | User Id  | Password 1 | Password 2 | Customer Number | Service URL                             | Test Service URL                                  | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges | Service Class | Record Id | Code      |
      | false   | false     | false        | false                | REQUIRED | REQUIRED   |            |                 | https://thelinkfmintegration.loadlink.ca| https://azuatfmintegration.loadlink.ca             |           | 45                |                          | TransCoreAPI  | populated | populated |
