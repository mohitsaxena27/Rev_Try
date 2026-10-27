Feature:2826 - GenerateAccessorialPayJob- Customer Quote Accessorial- Accessorial Rules

  @API @Regression @PayIQ @WEB @SingleCurrency @2826 @GenTierPayJob
  Scenario: 2826 - GenerateAccessorialPayJob- Customer Quote Accessorial- Accessorial Rules

    When Login into Salesforce

    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"

    # Step 1 & 2
    Then Open "PayIQ Programs" from App Launcher
    Then Wait for "2" Seconds
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

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

    # Step 3 & 4
    Then Scroll Until Related List for "Accessorial Rules"
    Then Click on "New" button on "Accessorial Rules" section
    Then Wait for "10" Seconds
    Then Update details
      | Type                       | Accessorial          | Rule      | Amount |
      | Customer Quote Accessorial | Detention at Pick Up | Flat Rate | 101    |
    Then Click on "Save" with Text
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Accessorial Rule"

    Then Click on "Accessorial Rule-" with "Type" as "Customer Quote Accessorial" and "Accessorial" as "Detention at Pick Up" and "Rule" as "Flat Rate" and "Amount" as "USD 101.00"
    Then Set Key "Accessorial_Rule_1" page Record Id with "rtms9__Accessorial_Rule__c"
    Then Wait for "2" Seconds
    Then Scroll into Section "Information"
    Then Get Details
      | Accessorial Rule ID |
      |                     |
    Then Set "Accessorial_Rule_ID_1" with "SysData=>Accessorial Rule ID"
    
    # Step 6
    Then Open "Loads" from App Launcher
    Then Recently Viewed to All
    Then Wait for "2" Seconds
    Then Select Customer Details and Load Type
      | Load_Num | Customer       | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova PayIQ | Truckload | Dry Van 53'    | N             | N                 |

    Then Wait for "1" Seconds

    Then Update details
      | Fleet |
      | true  |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Feathers    | 100    | NA           | NA       | NA             |

    Then Save Load With All details
    Then Wait for "2" Seconds
    Then Capture the current URL for "Load_1L"

    # Step 7 & 8
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date | Carrier Sales Rep | Customer Sales Rep |
      | Joe Revenova PayIQ   | 0                          | User User         | Test User0         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "6" Seconds

    # Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |

    Then Enter "Customer Quote Items" "Net Freight Charges" as "75"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "20"
    Then Wait for "2" Seconds
    Then Add "Stop 1" "Customer Quote Items" "Detention at Pick Up" Accessorial with Unit as "Per Pound" Qty as "100" and Price "0.50"
    Then Update details
      | Payable |
      | True    |
    Then "Save" Customer Quotes
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Save was successful."

    # Step 10
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load

    # Step 11
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "5" Seconds

    # Step 12
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    # Step 13
    Then Update "1" Segment details
      | Driver                   | Load        |
      | Dave Fleet Carrier One 8 | SysData=>1L |

    # Step 14
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds

    # Step 15
    Then Update details
      | Due Out Date | Due Out Time | Appointment Date | Appointment Start Time | Appointment End Time |
      | 1            | 11:00 AM     | 2                | 10:00 AM               | 10:00 AM             |

    # Step 16
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds

    # Step 17
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    # Step 18
    Then Update "1" leg details
      | Arrival Date |
      | 0            |
    Then Wait for "3" Seconds
    #Step 19
    Then Click on button with Title "Save & Close"
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Plan Trip Save was successful."

    # Step 20
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"

    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 21
    Then Open "Pay Headers" from App Launcher
    Then Wait for "3" Seconds

    # Step 22
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ (Contact)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Capture the current URL for "PayHeader_1"
    Then Wait for "3" Seconds
#    Then Set Key "Pay_Header_SFID_1" page Record Id with "rtms9__Pay_Header__c"

    # Step 23
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Click on "Pay Detail-" with "Accessorial" as "Detention at Pick Up" and "Paid From" as "SysData=>1L"
    Then Wait for "2" Seconds

    # Expected Result a
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount |
      | USD 101.00 |

    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial          |
      | Detention at Pick Up |

    Then Scroll into Section "Pay Rule"
    Then Verify Text not displaying as "Calculation Tier"
    Then Verify Details
      | Accessorial Rule               |
      | SysData=>Accessorial_Rule_ID_1 |
