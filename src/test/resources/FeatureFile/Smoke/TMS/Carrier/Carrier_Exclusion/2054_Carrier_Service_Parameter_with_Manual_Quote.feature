Feature: 2054 - Carrier Exclusions- Carrier Service Parameter with Manual Quote


  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Carrier_Exclusion @2054
  Scenario: 2054 - Carrier Exclusions- Carrier Service Parameter with Manual Quote

    When Login into Salesforce

     #Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Carrier Exclusions"
    #Step 2
    Then Wait for "1" Seconds
    Then Click on link "Carrier Exclusions"
    Then Click on button "New"
    Then Wait for "2" Seconds
    Then Update details
      |Carrier|Carrier Service|Exclusion Type|
      |Stored Rate Carrier One|Stored Rate Carrier One - Truckload|Exclude Pickup and Delivery|
    #Step 3
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Click on "Exclusion-" with Contains Text
    Then Wait for "2" Seconds
    Then Set Key "Carrier_Exclusion" page Record Id with "rtms__CarrierExclusion__c"

    #Steps4
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans |     LTL      | Dry Van 53     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                   | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots     |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Mixed     |4000  |NA          |8       |Pallets       |24    |24   |24    |NA            |50        |

    #Steps 5
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 6 
    Then Go to "Freight Quote Assistant" Tab
     Then Wait for "8" Seconds
    Then Update details
         |Carrier Service|
         |Stored Rate Carrier One|
    Then Wait for "2" Seconds
    #Expected a
    Then Verify Available Option displaying as "Stored Rate Carrier One - LTL"

   #Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Boston Beans | Truckload | Dry Van 48     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed     |12345 |NA          |NA       |NA       |
     #Steps 8
    Then Save Load With All details
     #Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      |Carrier Service|
      |Stored Rate Carrier|
    Then Wait for "2" Seconds
    #Expected b
    Then Verify Available Option displaying as "Stored Rate Carrier Two - Truckload"
    Then Verify Available Option Not displaying as "Stored Rate Carrier One - Truckload"














