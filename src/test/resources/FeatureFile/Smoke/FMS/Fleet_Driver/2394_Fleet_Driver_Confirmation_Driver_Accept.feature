Feature: 2394 - Fleet Driver Confirmation LWC- Driver Accept

  @Regression @Smoke @WEB @SingleCurrency @FMS @Fleet_Driver @Fleet_Driver_Confirmation @2394
   Scenario: 2394 - Fleet Driver Confirmation LWC- Driver Accept

    When Login into Salesforce
    #Step1
     #Load1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Chicago Pizza |Truckload | Dry Van 53     | Y             | N                 |
    Then Update details
      |Fleet|
      |True |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830            | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | 1445-1530       | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 15000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    #Step 2
    Then Save Load With All details

     #Step3
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "10" Seconds
    Then Fleet Management Console - Wait for Page Load
    #Step 4
    Then Update details
    |Page|
    |Trip Planning|
    Then Wait for "4" Seconds

    #Step 5
    Then Scroll into Section "View - Fleet Load" for "Revenova Loads" on Fleet Console
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
#    Then Select the Trip plan next to "L-334"
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    #Step 6
    Then Update "1" Segment details
    |Search                                |Driver|
    |Tractor Two Thousand Four Hundred and Seven|QA Driver Two Thousand Four Hundred and Seven|
   #Step 7
    Then Update "1" leg details
    |Location|
    |Revenova HQ|
    Then Update "1" leg details
    |Due Out Date|Due Out Time|
    |0           |1:15 AM     |

    Then Update "2" leg details
      |Due Out Time|
      |12:30 PM    |
    #Step 8
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "5" Seconds
    Then Get Trip Plan ID and store as "Trip_Plan_ID"
    #Step 9
    Then Click on button with Title "Confirm Driver"
    Then Verify Message displaying as "The driver confirmation email was sent."
    #Expected Result a
    Then Verify "1" Segment Driver Confirmation Status as "Requested"
    Then Verify "1" Segment Status as "Pending"
    #Wait for receive Email
    Then Wait for Email to Receive On Email
    #Step 10
    Then Get "Trip Details" link from Email for Driver Trip Confirmation
    Then Launch browser and Navigate Link
    #Step 11 & Expected Result b
    Then Guest - Click on button with Title "Accept"
    Then Wait for "1" Seconds
    Then Guest - Verify Text displaying as "Success - Driver Confirmation"
    Then Guest - Verify Text displaying as "This trip will be dispatched to you."
    Then Close Guest Browser
    Then Wait for "20" Seconds
    #Step 12 , 13 & 14
    Then Click on button "Refresh" on Trip Plan
    Then Click on button with Title "Undo Changes and Refresh" -
    Then Wait for "5" Seconds
     #Step 15 #Expected Result c
    Then Verify "1" Segment Driver Confirmation Status as "Accepted"
    Then Verify "1" Segment Status as "Configured"
    Then Verify Button with Title not displaying as "Confirm Driver" -
    Then Verify Button with Title displaying as "Dispatch" -
    Then Click on button "Close" on Trip Plan

    Then Wait for "2" Seconds
    #Step 16
    Then Open "Loads" from App Launcher
    Then Open "1L" Created Load from List
    #Step 17
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    #Expected d
    Then Verify Details
      |Load Status  |
      |Assigned       |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
      |Fleet Load Status  |
      |Planned      |
