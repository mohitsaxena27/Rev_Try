Feature: 2264 - Freight Plan- Tracking Load Status Logic (w/Cross-Dock)

  @API @Regression @TMS @Smoke @WEB @FMS @SingleCurrency @Freight_Plan @2264
  Scenario: 2264 - Freight Plan- Tracking Load Status Logic (w/Cross-Dock)

    Then Login into Salesforce
  # Step1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

  # Step 2
    Then Save Load With All details

  # Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Chicago Pizza | Truckload | NA             | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meat | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

  # Step 4
    Then Save Load With All details

  # Step 5
    Then Go to "Shipment" Tab
    Then Click on button with Title "Add Freight Plan"

  # Step 1
    Then Freight Plan - "Add Load Number" "SysData=>1L"
    Then Wait for "3" Seconds
    Then Verify Text displaying as "SysData=>1L"
    Then Click on button with Title "Show Filter/Template Panel"

  # Step 3
    Then Verify "Freight Plan Template" tab is active
    Then Click on "Add" icon under "Added Stops" within "Freight Plan Template"
    Then Freight Plan - "Search Locations" "Arizona Cardinals" and select "Arizona Cardinals - Tempe, AZ"

  # Step 4
    Then Click on button with Title Text "Refresh_3" within "Freight Plan Template"

  # Step 5
    Then Click on button with Title Text "Hide Panel" within "Freight Plan Template"

  # Step 6
    Then Freight Plan - Click on Checkbox with Location "Boston Beans - Boston, MA"
    Then Freight Plan - Click on Dropdown with Location "Tempe, AZ" inline with "Boston Beans"

  # Step 1
    Then Click on "New Load" with Text

  # Step 2
    Then Update details
      | Mode      |
      | Truckload |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds

  # Step 3
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"

  # Step 4
    Then Freight Plan - Click on Checkbox with Location "Chicago Pizza - Chicago, IL"
    Then Freight Plan - Click on Dropdown with Location "Tempe, AZ" inline with "Chicago Pizza"

  # Step 5
    Then Click on "New Load" with Text

  # Step 6
    Then Update details
      | Mode      |
      | Truckload |
    And Click on Native "Save" button

  # Step 7
    Then Freight Plan - Verify and get the "2" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_2"

  # Step 8
    Then Freight Plan - Click on Checkbox with Location "Tempe, AZ"
    Then Freight Plan - Click on Checkbox with Location "Tempe, AZ_2"
    Then Freight Plan - Click on Dropdown with Location "Denver Deli Meats" inline with "Boston Beans"

  # Step 8.b
    Then Click on "New Load" with Text

  # Step 9
    Then Update details
      | Mode      |
      | Truckload |
    And Click on Native "Save" button

  # Step 10
    Then Freight Plan - Verify and get the "3" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_3"

  # Step 11
    Then Freight Plan - Select the "1" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "2" Seconds

  # Step 12
    Then Wait for "1" Seconds
    Then Expand "Details" for "2" Load
    Then Click on Edit icon with Field Name "2D" "Expected Date"
    Then Update details
      | Expected Date |
      | 1             |
    Then Click on "2D" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "2D" Details
      | Expected Date |
      | 1             |

  # Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "200"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

  # Step 14
    Then Close Current Tab
    Then Switch to Parent Window

  # Step 15
    Then Freight Plan - Select the "2" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "2" Seconds

  # Step 16
    Then Wait for "1" Seconds
    Then Expand "Details" for "2" Load
    Then Click on Edit icon with Field Name "2D" "Expected Date"
    Then Update details
      | Expected Date |
      | 1             |
    Then Click on "2D" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "2D" Details
      | Expected Date |
      | 1             |

  # Step 17
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "220"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

  # Step 18
  #  Then Close Current Tab(Performing next actions in the same tab)
  #  Then Switch to Parent Window

  # Step 19 & 20
    Then Search and Select "rtms__Load__c" "SysData=>1L" from the Global search

  # Expected a
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

  # Step 21 & 22
    Then Search and Select "rtms__Load__c" "SysData=>2L" from the Global search

  # Expected b
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

    Then Close Current Tab
    Then Switch to Parent Window

  # Step 23
    Then Freight Plan - Select the "1" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "3" Seconds

  # Step 24
    Then Click on "1P" "En Route" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Carrier ETA Date | Carrier ETA Time |
      | 1                | 0800             |
    Then Click on "1P" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "1P" Details
      | Carrier ETA Date | Carrier ETA Time |
      | 1                | 08:00             |

  # Step 25
    Then Search and Select "rtms__Load__c" "SysData=>1L" from the Global search

  # Step 26 and Expected c
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

  # Step 27
    Then Search and Select "rtms__Load__c" "SysData=>2L" from the Global search

  # Step 28 and Expected d
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

    Then Close Current Tab
    Then Switch to Parent Window

  # Step 29
    Then Freight Plan - Select the "2" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "3" Seconds

  # Step 30
    Then Wait for "1" Seconds
    Then Click on "1P" "En Route" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Carrier ETA Date | Carrier ETA Time |
      | 1                | 1130             |
    Then Click on "1P" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "1P" Details
      | Carrier ETA Date | Carrier ETA Time |
      | 1                | 11:30             |

  # Step 31
    Then Search and Select "rtms__Load__c" "SysData=>2L" from the Global search

  # Step 32 and Expected e
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

    Then Close Current Tab
    Then Switch to Parent Window

  # Step 33
    Then Freight Plan - Select the "2" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "3" Seconds

  # Step 34
    Then Wait for "1" Seconds
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date | Departure Time |
      | 0              | 1600           |
    Then Click on "1P" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "1P" Details
      | Departure Date | Departure Time |
      | 0              | 16:00           |

  # Step 35
    Then Search and Select "rtms__Load__c" "SysData=>2L" from the Global search

  # Step 36 and Expected f
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

  # Step 37
    Then Search and Select "rtms__Load__c" "SysData=>1L" from the Global search

  # Step 38 and Expected g
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

    Then Close Current Tab
    Then Switch to Parent Window

  # Step 39
    Then Freight Plan - Select the "2" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "3" Seconds

  # Step 40
    Then Wait for "1" Seconds
    Then Click on "2D" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date | Departure Time |
      | 1              |                |
    Then Click on "2D" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "2D" Details
      | Departure Date | Departure Time |
      | 1              |                |

  # Step 41 and Expected h
    Then Verify Banner Details
      | Load Status |
      | Delivered   |

  # Step 42
    Then Search and Select "rtms__Load__c" "SysData=>1L" from the Global search

  # Step 43 and Expected i
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

  # Step 44
    Then Search and Select "rtms__Load__c" "SysData=>2L" from the Global search

  # Step 45 and Expected j
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

    Then Close Current Tab
    Then Switch to Parent Window

  # Step 46, 47
    Then Freight Plan - Select the "3" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "3" Seconds

  # Step 48
    Then Wait for "1" Seconds
    Then Expand "Details" for "1" Load
    Then Click on Edit icon with Field Name "1P" "Expected Date"
    Then Update details
      | Expected Date |
      | 1             |
    Then Click on "1P" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page
    Then Wait for "5" Seconds
    Then Verify Stop "1P" Details
      | Expected Date |
      | 1             |

  # Step 49
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "300"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

  # Step 50
    Then Wait for "1" Seconds
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date | Departure Time |
      | 1              | 1200           |
    Then Click on "1P" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "1P" Details
      | Departure Date | Departure Time |
      | 1              | 12:00           |

  # Step 51
    Then Search and Select "rtms__Load__c" "SysData=>1L" from the Global search

  # Step 52 and Expected k
    Then Verify Banner Details
      | Load Status |
      | Dispatched  |

  # Step 53
    Then Search and Select "rtms__Load__c" "SysData=>2L" from the Global search

  # Step 54 and Expected l
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

    Then Close Current Tab
    Then Switch to Parent Window

  # Step 55
    Then Freight Plan - Select the "3" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "3" Seconds

  # Step 56
    Then Wait for "1" Seconds
    Then Click on "2D" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date | Departure Time |
      | 2              |                |
    Then Click on "2D" "Save" button
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "2D" Details
      | Departure Date | Departure Time |
      | 2              |                |

  # Step 57
    Then Search and Select "rtms__Load__c" "SysData=>1L" from the Global search

  # Step 58 and Expected m
    Then Verify Banner Details
      | Load Status |
      | Delivered   |

  # Step 59
    Then Search and Select "rtms__Load__c" "SysData=>2L" from the Global search

  # Step 54 and Expected l
    Then Verify Banner Details
      | Load Status |
      | Delivered   |