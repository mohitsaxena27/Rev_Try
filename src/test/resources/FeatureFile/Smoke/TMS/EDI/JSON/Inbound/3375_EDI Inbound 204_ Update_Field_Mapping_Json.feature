Feature: 3375 - EDI Inbound 204- Field Mapping: Update (JSON)

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @3375
  Scenario: 3375 - EDI Inbound 204- Field Mapping: Update (JSON)

#    #Pre-conditions
    When Login into Salesforce
     #Pre-Request
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI|
      | True        |True                |
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Test Instructions
    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Equipment Types" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on Partial Link Text "Container 45" on Page -
    Then Switch to Parent Frame
    Then Scroll into Section "General Information"
    Then Click on Edit icon on Label "Mode"
    Then Edit the following to De-Select "Move selection to Available"
      | Mode      |
      | Truckload |
    Then Wait for "1" Seconds
    Then Click on "SaveEdit" button
    Then Capture the current URL for "EquipmentTypes"

    #Step 2 & 3
    Then Send Post Request for EDI with Json "Create_Load_3375.txt" with Access Token as "Access_Token"
    Then Wait for "60" Seconds


#    Step 4
    Then Open "Loads" from App Launcher
    Then Search and Select "Load-3375" from List
    Then Set Key "1LRI" page Record Id with "rtms__Load__c"
    Then Capture the current URL for "Load_url"
    Then Go to "Details" Tab

    #Expected a
    Then Scroll into Section "Team Assignments & Status"
    Then Verify Details
      | Load Status | Sales Status |
      | Unassigned  | Won          |
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      | Customer    | Customer Bill To | PO Number | Order Number | Bill of Lading Number |
      | Revenova HQ | Revenova HQ      | 3375      | ON3375       | 3375BOL               |
    Then Scroll into Section "Carrier Requirements"
    Then Verify Details
      | Mode      | Equipment Type | Other Instructions |
      | Truckload | Dry Van 53'    | Hello World        |
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Origin           | Destination   | Distance (Miles) | Total Weight | Weight Units |
      | ATLANTA, Georgia | Irving, Texas | 250.00           | 20,300       | lbs          |
    Then Verify Label Checkbox
      | Freeze Distance | HazMat |
      | true            | true   |

    Then Verify Details
      | Cargo Summary                                                                                           |
      | 10 Pallets (48.00x48.00x48.00 in), CLOTHING LT/12 PCF, 20000 lbs\n3 Pallets CLOTHING LT/12 PCF, 300 lbs |

    Then Verify Details
      | Cargo Value | Commodity Condition | Total Volume | Volume Units | Stops |
      | USD 50,000  | NA                  | 200          | Cubic Feet   | 3     |

    Then Verify Details
      | Payment Terms |
      | Collect       |

    #Step 5 & 6
    Then Scroll into Section "Carrier Requirements"
    Then Click on Edit icon on Label "Equipment Type"
    Then Update details
      | Equipment Type | Other Instructions |
      |                |                    |
    Then Click on "Save" button
    Then Wait for "3" Seconds

    #Step 7
    Then Open "EDI Transactions" from App Launcher
    Then Wait for "1" Seconds

    #Step 8
    Then Click on button with Title "New"
    Then Get "Update_Load_3375.txt" files and update below Attributes
      |No Update Required|
      |                  |
    Then Wait for "3" Seconds
    Then Update details
         |Load     |Trading Partner|EDI Location|Transaction Type|Purpose|Direction|EDI Provider|
         |Load-3375|Revenova HQ|KLIQA|204|Update|Inbound|Kleinschmidt|
    Then Click on "Transaction Payload" TextArea
    Then Enter Label "Transaction Payload" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      |Status|
      |Failure|
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    #Step 9
    Then Scroll into Section "EDI Provider Status"
    Then Click on Edit icon on Label "Status"
    Then Update details
        |Status |
        |Pending|
    Then Click on "SaveEdit" button
    Then Wait for "60" Seconds

    #Step 10
    Then Navigate to stored URL for "Load_url"
    Then Refresh current Page
    Then Go to "Details" Tab

    #Expected b
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      | PO Number | Order Number | Bill of Lading Number |
      | 3375ABC   | ON3375AB**   | 3375BOL 957           |
    Then Scroll into Section "Carrier Requirements"
    Then Verify Details
      | Equipment Type | Other Instructions |
      |                | Container 45' Hello World        |
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Distance (Miles) |
      | 750.00           |
    Then Verify Details
      | Cargo Value |
      | USD 70,000  |
    Then Verify Details
      | Payment Terms |
      | Prepaid       |

    #Step 11
    Then Go to "Shipment" Tab
    Then Scroll into Section "Oldgistics - ATL8"
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds

    #Expected Result c
    Then Verify "1P" Stop with "5267 ROYAL SOUTH PKWY STE 432, ATLANTA, Georgia 30349"
    Then Verify details for
      | Location          | Expected Date | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | References | Pickup/Delivery Number | Instructions   |
      | Oldgistics - ATL8 | 8/25/2028     | 13:30-15:00      | George Smiley              | 13:30-15:00             | NA         | NA                     | go to dock 122 |
    Then Verify details For Checkbox
      | Appointment Required |
      | True                 |
    Then Collapse "Details" for "1" Load

    #Step 12
    Then Expand "Items" for "1" Load
    #Expected d.a & d.b
    Then the Stop Detail table should have the following items:
      | # | Item Number | Cargo Summary                                               | Pickup Stop              | Delivery Stop                |
      | 1 | MG12345     | 18 Pallets (48.00x48.00x48.00 in), STUFF TO HAUL, 20000 lbs | Stop 1-Oldgistics - ATL8 | Stop 2-ATCLE-FW              |
      | 2 | MG000520789 | 3 Pallets CLOTHING LT/12 PCF, 300 lbs                       | Stop 1-Oldgistics - ATL8 | Stop 3-NeimanMarcus - Irving |

    Then Collapse "Items" for "1" Load

     #Step 13
    Then Expand "Accessorials" for "1" Load
    #Expected e
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "1" Load

    #Step 14
    Then Scroll into Section "ATCLE-FW"
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds

    #Expected Result f
    Then Verify "2D" Stop with "13550 Independence Parkway, Fort Worth, Texas 76177"
    Then Verify details for
      | Location | Expected Date | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | References | Pickup/Delivery Number | Instructions |
      | ATCLE-FW | 8/26/2028     | 06:00-08:00      | NA                         | 06:00-08:00             | NA         | NA                     | NA           |
    Then Verify details For Checkbox
      | Appointment Required |
      | False                |
    Then Collapse "Details" for "2" Load

   #Step 15
    Then Expand "Items" for "2" Load
    Then Click on "Edit" on "1" item
    Then Wait for "5" Seconds

    #Expected g
    Then Verify details for all Required Enabled fields
      | Item Number | Item Description | Weight | Delivery Stop                                            |
      | MG12345     | STUFF TO HAUL    | 20,000 | Stop 2 - ATCLE-FW 13550 Independence Parkway, Fort Worth |
    Then Verify details for all Enabled fields
      | Weight Units | HU Count | Handling Units | Length | Width | Height | Dimension Units | NMFC Class | HazMat |
      | lbs          | 18       | Pallets        | 48.00  | 48.00 | 48.00  | in              | 55         | True   |
    Then Verify details for all Enabled fields
      | HazMat Number Type | HazMat Number | HazMat Class/Division | HazMat Packaging Group | HazMat Contact        |
      | UN                 | 1234          | 1.1                   | III                    | Harrison Ford Updated |
    Then Verify details for all Disabled or Readonly fields
      | Pickup Stop                                                      |
      | Stop 1 - Oldgistics - ATL8 5267 ROYAL SOUTH PKWY STE 432, ATLANTA |
    Then Click on "Cancel" with Text
    Then Collapse "Items" for "2" Load

    #Step 16
    Then Expand "Accessorials" for "2" Load

    #Expected h
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "2" Load

    #Step 17
    Then Scroll into Section "NeimanMarcus - Irving"
    Then Expand "Details" for "3" Load
    Then Wait for "1" Seconds

    #Expected Result i
    Then Verify "3D" Stop with "123 Customer Way, Irving, Texas 75039"
    Then Verify details for
      | Location              | Expected Date | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | References | Pickup/Delivery Number | Instructions |
      | NeimanMarcus - Irving | 8/26/2028     | 06:30-08:30      | NA                         | 06:30-08:30             | NA         | NA                     | NA           |
    Then Verify details For Checkbox
      | Appointment Required |
      | False                |
    Then Collapse "Details" for "3" Load

   #Step 18
    Then Expand "Items" for "3" Load
    Then Click on "Edit" on "1" item
    Then Wait for "5" Seconds
    #Expected j
    Then Verify details for all Required Enabled fields
      | Item Number | Item Description   | Weight | Delivery Stop                                           |
      | MG000520789 | CLOTHING LT/12 PCF | 300    | Stop 3 - NeimanMarcus - Irving 123 Customer Way, Irving |
    Then Verify details for all Enabled fields
      | Weight Units | HU Count | Handling Units | Length | Width | Height | Dimension Units | NMFC Class | HazMat |
      | lbs          | 3        | Pallets        |        |       |        | in              |            | False  |
    Then Verify details for all Disabled or Readonly fields
      | Pickup Stop                                                              |
      | Stop 1 - Oldgistics - ATL8 5267 ROYAL SOUTH PKWY STE 432, ATLANTA |
    Then Update details
      | HazMat |
      | false  |
    Then Wait for "2" Seconds
    Then Click on "Cancel" with Text
    Then Collapse "Items" for "3" Load

    #Step 19
    Then Expand "Accessorials" for "3" Load

    #Expected k
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "3" Load

    #Step 20
    Then Scroll Until Related List for "Load Accessorials"

    #Expeced l
    Then Verify "Load Accessorials" Table details with following Details
      | Load Accessorial: Name      |
      | Hazardous Material Handling |

    #Step 21
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds

    #Expected m
    Then Verify details for all Enabled fields
      | Status   | Pricing  | Quote Date |
      | Accepted | Contract | 0          |
    Then Verify Customer "Freight Charges" displaying as "5,000"
    Then Verify Customer "Fuel Surcharge" displaying as "250"
    Then Verify Customer "Accessorial Charges" displaying as "300"
    Then Verify Customer "Quote Total" displaying as "5,550"

    #Step 22 & Expected Result n
    Then Verify "Customer Quote Items" "Net Freight Charges" with details "Fixed Cost,,1,,5,000,,5,000"
    Then Verify "Customer Quote Items" "Fuel Surcharge" with details "Fixed Cost,,1,,250,,250"
    Then Verify "Customer Quote Items" "Lift Gate" with details "Fixed Cost,,1,,100,,100"
    Then Verify "Customer Quote Items" "Lumper" with details "Fixed Cost,,1,,200,,200"

    #Step 23
    Then Search and Select "Oldgistics - ATL8" Account from the Global search

    #Step 32
    Then Go to "Contacts" Tab
    Then Click on "Harrison Ford Updated" with Text

    #Expected o
    Then Verify "Name" having value of "Harrison Ford Updated"
    Then Verify "Transportation Role" having value of "HazMat"
    Then Verify "Phone" having value of "(312) 888-9999"
    Then Verify "Email" having value of "hford@revenova.com"