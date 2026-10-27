Feature: 2927 - TruckerTools Load Board API- Post Loads Operation: Delete

  @API @Regression @TMS @Smoke @WEB @SingleCurrency @Load_Posting_And_Tracking @2927 @TruckerToolsAPI @Debugging
  Scenario: 2927 - TruckerTools Load Board API- Post Loads Operation: Delete
    When Login into Salesforce
#   #Step1
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

    #Step 2
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

      #Step3
    Then Wait for "3" Seconds
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Click on Native "Edit" icon
    Then Update details
      |Max Pay Amount| Offer Rate | Offer Rate Type | Load Posting Description |
      |100           | 1          | Fixed Cost      | testing                  |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step 4
    Then Select the + action next to the "Trucker Tools Load Board" integration listing
    Then Verify Message displaying with Text "Trucker Tools Load Board: This load was successfully posted."
    Then Wait for "4" Seconds
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step 5
    Then Select the Remove action next to the "Trucker Tools Load Board" integration listing
    Then Verify Message displaying with Text "Trucker Tools Load Board: This load posting was removed from the load board."
    Then Wait for "5" Seconds
    #Step 6
    Then "Capture" and Close all the Toast messages from Bottom

    Then Get Attribute "loads[0].status" store into "Load_Status" from "postLoads" "Request"

    #Expected a
    Then Verify Assertion for "Load_Status" contains "Canceled"

    #Step7
    Then Open "Load Postings" from App Launcher
    Then Set "Replaced_Load" from stored value "1L" with replace of "L-" with ""
    Then Search "SysData=>Replaced_Load" from List
    Then Select Load Posting for "Load Board Posting Id" contains "SysData=>1L"

#    Then Click on "Posting-" with Contains Text
    #Step 8
    Then Capture the current URL for "Load Posting"
    Then Wait for "1" Seconds
    Then Scroll into Section "General Information"
    #Expected b
    Then Verify Details
       | Posting Status |
       | Unposted         |