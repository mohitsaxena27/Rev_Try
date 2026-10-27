Feature: 2925 - TransCore API- Create Load Postings Operation

  @Regression @TMS @Smoke @API @WEB @Load_Posting_And_Tracking @SingleCurrency @TransCore @2925 @Debugging
  Scenario: 2925 - TransCore API- Create Load Postings Operation

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
      | N       | 2P   | Account_Address | Montreal Motors | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value          | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | Account_Address | Edmonton Eatery | 3             | NA                       | 1445             | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                      | Delivery                                                              | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 - Boston Beans 526 Beacon Street, Boston MA 02215 US | Stop 3 - Denver Deli Meats 1435 Fox St., Denver CO 80204 US | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Update details
         |HazMat |
         |True   |
    Then Wait for "3" Seconds
    Then Update details
      |HazMat Number Type|HazMat Number|HazMat Class/Division|HazMat Packaging Group|
      |UN          |123             |1.6             |II              |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp                                                         | Delivery                                                    | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 2 - Montreal Motors 1909 Av. des Canadiens-de-Montréal, Montréal QC H3B 5E8 CA | Stop 4 - Edmonton Eatery 10257 105 St NW, Edmonton AB T5J 1E3 CA | Grapes      | 8000   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step3
    Then Scroll into Section "Load Postings (0)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate | Offer Rate Type | Load Posting Description |
      | 1          | Fixed Cost      | test                 |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step 4
    Then Select the + action next to the "TransCore" integration listing
    #Expected Result a
    Then Verify Message displaying with Text "TransCore: This load was successfully posted."
    Then "Capture" and Close all the Toast messages from Bottom

     #Step 5 #Expected b
    And Update and verify payload for "LLIB_DAT" with "TC2925_RequestBody_Expected.json"
      | Load_Number |{CurrentDate}|
      | SysData=>1L |0|

    #Step 6 #Expected c
    Then Get Attribute "token" store into "Token" from "LLIB_DAT" "Response"
    Then Verify "Token" has numeric value
    #Step 7
    Then Open "Load Postings" from App Launcher
    Then Wait for "2" Seconds

    #Step 8
    Then Search "SysData=>Token" from List
    Then Wait for "2" Seconds
    Then Select Load Posting for "Load Board Posting Id" contains "SysData=>Token"

    #Step 9 & Expected d
    Then Capture the current URL for "Load Posting"
    Then Wait for "1" Seconds
    Then Scroll into Section "General Information"
    Then Verify Details
      | Load Board Posting Id | Posting Status |
      | SysData=>Token           | Posted         |


    