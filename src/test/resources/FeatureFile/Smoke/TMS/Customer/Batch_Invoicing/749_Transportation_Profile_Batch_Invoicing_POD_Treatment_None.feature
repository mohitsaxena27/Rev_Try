Feature: 749 - Transportation Profile- Batch Invoicing POD Treatment: None

  @Regression @TMS @Smoke @API @WEB @DeleteFile @Customer @SingleCurrency @749
  Scenario: 749 - Transportation Profile- Batch Invoicing POD Treatment: None

    When Login into Salesforce
    # Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Go to "Billing" Tab
    Then Scroll into Section "Batch Invoicing POD Treatment"
    Then Click on Edit icon on Label "Batch Invoicing POD Treatment"
    Then Update details
      | Batch Invoicing POD Treatment |
      | --None--                      |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page"

   # Step 2
    #1st Load
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000   | NA           | NA       | NA            |
    Then Save Load With All details

   # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    # Step 4
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 5
    Then Go to "Documents" Tab
    Then Update details
      |Upload Files                 |
      |TC- 749 Proof of delivery.png|
    Then Wait for "2" Seconds
    Then Click on "Done" with Text -

    # Step 6
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab

    # Step 7 & 8
    Then Click on button "Generate"
    Then Wait for "4" Seconds
    Then Verify Text displaying as "Customer Invoice.pdf" -
    Then Close the Preview Modal
    Then Wait for "2" Seconds
    Then Set Key "GetElementID" page Record Id with "rtms__CustomerInvoice__c"
    #Expected a
    Then Get Pdf content from "Document" with Subject "Customer Invoice.pdf"
    Then Verify Pdf not contains "Proof of Delivery/Supporting Document"

    # Step 9
    Then Click on button "Generate and Send"
    Then Wait for "4" Seconds
    # Step 10
    Then To open the preview attachments -
    Then Wait for "2" Seconds
     #Expected b
    Then Get Pdf content from "Preview Attachments" with Subject "Customer Invoice.pdf"
    Then Verify Pdf not contains "Proof of Delivery/Supporting Document"

    #Step 11 & Expected c
    Then Scroll into Section "Attached Documents"
    Then Verify "Customer Invoice.pdf" file showing on Attached Documents section
    Then Verify "TC- 749 Proof of delivery.png" file not showing on Attached Documents section

    #Step 12 & Expected d
    Then Verify details for all Enabled fields
         |Available Documents|
         |TC- 749 Proof of delivery.png|