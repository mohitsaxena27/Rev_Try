Feature: 1596 - Trucker Tools API- Outbound Update Tracking Request

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @1596 @Trucker_Tool @Debugging
  Scenario: 1596 - Trucker Tools API- Outbound Update Tracking Request

    When Login into Salesforce
    # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | true            |
    And Update the Custom Select option "Logging User" as "User User"
    Then Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53      | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value|Expected_Date  | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA   |1               | NA                       | 0830             | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2D   | Account_Address | Los Angeles Lighting | 1             | NA                       | NA        | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3P   | Account_Address | Los Angeles Lighting | 1             | NA                       | NA        | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | Same_as_Customer | NA    | 3             | NA                       | 1445        | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |


    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 3 | Stop 4   | Grapes      | 1200   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details

    # Step 3
    Then Capture the current URL for "Load_1"

    # Step 4
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "4" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Click on button "Assign"
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

    # Step 5
    Then Go to "Summary" Tab
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration"

    # Step 6
    Then Update details -
      | Tracking Provider    |
      | Trucker Tools        |
    Then Wait for "1" Seconds
    Then Update details
      |Start Time|Driver Phone|
      |1:00 AM   |2179721878  |
    Then Click on Native "On" button -
    And "Without Capture" and Close all the Toast messages from Bottom
    #Step 7
    Then Close Toast message
    Then Close Toast message
    # Step 8
    Then Wait for "1" Seconds
    Then Expand "Details" for "1" Load
    Then Click on Edit icon with Field Name "1P" "Expected Date"
    Then Update details
      |Expected Date|Appointment Time     |
      |0            |1200-1600        |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Verify Stop "1P" Details
      |Appointment Time|
      |12:00-16:00            |
    Then Collapse "Details" for "1" Load

    #Step 9
    Then Zoom Current Screen by "70"
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration"
    Then Click on Native "Update Tracking" button -
    Then Wait for "3" Seconds
    And "Capture" and Close all the Toast messages from Bottom

    #Expected a
    Then Get "Id" from "Account" using "name" with value "Boston Beans" and Store onto "Boston_Beans_Account_ID"
    Then Get "Id" from "rtms__Stop__c" using "name" with value "Stop 1" & "rtms__Load__c" with value "SysData=>1LRI" and Store onto "Stop1_ID"
    Then Get "Id" from "rtms__Stop__c" using "name" with value "Stop 2" & "rtms__Load__c" with value "SysData=>1LRI" and Store onto "Stop2_ID"
    Then Get "Id" from "rtms__Stop__c" using "name" with value "Stop 3" & "rtms__Load__c" with value "SysData=>1LRI" and Store onto "Stop3_ID"
    Then Get "Id" from "rtms__Stop__c" using "name" with value "Stop 4" & "rtms__Load__c" with value "SysData=>1LRI" and Store onto "Stop4_ID"
    Then Get Attribute "accountId" store into "accountId" from "LTL" "Request"
    Then Get Attribute "loadTrackExternalId" store into "loadTrackExternalId" from "LTL" "Request"
    And Update and verify payload for "LTL" with "TC1596_RequestBody_Expected.json"
      | {CurrentDateMM} | {CurrentDateMM+1} | {CurrentDateMM+3}  | AccountID |loadTrackExternalId|load_num|BostonBeansAccountID|Stop1SFID|Stop2SFID|Stop3SFID|Stop4SFID|
      | 0                      | 1| 3                     |SysData=>accountId|SysData=>loadTrackExternalId                     |SysData=>1L|SysData=>Boston_Beans_Account_ID|SysData=>Stop1_ID|SysData=>Stop2_ID|SysData=>Stop3_ID|SysData=>Stop4_ID|

    #Step 10
    #expected Result b
    Then Verify Message "Success - Carrier Banner" displaying stored during enabled logging

