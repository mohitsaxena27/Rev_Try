Feature: 658 - Carrier Service- Threshold: Maximum Volume
  @Regression  @WEB @SingleCurrency @Carrier @Carrier_Service @658
  Scenario: 658 - Carrier Service- Threshold: Maximum Volume
    When Login into Salesforce
    #Steps1
#    Then Search and Select "rtms__CarrierService__c" "Stored Rate Carrier Two - LTL" from the Global search
    Then Open "Transportation Profiles" from App Launcher

    Then Search and Select "Stored Rate Carrier Two" from List

    Then Click on "Carrier Service" Link Text "Stored Rate Carrier Two - LTL" on Page

    Then Scroll into Section "Load Weight & Volume Thresholds"
    Then Wait for "2" Seconds
    Then Scroll Up with "4" Times
    Then Click on Edit icon on Label "Maximum Volume"
    
    Then Enter Label "Maximum Volume" Text as "1"
    Then Update details
      |Volume Units|
      |Cubic Feet            |
    Then Enter Label "Maximum Volume" Text as "1"

    Then Click on "Save" button
    Then Wait for "5" Seconds
    Then Scroll into Section "Load Weight & Volume Thresholds"
    Then Verify "Maximum Volume" having value of "1"
    Then Capture the current URL for "Transportion_URL"

     #Steps 2
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Denver Deli Meats | LTL      | Dry Van 53     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  5             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Material     |8000  |NA          |2       |Pallets       |45    |45   |45    |NA            |50        |

    Then Save Load With All details

    #Step 3
    Then Scroll into Section "Denver Deli Meats"
    Then Expand "Items" for "1" Load
    Then Click on "Item 1" with Text
    Then Wait for "2" Seconds
    Then Switch Window by index "1"
    
    #Step 4
    Then Click on Edit icon on "Volume"
    Then Enter Label "Volume" Text as "10"
    Then Update details
    |Volume Units|
    |Cubic Feet            |
    Then Click on "Save" button

    #Step 5
    Then Click on Partial Link Text "L-" on Page

    #Step6 and expected result a
    Then Go to "Freight Quote Assistant" Tab
     Then Wait for "5" Seconds
    Then Verify Text displaying as "New Carrier Quote"
    
    Then Verify "Carrier Service" having value of ""

    Then Verify Carrier "Quote Total" displaying as "0"

    #Step 7
  Then Navigate to stored URL for "Transportion_URL"
    Then Scroll into Section "Load Weight & Volume Thresholds"
    Then Click on Edit icon on Label "Maximum Volume"

    Then Enter Label "Maximum Volume" Text as ""

    Then Click on "Save" button

    Then Verify "Maximum Volume" having value of ""

    #Step 8
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Denver Deli Meats | LTL      | Dry Van 53     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  5             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Material     |8000  |NA          |2       |Pallets       |45    |45   |45    |NA            |50        |

    Then Save Load With All details

    #Step 9

    Then Scroll into Section "Denver Deli Meats"
    Then Expand "Items" for "1" Load
    Then Click on "Item 1" with Text
    Then Wait for "2" Seconds
    Then Switch Window by index "2"

    Then Wait for "3" Seconds
    Then Click on Edit icon on "Volume"
    Then Enter Label "Volume" Text as "10"
    Then Update details
    |Volume Units|
    | Cubic Feet           |
    Then Click on "Save" button


    Then Click on Partial Link Text "L-" on Page

    #step 10 and expected result b
    Then Go to "Freight Quote Assistant" Tab

    Then Verify Message displaying as "Stored Rate Quote(s) created."
    Then Verify "Carrier Service" Link value displaying as "Stored Rate Carrier Two - LTL"











