Feature: 3575 - P44 Unified Tracking API- Event Processor: Event Processing Logic

  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @@Project44 @3575
  Scenario: 3575 - P44 Unified Tracking API- Event Processor: Event Processing Logic

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
    Then Wait for "4" Seconds

#Steps 4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode    | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Drayage |  Container 40  | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Wait for "2" Seconds
    Then Update container details
      | Container Number | Port/Terminal of Load | Port/Terminal of Discharge | SCAC |
      | TRHU4563575      | Port of Shanghai      | Port of Savannah           | SCAC |
      | TRHU5563575      | Port of Shanghai      | Port of Savannah           | SCAC |
      | TRHU6563575      | Port of Shanghai      | Port of Savannah           | SCAC |
      | TRHU7563575      | Port of Shanghai      | Port of Savannah           | SCAC |
      | TRHU8563575      | Port of Shanghai      | Port of Savannah           | SCAC |
      | TRHU9563575      | Port of Shanghai      | Port of Savannah           | SCAC |
      | TRHU1063575      | Port of Shanghai      | Port of Savannah           | SCAC |
      | TRHU1163575      | Port of Shanghai      | Port of Savannah           | SCAC |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

#Step 5
    Then Go to "Details" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Import/Export Information"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Master Bill of Lading Number"
    Then Update details
      |Master Bill of Lading Number|
      |MBOL3575                    |
    Then Click on "Save" button on Details Page

#Step 6
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU4563575" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|
      |On      |
    Then Click on "Save" button on Details Page

#Step 7,8
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU5563575" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|
      |On      |
    Then Click on "Save" button on Details Page

#Step 9,10
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU6563575" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|
      |On      |
    Then Click on "Save" button on Details Page

#Step 11,12
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU7563575" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|
      |On      |
    Then Click on "Save" button on Details Page

#Step 13,14
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU8563575" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|
      |On      |
    Then Click on "Save" button on Details Page

#Step 15,16
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU9563575" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|
      |On      |
    Then Click on "Save" button on Details Page

#Step 17,18
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU1063575" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|
      |On      |
    Then Click on "Save" button on Details Page

#Step 19,20
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU1163575" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      |Tracking|
      |On      |
    Then Click on "Save" button on Details Page

#Step 21
    Then Get "Project_44_Unified_Tracking_Update_3575.json" files and update below Attributes
      |No Update Required|
      |No Update Required|
    Then Wait for "2" Seconds
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Update details -
      |Processor                 |
      |Project44 Unified Tracking|
    Then Update details -
      |Direction|Status |Content Type    |
      |Inbound  |Pending|application/json|
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds


#Step 22
    Then Wait for "80" Seconds
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Status  |
      |Processed|

#Step 23
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU4563575" from Search List
    Then Wait for "2" Seconds

#Step 24
    #Expected 24a
#Expected a
    Then Verify Details
      |Container Number|Vessel|Route Information                                                                                                                                         |Container Status|Container Status Comments|Tracking|Tracking Number|Geolocation|Geolocation as of|
      |TRHU4563575     |      |PICKUP: Shanghai International Terminal (QA)\nORIGIN: Binh Duong Port\nPORT OF LOADING: Shanghai International Terminal (QA)\nPORT OF DISCHARGE: Savannah |Gate Out Empty  |qa is cool               |On      |               |           |                 |

#Expected b
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) | Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Shanghai     |Asia/Shanghai                 |                            |                            |                            |                            |                          |                           |                         |                         |                                     |                                     |                         |                          |9/5/2025                 |6:16:00 PM              |                              |                              |                       |                       |                        |                        |

#Expected c
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Savannah          |America/New_York                   |                          |                          |                          |                          |                       |                       |                   |                    |                  |                  |                              |                              |                       |                       |                              |                               |                       |                       |

#Step 25
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU5563575" from Search List
    Then Wait for "2" Seconds

#Step 26
    #Expected 26b
#Expected a
    Then Verify Details
      |Container Number|Vessel|Route Information                                                                                                                                         |Container Status|Container Status Comments|Tracking|Tracking Number|Geolocation|Geolocation as of|
      |TRHU5563575     |      |PICKUP: Shanghai International Terminal (QA)\nORIGIN: Binh Duong Port\nPORT OF LOADING: Shanghai International Terminal (QA)\nPORT OF DISCHARGE: Savannah |Gate Out Full   |qa is cool x2            |On      |               |           |                 |

#Expected b
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) | Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Shanghai     |Asia/Shanghai                 |                            |                            |                            |                            |                          |                           |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |                       |                       |                        |                        |

#Expected c
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Savannah          |America/New_York                   |                          |                          |                          |                          |                       |                       |                   |                    |                  |                  |                              |                              | 9/8/2025              | 6:18:00 AM            |                              |                               |                       |                       |

#Step 27
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU6563575" from Search List
    Then Wait for "2" Seconds

#Step 28
    #Expected 27c
#Expected a
    Then Verify Details
      |Container Number|Vessel|Route Information                                                                                                                                         |Container Status|Container Status Comments|Tracking|Tracking Number|Geolocation|Geolocation as of|
      |TRHU6563575     |      |PICKUP: Shanghai International Terminal (QA)\nORIGIN: Binh Duong Port\nPORT OF LOADING: Shanghai International Terminal (QA)\nPORT OF DISCHARGE: Savannah |Gate In Full    |                         |On      |               |           |                 |

#Expected b
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) | Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Shanghai     |Asia/Shanghai                 |                            |                            |                            |                            |                          |                           |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |9/10/2025              |10:34:00 PM            |                        |                        |

#Expected c
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Savannah          |America/New_York                   |                          |                          |                          |                          |                       |                       |                   |                    |                  |                  |                              |                              |                       |                       |                              |                               |                       |                       |

#Step 29
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU7563575" from Search List
    Then Wait for "2" Seconds

#Step 30
    #Expected 30d
#Expected a
    Then Verify Details
      |Container Number|Vessel|Route Information                                                                                                                                         |Container Status|Container Status Comments|Tracking|Tracking Number|Geolocation|Geolocation as of|
      |TRHU7563575     |      |PICKUP: Shanghai International Terminal (QA)\nORIGIN: Binh Duong Port\nPORT OF LOADING: Shanghai International Terminal (QA)\nPORT OF DISCHARGE: Savannah |Load            |load event type comment  |On      |               |           |                 |

#Expected b
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) | Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Shanghai     |Asia/Shanghai                 |9/14/2025                   |2:36:00 AM                  |                            |                            |                          |                           |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |                       |                       |9/10/2025               |3:59:00 PM              |

#Expected c
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Savannah          |America/New_York                   |                          |                          |                          |                          |                       |                       |                   |                    |                  |                  |                              |                              |                       |                       |                              |                               |                       |                       |

#Step 31
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU8563575" from Search List
    Then Wait for "2" Seconds

#Step 32
    #Expected 32e
#Expected a
    Then Verify Details
      |Container Number|Vessel|Route Information                                                                                                                                         |Container Status    |Container Status Comments          |Tracking|Tracking Number|Geolocation|Geolocation as of|
      |TRHU8563575     |      |PICKUP: Shanghai International Terminal (QA)\nORIGIN: Binh Duong Port\nPORT OF LOADING: Shanghai International Terminal (QA)\nPORT OF DISCHARGE: Savannah |Departure from Stop |dept from stop event type comment  |On      |               |           |                 |

#Expected b
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) |Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Shanghai     |Asia/Shanghai                 |                            |                            |                            |                            |9/11/2025                 |12:45:00 AM               |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |                       |                       |                        |                        |

#Expected c
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Savannah          |America/New_York                   |                          |                          |                          |                          |                       |                       |                   |                    |                  |                  |                              |                              |                       |                       |                              |                               |                       |                       |

#Step 33
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU9563575" from Search List
    Then Wait for "2" Seconds

#Step 34
    #Expected 34f
#Expected a
    Then Verify Details
      |Container Number|Vessel|Route Information                                                                                                                                         |Container Status|Container Status Comments|Tracking|Tracking Number|Geolocation|Geolocation as of|
      |TRHU9563575     |      |PICKUP: Shanghai International Terminal (QA)\nORIGIN: Binh Duong Port\nPORT OF LOADING: Shanghai International Terminal (QA)\nPORT OF DISCHARGE: Savannah |                |                          |On      |               |           |                 |

