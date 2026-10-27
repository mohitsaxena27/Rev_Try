Feature: 2111 - Move Stops LWC- Format/Functionality

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Load @Load_Stop @2111

  Scenario: 2111 - Move Stops LWC- Format/Functionality

    When Login into Salesforce
    #Step1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | LTL        | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | Y       | 2P   | City_State_PC   | Denver,CO,80014,US | 0             | NA               | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | GeoLocation  | 42.361145,-71.057083 |  NA             | NA                       | NA               | NA                   |


    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description|Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 3      |Bananas     |500 |NA          |NA       |NA       |NA        |NA   |NA    |NA            |NA        |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description|Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |2        |Stop 2    |Stop 3      |Grapes     |500 |NA          |NA       |NA       |NA        |NA   |NA    |NA            |NA        |

    #Stop 2
    Then Click on Move Stops action for Stop "1P"
    Then Wait for "1" Seconds
    #Expected a
     Then Verify Text displaying as "Move Stops"
    #Step 3
    #Expected b
    Then Verify Text displaying as "Move Stops"
    Then Verify "Move Down" action is displaying with Stop "0"
    Then Verify Stop Name of Stop "0" is "Stop 1 - Pickup (Chicago Pizza - 181 W. Madison St., Chicago IL 60602 US)" with date "0"

    Then Verify "Move Up" action is displaying with Stop "1"
    Then Verify "Move Down" action is displaying with Stop "1"
    Then Verify Stop Name of Stop "1" is "Stop 2 - Pickup ( - Denver CO 80014)" with date "0"

    Then Verify "Move Up" action is displaying with Stop "2"
    Then Verify Stop Name of Stop "2" is "Stop 3 - Delivery ( - 42.361145 -71.057083)" with date "NA"
    Then Verify button with Text "Done" on Modal
    Then Verify button with Text "Cancel" on Modal

    #Step 4
    Then Click on "Move Up" action is displaying with Stop "2"
    Then Wait for "1" Seconds
     #Expected c
    Then Verify Text displaying as "Move Stops"
    Then Verify "Move Down" action is displaying with Stop "0"
    Then Verify Stop Name of Stop "0" is "Stop 1 - Pickup (Chicago Pizza - 181 W. Madison St., Chicago IL 60602 US)" with date "0"

    Then Verify "Move Up" action is displaying with Stop "1"
    Then Verify "Move Down" action is displaying with Stop "1"
    Then Verify Stop Name of Stop "1" is "Stop 3 - Delivery ( - 42.361145 -71.057083)" with date "NA"

    Then Verify "Move Up" action is displaying with Stop "2"
    Then Verify Stop Name of Stop "2" is "Stop 2 - Pickup ( - Denver CO 80014)" with date "0"
    Then Verify button with Text "Done" on Modal
    Then Verify button with Text "Cancel" on Modal

    #Steps 5 & 6 / Expected d and e
    Then Verify Title "Move Down" is displaying with Stop "0"
    Then Verify Title "Move Up" is displaying with Stop "2"

    #Step 7
    Then Click button with Text "Cancel" on Modal
    Then Wait for "1" Seconds

    #Step 8
    Then Click on Move Stops action for Stop "1P"
    Then Wait for "1" Seconds
    Then Click button with Text "Done" on Modal
    Then Wait for "2" Seconds

     #Expected f
    Then Verify Load Stop details for "1P"
      |Location         |Expected Date|
      |Chicago Pizza    |0            |
    Then Verify Load Stop details for "2P"
      |City         |Postal Code|Expected Date|
      |Denver       |80014      |0            |
    Then Verify Load Stop details for "3D"
      |Latitude|Longitude|Expected Date|
      |42.361145|-71.057083|           |
#   Step 9
    Then Save Load With All details

  #Step 10  & Expected Result g -- Clicking with Title
    Then Verify Title "Move Stops" on Stop "Stop 1"
    #Step 11
    Then Click on button with Title "Move Stops" on Stop "Stop 1"

  #Expected h
    Then Verify Text displaying as "Move Stops"
    Then Verify "Move Down" action is displaying with Stop "0"
#    Then Verify Stop Name of Stop "0" is "Stop 1 - Pickup (Chicago Pizza - 181 W. Madison St., Chicago IL 60602 US)" with date "0"
    Then Verify Stop Name of Stop "0" is "Stop 1 - Pickup (Chicago Pizza - 181 W. Madison St., Chicago, Illinois 60602)" with date "0"

    Then Verify "Move Up" action is displaying with Stop "1"
    Then Verify "Move Down" action is displaying with Stop "1"
    Then Verify Stop Name of Stop "1" is "Stop 2 - Pickup ( - Denver, CO 80014)" with date "0"

    Then Verify "Move Up" action is displaying with Stop "2"
    Then Verify Stop Name of Stop "2" is "Stop 3 - Delivery ( - 42.361145 -71.057083 Boston, MA 02109)" with date "NA"
    Then Verify button with Text "Save" on Modal
    Then Verify button with Text "Cancel" on Modal

    #Steps 12 & 13 / Expected i and j
    Then Verify Title "Move Down" is displaying with Stop "0"
    Then Verify Title "Move Up" is displaying with Stop "2"

    #Step 14
    Then Click on "Move Down" action is displaying with Stop "0"
    Then Wait for "1" Seconds
  #Expected k
    Then Verify Text displaying as "Move Stops"
    Then Verify "Move Down" action is displaying with Stop "0"
    Then Verify Stop Name of Stop "0" is "Stop 2 - Pickup ( - Denver, CO 80014)" with date "0"

    Then Verify "Move Up" action is displaying with Stop "1"
    Then Verify "Move Down" action is displaying with Stop "1"
#    Then Verify Stop Name of Stop "1" is "Stop 1 - Pickup (Chicago Pizza - 181 W. Madison St., Chicago IL 60602 US)" with date "0"
    Then Verify Stop Name of Stop "1" is "Stop 1 - Pickup (Chicago Pizza - 181 W. Madison St., Chicago, Illinois 60602)" with date "0"

    Then Verify "Move Up" action is displaying with Stop "2"
    Then Verify Stop Name of Stop "2" is "Stop 3 - Delivery ( - 42.361145 -71.057083 Boston, MA 02109)" with date "NA"
    Then Verify button with Text "Save" on Modal
    Then Verify button with Text "Cancel" on Modal

  #Step 15
    Then Click button with Text "Save" on Modal
    Then Wait for "5" Seconds

  #Step 16 & Expected L
    Then Verify "1P" Stop Text is "Stop 1"
    Then Verify "1P" Stop with "Denver, CO 80014"
    Then Verify Stop "1P" Details
         |Expected Date|
         |0            |
    Then Verify "2P" Stop Text is "Chicago Pizza"
    Then Verify Stop "2P" Details
      |Expected Date|
      |0            |
    Then Verify "3D" Stop Text is "Stop 3"
    Then Verify "3D" Stop with "42.361145 -71.057083 Boston, MA 02109"
    Then Verify Stop "3D" Details
      |Expected Date|
      |            |

