Feature: 2336 - Freight Plan- Stop and Line Item Generation on Carrier Load

  @API @Regression @TMS @Smoke @WEB @FMS @SingleCurrency @FMS @Trimble_API @2336
  Scenario: 2336 - Freight Plan- Stop and Line Item Generation on Carrier Load

    Then Login into Salesforce
  # Step1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value       | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Revenova HQ | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 500    | NA           | NA       | NA             |

  # Step 2
    Then Save Load With All details

  # Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Chicago Pizza | Truckload | NA             | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Boston Beans | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Bulls | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Kiwi        | 600    | NA           | NA       | NA             |

  # Step 4
    Then Save Load With All details

  # Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Chicago Pizza | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 1P   | Account_Address | Boston Beans | 0             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2P   | Account_Address | Chicago Pizza | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value       | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3D   | Account_Address | Revenova HQ | 5             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 4D   | Account_Address | Boston Beans | 5             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D3       | Apples      | 700    | NA           | NA       | NA             |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P2     | D4       | Grapes      | 800    | NA           | NA       | NA             |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 3         | P1     | D4       | Cucumbers   | 950    | NA           | NA       | NA             |
  # Step 6
    Then Save Load With All details

  # Step 7
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 4L       | Chicago Pizza | Truckload | NA             | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value       | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Revenova HQ | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 2D   | Account_Address | Chicago Pizza | 2             | NA                       | NA               | NA                   |
    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 3D   | Account_Address | Boston Beans | 4             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Tomatoes    | 1,000  | NA           | NA       | NA             |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 2         | P1     | D3       | Squash      | 2,000  | NA           | NA       | NA             |

  # Step 8
    Then Save Load With All details

  # Step 9
    Then Go to "Shipment" Tab
    Then Click on button with Title "Add Freight Plan"

  # Step 10
    Then Wait for "10" Seconds
    Then Freight Plan - "Add Load Number" "SysData=>1L"
    Then Wait for "2" Seconds
    Then Freight Plan - "Add Load Number" "SysData=>2L"
    Then Wait for "2" Seconds
    Then Freight Plan - "Add Load Number" "SysData=>3L"
    Then Wait for "2" Seconds

  # Step 11
    Then Click on button with Title "Consolidate All"
    Then Verify Text displaying as "New Carrier Load Information"

  #Step 12
    Then Update details
      | Mode      |
      | Truckload |

    Then Click on button with Title "Save"
    Then Wait for "2" Seconds

  # Step 13
    Then Freight Plan - Select the "1" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "2" Seconds

    Then Refresh current Page
    Then Set Key "5L" page Record Id with "rtms__Load__c"
    Then Go to "Shipment" Tab

  # Step 14 & Expected a
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Verify Stop "1P" Details
      | Location     | Expected Date |
      | Boston Beans | 0             |

  #Step 15 & Expected b.a, b.b, b.c,b.d
    Then Expand "Items" for "1" Load
    Then The Item Detail table should have the following items:
      | # | Item Number | Cargo Summary      | Load        | Pickup Stop         | Delivery Stop        |
      | 1 | Item 1      | Bananas, 500 lbs   | SysData=>1L | Stop 1-Boston Beans | Stop 3-Revenova HQ   |
      | 2 | Item 1      | Apples, 700 lbs    | SysData=>3L | Stop 1-Boston Beans | Stop 3-Revenova HQ   |
      | 3 | Item 1      | Kiwi, 600 lbs      | SysData=>2L | Stop 1-Boston Beans | Stop 5-Chicago Bulls |
      | 4 | Item 3      | Cucumbers, 950 lbs | SysData=>3L | Stop 1-Boston Beans | Stop 6-Boston Beans  |
    Then Collapse "Items" for "1" Load

  # Step 16 & Expected c
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Verify Stop "2P" Details
      | Location      | Expected Date |
      | Chicago Pizza | 1             |

  #Step 17 & Expected d.a
    Then Expand "Items" for "2" Load
    Then The Item Detail table should have the following items:
      | # | Item Number | Cargo Summary   | Load        | Pickup Stop          | Delivery Stop       |
      | 1 | Item 1      | Grapes, 800 lbs | SysData=>3L | Stop 2-Chicago Pizza | Stop 6-Boston Beans |

    Then Collapse "Items" for "2" Load

  # Step 18 & Expected e
    Then Expand "Details" for "4" Load
    Then Wait for "1" Seconds
    Then Verify Stop "4P" Details
      | Location    | Expected Date |
      | Revenova HQ | 0             |

  #Step 19 & Expected f.a, f.b, d.c, d.d
    Then Expand "Items" for "4" Load
    Then The Item Detail table should have the following items:
      | # | Item Number | Cargo Summary      | Load        | Pickup Stop        | Delivery Stop        |
      | 1 | Item 2      | Squash, 2000 lbs   | SysData=>4L | Stop 4-Revenova HQ | Stop 6-Boston Beans  |
      | 2 | Item 1      | Tomatoes, 1000 lbs | SysData=>4L | Stop 4-Revenova HQ | Stop 7-Chicago Pizza |

    Then Collapse "Items" for "4" Load

  # Step 20 & Expected g
    Then Expand "Details" for "3" Load
    Then Wait for "1" Seconds
    Then Verify Stop "3D" Details
      | Location    | Expected Date |
      | Revenova HQ | 2             |

  # Step 21 & Expected h.a, h.b
    Then Expand "Items" for "3" Load
    Then The Item Detail table should have the following items:
      | # | Item Number | Cargo Summary    | Load        | Pickup Stop         | Delivery Stop      |
      | 1 | Item 1      | Bananas, 500 lbs | SysData=>1L | Stop 1-Boston Beans | Stop 3-Revenova HQ |
      | 2 | Item 1      | Apples, 700 lbs  | SysData=>3L | Stop 1-Boston Beans | Stop 3-Revenova HQ |

    Then Collapse "Items" for "3" Load

  # Step 22 & Expected i
    Then Expand "Details" for "5" Load
    Then Wait for "1" Seconds
    Then Verify Stop "5D" Details
      | Location      | Expected Date |
      | Chicago Bulls | 2             |

  # Step 23 & Expected j.a
    Then Expand "Items" for "5" Load
    Then The Item Detail table should have the following items:
      | # | Item Number | Cargo Summary | Load        | Pickup Stop         | Delivery Stop        |
      | 1 | Item 1      | Kiwi, 600 lbs | SysData=>2L | Stop 1-Boston Beans | Stop 5-Chicago Bulls |

    Then Collapse "Items" for "5" Load

  # Step 24 & Expected k
    Then Expand "Details" for "6" Load
    Then Wait for "1" Seconds
    Then Verify Stop "6D" Details
      | Location     | Expected Date |
      | Boston Beans | 5             |

  # Step 25 & Expected l.a, l.b
    Then Expand "Items" for "6" Load
    Then The Item Detail table should have the following items:
      | # | Item Number | Cargo Summary      | Load        | Pickup Stop          | Delivery Stop       |
      | 1 | Item 3      | Cucumbers, 950 lbs | SysData=>3L | Stop 1-Boston Beans  | Stop 6-Boston Beans |
      | 2 | Item 2      | Grapes, 800 lbs    | SysData=>3L | Stop 2-Chicago Pizza | Stop 6-Boston Beans |
      | 3 | Item 2      | Squash, 2000 lbs   | SysData=>4L | Stop 4-Revenova HQ   | Stop 6-Boston Beans |

    Then Collapse "Items" for "6" Load

  # Step 24 & Expected m
    Then Expand "Details" for "7" Load
    Then Wait for "1" Seconds
    Then Verify Stop "7D" Details
      | Location      | Expected Date |
      | Chicago Pizza | 2             |

    # Step 25 & Expected n.a
    Then Expand "Items" for "7" Load
    Then The Item Detail table should have the following items:
      | # | Item Number | Cargo Summary      | Load        | Pickup Stop        | Delivery Stop        |
      | 1 | Item 1      | Tomatoes, 1000 lbs | SysData=>4L | Stop 4-Revenova HQ | Stop 7-Chicago Pizza |

    Then Collapse "Items" for "7" Load