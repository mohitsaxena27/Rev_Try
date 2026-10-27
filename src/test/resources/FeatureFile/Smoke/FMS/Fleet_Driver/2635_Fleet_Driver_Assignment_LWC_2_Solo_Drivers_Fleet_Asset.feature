Feature: 2635 - Fleet Driver Assignment LWC - 2 Solo Drivers + Fleet Asset

  @Regression @Smoke @WEB @SingleCurrency @FMS @Fleet_Driver @Fleet_Driver_Assignment @2635
  Scenario: 2635 - Fleet Driver Assignment LWC - 2 Solo Drivers + Fleet Asset

    When Login into Salesforce
    Then Delete All Records with name "Assignment" for "rtms__DriverAssignment__c"

#     Step1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "2" Seconds
   #Step 2
    Then Click on button with Title "Driver Assignment"
    Then Update Lightning Layout Item details
      | Fleet Asset  | Driver                    | Driver_2                  | Date | Time     | Date_2 | Time_2  |
      | Chassis 1022 | Dave Fleet Carrier One 22 | Dave Fleet Carrier One 23 | 0    | 10:00 AM | 7      | 9:30 PM |

    Then Click on button with Title "Save"

    # Expected a
    Then Verify Message displaying with Text "Driver assignment was successful."

    # Step 3
    Then Click on button with Title "Driver Assignment"
    Then Update Lightning Layout Item details
      | Driver                    |
      | Dave Fleet Carrier One 22 |
    Then Wait for "1" Seconds

    #Expected b
    Then Verify Recent Driver Assignment
         |Fleet Asset|Driver                    |Driver Type|Start Date|End Date|
         |Chassis 1022|Dave Fleet Carrier One 22|Solo       |0>10:00:00 AM|7>9:30:00 PM|
    Then Verify Title displaying as "Delete"
      #Step 3.a
       Then Update Lightning Layout Item details
      | Driver_2                    |
      | Dave Fleet Carrier One 23 |

    Then Wait for "1" Seconds
    #Expected c
    Then Verify Recent Driver Assignment
      |Fleet Asset|Driver                    |Driver Type|Start Date|End Date|
      |Chassis 1022|Dave Fleet Carrier One 22|Solo       |0>10:00:00 AM|7>9:30:00 PM|
      |Chassis 1022|Dave Fleet Carrier One 23|Solo       |0>10:00:00 AM|7>9:30:00 PM|
    Then Verify Title displaying as "Delete"

    Then Click on button with Title "Cancel"
    Then Wait for "2" Seconds
    # Step 4
    Then Click on button with Title "Driver Assignment"
    Then Update details
      | Fleet Asset  |
      | Chassis 1022 |
    Then Wait for "1" Seconds
 #Expected d
    Then Verify Recent Driver Assignment
      |Fleet Asset|Driver                    |Driver Type|Start Date|End Date|
      |Chassis 1022|Dave Fleet Carrier One 22|Solo       |0>10:00:00 AM|7>9:30:00 PM|
      |Chassis 1022|Dave Fleet Carrier One 23|Solo       |0>10:00:00 AM|7>9:30:00 PM|
    Then Verify Title displaying as "Delete"

    Then Click on button with Title "Cancel"
    Then Wait for "1" Seconds

    # Step 5
    Then Open "Drivers" from App Launcher
    Then Search and Select "Dave Fleet Carrier One 22" from List
   # Expected e
    Then Verify Details
         |Status|
         |Seated|
    Then Capture the current URL for "Driver_1"

   # Expected f
    Then Go to "Driver Assignments" Tab
    Then Wait for "2" Seconds
    Then Set "StartDate" with "Date(M/d/yyyy)=>0" and ", 10:00 AM"
    Then Set "EndDate" with "Date(M/d/yyyy)=>7" and ", 9:30 PM"
    Then Verify Table With Header
         |Name|Fleet Asset|Start Date|End Date|
         |Assignment|Chassis 1022|SysData=>StartDate|SysData=>EndDate|

   # Step6
    Then Open "Drivers" from App Launcher
    Then Search and Select "Dave Fleet Carrier One 23" from List
   # Expected g
    Then Verify Details
      |Status|
      |Seated|
    Then Capture the current URL for "Driver_2"

   # Expected h
    Then Go to "Driver Assignments" Tab
    Then Wait for "2" Seconds
    Then Verify Table With Header
      |Name|Fleet Asset|Start Date|End Date|
      |Assignment|Chassis 1022|SysData=>StartDate|SysData=>EndDate|
    Then Verify Title displaying as "Chassis 1022"

  # Step 7
    Then Click on "Chassis 1022" with Text
    Then Go to "Driver Assignments" Tab
    Then Wait for "2" Seconds

  # Expected i
    Then Verify Table With Header
      |Name|Driver|Start Date|End Date|
      |Assignment|Dave Fleet Carrier One 22|SysData=>StartDate|SysData=>EndDate|
   Then Verify Table With Header
       |Name|Driver|Start Date|End Date|
       |Assignment|Dave Fleet Carrier One 23|SysData=>StartDate|SysData=>EndDate|
   Then Capture the current URL for "Assets_1"

   # Step 8
   Then Click on Records having "Name" contains "Assignment" with index "1"
   Then Wait for "1" Seconds
   Then Click on button with Title "Edit End Date"
   Then Update details
        |Date_2|
        |      |
  Then Click on "SaveEdit" button
  Then Wait for "1" Seconds
  Then Verify Details
       |End Date|
       |       |
  Then Navigate Browser Back

  # Step 8.1
    Then Click on Records having "Name" contains "Assignment" with index "2"
    Then Wait for "1" Seconds
    Then Click on button with Title "Edit End Date"
    Then Update details
      |Date_2|
      |      |
    Then Click on "SaveEdit" button
    Then Wait for "1" Seconds
    Then Verify Details
      |End Date|
      |       |

  # Step 9
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "2" Seconds
    Then Click on button with Title "Driver Assignment"
    Then Update Lightning Layout Item details
      | Driver                    |
      | Dave Fleet Carrier One 22 |
    Then Wait for "1" Seconds
    #Expected j
    Then Verify Recent Driver Assignment
         |Fleet Asset|Driver                    |Driver Type|Start Date|End Date|
         |Chassis 1022|Dave Fleet Carrier One 22|Solo       |0>10:00:00 AM|NA|
    Then Verify Title displaying as "Delete"
    Then Verify Title displaying as "Unassign"
       Then Update Lightning Layout Item details
      | Driver_2                    |
      | Dave Fleet Carrier One 23 |
    Then Wait for "1" Seconds

    #Expected k
    Then Verify Recent Driver Assignment
      |Fleet Asset|Driver                    |Driver Type|Start Date|End Date|
      |Chassis 1022|Dave Fleet Carrier One 22|Solo       |0>10:00:00 AM|NA|
      |Chassis 1022|Dave Fleet Carrier One 23|Solo       |0>10:00:00 AM|NA|
    Then Verify Title displaying as "Delete"
    Then Verify Title displaying as "Unassign"

  # Step 9.c & Expected Result l
    Then Click on button with Title "Unassign"
    Then Set "CurrentTimeEndDate1" with "M/d/yyyy, h:mm:ss a" Format and "America/Chicago" Timezone
    Then Verify Message displaying with Text "Driver unassignment was successful."
    Then Wait for "1" Seconds
    Then Click on button with Title "Unassign"
    Then Set "CurrentTimeEndDate2" with "M/d/yyyy, h:mm:ss a" Format and "America/Chicago" Timezone
    Then Verify Message displaying with Text "Driver unassignment was successful."
    Then Wait for "1" Seconds
    Then Verify Recent Driver Assignment
      |Fleet Asset|Driver                    |Driver Type|Start Date|End Date|
      |Chassis 1022|Dave Fleet Carrier One 22|Solo       |0>10:00:00 AM|SysData=>CurrentTimeEndDate1|
      |Chassis 1022|Dave Fleet Carrier One 23|Solo       |0>10:00:00 AM|SysData=>CurrentTimeEndDate2|

     # Step 10
    Then Navigate to stored URL for "Driver_1"
   # Expected m
    Then Verify Details
      |Status|
      |Available|

    # Step 11
    Then Navigate to stored URL for "Driver_2"
   # Expected n
    Then Verify Details
      |Status|
      |Available|

    #  Step 12
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "5" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "2" Seconds
    Then Click on button with Title "Driver Assignment"
    Then Update Lightning Layout Item details
      | Driver                    |
      | Dave Fleet Carrier One 22 |
    Then Wait for "1" Seconds
       Then Update Lightning Layout Item details
      | Driver_2                    |
      | Dave Fleet Carrier One 23 |

    Then Wait for "2" Seconds
    Then Click on button with Title "Delete"
    Then Click on "OK" with Text -
    Then Verify Message displaying with Text "Delete was successful"
    Then Wait for "1" Seconds
    Then Click on button with Title "Delete"
    Then Wait for "2" Seconds
    Then Click on "OK" with Text -
    Then Verify Message displaying with Text "Delete was successful."
    Then Wait for "1" Seconds
   
     # Step 13
    Then Navigate to stored URL for "Driver_1"
    Then Go to "Driver Assignments" Tab
    Then Wait for "2" Seconds
    #Expected p
    Then Verify No Records Available with "Driver Assignments"

    # Step 14
    Then Navigate to stored URL for "Driver_2"
    Then Go to "Driver Assignments" Tab
    Then Wait for "2" Seconds
    #Expected q
    Then Verify No Records Available with "Driver Assignments"

     # Step 15
    Then Navigate to stored URL for "Assets_1"
    Then Go to "Driver Assignments" Tab
    Then Wait for "2" Seconds
    #Expected r
    Then Verify No Records Available with "Driver Assignments"


    