Feature: 544 - Project44 LTL API- Inbound LTL Tracking Operation

  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @Project44 @544
  Scenario: 544 - Project44 LTL API- Inbound LTL Tracking Operation

    When Login into Salesforce
   # Step 1
    Then Set "Org_id" with "OrgData=>Org_Id"

   # Step 2

    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Update details
      | Quick Find           |
      | Remote Site Settings |
    Then Wait for "2" Seconds
    Then Click on "Remote Site Settings" with Text
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Remote Sites ~ Salesforce - Enterprise Edition"
    Then Click on "P" with Text -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "All Remote Sites ~ Salesforce - Enterprise Edition" -
    Then Set count of Text "P44BOL" on to "AvailableCount"
    Then Create New remote Site with Following details
      | Remote Site Name | Remote Site URL                           | Active |
      | P44BOL           | https://prod-1143-images.s3.amazonaws.com | True   |
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

 # Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Project44 Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | 5             | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 8000   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |

  # Step 4
    Then Save Load With All details

  # Step 5 ~ 1
    Then Go to "Freight Quote Assistant" Tab
    Then Capture the current URL for "Load_1"
    Then Set Key "LoadId_SFID" page Record Id with "rtms__Load__c"
    Then Wait for "8" Seconds
    Then Click on View Quotes
    Then Select "AAA Cooper" from View Quotes
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."
    Then Refresh current Page

  # Step 6 ~ 2
#    Then Go to "Details" Tab
#    Then Scroll into Section "Load Summary"
#    Then Set "Load Sequence Number" on to "Load_Sequence_Number"
#    Then Refresh current Page
    Then Search and Select "AAA Cooper Transportation" Account from the Global search
    Then Set key "AAA_CooperID" for Object "Account" and Name "AAA Cooper Transportation"

#  # Step 7 ~ 3
    Then Set "externalid" with "SysData=>Org_id" and "SysData=>LoadId_SFID"
    Then Set "Finalexternalid" with "SysData=>externalid" and "SysData=>AAA_CooperID"
    Then Get "Project44StatusOperation2_with_POD.txt" files and update below Attributes
      | {externalid}             |
      | SysData=>Finalexternalid |

    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Processor | Direction | Status  | Content Type     |
      | Project44 | Inbound   | Pending | application/json |
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "10" Seconds

  # Step 8 ~ 1
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "6" Seconds

  # Step  8 ~ 2     Expected Result a
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Go to "Snapshot" Tab
    Then Verify Details
      | Last Reported Location |
      | NORTH LAS VEGAS, NV    |
    Then Verify Banner Details
      | Departure Date | Departure Time | Stop Status |
      | 9/21/2023      | 17:38          | Departed    |
    Then Verify Banner Details
      | Carrier ETA Date | Carrier ETA Time |
      | 9/25/2023        | 12:00            |

  # Step  9 ~ 3 Expected Result b
    Then Go to "Documents" Tab
    Then Verify Text displaying as "Bill Of Lading.png"




