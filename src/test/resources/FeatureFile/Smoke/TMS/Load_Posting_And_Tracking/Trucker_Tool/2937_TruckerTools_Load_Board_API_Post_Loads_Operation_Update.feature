Feature: 2937 - TruckerTools Load Board API- Post Loads Operation: Update


  @API @Regression @TMS @Smoke  @WEB @SingleCurrency @Load_Posting_And_Tracking @2937 @TruckerToolsAPI @Debugging
  Scenario: 2937 - TruckerTools Load Board API- Post Loads Operation: Update

    When Login into Salesforce

    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
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

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | Y       | 3D   | City_State_PC   | Des Moines,IA,50301,US | 2             | NA               | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | GeoLocation  | 38.521860, -104.523780 |  3             | NA                       | 1445               | NA                   |

        Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 3   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp| Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 2| Stop 4   | Grapes      | 8000   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

    #Step 3
    Then Wait for "3" Seconds
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Scroll into Section "Load Postings (0)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate | Offer Rate Type | Load Posting Description |
      | 1          | Fixed Cost      | testing                  |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step 4
    Then Select the + action next to the "Trucker Tools Load Board" integration listing
    Then Verify Message displaying with Text "Trucker Tools Load Board: This load was successfully posted."
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step 5
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "1P" "Location"
    Then Update Location as "Indianapolis Colts"
    Then Update details
        |Appointment Time|
        | 0700-1100            |

    Then Click on "Save" Button with Type "submit"
    Then Wait for "4" Seconds
    Then Collapse "Details" for "1" Load

     #Step 6
    Then Scroll into Section "Load Postings (1)"
    Then Click on Native "Edit" icon
    Then Update details
      | Offer Rate    | Offer Rate Type    | Load Posting Description |Full Truckload|Truck Length|
      | 1.50          | Rate per Mile      | TEST POST 2937           |False|53                   |
    And Click on Native "Save" button
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step 8
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Total Weight"
    Then Update details
      |Distance (Miles)| Total Weight |Load Number|
      |1200.00            | 15000        |TEST_LOAD2937   |
    Then Click on "Save" button
    Then Wait for "6" Seconds
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Total Weight" Field Value Update with "15,000"
    Then Verify Details
      |Total Weight      |
      |15,000            |

    #Step 7
    Then Select Mode Picklist as "Reefer or Vented Van" & Book it Now Option as "True" for "Trucker Tools Load Board"

    #step 9
    Then Wait for "2" Seconds
    Then Click on Title button "Update" is displaying with Object "rtms-loadposting_loadposting"
    #Expected a
    Then Verify Message displaying with Text "Trucker Tools Load Board: This load was successfully re-posted."
    Then "Capture" and Close all the Toast messages from Bottom
     #Step 10 & Expected b
    And Update and verify payload for "postLoads" with "TC2937_RequestBody_Expected.json"
      |Load_SFID     |{CurrentDateMM+3}|{CurrentDateMM}|{CurrentDateMM+1}|{CurrentDateMM+2}|
      |SysData=>1LRI|3                |0                     |1         |2|
