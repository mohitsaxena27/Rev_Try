Feature: 1584 - P44 TL Tracking API- Inbound Get Load Status Operation

  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @@Project44 @1584
  Scenario: 1584 - P44 TL Tracking API- Inbound Get Load Status Operation

    When Login into Salesforce
    #Steps1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Email Carrier Two" from List
    Then Scroll into Section "Fleet Summary"
    Then Click on Edit icon on "SCAC"
    Then Enter Label "SCAC" Text as "SCAC"
    Then Scroll into Section "US Registration"
    Then Enter Label "US DOT Number" Text as "123456"
    Then Click on "Save" button
    Then Verify "US DOT Number" having value of "123456"

     #Steps 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload      | Dry Van 48     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats     |  3            | NA                       | 1445             | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Bananas     |15000  |NA          |NA       |NA       |NA    |NA   |NA    |NA            |NA        |
    #Steps 3
    Then Save Load With All details
    Then Capture the current URL for "Load_1"
    #Step4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page
    #Step5
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Set "Bill of Lading Number" on to "{Bill_of_Lading_Number}"
    Then Refresh current Page
    #Step 6
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -
    Then Update details -
    |Tracking Provider         |Driver Phone|
    |Project44 Tracking        |2179721878  |
    Then Click on Native "On" button -
    Then Verify Message displaying as "Success - Carrier Banner"
    Then Close Toast message

#    #Step 7
#    Then Wait for "20" Seconds
#    Then Refresh current Page
#    Then Wait for "5" Seconds
#    Then Refresh current Page
#    Then Wait for "2" Seconds
#    Then Click on "Tracking Log" with Text
#    #Expected Result a
#    Then Verify "The shipment has been dispatched." data is created with following details
#      |Type           |Status As Of(Date)|Update Received At(Date)  |Source   |
#      |Driver Event	  |0                 |0                         |Project44|
#    Then Verify "Entered tracking update window" data is created with following details
#    |Type           |Status As Of(Date)|Update Received At  |Source|
#    |Driver Event	|0                 |0                   |Project44|

    Then Get "1584_Project44InboundTLTracking.txt" files and update below Attributes
         |{DOT_NUMBER}|{BILL_OF_LADING}                  |{Load ID}      |
         |123456     |SysData=>{Bill_of_Lading_Number}    |SysData=>1LRI|

    #Step 8
    Then Open "Queued Transactions" from App Launcher
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
    |Processor         |Direction|Status |Content Type    |Payload 1                |Payload 2|
    |Project44 Tracking|Inbound  |Pending|application/json|SysData=>{FinalUpdatedText}|       |
    Then Wait for "5" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
#    Then Verify Text displaying as "was created" -

    #Step 9 ~ 1
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "6" Seconds
    Then Set "PreviousRunTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 10 ~ 2
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Go to "Snapshot" Tab
    #Expected b
    Then Verify Details
      |Last Reported Location|
      |Avoca, IA             |
    Then Verify Banner Details
    |Arrival Date|Arrival Time|Departure Date|Departure Time|
    |9/15/2023   |09:57       |9/15/2023     |10:46         |
    Then Verify Banner Details
      |Carrier ETA Date|Carrier ETA Time|
      |9/17/2023       |00:05           |
    #Step 11 ~ 3
    Then Click on "Tracking Log" with Text
    #Expected c
    Then Verify "The vehicle is idle." data is created with following details
      |Type             |Reported Location	|Status As Of         |Update Received At(Date)  |Source   |
      |Location Update	|Avoca, IA US       |9/16/2023, 2:20 PM   |SysData=>PreviousRunTime  |Project44|



