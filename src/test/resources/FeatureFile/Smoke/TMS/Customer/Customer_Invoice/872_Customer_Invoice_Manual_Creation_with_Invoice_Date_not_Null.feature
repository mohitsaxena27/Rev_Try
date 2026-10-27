Feature: 872 - Customer Invoice- Manual Creation with Invoice Date not Null

  @Regression @smoke @API @WEB @SingleCurrency @Customer @Customer_Invoice @872
  Scenario: 872 - Customer Invoice- Manual Creation with Invoice Date not Null

    When Login into Salesforce

    # Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Go to "Billing" Tab
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method | Customer Invoice Day | Invoice Terms | Batch Invoicing Email Process          | Batch Invoicing POD Treatment |
      | Email          | Wednesday            | 15            | One Email, Combined Invoice Attachment | Include in Invoice Attachment |
    Then Click on "SaveEdit" button


    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans  |Truckload | Dry Van 53'     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                      | NA                | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  3            | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000  |NA          |NA      |NA            |
    Then Save Load With All details
    Then Capture the current URL for "Load_1L"

    #Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1500"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 3
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Click on link "Customer Invoices"
    Then Click on button "New"
    Then Wait for "3" Seconds
    Then Set "Invoice_date" with "4/4/2021"
    Then Update details
      | Invoice Number | Invoice Date          | Invoice Status | Invoice Due Date      |
      | TESTINVNUM     | SysData=>Invoice_date | Pending        | SysData=>Invoice_date |
    Then Wait for "2" Seconds
    Then Scroll into Section "Invoice Summary"
    Then Update details
      | Invoice Total |
      | 50            |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Customer Invoice \"TESTINVNUM\" was created."
    Then Wait for "1" Seconds

    #Expected a
    Then Click on Partial Link Text "TESTINVNUM" on Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Invoice Date | Invoice Due Date |
      | 4/4/2021     | 4/4/2021         |
