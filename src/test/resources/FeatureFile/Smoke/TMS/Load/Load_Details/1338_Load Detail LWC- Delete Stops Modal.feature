Feature: 1338 - Load Detail LWC- Delete Stops Modal

  @Regression @TMS @Smoke @API @WEB @Load @SingleCurrency @Load_Details @1338

  Scenario: 1338 - Load Detail LWC- Delete Stops Modal

    When Login into Salesforce

  #Step1 - Create Quick Entry Shipment
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | LTL       |NA              | N             | N                 |
    Then Wait for "2" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | Y       | 2P   | Account_Address | Chicago Bulls       | 2             | NA                       | NA                 | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | Y       | 3P   | Account_Address | Denver Deli Meats   | 3             | NA                       | NA                 | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | N       | 4D   | Account_Address | Denver Deli Meats   | 3             | NA                       | NA                 | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 5D   | Account_Address  | Los Angeles Lighting  | 5             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 6D   | Account_Address  | Los Angeles Dodgers | 5             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D4      |Bananas    |12000 |NA          |NA      |NA            |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |2        |P2    |D5      |Grapes     |5000  |NA           |NA       |NA          |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description |Weight|Weight_Units|HU_Count|Handling_Units|
      |3        |P3    |D6      |Strawberries|1300  |NA          |NA       |NA           |
    Then Save Load With All details

  # Expected a
    Then Hover over on "Delete Stops" icon and verify icon text is "Delete Stops"
  #Step 3 & Expected c
    Then Select Delete Stops for "1P" Stop under Load Details
    Then Get and Verify Delete Stops pop-up details
    |Stop 1       |Stop 2       |Stop 3           |Stop 4           |Stop 5              |Stop 6             |
    |Chicago Pizza|Chicago Bulls|Denver Deli Meats|Denver Deli Meats|Los Angeles Lighting|Los Angeles Dodgers|
    Then Click on Native "Cancel" button
  #Step 4 & Expected d
    Then Wait for "2" Seconds
    Then Delete "1P" Stop from Load Details with reason "Delete stop and move associated line items"
    Then Update details
    |Pickup|
    |Stop 2|
    Then Click on Native "Cancel" button
  #Step 5 & Expected e
    Then Wait for "2" Seconds
    Then Delete "1P" Stop from Load Details with reason "Delete stop and move associated line items"
    Then Update details
      |Pickup|
      |Stop 2|
    Then Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Delete was successful."
    Then Verify Stop count is "5"

  #Step 6 & Expected f
    Then Wait for "2" Seconds
    Then Delete "5D" Stop from Load Details with reason "Delete stop and associated line items"
    Then Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Delete was successful."
    Then Verify Message displaying as "Invalid Load Configuration: Stops without line items."
    Then Verify Stop count is "4"