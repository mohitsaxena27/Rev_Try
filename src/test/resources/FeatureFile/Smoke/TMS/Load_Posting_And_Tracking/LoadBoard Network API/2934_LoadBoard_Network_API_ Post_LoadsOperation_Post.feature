Feature: 2934 - LoadBoard Network API- Post Loads Operation

  @API @Regression @TMS @Smoke @WEB @SingleCurrency @Load_Posting_And_Tracking @2934 @LoadBoard_Network @Debugging
  Scenario: 2934 - LoadBoard Network API- Post Loads Operation

    When Login into Salesforce

    # Step 1a & 1b
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
    Then Add Location Details
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

    Then Capture the current URL for "Load_Details"

    # Step 3
    Then Wait for "3" Seconds
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on link for label "Owner"
    Then Capture the current URL for "User_Details"

    # Step 4
    Then Click on button with Title "Edit"
    Then Enter Label "Phone" Text as "1234567890" on Modal
    Then Wait for "2" Seconds
    Then Click on button with Title "Save"
    Then Wait for "2" Seconds

    # Step 5
    Then Navigate to stored URL for "Load_Details"

    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Click on Native "Edit" icon
    #Step 5a
    Then Update details
      | Offer Rate | Offer Rate Type | Load Posting Description |
      | 1          | Fixed Cost      | testing                  |

    And Click on Native "Save" button

    #Step 5.b
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step6
    Then Select the + action next to the "LoadBoard Network" integration listing

    #Expected a
    Then Verify Message displaying with Text "LoadBoard Network: This load was successfully posted."

    #Step7.a
    Then "Capture" and Close all the Toast messages from Bottom

    #Expected b
    And Verify XML request for "post-loads" with File "2934_Expected_Request.txt"
      | Load_Number | {CurrentDate} | {CurrentDate+3} |
      | SysData=>1L | 0             | 3               |

    #Step8
    Then Open "Load Postings" from App Launcher
    Then Recently Viewed to All

    #Step9,10 & Expected c
    Then Click on "Posting" where "SysData=>1L"
    Then Capture the current URL for "Load Posting"
    Then Wait for "1" Seconds
    Then Scroll into Section "General Information"
    Then Verify Details
      | Posting Status |
      | Posted         |