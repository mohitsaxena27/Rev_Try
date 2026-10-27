Feature: 609 - Carrier Guest LWC- Detailed Tender: Decline Functionality


  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Headed @Carrier_Guest @609
  Scenario: 609 - Carrier Guest LWC- Detailed Tender: Decline Functionality


    When Login into Salesforce
    #Step1
    Then Run "QueuedTransactionJob" Job
    #Step 2
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Edit Object" from Setup Icon
    Then Switch Window by index "1"
    Then Capture the current URL for "Load_Setting"
    Then Click on "Field Sets" with Text
    Then Open Field Sets "TMS30" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Delete Fields if any available with Field Set
    Then Add the Following Fields in this Order
    |Load Number|
    |Load Number|
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window
    
   # Step 3
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
    # Expected Result a
    Then Guest - Verify Icon "standard:planogram" is displaying with background color "BrightBlue"
    Then Guest - Verify Icon "custom:custom98" is displaying with background color "Earth Yellow"
    Then Guest - Verify Text displaying as "Email Carrier One"
    Then Guest - Verify Text displaying as "Carrier Total"
    Then Guest - Verify Text displaying as "USD"
    Then Guest - Verify Text displaying as "0.00"
    Then Guest - Verify Text displaying as "Carrier Load Tender Instructions"
    Then Guest - Verify "White" Color with "SteelBlue" Text of "Decline" Button is "Enabled"
    Then Guest - Verify "SteelBlue" Color with "White" Text of "Accept" Button is "Enabled"

    #Step 6
    Then Guest - Click on button with Text "Decline"
    Then Set "TenderDateTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "2" Seconds
    #Expected Result b
    Then Guest - Verify Text displaying as "Carrier Load Confirm Decline Message"
    Then Close Guest Browser
    Then Wait for "80" Seconds
    #Step 7
    #Expected Result c
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | Declined    |

    #Step 8 & 9
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
    
    #Step 10
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
    
















