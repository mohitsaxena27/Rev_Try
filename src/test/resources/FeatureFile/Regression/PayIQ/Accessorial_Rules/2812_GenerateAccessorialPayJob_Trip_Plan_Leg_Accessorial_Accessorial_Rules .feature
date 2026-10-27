Feature:2812 - GenerateAccessorialPayJob- Trip Plan Leg Accessorial- Accessorial Rules

  @API @Regression @PayIQ  @WEB @SingleCurrency @2812
  Scenario: 2812 - GenerateAccessorialPayJob- Trip Plan Leg Accessorial- Accessorial Rules

    When Login into Salesforce

    #Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

   # Step 2
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

    #Step 3 &4
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Accessorial Rules" section
    Then Update details
    | Type                     | Accessorial         | Rule     | Amount |
    | Trip Plan Leg Accessorial| Detention at Pick Up| Flat Rate| 100    |
    Then Click on "SaveEdit" button
    #Step 5
    Then Verify Message displaying as "Accessorial Rule-"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Trip Plan Leg Accessorial" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "4" Seconds
    Then Capture the current URL for "Accessorial_Rules_1"
    Then Set Key "Accessorial_Rules_SFID_1" page Record Id with "rtms9__Accessorial_Rule__c"

   # Step 6 & 7
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

   # Step 8 & 9
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -
    Then Update "1" Segment details
      | Search       | Driver                    | Load |
      | Tractor 1008 | Dave Fleet Carrier One 8 | PIQ-0 |
    Then Wait for "5" Seconds

    #Step 10
    Then Update "1" leg details
      | Start Type | Location       |
      | Terminal   | Illinois Terminal |
    Then Update "1" leg details
      | Due Out Date | Due Out Time |
      | 1            | 8:00 AM      |
    Then Update "1" leg details
      |Appointment Date |Appointment Start Time |Appointment End Time|
      |2                | 9:00 AM               | 9:00 AM               |

    #Step 11
    Then Update "2" leg details
      | Due Out Date | Due Out Time  | Appointment Date |Appointment Start Time |Appointment End Time|
      | 2            |    11:00 AM      | 4               | 10:00 AM |            10:00 AM |
    Then Wait for "1" Seconds

    #Step 12
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"

    #Step 13 & 14
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "1" leg details
    | Accessorial              | Unit   | Quantity | Unit Price |Payable|
    | Vehicle Ordered Not Used | Per Day| 4.00   | 56.25      | True  |

    #Step 15 & 16
    Then Click on "Show Accessorials" on "2" Leg
    Then Wait for "2" Seconds
    Then Update "2" leg details
      | Accessorial             | Unit       | Quantity|Unit Price|Payable|
      | Detention at Pick Up    | --None--   |  1 |100       | True  |

   # Step 17 & 18
    Then Click on icon "utility:add" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Accessorial_2            | Unit_2 | Quantity_2| Unit Price_2|Payable_2|
      | Detention at Pick Up  | Per Stop| 2  |10| True       |
    Then Close Toast message
    #Step 19
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 20
    Then Update "1" leg details
    | Arrival Date |
    | 0 |

    #Step 21
    Then Update "2" leg details
      | Arrival Date |
      | 0 |

    #Step 22
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."

    #Step 23
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 24
    Then Open "Pay Headers" from App Launcher
    #Step 25
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

   # Step 26 and Expected result a
     Then Scroll Until Related List for "Pay Details"
     Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Set "PaidFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "PaidFrom2" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 2"
    Then Verify "Pay Details" Table Details
      | Pay Amount| Paid From           | Accessorial |
      | USD 225.00| SysData=>PaidFrom   |  Vehicle Ordered Not Used |
      | USD 20.00 | SysData=>PaidFrom   |  Detention at Pick Up |
      | USD 100.00| SysData=>PaidFrom2  |  Detention at Pick Up |


    #Step 27
    Then Navigate to stored URL for "PayIQ_Program_1"
     #Step 28
    Then Scroll Until Related List for "Participants"
    Then Click on link "Participants"
    Then Click on "Participant-" with "Type" as "Fleet Asset" and "Name" as "Tractor 1008"
    Then Capture the current URL for "Participants_1"

    #Step 29
    Then Scroll into Section with Title "Duration"
    Then Click on Edit icon on Label "Expiration Date"
  Then Update details
    |Expiration Date|
    |-1             |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Expiration Date|
      |-1             |

    #Step 30
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Invoiced)" from List

    #Step 31
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
    #Step 32

    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds
    Then Capture the current URL for "Participants_2"
 #Step 33
    Then Scroll into Section with Title "Duration"
    Then Click on Edit icon on Label "Expiration Date"
    Then Update details
      |Expiration Date|
      |-1             |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Expiration Date|
      |-1             |


    #Step 34 & 35
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 36 & 37
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan Start Date|
      |Tomorrow       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

    #Step 38
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

   #Step 39
    Then Update "1" leg details
      | Departure Date |
      | 0 |

    #Step 40
    Then Update "2" leg details
      | Departure Date |
      | 0 |

    #Step 41
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying with "Plan Trip Save was successful."
    Then Close All Toast message

    #Step 42
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"


   #Step 43
    Then Open "Pay Headers" from App Launcher

    #Step 44
   Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List


    #Step 45 and Expected result b
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Verify "Pay Details" Table Details
      | Pay Amount| Paid From               | Accessorial |
      | USD 225.00| SysData=>PaidFrom   |  Vehicle Ordered Not Used |
      | USD 20.00 | SysData=>PaidFrom   |  Detention at Pick Up |
      | USD 100.00| SysData=>PaidFrom2   |  Detention at Pick Up |

     #Step 46
    Then Open "Pay Headers" from App Launcher
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1008 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List

    #Step 48 and Expected result c
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Verify "Pay Details" Table Details
      | Pay Amount          | Paid From               | Accessorial |
      | USD 225.00              | SysData=>PaidFrom   |  Vehicle Ordered Not Used |
      | USD 20.00              | SysData=>PaidFrom   |  Detention at Pick Up |
      | USD 100.00              | SysData=>PaidFrom2   |  Detention at Pick Up |

