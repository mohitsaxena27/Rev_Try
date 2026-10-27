Feature: 3149 - Load Detail LWC- Stop Status Format/Functionality

  @Regression @TMS @Smoke @WEB @SingleCurrency @Load @Load_Details @3149

  Scenario: 3149 - Load Detail LWC- Stop Status Format/Functionality

    When Login into Salesforce

    #Step 1 - Create Quick Entry Shipment
    Then Open "Loads" from App Launcher
#    Then Open Load Number "L203"
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details

    #Step 2 - Create Carrier Quote and Assign
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "2" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page
    #Step 3 - Stop 1P - En Route Action
    Then Click on "1P" "En Route" chevron
    Then Wait for "2" Seconds

    #Expected Result a
    Then Verify "1P" "Carrier Assigned" chevron have "White" checkmark
    Then Verify "1P" "En Route" chevron is highlighted with "SteelBlue"
    Then Verify details for all Enabled fields
      | Carrier ETA Date | Carrier ETA Time | Stop Status | Carrier Status | Carrier Status Comments | Last Reported City | Last Reported State/Province | Last Reported Country |
      |                  |                  | En Route    | None           |                         |                    | None                         | None                  |
    Then Verify "SteelBlue" Color with "White" Text of "1P" "Save" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "1P" "Cancel" Button is "Enabled"

    #Step4
    Then Update details
      | Carrier ETA Date | Carrier ETA Time | Carrier Status | Carrier Status Comments |
      | 0                | 0835             | No Issues      | Almost there            |
    Then Enter Last Reported City as "Oak Park, IL 60303"
    Then Wait for "2" Seconds
    Then Verify details for all Enabled fields
    |Last Reported State/Province | Last Reported Country |
    |IL                           | US                    |
    Then Click on "1P" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    #Step 5
    Then Click on "1P" "Arrived" chevron
    #Expected Result b
    Then Verify "1P" "Carrier Assigned" chevron have "White" checkmark
    Then Verify "1P" "En Route" chevron have "White" checkmark
    Then Verify "1P" "Arrived" chevron is highlighted with "SteelBlue"
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments | Last Reported City | Last Reported State/Province | Last Reported Country |
      |              |              | Arrived     | No Issues      | Almost there            | Chicago            | IL                           | US                    |

    Then Verify "SteelBlue" Color with "White" Text of "1P" "Save" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "1P" "Cancel" Button is "Enabled"

    #Step6
    Then Update details
      | Arrival Date | Carrier Status Comments |
      | 0            | door 8                  |
    Then Click on "1P" "Save" button
#    Expected result C
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "4" Seconds
    #Step7
    Then Click on "1P" "Arrived" chevron
    Then Update details
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments |
      | 1            | 1600         | Departed    | Unloaded Clean |                         |

    #Step8
    Then Click on "1P" "Cancel" button
    Then Wait for "2" Seconds
    #Step9
    Then Click on "1P" "Arrived" chevron
    Then Wait for "3" Seconds

    #Expected result d
    Then Verify "1P" "Carrier Assigned" chevron have "White" checkmark
    Then Verify "1P" "En Route" chevron have "White" checkmark
    Then Verify "1P" "Arrived" chevron is highlighted with "SteelBlue"
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments | Last Reported City | Last Reported State/Province | Last Reported Country |
      | 0            |              | Arrived     | No Issues      | door 8                  | Chicago            | IL                           | US                    |
#    Then Click on "1P" "Cancel" button

    #Step10
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    #Expected Result e
    Then Verify "SteelBlue" Color with "White" Text of "1P" "Save" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "1P" "Cancel" Button is "Enabled"
    #Step 11
    Then Update details
      | Departure Date | Departure Time | Carrier Status       | Carrier Status Comments |
      | 0              | 1500           | Other (see comments) | G2G                     |
    Then Click on "1P" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    #Expected result f
    Then Verify "1P" "Carrier Assigned" chevron have "White" checkmark
    Then Verify "1P" "En Route" chevron have "White" checkmark
    Then Verify "1P" "Arrived" chevron have "White" checkmark
    Then Verify "1P" "Departed" chevron is highlighted with "SteelBlue"
    Then Wait for "2" Seconds
    Then Verify "1P" Stop Details
      | Arrival Date | Arrival Time | Departure Date | Departure Time | Stop Status | Carrier Status       | Carrier Status Comments |
      | 0            |              | 0              | 15:00          | Departed    | Other (see comments) | G2G                     |

    #Step12
    Then Click on "2D" "Arrived" chevron
    Then Wait for "3" Seconds
    Then Update details
      | Arrival Date | Arrival Time |
      | 3            | 1000         |
    Then Wait for "1" Seconds
    #Step13
    Then Click on "2D" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "8" Seconds
#    Then Refresh current Page
#    Then Wait for "2" Seconds
    #Expected result g
    Then Verify "2D" "Carrier Assigned" chevron have "White" checkmark
    Then Verify "2D" "En Route" chevron have "White" checkmark
    Then Verify "2D" "Arrived" chevron is highlighted with "SteelBlue"
    Then Verify "2D" Stop Details
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments |
      | 3            | 10:00        | Arrived     |                |                         |

    #Step14
    Then Click on "2D" "Departed" chevron

    #Expected result h
    Then Verify "SteelBlue" Color with "White" Text of "2D" "Save" Button is "Enabled"
    Then Verify "Black" Color with "Gray" Text of "2D" "ThumbsUp" Button is "Enabled"

    #Step 15 & Expected i
    Then Wait for "1" Seconds
    Then Verify button is present with "Arrival/Departure = Expected"

    #Step16
    Then Click on button with Title "Arrival/Departure = Expected"
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "3" Seconds
#    Then Wait for "2" Seconds
    Then Click on "2D" "Departed" chevron
    Then Wait for "4" Seconds
    #Expected j
    Then Verify "2D" "Carrier Assigned" chevron have "White" checkmark
    Then Verify "2D" "En Route" chevron have "White" checkmark
    Then Verify "2D" "Arrived" chevron have "White" checkmark
    Then Wait for "2" Seconds
    Then Verify "2D" "Departed" chevron is highlighted with "Black"
    Then Verify details for all Enabled fields
      | Arrival Date | Arrival Time | Departure Date | Departure Time | Stop Status | Carrier Status | Carrier Status Comments | Last Reported City | Last Reported State/Province | Last Reported Country |
      | 3            | 10:00        | 3              | 12:00          | Departed    |                |                         | Denver             | CO                           | US                    |

    Then Verify "SteelBlue" Color with "White" Text of "2D" "Save" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "2D" "Cancel" Button is "Enabled"
    Then Verify "Black" Color with "Gray" Text of "2D" "ThumbsUp" Button is "Enabled"