#    Then Set Key "PayDetails1" page Record Id with "rtms9__Pay_Detail__c"

    # Step 24
    Then Navigate to stored URL for "PayIQ_Program_1"

    # Step 25
    Then Scroll Until Related List for "Accessorial Rules"
    Then Click on "New" button on "Accessorial Rules" section
    Then Wait for "5" Seconds

    # Step 26
    Then Update details
      | PayIQ Program                                 | Type                      | Accessorial          | Rule                     | Amount |
      | PayIQProgram Individual Load Revenue (Quoted) | Trip Plan Leg Accessorial | Detention at Pick Up | Amount Per Unit/Quantity | 0.75   |

    # Step 27
    Then Click on "Save" with Text
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Accessorial Rule"

    Then Click on "Accessorial Rule-" with "Type" as "Trip Plan Leg Accessorial" and "Accessorial" as "Detention at Pick Up" and "Rule" as "Amount Per Unit/Quantity" and "Amount" as "USD 0.75"
    Then Set Key "Accessorial_Rule_2" page Record Id with "rtms9__Accessorial_Rule__c"
    Then Wait for "2" Seconds
    Then Scroll into Section "Information"
    Then Get Details
      | Accessorial Rule ID |
      |                     |
    Then Set "Accessorial_Rule_ID_2" with "SysData=>Accessorial Rule ID"

    # Step 28 - 34
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load

    # Step 29
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "5" Seconds

    # Step 30 & 31
    Then Scroll into Section "View - Fleet Load" for "Revenova Loads" on Fleet Console
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"

    # Step 32
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds

    # Step 33
    Then Update "1" leg details
      | Accessorial          | Unit      | Quantity | Unit Price | Payable |
      | Detention at Pick Up | Per Pound | 100.00   | 0.75       | True    |

    # Step 34
    Then Click on button with Title "Save & Close"
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Plan Trip Save was successful."

    # Step 35
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"

    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 36
    Then Open "Pay Headers" from App Launcher
    Then Recently Viewed to All Pending
    Then Wait for "3" Seconds

    # Step 37
    Then Navigate to stored URL for "PayHeader_1"
    Then Wait for "3" Seconds

    # Step 38
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "3" Times
    Then Click on "Pay Detail-" with "Accessorial" as "Detention at Pick Up" and "Paid From" as "SysData=>1L"
    Then Wait for "2" Seconds

    # Expected Result b
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount |
      | USD 101.00 |

    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial          |
      | Detention at Pick Up |

    Then Scroll into Section "Pay Rule"
    Then Verify Text not displaying as "Calculation Tier"
    Then Verify Details
      | Accessorial Rule               |
      | SysData=>Accessorial_Rule_ID_1 |

    # Step 39
    Then Open "Pay Headers" from App Launcher
    Then Recently Viewed to All Pending
    Then Wait for "3" Seconds

    # Step 40
    Then Click on "Pay Header-" with "Participant Name" as "Dave Fleet Carrier One 8 (Driver)" and "Payroll Description" as "SysData=>Current_Month_Range"
    Then Wait for "2" Seconds

    # Step 41
    Then Scroll Until Related List for "Pay Details"
    Then Scroll down with "2" Times
    Then Click on "Pay Detail-" with "Type" as "Detention at Pick Up" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "2" Seconds

    # Expected Result c
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount |
      | USD 75.00  |

    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial          |
      | Detention at Pick Up |

    # Step 42
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "3" Seconds

    # Step 43 - Lock Load
    Then Click on Edit icon on Label "PayIQ Locked"
    Then Update details
      | PayIQ Locked |
      | true         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds

    # Step 44
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter "Customer Quote Items" "Detention at Pick Up" as "0.60"

    Then "Save" Customer Quotes
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Save was successful."

    # Step 45
    Then Open "PayIQ Programs" from App Launcher
    Then Wait for "2" Seconds
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List
    Then Wait for "3" Seconds

    # Step 46 & 47
    Then Scroll Until Related List for "Accessorial Rules"
    Then Click on "Accessorial Rule-" with "Type" as "Customer Quote Accessorial" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "2" Seconds

    Then Scroll into Section "Information"
    Then Click on Edit icon on Label "Amount"
    Then Update details
      | Amount |
      | 102    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    # Step 48
    Then Click on Partial Link Text "PayIQProgram Individual Load Revenue (Quoted)" on Page
    Then Wait for "2" Seconds

    # Step 49 & 50
    Then Scroll Until Related List for "Accessorial Rules"
    Then Click on "Accessorial Rule-" with "Type" as "Trip Plan Leg Accessorial" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "2" Seconds

    Then Scroll into Section "Information"
    Then Click on Edit icon on Label "Amount"
    Then Update details
      | Amount |
      | 0.85   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    # Step 51
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"

    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    # Step 52 & 53
    Then Open "Pay Headers" from App Launcher
    Then Recently Viewed to All Pending
    Then Wait for "3" Seconds

    Then Click on "Pay Header-" with "Participant Name" as "Joe Revenova PayIQ (Contact)" and "Payroll Description" as "SysData=>Current_Month_Range"
    Then Wait for "2" Seconds

    # Step 54
    Then Scroll Until Related List for "Pay Details"
    Then Wait for "2" Seconds

    Then Click on "Pay Detail-" with "Type" as "Customer Quote Accessorial: Detention at Pick Up" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "2" Seconds

    # Expected Result d
    Then Scroll into Section "Information"
    Then Verify Details
      | Pay Amount |
      | USD 101.00 |

    Then Scroll into Section "Accessorial"
    Then Verify Details
      | Accessorial          |
      | Detention at Pick Up |