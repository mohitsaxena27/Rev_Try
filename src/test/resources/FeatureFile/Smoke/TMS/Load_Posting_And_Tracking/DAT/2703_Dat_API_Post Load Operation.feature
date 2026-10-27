Feature: 2703 - DAT API- Post Load Operation: Post

  @API @Regression @TMS @Smoke @WEB @SingleCurrency @Load_Posting_And_Tracking @2703 @DATAPI @Debugging
  Scenario: 2703 - DAT API- Post Load Operation: Post

    When Login into Salesforce
    #Step1 a
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Authorized Users" Tab
    Then Click on "User User" with Text
    Then Update checkbox "Enabled" as "false" for "DAT" credential card
    Then Update checkbox "Enabled" as "true" for "DAT 2" credential card
    Then Update details
      | Preferred Contact Method |
      | Primary Phone            |
    And Click on Native "Save" button

    #Step1 b
    Then Go to "Global Services" Tab
    Then Search text "DAT 2" in the "Search Credentials..." search box
    Then Select the "DAT 2" record from the lookup field results
    Then Update details
      | Enabled |
      | true    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds
    #Step1 c
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | true            |
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
    #Step3
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
    Then Select the + action next to the "DAT" integration listing

    #Expected a
    Then Verify Message displaying with Text "DAT 2: This load was successfully posted."

    #Step5.a
    Then "Capture" and Close all the Toast messages from Bottom

    #Expected b
    And Update and verify payload for "loads" with "TC2703_RequestBody_Expected.json"
      | Load_Number |{CurrentDateWithSlash+3}|{CurrentDateWithSlash}|
      | SysData=>1L |3                       |0                     |

    #Step6
    Then Get Attribute "id" from "loads" "Response"

    #Step7.a
    Then Open "Load Postings" from App Launcher

    #Step8 & Expected c
    Then Search and Select "SysData=>id" from List
    Then Click on "Posting-" with Contains Text

    #Step9 & Expected d
    Then Capture the current URL for "Load Posting"
    Then Wait for "1" Seconds
    Then Scroll into Section "General Information"
    Then Verify Details
      | Load Board Posting Id | Posting Status |
      | SysData=>id           | Posted         |