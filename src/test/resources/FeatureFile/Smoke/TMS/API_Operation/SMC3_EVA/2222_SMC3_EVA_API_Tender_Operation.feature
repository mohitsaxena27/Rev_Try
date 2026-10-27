Feature: 2222 - SMC3 EVA API- Tender Operation

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2222 @SMC3EVAAPI @Debugging
  Scenario: 2222 - SMC3 EVA API- Tender Operation

    When Login into Salesforce
    #Step1
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

    #Step2 & 3
    Then Search and Select "rtms__CarrierService__c" "SMC3 EVA Carrier - SMC3 EVA" from the Global search
    Then Wait for "2" Seconds
    Then Scroll into Section "Carrier Quote  & Settlement Contacts (Default)"
    Then Click on Edit icon on Label "Quote Contact"
    Then Update details
      | Quote Contact    | Quote Method |
      | Joe Boston Beans | Phone        |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify "Quote Contact" having value of "Joe Boston Beans"
    Then Capture the current URL for "Carrier_Service_SMC3"

    #Step 4
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 EVA Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Bulls | 3            | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA            | NA                       | 0800-0915        | NA                   |
    Then Wait for "1" Seconds
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 4500   | NA           | 10       | Pallets        | 24     | 48    | 48     | NA             | 50         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step5 & 6
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "Bill of Lading Number"
    Then Update details
      | Bill of Lading Number | PO Number |
      | 112233                | A123      |
    Then Click on "Save" button
    Then Wait for "2" Seconds

    #Step 7
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom

    #Step 8
    Then "New" Carrier
    Then Verify Text displaying as "New Carrier Quote"
    Then Enter Carrier Service as "SMC3 EVA Carrier - SMC3 EVA"
    And Wait for "1" Seconds
    Then Enter Label "Carrier Quote Reference" Text as "CarrierQuoteRef"
    Then "Save" Carrier
    Then Wait for "2" Seconds

    #Step 9
     Then Click on Carrier Quote from FQA Page
     Then Wait for "2" Seconds

    #Step 10
     Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Click on Edit icon on Label "Bill To"
     Then Update details
          |Bill To|Customer API Access Id|
          |Jacksonville Jaguars|Revenova-126351|
    Then Enter Label "Bill To Override" Text as "QA2222!"
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
         |Bill To Override|
         |QA2222!|
    Then Go to "Pricing" Tab
    Then Wait for "1" Seconds
    #Step 11
    Then Click on button with Title "Tender"
    And "Capture" and Close all the Toast messages from Bottom

    #Step 12, 13 , Expected Result a & b
    Then Get Attribute "transactionId" store into "Transaction1" from "SMCA" "Response"
    Then Get Attribute "referenceNumbers[1].number" store into "pro_Number" from "SMCA" "Response"
    And Update and verify Response payload for "SMCA" with "TC2222_Response_Expected_Dispatch1.json"
      | Transaction1 |
      | Transactional |
    Then Get Attribute "revenovaId" store into "{revenovaId}" from "SMCA" "Request"
    And Update and verify payload for "SMCA" with "TC2222_RequestBody_Expected.json"
      | {revenovaId} |{CurrentDateYYYYMMDD+3}|
      | Transactional|3|
    #Step 14 , Expected Result c
    Then Verify Message "Load tendered successfully." displaying stored during enabled logging

      #  Step 15
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Click on Edit icon on Label "Bill To"
    Then Update details
         |Bill To|
         |       |
    Then Enter Label "Bill To Override" Text as ""
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Bill To Override|Bill To|
      ||                       |
    #Step 16
    Then Navigate to stored URL for "Load_1"
    Then Wait for "2" Seconds
     #Step 17 #Expected d
    Then Scroll Up with "2" Times
    Then Verify Banner Details
         |Load Status|
         |Assigned   |

    #Step18 Expected e)
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    And Verify Details
      | Tracking Number         |
      |                         |
     #Expected f)
    Then Scroll into Section "Shipment IDs"
    And Verify Details
      | PRO Number             |
      | SysData=>pro_Number    |

    #Step19 Expected g)
    Then Go to "Shipment" Tab
    Then Scroll into Section "Chicago Bulls"
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Verify details for
      | Pickup/Delivery Number |
      | 55667788               |

    #Step 20
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Click on Carrier Quote from FQA Page

    #Step 21
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Service Information"
    Then Click on Edit icon on Label "Service Class"
    Then Enter Label "Service Class" Text as "GTD_NOON"
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Service Class|
      |GTD_NOON|
    Then Go to "Pricing" Tab
    Then Wait for "1" Seconds

    #Step 22
    Then Click on button with Title "Tender"
    And "Capture" and Close all the Toast messages from Bottom
    Then Get Attribute "transactionId" store into "Transaction1" from "SMCA" "Response"
    Then Get Attribute "referenceNumbers[1].number" store into "pro_Number" from "SMCA" "Response"
       # Expected h
    Then Get Attribute "revenovaId" store into "{revenovaId}" from "SMCA" "Request"
    And Update and verify payload for "SMCA" with "TC2222_Request_Expected_Notification.json"
      | {revenovaId} |{CurrentDateYYYYMMDD+3}|
      | Transactional|3|