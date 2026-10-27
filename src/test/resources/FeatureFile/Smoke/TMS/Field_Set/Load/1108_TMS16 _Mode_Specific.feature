Feature: 1108 - Field Set Load TMS16 - Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1108 @Field_Set
  Scenario: 1108 - Field Set Load TMS16 - Mode Specific
    When Login into Salesforce
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Edit Object" from Setup Icon
    Then Switch Window by index "1"
    #Fields & Relationships
    Then Click on "Fields & Relationships" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Relationship"
    Then Click on Native "New" button
    Then Switch to Frame by Title "Load: New Custom Field"
    Then Update details -
    |Formula|
    |True   |
    Then Select "Next" from List -
    Then Update details -
      |Field Label        |Field Name           |Text|
      |Custom Field 1108  |Custom_Field_1108    |True|
    Then Click on "Next" button on "Step 2. Choose output type" Page -
    Then Enter Formula Text as "rtms__Customer__r.BillingCountry"
    Then Click on "Next" button on "Step 3. Enter formula" Page -
    Then Click on "Next" button on "Step 4. Establish field-level security" Page -
    Then Update details -
      |Add Field|
      |False    |
    Then Click on "Next" button on "Step 5. Add to Dynamic Forms-enabled record pages" Page -
    Then Wait for "3" Seconds
    Then Update details -
      |Add Field|
      |False    |
    Then Select "Save" from List -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Verify Details "Custom_Field_1108" added and displaying on List
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Click on Native "New" button
    Then Switch to Frame by Title "Load Field Set"
    Then Update details -
      |Field Set Label|Where is this used?|
      |TMS16 LTL      |Testing            |
    Then Select "Save" from List -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Add the Following Fields in this Order
    |Offer Rate|Mode Name|Freeze Distance|Distance (Miles)|Created Date|Commodity Condition|Carrier Sales Rep|Custom Field 1108|Bill of Lading Number|
    |Offer Rate|Mode Name|Freeze Distance|Distance (Miles)|Created Date|Commodity Condition|Carrier Sales Rep|Custom Field 1108|Bill of Lading Number|
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | LTL       | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza |  3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |
     #Steps 2
    Then Save Load With All details
#    Then Open Load Number "L-118"

    Then Verify Text displaying as "Load Status"
    Then Wait for "3" Seconds
    Then Verify Banner Details
      |Bill of Lading Number|Carrier Sales Rep|Commodity Condition|Created Date  |Distance (Miles)   |Mode Name|Offer Rate|
      |NA                   |NA               |NA                 |0             |Number              |LTL       |NA          |
    Then Verify "Custom Field 1108" having value of "United States"
    Then Verify Banner details For Checkbox
      |Freeze Distance  |
      |False            |
    Then Go to "Details" Tab
    Then Scroll into Section "Carrier Sales Information"
    Then Click on Edit icon on Label "Offer Rate"
    Then Update details
      |Offer Rate|Distance (Miles)      |Freeze Distance|Commodity Condition|
      |40.00     |1107                  |true           | Used              |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Verify Details
      |Distance (Miles)  |
      |1,107.00          |
    Then Refresh current Page

    Then Verify Banner Details
      |Bill of Lading Number|Carrier Sales Rep|Commodity Condition|Created Date  |Distance (Miles)   |Mode Name|Offer Rate|
      |NA                   |NA               |Used               |0             |Number             |LTL       |USD 40.00|
    Then Verify "Custom Field 1108" having value of "United States"
    Then Verify Banner details For Checkbox
      |Freeze Distance  |
      |True             |

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Summary" Tab
    Then Wait for "3" Seconds
    Then Refresh current Page
    Then Verify Banner Details
      |Bill of Lading Number|Carrier Sales Rep|Commodity Condition|Created Date  |Distance (Miles)   |Mode Name|Offer Rate|Carrier Total|Settlement Status|
      |Number               |User User        |Used               |0             |Number             |LTL       |USD 40.00|USD 0.00     |Pending      |
    Then Verify "Custom Field 1108" having value of "United States"
    Then Verify Banner details For Checkbox
      |Freeze Distance  |Accepted|
      |True             |True     |