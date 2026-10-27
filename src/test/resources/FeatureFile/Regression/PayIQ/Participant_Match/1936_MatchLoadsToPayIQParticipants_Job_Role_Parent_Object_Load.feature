Feature:1936 - MatchLoadsToPayIQParticipants Job - Role Parent Object - Load
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @1936
  Scenario: 1936 - MatchLoadsToPayIQParticipants Job - Role Parent Object - Load

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"
#    Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "PayIQ Program 1936" from Search List

    #Step 2
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

    #Step 2 & 3
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

    #Step 4
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact)    |Carrier Sales Rep|
      | Second User        | Joe Philadelphia Eagles |User User        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Second User        |

    #Step 5
    Then Execute Load "1L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load
    Then Wait for "4" Seconds
    Then Capture the current URL for "Cloned_Load1"

    #Step 6 & 7
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact)    |Carrier Sales Rep|
      | User User        | Joe Philadelphia Eagles |Second User        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | User User        |

    #Step 8
    Then Execute Load "2L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"

    #Step 9 & 10
    Then Open Last Load from Cloned Load
    Then Wait for "4" Seconds
    Then Expand "Details" for "1" Load
    Then Wait for "2" Seconds
    Then Click on Edit icon with Field Name "1P" "Location"
    Then Store date "0" days and "2" "years" from current date into "FutureDate1"
    Then Update details
      | Expected Date       |
      | SysData=>FutureDate1 |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Collapse "Details" for "1" Load
    Then Wait for "2" Seconds
    Then Expand "Details" for "2" Load
    Then Wait for "2" Seconds
    Then Click on Edit icon with Field Name "2D" "Location"
    Then Store date "2" days and "2" "years" from current date into "FutureDate2"
    Then Update details
      | Expected Date       |
      | SysData=>FutureDate2 |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Collapse "Details" for "2" Load

    #Step 11
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep | Sales Lead (Contact)    |
      | Second User        | Joe Philadelphia Eagles |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Second User        |
    Then Capture the current URL for "Cloned_Load2"

    #Step 12
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 13
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Go to "PayIQ Generated" Tab
    Then Capture the current URL for "PayIQ_Generated"
    Then Wait for "2" Seconds

    #Expected a
    Then Verify Table "Participant Matches" row count is equal or greater than "4"
    Then Verify table with "Participant Match ID" as "Participant Match-" does not have "Matched To" as "SysData=>2L1C"

    #Expected b
    Then Click on "Participant Match-" with "Participant Name" as "Second User (User)" and "Matched To" as "SysData=>1L"
    Then Wait for "2" Seconds
    Then Verify Details
      | Eligible Date |
      | 2             |
    Then Navigate to stored URL for "PayIQ_Generated"
    Then Go to "PayIQ Generated" Tab

    #Expected c
    Then Click on "Participant Match-" with "Participant Name" as "Second User (User)" and "Matched To" as "SysData=>1L1C"
    Then Wait for "2" Seconds
    Then Verify Details
      | Eligible Date |
      | 0             |

    #Expected d
    Then Navigate to stored URL for "PayIQ_Generated"
    Then Go to "PayIQ Generated" Tab
    Then Wait for "2" Seconds
    Then Click on "Participant Match-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "Matched To" as "SysData=>1L"
    Then Verify Details
      | Eligible Date |
      | 0             |

    Then Navigate to stored URL for "PayIQ_Generated"
    Then Go to "PayIQ Generated" Tab
    Then Wait for "2" Seconds
    Then Click on "Participant Match-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "Matched To" as "SysData=>1L1C"
    Then Verify Details
      | Eligible Date |
      | 0             |