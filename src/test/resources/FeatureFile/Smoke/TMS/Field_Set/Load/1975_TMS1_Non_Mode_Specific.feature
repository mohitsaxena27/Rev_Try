Feature: 1975 - Field Set Load TMS1 - Non Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1975 @Field_Set
  Scenario: 1975 - Field Set Load TMS1 - Non Mode Specific
    When Login into Salesforce
    Then Open "Loads" from App Launcher
    Then Wait for "1" Seconds
    # Step 1
    Then Open "Edit Object" from Setup Icon
    Then Switch Window by index "1"
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Open Field Sets "TMS1" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Delete Fields if any available with Field Set
    Then Add the Following Fields in this Order
      | Terminal Cutoff Date | Team | Max Pay Amount | Customer Sales Rep | Commodity Condition |Booking Number| Fleet | Equipment Type |
      | Terminal Cutoff Date | Team | Max Pay Amount | Customer Sales Rep | Commodity Condition |Booking Number| Fleet | Equipment Type |
    Then Make below Field Set Required
      | Booking Number |
      | Booking Number |
    Then Click on button "Save" -
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

    # Step 2: Create Quick Entry Load

    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials | Booking Number |
      | 1L       | Boston Beans | Truckload | NA             | N             | N                 |                |
        #Expected Result a
    Then Verify details for all Enabled fields
      | Equipment Type | Fleet | Booking Number | Commodity Condition | Customer Sales Rep | Max Pay Amount |Team  | Date |Time|
      |                | False |                |                     |                    |                |False |      |    |
    Then Verify details for all Required Enabled fields
      | Booking Number |
      |                |
    #Continue Step2
    Then Update details
    |Fleet|
    |True |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 3             | NA                       | NA               | NA                   |

    # Add Line Items
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load
    #Expected Result b
    Then "Booking Number" field highlights red as required -
    #Continue Step 2
    Then Select "Equipment Type" as "Dry Van 53"
    Then Update Legend details
      | Terminal Cutoff Date, Date |
      | 4                          |
    Then Update details
      | Booking Number | Commodity Condition | Customer Sales Rep              | Max Pay Amount | Team |
      | 1975           | Used                | Customer_Portal Site Guest User | 150            | True |
    Then Get Label Value
      | Time |
      |      |
    Then Save Load With All details
    # Steps 3
    Then Go to "Details" Tab
    #Expected c
    Then Scroll into Section "Team Assignments & Status"
    Then Verify Details
      | Customer Sales Rep              |
      | Customer_Portal Site Guest User |
    Then Scroll into Section "Shipment IDs"
    Then Verify Details
      | Booking Number |
      | 1975           |
    Then Scroll into Section "Carrier Requirements"
    Then Verify Label Checkbox
      | Fleet | Team |
      | true  | true |
    Then Scroll into Section "Carrier Sales Information"
    Then Verify Details
      | Max Pay Amount | Commodity Condition |
      | 150            | Used                |
    Then Scroll into Section "Import/Export Information"
    Then Set "Terminal Cutoff Date" with Date "4" and Time "SysData=>Time"
    Then Verify Details
      | Terminal Cutoff Date          |
      | SysData=>Terminal Cutoff Date |

