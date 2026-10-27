Feature: 608 - Carrier Guest LWC- Simple Tender: Decline Functionality

  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Headed @Carrier_Guest @608
  Scenario: 608 - Carrier Guest LWC- Simple Tender: Decline Functionality

    When Login into Salesforce
    #Step1
    Then Run "QueuedTransactionJob" Job
    #Step 2
     #Load1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Boston Beans |Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza|  4             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000  |NA          |NA       |NA       |
    #Step 3
    Then Save Load With All details

     #Step4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Tender Email" -
    Then Click on "Legend" Link Text "Tender" on Page -
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | Tendered    |
    Then Refresh current Page
    Then Set "Email_Subject" with "Load Tender for SysData=>1L"
    Then Wait for Email to Receive On Email

    #Step 5
    Then Get "Decline Quote" link from Email for Subject "SysData=>Email_Subject"
    Then Launch browser and Navigate Link
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds

    #Step 6 & Expected Result a
    Then Guest - Verify Icon "standard:poll" is displaying with background color "BrightBlue"
    Then Guest - Verify Text displaying as "Carrier Tender"
    Then Guest - Verify Text displaying as "Indicate your acceptance of this load by clicking on the Accept button. Or if you are unable to accommodate this shipment, please click on the Decline button."
    Then Guest - Verify "White" Color with "SteelBlue" Text of "Decline" Button is "Enabled"
    Then Guest - Verify "SteelBlue" Color with "White" Text of "Accept" Button is "Enabled"
    #Step 6.a
    Then Guest - Click on button with Text "Decline"
    Then Set "TenderDateTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "2" Seconds
    #Expected Result b
    Then Guest - Verify Icon "standard:poll" is displaying with background color "BrightBlue"
    Then Guest - Verify Text displaying as "Carrier Tender"
    Then Guest - Verify Text displaying as "Carrier Load Confirm Decline Message"
    Then Close Guest Browser
    Then Wait for "80" Seconds

    #Step 7
    #Expected Result c
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | Declined    |

    #Step 8
    Then Go to "Details" Tab
    #Expected Result d
    Then Verify details for
         |Carrier Sales Rep|
         |User User|
    Then Scroll into Section "Assigned Carrier Information"
    Then Get Details
         |Tender Accepted Date|
         |                    |
    #Expected e
    Then Verify Assertion for "SysData=>Tender Accepted Date" contains ""
    
    #Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Click on Carrier Quote from FQA Page
    Then Wait for "2" Seconds
    Then Go to "Details" Tab on Next to "Pricing" Tab

    #Expected f
    Then Verify Label Checkbox
         |Accepted|
         |False   |
    Then Scroll into Section "Auto-Engagement"
    Then Verify Details
         |Tender Status|
         |Rejected     |