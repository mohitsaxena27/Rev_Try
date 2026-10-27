Feature: 2827 - Carrier Guest LWC - Simple Tender: Carrier Quote - Tender Expired

  @Regression @TMS @Priority_1 @WEB @SingleCurrency @Carrier @Headed @Carrier_Guest @2827
  Scenario: 2827 - Carrier Guest LWC - Simple Tender: Carrier Quote - Tender Expired

    When Login into Salesforce
    #Step1
    Then Run "QueuedTransactionJob" Job
    Then Wait for "2" Seconds
   # Step 2 - Removed not need
  #Step 3 & 4
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

    #Step 5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Tender Email" -
    Then Click on "Legend" Link Text "Tender" on Page -
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "5" Seconds
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | Tendered    |

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Click on Carrier Quote from FQA Page
    Then Go to "Details" Tab
    Then Scroll into Section "Auto-Engagement"
    Then Click on Edit icon on Label "Tender Expiration Date"
    Then Update Legend details
      |Tender Expiration Date, Date|Tender Expiration Date, Time|
      | -1                   |12:00 PM                    |
    Then Click on "SaveEdit" button

    #Step 7
    Then Set "Email_Subject" with "Load Tender for SysData=>1L"
    Then Wait for Email to Receive On Email

    Then Get "Accept Quote" link from Email for Subject "SysData=>Email_Subject"
    Then Launch browser and Navigate Link
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds

   #Expected Result a
    Then Guest - Click on button with Text "Accept"
    Then Wait for "3" Seconds
    Then Guest - Verify Text displaying as "Carrier Tender"
    Then Guest - Verify Icon "standard:poll" is displaying with background color "BrightBlue"
    Then Guest - Verify Text displaying as "Carrier Quotation Tender Expired Message"
    Then Close Guest Browser





