Feature: 2230 - EDI Outbound 214- Field Mapping: Trigger Logic


  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @2230
  Scenario: 2230 - EDI Outbound 214- Field Mapping: Trigger Logic

    When Login into Salesforce
    #-----------------------------------------------------
       #Step 1
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
    |EDI Enabled|Enable EDI Transaction Logging|
    |True       |True                          |
    And Update the Custom Select option "EDI Administrator" as "User User"
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    Then Update details -
    |Inbound 204|Inbound 990|Inbound 214|Inbound 210|Inbound 824|Inbound 322|Inbound 410|Outbound 990|Outbound 204|Outbound 210|Outbound 214|Outbound 404|Outbound 998|
    |True       |True       |True       |True       |True       |True       |True       |True        |True        |True        |True        |True        |True        |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

     #Step 4
    Then Open "Loads" from App Launcher
#    Then Open Load Number "L-69"
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

    # Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_1"

     #Step 6
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

     #Step 7
    Then Click on "1P" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Arrival Date | Arrival Time| Departure Date | Departure Time |
      |0             |1200         | 0              | 1530           |
    Then Click on "1P" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 8
     Then Wait for "120" Seconds
     Then Refresh current Page
     Then Wait for "2" Seconds
    #Step 9
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Manage "EDI ID" in "ascending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "214" and "Direction" as "Outbound"
    Then Verify details for
      |Transaction Type|Direction|
      |214             |Outbound |
    Then Scroll into Section "EDI Payload"
    #Step 10
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected a
    Then Verify "Transaction Payload" with File "Transaction_a_payload.txt"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|{CurrentDateMM/dd/yyyy}|
      |SysData=>1L |0            |3              |1              |0                      |

    #Step 11
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
    #Step 12
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected b
    Then Verify "Transaction Payload" with File "Transaction_b_payload.txt"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|{CurrentDateMM/dd/yyyy}|
      |SysData=>1L |0            |3              |1              |0                      |

    #Step 13
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

    #Step 14
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
    #Step 15
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected c
    Then Verify "Transaction Payload" with File "Transaction_c_payload.txt"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|{CurrentDateMM/dd/yyyy}|
      |SysData=>1L |0            |3              |1              |0                      |

#    Step 16
    Then Navigate to stored URL for "Load_1"
    Then Wait for "1" Seconds
    Then Expand "Details" for "2" Load
    Then Wait for "2" Seconds
    Then Click on Edit icon with Field Name "2D" "Expected Date"
    Then Update details
      |Expected Date|
      |1            |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Collapse "Details" for "2" Load
    Then Wait for "8" Seconds

    #Step 17
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

    #Step 18
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected d
    Then Verify "Transaction Payload" with File "Transaction_d_payload.txt"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|{CurrentDateMM/dd/yyyy}|{CurrentDateMM/dd/yyyy+1}|
      |SysData=>1L |0            |3              |1              |0                      |1                        |

        #Step 19
    Then Navigate to stored URL for "Load_1"
    Then Wait for "1" Seconds
    #Step 20
    Then Click on "Los Angeles Lighting" with Text
    Then Wait for "2" Seconds
    #Step 21
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

    #Step 22
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

        #Step 23
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

    #Step 24
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected e
    Then Verify "Transaction Payload" with File "Transaction_e_payload.txt"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|{CurrentDateMM/dd/yyyy}|{CurrentDateMM/dd/yyyy+1}|
      |SysData=>1L |0            |3              |1              |0                      |1                        |

     #Step 25
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

    #Step 26
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected f
    Then Verify "Transaction Payload" with File "Transaction_f_payload.txt"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|{CurrentDateMM/dd/yyyy}|{CurrentDateMM/dd/yyyy+1}|
      |SysData=>1L |0            |3              |1              |0                      |1                        |

      #Step 27
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

     #Step 28 & 29
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

        #Step 30
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
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

    #Step 31
    Then Get Details
      |Transaction Payload|
      |Transaction Payload|
    #EXpected g
    Then Verify "Transaction Payload" with File "Transaction_g_payload.txt"
      |{shipmentId}|{CurrentDate}|{CurrentDate+3}|{CurrentDate+1}|{CurrentDateMM/dd/yyyy}|{CurrentDateMM/dd/yyyy+1}|
      |SysData=>1L |0            |3              |1              |0                      |1                        |
