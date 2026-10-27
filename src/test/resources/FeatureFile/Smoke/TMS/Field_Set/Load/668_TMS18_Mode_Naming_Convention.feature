Feature: 668 - Field Set Load TMS18 - Mode Naming Convention

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @668 @Field_Set
  Scenario: 668 - Field Set Load TMS18 - Mode Naming Convention
    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Modes" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Mode" Link Text "Truckload" on Page -
    Then Switch to Parent Frame

    #Step 2
    Then Click on "Clone" button
    Then Wait for "1" Seconds
    Then Update details
    |Name            |
    |Truckload-Reefer|
    Then Click on "SaveEdit" button
    Then Wait for "1" Seconds
    Then Verify Details
      |Name           |
      |Truckload-Reefer          |
    #Step 3
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Update details
      |Quick Find         |
      |Picklist Value Sets|
    Then Wait for "1" Seconds
    Then Click on "Picklist Value Sets" with Text
    Then Wait for "6" Seconds
    Then Capture the current URL for "Picklist_Value_Sets"
    Then Switch to Frame by Title "Picklist Value Sets"
    Then Click on "M" with Text -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Picklist Value Sets"
    Then Click on "Modes" with Text -
    Then Switch to Parent Frame
    #Step 4
    Then Switch to Frame by Title "Global Value Set ~ Salesforce - Enterprise Edition"
    Then Click on "new" button -
    Then Switch to Parent Frame
    #Step 5
    Then Switch to Frame by Title "Add Picklist Values"
    Then Add Picklist Values with Mode "Truckload-Reefer"
    Then Click on button with Title "Save" -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds
    Then Close Current Tab
    Then Switch to Parent Window
    #Step 6
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
      | Field Set Label | Field Set Name | Where is this used? |
      | TMS18 Truckload Reefer        | TMS18_Truckload_Reefer       | testing             |
    Then Select "Save" from List -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"

    #Step 7
    Then Add the Following Fields in this Order
    |Stops|Expected Delivery Date|Equipment Type|Driver Phone|Driver Comments|Customer Load|Credit Limit Source|Created Date|Carrier Uploads|Carrier Load|Cargo Value|Cargo Summary|API Load Id|
    |Stops|Expected Delivery Date|Equipment Type|Driver Phone|Driver Comments|Customer Load|Credit Limit Source|Created Date|Carrier Uploads|Carrier Load|Cargo Value|Cargo Summary|API Load Id|
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 8
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode             | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload-Reefer | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |
     #Steps 9
    Then Save Load With All details
    #Expected a
    Then Verify Banner Details
      |API Load Id|Cargo Summary     |Cargo Value|Carrier Uploads|Created Date|Credit Limit Source|Driver Comments|Driver Phone|Equipment Type|Expected Delivery Date|Stops|
      |NA         |Banana, 15000 lbs|NA         |NA             |0           |Customer           |NA             |NA          |NA            |3                     |2    |

    Then Verify Banner details For Checkbox
      |Carrier Load    |Customer Load|
      |True             |True        |

    #Step 10
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Cargo Value"
    Then Update details
      |Cargo Value|
      |15000          |
    Then Scroll into Section "Assigned Carrier Information"
    Then Update details
       |Driver Phone|
       |123-654-7890|
    Then Enter Label "Driver Comments" TextArea as "Testing Driver Comments"
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Summary"
    Then Verify Details
      |Cargo Value            |
      |USD 15,000.00          |
    Then Refresh current Page
     #Expected b
    Then Verify Banner Details
      |API Load Id|Cargo Summary     |Cargo Value        |Carrier Uploads|Created Date|Credit Limit Source|Driver Comments        |Driver Phone|Equipment Type|Expected Delivery Date|Stops|
      |NA         |Banana, 15000 lbs|USD 15,000.00      |NA             |0           |Customer           |Testing Driver Comments|123-654-7890|NA            |3                     |2    |

    Then Verify Banner details For Checkbox
      |Carrier Load    |Customer Load|
      |True             |True        |