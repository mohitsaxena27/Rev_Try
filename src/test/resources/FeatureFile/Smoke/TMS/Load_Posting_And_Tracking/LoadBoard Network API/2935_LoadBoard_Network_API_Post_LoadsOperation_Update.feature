Feature: 2935 - LoadBoard Network API- Post Loads Operation:Update

  @API @Regression @TMS @Smoke @WEB @SingleCurrency @Load_Posting_And_Tracking @2935 @LoadBoard_Network @Debugging
  Scenario: 2935 - LoadBoard Network API- Post Loads Operation:Update

    When Login into Salesforce
    # Step 1a, 1b and 1c
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Freeze Load Number |
      | False              |
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | true            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 48     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Same_as_Customer | NA    | 0             | NA                       | 0830-1200        | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | Account_Address | Chicago Pizza | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type  | Value                  | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3D   | City_State_PC | Des Moines,IA,50301,US | 2             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | GeoLocation  | 38.521860,-104.523780 | 3             | NA                       | 1445             | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                      | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 - Boston Beans 526 Beacon Street, Boston MA 02215 US | Stop 3   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                         | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 2 - Chicago Pizza 181 W. Madison St., Chicago IL 60602 US | Stop 4   | Grapes      | 8000   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_Num"

    # Step 3
    Then Wait for "3" Seconds
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Click on Native "Edit" icon
    #Step 3a,3b,3c
    Then Update details
      | Offer Rate | Offer Rate Type | Load Posting Description |
      | 1          | Fixed Cost      | testing                  |

    #Step 3.d
    And Click on Native "Save" button

    #Step 3.e
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step4
    Then Select the + action next to the "LoadBoard Network" integration listing
    Then Verify Message displaying with Text "LoadBoard Network: This load was successfully posted."

    #Step4.a
    Then "Without Capture" and Close all the Toast messages from Bottom

    # Step 5.a.i & 5.a.ii
    Then Expand "Details" for "1" Load
    Then Click on Edit icon with Field Name "1P" "Expected Date"
    Then Update Location as "Indianapolis Colts"
    Then Update details
      | Expected Date |
      | 0             |

    #Step 5.a.iii
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "1P" Details
      | Location           | Expected Date |
      | Indianapolis Colts | 0             |
    Then Collapse "Details" for "1" Load

    #Step 5.b.i
    Then Expand "Details" for "4" Load
    Then Click on Edit icon with Field Name "4D" "Expected Date"
    Then Update details
      | Expected Date |
      | 7             |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "4D" Details
      | Expected Date |
      | 7             |
    Then Collapse "Details" for "1" Load

    # Step 6
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"

    # Step 6.a & 6.b
    Then Update details
      | Load Number     | Total Weight |
      | LOAD_NUMBER2935 | 15000        |

    # Step 6.c
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Load Number     | Total Weight |
      | LOAD_NUMBER2935 | 15,000        |

    # Step 7
    Then Scroll into Section "Load Postings (1)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate | Offer Rate Type | Load Posting Description | Full Truckload | Truck Length |
      | 1.50       | Rate per Mile   | testing 123              | false          | 53           |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    # Step 8
    Then Select Mode Picklist as "Van or Reefer" & Book it Now Option as "False" for "LoadBoard Network"

    # Step 9
    Then Wait for "2" Seconds
    Then Click on Title button "Update" is displaying with Object "rtms-loadposting_loadposting"

    # Expected a
    Then Verify Message displaying with Text "LoadBoard Network: This load was successfully re-posted."
    Then "Capture" and Close all the Toast messages from Bottom

    # Step 10 and Expected b
    Then Verify XML request for "post-loads" with File "2935_Expected_Request.txt"
      | {CurrentDate} | {CurrentDate+7} |
      | 0             | 7               |