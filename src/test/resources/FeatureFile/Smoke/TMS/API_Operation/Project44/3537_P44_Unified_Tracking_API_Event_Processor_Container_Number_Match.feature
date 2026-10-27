Feature: 3537 - P44 Unified Tracking API- Event Processor: Container Number Match
Background: Pre- Test
  When Login into Salesforce
  Then Delete All Records with name "TRHU1233537" for "rtms__Container__c"
  Then Open "TMS Admin" from App Launcher
  Then Go to "Modes" Tab
  Then Switch to Frame by Title "accessibility title"
  Then Click on "Mode" Link Text "Drayage" on Page -
  Then Switch to Parent Frame
  Then Scroll into Section "General Settings"
  Then Click on Edit icon on Label "Show Containers on Load Creation"
  Then Update details
    | Show Containers on Load Creation |
    | True                             |
  Then Click on "SaveEdit" button
  Then Wait for "3" Seconds
  Then Verify Details
    | Show Containers on Load Creation |
    | True                             |
  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @Project44 @3537
  Scenario: 3537 - P44 Unified Tracking API- Event Processor: Container Number Match
  #step1
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "4" Seconds
  # Step2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Wait for "2" Seconds
    Then Go to "Global Services" Tab
    Then Search text "OpenTrack" in the "Search Credentials..." search box
    Then Select the "OpenTrack" record from the lookup field results
    Then Update details
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
  #step3
    Then Search text "Project44 Tracking" in the "Search Credentials..." search box
    Then Select the "Project44 Tracking" record from the lookup field results
    Then Update details
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

     # Steps 4- Create the quick-entry shipment
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode    | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Drayage | Container 40   | N             | N                 |

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
      | Container Number | SCAC |
      | TRHU1233537      | SCAC |
      | TRHU1233537      | TRHU |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"
    #step 5
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU1233537" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      | Tracking |
      | On       |
    Then Click on "Save" button on Details Page
  #step6
    Then Get "Project 44 Unified- Tracking Update 3537 Container Number Match.json" files and update below Attributes
      | No Update Required |
      | No Update Required |

    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "3" Seconds

    Then Update details -
      | Processor                  |
      | Project44 Unified Tracking |

    Then Update details -
      | Direction | Status  | Content Type    |
      | Inbound   | Pending | application/json |

    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"

    Then Update details
      | Payload 2 |
      |           |

    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    Then Verify Details
      | Processor                  | Direction | Status  | Content Type    |
      | Project44 Unified Tracking | Inbound   | Pending | application/json |
   #step7
    Then Wait for "180" Seconds
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Status    |
      | Processed |
    #step8
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "3" Seconds
    Then Scroll into Section "Containers"
    Then Click on container "TRHU1233537" with SCAC "SCAC"
    Then Wait for "2" Seconds

    #step9
    Then Scroll into Section "Container Information"
    Then Verify Details
      | Container Number | Vessel         | Route Information                                                        | Container Status | Container Status Comments | Tracking | Tracking Provider | Tracking Number | Geolocation         | Geolocation as of     |
      | TRHU1233537      | USS Enterprise | PORT OF LOADING: Navi Mumbai (Nhava Sheva) - INNSA\nPORT OF DISCHARGE: Hamburg - DEHAM | Return to Sender |                          | On       |                   |                 | 37.284283, 4.562112 | 2/23/2022, 12:02 PM |


    Then Scroll into Section "Port/Terminal of Load"
    Then Verify Details
      | Port/Terminal of Load | Port/Terminal of Load Timezone | Scheduled Departure Date (L) | Scheduled Departure Time (L) | Estimated Departure Date (L) | Estimated Departure Time (L) | Actual Departure Date (L) | Actual Departure Time (L) | Earliest Pickup Date (L) | Earliest Pickup Time (L) | Earliest Return Date - Demurrage (L) | Earliest Return Time - Demurrage (L) | Terminal Cut-Off Date (L) | Terminal Cut-Off Time (L) | Gated Out Empty Date (L) | Gated Out Empty Time (L) | Last Free Date - Detention (L) | Last Free Time - Detention (L) | Gated In Full Date (L) | Gated In Full Time (L) | Loaded On Board Date (L) | Loaded On Board Time (L) |
      |                       |                                |                               |                               |                              |                              |                           |                           |                           |                           |                                      |                                      |                           |                           |                           |                           |                                  |                                  |                          |                          |                          |                          |

    Then Scroll into Section "Port/Terminal of Discharge"
    Then Verify Details
      | Port/Terminal of Discharge | Scheduled Arrival Date (D) | Scheduled Arrival Time (D) | Estimated Arrival Date (D) | Estimated Arrival Time (D) | Actual Arrival Date (D) | Actual Arrival Time (D) | Discharged Date (D) | Discharged Time (D) | Available Date (D) | Available Time (D) | Last Free Date - Demurrage (D) | Last Free Time - Demurrage (D) | Gated Out Full Date (D) | Gated Out Full Time (D) | Last Free Date - Detention (D) | Last Free Time - Detention (D) | Gated In Empty Date (D) | Gated In Empty Time (D) |
      | Port of Hamburg            | 3/6/2022                    | 6:00:00 AM                  | 3/5/2022                   | 1:00:00 PM                 | 1/16/2022               | 3:05:00 PM               | 2/5/2022            | 2:19:00 AM          | 3/9/2022          | 11:29:00 AM        |                                |                                | 3/10/2022             | 2:33:00 PM             |                                |                                | 3/11/2022            | 11:20:00 AM          |

    #step10
    Then Navigate to stored URL for "Load_1"
    Then Go to "Shipment" Tab
    Then Wait for "3" Seconds
    Then Scroll into Section "Containers"
    Then Click on container "TRHU1233537" with SCAC "TRHU"
    Then Wait for "3" Seconds
    #step11
    Then Scroll into Section "System Information"
    Then Get Details
      | Created By |
    Then Verify Details
      | Last Modified By |
      | SysData=>Created By |