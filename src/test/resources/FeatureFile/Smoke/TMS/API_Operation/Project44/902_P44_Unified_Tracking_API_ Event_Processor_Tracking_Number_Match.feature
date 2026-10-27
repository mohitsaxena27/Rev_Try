Feature: 902 - P44 Unified Tracking API- Event Processor - Tracking Number Match

  @Regression @WEB @TMS @Smoke @API @API_Operation @SingleCurrency @Project44 @902
  Scenario: 902 - P44 Unified Tracking API- Event Processor - Tracking Number Match

    When Login into Salesforce
  #Steps 1 & 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Wait for "2" Seconds
    Then Go to "Global Services" Tab
    Then Search text "OpenTrack" in the "Search Credentials..." search box
    Then Select the "OpenTrack" record from the lookup field results
    Then Update details
      | Enabled |
      | False    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds
    Then Search text "Project44 Tracking" in the "Search Credentials..." search box
    Then Select the "Project44 Tracking" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

  #Steps 3
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job

  #Steps 4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Drayage       | Container 40   | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats     |  3            | NA                       | 1445             | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Bananas      |15000 |NA          |NA       |NA           |NA    |NA   |NA    |NA            |NA        |

    Then Update container details
      | Container Number |Port/Terminal of Load|SCAC|
      | TRHU9024567      |Port of Savannah     |SCAC|
      | TRHU9024568        |Port of Savannah   |SCAC|
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

  #Step 5
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU9024567" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|Tracking Number                         |
      |On      |6f8a930c-266e-4f4e-af7c-380628cb2460    |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

  #Step 6,7,8
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU9024568" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking Number                    |
      |6f8a930c-266e-4f4e-af7c-380628cb2460|
    Then Click on "Save" button on Details Page
    Then Store current Chicago Time in format of "M/d/yyyy, h:mm a" on to "Container_Date_Time"
    Then Wait for "3" Seconds

  #Steps 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | Boston Beans | Drayage       | Container 40   | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats     |  3            | NA                       | 1445             | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Bananas      |15000 |NA          |NA       |NA           |NA    |NA   |NA    |NA            |NA        |

    Then Update details
      | Container Number |Port/Terminal of Load|SCAC|
      | TRHU9024569      |Port of Savannah     |SCAC|
    Then Save Load With All details
    Then Capture the current URL for "Load_2"

  #Step 10
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU9024569" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|Tracking Number                         |
      |On      |6f8a930c-266e-4f4e-af7c-380628cb2460    |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

  #Step 11
    Then Get "Project44UnifiedTransaction_Inbound_Old_packet_used_for_902.txt" files and update below Attributes
      |No Update Required|
      |No Update Required|
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |
      |Project44 Unified Tracking    |Inbound  |Pending|application/json|
    Then Wait for "2" Seconds
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

  #Step 12
    Then Wait for "120" Seconds
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Status   |
      |Processed|

  #Step 13
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU9024567" from Search List
    Then Wait for "2" Seconds

  #Step 14
  #Expected a
  #Expected aa
    Then Verify Details
      |Container Number|Vessel         |Route Information                                            |Container Status    |Container Status Comments|Tracking|Tracking Provider|Tracking Number                     |Geolocation|Geolocation as of|
      |TRHU9024567     |USS Enterprise|PORT OF LOADING: Savannah\nPORT OF DISCHARGE: Hamburg - DEHAM |Departure from Stop |                         |On      |                 |6f8a930c-266e-4f4e-af7c-380628cb2460|           |                 |

  #Expected ab
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) | Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Savannah     |America/New_York              |                            |                            |                            |                            | 2/5/2022                 | 1:16:00 AM                |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |                       |                       |                        |                        |

  #Expected ac
    Then Verify Details
      |Port/Terminal of Discharge|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Hamburg           |                          |                          |                          |                          |                       |                       |                   |                    |                  |                  |                              |                              |                       |                       |                              |                               |                       |                       |

  #Step 15
    Then Scroll into Section "Port/Terminal of Load"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Port/Terminal of Load"
    Then Update details
    |Port/Terminal of Load|Actual Departure Date (L)|Actual Departure Time (L)|
    |                     |                         |                         |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

  #Step 16
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU9024568" from Search List
    Then Wait for "2" Seconds

  #Step 17
  #Expected b
    Then Scroll into Section "System Information"
    Then Wait for "2" Seconds
    Then Verify Details
    |Last Modified By              |
    |SysData=>Container_Date_Time  |

  #Step 18
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU9024569" from Search List
    Then Wait for "2" Seconds

  #Step 19
  #Expected c
  #Expected ca
    Then Verify Details
      |Container Number|Vessel         |Route Information                                    |Container Status    |Container Status Comments|Tracking|Tracking Provider|Tracking Number                     |Geolocation|Geolocation as of|
      |TRHU9024569     | USS Enterprise|PORT OF LOADING: Savannah\nPORT OF DISCHARGE: Hamburg|Departure from Stop |                         |On      |                 |6f8a930c-266e-4f4e-af7c-380628cb2460|           |                 |

  #Expected cb
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) | Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Savannah     |America/New_York              |                            |                            |                            |                            | 2/7/2022                 | 4:19:00 AM                |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |                       |                       |                        |                        |

  #Expected cc
    Then Verify Details
      |Port/Terminal of Discharge|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Hamburg           |                          |                          |                          |                          |                       |                       |                   |                    |                  |                  |                              |                              |                       |                       |                              |                               |                       |                       |

  #Step 20
    Then Delete All Records with name "TRHU9024569" for "rtms__Container__c"

  #Step 21
    Then Get "Project44Unified_Tracking_Update_902.json" files and update below Attributes
      |No Update Required|
      |No Update Required|
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "3" Seconds
    Then Update details -
      |Processor                     |Direction|Status |Content Type    |
      |Project44 Unified Tracking    |Inbound  |Pending|application/json|
    Then Wait for "2" Seconds
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "140" Seconds
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Status   |
      |Processed|


  #Step 22
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU1233902" from Search List
    Then Wait for "2" Seconds

  #Step 23
  #Expected d
  #Expected da
    Then Verify Details
      |Container Number|Vessel           |Route Information                                            |Container Status    |Container Status Comments|Tracking|Tracking Provider|Tracking Number                     |Geolocation        |Geolocation as of  |
      |TRHU1233902     |QA USS Enterprise|PORT OF LOADING: Savannah - USSAV\nPORT OF DISCHARGE: Hamburg|Unload from Vehicle |                         |On      |                 |6f8a930c-266e-4f4e-af7c-380628cb2460|37.284283, 4.562112|2/23/2022, 12:02 PM|

  #Expected db
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) | Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Savannah     |America/New_York              |2/6/2022                    |2:00:00 AM                  |2/5/2022                    |8:00:00 AM                  | 2/5/2022                 | 4:19:00 AM                |                         |                         |                                     |                                     |                         |                          |1/17/2022                |8:05:00 AM              |                              |                              |1/29/2022              |3:20:00 AM             |2/4/2022                |11:41:00 AM             |

  #Expected dc
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone |Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Hamburg           |Europe/Vienna                       | 3/6/2022                 | 6:00:00 AM               |3/5/2022                  | 1:00:00 PM               |  1/16/2022            |   3:05:00 PM          |2/5/2022           |2:19:00 AM          |3/9/2022          |11:29:00 AM       |                              |                              |3/10/2022              |2:33:00 PM             |                              |                               |3/11/2022              |11:20:00 AM            |

  #Step 24
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU9024568" from Search List
    Then Wait for "2" Seconds

  #Step 25
  #Expected e
    Then Scroll into Section "System Information"
    Then Wait for "2" Seconds
    Then Verify Details
      |Last Modified By            |
      |SysData=>Container_Date_Time|
