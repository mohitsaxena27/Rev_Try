Feature: 2051 - RMIS API- Get Carrier Operation

  Background: Pre- Test
    Then Delete Field with Title "RMISGetNewOrUpdatedCarriersOperation"
    Then Delete Field with Title "RMISGetCarrierOperation"

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2051 @RMIS_API
  Scenario: 2051 - RMIS API- Get Carrier Operation

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

    Then Search text "MyCarrierPackets" in the "Search Credentials..." search box
    Then Select the "MyCarrierPackets" record from the lookup field results
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
    Then Search text "RMIS" in the "Search Credentials..." search box
    Then Select the "RMIS" record from the lookup field results
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
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

  # Step 3,4,5

    Given Upload File "RMISGetCarrierOperation 2.txt" with Title "RMISGetCarrierOperation"
    Given Upload File "RMISGetNewOrUpdatedCarriersOperation-InsdID3463610 Almas.txt" with Title "RMISGetNewOrUpdatedCarriersOperation"

  # Step 6
    Then Go to Home Page
    Then Run "CarrierMonitorRMISJob" Job until Previous Run Time is not blank

  # Step 7
    Then Delete "CarrierMonitorRMISJob" from Apex job
    Then Wait for "1" Seconds

    #Step 8
    Then Search and Select "rtms__CarrierService__c" "Almas Express Inc - LTL" from the Global search
    Then Wait for "4" Seconds

   # Expected result a
    Then Scroll into Section "General Information"
    Then Verify Details
      | Name             | Carrier Service Owner | Credentials | API Provider |
      | Almas Express Inc - LTL |                       |             |              |

    Then Verify Label Checkbox
      | Enabled |
      | true    |

    Then Scroll into Section "Carrier Information"
    Then Verify Details
      | Carrier          | Transportation Profile | Mode      | Service Notes | Rating |
      | Almas Express Inc | Almas Express Inc       | LTL |               |        |

    Then Scroll into Section "Carrier Quote  & Settlement Contacts (Default)"
    Then Verify Details
      | Quote Contact | Quote Method | Settlement Contact |
      | Jeff Beks  | Email        | Jeff Beks |

    Then Scroll into Section "Carrier Booking Contact (Default)"
    Then Verify Details
      | Tender Contact | Tender Method | Load Tender Page Settings | EDI Provider |
      | Jeff Beks   | Email         |                           |              |

    Then Verify Label Checkbox
      | Pickup Only |
      | false       |

    Then Scroll into Section "Carrier Status Contact (Default)"
    Then Verify Details
      | Status Contact | Status Method |
      | Jeff Beks   | Email         |

    Then Verify Label Checkbox
      | Batch Status Emails |
      | true                |

    Then Scroll into Section "Load Weight & Volume Thresholds"
    Then Verify Details
      | Minimum Weight | Maximum Weight | Weight Units | Maximum Volume | Volume Units | Minimum Linear Feet | Maximum Linear Feet |
      | 100            | 18,000         | lbs          |                |              |                     |                     |

    Then Verify Label Checkbox
      | VLTL  |
      | false |

    Then Scroll into Section "Handling Unit Thresholds"
    Then Verify Details
      | Maximum HU Length | Maximum HU Width | Maximum HU Height | Dimension Units | Maximum HU Count | Maximum HU Weight |
      |                   |                  |                   | in              |                  |                   |

    # Step 9
    Then Search and Select "rtms__TransportationProfile__c" "Almas Express Inc" from the Global search
    Then Go to "Carrier Operations" Tab

    # Expected result b
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Verify Details
      | SCAC |
      | ALMS   |
    Then Scroll into Section "Fleet Summary"
    Then Verify Details
      | Fleet Size | Total Power Units | Number of Drivers |
      | 8          | 8                 | 8                 |

    Then Scroll into Section "US Registration"
    Then Verify Details
      | MC/MX/FF Number | US DOT Number |
      | 1382925        | 3821393       |

  #Step 9.a
    Then Go to "Settlement" Tab
   # Expected result c
    Then Scroll into Section "Tax Information"
    Then Verify Details
      | W9 Address | W9 City | W9 State | Federal Tax ID |
      | 10900 Bustleton Ave Apt C4 |  Philadelphia       |   PA     |******6269  |
    Then Verify Label Checkbox
      | W9 Validated |
      | true        |

    Then Scroll into Section "Carrier Remittance Information"
    Then Verify Details
      | Carrier Remit To | Carrier Pay To Name |
      | RTS Financial Service Inc | RTS Financial Service Inc |

  # Step 9.b
    Then Go to "Compliance" Tab

  #Expected d
    Then Scroll into Section "Motor Carrier Analysis (powered by RMIS)"
    Then Verify Details
      |  RMIS ID  | RMIS Certified  |
      | 3463610  | Yes |

    Then Scroll into Section "SAFER Snapshot"
    Then Verify Details
      | Out of Service | Out of Service Date | Safety Rating | Safety Rating Date | Authority Granted Date | Common Authority Status | Contract Authority Status | Broker Authority Status |
      | No             |                     | Not Rated     |                    | 3/4/2022             | Active                | None                      | None                    |

    Then Scroll into Section "CARB Snapshot"
    Then Verify Details
      | CARB-TRU Compliance Type | CARB-TRU Compliant Vehicles Reported | CARB-TRU Non-Compliant Reason | CARB-TRU Certificate Expiration Date |
      |                          |   0    |  I operate in California, but am not currently CARB Truck and Bus compliant.|   12/31/2023 |

    Then Scroll into Section "SAFER Authority Alerts"
    Then Verify Details
      | Common Authority Pending | Contract Authority Pending | Broker Authority Pending | Common Authority Revocation | Contract Authority Revocation | Broker Authority Revocation |
      | No                       | No                         | No                       | No                          | No                            | No                          |

  # Step 10
    Then Scroll Until Related List for "Insurance Policies"
    Then Scroll into Section "Insurance Policies"
    Then Wait for "2" Seconds
