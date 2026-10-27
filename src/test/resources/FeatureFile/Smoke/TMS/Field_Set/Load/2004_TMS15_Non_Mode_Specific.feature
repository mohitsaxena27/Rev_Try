Feature: 2004 - Field Set Load TMS15 - Non Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @2004 @Field_Set
  Scenario: 2004 - Field Set Load TMS15 - Non Mode Specific
    When Login into Salesforce
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Edit Object" from Setup Icon
    Then Switch Window by index "1"
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Open Field Sets "TMS15" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Delete Fields if any available with Field Set
    Then Add the Following Fields in this Order
    |Warehouse Contact|Terminal Cutoff Date|Team|PO Number|Other Instructions|Offer Rate Type|Offer Rate|Driver Phone|Driver Comments|
    |Warehouse Contact|Terminal Cutoff Date|Team|PO Number|Other Instructions|Offer Rate Type|Offer Rate|Driver Phone|Driver Comments|
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
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza |  3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |
     #Steps 2
    Then Save Load With All details
#    Then Open Load Number "L-110"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Summary" Tab
    Then Go to "Details" Tab
    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on Label "PO Number"
    Then Update details
    |PO Number|Other Instructions|Team|Offer Rate|Offer Rate Type|Driver Comments|Driver Phone|Warehouse Contact|
    |2004     |Instruction 2004  |true|100       |Fixed Cost     |Comment 2004   | 123-456-7890|Joe Boston Beans|
    Then Update Legend details
    |Terminal Cutoff Date, Date|Terminal Cutoff Date, Time|
    |0                         |10:30 AM                  |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      |PO Number  |
      |2004       |
    Then Refresh current Page
    Then Click on Native "Remove Carrier" icon
    Then Verify Modal Heading Text displaying as "Email Carrier One" -
    Then Click on button "Remove Carrier" -
    Then Verify Message displaying as "Carrier removed from load."
    Then Go to "Details" Tab
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      |PO Number|Other Instructions|Offer Rate|Offer Rate Type|
      |NA       |NA                |NA        |  NA           |
    Then Verify Label Checkbox
      |Team    |
      |false   |
    Then Scroll into Section "Assigned Carrier Information"
    Then Verify Details
    |Driver Comments|Driver Phone|Warehouse Contact|Terminal Cutoff Date|
    | NA           |NA              |NA                    |NA          |
