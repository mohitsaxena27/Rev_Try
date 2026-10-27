Feature:2790 - ClearOutUnapprovedPay Job - Pay Details

  @API @Regression @PayIQ @WEB @SingleCurrency @2790 @PayIQ_Logs
  Scenario: 2790 - ClearOutUnapprovedPay Job - Pay Details

    When Login into Salesforce
     #Pre-Condition
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program 1936" from List
    #Step 3
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Open|
    Then Capture the current URL for "PayIQ_Program_1"
    #step 3 -b
    Then Choose "New" button on "Participants" section
    Then Update details
      | Type | User       |
      | User | Test User1 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Get "Participant-" Name with "Name" as "Test User1" and store in "Participant_Name_2"

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type  | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA              | N             | N                 |
    Then Wait for "1" Seconds

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Kayaks      | 999    | NA           | NA       | NA             |

    #Step 2
    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"
    #Step 3
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep |Carrier Sales Rep|Sales Lead (Contact)|
      | Second User        |Test User1       |Joe Philadelphia Eagles|
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Verify Details
       |Customer Sales Rep|
       |Second User       |
    #Step4
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "3" Seconds

    #Step5
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "1" Seconds
    #Step 6
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep |Carrier Sales Rep|
      |                    |                 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    #6>b
    Then Scroll Until Related List for "Participant Matches"
    Then Verify "Participant Matches" count displaying as "3"
    Then Get "Participant Match-" Name with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and store in "Participant_Match_ID_1"
    Then Get "Participant Match-" Name with "Participant Name" as "Second User (User)" and store in "Participant_Match_ID_2"
    #Step 6>c
    Then Scroll Until Related List for "Pay Details"
    Then Verify "Pay Details" count displaying as "3"
    Then Get "Pay Detail-" Name with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and store in "Pay_Details_ID_1"
    Then Get "Pay Detail-" Name with "Participant Name" as "Second User (User)" and store in "Pay_Details_ID_2"

    #step 6 d
    Then Click on "Pay Header-" with "Participant Name" as "Second User (User)"
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Approved       |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Verify Details
      | Payment Status |
      | Approved       |

    #Step7
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #step8
    Then Navigate to stored URL for "Load_1L"
    #Step9 >a
    Then Scroll Until Related List for "Participant Matches"
    Then Get "Participant Match-" Name with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and store in "Participant_Match_ID_3"
    Then Get "Participant Match-" Name with "Participant Name" as "Second User (User)" and store in "Participant_Match_ID_4"

    #Expected b
    Then Verify Assertion for "Participant_Match_ID_1" not contains "{Participant_Match_ID_3}"
    Then Verify Assertion for "Participant_Match_ID_2" contains "{Participant_Match_ID_4}"
    #Step9 >b
    Then Get "Pay Detail-" Name with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and store in "Pay_Details_ID_3"
    Then Get "Pay Detail-" Name with "Participant Name" as "Second User (User)" and store in "Pay_Details_ID_4"

    #Expected c
    Then Verify Assertion for "Pay_Details_ID_3" not contains "{Pay_Details_ID_1}"
    Then Verify Assertion for "Pay_Details_ID_4" contains "{Pay_Details_ID_2}"

    #step10
    Then Navigate to stored URL for "Load_1L"
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Sales Lead (Contact) |
      |                    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #step10-b
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Header-" with "Participant Name" as "Second User (User)"
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Paid   |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Verify Details
      |Payment Status|
      |Paid          |

    #Step 11
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 12
    Then Navigate to stored URL for "Load_1L"

    #Step 13>a
    Then Scroll Until Related List for "Participant Matches"
    Then Get "Participant Match-" Name with "Participant Name" as "Second User (User)" and store in "Participant_Match_ID_5"

    #Expected d
    Then Verify Assertion for "Participant_Match_ID_2" contains "{Participant_Match_ID_5}"

      #Step13 >b
    Then Get "Pay Detail-" Name with "Participant Name" as "Second User (User)" and store in "Pay_Details_ID_5"

    #Expected e
    Then Verify Assertion for "Pay_Details_ID_5" contains "{Pay_Details_ID_2}"