# Step 10.a
    Then Click on "IMC H25549053" with Text
 # Expected result e
    Then Scroll into Section "Policy Information"
    Then Verify Details
      | Insurance Company              | Type  | Source | Policy Number | Description | Coverage Amount | Effective Date | Expiry Date | Cancel Date | Deductible | Reefer Breakdown Coverage | Reefer Breakdown Deductible |
      | Ace American Insurance Company | Cargo | RMIS   | IMC H25549053 | CARGO       | USD 250,000.00  | 9/15/2022      | 4/1/2024    |             |            |                           |                             |

    Then Scroll into Section "Agent Information"
    Then Verify Details
      | Agent First Name | Agent Last Name | Agent Title | Agent Email           | Agent Phone  | Fax          | Agent Company                    | Address                        | City    | State/Province | Postal Code | Phone        |
      |                  |                 |             | certs@mohaveinsco.com | (480) 579-2500 | (480) 579-2404 | Transtar Insurance Brokers, Inc. | 5450 E. High Street, Suite 230 | Phoenix | AZ             | 85054       | (480) 579-2500 |

  # Step 11,12
    Then Search and Select "rtms__TransportationProfile__c" "Almas Express Inc" from the Global search
    Then Go to "Compliance" Tab
    Then Scroll Until Related List for "Insurance Policies"
    Then Scroll into Section "Insurance Policies"
    Then Wait for "2" Seconds
    Then Click on "MMT H25549090" with Text
  # Expected result f
    Then Scroll into Section "Policy Information"
    Then Verify Details
      | Insurance Company                            | Type | Source | Policy Number | Description | Coverage Amount | Effective Date | Expiry Date | Cancel Date | Deductible | Reefer Breakdown Coverage | Reefer Breakdown Deductible |
      | Indemnity Insurance Company of North America | Auto | RMIS   | MMT H25549090 | AUTO        |  USD 1,000,000.00 | 9/15/2022        | 4/1/2024    |             |            |                           |                             |

    Then Scroll into Section "Agent Information"
    Then Verify Details
      | Agent First Name | Agent Last Name | Agent Title | Agent Email           | Agent Phone  | Fax          | Agent Company                    | Address                        | City    | State/Province | Postal Code | Phone        |
      |                  |                 |             | certs@mohaveinsco.com | (480) 579-2500 | (480) 579-2404 | Transtar Insurance Brokers, Inc. | 5450 E. High Street, Suite 230 | Phoenix | AZ             | 85054       | (480) 579-2500 |

