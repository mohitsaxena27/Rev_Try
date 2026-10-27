Feature: 2929 - LoadBoard Network API- Post Loads Operation:Delete

  @API @Regression @TMS @Smoke @WEB @SingleCurrency @Load_Posting_And_Tracking @2929 @LoadBoard_Network @Debugging
  Scenario: 2929 - LoadBoard Network API- Post Loads Operation:Delete

    When Login into Salesforce
    # Step 1a, 1b and 1c
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
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
      | Add_Loc | Type | Address_Type    | Value          | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3D   | Account_Address | Denver Broncos | 3             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | Account_Address | Denver Deli Meats | 3             | NA                       | 1445             | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                      | Delivery                                                              | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 - Boston Beans 526 Beacon Street, Boston MA 02215 US | Stop 3 - Denver Broncos 1701 Bryant St. Suite 100, Denver CO 80204 US | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                         | Delivery                                                    | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 2 - Chicago Pizza 181 W. Madison St., Chicago IL 60602 US | Stop 4 - Denver Deli Meats 1435 Fox St., Denver CO 80204 US | Grapes      | 8000   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details

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

    #Step 5
    Then Select the Remove action next to the "LoadBoard Network" integration listing

    # Expected a
    Then Verify Message displaying with Text "LoadBoard Network: This load posting was removed from the load board."
    Then Wait for "5" Seconds

    #Step 6
    Then "Capture" and Close all the Toast messages from Bottom

    #Expected b
    And Verify XML request for "post-loads" with File "2929_Expected_Request.txt"
      | {LoadNumber} | {CurrentDate} | {CurrentDate+3} |
      | SysData=>1L  | 0             | 3               |

    #Step7.a
    Then Open "Load Postings" from App Launcher
    Then Recently Viewed to All

    #Step8 & Expected c
    Then Click on "Posting" where "SysData=>1L"
    Then Capture the current URL for "Load Posting"
    Then Wait for "1" Seconds
    Then Scroll into Section "General Information"
    Then Verify Details
      | Posting Status |
      | Unposted       |