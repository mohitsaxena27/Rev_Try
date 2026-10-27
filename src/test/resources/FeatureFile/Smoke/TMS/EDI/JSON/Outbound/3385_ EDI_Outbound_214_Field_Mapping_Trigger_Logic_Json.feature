Feature: 3385 - EDI Outbound 214- Field Mapping: Trigger Logic (JSON)

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @3385
  Scenario: 3385 - EDI Outbound 214- Field Mapping: Trigger Logic (JSON)

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
    #-----------------------------------------------------

     #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | Truckload | Dry Van 53     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | True                   |

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
      | 2         | Stop 3 | Stop 4   | Grapes      | 12000   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_1"

     #Step 3
    Then Go to "EDI" Tab
    Then Click on Edit icon on Label "EDI Status"
    Then Update details
      |EDI Status|EDI Provider|
      |Accept    |Kleinschmidt|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Wait for "EDI Status" Field Value Update with "Accept"
    Then Verify Details
      |EDI Status      |
      |Accept  |
    Then Refresh current Page

     #Step 4
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Arrival Date | Arrival Time| Departure Date | Departure Time |
      |0             |1200         | 0              | 1530           |
    Then Click on "1P" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 5
     Then Wait for "120" Seconds
     Then Refresh current Page

    #Step 6
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Manage "EDI ID" in "ascending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"
    #Step 7
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected a
    Then Verify Json "Transaction Payload" with File "Transaction_payload_1.json"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|
      |SysData=>1L |0            |3              |1              |

    #Step 8
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"
    #Step 9
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected b
    Then Verify Json "Transaction Payload" with File "Transaction_payload_2.json"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|
      |SysData=>1L |0            |3              |1              |

    #Step 10
    Then Navigate to stored URL for "Load_1"
    Then Wait for "1" Seconds
    Then Expand "Details" for "2" Load
    Then Click on Edit icon with Field Name "2D" "Appointment Time"
    Then Update details
      |Appointment Time|
      |1850            |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Collapse "Details" for "1" Load
    Then Wait for "8" Seconds

    #Step 11
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Refresh "EDI Transactions"
    Then Wait for "4" Seconds
    Then Verify "EDI Transactions" "Transaction Type" "214" count as "3"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"
    #Step 12
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected c
    Then Verify Json "Transaction Payload" with File "Transaction_payload_3.json"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|
      |SysData=>1L |0            |3              |1              |

#    Step 13
    Then Navigate to stored URL for "Load_1"
    Then Wait for "1" Seconds
    Then Expand "Details" for "2" Load
    Then Wait for "2" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Wait for "1" Seconds
    Then Update details
      |Expected Date|
      |1            |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Collapse "Details" for "1" Load
    Then Wait for "8" Seconds

    #Step 14
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Refresh "EDI Transactions"
    Then Wait for "4" Seconds
    Then Verify "EDI Transactions" "Transaction Type" "214" count as "4"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"

    #Step 15
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected d
    Then Verify Json "Transaction Payload" with File "Transaction_payload_4.json"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|
      |SysData=>1L |0            |3              |1              |

        #Step 16
    Then Navigate to stored URL for "Load_1"
    Then Wait for "1" Seconds
    Then Click on "Los Angeles Lighting" with Text
    Then Wait for "2" Seconds
    #Step 17
    Then Scroll into Section "Arrival/Departure Information"
    Then Click on Edit icon on Label "Loading/Unloading Complete Date"
    Then Update details
      |Loading/Unloading Complete Date|
      |1            |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "5" Seconds
    Then Verify details for
      |Loading/Unloading Complete Date|
      |1                              |

    #Step 18
    Then Scroll into Section "Arrival/Departure Information"
    Then Click on Edit icon on Label "Loading/Unloading Complete Time"
    Then Update details
      | Loading/Unloading Complete Time|
      |1650                            |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "5" Seconds
    Then Verify details for
      |Loading/Unloading Complete Time|
      |16:50                           |
    Then Wait for "8" Seconds

        #Step 19
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Refresh "EDI Transactions"
    Then Wait for "2" Seconds
    Then Refresh "EDI Transactions"
    Then Wait for "2" Seconds
    Then Verify "EDI Transactions" "Transaction Type" "214" count as "6"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "2" "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"

    #Step 20
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected e
    Then Verify Json "Transaction Payload" with File "Transaction_payload_5.json"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|
      |SysData=>1L |0            |3              |1              |

     #Step 21
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Refresh "EDI Transactions"
    Then Wait for "4" Seconds
    Then Verify "EDI Transactions" "Transaction Type" "214" count as "6"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"

    #Step 22
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected f
    Then Verify Json "Transaction Payload" with File "Transaction_payload_6.json"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|
      |SysData=>1L |0            |3              |1              |

      #Step 23
    Then Navigate to stored URL for "Load_1"
    Then Wait for "1" Seconds

    Then Click on "3P" "Arrived" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Arrival Date | Arrival Time|
      |1             |1030         |
    Then Click on "3P" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "2" Seconds

     #Step 22 & 25
    Then Click on "3P" "Los Angeles Lighting" button
    Then Wait for "2" Seconds
    Then Scroll into Section "Arrival/Departure Information"
    Then Click on Edit icon on Label "Loading/Unloading Complete Date"
    Then Update details
      |Loading/Unloading Complete Date| Loading/Unloading Complete Time|
      |1            |1115                                              |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "5" Seconds
    Then Verify details for
      |Loading/Unloading Complete Date|
      |1                              |

        #Step 26
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Wait for "4" Seconds
    Then Scroll into Section "EDI Transactions"
    Then Refresh "EDI Transactions"
    Then Wait for "4" Seconds
    Then Verify "EDI Transactions" "Transaction Type" "214" count as "8"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"

    #Step 27
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected g
    Then Verify Json "Transaction Payload" with File "Transaction_payload_7.json"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|
      |SysData=>1L |0            |3              |1              |
