Feature: 3444 - Transportation Profile- Batch Invoicing POD Treatment:Include as Attachment

  @Regression @TMS @Smoke @API @WEB @DeleteFile @Customer @SingleCurrency @3444 @After
  Scenario: 3444 - Transportation Profile- Batch Invoicing POD Treatment:Include as Attachment

    When Login into Salesforce

    # Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Go to "Billing" Tab
    Then Click on Edit icon on Label "Batch Invoicing Email Process"
    Then Update details
      | Batch Invoicing Email Process             |  Batch Invoicing POD Treatment |
      | One Email, Individual Invoice Attachments |  Include as Attachment         |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page"

    # Step 2
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
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details

    # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    # Step 4
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    # Step 5
    Then Go to "Documents" Tab
    Then Update details
      | Upload Files                                           |
      | 94897_Proof of Delivery _2022-11-16-3.png              |
    Then Wait for "12" Seconds
    Then Click on "Done" with Text -

    # Step 6
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab

    # Step 7 - Expected Result A
    Then Click on button "Generate"
    Then Wait for "4" Seconds
    Then Verify Text displaying as "Customer Invoice.pdf" -

    # Step 8
    Then Close the Preview Modal
    Then Wait for "2" Seconds
    Then Set Key "GetElementID" page Record Id with "rtms__CustomerInvoice__c"
    Then Get Pdf content from "Document" with Subject "Customer Invoice.pdf"
    Then Verify Pdf not contains "Proof of Delivery/Supporting Document"

    # Step 9
    Then Click on button "Generate and Send"
    Then Wait for "4" Seconds
    Then To open the preview attachments -
    Then Wait for "2" Seconds

   # Step 10 - Expected Result B
    Then Get Pdf content from "Preview Attachments" with Subject "Customer Invoice.pdf"
    Then Verify Pdf not contains "Proof of Delivery/Supporting Document"

    # Step 11 Expected Result C
    Then Scroll into Section "Attached Documents"
    Then Verify "Customer Invoice.pdf" file showing on Attached Documents section
    Then Verify "94897_Proof of Delivery _2022-11-16-3.png" file showing on Attached Documents section

    # Step 12 Expected Result D
    Then Verify details for all Enabled fields
      | Available Documents                       |
      | 94897_Proof of Delivery _2022-11-16-3.png |

    