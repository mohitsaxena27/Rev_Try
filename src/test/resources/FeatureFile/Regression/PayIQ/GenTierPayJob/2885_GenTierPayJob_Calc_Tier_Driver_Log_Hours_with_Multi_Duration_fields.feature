Feature: 2885 - GenTierPayJob- Calc Tier: Driver Log Hours with Multi-Duration fields

  @API @Regression @PayIQ  @WEB @SingleCurrency @2885 @GenTierPayJob
  Scenario: 2885 - GenTierPayJob- Calc Tier: Driver Log Hours with Multi-Duration fields


    When Login into Salesforce
    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    #Step 2
    Then Search and Select "PayIQProgram Driver Pay - Driver Logs" from List
    #Step 3
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Open|
    Then Click on "SaveEdit" button
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 4
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times
    Then Click on "Calculation Tier-" with "Calculation Description" as "Rate per Driver Log (Driving Duration) Hour" and "From (>)" as "100.00" and "To (<=)" as "500.00"
    Then Wait for "2" Seconds
    Then Get Details
      |Calculation Tier ID|
      |                   |

    #Step 5
    Then Click on Edit icon on Label "Criteria Driver Log Duration Field(s)"
    Then Select "Criteria Driver Log Duration Field(s)" as "Yard Move Duration" from Dueling List
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Capture the current URL for "Calculation_Tier_Page"
    #Step 6
    Then Open "Driver Logs" from App Launcher
    Then Wait for "5" Seconds
    Then Click on button with Title "New"
    Then Update details
      |Driver Log Name|Driver                    |Date|Time        |Date_2|Time_2|
      |               |Dave Fleet Carrier One 10 |0   |12:00 PM       |3            |12:00 PM     |

    Then Update details
      |Driving Duration|On Duty Duration|Yard Move Duration|
      |225             |275             |150               |

    Then Update details
      |Certification Status|
      |Certified           |

    Then Update Legend details
      |Certified as of, Date|Certified as of, Time|
      |0                    |12:00 PM             |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Set Key "Driver_SFID_1" page Record Id with "rtms__DriverLog__c"

    #Step 7
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 8
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"

    #Step 8 a)
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 9
   Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 10
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID" and "Participant Name" as "Dave Fleet Carrier One 10 (Driver)"

    # Expected result a)
    Then Wait for "3" Seconds
    Then Verify Details
      | Pay Amount | Pay Header  |
      | USD 6,750.00  | Pay Header- |

    #Step 11
    Then Go to "Logs" Tab
    Then Wait for "4" Seconds
    #expected result b)
    Then Verify Logs displaying as "[Within {Calculation Tier ID} calculation] = [From] < [Individual Driver Log (On Duty Duration + Yard Move Duration) Hours] <= [To] = 100 < 425 <= 500"

    #Step 12
    #Expected Result c)
    Then Verify Logs displaying as "[{Calculation Tier ID} Pay Amount] = [Driver Log Driving Duration (Hours)] x [Amount] = 225 x 30 USD = 6,750 USD"














