Feature: 3386 - EDI Outbound 204- Field Mapping: Original+Update+Cancel (JSON)

  @WEB @Regression @TMS @Smoke @API  @SingleCurrency @EDI @3386
  Scenario: 3386 - EDI Outbound 204- Field Mapping: Original+Update+Cancel (JSON)

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
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
       #Setting SCAC as EDC1
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "EDI Carrier One" from Search List
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Click on Edit icon on "SCAC"
    Then Enter Label "SCAC" Text as "EDC1"
    Then Click on "Save" button
    Then Verify "SCAC" having value of "EDC1"
    #-----------------------------------------------------

    #Step 1
    Then Set key "ChicagoPizza_AccountID" for Object "Account" and Name "Chicago Pizza"
    #Step 2
    Then Set key "LosAngelesLighting_AccountID" for Object "Account" and Name "Los Angeles Lighting"
    #Step 3
    Then Set key "RevenovaHQ_AccountID" for Object "Account" and Name "Revenova HQ"
    #Step 4
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "EDI Carrier One" from Search List
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Click on Edit icon on "SCAC"
    Then Enter Label "SCAC" Text as "SCAC1"
    Then Click on "Save" button
    Then Verify "SCAC" having value of "SCAC1"

    #Step5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | Truckload | Dry Van 53     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | 0             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3P   | Account_Address | Los Angeles Lighting | 1             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 4D   | Same_as_Customer | NA    | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 3 | Stop 4   | Grapes      | 1200   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Update details
      | HazMat_2 |
      | true     |

    Then Update details
      | HazMat Number Type | HazMat Number | HazMat Class/Division | HazMat Packaging Group | HazMat Contact           |
      | UN                 | 12            | 2.1                   | II                     | Joe Los Angeles Lighting |

    #Steps 6
    Then Save Load With All details
    Then Capture the current URL for "Load"
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Get Details
      | Distance (Miles) |
      |                  |
    Then Remove "," and Set "Distance (Miles)" on to "DistanceInMiles"
    Then Wait for "2" Seconds

    #Step7
    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on Label "RFP"
    Then Wait for "2" Seconds
    Then Update details
      | Customer Bill To |
      | Revenova HQ      |
    Then Scroll into Section "Import/Export Information"
    Then Wait for "2" Seconds
    Then Update details
      | Notify Party     |
      | Joe Boston Beans |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      | Customer Bill To |
      | Revenova HQ      |
    Then Scroll into Section "Import/Export Information"
    Then Verify Details
      | Notify Party     |
      | Joe Boston Beans |

    #Step 8 a, b, c
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then Enter Label "Contract Id" Text as "777666555"
    And Wait for "1" Seconds
    Then Enter Label "Carrier Quote Reference" Text as "22311322"
    And Wait for "1" Seconds

    #Step8 d,e,f,g
    Then Add "Load" "Carrier Quote Items" "Net Freight Charges" with Unit as "Per Mile" Qty as "1850.12" and Price "1.25" with all details
    Then Add "Load" "Carrier Quote Items" "Fuel Surcharge" with Unit as "Fixed Cost" Qty as "1" and Price "200" with all details
    Then Add "Stop 2" "Carrier Quote Items" "Expedited" Accessorial with Unit as "Fixed Cost" Qty as "50" and Price "2"

    #Step 9
    Then Click on Native "Tender" icon
    Then Store current Time plus "2" hrs in format of "HH:mm" on to "CurrentTime"
    Then Wait for "2" Seconds
    Then Verify Success Message displaying as "Load tendered successfully."

    #Step 10
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds

     #Step 11 #Expected a
    Then Select "EDI Transactions" with "Transaction Type" as "204" and "Direction" as "Outbound"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 204              | Original | Outbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Pending |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    Then Verify Json "Transaction Payload" with File "Transaction_payload_1.json"
      | ShipmentId  | {CurrentDateYYYY-MM-DD} | {CurrentDateYYYY-MM-DD+1} | {CurrentDateYYYY-MM-DD+3} | {ScratchOrgEmail} | DistanceInMiles          | RevenovaHQAccountID           | ChicagoPizzaAccountID           | LosAngelesLightingAccountID           | RespondTime          |
      | SysData=>1L | 0                       | 1                         | 3                         | Company_Email     | SysData=>DistanceInMiles | SysData=>RevenovaHQ_AccountID | SysData=>ChicagoPizza_AccountID | SysData=>LosAngelesLighting_AccountID | SysData=>CurrentTime |

    #Step 12
    Then Navigate to stored URL for "Load"

    #Step 13
    Then Go to "Details" Tab
    Then Scroll into Section "Import/Export Information"
    Then Click on Edit icon on Label "Ultimate Consignee"
    Then Update details
      | Customs Broker      | Ultimate Consignee |
      | Customs Broker Four | Montreal Motors    |
    Then Click on "Save" button
    Then Wait for "3" Seconds


    #Step 14
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Click on Native "Tender" icon
    Then Store current Time in format of "MM/dd/yyyy, h:mm" on to "CurrentTimeTendered"
    Then Store current Time plus "2" hrs in format of "HH:mm" on to "CurrentTime"
    Then Wait for "2" Seconds
    Then Verify Success Message displaying as "Load tendered successfully."
    Then Set Carrier Quote value on to "Carrier_Quote"

    #Step 15
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds

    #Step 16 & Expected b
    Then Scroll into Section "EDI Transactions"
    Then Verify "EDI Transactions" "Transaction Type" "204" count as "2"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "2" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "204" and "Direction" as "Outbound"
    Then Verify Details
      | Transaction Type | Purpose | Direction | Event Code |
      | 204              | Update  | Outbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Pending |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |

    Then Verify Json "Transaction Payload" with File "Transaction_payload_2.json"
      | ShipmentId  | {CurrentDateYYYY-MM-DD} | {CurrentDateYYYY-MM-DD+1} | {CurrentDateYYYY-MM-DD+3} | {ScratchOrgEmail} | DistanceInMiles          | RevenovaHQAccountID           | ChicagoPizzaAccountID           | LosAngelesLightingAccountID           | RespondTime          |
      | SysData=>1L | 0                       | 1                         | 3                         | Company_Email     | SysData=>DistanceInMiles | SysData=>RevenovaHQ_AccountID | SysData=>ChicagoPizza_AccountID | SysData=>LosAngelesLighting_AccountID | SysData=>CurrentTime |

    #Step 17
    Then Scroll into Section "System Information"
    Then Store EDI "CreatedBy"

    #Step 18
    Then Navigate to stored URL for "Load"

    #Step 19
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds
    Then Open "Carrier Quotes" using value from "Carrier_Quote" on QuoteInvoice Tab
    #Step 20
    Then Go to "Details" Tab
    Then Scroll into Section "Auto-Engagement"
    #Expected Result c
    Then Verify Details
      | Tender Sent Date   |
      | SysData=>CreatedBy |

    #Step 21
    Then Navigate to stored URL for "Load"

    #Step 22
    Then Click on Native "Remove Carrier" icon
    Then Wait for "5" Seconds
    Then Verify details for all Enabled fields -
      | Removal Reason | Removal Comments |
      | --None--       |                  |
    Then Click on button "Remove Carrier" -
    Then Verify Success Message displaying as "Carrier removed from load."
    Then Store current Time plus "2" hrs in format of "HH:mm" on to "CurrentTime"

    #Step 23
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds

    #Step 24 Expected d
    Then Scroll into Section "EDI Transactions"
    Then Verify "EDI Transactions" "Transaction Type" "204" count as "3"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "2" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "204" and "Direction" as "Outbound"
    Then Verify Details
      | Transaction Type | Purpose      | Direction | Event Code |
      | 204              | Cancellation | Outbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Pending |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |

    Then Verify Json "Transaction Payload" with File "Transaction_payload_3.json"
      | ShipmentId  | {CurrentDateYYYY-MM-DD} | {CurrentDateYYYY-MM-DD+1} | {CurrentDateYYYY-MM-DD+3} | {ScratchOrgEmail} | DistanceInMiles          | RevenovaHQAccountID           | ChicagoPizzaAccountID           | LosAngelesLightingAccountID           | RespondTime          |
      | SysData=>1L | 0                       | 1                         | 3                         | Company_Email     | SysData=>DistanceInMiles | SysData=>RevenovaHQ_AccountID | SysData=>ChicagoPizza_AccountID | SysData=>LosAngelesLighting_AccountID | SysData=>CurrentTime |