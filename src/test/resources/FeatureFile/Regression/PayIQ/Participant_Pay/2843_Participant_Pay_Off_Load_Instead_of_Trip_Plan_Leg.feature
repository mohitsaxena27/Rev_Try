Feature:2843 - Participant- Pay Off Load Instead of Trip Plan Leg

  @API @Regression @PayIQ  @WEB @SingleCurrency @2843 @PayHeader
  Scenario: 2843 - Participant- Pay Off Load Instead of Trip Plan Leg

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Event" for "rtms__TripEvent__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
   #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Individual Load Revenue (Quoted)" from List

    #Step 2
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

    #Step 3
    Then Scroll Until Related List for "Participants"
    Then Click on "Participant-" with "Type" as "Driver" and "Name" as "Dave Fleet Carrier One 8"
    Then Wait for "2" Seconds
      #Step 4
    Then Click on "Clone" button
    Then Wait for "6" Seconds
    #Step 5
    Then Update details
      | Type   | Driver                   | Pay Off Load Instead of Trip Plan Leg |
      | Driver | Dave Fleet Carrier One 8 | True                                  |
   #Step 6
    Then Click on "SaveEdit" button
    Then Wait for "6" Seconds
    Then Capture the current URL for "Participant_1"
    Then Set Key "Participants_SFID_1" page Record Id with "rtms9__Participant__c"


    #Step 7:
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Participants"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Participants" section
    #Step 8
    Then Update details
      | Type        | Fleet Asset  | Pay Off Load Instead of Trip Plan Leg |
      | Fleet Asset | Tractor 1009 | True                                  |
    #Step 9
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds
    Then Get "Participant-" Name with "Name" as "Tractor 1009" and store in "Participant_Name_2"

    #Step 10
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer       | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova PayIQ | Truckload | Dry Van 53'    | NA            | NA                |
    Then Wait for "1" Seconds
    Then Update details
         |Fleet|
         |True |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Grapes      | 400    | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_1L"
    #Step 11
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date | Carrier Sales Rep | Customer Sales Rep |
      | Joe Revenova PayIQ   | 0                          | User User         | Test User0         |
    #Step 12
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds
    #Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "25"
    Then Add "Stop 1" "Customer Quote Items" "Lumper Pick Up" Accessorial with Unit as "Per Pound" Qty as "400" and Price "0.15"
    Then Update details
      |Payable| Status   |
      |True   | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 14. 15 & 16
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "8" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "4" Seconds
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 17
    Then Update "1" Segment details
      | Search       | Driver                   | Load |
      | Tractor 1008 | Dave Fleet Carrier One 8 | SysData=>1L   |
    Then Wait for "5" Seconds
    #Step 18
    Then Click on "Remove Leg" on "1" Leg
    Then Wait for "2" Seconds
      #Step 19
    Then Update "1" leg details
      | Due Out Time | Appointment Date | Appointment Start Time | Appointment End Time |
      | 8:00 AM      | 2                | 9:00 AM                | 9:00 AM              |
    #Step 20
    Then Click on button with Title "Add Segment Below"
    Then Wait for "2" Seconds
    #Step 21
    Then Update "2" Segment details
      | Search       | Driver                   |
      | Tractor 1009 | Dave Fleet Carrier One 8 |
    #Step 22
    Then Update "2" leg details
      | Start Type | Location                   | Due Out Date | Due Out Time | End Type | Location_2           | Appointment Date | Appointment Start Time | Appointment End Time |
      | Load Stop  | Stop 2D - Indianapolis Colts | 2            | 11:00 AM     | Location | Cincinnati Bengals | 3                | 7:00 AM                | 7:00 AM              |

    Then Wait for "2" Seconds
      #Step 23
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds
    #Step 24
    Then Update "1" leg details
      | Arrival Date | Departure Date |
      | 0            | 0              |
    #Step 25
    Then Update "2" leg details
      | Arrival Date | Departure Date |
      | 0            | 0              |
    #Step 26
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    Then Wait for "3" Seconds
    Then Click on button "Actuals" on Trip Plan
    Then Wait for "2" Seconds

    #Step 27
    Then Click on "Show Accessorials" on "1" Leg
    Then Wait for "2" Seconds
    #Step 28
    Then Update "1" leg details
      | Accessorial           | Unit       | Quantity | Unit Price | Payable |
      | Detention at Delivery | Fixed Cost | 2.00     | 5          | True    |
    Then Wait for "2" Seconds
#Step 29
    Then Click on "Show Accessorials" on "2" Leg
    Then Wait for "2" Seconds
    #Step 30
    Then Update "2" leg details
      | Accessorial              | Unit       | Quantity | Unit Price | Payable |
      | Vehicle Ordered Not Used | Fixed Cost | 1.00     | 7          | True    |
    #Step 31
    Then Click on button with Title "Save & Close"
    Then Verify Message displaying as "Save was successful."

    #Step 32
    Then Wait for "5" Seconds
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "10" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 33
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Dave Fleet Carrier One 8 (Driver)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderName"
        #Expected Result a
    Then Verify Assertion for "PayHeaderName_count" contains "1"
    
    #Step 34
    Then Search and Select "SysData=>PayHeaderName" from List

    #Step 35 and Expected Result b
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Set "PaidFrom" with "SysData=>Trip_Plan_ID" and " / Segment 1 / Leg 1"
    Then Set "PaidFrom2" with "SysData=>Trip_Plan_ID" and " / Segment 2 / Leg 2"
    Then Verify "Pay Details" Table Details
      | Pay Amount | Paid From Type   | Paid From       | Accessorial        |
      | USD 8.50   | Load             | SysData=>1L     |                          |
      | USD 10.00  | Trip Plan Leg    | SysData=>PaidFrom         | Detention at Delivery    |
      | USD 7.00   | Trip Plan Leg    |SysData=>PaidFrom2         | Vehicle Ordered Not Used |


    #Step 36
    Then Open "Pay Headers" from App Launcher
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1008 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderName_2"

    #Step 37
    Then Search and Select "SysData=>PayHeaderName_2" from List

    #Step 38 and Expected Result 3
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Verify "Pay Details" Table Details
      | Pay Amount | Paid From Type   | Paid From         | Accessorial        |
      | USD 10.00  | Trip Plan Leg    | SysData=>PaidFrom | Detention at Delivery    |


    #Step 39
    Then Open "Pay Headers" from App Launcher
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Tractor 1009 (Fleet Asset)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderName_3"

    #Step 40
    Then Search and Select "SysData=>PayHeaderName_3" from List

    #Step 41 and Expected Result 4
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "2" Seconds
    Then Verify "Pay Details" Table Details
      | Pay Amount | Paid From Type   | Paid From         |
      | USD 8.50   | Load    | SysData=>1L |
    Then Verify Text not displaying as "SysData=>PaidFrom"



    

