Feature:2907 - MatchLoadsToPayIQParticipants Job - Role Parent Object - Trip Plan

  @API @Regression @PayIQ  @WEB @SingleCurrency @2907 @PayIQ_Logs
  Scenario: 2907 - MatchLoadsToPayIQParticipants Job - Role Parent Object - Trip Plan

    When Login into Salesforce

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
      | N       | 2D   | Account_Address | Philadelphia Eagles  | 2       | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Parts   | 999  | NA           | NA       | NA             |
    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"
    
    #Step 3
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Driver Pay - Per Mile" from List
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
    Then Click on "Participant-" with "Name" as "Dave Fleet Carrier One 7"
    Then Click on Edit icon on Label "Pay Off Load Instead of Trip Plan Leg"
    Then Update details
    |Pay Off Load Instead of Trip Plan Leg|
    |True                                 |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Click on "Participant-" with "Name" as "Tractor 1007"
    Then Click on Edit icon on Label "Pay Off Load Instead of Trip Plan Leg"
    Then Update details
      |Pay Off Load Instead of Trip Plan Leg|
      |True                                 |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 4
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds

    #Step 5 & 6
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Wait for "1" Seconds
    Then Update "1" Segment details
      | Search       | Driver                   | Load        |
      | Tractor 1007 | Dave Fleet Carrier One 7 | SysData=>1L |
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "3" Seconds
    Then Update "1" leg details
      | Due Out Time |
      | 1:00 AM            |

    #Step 7
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 8
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 9 & 10
    Then Update "1" leg details
      | Arrival Date |
      | 0           |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds

    #Step 11
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 12
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Participant Matches"

    #Expected a
    Then Verify Table "Participant Matches" row count is "2"

    #Expected b
    Then Click on "Participant Match-" with "Participant Name" as "Dave Fleet Carrier One 7 (Driver)"
    Then Verify Details
      | Participant Name                  | Eligible Date | PayIQ Program                      |
      | Dave Fleet Carrier One 7 (Driver) | 0             | PayIQProgram Driver Pay - Per Mile |

    #Expected c
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Participant Matches"
    Then Click on "Participant Match-" with "Participant Name" as "Tractor 1007 (Fleet Asset)"
    Then Verify Details
      | Participant Name           | Eligible Date | PayIQ Program                      |
      | Tractor 1007 (Fleet Asset) | 0             | PayIQProgram Driver Pay - Per Mile |
