Feature:2896 - ClearOutUnapprovedPay Job - PayIQ Locked

  @API @Regression @PayIQ @WEB @SingleCurrency @2896 @PayIQ_Locked
  Scenario:2896 - ClearOutUnapprovedPay Job - PayIQ Locked

    When Login into Salesforce

    #---------------------------------------------------------
    # Pre-Condition Step 1-3 : Open Program 1936 and Configure
    #---------------------------------------------------------

    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "PayIQ Program 1936" from Search List

    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |

    Then Capture the current URL for "PayIQ_Program_1"

    Then Scroll Until Related List for "Participants"
    Then Click on "New" button on "Participants" section
    Then Update details
      | Type | User       |
      | User | Test User1 |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Scroll Until Related List for "Participants"
    Then Scroll down with "3" Times
    Then Wait for "2" Seconds
    Then Click on "Participant-" with "Name" as "Test User1"
    Then Wait for "2" Seconds
    Then Verify Details
      | Type | User       |
      | User | Test User1 |
    Then Set Key "Participant_SFID" page Record Id with "rtms9__Participant__c"
    #---------------------------------------------------------
    # Step - 1 & 2 : Create Load
    #---------------------------------------------------------
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Kayaks      | 999    | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load_1L"

    #---------------------------------------------------------
    # Step - 3 : Update PayIQ Fields
    #---------------------------------------------------------
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)    | Customer Sales Rep | Carrier Sales Rep |
      | Joe Philadelphia Eagles | Second User        | Test User1        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact)    |
      | Joe Philadelphia Eagles |

    #---------------------------------------------------------
    # Step - 4 : Execute PayIQ Jobs
    #---------------------------------------------------------
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #---------------------------------------------------------
    # Step - 5 : Search and Select Loads
    #---------------------------------------------------------
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds

    #---------------------------------------------------------
    # Step - 6.a) : Lock Load
    #---------------------------------------------------------
    Then Go to "PayIQ" Tab
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "PayIQ Locked"
    Then Update details
      | PayIQ Locked |
      | True         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds
    Then Verify Details
      | PayIQ Locked |
      | True         |

    #---------------------------------------------------------
    # Step - 6b.i & ii) : Participant Match - Joe Philadelphia Eagles
    #---------------------------------------------------------
    Then Scroll Until Related List for "Participant Matches"
    Then Click on "Participant Match-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)"
    Then Wait for "2" Seconds
    Then Get Details
      | Participant Match ID |
      |                      |
    Then Set "PM_Joe" with "SysData=>Participant Match ID"
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    #---------------------------------------------------------
    # Step - 6b.iii) : Participant Match - Second User
    #---------------------------------------------------------
    Then Scroll Until Related List for "Participant Matches"
    Then Scroll down with "3" Times
    Then View All Records for "Participant Matches"
    Then Wait for "2" Seconds
    Then Zoom Current Screen by "70"
    Then Click on "Participant Match-" with "Participant Name" as "Second User (User)"
    Then Wait for "2" Seconds
    Then Get Details
      | Participant Match ID |
      |                      |
    Then Set "PM_SecondUser" with "SysData=>Participant Match ID"
    Then Navigate to stored URL for "Load_1L"

    #---------------------------------------------------------
    # Step - 6b.iv) :Participant Match - Test User1
    #---------------------------------------------------------
    Then Scroll Until Related List for "Participant Matches"
    Then Scroll down with "3" Times
    Then Wait for "2" Seconds
    Then Click on "Participant Match-" with "Participant Name" as "Test User1 (User)"
    Then Wait for "2" Seconds
    Then Get Details
      | Participant Match ID |
      |                      |
    Then Set "PM_TestUser1" with "SysData=>Participant Match ID"
    Then Navigate to stored URL for "Load_1L"

    #---------------------------------------------------------
    # Step - 6c.i & ii) :Joe Philadelphia Eagles Pay Detail
    #---------------------------------------------------------
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)"
    Then Wait for "2" Seconds
    Then Get Details
      | Pay Detail ID |
      |               |
    Then Set "PD_Joe" with "SysData=>Pay Detail ID"
    Then Navigate to stored URL for "Load_1L"

    #---------------------------------------------------------
    # Step - 6c.iii) : Second User Pay Detail
    #---------------------------------------------------------
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then View All Records for "Pay Details"
    Then Wait for "2" Seconds
    Then Zoom Current Screen by "70"
    Then Click on "Pay Detail-" with "Participant Name" as "Second User (User)"
    Then Wait for "2" Seconds
    Then Get Details
      | Pay Detail ID |
      |               |
    Then Set "PD_SecondUser" with "SysData=>Pay Detail ID"
    Then Navigate to stored URL for "Load_1L"

    #---------------------------------------------------------
    # Step - 6c.iv) : Test User1 Pay Detail
    #---------------------------------------------------------
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Participant Name" as "Test User1 (User)"
    Then Wait for "2" Seconds
    Then Get Details
      | Pay Detail ID |
      |               |
    Then Set "PD_TestUser1" with "SysData=>Pay Detail ID"
    Then Navigate to stored URL for "Load_1L"

    #---------------------------------------------------------
    # Step - 7 : Execute PayIQ Jobs Again
    #---------------------------------------------------------

    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #---------------------------------------------------------
    # Step - 8 : Search and Select Loads
    #---------------------------------------------------------
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Go to "PayIQ" Tab
    #---------------------------------------------------------
    # Step - 9 : Open Participant Match Related List
    #---------------------------------------------------------
    Then Scroll Until Related List for "Participant Matches"
