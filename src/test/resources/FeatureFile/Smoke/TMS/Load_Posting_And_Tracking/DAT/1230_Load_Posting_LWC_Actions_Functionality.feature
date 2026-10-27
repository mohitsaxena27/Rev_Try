Feature: 1230 - Load Posting LWC- Actions/Functionality

  @API @Regression @smoke @WEB @SingleCurrency @Load_Posting_And_Tracking @1230 @DATAPI @Debugging
  Scenario: 1230 - Load Posting LWC- Actions/Functionality

    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Equipment Types" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on Partial Link Text "Dry Van 45" on Page -
    Then Switch to Parent Frame
    Then Go to "Load Posting Defaults" Tab
    Then Wait for "5" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | DAT Posting     | LoadBoard Network | Trucker Tools Posting | Truckstop Posting | LoadLink Posting |
      |Flatbed, Double|Lowboy   |Auto Carrier| Conestoga| Floats|
    Then Wait for "1" Seconds
    Then Click on Button with Value "Save" -
    Then Capture the current URL for "EquipmentTypes"

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | LTL  |   NA             | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load_1L"

#    Step 3 and expected result a
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Wait for "2" Seconds
    Then Verify details for
      |Truck Length|
      |53         |
    Then Verify Banner details For Checkbox
      |Full Truckload|
      |False          |
  Then Verify "DAT" Load posting has dropdown value "Van"
  Then Verify "LoadBoard Network" Load posting has dropdown value "Van"
  Then Verify "TransCore" Load posting has dropdown value "Van"
  Then Verify "Trucker Tools Load Board" Load posting has dropdown value "Van"
  Then Verify "Truckstop 2" Load posting has dropdown value "Van"

#    Step 4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Chicago Pizza | Truckload | Dry Van 45'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_2L"

#    Step 5 and expected result b
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Wait for "2" Seconds
    Then Verify details for
      |Truck Length|
      |45           |
    Then Verify Banner details For Checkbox
      |Full Truckload|
      |True          |
    Then Click on Native "Edit" icon
    Then Verify "Update" button is displaying and "disabled"
    Then Verify "Post/Remove All" button is displaying and "disabled"
    Then Verify "DAT" Load posting has dropdown value "Flatbed, Double"
    Then Verify "LoadBoard Network" Load posting has dropdown value "Lowboy"
    Then Verify "TransCore" Load posting has dropdown value "Floats"
    Then Verify "Trucker Tools Load Board" Load posting has dropdown value "Auto Carrier"
    Then Verify "Truckstop 2" Load posting has dropdown value "Conestoga"

    #Step 6 and expected result c & d
    Then Update details
      | Max Pay Amount | Offer Rate | Offer Rate Type |
      | -2500          | -2400      | Fixed Cost      |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Verify Error Message displaying with "Please review the errors on this page before saving."
    Then Close all the Toast messages
    And Click on Native "Cancel" button
    Then Verify details for
      | Max Pay Amount | Offer Rate | Offer Rate Type |
      | NA             | NA         | NA              |

    #Step 7 and expected result e
    Then Click on Native "Edit" icon
    Then Wait for "2" Seconds
    Then Update details
      | Offer Rate Type | Max Pay Amount|Offer Rate|
      | Fixed Cost      | 2500         |2400     |
    And Click on Native "Save" button
    Then Verify Message displaying as "Success - Load Postings"
    Then Verify "Update" button is displaying and "enabled"
    Then Verify "Post/Remove All" button is displaying and "enabled"
    Then Verify "Edit" button is displaying and "enabled"
    Then Verify details for
      | Offer Rate Type | Max Pay Amount | Offer Rate   |
      | Fixed Cost      | USD 2,500.00   | USD 2,400.00 |

#    Step 8
    Then Click on Native "Post/Remove All" icon
    Then Wait for "5" Seconds

#    Expected result f
    And Capture load post success and error messages
    Then Verify load posting buttons based on toast messages
    Then Verify header button based on load posting result
    Then Store current date in format "MM/d/YYYY" into "Date"
    Then Set "CurrentDate" with "Updated " and "SysData=>Date"
    Then Verify Text displaying as "SysData=>CurrentDate"
    Then Set "LoadPosting" with "Load Postings " and "SysData=>SuccessfulLoadPostCount"
    Then Verify Text displaying as "SysData=>LoadPosting"

#    Step 9 and expected result g
    Then Click on Title button "Update" is displaying with Object "rtms-loadposting_loadposting"
    Then Wait for "5" Seconds
    Then Verify load posts are re-posted

#    Step 10 and expected result h
    Then Click on Native "Post/Remove All" icon and verify toast messages and action buttons

#    Step 11
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Boston Beans | Intermodal | Container 40'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | 5             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Material     | 14000  | NA           | 8       | Pallets        |

    Then Save Load With All details
    Then  Capture the current URL for "Load_3L"

    #Step 12
    Then Go to "Shipment" Tab
    Then Click on button with Title "Add Freight Plan"
    Then Wait for "2" Seconds
    Then Click on button with Title "Show Filter/Template Panel"
    Then Wait for "1" Seconds
    Then Verify "Freight Plan Template" tab is active

    #Step 13
    Then Click on "Add" icon under "Added Stops" within "Freight Plan Template"
    Then Freight Plan - "Search Locations" "Chicago Pizza" and select "Chicago Pizza - Chicago, IL"
    Then Click on button with Title Text "Refresh_3" within "Freight Plan Template"
    Then Click on button with Title Text "Hide Panel" within "Freight Plan Template"

    #Step 14
    Then Wait for "2" Seconds
    Then Freight Plan - Click on Checkbox with Location "Boston Beans"
    Then Freight Plan - Click on Dropdown with Location "Chicago, IL" inline with "Boston Beans"
    Then Wait for "2" Seconds
    Then Click on "New Load" with Text
    Then Update details
      | Mode      |
      | Intermodal |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds

    #Step 15
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_1" from List

    #Step 16
    Then Wait for "1" Seconds
    Then Expand "Details" for "2" Load
    Then Click on Edit icon with Field Name "2D" "Expected Date"
    Then Update details
      |Expected Date|
      |1            |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    #Step 17
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Select the + action next to the "LoadBoard Network" integration listing

    #Expected result i
    Then Verify Message displaying with Text "LoadBoard Network: This load was successfully posted."

