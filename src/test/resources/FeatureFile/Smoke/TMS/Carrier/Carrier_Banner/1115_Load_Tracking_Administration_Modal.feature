Feature: 1115 - Carrier Banner LWC- Load Tracking Administration Modal: Functionality

  @Regression @TMS @Smoke @WEB @Carrier @SingleCurrency @Carrier_Banner @1115
  Scenario: 1115 - Carrier Banner LWC- Load Tracking Administration Modal: Functionality

    When Login into Salesforce

    #Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Wait for "3" Seconds
    Then Scroll into Section "Customer Load Tracking"
    Then Click on Edit icon on Label "Tracking Customer Id"
    Then Wait for "2" Seconds
    Then Update details
      | Tracking Customer Id |
      | 123456               |
    Then Click on "Save" button
    Then Verify "Tracking Customer Id" having value of "123456"
    Then Capture the current URL for "Boston_Beans_TP"

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 48     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | 0830-1200        | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | 1445             | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 4
    Then Go to "Summary" Tab
    Then Wait for "2" Seconds
    Then Go to "Details" Tab
    Then Scroll into Section "Assigned Carrier Information"
    Then Click on Edit icon on Label "Tractor Number"
    Then Update details
      | Driver Name  | Driver Phone | Tractor Number |
      | Keanu Reeves | 217-972-1878 | 6789           |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Scroll into Section "Assigned Carrier Information"
    Then Verify Details
      | Driver Name  | Driver Phone | Tractor Number |
      | Keanu Reeves | 217-972-1878 | 6789           |

    #Step 5
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -

    #Expected a
    Then Click on PickList "Tracking Provider"

    Then Verify Text displaying as "FourKites"
    Then Verify Text displaying as "MacroPoint"
    Then Verify Text displaying as "Project44 Tracking"
    Then Verify Text displaying as "Trucker Tools"

    #Step 6
    Then Update details -
      | Tracking Provider |
      | MacroPoint        |

    #Expected b
    Then Verify details for all Enabled fields
      | Tracking Provider | Start Day | Start Time | Timezone     | Tracking Duration | Tracking Update Interval | MacroPoint Stop Sequencing | Share Tracking Updates with Customer |
      | MacroPoint        | 1         | 8:30 AM    | Eastern Time | 1 hour            | 15 minutes               | False                      | False                                |

    Then Verify details for all Enabled fields
      | Tracking Notes                            | Tracking Update Email List          |
      | Default tracking notes for Global Default | test@revenova.com, dev@revenova.com |

    Then Verify details for all Enabled fields
      | Tractor Number | Driver Phone |
      | 6789           | 217-972-1878 |

    Then Verify Text displaying as "Driver Name"
    Then Verify Text displaying as "Keanu Reeves"

    #Step 7 & Expected c
    Then Close Modal

    #Step 8
    Then Navigate to stored URL for "Boston_Beans_TP"
    Then Scroll into Section "Customer Load Tracking"
    Then Click on Edit icon on Label "Tracking Customer Id"
    Then Update details
      | Tracking Customer Id |
      |                      |
    Then Wait for "2" Seconds
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "Tracking Customer Id" having value of " "

    #Step 9
    Then Navigate to stored URL for "Load_1"

    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -

    Then Update details -
      | Tracking Provider |
      | MacroPoint        |

    #Expected d
    Then Verify Text not displaying as "Share Tracking Updates with Customer"

    #Step 10
    Then Update details -
      | Tracking Provider  |
      | Project44 Tracking |

    #Expected e
    Then Verify details for all Enabled fields
      | Driver Phone |
      | 217-972-1878 |
    Then Verify Text not displaying as "Tracking Update Email List"
    Then Verify Text not displaying as "Tracking Notes"

    #Step 11
    Then Update details -
      | Tracking Provider |
      | FourKites         |

    #Expected f
    Then Verify details for all Enabled fields
      | Tractor Number | Driver Phone |
      | 6789           | 217-972-1878 |
    Then Verify Text displaying as "Driver Name"
    Then Verify Text displaying as "Keanu Reeves"
    Then Verify Text not displaying as "Tracking Update Email List"
    Then Verify Text not displaying as "Tracking Notes"

    #Step 12
    Then Close Modal

    #Step 13
    Then Navigate to stored URL for "Boston_Beans_TP"
    Then Scroll into Section "Shipping/Receiving Information"
    Then Click on Edit icon on Label "Shipping Hours"
    Then Wait for "2" Seconds
    Then Update details
      | Shipping Hours |
      |                |
    Then Click on "Save" button
    Then Verify "Shipping Hours" having value of ""

    #Step 14
    Then Search and Select "Boston Beans" Account from the Global search
    Then Capture the current URL for "Boston_Beans_Account"
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Verify Details
      | Timezone |
      |          |

    #Step 15
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Wait for "1" Seconds
    Then Update details
      | Appointment Time | Shipping/Receiving Hours |
      |                  |                          |
    Then Click on "Save" Button with Type "submit"
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Collapse "Details" for "1" Load
    Then Refresh current Page
    Then Wait for "2" Seconds
    #Step 16
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -

    Then Update details -
      | Tracking Provider |
      | Trucker Tools     |

    #Expected g
    Then Verify details for all Disabled or Readonly fields
      | Start Day |
      | 1         |
    Then Verify details for all Enabled fields
       | Start Time |
       | 12:00 AM   |

    #Step 17
    Then Update details -
      | Tracking Provider |
      | MacroPoint        |

    Then Update details -
      | Tractor Number |
      |                |
    Then Click button with Text "On" on Modal
    Then Verify "Tractor Number" having value of ""

    #Expected h
