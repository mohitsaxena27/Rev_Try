Feature: 1932 - Field Set Customer Invoice TMS1 - Non-Mode Specific

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @1932 @Field_Set
  Scenario: 1932 - Field Set Customer Invoice TMS1 - Non-Mode Specific

    When Login into Salesforce

    #Step1
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Open "Customer Invoice" Object Manager
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Open Field Sets "TMS1" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Delete Fields if any available with Field Set
    Then Add the Following Fields in this Order
     |Dispute Reason|Disputed|Customer Quote|Created Date|Billing Method|Billing Account|Invoice Total|Tax Amount|Transportation Total|
     |Dispute Reason|Disputed|Customer Quote|Created Date|Billing Method|Billing Account|Invoice Total|Tax Amount|Transportation Total|
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window
     #Step2
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |
    Then Save Load With All details
    # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1100"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Store Customer Quote value on "Customer_Quote"
    Then Click on Customer Quote from FQA Page
    Then Set Key "Customer_Quote_SFID" page Record Id with "rtms__CustomerQuote__c"
    Then Navigate Browser Back
    #Step 4
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Click on link "Customer Invoices"
    Then Click on button "New"
    Then Wait for "1" Seconds
    Then Update details
        |Invoice Number|Invoice Date|Invoice Due Date|Customer Quote|Invoice Total|
        |1932-1        |0           |7               |SysData=>Customer_Quote     |1111         |
    Then Click on "SaveAndNew" button
    Then Wait for "4" Seconds
    Then Update details
      |Invoice Number|Invoice Date|Invoice Due Date|Customer Quote|Invoice Total|
      |1932-2        |0           |7               |SysData=>Customer_Quote     |2222         |
    Then Click on "SaveEdit" button
    Then Verify Text displaying as "1932-2"
       #Step5
    Then Open "Customer Invoices" from App Launcher
    Then Search "1932" from List
    Then Select Multiple Records from List
         |Data1 |Data2|
         |1932-1|1932-2|
    Then Click on "Generate & Preview" with Text
    Then Switch to Frame by Title "accessibility title"
    Then Verify Heading Text "Generate and Preview"
    Then Wait for "10" Seconds
      #Expected a
    Then Get Pdf content from "Generate And Preview" with Subject "Customer Invoice.pdf"
    Then Wait for "6" Seconds
    Then Switch to Parent Frame
    Then the PDF table rows should match:
      |Transportation Total|Tax Amount| Invoice Total   | Billing Account |Billing Method|Created Date     |Customer Quote                            |Disputed|Dispute Reason|
      |USD 1,111.00        |          |USD 1,111.00     |Boston Beans     |Email         |Date=>0          |SysData=>Customer_Quote_SFID              |false   |              |
      |USD 2,222.00        |          |USD 2,222.00     |Boston Beans     |Email         |Date=>0          |SysData=>Customer_Quote_SFID               |false   |              |


