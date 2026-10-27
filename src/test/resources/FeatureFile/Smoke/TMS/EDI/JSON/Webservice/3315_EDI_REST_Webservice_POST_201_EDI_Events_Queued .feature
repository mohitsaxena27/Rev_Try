Feature: 3315 - EDI REST Webservice- POST: 201 EDI Events Queued


  Background: Pre- Test
    Then Delete All Records with name "Load-ABC" for "rtms__Load__c"
    Then Delete All Records with name "Load-XYZ" for "rtms__Load__c"



  @Regression @TMS @Smoke @API @WEB @SingleCurrency  @EDI @3315
  Scenario: 3315 - EDI REST Webservice- POST: 201 EDI Events Queued

    When Login into Salesforce
#    Pre-Condition
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
    #Setting up SCAC Value
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "EDI Carrier One" from Search List
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Click on Edit icon on "SCAC"
    Then Enter Label "SCAC" Text as "EDIC1"
    Then Click on "Save" button
    Then Verify "SCAC" having value of "EDIC1"
    Then Capture the current URL for "TP_Page"

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Freeze Load Number |
      | False              |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | Truckload | NA     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Arizona Cardinals    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Texas Rangers | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Beans      | 5678    | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Steps 3
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-ABC  |
    Then Click on "Save" button
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-ABC"
    Then Verify Details
      | Load Number |
      | Load-ABC  |
    Then Refresh current Page
    Then Wait for "1" Seconds
    Then Scroll into Section "Arizona Cardinals"
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Shipping/Receiving Contact"
    Then Update details
      |Shipping/Receiving Contact|
      |Joe Texas Rangers                    |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Collapse "Details" for "1" Load
    Then Wait for "3" Seconds

    # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."


    #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Revenova HQ | Intermodal | NA     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Arizona Cardinals    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Texas Rangers | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Beans      | 5678  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_2"

        #Steps 6
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-XYZ  |
    Then Click on "Save" button
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-XYZ"
    Then Verify Details
      | Load Number |
      | Load-XYZ  |
    Then Refresh current Page
    Then Open "Loads" from App Launcher
    Then Open Load Number "Load-XYZ"
    Then Wait for "2" Seconds
    Then Scroll into Section "Arizona Cardinals"
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Shipping/Receiving Contact"
    Then Update details
      |Shipping/Receiving Contact|
      |Joe Texas Rangers                    |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Collapse "Details" for "1" Load
    Then Wait for "3" Seconds

    # Step 7
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."

    #Step 8, 9, 10 & Expected a
    Then Send Post Request for EDI with Json "edi_all_types.txt" with Access Token as "Access_Token"
    Then Wait for "30" Seconds

    #Step 11
    Then Navigate to stored URL for "Load_1"

    #Step 12
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds
    #Expected Result b
    Then Verify EDI Transactions Table
        |Status |Transaction Type|Direction|Purpose|EDI Provider|Trading Partner|EDI Location|
        |Success|210             |Inbound  |Original|Kleinschmidt|EDI Carrier One|EDIC1      |
        |Success|990             |Inbound  |Original|Kleinschmidt|EDI Carrier One|EDIC1      |
        |Success|214             |Inbound  |Original|Kleinschmidt|EDI Carrier One|EDIC1      |
        |Success|204             |Inbound  |Update  |Kleinschmidt|Revenova HQ|KLIQA      |

    #Step 13
    Then Select "EDI Transactions" with "Transaction Type" as "204" and "Purpose" as "Update"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 204              | Update | Inbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    #Expected Result c
    Then Verify Json "Transaction Payload" with File "Transaction_payload_1.json"
      | No Update Required |
      | |

    Then Navigate Browser Back
    #Step 14
    Then Select "EDI Transactions" with "Transaction Type" as "210" and "Purpose" as "Original"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 210              | Original | Inbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    #Expected Result d
    Then Verify Json "Transaction Payload" with File "Transaction_payload_2.json"
      | No Update Required |
      |  |

    Then Navigate Browser Back
    #Step 15
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Inbound"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 214             | Original | Inbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    #Expected Result e
    Then Verify Json "Transaction Payload" with File "Transaction_payload_3.json"
      | No Update Required |
      |  |

    Then Navigate Browser Back
    #Step 16
    Then Select "EDI Transactions" with "Transaction Type" as "990" and "Purpose" as "Original"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 990             | Original | Inbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    #Expected Result F
    Then Verify Json "Transaction Payload" with File "Transaction_payload_4.json"
      | No Update Required |
      |  |

    #Step 17
    Then Navigate to stored URL for "Load_2"

    #Step 18
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds
    #Expected Result G
    Then Verify EDI Transactions Table
      |Status |Transaction Type|Direction|Purpose|EDI Provider|Trading Partner      |EDI Location|
      |Success|322             |Inbound  |Original|Kleinschmidt|Rail EDI Carrier One|REDIC1      |
      |Success|410             |Inbound  |Original|Kleinschmidt|Rail EDI Carrier One|REDIC1     |
      |Success|824             |Inbound  |Original|Kleinschmidt|Rail EDI Carrier One|REDIC1     |

    #Step 19
    Then Select "EDI Transactions" with "Transaction Type" as "322" and "Purpose" as "Original"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 322              | Original | Inbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    #Expected Result H
    Then Verify Json "Transaction Payload" with File "Transaction_payload_5.json"
      | No Update Required |
      | |

    Then Navigate Browser Back
    #Step 20
    Then Select "EDI Transactions" with "Transaction Type" as "410" and "Purpose" as "Original"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 410              | Original | Inbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    #Expected Result I
    Then Verify Json "Transaction Payload" with File "Transaction_payload_6.json"
      | No Update Required |
      |  |

    Then Navigate Browser Back
    #Step 21
    Then Select "EDI Transactions" with "Transaction Type" as "824" and "Purpose" as "Original"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 824             | Original | Inbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |

    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |
    #Expected Result j
    Then Verify Json "Transaction Payload" with File "Transaction_payload_7.json"
      | No Update Required |
      |  |












