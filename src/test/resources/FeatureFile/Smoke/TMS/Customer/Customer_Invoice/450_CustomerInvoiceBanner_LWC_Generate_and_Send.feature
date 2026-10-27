Feature: 450 - Customer Invoice Banner LWC- Generate and Send

  @Regression @API @WEB @TMS @Smoke @SingleCurrency @Customer @Customer_Invoice @450
  Scenario: 450 - Customer Invoice Banner LWC- Generate and Send

    When Login into Salesforce
    #Step1
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "Boston Beans" from Search List
    Then Capture the current URL for "TP_Boston_Beans"
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Information"
    Then Click on Edit icon on "Billing Email Attachment Format"
    Then Update details
      | Billing Email Attachment Format | Customer Invoice Export File |
      | PDF with CSV                    | Valid FED - UC Group Sample  |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Email Attachment Format | Customer Invoice Export File |
      | PDF with CSV                    | Valid FED - UC Group Sample  |

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Water       | 15000  | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 3,3a,3b
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Verify details for
      | Status   |
      | Accepted |

    #Step 3.c,3.d
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Verify details for
      | Billing Status |
      | Approved       |
    Then Click on Customer Quote from FQA Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Quote_Load1"
    Then Navigate Browser Back

    #Step 4
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Invoice_Number_Email"
    Then Set Key "Customer_Invoice_SFID_Email" page Record Id with "rtms__CustomerInvoice__c"

    #Step 4.a
    Then Scroll into Section "General Information"
    Then Click on Edit icon on "Invoice Number"
    Then Update details
      | Invoice Number | Invoice Status |
      | 450-EMAIL      | Approved       |
    Then Click on "Save" button on Details Page
    Then Verify Details
      | Invoice Number | Invoice Status |
      | 450-EMAIL      | Approved       |

    #Step 5
    Then Click on "Generate and Send" with Text
    #Step 5.b
    Then Set "CurrentDateTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "2" Seconds

    #Step 6
    Then Click on Native "Send" button
    Then Wait for "2" Seconds
    Then Verify Success Message displaying as "Email sent."

    #Step 7
    Then Wait for Email to Receive On Email

    #Expected a
    Then Verify Content "450-EMAIL" in the email body with Subject "450-EMAIL"
    Then Set "Invoice_PDF" with "SysData=>1L" and " - Customer Invoice.pdf"
    Then Set "Invoice_CSV" with "SysData=>1L" and " - Customer Invoice.csv"
    Then Verify the email attachment has "SysData=>Invoice_PDF" as an attachment with subject "450-EMAIL"
    Then Verify the email attachment has "SysData=>Invoice_CSV" as an attachment with subject "450-EMAIL"

    #Step 8
    #Expected b
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Get Details
      | Date Sent |
      |           |

    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 9
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "10" Seconds

    #Expected c
    Then Verify Text displaying as "SysData=>Invoice_PDF" -
    Then Verify Text displaying as "SysData=>Invoice_CSV" -

    #Step 10
    Then Navigate to stored URL for "Customer_Quote_Load1"

    #Expected d
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 11a, 11b
    Then Click on Edit icon on Label "Billing Status"
    Then Wait for "2" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Approved       |

    #Step 12
    Then Navigate to stored URL for "Customer_Invoice_Number_Email"
    Then Wait for "3" Seconds
    Then Click on "Clone" button
    Then Wait for "6" Seconds

    Then Update details
      | Invoice Number | Invoice Status |
      | 450-PRINT      | Approved       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Invoice_Number_Print"
    Then Set Key "Customer_Invoice_SFID_Print" page Record Id with "rtms__CustomerInvoice__c"
    Then Scroll into Section "General Information"
    Then Wait for "2" Seconds
    Then Verify Details
      | Invoice Number | Invoice Status |
      | 450-PRINT      | Approved       |

    #Step 13
    Then Scroll into Section "Billing Contact Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | Print          |
    Then Update Legend details
      | Date Sent, Date |
      |                 |
    Then Click on "Save" button on Details Page

    #Step 14, 14.a
    Then Click on "Generate and Send" with Text
    Then Set "CurrentDateTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "2" Seconds

    #Step 15
    Then Click on Native "Send" button
    Then Wait for "2" Seconds
    Then Verify Success Message displaying as "Email sent."

    #Step 16
    Then Wait for Email to Receive On Email

    #Expected e
    Then Verify Content "450-PRINT" in the email body with Subject "450-PRINT"
    Then Verify the email attachment has "SysData=>Invoice_PDF" as an attachment with subject "450-PRINT"
    Then Verify the email attachment has "SysData=>Invoice_CSV" as an attachment with subject "450-PRINT"

    #Step 17
    #Expected f
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Get Details
      | Date Sent |
      |           |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 18
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected g  Ensure a PDF file and CSV file are displayed, each with the name 'Load Number noted in Step 3(f)(iii)' - Customer Invoice'
    Then Verify Text displaying as "SysData=>Invoice_PDF" -
    Then Verify Text displaying as "SysData=>Invoice_CSV" -

    #Step 19
    Then Navigate to stored URL for "Customer_Quote_Load1"

    #Expected h
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 20
    Then Click on Edit icon on Label "Billing Status"
    Then Wait for "2" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Approved       |

    #Step 21
    Then Navigate to stored URL for "TP_Boston_Beans"
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Information"
    Then Click on Edit icon on "Billing Email Attachment Format"
    Then Update details
      | Billing Email Attachment Format | Customer Invoice Export File |
      | PDF                             |                              |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Email Attachment Format | Customer Invoice Export File |
      | PDF                             |                              |

    #Step 22
    Then Navigate to stored URL for "Customer_Invoice_Number_Email"

    Then Click on Edit icon on Label "Invoice Number"
    Then Update details
      | Invoice Number | Invoice Status |
      | 450-EMAIL2     | Approved       |

    Then Update Legend details
      | Date Sent, Date |
      |                 |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Invoice_Number_Email2"
    Then Set Key "Customer_Invoice_SFID_Email2" page Record Id with "rtms__CustomerInvoice__c"
    Then Scroll into Section "General Information"
    Then Wait for "2" Seconds
    Then Verify Details
      | Invoice Number | Invoice Status | Date Sent |
      | 450-EMAIL2     | Approved       |           |

    #Step 23
    Then Click on "Generate and Send" with Text
    Then Set "CurrentDateTime 2" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "2" Seconds

    #Step 24
    Then Click on Native "Send" button
    Then Wait for "2" Seconds
    Then Verify Success Message displaying as "Email sent."

    #Step 25
    Then Wait for Email to Receive On Email

    #Expected i
    Then Verify Content "450-EMAIL2" in the email body with Subject "450-EMAIL2"
    Then Verify the email attachment has "SysData=>Invoice_PDF" as an attachment with subject "450-EMAIL2"

    #Step 26
    #Expected j
    Then Get Details
      | Date Sent |
      |           |
    Then Verify Details
      | Invoice Status |
      | Invoiced       |

    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 27
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected k Related list displays two PDF files and one CSV file, each titled 'Load Number noted in Step 2(g) - Customer Invoice'
    Then Verify File "SysData=>Invoice_PDF" displaying "2" Times
    Then Verify File "SysData=>Invoice_CSV" displaying "1" Times

    #Step 28
    Then Navigate to stored URL for "Customer_Quote_Load1"

    #Expected l
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 29
    Then Click on Edit icon on Label "Billing Status"
    Then Wait for "2" Seconds
    Then Update details
      | Billing Status |
      | Approved       |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Approved       |

    #Step 30
    Then Navigate to stored URL for "Customer_Invoice_Number_Print"

    Then Click on Edit icon on Label "Invoice Number"
    Then Update details
      | Invoice Number | Invoice Status |
      | 450-PRINT2     | Approved       |

    Then Update Legend details
      | Date Sent, Date |
      |                 |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Invoice_Number_Print2"
    Then Set Key "Customer_Invoice_SFID_Email2" page Record Id with "rtms__CustomerInvoice__c"
    Then Scroll into Section "General Information"
    Then Wait for "2" Seconds
    Then Verify Details
      | Invoice Number | Invoice Status | Date Sent |
      | 450-PRINT2     | Approved       |           |

    #Step 31
    Then Click on "Generate and Send" with Text
    Then Set "CurrentDateTime 2" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "2" Seconds

    #Step 32
    Then Click on Native "Send" button
    Then Wait for "2" Seconds
    Then Verify Success Message displaying as "Email sent."

    #Step 33
    Then Wait for Email to Receive On Email

    #Expected m
    Then Verify Content "450-PRINT2" in the email body with Subject "450-PRINT2"
    Then Verify the email attachment has "SysData=>Invoice_PDF" as an attachment with subject "450-PRINT2"

    #Step 34
    #Expected n
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Get Details
      | Date Sent |
      |           |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 35
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected o Related list displays two PDF files and one CSV file, each titled 'Load Number noted in Step 2(g) - Customer Invoice'
    Then Verify File "SysData=>Invoice_PDF" displaying "2" Times
    Then Verify File "SysData=>Invoice_CSV" displaying "1" Times

    #Step 36
    Then Navigate to stored URL for "Customer_Quote_Load1"

    #Expected p
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |