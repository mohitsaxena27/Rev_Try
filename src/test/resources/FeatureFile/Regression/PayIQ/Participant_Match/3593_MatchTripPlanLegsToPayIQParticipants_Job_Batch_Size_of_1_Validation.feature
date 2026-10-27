Feature:3593 - MatchTripPlanLegsToPayIQParticipants Job - Batch Size of 1 Validation
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @3593
  Scenario: 3593 - MatchTripPlanLegsToPayIQParticipants Job - Batch Size of 1 Validation

    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"

    When Login into Salesforce
    #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Click on "New" with Text
    Then Update details
     | Name            |   Status    |  Pay Schedule  |
     | TPL Batch Test |  Open  |  Test Pay Schedule  |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Set Key "PayIQ_Program_SFID_1" page Record Id with "rtms9__PayIQ_Program__c"

    #Step 2
    Then Click on "New" button on "Roles" section
    Then Update details
      | Parent Object   | Lookup Type | Eligible Date Field   |
      | Trip Plan Leg   |    Driver   | Arrival Date |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
     #Step 3
    Then Click on "New" button on "Participants" section
    Then Update details
      | Type   |      Driver          | Pay Off Load Instead of Trip Plan Leg   |
      | Driver | Bruce Fleet Carrier Two 2  | False |
    #Step 4
    Then Click on button with Title "Save & New"
    Then Wait for "2" Seconds
    Then Update details
      | Type   |      Driver          | Pay Off Load Instead of Trip Plan Leg   |
      | Driver | Bruce Fleet Carrier Two 2  | True |
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds

    #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload |       NA       | NA             | NA                |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 7             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Beans    | 10000   | NA           | NA       | NA             |

    Then Save Load With All details
    #Step 6
    Then  Capture the current URL for "Load_1L"
    #Step 7
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    #Step 8
    Then Update "1" Segment details
     | Load   | Driver                   |
     | SysData=>1L | Bruce Fleet Carrier Two 2 |
    Then Wait for "5" Seconds
    #Step 9
    Then Update "1" leg details
      | Start Type | Location     | Due Out Date  | Appointment Start Time | Appointment End Time |
      | Location   | Boston Beans |   0             | 12:00 AM      |        12:00 AM       |

    Then Update "2" leg details
    |Due Out Time |  Appointment Start Time | Appointment End Time |
     | 12:15 AM     | 12:30 AM               |     12:30 AM          |

    #Step 9
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    Then Update "1" leg details
      | Arrival Date |
      |      0       |
    Then Update "2" leg details
      | Arrival Date |
      |     7       |

    # Step 10 & 11,12
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "10" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Click on button with Title "Close"

    #Step 13
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Go to "Configuration" Tab
    Then Wait for "2" Seconds
    Then Update details
    |  Match Trip Plan Legs to PayIQ Participants Batch Size|
    | 1                                                     |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
   #Step 14
    Then Go to "Job Monitor" Tab
    Then Wait for "6" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 15
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "TPL Batch Test" from List
    #Step 16
    Then Go to "PayIQ Generated" Tab
    #Expected a
    Then Verify Table "Participant Matches" row count is "3"
    Then Click on link "Participant Matches"
    Then Wait for "2" Seconds
    #Expected b
    Then Set "MatchedTo" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "MatchedTo_2" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Verify "Participant Matches" Table Details
      | Participant Name                  | Matched To Type | Matched To |
      |Bruce Fleet Carrier Two 2 (Driver) | Load            | SysData=>1L|
      | Bruce Fleet Carrier Two 2 (Driver)|  Trip Plan Leg  | SysData=>MatchedTo |
      | Bruce Fleet Carrier Two 2 (Driver)|  Trip Plan Leg  | SysData=>MatchedTo_2 |
