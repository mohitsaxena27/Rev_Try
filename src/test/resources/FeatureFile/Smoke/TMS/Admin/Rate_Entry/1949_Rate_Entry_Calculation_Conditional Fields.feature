Feature:1949 - Rate Entry Detail LWC- Rate Entry Calculation- Conditional Fields

  @Regression @TMS @Smoke @WEB @Admin @SingleCurrency  @TMS_Rate_Entry @1949
  Scenario: 1949 - Rate Entry Detail LWC- Rate Entry Calculation- Conditional Fields


    When Login into Salesforce
# Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
  #Step 2
    Then Scroll into Section "General Information"
    Then Update details
      | Transportation Profile | Mode | Lane     | Category | Currency ISO Code |
      | Boston Beans           | LTL  | US to US | Customer | USD - U.S. Dollar |

    #Step 3
    Then Update details
      | Rate Type                |
      | Freight+Fuel+Accessorial |
    Then Wait for "2" Seconds
    #Expected a
    Then Scroll into Section "Base Rate Calculation"
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method | Rate |
      | --None--    |      |

    #Step 4
    Then Scroll into Section "General Information"
    Then Update details
      | Rate Type    |
      | Freight+Fuel |
    Then Wait for "2" Seconds
    #Expected b
    Then Scroll into Section "Base Rate Calculation"
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method | Rate |
      | --None--    |      |
    Then Verify details for all Enabled fields
      | Distance Override |
      |                   |

    #Step 5
    Then Update details
      | Distance Override |
      | 700               |
    #Step 6
    Then Scroll into Section "General Information"
    Then Update details
      | Rate Type |
      | Freight   |
    Then Wait for "2" Seconds
    #Expected c
    Then Scroll into Section "Base Rate Calculation"
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method | Rate |
      | --None--    |      |
    Then Verify Text not displaying as "Distance Override"
        #Step 7
    Then Update details
      | Rate Method   |
      | Per Kilometer |
    Then Wait for "2" Seconds
    #Expected d
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method | Rate |
      | Per Kilometer    |      |
    Then Verify details for all Enabled fields
      | Distance Override |
      |                   |
     #Step 8
    Then Update details
      | Distance Override | Rate |
      | 800               | 1.25 |
     #Step 9
    Then Update details
      | Rate Method |
      | Per Mile    |
    Then Wait for "2" Seconds
      #Expected e
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method | Rate |
      | Per Mile    | 1.25 |
    Then Verify details for all Enabled fields
      | Distance Override |
      | 800.000           |

      #Step 10
    Then Update details
      | Rate Method |
      | Per HU Position    |
    Then Wait for "2" Seconds
      #Expected f
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method        |Handling Units|HU Calculation Method| Rate |
      | Per HU Position    |--None--      |--None--             | 1.2500 |
    Then Verify details for all Enabled fields
      | HU Max Weight |Weight Units|
      |               |lbs         |

    #Step 11
    Then Update details
      |Handling Units|HU Calculation Method|
      |Pallets       |Actual             |
    Then Wait for "2" Seconds
      #Expected g
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method        |Handling Units|HU Calculation Method| Rate |
      | Per HU Position    |Pallets       |Actual             | 1.2500 |
    Then Verify details for all Enabled fields
      | HU Max Weight |Weight Units|
      |               |lbs         |

    #Step 12
    Then Update details
      | HU Max Weight |Weight Units|HU Calculation Method|
      | 400           |cwt         |Adjusted by HU Max Weight|
    Then Wait for "2" Seconds
    #Expected h
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method        |Handling Units|HU Calculation Method|HU Max Weight| Rate |
      | Per HU Position    |Pallets       |Adjusted by HU Max Weight |400.00  | 1.2500 |
    Then Verify details for all Enabled fields
      |Weight Units|
      |cwt         |
     #Step 13
    Then Update details
      | Rate Method |
      | Per Packaging Unit    |
    Then Wait for "2" Seconds

    #Expected i
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Packaging Units      | Rate |
      | Per Packaging Unit    |--None--             | 1.2500 |
     #Step 14
     Then Update details
         |Packaging Units|
         |Spools|
     Then Wait for "2" Seconds
     #Expected j
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Packaging Units      | Rate |
      | Per Packaging Unit    |Spools             | 1.2500 |

     #Step 15
    Then Update details
      | Rate Method |
      | Per Equipment Type    |
    Then Wait for "2" Seconds

    #Expected k
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Equipment Type      | Rate |
      | Per Equipment Type    |                    | 1.2500 |

     #Step 16
      Then Enter Rate Entry "Equipment Type" Text as "Dry Van"
      Then Wait for "2" Seconds
    #Expected l
     Then Verify Title displaying as "Dry Van 53"
     Then Verify Title displaying as "Dry Van 48"
     Then Verify Title displaying as "Dry Van 45"
     Then Verify Title displaying as "Dry Van 43"
     Then Verify Title displaying as "Dry Van 42"

    #Step 17
     Then Click on button with Title Contains "Dry Van 48"
     Then Wait for "2" Seconds
     #Expected m
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Equipment Type      | Rate |
      | Per Equipment Type    |Dry Van 48'         | 1.2500 |

         #Step 18
    Then Update details
      | Rate Method |
      | Percent of Amount    |
    Then Wait for "2" Seconds

    #Expected n
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Amount Field        | Rate |
      | Percent of Amount     |                    | 1.2500 |
     #Step 19
    Then Update details
      |Amount Field                 |
      |Customer Quote - Customer Quote Total|
    Then Wait for "2" Seconds

    #Expected o
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Amount Field                  | Rate |
      | Percent of Amount     |Customer Quote - Customer Quote Total | 1.2500 |


     #Step 20
    Then Scroll into Section "General Information"
    Then Update details
       | Category |
       | Carrier |
    Then  Wait for "2" Seconds
        #Expected p
    Then Scroll into Section "Base Rate Calculation"
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Amount Field        | Rate |
      | Percent of Amount     |                    | 1.2500 |

    #Step 21
    Then Update details
      |Amount Field                 |
      |Carrier Quote - Accessorial Charges|
    Then Wait for "2" Seconds

    #Expected q
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Amount Field                  | Rate |
      | Percent of Amount     |Carrier Quote - Accessorial Charges | 1.2500 |


         #Step 22
    Then Update details
      | Rate Method |
      | Per 100.00 of Amount    |
    Then Wait for "2" Seconds
    
    #Expected r
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Amount Field                  | Rate |
      | Per 100.00 of Amount  |Carrier Quote - Accessorial Charges | 1.2500 |

        #Step 23
    Then Update details
      |Amount Field                 |
      |Load - Cargo Value           |
    Then Wait for "2" Seconds

    #Expected s
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Amount Field                  | Rate |
      | Per 100.00 of Amount  |Load - Cargo Value            | 1.2500 |

    #Step 24
    Then Scroll into Section "General Information"
    Then Update details
      | Category |
      | Customer |
    Then  Wait for "2" Seconds
        #Expected p
    Then Scroll into Section "Base Rate Calculation"
     #Expected t
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Amount Field                  | Rate |
      | Per 100.00 of Amount  |Load - Cargo Value            | 1.2500 |

    #Step 25
    Then Scroll into Section "General Information"
    Then Click on "Save" with Text
    #Expected u
    Then Verify Message displaying as "Save was successful."
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_1"
    Then Scroll into Section "Base Rate Calculation"
    Then Verify details for all Disabled or Readonly fields
      | Calculation Type |
      | Base             |
    Then Verify details for all Required Enabled fields
      | Rate Method           |Amount Field                  | Rate |
      | Per 100.00 of Amount  |Load - Cargo Value            | 1.2500 |