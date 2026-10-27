Feature: 522 - FourKites - Inbound Event Processor- Location Update

  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @FourKites @522
  Scenario: 522 - FourKites - Inbound Event Processor- Location Update

    When Login into Salesforce

  # Steps 1
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "6" Seconds

  # Steps 2 & 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer             | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Los Angeles Lighting | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Fargo Wood Chippers | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12345  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

  # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

  # Step5
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -
    Then Update details -
      | Tracking Provider | Driver Phone |
      | FourKites         | 2179721878   |
    Then Click on Native "On" button -
    Then Verify Message displaying as "Success - Carrier Banner"

  # Step 6
    Then Close Toast message

  # Step 7
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Get Details
      | Tracking Number |
      |                 |

  # Step 8
    Then Open "Queued Transactions" from App Launcher
    Then Click on button with Title "New"
    Then Wait for "2" Seconds

    Then Get "522_Payload_1.txt" files and update below Attributes
      | {FourKites_LoadId}       | {Load ID}     |
      | SysData=>Tracking Number | SysData=>1LRI |

    Then Update details -
      | Processor | Direction | Status  | Content Type     | Payload 1                   | Payload 2 |
      | FourKites | Inbound   | Pending | application/json | SysData=>{FinalUpdatedText} |           |
    Then Wait for "5" Seconds
    Then Click on "SaveEdit" button
    Then Verify Text displaying as "was created" -
    Then Wait for "2" Seconds

  # Step 9
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "6" Seconds
    Then Set "PreviousRunTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

  # Step 10
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    Then Go to "Snapshot" Tab

  # Expected a
    Then Verify Details
      | Last Reported Location |
      | Sunbury, OH            |

  #c Step 11
    Then Click on "Tracking Log" with Text

  # Expected c
    Then Verify "" data is created with following details
      | Type            | Reported Location | COMMENTS                          | Status As Of        | Update Received At(Date) | Source     |
      | Location Update | Sunbury, OH       | Location Update: I-71 Sunbury, OH | 6/12/2023, 10:28 AM | SysData=>PreviousRunTime | Four Kites |