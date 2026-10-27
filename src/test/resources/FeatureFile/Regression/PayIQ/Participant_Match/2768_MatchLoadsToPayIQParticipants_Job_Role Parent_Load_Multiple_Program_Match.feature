Feature:2768 - MatchLoadsToPayIQParticipants Job - Role Parent - Load - Multiple Program Match
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2768
  Scenario: 2768 - MatchLoadsToPayIQParticipants Job - Role Parent - Load - Multiple Program Match

    When Login into Salesforce

    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program 2757" from List
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Open|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Open|
    Then Capture the current URL for "PayIQ_Program_1"

    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program 1936" from List
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Open|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Open|
    Then Capture the current URL for "PayIQ_Program_2"

    #Step 1 & 2
     Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles  | 2        | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Parts   | 999  | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"
    Then Store date with offset "0" as "TodayDate"
    Then Store date with offset "2" as "TwoDaysDate"

    #Step 3
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
    |Customer Sales Rep|Sales Lead (Contact)|
    |Second User     |Joe Philadelphia Eagles |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Customer Sales Rep|
      |Second User       |


    #Step 4
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

  #Step 5
    Then Navigate to stored URL for "Load_1L"

    #Step 6 and Expected result a & b
    Then Scroll Until Related List for "Participant Matches"
    Then Verify "Participant Matches" count displaying as "4"
    Then Click on link "Participant Matches"
    Then Wait for "3" Seconds
    Then Verify "Participant Matches" Table Details
      |Participant Name                 |PayIQ Program      |Eligible Date|
      |Joe Philadelphia Eagles (Contact)|PayIQ Program 1936 |SysData=>TodayDate|
      |Second User (User)               |PayIQ Program 1936 |SysData=>TwoDaysDate|
      |Joe Philadelphia Eagles (Contact)|PayIQ Program 2757 |SysData=>TwoDaysDate|
      |Second User (User)               |PayIQ Program 2757 |SysData=>TodayDate |



