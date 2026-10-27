Feature: Comdata API- Fuel Card- Issue One-Time Limit

  @2736 @API @Regression@TMS @Smoke @WEB @API_Operation
  Scenario: 2736 - Comdata API- Fuel Card- Issue One-Time Limit

    #step1
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Comdata" in the "Search Credentials..." search box
    Then Select the "Comdata" record from the lookup field results
    And Update details for "Comdata" service
      | Fuel Cards |
      | True       |
    And Click on Native "Save" button
    #step2
  # Run FuelCardJob
    Then Go to Home Page
    Then Click on Run Now for "FuelCardJob"
    Then Wait for "2" Seconds
    Then Refresh current Page
    Then Verify "FuelCardJob" Details
      | Status                    |
      | Not Running or Scheduled! |

    #Fuel card inactive check
    Then Wait for "2" Seconds
    Then Open "Fuel Cards" from App Launcher
    Then Wait for "2" Seconds
    Then Search and Select "224W64R4L6" from List
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Card Information" -
    Then Verify "Status" having not contains value of "Active"
    Then Scroll into Section "TMS Assignment" -
    Then Verify Details
      | Employee Number |
      |                 |

    #Step3 Set the Driver's Fuel Card Driver Number
    Then Open "Drivers" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "Bruce Fleet Carrier Two 35" from List
    Then Click on Edit icon on Label "Fuel Card Driver Number"
    Then Update details
      | Fuel Card Driver Number |
      | BFCT35                  |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Fuel Card Driver Number |
      | BFCT35                  |

    # step4 Open the Fuel Card and record its initial values
    Then Open "Fuel Cards" from App Launcher
    Then Search and Select "224W64R4L6" from List
    Then Go to "Details" Tab
    Then Scroll into Section "Comdata Limits" -
    #step5
    Then Get Details
      | Cash Limit           | Fuel Limit|Cash Used|Fuel Used|One-Time Cash Limit|One-Time Fuel Limit|Card Balance|
      |                      |           |         |         |                   |                   |            |

    # step6,7  Issue a Cash one-time limit of 100
    Then Scroll into Section "Fuel Card Control Panel" -
    Then Wait for "2" Seconds
    Then Click on button "Issue One-Time Limit"
    Then Update details
      | Amount | Type |
      | 100    | Cash |
    Then Click on button "Issue"
    # Expected result a
    Then Verify Message displaying with Text "Success - Fuel Card Banner"
    Then Verify Message displaying as "One-time limit set."
    Then Verify Modal close
    # step8 Expected result b: Cash limit becomes 100.00; all other recorded values remain unchanged
    Then Scroll into Section "Comdata Limits" -
    Then Verify Details
      | Cash Limit          | Fuel Limit | Cash Used | Fuel Used | One-Time Cash Limit | One-Time Fuel Limit | Card Balance |
      | 0.00                | 0.00       | 0.00      | 0.00      | 100.00              | 0.00                | 0.00         |

    # step9,10 Issue a Fuel one-time limit of 150
    Then Scroll into Section "Fuel Card Control Panel" -
    Then Wait for "2" Seconds
    Then Click on button "Issue One-Time Limit"
    Then Update details
      | Amount | Type |
      | 150    | Fuel |
    Then Click on button "Issue"
    # step11 Expected result c: only the One-Time Fuel Limit changes
    Then Verify Message displaying with Text "Success - Fuel Card Banner"
    Then Verify Message displaying as "One-time limit set."
    Then Verify Modal close
    Then Scroll into Section "Comdata Limits" -
    Then Verify Details
      | Cash Limit | Fuel Limit | Cash Used | Fuel Used | One-Time Cash Limit | One-Time Fuel Limit | Card Balance |
      | 0.00       | 0.00       | 0.00      | 0.00      | 100.00              | 150.00              | 0.00         |

    #step12,13 Replace the Cash one-time limit with 10
    Then Scroll into Section "Fuel Card Control Panel" -
    Then Wait for "2" Seconds
    Then Click on button "Issue One-Time Limit"
    Then Update details
      | Amount | Type |
      | 10     | Cash |
    Then Click on button "Issue"
    #step14 Expected result d: the Cash limit is overwritten, not added to
    Then Verify Message displaying with Text "Success - Fuel Card Banner"
    Then Verify Message displaying as "One-time limit set."
    Then Verify Modal close
    Then Scroll into Section "Comdata Limits" -
    Then Verify Details
      | Cash Limit | Fuel Limit | Cash Used | Fuel Used | One-Time Cash Limit | One-Time Fuel Limit | Card Balance |
      | 0.00       | 0.00       | 0.00      | 0.00      | 10.00               | 150.00              | 0.00         |

    # step 15,16 Assign the Fuel Card to the Driver
    Then Scroll into Section "Fuel Card Control Panel" -
    Then Click on button with Title Contains "Edit"
    Then Update details
      | Assignment Type | Driver                       |
      | Driver          | Bruce Fleet Carrier Two 35   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Scroll into Section "TMS Assignment" -
    Then Verify Details
      | Employee Number |
      | BFCT35          |

    # step 17 Activate the Fuel Card
    Then Scroll into Section "Fuel Card Control Panel" -
    Then Wait for "2" Seconds
    Then Click on Partial Link Text "Show menu" on Page
    Then Wait for "1" Seconds
    Then Click on Partial Link Text "Activate" on Page
    Then Wait for "3" Seconds
    Then Scroll into Section "Card Information" -
    Then Verify Details
      | Status |
      | Active |

    #step18,19 Issue a Cash one-time limit of 1234.56
    Then Scroll into Section "Fuel Card Control Panel" -
    Then Wait for "2" Seconds
    Then Click on button "Issue One-Time Limit"
    Then Update details
      | Amount  | Type |
      | 1234.56 | Cash |
    Then Click on button "Issue"
    # Expected result e
    Then Verify Message displaying with Text "Success - Fuel Card Banner"
    Then Verify Message displaying as "One-time limit set."
    Then Verify Modal close
    # step20 Expected result f: the Cash limit is overwritten, not added to
    Then Scroll into Section "Comdata Limits" -
    Then Verify Details
      | Cash Limit | Fuel Limit | Cash Used | Fuel Used | One-Time Cash Limit | One-Time Fuel Limit | Card Balance |
      | 0.00       | 0.00       | 0.00      | 0.00      | 1,234.56             | 150.00              | 0.00         |

    # step21,22 Issue a Cash one-time limit of zero
    Then Scroll into Section "Fuel Card Control Panel" -
    Then Wait for "2" Seconds
    Then Click on button "Issue One-Time Limit"
    Then Update details
      | Amount | Type |
      | 0      | Cash |
    Then Click on button "Issue"
    # Expected result g
    Then Verify Message displaying with Text "Success - Fuel Card Banner"
    Then Verify Message displaying as "One-time limit set."
    Then Verify Modal close
    # Step23 Expected result h
    Then Scroll into Section "Comdata Limits" -
    Then Verify Details
      | Cash Limit | Fuel Limit | Cash Used | Fuel Used | One-Time Cash Limit | One-Time Fuel Limit | Card Balance |
      | 0.00       | 0.00       | 0.00      | 0.00      | 0.00                | 150.00              | 0.00         |

    # step24 ,25 Reject a negative one-time limit
    Then Scroll into Section "Fuel Card Control Panel" -
    Then Wait for "2" Seconds
    Then Click on button "Issue One-Time Limit"
    Then Update details
      | Amount | Type |
      | -120   | Cash |
    Then Click on button "Issue"
    # Expected result i
    Then Verify Error Message displaying with "The number is too low."
    # step26 Set a Fuel one-time limit of zero
    Then Update details
      | Amount | Type |
      | 0      | Fuel |
    Then Click on button "Issue"
    # step27 Expected result j
    Then Verify Message displaying with Text "Success - Fuel Card Banner"
    Then Verify Message displaying as "One-time limit set."
    Then Verify Modal close
    # step28 Expected result k
    Then Scroll into Section "Comdata Limits" -
    Then Verify Details
      | Cash Limit | Fuel Limit | Cash Used | Fuel Used | One-Time Cash Limit | One-Time Fuel Limit | Card Balance |
      | 0.00       | 0.00       | 0.00      | 0.00      | 0.00                | 0.00                | 0.00         |
