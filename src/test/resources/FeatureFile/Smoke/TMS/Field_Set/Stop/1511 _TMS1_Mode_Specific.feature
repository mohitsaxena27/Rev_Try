Feature: 1511 - Field Set Stop TMS1 - Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1511 @Field_Set
  Scenario: 1511 - Field Set Stop TMS1 - Mode Specific

    When Login into Salesforce
#    #Step1
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Open "Stop" Object Manager
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Click on Native "New" button
    Then Switch to Frame by Title "Stop Field Set"
    Then Update details -
      |Field Set Label|Where is this used?|
      |TMS1 LTL      |testing            |
    Then Select "Save" from List -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds

     #Step 2
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Add the Following Fields in this Order
         |References|Planned Duration (Dwell)|Pickup/Delivery Number|Due Out Time|Due Out Date|Cargo Status|
         |References|Planned Duration (Dwell)|Pickup/Delivery Number|Due Out Time|Due Out Date|Cargo Status|
    Then Make below Field Set Required
        |Planned Duration (Dwell)|
        |Planned Duration (Dwell)|
    Then Click on button "Save" -
    Then Wait for "1" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 3
    Then Open "Transportation Profiles" from App Launcher
    #Step 4
    Then Search and Select "Boston Beans" from List
    Then Scroll into Section "Stop Defaults"
    Then Click on Edit icon on Label "Planned Duration Pickup Preloaded"
    Then Update details
      | Planned Duration Pickup Preloaded |Default Cargo Status Pickup|
      | 30                      |Preloaded|
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Stop Defaults"
    Then Verify "Planned Duration Pickup Preloaded" having value of "30"

    #Step 5
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Denver Deli Meats" from List
    Then Scroll into Section "Stop Defaults"
    Then Click on Edit icon on Label "Planned Duration Delivery Live Unload"
    Then Update details
      | Planned Duration Delivery Live Unload |Default Cargo Status Delivery|
      | 60                                    |Live Unload|
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Stop Defaults"
    Then Verify "Planned Duration Delivery Live Unload" having value of "60"

     #Step6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | LTL       | Dry Van 53     | Y             | N                 |
    Then Update details
    |Fleet|
    |True |
    #Expected Result a
    Then Verify details for all Enabled fields
      |Cargo Status|Due Out Date|Due Out Time|Pickup/Delivery Number|References|
      |            |            |            |                      |          |
    Then Verify details for all Required Enabled fields
      |Planned Duration (Dwell)|
      |                |
    #Continue with Step 6
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date   | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
     #Expected b
    Then Verify details for all Enabled fields
      |Cargo Status|Planned Duration (Dwell)|
      |Preloaded   |30              |
   #Continue with Step 6
    Then Update details
    |Due Out Date|Due Out Time|Pickup/Delivery Number|Planned Duration (Dwell)|References|
    |0            |6:00 AM    |321-1                 |                |Testing 1P|

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  3             | NA                       | NA               | NA                   |

    #Expected c
    Then Verify details for all Enabled fields
      |Cargo Status_2  |Planned Duration (Dwell)_2|
      |Live Unload     |60                        |

    #Continue with Step 6
    Then Update details
      |Due Out Date_2|Due Out Time_2|Pickup/Delivery Number_2|References_2|
      |3            |5:00 PM    |321-2                                 |Testing 2D|
    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description          |Weight|Weight_Units|HU_Count |Handling_Units|Length|Height|Width|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Mixed                |6500  |NA          |NA     |NA       |NA    |NA          |NA|NA               |NA       |

    Then Save Load
    #Expected d
    Then "Planned Duration (Dwell)" field highlights red as required -

    Then Update details
      |Planned Duration (Dwell)          |
      |30   |
    Then Save Load With All details
    #Step 7 & 8
    Then Click on Text "Boston Beans" on "1" item
    Then Wait for "2" Seconds
    #Expected Result e
    Then Verify Details
      |Cargo Status |Planned Duration (Dwell) |Due Out Date|Due Out Time|
      |Preloaded    |30               |0            |6:00:00 AM    |
    Then Scroll into Section "Shipping/Receiving Information"
    Then Verify Details
      |Pickup/Delivery Number|References|
      |321-1                 |Testing 1P|

    #Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | LTL | Dry Van 53     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date   | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | NA              | NA                       | NA               | NA                   |
    Then Update details
      |Due Out Date|Due Out Time|Pickup/Delivery Number|References|
      |0            |6:00 AM    |321-1                 |Testing 1P|
    Then Click on "Quick Entry" with Text
    Then Wait for "2" Seconds
    Then Click on "Detail Entry" with Text
    #Expected f
    Then Verify details for all Enabled fields
      |Due Out Date|Due Out Time|Pickup/Delivery Number|References|
      |0            |6:00 AM    |321-1                 |Testing 1P|
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  3             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description          |Weight|Weight_Units|HU_Count |Handling_Units|Length|Height|Width|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Bananas               |15000  |NA          |NA     |NA       |NA    |NA          |NA|NA               |NA       |
    Then Save Load With All details
    #Expected g
    Then Verify Banner Details
    |Load Status|
    |Unassigned |
  