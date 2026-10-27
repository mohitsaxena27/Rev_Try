Feature: 490 - EDI Inbound 990/824- Field Mapping

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @490
  Scenario: 490 - EDI Inbound 990/824- Field Mapping

    When Login into Salesforce
    #-----------------------------------------------------
        #Pre- Step
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
    Then Wait for "2" Seconds
        #Setting up SCAC Value
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "EDI Carrier One" from Search List
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Click on Edit icon on "SCAC"
    Then Enter Label "SCAC" Text as "EDIC1"
    Then Click on "Save" button
    Then Verify "SCAC" having value of "EDIC1"
    Then Capture the current URL for "TP_Page_EDI_Carrier_One"

    #Step1
    Then Go to "Home" Object
    Then Verify and Delete "EDIWatcherJob" from Scheduled Jobs

    #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Freeze Load Number |
      | False               |
    Then Scroll into Section "Debugging" -
    Then Update details -
       | Enable Packet Replay |
       | True                 |
    And Update the Custom Select option "Logging User" as "User User"
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

     #Step 3, 4, 5
    Given Upload File "KleinschmidtGetLoadTenderRespOperation_A.xml" with Title "KleinschmidtGetLoadTenderRespOperation"

    #Step 6
    Then Open "Loads" from App Launcher
#    Then Open Load Number "Load-490A"
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"
    #Steps 7
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number      |
      |Load-490A |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-490A"
    Then Verify Details
      |Load Number      |
      |Load-490A |

    # Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."
    Then Set Carrier Quote value on to "Carrier_Quote_1"

        #Step 9
    Then Open "Loads" from App Launcher
#    Then Open Load Number "Load-490B"
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Boston Beans | Intermodal | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load_2"

    #Steps 10
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number      |
      |Load-490B |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-490B"
    Then Verify Details
      |Load Number      |
      |Load-490B |

    # Step 11
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."
    Then Set Carrier Quote value on to "Carrier_Quote_2"

       #Step 12
    Then Open "Loads" from App Launcher
#    Then Open Load Number "Load-490C"
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |3L       | Boston Beans | Intermodal | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |

    Then Save Load With All details
    Then Capture the current URL for "Load_3"

    #Steps 13
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      |Load Number|Waybill Number|Booking Number|
      |Load-490C |12345          |54321         |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-490C"
    Then Verify Details
      |Load Number      |
      |Load-490C |

    # Step 14
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."
    Then Set Carrier Quote value on to "Carrier_Quote_3"
    #Step 15
    Then Go to "Home" Object
    Then Run "EDIWatcherJob" Job
    Then Wait for "10" Seconds
    
    #Step 16
    Then Navigate to stored URL for "Load_1"

    #Expected Result a
    Then Verify Banner Details
    |Load Status|
    |Assigned   |

    #Step 17
    Then Go to "EDI" Tab
    #Expected b
    Then Verify "EDI Transactions" "Transaction Type" "990" count as "1"
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "990"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "824"

    #Step 18
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Carrier Quotes" on QuoteInvoice Tab
    Then Open "Carrier Quotes" using value from "Carrier_Quote_1" on QuoteInvoice Tab

    #Step 19
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Auto-Engagement"

    #EXpected c
    Then Verify details for
         |Tender Status|
         |Assigned     |

     #Step 20
    Then Navigate to stored URL for "Load_2"
    #Expected Result d
    Then Verify Banner Details
      |Load Status|
      |Assigned   |

    #Step 21
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    #Expected Result e
    Then Verify Details
      |Waybill Number  |
      |490B       |

     #Step 22
    Then Go to "EDI" Tab
    #Expected f
    Then Verify "EDI Transactions" "Transaction Type" "824" count as "1"
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "824"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "990"

   #Step 23
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Carrier Quotes" on QuoteInvoice Tab
    Then Open "Carrier Quotes" using value from "Carrier_Quote_2" on QuoteInvoice Tab

    #Step 24 & 25
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Auto-Engagement"

    #EXpected g & h
    Then Verify details for
      |Tender Status|Tender Exception Comments|
      |Assigned     |Exception Comment $^&! 490<|

    #Step 26
    Then Navigate to stored URL for "Load_3"
    #Expected Result i
    Then Verify Banner Details
      |Load Status|
      |Declined   |

    #Step 27
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    #Expected Result j & k
    Then Verify Details
      |Waybill Number  |Booking Number|
      |490C       |C490|

     #Step 28
    Then Go to "EDI" Tab
    #Expected l
    Then Verify "EDI Transactions" "Transaction Type" "824" count as "1"
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "824"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "990"

   #Step 29
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Carrier Quotes" on QuoteInvoice Tab
    Then Open "Carrier Quotes" using value from "Carrier_Quote_3" on QuoteInvoice Tab

    #Step 30
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Auto-Engagement"

    #EXpected m
    Then Verify details for
      |Tender Status|Tender Declined Reasons|Tender Declined Comments|
      |Rejected     |Missing or Invalid Consignee;OtherUnspecified application error;Out of Range|Declined Comment $^&*! 490|

    #Step 31
     Then Delete Field with Title "KleinschmidtGetLoadTenderRespOperation"

    #Step 32 & 33
    Given Upload File "KleinschmidtGetLoadTenderRespOperation_B.xml" with Title "KleinschmidtGetLoadTenderRespOperation"

    #Step 34
    Then Go to Home Page
    Then Delete "EDIWatcherJob" job

    #Step 35
    Then Navigate to stored URL for "Load_3"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then "New" Carrier
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Tender" Carrier
    Then Verify Message displaying with Text "Load tendered successfully."
    Then Set Carrier Quote value on to "Carrier_Quote_4"

    #Step 36
    Then Go to Home Page
    Then Run "EDIWatcherJob" Job
    Then Wait for "20" Seconds

    #Step 37
    Then Navigate to stored URL for "Load_3"
    Then Wait for "5" Seconds
    #Expected Result n
    Then Verify Banner Details
      |Load Status|
      |Assigned   |

     #Step 38
    Then Go to "EDI" Tab
    #Expected o
    Then Verify "EDI Transactions" "Transaction Type" "824" count as "2"
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "824"
    Then Verify "EDI Transactions" "Transaction Type" is not displaying as "990"

   #Step 39
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Carrier Quotes" on QuoteInvoice Tab
    Then Open "Carrier Quotes" using value from "Carrier_Quote_4" on QuoteInvoice Tab

    #Step 40
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Auto-Engagement"

    #EXpected p
    Then Verify Details
      |Tender Status|Tender Declined Reasons|Tender Declined Comments|
      |Assigned     |                       ||