#Expected b
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) |Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Shanghai     |Asia/Shanghai                 |                            |                            |                            |                            |                          |                          |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |                       |                       |                        |                        |

#Expected c
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Savannah          |America/New_York                   |                          |                          | 9/11/2025                | 2:36:00 PM               |                       |                       |                   |                    |                  |                  |                              |                              |                       |                       |                              |                               |                       |                       |

#Step 35
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU1063575" from Search List
    Then Wait for "2" Seconds

#Step 36
    #Expected 36g
#Expected a
    Then Verify Details
      |Container Number|Vessel|Route Information                                                                                                                                         |Container Status|Container Status Comments|Tracking|Tracking Number|Geolocation|Geolocation as of|
      |TRHU1063575     |      |PICKUP: Shanghai International Terminal (QA)\nORIGIN: Binh Duong Port\nPORT OF LOADING: Shanghai International Terminal (QA)\nPORT OF DISCHARGE: Savannah |Discharge       |                          |On      |              |           |                 |

#Expected b
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) |Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Shanghai     |Asia/Shanghai                 |                            |                            |                            |                            |                          |                          |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |                       |                       |                        |                        |

#Expected c
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Savannah          |America/New_York                   |                          |                          |                          |                          |                       |                       |10/22/2025         |11:38:00 AM         |                  |                  |                              |                              |                       |                       |                              |                               |                       |                       |

#Step 37
    Then Open "Containers" from App Launcher
    Then Search And Select "TRHU1163575" from Search List
    Then Wait for "2" Seconds

#Step 38
    #Expected 38h
#Expected a
    Then Verify Details
      |Container Number|Vessel|Route Information                                                                                                                                         |Container Status|Container Status Comments|Tracking|Tracking Number|Geolocation|Geolocation as of|
      |TRHU1163575     |      |PICKUP: Shanghai International Terminal (QA)\nORIGIN: Binh Duong Port\nPORT OF LOADING: Shanghai International Terminal (QA)\nPORT OF DISCHARGE: Savannah |Tracking Stop   |Tracking not active.     |Off     |               |           |                 |

#Expected b
    Then Verify Details
      |Port/Terminal of Load|Port/Terminal of Load Timezone|Scheduled Departure Date (L)|Scheduled Departure Time (L)|Estimated Departure Date (L)|Estimated Departure Time (L)|Actual Departure Date (L) |Actual Departure Time (L) |Earliest Pickup Date (L) |Earliest Pickup Time (L) |Earliest Return Date - Demurrage (L) |Earliest Return Time - Demurrage (L) |Terminal Cut-Off Date (L)|Terminal Cut-Off Time (L) |Gated Out Empty Date (L) |Gated Out Empty Time (L)|Last Free Date - Detention (L)|Last Free Time - Detention (L)|Gated In Full Date (L) |Gated In Full Time (L) |Loaded On Board Date (L)|Loaded On Board Time (L)|
      |Port of Shanghai     |Asia/Shanghai                 |                            |                            |                            |                            |                          |                          |                         |                         |                                     |                                     |                         |                          |                         |                        |                              |                              |                       |                       |                        |                        |

#Expected c
    Then Verify Details
      |Port/Terminal of Discharge|Port/Terminal of Discharge Timezone|Scheduled Arrival Date (D)|Scheduled Arrival Time (D)|Estimated Arrival Date (D)|Estimated Arrival Time (D)|Actual Arrival Date (D)|Actual Arrival Time (D)|Discharged Date (D)|Discharged Time (D) |Available Date (D)|Available Time (D)|Last Free Date - Demurrage (D)|Last Free Time - Demurrage (D)|Gated Out Full Date (D)|Gated Out Full Time (D)|Last Free Date - Detention (D)|Last Free Time - Detention (D) |Gated In Empty Date (D)|Gated In Empty Time (D)|
      |Port of Savannah          |America/New_York                   |                          |                          |                          |                          |                       |                       |                   |                    |10/20/2025        | 11:38:00 AM      |                              |                              |                       |                       |                              |                               |                       |                       |