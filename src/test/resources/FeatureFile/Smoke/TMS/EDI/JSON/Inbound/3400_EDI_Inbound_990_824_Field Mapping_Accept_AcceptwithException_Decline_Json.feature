Feature: 3400 - EDI Outbound 990 Field Mapping: Accept/Decline

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @3400
  Scenario: 3400 - EDI Outbound 990- Field Mapping: Accept/Decline

    When Login into Salesforce

    #Pre-conditions
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI |
      | True        | True                 |
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


    #-----------------------------------------------------
    #Step 1`
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Freeze Load Number |
      | False              |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load-3400A"

    #Step3
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3400A  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3400A"
    Then Verify Details
      | Load Number |
      | Load-3400A  |

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."
    Then Click on Carrier Quote from FQA Page
    Then Capture the current URL for "Carrier_Quote_A"

    #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode       | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | Intermodal | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load-3400B"

    #Step 6
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3400B  |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3400B"
    Then Verify Details
      | Load Number |
      | Load-3400B  |

    #Step 7
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."
    Then Click on Carrier Quote from FQA Page
    Then Capture the current URL for "Carrier_Quote_B"

    #Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode       | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Boston Beans | Intermodal | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load-3400C"

    #Step 9
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number | Waybill Number | Booking Number |
      | Load-3400C  | 12345          | 54321          |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3400C"
    Then Verify Details
      | Load Number |
      | Load-3400C  |

    #Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."
    Then Click on Carrier Quote from FQA Page
    Then Capture the current URL for "Carrier_Quote_C"

    #Step 11 & 12
    Then Send Post Request for EDI with Json "Tender_Response_3400A.txt" with Access Token as "Access_Token"
    Then Wait for "120" Seconds
    
    #Step 13
    Then Navigate to stored URL for "Load-3400A"
    Then Refresh current Page
    #Expected a
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

    #Step 14
    Then Go to "EDI" Tab

    #Expected b
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "990"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "824"

    #Step 15
    Then Navigate to stored URL for "Carrier_Quote_A"

    #Step 16
    Then Go to "Details" Tab
    Then Scroll into Section "Auto-Engagement"

    #Expected c
    Then Verify Details
      | Tender Status |
      | Assigned      |

    #Step 17
    Then Navigate to stored URL for "Load-3400B"
    Then Refresh current Page
    #Expected d
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

    #Step 18
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"

    #Expected e
    Then Verify Details
      | Waybill Number |
      | 3400B          |

    #Step 19
    Then Go to "EDI" Tab

    #Expected f
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "824"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "990"

    #Step 20
    Then Navigate to stored URL for "Carrier_Quote_B"

    #Step 21
    Then Go to "Details" Tab
    Then Scroll into Section "Auto-Engagement"

    #Expected g
    Then Verify Details
      | Tender Status |
      | Assigned      |

    #Step 22
    Then Scroll into Section "General Information"

    #Expected h
    Then Verify Details
      | Tender Exception Comments   |
      | Exception Comment $^&! 490< |

    #Step 23
    Then Navigate to stored URL for "Load-3400C"
    Then Refresh current Page

    #Expected i
    Then Verify Banner Details
      | Load Status |
      | Declined    |

    #Step 24
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"

    #Expected j & k
    Then Verify Details
      | Waybill Number | Booking Number |
      | 3400C          | C3400          |

    #Step 25
    Then Go to "EDI" Tab

    #Expected l
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "824"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "990"

    #Step 26
    Then Navigate to stored URL for "Carrier_Quote_C"

    #Step 27
    Then Go to "Details" Tab
    Then Scroll into Section "Auto-Engagement"

    #Expected m, m.a and m.b
    Then Verify Details
      | Tender Status | Tender Declined Reasons                                                      | Tender Declined Comments   |
      | Rejected      | Missing or Invalid Consignee;OtherUnspecified application error;Out of Range | Declined Comment $^&*! 490 |

    #Step 28.a
    Then Navigate to stored URL for "Load-3400C"
    Then Go to "Freight Quote Assistant" Tab
    Then Verify Quotes returned

    #Step 28.b
    And Verify Carrier Service displaying as "Rail EDI Carrier One - Intermodal"
    Then Click on Native "Tender" icon
    Then Verify Success Message displaying as "Load tendered successfully."

    #Step 29
    Then Open "EDI Transactions" from App Launcher
    Then Wait for "1" Seconds

    #Step 30
    Then Click on button with Title "New"
    Then Get "Tender_Response_3400C.txt" files and update below Attributes
      | No Update Required |
      |                    |
    Then Wait for "3" Seconds
    Then Update details
      | EDI Location | Trading Partner | Transaction Type | Purpose  | Direction | EDI Provider |
      | KLIQA        | Revenova HQ     | 990              | Original | Inbound   | Kleinschmidt |
    Then Click on "Transaction Payload" TextArea
    Then Enter Label "Transaction Payload" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Status  |
      | Failure |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."

    #Step 31
    Then Scroll into Section "EDI Provider Status"
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Wait for "60" Seconds

    #Step 32
    Then Navigate to stored URL for "Load-3400C"

    Then Go to "Summary" Tab
    #Expected n
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

    #Step 33
    Then Go to "EDI" Tab

    #Expected o
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "824"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "990"

    #Step 34
    Then Navigate to stored URL for "Carrier_Quote_C"

    #Step 35
    Then Go to "Details" Tab
    Then Scroll into Section "Auto-Engagement"

    #Expected p
    Then Verify Details
      | Tender Status | Tender Declined Reasons | Tender Declined Comments |
      | Assigned      |                         |                          |