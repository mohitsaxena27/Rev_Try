Feature: 2762 - MatchLoadsToPayIQParticipants Job - Custom Eligible Date
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2762
  Scenario: 2762 - MatchLoadsToPayIQParticipants Job - Custom Eligible Date

    When Login into Salesforce

    #Precondition Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program 2762" from List

    #Precondition Step 2
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

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles  | 2       | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Parts   | 999  | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 2
    Then  Capture the current URL for "Load_1L"

    #Step 3
    Then Go to "PayIQ" Tab
    Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact)    |Custom PayIQ Eligible Date|
      | Second User        | Joe Philadelphia Eagles |32                    |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Second User        |
    Then Get Details
      |Custom PayIQ Eligible Date|
      |                          |


    #Step 4
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 5
    Then Navigate to stored URL for "Load_1L"

    #Step 6
    Then Scroll Until Related List for "Participant Matches"
    #Expected Result a
    Then Scroll down with "2" Times
    Then Click on "Participant Match-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)"
    Then Verify Details
      |Eligible Date                        |
      |SysData=>Custom PayIQ Eligible Date  |
    Then Wait for "2" Seconds
    Then Navigate Browser Back
    Then Click on "Participant Match-" with "Participant Name" as "Second User (User)"
    Then Verify Details
      |Eligible Date                        |
      |SysData=>Custom PayIQ Eligible Date  |
    Then Wait for "2" Seconds

    #Step 6a)
    Then Wait for "2" Seconds
    Then Click on "Pay Period-" with Contains Text
    Then Wait for "2" Seconds
    Then Get Details
      | Period Beginning          | Period Ending       |
      | SysData=>BeginningDate    | SysData=>EndingDate |
   #Expected Result b
    Then Verify date "SysData=>Custom PayIQ Eligible Date" falls between "SysData=>Period Beginning" and "SysData=>Period Ending"


