Feature: 550 - Trucker Tools API- Inbound Location Update

  @Regression @TMS @Smoke @API @WEB @Load_Posting_And_Tracking @SingleCurrency @TruckerTool @550
  Scenario: 550 - Trucker Tools API- Inbound Location Update

    When Login into Salesforce
    #Steps1
    Then Run "QueuedTransactionJob" Job
    Then Wait for "2" Seconds
      #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | TruckerTools    |Tracking Update Frequency (Minutes)|
      | False            |0                                  |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
     #Steps 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload      | Dry Van 48     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | 0830-1200              | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats     |  3            | NA                       | NA             | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Bananas     |15000  |NA          |NA       |NA       |NA    |NA   |NA    |NA            |NA        |
    #Steps 4
    Then Save Load With All details
    #Step5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

    #Step 6
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -
    Then Update details -
    |Tracking Provider         |Driver Phone|Start Time|
    |Trucker Tools             |2179721878  |1:00 AM       |
    Then Click on Native "On" button -
    Then Verify Message displaying as "Success - Carrier Banner"
    Then Close Toast message

    #Step 7
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Set "Load Sequence Number" on to "Load_Sequence_Number"
    Then Refresh current Page
    #Step 8
    Then Click on Text "Boston Beans" on "1" item
    Then Verify Text displaying as "Load"
    Then Set Key "Stop1_SFID" page Record Id with "rtms__Stop__c"

    #Step 9
    Then Get "Inbound_550.txt" files and update below Attributes
      |{loadTrackExternalId}             |{loadNumber}      |{stopExternalId}   |
      |SysData=>Load_Sequence_Number     |SysData=>1L       |SysData=>Stop1_SFID|

    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |Payload 1                |Payload 2|
      |Trucker Tools    |Inbound  |Pending|application/json|SysData=>{FinalUpdatedText}|       |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    #Step 9.1
    Then Wait for "90" Seconds
    Then Set "PreviousRunTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 9.2
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Wait for "4" Seconds
    Then Click on "1P" "Arrived" chevron
    Then Wait for "6" Seconds
    Then Verify details for all Enabled fields
      | Arrival Date  | Arrival Time | Stop Status | Carrier Status Comments | Last Reported City | Last Reported State/Province | Last Reported Country |
      | May 15, 2025  | 11:45        | Arrived     | Arrived at Pickup       | Boston             | MA                            |--None--              |

    #Step 9 ~ 3
    Then Click on "Tracking Log" with Text
    #Expected b
    Then Verify "Arrived at Pickup - Boston Beans - Stop 1" data is created with following details
      |Type             |Reported Location	|Status As Of         |Update Received At(Date)  |Source   |
      |Location Update	|Boston, MA         |5/15/2025, 11:45 AM  |SysData=>PreviousRunTime  |TruckerTools|

    #Step 9-4
    Then Get "Inbound_550_2.txt" files and update below Attributes
      |{loadTrackExternalId}             |{loadNumber}      |
      |SysData=>Load_Sequence_Number     |SysData=>1L       |

    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |Payload 1                |Payload 2|
      |Trucker Tools    |Inbound  |Pending|application/json|SysData=>{FinalUpdatedText}|       |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    #Step 9.4.1
    Then Wait for "90" Seconds
    Then Set "PreviousRunTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 9.4.2
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Wait for "5" Seconds
    Then Verify Details
      |Last Reported Location|
      |Brigham City, UT     |
    #Step 9 ~ 4.3
    Then Click on "Tracking Log" with Text
    #Expected b
    Then Verify "Location Update" data is created with following details
      |Type             |Reported Location	|Status As Of         |Update Received At(Date)  |Source   |
      |Location Update	|Brigham City, UT US|6/12/2025, 2:52 PM   |SysData=>PreviousRunTime  |TruckerTools|