#    Then Verify Text displaying as "Complete this field."
    Then "Timezone" field highlights red as required
    #Step 18
    Then Update details -
      | Timezone     |
      | Eastern Time |
    Then Click button with Text "On" on Modal
    Then Verify Message displaying with "Success"

#    #Expected i
    Then Wait for "5" Seconds
    Then Verify "SteelBlue" Color with "White" Text of "On" Button is "Enabled"
    Then Verify details for all Disabled or Readonly fields
      | Tracking Provider |
      | MacroPoint        |
    Then Verify button with Text "Update Tracking" on Modal
    Then Verify details for all Enabled fields
      | Tractor Number | Container/Trailer Number | Driver Phone | Tracking Duration | Tracking Update Interval | Tracking Notes                            | Tracking Update Email List          |
      |                |                          | 217-972-1878 | 1 hour            | 15 minutes               | Default tracking notes for Global Default | test@revenova.com, dev@revenova.com |

    #Step 19
    Then Close Modal
    Then Wait for "2" Seconds
    #Step 20
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Get Details
      | Tracking Number |
      |                 |

    #Expected j
    Then Verify "SysData=>Tracking Number" value is not empty

    #Step 21
    Then Scroll into Section "Assigned Carrier Information"
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Carrier Tracking Status"
    Then Update details
      | Carrier Tracking Status |
      | Scheduled               |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    #Step 22
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -

    #Expected k
    Then Wait for "3" Seconds
    Then Verify Carrier Tracking Status as "Scheduled"
    Then Verify button with Text "Scheduled" on Modal
    Then Verify "SteelBlue" Color with "White" Text of "Scheduled" Button is "Enabled"
    Then Verify button with Text "Save" on Modal


    #Step 23
    Then Update details -
      | Driver Phone |
      | 999-999-9999 |
    Then Click button with Text "Save" on Modal
    Then Verify Message displaying with "Save was successful."
    Then Wait for "2" Seconds
    #Expected l
    Then Verify details for all Enabled fields
      | Driver Phone |
      | 999-999-9999 |

    #Step 24
    Then Click button with Text "Off" on Modal

    #Expected m
    Then Verify Message displaying with "Success - Carrier Banner"
    Then Wait for "4" Seconds
    Then Verify "SteelBlue" Color with "White" Text of "Off" Button is "Enabled"
    Then Verify details for all Enabled fields
      | Tracking Provider |
      | MacroPoint        |

    #Step 25
    Then Close Modal
    Then Wait for "2" Seconds
    #Step 26
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Get Details
      | Tracking Number |
      |                 |

   #Expected n
    Then Verify Details
         |Tracking Number| Tracking Provider |
         |                |                   |

    #Step 27
    Then Scroll into Section "Tracking Information"
    Then Verify Details
      | Carrier Tracking Status |
      | Off                     |