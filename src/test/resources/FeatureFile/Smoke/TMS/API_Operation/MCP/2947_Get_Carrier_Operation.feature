Feature: 2947 - MCP API- Get Carrier Operation

  Background: Pre- Test
    Then Delete Field with Title "MCPGetCarrierOperation"
    Then Delete Field with Title "MCPGetCompletedPacketsOperation"
    Then Delete Field with Title "MCPGetCarrierChangesOperation"
    Then Delete Field with Title "MCPGetMonitoredCarriersOperation"
    Then Delete Field with Title "Sample Broker Agreement V2.pdf"
    Then Delete Field with Title "Carrier Customer Agreement.pdf"

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2947 @MCP_API
  Scenario: 2947 - MCP API- Get Carrier Operation

    When Login into Salesforce

  # Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "SaferWatch" in the "Search Credentials..." search box
    Then Select the "SaferWatch" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    Then Search text "RMIS" in the "Search Credentials..." search box
    Then Select the "RMIS" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    Then Search text "Highway" in the "Search Credentials..." search box
    Then Select the "Highway" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Search text "MyCarrierPackets" in the "Search Credentials..." search box
    Then Select the "MyCarrierPackets" record from the lookup field results
    Then Update details
      | Enabled |
      | true   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

  # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | true                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    Then Update details -
      | Carrier Monitor Last Run |
      |                          |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    Then Verify details for all Enabled fields -
      | Carrier Monitor Last Run |
      |                          |
    Then Switch to Parent Frame

  # Step 3,4,5,6

    Given Upload File "MCPGetCarrierOperation- 2947.txt" with Title "MCPGetCarrierOperation"
    Given Upload File "MCPGetMonitoredCarriersOperation -2947.txt" with Title "MCPGetMonitoredCarriersOperation"
    Given Upload File "MCPGetCompletedPacketsOperation.txt" with Title "MCPGetCompletedPacketsOperation"
    Given Upload File "MCPGetCarrierChangesOperation.txt" with Title "MCPGetCarrierChangesOperation"

  # Step 7
    Then Go to Home Page
    Then Run "CarrierMonitorMCPJob" Job
    Then Wait for "6" Seconds

  # Step 8
    Then Delete "CarrierMonitorMCPJob" job
    Then Wait for "1" Seconds
    #Step 9
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "MCP Carrier 2947" from List
    Then Wait for "4" Seconds
    Then Capture the current URL for "TP1_MCP"
    Then Go to "Carrier Operations" Tab
    Then Search and Select "rtms__CarrierService__c" "MCP Carrier 2947" from the Global search
    Then Wait for "4" Seconds
    Then Capture the current URL for "Carrier_Service1_MCP"
    
  # Expected resylt a
    Then Scroll into Section "General Information"
    Then Verify Details
      | Name             | Carrier Service Owner | Credentials | API Provider |
      | MCP Carrier 2947 |                       |             |              |

    Then Verify Label Checkbox
      | Enabled |
      | true    |

    Then Scroll into Section "Carrier Information"
    Then Verify Details
      | Carrier          | Transportation Profile | Mode      | Service Notes | Rating |
      | MCP Carrier 2947 | MCP Carrier 2947       | Truckload |               |        |

    Then Scroll into Section "Carrier Quote  & Settlement Contacts (Default)"
    Then Verify Details
      | Quote Contact | Quote Method | Settlement Contact |
      | Rory Gilmore  | Email        | Remittance Contact |

    Then Scroll into Section "Carrier Booking Contact (Default)"
    Then Verify Details
      | Tender Contact | Tender Method | Load Tender Page Settings | EDI Provider |
      | Paris Geller   | Email         |                           |              |

    Then Verify Label Checkbox
      | Pickup Only |
      | false       |

    Then Scroll into Section "Carrier Status Contact (Default)"
    Then Verify Details
      | Status Contact | Status Method |
      | Rory Gilmore   | Email         |

    Then Verify Label Checkbox
      | Batch Status Emails |
      | true                |

    Then Scroll into Section "Load Weight & Volume Thresholds"
    Then Verify Details
      | Minimum Weight | Maximum Weight | Weight Units | Maximum Volume | Volume Units | Minimum Linear Feet | Maximum Linear Feet |
      | 100            | 45,000         | lbs          |                |              |                     |                     |

    Then Verify Label Checkbox
      | VLTL  |
      | false |

    Then Scroll into Section "Handling Unit Thresholds"
    Then Verify Details
      | Maximum HU Length | Maximum HU Width | Maximum HU Height | Dimension Units | Maximum HU Count | Maximum HU Weight |
      |                   |                  |                   | in              |                  |                   |

    # Step 10
    Then Navigate Browser Back

    # Expected reult b
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Verify Details
      | SCAC |
      |      |
    Then Scroll into Section "Fleet Summary"
    Then Verify Details
      | Fleet Size | Total Power Units | Number of Drivers |
      | 1          | 1                 | 1                 |

    Then Scroll into Section "US Registration"
    Then Verify Details
      | MC/MX/FF Number | US DOT Number |
      | MC076576        | 3099350       |

  # Expected resylt c
    Then Scroll Until Related List for "Carrier Equipment Types"
    Then Scroll down with "3" Times
    Then Hover over on "1" "Equipment-" link
    Then Verify hover popup for "Equipment-1"
      | Equipment Type | Number |
      | Dry Van 53'    | 1      |

  # Expected resylt d"
    Then Hover over on "2" "Equipment-" link
    Then Verify hover popup for "Equipment-2"
      | Equipment Type | Number |
      | Reefer 53'     | 1      |

  # Expected resylt e
    Then Hover over on "3" "Equipment-" link
    Then Verify hover popup for "Equipment-3"
      | Equipment Type     | Number |
      | Flatbed 2 Axle 48' | 1      |

  # Step 11
    Then Navigate to stored URL for "TP1_MCP"
    Then Wait for "1" Seconds
    Then Go to "Settlement" Tab

  # Expected resylt f
    Then Scroll into Section "Tax Information"
    Then Verify Details
      | W9 Address | W9 City | W9 State | Federal Tax ID |
      |            |         |          |                |
    Then Verify Label Checkbox
      | W9 Validated |
      | false        |

    Then Scroll into Section "Carrier Remittance Information"
    Then Verify Details
      | Carrier Remit To | Carrier Pay To Name |
      | MCP Carrier 2947 |                     |

  # Step 11.a
    Then Go to "Compliance" Tab

  #Expected g
    Then Scroll into Section "Carrier Status Information"
    Then Verify Details
      | Carrier Review Status | Agreement Status | Agreement Date | Agreement Signed By |
      | Pending               | Received         | 6/20/2020      | Rory Gilmore        |
    Then Verify Label Checkbox
      | Monitor Carrier |
      | true            |

    Then Scroll into Section "Motor Carrier Analysis  (powered by My Carrier Portal)"
    Then Verify Details
      | Overall Risk      | Overall Risk Points | Authority Risk    | Authority Risk Points | Insurance Risk    | Insurance Risk Points | Safety Risk | Safety Risk Points | Operation Risk      | Operation Risk Points | Other Risk | Other Risk Points |
      | Unacceptable Fail | 42,000              | Unacceptable Fail | 20,000                | Unacceptable Fail | 21,000                | Acceptable  | 0                  | Unacceptable Review | 1,000                 | Acceptable | 0                 |
    Then Verify Label Checkbox
      | Blocked Carrier |
      | false           |

    Then Scroll into Section "SAFER Snapshot"
    Then Verify Details
      | Out of Service | Out of Service Date | Safety Rating | Safety Rating Date | Authority Granted Date | Common Authority Status | Contract Authority Status | Broker Authority Status |
      | No             |                     | Not Rated     |                    | 10/30/2020             | Inactive                | None                      | None                    |

    Then Scroll into Section "CARB Snapshot"
    Then Verify Details
      | CARB-TRU Compliance Type | CARB-TRU Compliant Vehicles Reported | CARB-TRU Non-Compliant Reason | CARB-TRU Certificate Expiration Date |
      |                          |                                      |                               |                                      |

    Then Scroll into Section "SAFER Authority Alerts"
    Then Verify Details
      | Common Authority Pending | Contract Authority Pending | Broker Authority Pending | Common Authority Revocation | Contract Authority Revocation | Broker Authority Revocation |
      | No                       | No                         | No                       | No                          | No                            | No                          |

  # Step 12
    Then Scroll Until Related List for "Insurance Policies"
  # Expected result h
    Then Verify No Records Available with "Insurance Policies"

  # Step 13
    Then Open "Files" from App Launcher
    Then Wait for "2" Seconds
  # Expected i
    Then Verify Text displaying as "Sample Broker Agreement V2.pdf"
    Then Verify Text displaying as "Carrier Customer Agreement.pdf"

  # Step 14
    Then Search and Select "MCP Carrier 2947" Account from the Global search
    Then Wait for "3" Seconds
    Then Capture the current URL for "Account1_MCP"

  # Expected result j
    Then Scroll into Section "General Information"
    Then Verify Details
      | DBA Name     | TMS Type         | Phone          |
      | DBA Name2947 | Carrier (Ground) | (347) 743-8430 |

    Then Scroll into Section "Address Information"
    Then Verify Details
      | Shipping Address                                               | Billing Address                                                |
      | 3626 WILLANO WAY\nRALEIGH, North Carolina 27610\nUnited States | 3626 WILLANO WAY\nRALEIGH, North Carolina 27610\nUnited States |

  # Step 15
    Then Go to "Contacts" Tab
    Then Click the "Lorelai Gilmore" from grid

  # Expected result k
    Then Scroll into Section "Details"
    Then Verify Details
      | Name            | Transportation Role | Phone | Title | Mobile       | Department | Email                        | Reports To | Fax |
      | Lorelai Gilmore |                     |       |       | 347-743-8430 |            | lorelai.gilmore@revenova.com |            |     |

    Then Scroll into Section "Address Information"
    Then Verify Details
      | Mailing Address | Citizenship Country |
      | United States   | United States       |

    Then Navigate Browser Back

  # Step 16
    Then Click the "Paris Geller" from grid

  # Expected result l
    Then Scroll into Section "Details"
    Then Verify Details
      | Name         | Transportation Role | Phone          | Title | Mobile | Department | Email                | Reports To | Fax |
      | Paris Geller | Tendering           | (555) 555-5555 |       |        |            | pgeller@revenova.com |            |     |

    Then Scroll into Section "Address Information"
    Then Verify Details
      | Mailing Address | Citizenship Country |
      | United States   | United States       |

    Then Navigate Browser Back
    Then Wait for "2" Seconds
  # Step 17
    Then Click the "Remittance Contact" from grid

  # Expected result m
    Then Scroll into Section "Details"
    Then Verify Details
      | Name               | Transportation Role | Phone | Title | Mobile | Department | Email                   | Reports To | Fax |
      | Remittance Contact | Settlement          |       |       |        |            | randallalaska@gmail.com |            |     |

    Then Scroll into Section "Address Information"
    Then Verify Details
      | Mailing Address                                                | Citizenship Country |
      | 3626 WILLANO WAY\nRALEIGH, North Carolina 27610\nUnited States | United States       |

    Then Navigate Browser Back
    Then Wait for "2" Seconds
  # Step 18
    Then Click the "Richard Gilmore" from grid

  # Expected result n
    Then Scroll into Section "Details"
    Then Verify Details
      | Name            | Transportation Role | Phone          | Title | Mobile         | Department | Email | Reports To | Fax |
      | Richard Gilmore | Driver              | (801) 111-1111 |       | (801) 111-1111 |            |       |            |     |

    Then Scroll into Section "Address Information"
    Then Verify Details
      | Mailing Address | Citizenship Country |
      | United States   | United States       |

    Then Navigate Browser Back
    Then Wait for "2" Seconds
  # Step 19
    Then Click the "Rory Gilmore" from grid

  # Expected result o
    Then Scroll into Section "Details"
    Then Verify Details
      | Name         | Transportation Role        | Phone          | Title | Mobile | Department | Email              | Reports To | Fax |
      | Rory Gilmore | Carrier Application Signer | (336) 942-6001 |       |        |            | rgilmore@gmail.com |            |     |

    Then Scroll into Section "Address Information"
    Then Verify Details
      | Mailing Address | Citizenship Country |
      | United States   | United States       |

    Then Navigate Browser Back
    Then Wait for "2" Seconds
  # Step 20 & Expected result p
    Then Verify Text not displaying as "Richard Gilmore 2"

  # Step 21
    Then Go to "Quotes, Invoices & Payments" Tab
    Then Scroll Until Related List for "Bank Accounts"
    Then Click on Partial Link Text "BA-" on Page -
    Then Wait for "1" Seconds
  # Expected result q
    Then Scroll into Section "Bank Account Information"
    Then Verify Details
      | Bank Name | Routing Number | Account Number | Account Type | Confirm Account Number | ACH Remittance Document |
      | TestBank  | 123456789      | *2345          | Checking     | *2345                  |                         |
    Then Verify Label Checkbox
      | ACH Active |
      | false      |

    Then Scroll into Section "NACHA File Settings"
    Then Verify Details
      | ACH Payee Name   | ACH Immediate Origin Name | ACH Company Information | ACH Company Name | ACH Company Discretionary Data | ACH Reference Code |
      | MCP Carrier 2947 |                           |                         |                  |                                | ACH                |

  # Step 22
    Then Delete Field with Title "MCPGetCarrierOperation"
    Then Delete Field with Title "MCPGetMonitoredCarriersOperation"

  # Step 23, 24, 25
    Given Upload File "MCPGetCarrierOperation- 2947 Blocked Carrier.txt" with Title "MCPGetCarrierOperation"
    Given Upload File "MCPGetMonitoredCarriersOperation -2947 Blocked Carrier.txt" with Title "MCPGetMonitoredCarriersOperation"

  # Step 26
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    Then Update details -
      | Carrier Monitor Last Run |
      |                          |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Scroll into Section "Carrier Management / Automatic Load Status Updates" -
    Then Verify details for all Enabled fields -
      | Carrier Monitor Last Run |
      |                          |
    Then Switch to Parent Frame
    And Wait for "2" Seconds

  # Step 27
    Then Go to Home Page
    Then Run "CarrierMonitorMCPJob" Job
    Then Wait for "6" Seconds

  # Step 28
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "MCP Carrier 2947 Blocked Carrier" from List
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP2_MCP"
    Then Go to "Compliance" Tab

  # Stp 29 & Expected result r
    Then Scroll into Section "Motor Carrier Analysis  (powered by My Carrier Portal)"
    Then Verify Label Checkbox
      | Blocked Carrier |
      | true            |

    Then Search and Select "rtms__CarrierService__c" "MCP Carrier 2947 Blocked Carrier" from the Global search
    Then Capture the current URL for "Carrier_Service2_MCP"
    Then Search and Select "MCP Carrier 2947 Blocked Carrier" Account from the Global search
    Then Capture the current URL for "Account2_MCP"