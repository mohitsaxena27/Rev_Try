Feature: 2268 - Customer Guest LWC: Customer Quote Accept Decline LWC- Accept Format/Function

  @Regression @TMS @Smoke @WEB @SingleCurrency @Customer @Headed @Customer_Guest @2268
  Scenario: 2268 - Customer Guest LWC: Customer Quote Accept Decline LWC- Accept Format/Function

    When Login into Salesforce
    #Step1
    Then Run "QueuedTransactionJob" Job
    
     #Step2 & Step 3
     #Load1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Chicago Pizza |Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  4             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000  |NA          |NA       |NA       |
    Then Save Load With All details

     #Step4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "2" Seconds
    Then "Send" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Verify Text displaying as "Customer Quote Confirmation"
    Then Click button with Text "Send" on Modal
    Then Verify Message displaying as "Email sent."
    Then Store Customer Quote value on "Customer_Quote"
    Then Set "Email_Subject" with "Customer Rate and Load Confirmation for SysData=>Customer_Quote"
    Then Wait for Email to Receive On Email
    #Step 5
    Then Get "Accept Quote" link from Email for Subject "SysData=>Email_Subject"
    Then Launch browser and Navigate Link
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds
    #Step 6 & Expected Result a
    Then Guest - Verify Icon "standard:poll" is displaying with background color "BrightBlue"
    Then Guest - Verify Text displaying as "Customer Quote"
    Then Guest - Verify Text displaying as "Indicate your acceptance of this load quotation by clicking Accept. If you do not accept the load quotation, click Decline."
    Then Guest - Verify "White" Color with "SteelBlue" Text of "Decline" Button is "Enabled"
    Then Guest - Verify "SteelBlue" Color with "White" Text of "Accept" Button is "Enabled"
    #Step 6>a
    Then Guest - Click on button with Text "Accept"
    Then Wait for "2" Seconds
    #Expected Result b
    Then Guest - Verify Icon "standard:poll" is displaying with background color "BrightBlue"
    Then Guest - Verify Text displaying as "Customer Quote"
    Then Guest - Verify Text displaying as "Customer Load Confirm Accept Message"
    Then Close Guest Browser
    Then Wait for "80" Seconds

    #Step 7
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Quotes" using value from "Customer_Quote" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    #Expected Result c
    Then Verify Details
         |Status|
         |Accepted|
