#    Then Click on link "Participant Matches"
#    Then Scroll down with "3" Times
#    Then View All Records for "Participant Matches"
#    Then Wait for "2" Seconds
#    Then Zoom Current Screen by "70"
    Then Wait for "1" Seconds
    #---------------------------------------------------------
    # Expected result a
    #---------------------------------------------------------

    Then Get "Participant Match-" Name with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and store in "Participant_Match1"
    Then Get "Participant Match-" Name with "Participant Name" as "Test User1 (User)" and store in "Participant_Match2"
    Then Get "Participant Match-" Name with "Participant Name" as "Second User (User)" and store in "Participant_Match3"
    Then Verify Assertion for "Participant_Match1" contains "SysData=>PM_Joe"
    Then Verify Assertion for "Participant_Match2" contains "SysData=>PM_TestUser1"
    Then Verify Assertion for "Participant_Match3" contains "SysData=>PM_SecondUser"

#    Then Verify "Participant Matches" Table Details
#      | Participant Match ID   | Participant Name                  |
#      | SysData=>PM_Joe        | Joe Philadelphia Eagles (Contact) |
#      | SysData=>PM_TestUser1  | Test User1 (User)                 |
#      | SysData=>PM_SecondUser | Second User (User)                |
    #---------------------------------------------------------
    # Expected result b
    #---------------------------------------------------------
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
#    Then View All Records for "Pay Details"
#    Then Wait for "2" Seconds
#    Then Zoom Current Screen by "70"
    Then Wait for "2" Seconds
#    Then Verify "Pay Details" Table Details
#      | Pay Detail ID          | Participant Match      | Participant Name                  |
#      | SysData=>PD_TestUser1  | SysData=>PM_TestUser1  | Test User1 (User)                 |
#      | SysData=>PD_SecondUser | SysData=>PM_SecondUser | Second User (User)                |
#      | SysData=>PD_Joe        | SysData=>PM_Joe        | Joe Philadelphia Eagles (Contact) |
#
#    Then Get "Pay Detail-" Name with "Participant Name" as "Test User1 (User)" and "Participant Match" as "SysData=>PM_TestUser1" and store in "Participant_Match3"
#    Then Get "Pay Detail-" Name with "Participant Name" as "Second User (User)" and store in "Participant_Match4"
#    Then Get "Pay Detail-" Name with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and store in "Participant_Match5"

    Then Click on "Pay Detail-" with "Participant Name" as "Test User1 (User)" and "Participant Match" as "SysData=>PM_TestUser1"
    Then Wait for '2' Seconds
    Then Verify Details
      | Pay Detail ID          | Participant Match      | Participant Name |
      | SysData=>PD_TestUser1  | SysData=>PM_TestUser1  | Test User1 (User)|

    Then Navigate Back & Refresh
    Then Click on "Pay Detail-" with "Participant Name" as "Second User (User)" and "Participant Match" as "SysData=>PM_SecondUser"
    Then Wait for '2' Seconds
    Then Verify Details
      | Pay Detail ID          | Participant Match      | Participant Name |
      | SysData=>PD_SecondUser | SysData=>PM_SecondUser | Second User (User)|

    Then Navigate Back & Refresh
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "Participant Match" as "SysData=>PM_Joe"
    Then Wait for '2' Seconds
    Then Verify Details
      | Pay Detail ID          | Participant Match      | Participant Name                  |
      | SysData=>PD_Joe        | SysData=>PM_Joe        | Joe Philadelphia Eagles (Contact) |

