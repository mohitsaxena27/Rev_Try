Feature: 2182 - EDI Outbound 990 Field Mapping: Accept/Decline

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @2182
  Scenario: 2182 - EDI Outbound 990- Field Mapping: Accept/Decline

    When Login into Salesforce

    #Step 1
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

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode    | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | Drayage | NA             | Y             | N                 |

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

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 3
    Then Go to "EDI" Tab
    Then Click on Edit icon on Label "EDI Status"
    Then Update details
      | EDI Status | EDI Provider |
      | Accept     | Cleo         |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Wait for "EDI Status" Field Value Update with "Accept"
    Then Verify Details
      | EDI Status |
      | Accept     |

    #Step 4
    Then Refresh current Page

    #Step 5
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "990" and "Direction" as "Outbound"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 990              | Original | Outbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Cleo         | Pending |            |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |

    #Expected A
    Then Verify Json "Transaction Payload" with File "Transaction_Payload_A.json"
      | ShipmentId  |
      | SysData=>1L |

    #Step 6
    Then Navigate to stored URL for "Load_1"

    #Step 7
    Then Go to "EDI" Tab
    Then Click on Edit icon on Label "EDI Status"
    Then Update details
      | EDI Status |
      | Decline    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Wait for "EDI Status" Field Value Update with "Decline"
    Then Verify Details
      | EDI Status |
      | Decline    |

    #Step 8
    Then Refresh current Page

    #Step 9
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "990" and "Direction" as "Outbound"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 990              | Original | Outbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Cleo         | Pending |            |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |

    #EXpected b
    Then Verify Json "Transaction Payload" with File "Transaction_Payload_B.json"
      | ShipmentId  |
      | SysData=>1L |

    #Step 10
    Then Navigate to stored URL for "Load_1"

    #Step 11
    Then Go to "EDI" Tab
    Then Click on Edit icon on Label "EDI Status"
    Then Update details
      | EDI Status |
      | --None--   |

    #Step 12
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | EDI Status |
      |            |

    Then Click on Edit icon on Label "EDI Status"
    Then Update details
      | EDI Status | EDI Decline Reason  |
      | Decline    | Overweight Shipment |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Wait for "EDI Status" Field Value Update with "Decline"
    Then Verify Details
      | EDI Status |
      | Decline    |
    Then Wait for "20" Seconds
    #Step 13
    Then Refresh current Page
    Then Wait for "5" Seconds
    #Step 14
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions"
    Then Manage "EDI ID" in "descending" Order
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "990" and "Direction" as "Outbound"
    Then Verify Details
      | Transaction Type | Purpose  | Direction | Event Code |
      | 990              | Original | Outbound  |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Cleo         | Pending |            |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |

    #EXpected c
    Then Verify Json "Transaction Payload" with File "Transaction_Payload_C.json"
      | ShipmentId  |
      | SysData=>1L |