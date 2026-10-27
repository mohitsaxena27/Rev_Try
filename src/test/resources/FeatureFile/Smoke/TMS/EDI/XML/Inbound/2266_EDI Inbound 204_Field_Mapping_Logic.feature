Feature: 2266 - EDI Inbound 204- Original: Field Mapping Logic

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @2266
  Scenario: 2266 - EDI Inbound 204- Original: Field Mapping Logic

    When Login into Salesforce
    #-----------------------------------------------------
    #Step1
    Then Verify and Delete "EDIWatcherJob" from Scheduled Jobs
    #Step 2
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

    #Step 3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Accessorials" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Exhibition/Trade Show Pick Up" with Text -
    Then Switch to Parent Frame
    Then Click on Edit icon on Label "Limited Access"
    Then Update details
      | Limited Access |
      | True           |
    Then Click on "SaveEdit" button
    Then Capture the current URL for "Accessorials"

    #Step 4
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      |Use REST API for EDI|
      |False               |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"
   #Step 5
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Enable EDI Transaction Logging |
      | True        | True                           |
    And Update the Custom Select option "EDI Administrator" as "User User"
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"

    Then Update details -
      | Inbound 204 | Inbound 990 | Inbound 214 | Inbound 210 | Inbound 824 | Inbound 322 | Inbound 410 | Outbound 990 | Outbound 204 | Outbound 210 | Outbound 214 | Outbound 404 | Outbound 998 |
      | True        | True        | True        | True        | True        | True        | True        | True         | True         | True         | True         | True         | True         |

    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 6
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Revenova HQ" from List
    Then Scroll into Section "Carrier Tracking Administration"
    Then Click on Edit icon on Label "Automatic Carrier Tracking"
    Then Update details
      | Automatic Carrier Tracking | Tracking Provider | Automatic Tracking Start Trigger |
      | Enabled                    | FourKites         | 1 Hour Before Pickup             |
    Then Select "Automatic Carrier Tracking Enabled Modes" as "Truckload" from Dueling List
    Then Click on "Save" button on Details Page
    Then Verify "Automatic Carrier Tracking" having value of "Enabled"

     #Step 7, 8 & 9
    Given Upload File "KleinschmidtGetLoadTendersOperation (Load-2266).xml" with Title "KleinschmidtGetLoadTendersOperation"

    #Step 10
    Then Go to "Home" Object
    Then Run "EDIWatcherJob" Job
    Then Wait for "30" Seconds
    #Step 11
    Then Open "Loads" from App Launcher
    Then Search and Select "Load-2266" from List
    Then Set Key "1LRI" page Record Id with "rtms__Load__c"
    #Step 12
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    #Expected a
    Then Scroll into Section "Team Assignments & Status"
    Then Verify Details
      | Load Status | Sales Status |
      | Unassigned  | Won          |
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      | Customer    | Customer Bill To | PO Number | Order Number | Bill of Lading Number |
      | Revenova HQ | Revenova HQ      | 2266      | ON2266       | 2266BOL               |
    Then Scroll into Section "Carrier Requirements"
    Then Verify Details
      | Mode      | Equipment Type | Other Instructions |
      | Truckload | Dry Van 53'    | Hello World        |
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Origin           | Destination      | Distance (Miles) | Total Weight | Weight Units |
      | Phoenix, Arizona | Arlington, Texas | 250.00           | 21,600       | lbs          |
    Then Verify Label Checkbox
      | Freeze Distance | HazMat |
      | true            | true   |

    Then Verify Details
      | Cargo Summary                                                                                                                        |
      | 10 Pallets (48.00x48.00x48.00 in), CLOTHING LT/12 PCF, 20000 lbs\n3 Pallets CLOTHING LT/12 PCF, 300 lbs\n1 Pallets Hangers, 1300 lbs |

    Then Verify Details
      | Cargo Value | Commodity Condition | Total Volume | Volume Units | Stops |
      | USD 50,000  | NA                  | 200          | Cubic Feet   | 4     |

    Then Verify Details
      | Payment Terms |
      | Collect       |

    Then Scroll into Section "Tracking Information"
    Then Verify Label Checkbox
      | Automatic Carrier Tracking |
      | true                       |

    #Step 13
    Then Go to "EDI" Tab
    #Expected b
    Then Verify Details
      | EDI Response Deadline | EDI Quote Total |
      | 12/23/2028, 7:30 PM   | USD 5,500.00    |
     #Step 14 #Expected c
    Then Verify "Load References" Table With Details
      | Stop   | Type | Label                     | Value             |
      | Stop 1 | PO   | PO Number                 | 02240044          |
      | Stop 2 | BM   | BOL Number                | 04022401275315659 |
      | Stop 2 | CR   | Customer Reference Number | LD000461060       |
      | Stop 3 | PO   | PO Number                 | 02240044          |

    #Step 15
    Then Click If button with Title "More Tabs" is enabled
    Then Go to "Insurance/Claims" Tab
    #Expected d
    Then Verify Details
      | Insurance Amount |
      | USD 250.00       |
    Then Refresh current Page
    #Step 16
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds

    #Expected Result e
    Then Verify "1P" Stop with "401 E Jefferson St, Phoenix, Arizona 85004"
    Then Verify "1P" Stop with "312-888-9999"
    Then Verify details for
      | Location             | Expected Date | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | References | Pickup/Delivery Number | Instructions   |
      | Arizona Diamondbacks | 8/24/2028     | 13:00-15:00      | George Smiley              | 13:00-15:00             | NA         | NA                     | go to dock 122 |
    Then Verify details For Checkbox
      | Appointment Required |
      | False                |
    Then Collapse "Details" for "1" Load

    #Step 17
    Then Expand "Items" for "1" Load
    #Expected f
    Then the Stop Detail table should have the following items:
      | # | Item Number | Cargo Summary                                                    | Pickup Stop                 | Delivery Stop                |
      | 1 | MG000520788 | 10 Pallets (48.00x48.00x48.00 in), CLOTHING LT/12 PCF, 20000 lbs | Stop 1-Arizona Diamondbacks | Stop 2-Arizona Cardinals     |
      | 2 | MG000520789 | 3 Pallets CLOTHING LT/12 PCF, 300 lbs                            | Stop 1-Arizona Diamondbacks | Stop 3-NeimanMarcus - Irving |
      | 3 | Item5789    | 1 Pallets Hangers, 1300 lbs                                      | Stop 1-Arizona Diamondbacks | Stop 4-Texas Rangers         |
    Then Collapse "Items" for "1" Load
     #Step 18
    Then Expand "Accessorials" for "1" Load
    #Expected g
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "1" Load
     #Step 19
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds

    #Expected Result h
    Then Verify "2D" Stop with "8701 S Hardy Dr, Tempe, Arizona 85284"
    Then Verify details for
      | Location          | Expected Date | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | References | Pickup/Delivery Number | Instructions |
      | Arizona Cardinals | 8/26/2028     | 06:00-08:00      | NA                         | 06:00-08:00             | NA         | NA                     | NA           |
    Then Verify details For Checkbox
      | Appointment Required |
      | True                 |
    Then Collapse "Details" for "2" Load
   #Step 20
    Then Expand "Items" for "2" Load
    Then Click on "Edit" on "1" item
    Then Wait for "5" Seconds
    #Expected i
    Then Verify details for all Required Enabled fields
      | Item Number | Item Description   | Weight | Delivery Stop                                                    |
      | MG000520788 | CLOTHING LT/12 PCF | 20,000 | Stop 2 - Arizona Cardinals 8701 S Hardy Dr, Tempe, Arizona 85284 |
    Then Verify details for all Enabled fields
      | Weight Units | HU Count | Handling Units | Length | Width | Height | Dimension Units | NMFC Class | HazMat |
      | lbs          | 10       | Pallets        | 48.00  | 48.00 | 48.00  | in              | 70         | True   |
    Then Verify details for all Enabled fields
      | HazMat Number Type | HazMat Number | HazMat Class/Division | HazMat Packaging Group | HazMat Contact       |
      | UN                 | 1234          | 1.1                   | III                    | QA Arizona Cardinals |
    Then Verify details for all Disabled or Readonly fields
      | Pickup Stop                                                              |
      | Stop 1 - Arizona Diamondbacks 401 E Jefferson St, Phoenix, Arizona 85004 |
    Then Click on "Cancel" with Text
    Then Collapse "Items" for "2" Load
    #Step 21
    Then Expand "Accessorials" for "2" Load
    #Expected J
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "2" Load
     #Step 22
    Then Expand "Details" for "3" Load
    Then Wait for "1" Seconds

    #Expected Result K
    Then Verify "3D" Stop with "123 Customer Way, Irving, Texas 75039"
    Then Verify details for
      | Location              | Expected Date | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | References | Pickup/Delivery Number | Instructions |
      | NeimanMarcus - Irving | 8/26/2028     | 06:30-08:30      | NA                         | 06:30-08:30             | NA         | NA                     | NA           |
    Then Verify details For Checkbox
      | Appointment Required |
      | False                |
    Then Collapse "Details" for "3" Load
   #Step 23
    Then Expand "Items" for "3" Load
    Then Click on "Edit" on "1" item
    Then Wait for "5" Seconds
    #Expected l
    Then Verify details for all Required Enabled fields
      | Item Number | Item Description   | Weight | Delivery Stop                                           |
      | MG000520789 | CLOTHING LT/12 PCF | 300    | Stop 3 - NeimanMarcus - Irving 123 Customer Way, Irving |
    Then Verify details for all Enabled fields
      | Weight Units | HU Count | Handling Units | Length | Width | Height | Dimension Units | NMFC Class | HazMat |
      | lbs          | 3        | Pallets        |        |       |        | in              |            | False  |
    Then Verify details for all Disabled or Readonly fields
      | Pickup Stop                                                              |
      | Stop 1 - Arizona Diamondbacks 401 E Jefferson St, Phoenix, Arizona 85004 |
    Then Update details
      | HazMat |
      | True   |
    Then Wait for "2" Seconds
    Then Verify details for all Enabled fields
      | HazMat Contact               |
      | QA Arizona Diamondbacks 2266 |
    Then Click on "Cancel" with Text
    Then Collapse "Items" for "3" Load
    #Step 24
    Then Expand "Accessorials" for "3" Load
    #Expected m
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "3" Load
    #Step 25
    Then Expand "Details" for "4" Load
    Then Wait for "1" Seconds

    #Expected Result n
    Then Verify "4D" Stop with "1000 Ballpark Way Ste 400, Arlington, Texas 76011"
    Then Verify details for
      | Location      | Expected Date | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | References | Pickup/Delivery Number | Instructions |
      | Texas Rangers | 8/27/2028     | 16:30-18:30      | Joe Texas Rangers          | 16:30-18:30             | NA         | NA                     | NA           |
    Then Verify details For Checkbox
      | Appointment Required |
      | False                |
    Then Collapse "Details" for "4" Load
   #Step 26
    Then Expand "Items" for "4" Load
    Then Click on "Edit" on "1" item
    Then Wait for "5" Seconds
    #Expected 0
    Then Verify details for all Required Enabled fields
      | Item Number | Item Description | Weight | Delivery Stop                                                            |
      | Item5789    | Hangers          | 1,300  | Stop 4 - Texas Rangers 1000 Ballpark Way Ste 400, Arlington, Texas 76011 |
    Then Verify details for all Enabled fields
      | Weight Units | HU Count | Handling Units | Length | Width | Height | Dimension Units | NMFC Class | HazMat |
      | lbs          | 1        | Pallets        |        |       |        | in              |            | False  |
    Then Verify details for all Disabled or Readonly fields
      | Pickup Stop                                                              |
      | Stop 1 - Arizona Diamondbacks 401 E Jefferson St, Phoenix, Arizona 85004 |
    Then Update details
      | HazMat |
      | True   |
    Then Wait for "2" Seconds
    Then Verify details for all Enabled fields
      | HazMat Contact      |
      | QA Hazmat Not Found |

    Then Click on "Cancel" with Text
    Then Collapse "Items" for "4" Load
    #Step 27
    Then Expand "Accessorials" for "4" Load
    #Expected p
    Then Verify no "Accessorials" are marked true
    Then Collapse "Accessorials" for "4" Load
    #Step 28 Expected q
    Then Scroll Until Related List for "Load Accessorials"
    Then Verify "Load Accessorials" Table details with following Details
      | Load Accessorial: Name      |
      | Hazardous Material Handling |
    #Step 29
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    #Expected r
    Then Verify details for all Enabled fields
      | Status   | Pricing  | Quote Date |
      | Accepted | Contract | 0          |
    Then Verify Customer "Freight Charges" displaying as "5,000"
    Then Verify Customer "Fuel Surcharge" displaying as "200"
    Then Verify Customer "Accessorial Charges" displaying as "300"
    Then Verify Customer "Quote Total" displaying as "5,500"
    #Step 30 & Expected Result s
    Then Verify "Customer Quote Items" "Net Freight Charges" with details "Fixed Cost,,1,,5,000,,5,000"
    Then Verify "Customer Quote Items" "Fuel Surcharge" with details "Fixed Cost,,1,,200,,200"
    Then Verify "Customer Quote Items" "Lift Gate" with details "Fixed Cost,,1,,100,,100"
    Then Verify "Customer Quote Items" "Lumper" with details "Fixed Cost,,1,,200,,200"
    #Step 31
    Then Search and Select "Arizona Cardinals" Account from the Global search
    #Step 32
    Then Go to "Contacts" Tab
    Then Click on "QA Arizona Cardinals" with Text
    #Expected t
    Then Verify "Transportation Role" having value of "HazMat"
     #Expected u
    Then Verify "Email" having value of "hford@revenova.com"
    #Step 33
    Then Search and Select "Arizona Diamondbacks" Account from the Global search
    #Step 34
    Then Go to "Contacts" Tab
    #Expected v
    Then Verify Text displaying as "QA Arizona Diamondbacks 2266"

    #Step 35
    Then Click on "QA Hazmat Not Found" with Text
    #Expected w
    Then Verify "Name" having value of "QA Hazmat Not Found"
    Then Verify "Transportation Role" having value of "HazMat"
    Then Verify "Phone" having value of "(775) 441-9981"
    Then Verify "Email" having value of "qa@revenova.com"

#    # Following step is applicable from Winter'27
#    #Step 28
#    Then Navigate Browser Back
#    Then Go to "Contacts" Tab
#
#    #Expected x
#    Then Verify Text displaying as "George Smiley"
#    Then Click on "George Smiley" with Text
#    Then Verify "Email" having value of "gsmiley@mi6.org"