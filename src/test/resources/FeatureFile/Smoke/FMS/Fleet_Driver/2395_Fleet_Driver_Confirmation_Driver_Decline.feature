Feature: 2395 - Fleet Driver Confirmation LWC- Driver Decline

  @Regression @Smoke @WEB @SingleCurrency @FMS @Fleet_Driver @Fleet_Driver_Confirmation @2395
  Scenario: 2395 - Fleet Driver Confirmation LWC- Driver Decline

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
  Then Wait for "5" Seconds
  #Step 4
    Then Fleet Management Console - Wait for Page Load
    Then Update details
         |Page|
         |Trip Planning|
  Then Wait for "4" Seconds

  #Step 5
    Then Scroll into Section "View - Fleet Load" for "Revenova Loads" on Fleet Console
    Then Scroll into Section "View - Fleet Load"
    Then Scroll down with "4" Times
    Then Select the Trip plan next to Load "1L"
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
  Then Wait for "8" Seconds
  Then Get Trip Plan ID and store as "Trip_Plan_ID"
  #Step 9
  Then Click on button with Title "Confirm Driver"
  Then Verify Message displaying as "The driver confirmation email was sent."
  Then Wait for Email to Receive On Email
  #Step 10
  Then Get "Trip Details" link from Email for Driver Trip Confirmation
  Then Launch browser and Navigate Link
  #Step 11 & Expected Result a
  Then Guest - Click on button with Title "Decline"
  Then Wait for "3" Seconds
  Then Guest - Verify Text displaying as "Driver Decline Reason"
  Then Guest - Verify Text displaying as "Driver Decline Message"
  Then Guest - Verify "Out of Hours" Checkbox is displaying
  Then Guest - Verify "Not Interested" Checkbox is displaying
  Then Guest - Verify "Location" Checkbox is displaying
  Then Guest - Verify "Can't Perform Additional Services" Checkbox is displaying
  Then Guest - Verify "Not Enough Pay" Checkbox is displaying
  Then Guest - Verify "Other" Checkbox is displaying
  Then Guest - Verify Text displaying as "Driver Decline Comments"
  Then Guest - Verify Button displaying as "Decline"
  Then Guest - Verify Button displaying as "Cancel"

    #Step 12 & Expected Result b
  Then Guest - "Cancel" Fleet Driver Confirmation
  Then Wait for "2" Seconds
  Then Guest - Verify text "Driver Decline Reason" not displaying on Page -
  Then Guest - Verify Text displaying as "Driver Confirmation"
  Then Guest - Verify text "Success" not displaying on Page -

   #Step 13 and Expected c
  Then Guest - Click on button with Title "Decline"
  Then Wait for "2" Seconds
  Then Guest - "Decline" Fleet Driver Confirmation
  Then Guest - Verify Text displaying as "Success - Driver Confirmation"
  Then Guest - Verify Text displaying as "This trip will not be dispatched to you."
  Then Close Guest Browser

  #Step 14 , 15 & 16
     Then Wait for "30" Seconds
  Then Click on button "Refresh" on Trip Plan
  Then Click on button with Title "Undo Changes and Refresh" -
  Then Wait for "1" Seconds
   #Step 17
     # Expected Result D
    Then Verify details for all Enabled fields
      |Status |
      |Pending|
    Then Verify "1" Segment details
    |Driver Confirmation Status|Status|
    |Declined                  |Pending|
  Then Verify Button with Title displaying as "Confirm Driver" -
  Then Verify Button with Title not displaying as "Dispatch" -
  Then Wait for "2" Seconds

  #Step 18
  Then Click on button "Trip Events" on Trip Plan
  Then Verify Text displaying as "Trip Events - Trip Plan-"

  #Step 19 & Expected Result e
   Then Verify details for all Enabled fields
    |Event Type          |Is Alert|Date|Event Detail                  |
    |Driver Declined Load|True    |0   |The driver declined this load.|
    Then Verify details for
     |Driver                                        |Driver Decline Reason|Driver Decline Comments|
    | QA Driver Two Thousand Four Hundred and Seven| NA                  |NA                     |

    Then Click on button "Close" on Trip Event
   Then Wait for "1" Seconds
   Then Click on button "Close" on Trip Plan

  Then Wait for "2" Seconds
  #Step 20
  Then Open "Loads" from App Launcher
  Then Open "1L" Created Load from List
  #Step 21
  Then Go to "Details" Tab
    #Expected f
    Then Scroll into Section "Team Assignments & Status"
    Then Verify Details
      |Load Status      |
      |Quotes Received  |
    Then Scroll into Section "Fleet Information"
    Then Verify Details
    |Fleet Load Status      |
    |Partially Planned      |
    Then Scroll into Section "Assigned Carrier Information"
    Then Verify Details
      |Carrier|Vendor|Carrier Service|
      | |            |               |
