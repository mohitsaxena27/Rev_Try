Feature: 1107 - Field Set Load TMS16 - Non Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1107 @Field_Set
  Scenario: 1107 - Field Set Load TMS16 - Non Mode Specific
    When Login into Salesforce
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Edit Object" from Setup Icon
    Then Switch Window by index "1"
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Open Field Sets "TMS16" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Delete Fields if any available with Field Set
    Then Add the Following Fields in this Order
      |Order Date|Import/Export|Carrier Portal|Cargo Summary|Booking Number|Max Pay Amount|Offer Rate|Carrier Sales Rep|Vendor|Carrier|
      |Order Date|Import/Export|Carrier Portal|Cargo Summary|Booking Number|Max Pay Amount|Offer Rate|Carrier Sales Rep|Vendor|Carrier|
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza |  3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |
     #Steps 2
    Then Save Load With All details
#    Then Open Load Number "L-116"
    Then Verify Banner Details
    |Carrier|Vendor|Carrier Sales Rep|Offer Rate|Max Pay Amount|Booking Number|Cargo Summary    |Import/Export|Order Date|
    |NA     |NA    |NA               |NA        |NA            |NA            |Banana, 15000 lbs|NA         |NA          |

    Then Verify Banner details For Checkbox
      |Carrier Portal    |
      |False             |

    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "Booking Number"
    Then Update details
      |Booking Number|Order Date|
      |1107          |0         |
    Then Scroll into Section "Carrier Sales Information"
    Then Update details
      |Offer Rate|Carrier Portal|Max Pay Amount|Import/Export|
      |40.00     |true          |100           | Import|
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Shipment IDs"
    Then Verify Details
      |Booking Number  |
      |1107            |
    Then Refresh current Page

    Then Verify Banner Details
      |Carrier|Vendor|Carrier Sales Rep|Offer Rate|Max Pay Amount|Booking Number|Cargo Summary    |Import/Export|Order Date|
      |NA     |NA    |NA               |USD 40.00 |USD 100.00    |1107          |Banana, 15000 lbs|Import       |0         |

    Then Verify Banner details For Checkbox
      |Carrier Portal    |
      |True             |

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Summary" Tab
    Then Wait for "5" Seconds
    Then Refresh current Page
    Then Verify Banner Details
      |Carrier               |Vendor               |Carrier Sales Rep|Offer Rate|Max Pay Amount|Booking Number|Cargo Summary    |Import/Export|Order Date|Carrier Total|Settlement Status|
      |Email Carrier One     |Email Carrier One    |User User         |USD 40.00     |USD 100.00        |1107          |Banana, 15000 lbs|Import       |0         |USD 0.00         |Pending          |
    Then Verify Banner details For Checkbox
      |Carrier Portal    |Accepted|
      |True              |True     |
