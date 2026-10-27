Feature: 2275 - Field Set Load TMS15 - Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @2275 @Field_Set
  Scenario: 2275 - Field Set Load TMS15 - Mode Specific
    When Login into Salesforce
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Edit Object" from Setup Icon
    Then Switch Window by index "1"
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Click on Native "New" button
    Then Switch to Frame by Title "Load Field Set"
    Then Update details -
    |Field Set Label|Where is this used?|
    |TMS15 LTL      |Testing            |
    Then Select "Save" from List -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Add the Following Fields in this Order
      |Temperature Controlled|Requested Delivery Time|Requested Delivery Date|PRO Number|Faster Transit Comments|Driver Phone|Driver Name|Commodity Condition|Cargo Value|
      |Temperature Controlled|Requested Delivery Time|Requested Delivery Date|PRO Number|Faster Transit Comments|Driver Phone|Driver Name|Commodity Condition|Cargo Value|
    Then Click on button "Save" -
    Then Wait for "1" Seconds
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
#    Then Open Load Number "L-112"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Summary" Tab
    Then Go to "Details" Tab
    Then Scroll into Section "Faster Transit Request"
    Then Click on Edit icon on Label "Requested Delivery Date"
    Then Update details
      |Requested Delivery Date|Requested Delivery Time|Faster Transit Comments|PRO Number |Cargo Value|Commodity Condition|Temperature Controlled|Driver Name|Driver Phone|
      |0                      |10:30 AM               |Test 2275              |2275       |54000      |Used               |True                  |Sam        |123-456-7890|

    Then Click on "Save" button on Details Page
    Then Scroll into Section "Shipment IDs"
    Then Verify Details
      |PRO Number  |
      |2275       |
    Then Refresh current Page
    Then Click on Native "Remove Carrier" icon
    Then Verify Modal Heading Text displaying as "Email Carrier One" -
    Then Click on button "Remove Carrier" -
    Then Verify Message displaying as "Carrier removed from load."
    Then Go to "Details" Tab
    Then Scroll into Section "Faster Transit Request"
    Then Verify Details
      |Requested Delivery Date|Requested Delivery Time|Faster Transit Comments|PRO Number |
      |NA                     |NA               |NA   |NA       |
    Then Scroll into Section "Load Summary"
    Then Verify Details
    |Cargo Value|Commodity Condition|
    |NA         |NA                 |
    Then Scroll into Section "Assigned Carrier Information"
    Then Verify Details
      |Driver Name         |Driver Phone|
      |NA                  |NA          |
    Then Verify Label Checkbox
      |Temperature Controlled    |
      |false                      |
