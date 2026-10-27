Feature: 2310 - Send Email LWC- Tender

  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Carrier_Quotes @2310
  Scenario: 2310 - Send Email LWC- Tender

    When Login into Salesforce

#   # Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Boston Beans |LTL | NA     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots|  1           | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |4000  |NA          |NA       |NA       |
    Then Save Load With All details

     #Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then Add "Load" "Carrier Quote Items" "Blind Shipments" Accessorial with Unit as "Fixed Cost" Qty as "2" and Price "117.28"
    Then Wait for "1" Seconds
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    #Step 3
    Then Verify Text displaying as "Tender Email" -
    Then Click on "Legend" Link Text "Tender" on Page -

    #Step 4
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds
    #Expected a
    Then Verify Message displaying with Text "Email has been placed in the outgoing queue."
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | Tendered    |

    Then Set "Email_Subject" with "Load Tender for SysData=>1L"
    Then Wait for Email to Receive On Email

    #Step 5
    Then Set "PdfName" with "SysData=>1L" and " - Email Carrier One - LTL - Carrier Rate and Load Confirmation.pdf"
    #Expected b
    Then Verify the email attachment has "SysData=>PdfName" as an attachment with subject "SysData=>Email_Subject"

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then "Tender" Carrier

    #Step 7
    Then Verify Text displaying as "Tender Email" -
    Then Click on "Legend" Link Text "Tender" on Page
    Then Scroll On Modal
    Then Scroll into Section "Preview Attachments"
    Then Click on button with Title "Generate Attachments"
    Then Wait for "6" Seconds
#    Then To open the preview attachments -
#    Then Wait for "4" Seconds
    
    #Expected c
    Then Scroll On Modal
    Then Verify Button with Title not displaying as "Generate Attachments" -
    Then Verify Text displaying as "Preview Attachments" -
    Then Verify "SysData=>PdfName" file showing on Attached Documents section
    Then Verify Label "Source" is displaying with button data Value as "Load"
    Then Verify details for all Enabled fields -
          |Available Documents|
          |SysData=>PdfName   |
    Then Verify Title displaying as "Attach Documents"
    Then Verify Text displaying as "Upload Files" -
    #Step 8
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "2" Seconds
    #Expected d
    Then Verify Message displaying with Text "Email sent."
   #Step 9 &  #Expected e
    Then Wait for Email to Receive On Email
    Then Verify the email attachment has "SysData=>PdfName" as an attachment with subject "SysData=>Email_Subject"