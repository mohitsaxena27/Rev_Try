Feature: 2453 - Carrier Match LWC- Filter/Sorting without Lane Preferences


  @Regression  @WEB @SingleCurrency @Carrier @Headed @2453
  Scenario: 2453 - Carrier Match LWC- Filter/Sorting without Lane Preferences

    When Login into Salesforce

   #Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Stored Rate Carrier One" from List
    Then Go to "Compliance" Tab
    Then Click on Edit icon on Label "Carrier Review Status"
    Then Wait for "2" Seconds
    Then Update details
      | Carrier Review Status |
      | Pending               |
    Then Click on "SaveEdit" button
    Then Verify Details
      | Carrier Review Status |
      | Pending               |
    Then Capture the current URL for "Stored_Rate_TP"

    #Step 2
    Then Open "Truck Postings" from App Launcher
    Then Wait for "2" Seconds
    Then Capture the current URL for "Truck_Posting"

    #Step 3 & 4
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Carrier Service               |
      | Email Carrier One - Truckload |
    Then Wait for "1" Seconds
    Then Click on Search lookup with Title "Carrier Service Lookup (New Window)" -
    Then Click on Link Text "Email Carrier One - Truckload" on new Window with "resultsFrame" Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Equipment Type |
      | Dry Van 53'    |
    Then Wait for "1" Seconds
    Then Click on Search lookup with Title "Equipment Type Lookup (New Window)" -
    Then Click on Link Text "Dry Van 53'" on new Window with "resultsFrame" Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Origin City | Origin State | Pickup Range (Miles) | Destination City | Destination State | Delivery Range (Miles) | Initial Quantity | Date Available |
      | South Bend  | IN           | 100                  | Joliet           | IL                | 100                    | 2                | 0              |

    Then Click on Button with Value "Save" -
    Then Wait for "6" Seconds
    Then Switch to Parent Frame
    Then Get Details
      | Posting |
      |         |
    Then Set "Posting_1" with "SysData=>Posting"
    Then Capture the current URL for "Posting1_URL"
    Then Set Key "Posting1_SFID" page Record Id with "rtms__TruckPosting__c"

    #Step 5
    Then Navigate to stored URL for "Truck_Posting"
    Then Wait for "2" Seconds

    #Step 6 & 7
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Carrier Service               |
      | Email Carrier Two - Truckload |
    Then Wait for "1" Seconds
    Then Click on Search lookup with Title "Carrier Service Lookup (New Window)" -
    Then Click on Link Text "Email Carrier Two - Truckload" on new Window with "resultsFrame" Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Equipment Type |
      | Dry Van 53'    |
    Then Wait for "1" Seconds
    Then Click on Search lookup with Title "Equipment Type Lookup (New Window)" -
    Then Click on Link Text "Dry Van 53'" on new Window with "resultsFrame" Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Origin City | Origin State | Pickup Range (Miles) | Destination City | Destination State | Delivery Range (Miles) | Initial Quantity | Date Available |
      | Marengo     | IL           | 38                   | Joliet           | IL                | 38                     | 2                | 0              |
    Then Click on Button with Value "Save" -
    Then Wait for "6" Seconds
    Then Switch to Parent Frame
    Then Get Details
      | Posting |
      |         |
    Then Set "Posting_2" with "SysData=>Posting"
    Then Capture the current URL for "Posting2_URL"
    Then Set Key "Posting2_SFID" page Record Id with "rtms__TruckPosting__c"

    #Step 8 & 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Kankakee Kayaks | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value       | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Revenova HQ | 0             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "150"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_1"

    #Step 11
    Then Go to "Summary" Tab
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status |
      | Delivered   |
    Then Click on "Save" button on Details Page
    Then Verify "Load Status" having value of "Delivered"

    #Step 12
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Revenova HQ | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value           | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Kankakee Kayaks | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_2L"

    #Step 13
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Chicago Pizza | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Joliet Jazz Supplies | 0             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_3L"

    #Step 14
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "150"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote_2"

    #Step 15
    Then Go to "Summary" Tab
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status |
      | Delivered   |
    Then Click on "Save" button on Details Page
    Then Verify "Load Status" having value of "Delivered"

    #Step 16 & 17
    Then Navigate to stored URL for "Load_2L"
    Then Go to "Find Carriers" Tab
    Then Wait for "3" Seconds

    #Step 18 & Expected a
    Then Scroll into Section "In Network"
    Then Verify Table details with Reference of "Carrier" as "Email Carrier One - Truckload"
      | Review Status | Carrier                       |
      | Approved      | Email Carrier One - Truckload |
    Then Verify Table details with Reference of "Carrier" as "Email Carrier Two - Truckload"
      | Review Status | Carrier                       |
      | Approved      | Email Carrier Two - Truckload |
    Then Verify Table details with Reference of "Carrier" as "Liverpool Reds Transport - Truckload"
      | Review Status | Carrier                              |
      | Approved      | Liverpool Reds Transport - Truckload |
    Then Verify Table details with Reference of "Carrier" as "Stored Rate Carrier Two - Truckload"
      | Review Status | Carrier                             |
      | Approved      | Stored Rate Carrier Two - Truckload |

    #Step 19
    Then Click on Checkbox "Approved" to "False"
    Then Click on Carrier Match Refresh button in "Filter"

    #Step 20 & Expected b
    Then Verify if all status in "Review Status" column are displayed under "In Network"

    #Step 21
    Then Update details
      | Domicile (Origin) |
      | 25                |
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"

    #Step 22 & Expected c
    Then Verify Table "In Network" details should "not contain" below values
      | Carrier                              |
      | Liverpool Reds Transport - Truckload |

    #Step 23
    Then Update details
      | Domicile (Destination) |
      | 25                     |
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"
    Then Wait for "5" Seconds

    #Step 24 & Expected d
    Then Verify Table "In Network" details should "not contain" below values
      | Carrier                             |
      | Stored Rate Carrier One - Truckload |
      | Stored Rate Carrier Two - Truckload |

    #Step 25
    Then Update details
      | Domicile (Origin) | Domicile (Destination) |
      | 100               | 100                    |

    #Step 26
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"

    #Step 27 & Expected e
    Then Verify Table "In Network" details should "contain" below values
      | Carrier                             |
      | Liverpool Reds Transport - Truckload|
      | Stored Rate Carrier One - Truckload |

    #Step 28
    Then Scroll into Section "Loads Delivering"

    #Expected f
    Then Verify Table details with Reference of "Carrier" as "Email Carrier One - Truckload"
      | Load Number | Carrier                       |
      | SysData=>1L | Email Carrier One - Truckload |
    Then Verify Table details with Reference of "Carrier" as "Email Carrier One - Truckload"
      | Load Number | Carrier                       |
      | SysData=>3L | Email Carrier One - Truckload |

    #Step 29
    Then Scroll into Section "In Network"
    Then Update details
      | Delivering (Origin) |
      | 25                  |
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"

    #Step 30
    Then Scroll into Section "Loads Delivering"

    #Expected g
    Then Verify Table "Loads Delivering" details should "not contain" below values
      | Load Number |
      | SysData=>3L |

    #Step 31
    Then Scroll into Section "Truck Postings"

    #Expected h
    Then Verify Table details with Reference of "Carrier" as "Email Carrier One - Truckload"
      | Posting            | Carrier                       |
      | SysData=>Posting_1 | Email Carrier One - Truckload |
    Then Verify Table details with Reference of "Carrier" as "Email Carrier Two - Truckload"
      | Posting            | Carrier                       |
      | SysData=>Posting_2 | Email Carrier Two - Truckload |

    #Step 32 & 33
    Then Scroll into Section "In Network"
    Then Update details
      | Posted (Origin) |
      | 50              |
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"

    #Step 34
    Then Scroll into Section "Truck Postings"

    #Expected i
    Then Verify Table "Truck Postings" details should "not contain" below values
      | Posting            |
      | SysData=>Posting_1 |
    Then Verify values in "Truck Postings" "Range" is within "0-50" range

    #Step 35
    Then Scroll into Section "In Network"
    Then Update details
      | Posted (Origin) |
      | 100             |
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"

    #Step 36
    Then Scroll into Section "Truck Postings"

    #Expected j
    Then Verify Table details with Reference of "Carrier" as "Email Carrier One - Truckload"
      | Posting            | Carrier                       |
      | SysData=>Posting_1 | Email Carrier One - Truckload |
    Then Verify Table details with Reference of "Carrier" as "Email Carrier Two - Truckload"
      | Posting            | Carrier                       |
      | SysData=>Posting_2 | Email Carrier Two - Truckload |
    Then Verify values in "Truck Postings" "Range" is within "0-100" range

    #Step 37
    Then Scroll into Section "In Network"
    Then Update details
      | Mi/Km |
      | km    |
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"

    #Step 38 & Expected k
    Then Verify Table "In Network" details should "not contain" below values
      | Carrier                              |
      | Liverpool Reds Transport - Truckload |

    #Step 39
    Then Scroll into Section "In Network"
    Then Update details
      | Mi/Km |
      | mi    |
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"

    #Step 40 & Expected l
    Then Verify Table details with Reference of "Carrier" as "Liverpool Reds Transport - Truckload"
      | Review Status | Carrier                              |
      | Approved      | Liverpool Reds Transport - Truckload |

    #Step 41
    Then Set "Sfid" with "SysData=>Posting2_SFID"
    Then Update "SysData=>Sfid" from Developer console

    #Step 42 & 43
    Then Scroll into Section "In Network"
    Then Update details
      | Posting Age |
      | 60 min      |
    Then Click on Carrier Match Refresh button in "CarrierMatchesFilterRefresh"

    #Step 44
    Then Scroll into Section "Truck Postings"

    #Expected m
    Then Verify Table "Truck Postings" details should "not contain" below values
      | Posting            |
      | SysData=>Posting_2 |

    #Step 45
    Then Scroll into Section "In Network"
    Then Click on button with Title "Review Status"

    #Expected n
    Then Verify "Review Status" column in Carrier Matches section should be sorted in "ascending" order

    #Step 46
    Then Scroll into Section "In Network"
    Then Click on button with Title "Review Status"

    #Expected o
    Then Verify "Review Status" column in Carrier Matches section should be sorted in "descending" order

    #Step 47
    Then Select checkbox with "Carrier" as "Arsenal Gunners Truckers - Truckload" under "In Network" section
    Then Select checkbox with "Carrier" as "Email Carrier One - Truckload" under "In Network" section
    Then Select checkbox with "Carrier" as "Fleet Carrier One - Truckload" under "In Network" section

    #Step 48 & 49
    Then Click on button "Log Call"
    Then Click on Carrier Match Refresh button in "CarrierMatchesHeader"
    Then Wait for "3" Seconds

    #Step 50 & Expected p
    Then Verify Table details with Reference of "Carrier" as "Email Carrier One - Truckload"
      | Request Status | Carrier                       |
      | Requested      | Email Carrier One - Truckload |
    Then Verify Table details with Reference of "Carrier" as "Fleet Carrier One - Truckload"
      | Request Status | Carrier                       |
      | Requested      | Fleet Carrier One - Truckload |
    Then Verify Table details with Reference of "Carrier" as "Arsenal Gunners Truckers - Truckload"
      | Request Status | Carrier                              |
      | Requested      | Arsenal Gunners Truckers - Truckload |

    #Step 51
    Then Update details
      | Mode |
      | LTL  |
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

    #Expected q
    Then Verify values in the "Carrier" column of In Network should contain "LTL"

  #Step 52
    Then Update details
      | Cargo Insurance |
      | 40000           |
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

    #Expected r
    Then Verify Table details with Reference of "Carrier" as "Email Carrier One - LTL"
      | Request Status | Carrier                 |
      | Requested      | Email Carrier One - LTL |
    Then Verify Table "In Network" details should "not contain" below values
      | Carrier                 |
      | Email Carrier Two - LTL |

    #Step 53
    Then Update details
      | Cargo Insurance | Request Status |
      |                 | Requested      |
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

    #  Expected s
    Then Scroll into Section "In Network"
    Then Verify Table "In Network" details should "contain" below values
      | Carrier                 |
      | Email Carrier One - LTL |
      | Fleet Carrier One - LTL |

    #Step 54
    Then Update details
      | Request Status |
      | All            |
    Then Click on Checkbox "Bonded (US)" to "True"
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

    #Expected t
    Then Scroll into Section "In Network"
    Then Verify Table "In Network" details should "contain" below values
      | Carrier                       |
      | Stored Rate Carrier One - LTL |
    Then Verify Table "In Network" details should "not contain" below values
      | Carrier                       |
      | Stored Rate Carrier Two - LTL |

    #Step 55
    Then Click on Checkbox "Bonded (US)" to "False"
    Then Click on Checkbox "SmartWay Certified (US)" to "True"
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

     # Step 56 & Expected u
    Then Scroll into Section "In Network"
    Then Verify Table "In Network" details should "contain" below values
      | Carrier                       |
      | Stored Rate Carrier Two - LTL |
    Then Verify Table "In Network" details should "not contain" below values
      | Carrier                 |
      | Email Carrier One - LTL |

    #Step 57
    Then Click on Checkbox "SmartWay Certified (US)" to "False"
    Then Click on Checkbox "C" to "True"
    Then Update details
      | Mode      |
      | Truckload |
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

    # Expected v
    Then Scroll into Section "In Network"
    Then Verify Table "In Network" details should "contain" below values
      | Carrier                             |
      | Stored Rate Carrier One - Truckload |
    Then Verify Table "In Network" details should "not contain" below values
      | Carrier                             |
      | Stored Rate Carrier Two - Truckload |

    #Step 58
    Then Click on Checkbox "C" to "False"
    Then Click on Checkbox "D" to "True"
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

    # Step 59 & Expected w
    Then Scroll into Section "In Network"
    Then Verify Table "In Network" details should "contain" below values
      | Carrier                             |
      | Stored Rate Carrier Two - Truckload |
    Then Verify Table "In Network" details should "not contain" below values
      | Carrier                             |
      | Stored Rate Carrier One - Truckload |

    #Step 60
    Then Click on Checkbox "D" to "False"
    Then Click on Checkbox "Pending" to "True"
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

    #Expected x
    Then Scroll into Section "In Network"
    Then Verify Table "In Network" details should "contain" below values
      | Carrier                             |
      | Stored Rate Carrier One - Truckload |

    #Step 61
    Then Click on Checkbox "Pending" to "False"
    Then Update details
      | Carrier Name      |
      | Fleet Carrier One |
    Then Click on Carrier Match Refresh button in "Filter"
    Then Wait for "5" Seconds

    #Expected y
    Then Verify Table "In Network" details should only have below values
      | Carrier                       |
      | Fleet Carrier One - Truckload |