# Step 13,14
    Then Search and Select "rtms__TransportationProfile__c" "Almas Express Inc" from the Global search
    Then Go to "Compliance" Tab
    Then Scroll Until Related List for "Insurance Policies"
    Then Scroll into Section "Insurance Policies"
    Then Wait for "2" Seconds
    Then Click on "CGO G72486183" with Text
     # Expected result g
    Then Scroll into Section "Policy Information"
    Then Verify Details
      | Insurance Company                            | Type    | Source | Policy Number | Description | Coverage Amount | Effective Date | Expiry Date | Cancel Date | Deductible | Reefer Breakdown Coverage | Reefer Breakdown Deductible |
      | Indemnity Insurance Company of North America | General | RMIS   | CGO G72486183 | GENERAL     | USD 1,000,000.00   | 9/15/2022        | 4/1/2024    |             |            |                           |                             |

    Then Scroll into Section "Agent Information"
    Then Verify Details
      | Agent First Name | Agent Last Name | Agent Title | Agent Email           | Agent Phone  | Fax          | Agent Company                    | Address                        | City    | State/Province | Postal Code | Phone        |
      |                  |                 |             | certs@mohaveinsco.com | (480) 579-2500 | (480) 579-2404 | Transtar Insurance Brokers, Inc. | 5450 E. High Street, Suite 230 | Phoenix | AZ             | 85054       | (480) 579-2500 |
# Step 15,16
    Then Search and Select "rtms__TransportationProfile__c" "Almas Express Inc" from the Global search
    Then Go to "Compliance" Tab
    Then Scroll Until Related List for "Insurance Policies"
    Then Scroll into Section "Insurance Policies"
    Then Wait for "2" Seconds
    Then Click on "ICSA00001" with Text
   # Expected result h
    Then Scroll into Section "Policy Information"
    Then Verify Details
      | Insurance Company                | Type  | Source | Policy Number | Description                           | Coverage Amount | Effective Date | Expiry Date | Cancel Date | Deductible | Reefer Breakdown Coverage | Reefer Breakdown Deductible |
      | Harco National Insurance Company | Other | RMIS   | ICSA00001     | NON-OWNED TRAILER/TRAILER INTERCHANGE | USD 50,000.00      | 9/15/2022        | 8/1/2025    |             |            |                           |                             |

    Then Scroll into Section "Agent Information"
    Then Verify Details
      | Agent First Name | Agent Last Name | Agent Title | Agent Email           | Agent Phone  | Fax          | Agent Company                    | Address                        | City    | State/Province | Postal Code | Phone        |
      |                  |                 |             | certs@mohaveinsco.com | (480) 579-2500 | (480) 579-2404 | Transtar Insurance Brokers, Inc. | 5450 E. High Street, Suite 230 | Phoenix | AZ             | 85054       | (480) 579-2500 |
 #Step 17,18
    Then Search and Select "Almas Express Inc" Account from the Global search
    Then Wait for "3" Seconds

     # Expected result I
    Then Scroll into Section "General Information"
    Then Verify Details
      | DBA Name | TMS Type         | Phone        |
      |          | Carrier (Ground) | (215) 987-6970 |

    Then Scroll into Section "Address Information"
    Then Get Details
      |Shipping Address|Billing Address|
      |                |               |
    Then Wrap "Shipping Address" in one line
    Then Wrap "Billing Address" in one line
    Then Verify Assertion for "Shipping Address" contains "10900 Bustleton Ave Apt C4 Philadelphia, Pennsylvania 19116 United States"
    Then Verify Assertion for "Billing Address" contains "United States"
    # Step 19
    Then Go to "Contacts" Tab
    Then Click the "Jeff Beks" from grid

      # Expected result J
    Then Scroll into Section "Details"
    Then Verify Details
      | Name      | Transportation Role                             | Phone        | Title   | Mobile | Department | Email  | Reports To | Fax |
      | Jeff Beks | Shipping;Receiving;Quoting;Tendering;Status | (215) 987-6970 | Manager |        |            | almasdispatch@gmail.com |            |     |

    Then Scroll into Section "Address Information"
    Then Verify Details
      | Mailing Address |
      | United States   |

