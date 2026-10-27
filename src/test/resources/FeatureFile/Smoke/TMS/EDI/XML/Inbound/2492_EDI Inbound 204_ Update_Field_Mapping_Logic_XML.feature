Feature: 2492 - EDI Inbound 204 - Update: Field Mapping Logic (XML)

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @2492
  Scenario: 2492 - EDI Inbound 204 - Update: Field Mapping Logic (XML)

    #Pre-conditions
    When Login into Salesforce
    #-----------------------------------------------------
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Cleo" in the "Search Credentials..." search box
    Then Select the "Cleo" record from the lookup field results
    And Update details for "Cleo" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Search text "Custom EDI" in the "Search Credentials..." search box
    Then Select the "Custom EDI" record from the lookup field results
    And Update details for "Custom EDI" service
      | Enabled |
      | False   |
    And Click on Native "Save" button

    #Step 2
    Then Go to Home Page
    Then Wait for "6" Seconds
    Then Verify and Delete "EDIWatcherJob" from Scheduled Jobs

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

    #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"

    #Step 3
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | Use REST API for EDI |
      | False                |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | EDI Enabled | Enable EDI Transaction Logging |
      | True        | True                           |
    And Update the Custom Select option "EDI Administrator" as "User User"
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"

    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 4, 5 & 6
    Given Upload File "KleinschmidtGetLoadTendersOperation_Load_2492_Original.xml" with Title "KleinschmidtGetLoadTendersOperation"

    #Step 7
    Then Go to "Home" Object
    Then Run "EDIWatcherJob" Job
    Then Wait for "120" Seconds

    #Step 8
    Then Open "Loads" from App Launcher
    Then Search and Select "Load-2492" from List
    Then Set Key "1LRI" page Record Id with "rtms__Load__c"

    #Step 9
    Then Go to "Details" Tab

    #Expected a
    Then Scroll into Section "Team Assignments & Status"
    Then Verify Details
      | Load Status | Sales Status |
      | Unassigned  | Won          |
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      | Customer    | Customer Bill To | PO Number | Order Number | Bill of Lading Number |
      | Revenova HQ | Revenova HQ      | 2492      | ON2492       | 2492BOL               |
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

    #Step 10 & 11
    Then Scroll into Section "Carrier Requirements"
    Then Click on Edit icon on Label "Equipment Type"
    Then Update details
      | Equipment Type | Other Instructions |
      |                |                    |
    Then Click on "Save" button
    Then Wait for "3" Seconds

  #Step12
    Then Go to Home Page
    Then Verify and Delete "EDIWatcherJob" from Scheduled Jobs

  #Step13
    Then Delete Field with Title "KleinschmidtGetLoadTendersOperation"

  #Step14 & 15
    Given Upload File "KleinschmidtGetLoadTendersOperation (Load-2492 Update).xml" with Title "KleinschmidtGetLoadTendersOperation"

    #Step16
    Then Go to "Home" Object
    Then Run "EDIWatcherJob" Job
    Then Wait for "10" Seconds

    #Step 17
    Then Open "Loads" from App Launcher
    Then Search and Select "Load-2492" from List
    Then Set Key "1LRI" page Record Id with "rtms__Load__c"

    #Step 18
    Then Refresh current Page
    Then Go to "Details" Tab

    #Expected b
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      | PO Number | Order Number | Bill of Lading Number |
      | 2492ABC   | ON2492AB**   | 2492BOL 957           |
    Then Scroll into Section "Carrier Requirements"
    Then Verify Details
      | Equipment Type | Other Instructions |
      |                | Hello World        |
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

    #Step 19
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

    #Step 20
    Then Expand "Items" for "1" Load
    #Expected d.a & d.b
    Then the Stop Detail table should have the following items:
      | # | Item Number | Cargo Summary                                               | Pickup Stop              | Delivery Stop                |
      | 1 | MG12345     | 18 Pallets (48.00x48.00x48.00 in), STUFF TO HAUL, 20000 lbs | Stop 1-Oldgistics - ATL8 | Stop 2-ATCLE-FW              |
      | 2 | MG000520789 | 3 Pallets CLOTHING LT/12 PCF, 300 lbs                       | Stop 1-Oldgistics - ATL8 | Stop 3-NeimanMarcus - Irving |

    Then Collapse "Items" for "1" Load

     #Step 21
    Then Expand "Accessorials" for "1" Load
    #Expected e
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "1" Load

    #Step 22
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

   #Step 23
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

    #Step 24
    Then Expand "Accessorials" for "2" Load

    #Expected h
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "2" Load

    #Step 25
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

   #Step 26
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

    #Step 27
    Then Expand "Accessorials" for "3" Load

    #Expected k
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "3" Load

    #Step 28
    Then Scroll Until Related List for "Load Accessorials"

    #Expeced l
    Then Verify "Load Accessorials" Table details with following Details
      | Load Accessorial: Name      |
      | Hazardous Material Handling |

    #Step 29
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds

    #Expected m
    Then Verify details for all Enabled fields
      | Status   | Pricing  | Quote Date |
      | Accepted | Contract | 0          |
    Then Verify Customer "Freight Charges" displaying as "5,000"
    Then Verify Customer "Fuel Surcharge" displaying as "250"
    Then Verify Customer "Accessorial Charges" displaying as "300"
    Then Verify Customer "Quote Total" displaying as "5,550"

    #Step 30 & Expected Result n
    Then Verify "Customer Quote Items" "Net Freight Charges" with details "Fixed Cost,,1,,5,000,,5,000"
    Then Verify "Customer Quote Items" "Fuel Surcharge" with details "Fixed Cost,,1,,250,,250"
    Then Verify "Customer Quote Items" "Lift Gate" with details "Fixed Cost,,1,,100,,100"
    Then Verify "Customer Quote Items" "Lumper" with details "Fixed Cost,,1,,200,,200"

    #Step 31
    Then Search and Select "Oldgistics - ATL8" Account from the Global search

    #Step 32
    Then Go to "Contacts" Tab
    Then Click on "Harrison Ford Updated" with Text

    #Expected o
    Then Verify "Name" having value of "Harrison Ford Updated"
    Then Verify "Transportation Role" having value of "HazMat"
    Then Verify "Phone" having value of "(312) 888-9999"
    Then Verify "Email" having value of "hford@revenova.com"