#
    #Step 50
    Then Navigate to stored URL for "PayIQ_Program_2"

    #Step 51
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Accessorial Rules" section
    Then Update details
      |Type                     |Accessorial         |Rule                    |Amount|
      |Trip Plan Leg Accessorial|Detention at Pick Up|Amount Per Unit/Quantity|75.00|
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 52
    Then Verify Message displaying as "Accessorial Rule-"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Trip Plan Leg Accessorial" and "Accessorial" as "Detention at Pick Up"
    Then Wait for "4" Seconds
    Then Capture the current URL for "Accessorial_Rules_2"
    Then Set Key "Accessorial_Rules_SFID_2" page Record Id with "rtms9__Accessorial_Rule__c"


    #Step 53
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds

    Then Fleet Management Console - Wait for Page Load

    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 55 & 56
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan Start Date|
      |Tomorrow       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

   #Step 57 and Expected result d
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds
    Then Verify "1" leg details
      | Accessorial             | Unit    | Quantity| Unit Price|Payable|
      | Vehicle Ordered Not Used | Per Day| 4.00  |56.25| True       |
    Then Verify "1" leg details
      | Accessorial_2             | Unit_2    | Quantity_2| Unit Price_2|Payable_2|
      | Detention at Pick Up      | Per Stop| 2.00 |10.00| True       |

    #Step 58 and Expected result e
    Then Click on "Show Accessorials" on "2" Leg
    Then Wait for "2" Seconds
    Then Scroll down with "2" Times
    Then Verify "2" leg details
      | Accessorial             | Unit        | Quantity|Unit Price|Payable|
      | Detention at Pick Up    | --None--    |  1      |100       | True  |

   # Step 59
    Then Scroll down with "2" Times
    Then Click on icon "utility:clear" on "Accessorial_2"
    Then Wait for "2" Seconds

     #Step 60
    Then Click on icon "utility:add" on "1" Leg

    #Step 61 and expected result f
    Then Wait for "2" Seconds
    Then Update "1" leg details
    |Accessorial_2|
    |Detention at Pick Up|
    Then Verify Message displaying with "More than one accessorial rule was found, rate not auto-filled. Contact your PayIQ admin"
    Then Close All Toast message
    Then Verify "1" leg details
      | Unit Price_2|
      |             |
    Then Verify "1" leg details
      | Accessorial             | Unit    | Quantity| Unit Price|Payable|
      | Vehicle Ordered Not Used | Per Day| 4.00  |56.25| True       |

   #Step 62 & 63
    Then Click on button with Title "Close"

      #Step 64 & 65
    Then Navigate to stored URL for "Accessorial_Rules_2"
    Then Wait for "2" Seconds
   #Step 66
  Then Click on Edit icon on Label "Accessorial"
    Then Update details
          |Accessorial|
          |Detention at Delivery|
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Accessorial|
      |Detention at Delivery|



  #Step 67 & 68
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds

    Then Fleet Management Console - Wait for Page Load

    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "2" Seconds

    #Step 69 & 70
    Then Scroll into Section "View - Trip Plan"
    Then Scroll down with "4" Times
    Then Update details
      |Trip Plan Start Date|
      |Tomorrow       |
    Then Click on "Refresh" under "View - Trip Plan" Section
    Then Wait for "2" Seconds

    Then Click on "SysData=>Trip_Plan_ID" under "View - Trip Plan" Section
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Plan Trip - Trip Plan" -

  #Step 71
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds

  #Step 72 & 73 and Expected result g
    Then Click on icon "utility:clear" on "1" Leg
    Then Wait for "3" Seconds
    Then Click on icon "utility:add" on "1" Leg
    Then Wait for "2" Seconds
    Then Update "1" leg details
      | Accessorial_2          |
      | Detention at Delivery  |
    Then Verify "1" leg details
      | Accessorial_2             | Unit_2      | Quantity_2|Unit Price_2|Payable_2|
      | Detention at Delivery    |  --None-- |  1.00 |75.00      | True  |