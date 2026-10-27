Feature:1940 - MatchLoadsToPayIQParticipants Job - Team - Effective + Expiration Date
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @1940
  Scenario: 1940 - MatchLoadsToPayIQParticipants Job - Team - Effective + Expiration Date

    When Login into Salesforce

    #Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Team One" from List

    #Step 2a,2b
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

    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Name" as "Team One"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Team Members"
    Then Capture the current URL for "Participants_page"

    Then Click on "Participant-" with "Name" as "Test User1"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Effective Date"
    Then Update details
    |Effective Date|
    |1             |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Effective Date|
      |1         |
    Then Capture the current URL for "Participants_page_1"

    Then Navigate to stored URL for "Participants_page"
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Name" as "Joe Oakland Athletics"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Effective Date"
    Then Update details
      |Expiration Date|
      |-1           |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Expiration Date|
      |-1            |
    Then Capture the current URL for "Participants_page_2"

    #Step 3 and 4
     Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Oakland Athletics  | 2        | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Part   | 2000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 5
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
    |Customer Sales Rep|Carrier Sales Rep|Sales Lead (Contact)|Custom PayIQ Eligible Date|
    |Test User1        | Second User     |Joe Oakland Athletics |0                       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Customer Sales Rep|
      |Test User1        |

    #Step 6
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 7
    Then Navigate to stored URL for "Load_1L"

    #Step 8 and Expected result a
    Then Scroll Until Related List for "Participant Matches"
    Then Scroll down with "2" Times
    Then Click on "Participant Match-" with "Participant Name" as "Team One (Team)"
    Then Verify Details
    |Participant Name|Eligible Date|PayIQ Program|
    |Team One (Team) |2            |PayIQ Program Team One|
    Then Get Details
    |Participant Match ID|
    |                    |
    Then Navigate to stored URL for "Load_1L"

    #Step 9 and Expected result b
    Then Scroll Until Related List for "Pay Details"
    Then Verify "Pay Details" count displaying as "3"
    Then Verify "Pay Details" Table With Details
    |Participant Name|Pay Amount|Participant Match|PayIQ Program|
    |Test User1 (User)|USD 2.50 |SysData=>Participant Match ID|PayIQ Program Team One|
    |Second User (User)|USD 2.50 |SysData=>Participant Match ID|PayIQ Program Team One|
    |Joe Carolina Panthers (Contact)|USD 2.50 |SysData=>Participant Match ID|PayIQ Program Team One|


