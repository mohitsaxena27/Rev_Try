Feature: 537 - MacroPoint API- Inbound Update Tracking

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @537 @MacroPoint
  Scenario: 537 - MacroPoint API- Inbound Update Tracking

    When Login into Salesforce

    # Step 1
    Then Run "QueuedTransactionJob" Job

    # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "2" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Platform Events" -
    Then Update details -
      | Macropoint |
      | false      |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame

    # Step 3 & Step 4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 48'    | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Expected_Date | Value | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | 0             | NA    | NA                       | 0830             | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then Click on button "Assign"
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Refresh current Page

    # Step 6 & Step 7
    Then Go to "Summary" Tab
    Then Click on Native "Load Tracking" icon
    Then Verify Text displaying as "Load Tracking Administration" -
    Then Update details -
      | Tracking Provider | Driver Phone |
      | MacroPoint        | 2179721878   |
    Then Click on Native "On" button -
    Then Verify Message displaying as "Success - Carrier Banner"
    Then Close Toast message
    
    #Step 8
    Then Refresh current Page
    Then Wait for "1" Seconds
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking IDs"
    Then Get Details
      | Tracking Number |
      |                 |

    #expected Result a
    Then Verify "Tracking Number" is Not null or Empty
    Then Verify Details
      | Tracking Provider |
      | MacroPoint        |

    # Step 9
    Then Get "PayLoad.txt" files and update below Attributes
      | {LoadID}    |
      | SysData=>1L |
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      | Processor  | Direction | Status  | Content Type     |
      | MacroPoint | Inbound   | Pending | application/json |
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "80" Seconds

    # Step 10 & Expected Result b
    Then Navigate to stored URL for "Load_1"
    Then Refresh current Page
    Then Go to "Snapshot" Tab
    Then Wait for "10" Seconds
    Then Verify Details
      | Last Reported Location |
      | Cincinnati, OH         |
    Then Verify "1P" Stop Details
      | Carrier Status Comments         |
      | Location Update: Cincinnati, OH |
    Then Set "CurrentTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    # Step 11
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text

    # Expected Result C
    Then Verify "I-75, Cincinnati, OH 45237" data is created with following details
      | TYPE            | REPORTED lOCATION | COMMENTS                   | Status As Of       | Update Received At(Date) | Source     |
      | Location Update | Cincinnati, OH    | I-75, Cincinnati, OH 45237 | 6/12/2023, 9:38 AM | SysData=>CurrentTime     | MacroPoint |