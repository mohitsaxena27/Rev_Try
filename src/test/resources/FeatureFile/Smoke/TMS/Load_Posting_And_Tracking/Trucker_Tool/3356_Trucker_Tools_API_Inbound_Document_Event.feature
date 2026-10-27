Feature: 3356 - Trucker Tools API- Inbound Document Event

  Background: Pre- Test
    When Login into Salesforce
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Update details
      |Quick Find      |
      |Remote Site Settings|
    Then Wait for "2" Seconds
    Then Click on "Remote Site Settings" with Text
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Remote Sites ~ Salesforce - Enterprise Edition"
    Then Click on "T" with Text -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "All Remote Sites ~ Salesforce - Enterprise Edition" -
    Then Verify Text displaying as "TruckerTools" -
    Then Set count of Text "Truckertoolsdocument" on to "AvailableCount"
    Then Create New remote Site with Following details
         |Remote Site Name|Remote Site URL|Active|
         |Truckertoolsdocument|https://assets.truckertools.com|True|
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

  @Regression @TMS @Smoke @API @WEB @Load_Posting_And_Tracking @SingleCurrency @TruckerTool @3356
  Scenario: 3356 - Trucker Tools API- Inbound Document Event

    #Steps1
    Then Run "QueuedTransactionJob" Job
    Then Wait for "2" Seconds

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload      | Dry Van 48     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA              | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats     |  3            | NA                       | NA             | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Bananas     |15000  |NA          |NA       |NA       |NA    |NA   |NA    |NA            |NA        |
    #Steps 3
    Then Save Load With All details

    #Step4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

    #Step 5
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -
    Then Update details -
    |Tracking Provider         |Driver Phone|Start Time|
    |Trucker Tools             |2179721878  |9:00 AM       |
    Then Click on Native "On" button -
    Then Verify Message displaying as "Success - Carrier Banner"
    Then Close Toast message

    #Step 6
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Set "Load Sequence Number" on to "Load_Sequence_Number"
    Then Refresh current Page


    #Step 7
    Then Get "Inbound_3356.txt" files and update below Attributes
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
    #Step 7.1
    Then Wait for "120" Seconds
    #Step 7.2
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Wait for "4" Seconds
    Then Go to "Documents" Tab
    #Expected Result a
    Then Verify Text displaying as "Driver Upload-Bill of Ladings.jpg"
    