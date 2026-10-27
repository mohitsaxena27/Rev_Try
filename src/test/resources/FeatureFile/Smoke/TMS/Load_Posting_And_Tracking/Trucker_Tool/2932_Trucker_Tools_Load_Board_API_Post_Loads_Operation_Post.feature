Feature: 2932 - TruckerTools Load Board API - Post Loads Operation: Post

  @Regression @TMS @Smoke @API @WEB @Load_Posting_And_Tracking @SingleCurrency @TruckerTool @2932 @Debugging
  Scenario: 2932 - TruckerTools Load Board API - Post Loads Operation: Post

    When Login into Salesforce
    #Steps1
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
    Then Wait for "1" Seconds
    Then Switch to Parent Frame

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | Y             | N                 |
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
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step3
    Then Go to "Details" Tab
    Then Wait for "1" Seconds
    Then Scroll into Section "Assigned Carrier Information"
    Then Click on Edit icon on Label "Tractor Number"
    Then Update details
        |Tractor Number|Container/Trailer Number|
        |654321        |123789                  |
    Then Scroll into Section "Load Summary"
    Then Update details
         |Distance (Miles)|
         |1000            |
    Then Click on "Save" button
    Then Wait for "4" Seconds
    Then Scroll into Section "Assigned Carrier Information"
    Then Wait for "2" Seconds
    Then Verify Details
      |Tractor Number|
      |654321 |
    
    #Step 4 & 5
    Then Scroll into Section "Team Assignments & Status"
    Then Click on link for label "Owner"
    Then Wait for "2" Seconds
    # Step 5
    Then Click on button with Title "User Detail"
    Then Wait for "10" Seconds
    Then Switch to Frame by Title "User: User User ~ Salesforce - Enterprise Edition"
    Then Click on button with Title "Edit" -
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "User Edit: User User ~ Salesforce - Enterprise Edition"
    Then Enter "1234567890" with Id "Phone" -
    Then Enter "321" with Id "Extension" -
    Then Wait for "1" Seconds
    Then Click on button with Title "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Capture the current URL for "OwnerPage"
     #Step 6
     Then Navigate to stored URL for "Load_Details"
     #Step 7
    Then Wait for "3" Seconds
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate | Offer Rate Type | Load Posting Description |
      | 1          | Fixed Cost      | test                 |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step 8
    Then Select the + action next to the "Trucker Tools Load Board" integration listing
    #Expected Result a
    Then Verify Message displaying with Text "Trucker Tools Load Board: This load was successfully posted."
    Then "Capture" and Close all the Toast messages from Bottom

     #Step 9 #Expected b
    And Update and verify payload for "postLoads" with "TC2932_RequestBody_Expected.json"
      | Load_Number |LoadSFID|{CurrentDateMM+3}|{CurrentDateMM}|{CurrentDateMM+1}|
      | SysData=>1L |SysData=>1LRI|3                       |0                     |1                       |

    #Step 10 & 11
    Then Open "Load Postings" from App Launcher

    #Step 12 & 13
    Then Set "Replaced_Load" from stored value "1L" with replace of "L-" with ""
    Then Search "SysData=>Replaced_Load" from List
    Then Select Load Posting for "Load Board Posting Id" contains "SysData=>1L"
#    Then Click on "Posting-" with Contains Text

    #Step 14 & Expected c
    Then Capture the current URL for "Load Posting"
    Then Wait for "1" Seconds
    Then Scroll into Section "General Information"
    Then Verify Details
      | Load Board Posting Id | Posting Status |
      | SysData=>1L           | Posted         |


    