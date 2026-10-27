Feature: 2333 - SMC3 EVA API- Document Operation

  Background: Pre- Test
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "SMC3 EVA" in the "Search Credentials..." search box
    Then Select the "SMC3 EVA" record from the lookup field results
    Then Get Public IP and Store it into "PublicIP"
    Then Get Label Value
         |Code|Inbound Packet IP Ranges|
         |    |                        |
    Then Set "Set_IP" with "SysData=>Inbound Packet IP Ranges" and ", "
    Then Set "Final_IP" with "SysData=>Set_IP" and "SysData=>PublicIP" if not exist
    And Update details for "Catena" service
      | Callback Endpoint Created |Inbound Packet IP Ranges|
      | True                      |SysData=>Final_IP       |
    And Click on Native "Save" button
    Then Wait for "3" Seconds

  @API @Regression @WEB @TMS @Smoke  @API_Operation @SingleCurrency @2333 @SMC3EVAAPI @Debugging
  Scenario: 2333 - SMC3 EVA API- Document Operation

     #Step 1, 2 ,3 & 4
    #Step 2 is included in  Pre-Execution Steps
    # Step4
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 5
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | NA        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 4500   | NA           | 10       | Pallets        | 24     | 48    | 48     | NA             | 50         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds
    And "Without Capture" and Close all the Toast messages from Bottom

    # Step 7
    Then Click on View Quotes
    Then Wait for "2" Seconds
    Then Select exact "SMC3 EVA Carrier - SMC3 EVA" from View Quotes
    Then Wait for "1" Seconds
    Then "Tender" Carrier

    # Expected a)
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify Message "Load tendered successfully." displaying stored during enabled logging
    Then Verify Assertion for "document_Url" contains "documentType=ALL"
    Then Verify Assertion for "document_Url" contains "fileType=PNG"

    # Step 8 & Expected b
    Then Go to "Summary" Tab
    Then Verify Banner Details
      | Load Status |
      | In Transit  |

    #Step 9
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"

    # Expected c)
    Then Verify Details
      | Tracking Provider |
      | SMC3 EVA          |
    Then Get Details
      | Tracking Number |
      |                 |
    Then Verify "Tracking Number" is Not null or Empty

    # Step 10
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "6" Seconds

    # Step 11 & Expected d)
    Then Navigate to stored URL for "Load_1"
#    Then Get "rtms__Payload_1__c" from "rtms__QueuedTransaction__c" using "rtms__Processor__c" with value "SMC3 EVA DOCUMENT" & "rtms__Status__c" with value "Processed" and Store into "Payload1"
#    Then Get Attribute "transactionId" store into "transactionId" from "Payload1"
#    Then Go to "Details" Tab
#    Then Scroll into Section "Tracking Information"
#    Then Scroll into Section "Tracking IDs"
#    Then Click on Edit icon on "Tracking Notes"
#    Then Update details
#      | Document Polling Number | Tracking Provider |
#      | SysData=>transactionId  | SMC3 EVA          |
#    Then Click on Native "Save" button
#    Then Wait for "80" Seconds
    Then Wait until any one file is present in the Documents tab for "Load_1" with a maximum wait of 35 minutes for push updates

    # Step 12
    Then Refresh current Page
    Then Go to "Details" Tab
    Then Click on Edit icon on "Load Status"
    Then Update details
      | Load Status |
      | Cancelled   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 13
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | NA        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 4500   | NA           | 10       | Pallets        | 24     | 48    | 48     | NA             | 50         |

    # Step 14
    Then Save Load With All details
    Then Capture the current URL for "Load_2"

    # Step 15
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking Information"
    Then Scroll into Section "Tracking IDs"
    Then Click on Edit icon on "Tracking Notes"
    Then Update details
      | Document Polling Number | Tracking Provider |
      | 2333                    | SMC3 EVA          |
    Then Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Document Polling Number | Tracking Provider |
      | 2333                    | SMC3 EVA          |

    #Step 16, 17, 18 & 19
    Then Send Post Request for SMC3 EVA Document Operation with File "2333_SMC3EVADocumentationOperation_BL_QT1.txt"
    Then Send Post Request for SMC3 EVA Document Operation with File "2333_SMC3EVADocumentationOperation_DR_QT2.txt"
    Then Send Post Request for SMC3 EVA Document Operation with File "2333_SMC3EVADocumentationOperation_INV_QT3.txt"
    Then Send Post Request for SMC3 EVA Document Operation with File "2333_SMC3EVADocumentationOperation_WC_QT4.txt"
    Then Wait for "80" Seconds
    # Step 20
    Then Navigate to stored URL for "Load_2"
    Then Go to "Documents" Tab
    Then Go to "Files" Tab
    Then Wait for "6" Seconds

    # Expected e)
    Then Verify Text displaying as "Weight & Inspection Certificate.PNG"
    Then Verify Text displaying as "Delivery Receipt.PNG"
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Bill Of Lading.PNG"
    Then Verify Text displaying as "Invoice.PNG"

    # Step 21
    Then Refresh current Page
    Then Go to "Details" Tab
    Then Scroll into Section "Assigned Carrier Information"
    # Expected f)
    Then Verify Label Checkbox
      | POD Received |
      | True         |