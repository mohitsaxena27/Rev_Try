Feature: 741 - Customer Invoice Banner LWC- Generate Action

  @WEB @API @Regression @TMS @Smoke @SingleCurrency @Customer @Customer_Invoice @741 @DeleteFile
  Scenario: 741 - Customer Invoice Banner LWC- Generate Action

    When Login into Salesforce
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI |
      | True        | True                 |
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 2
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
      | Billing Email Attachment Format |
      | PDF with CSV                    |

    #Step 3
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

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 5
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Click on Customer Quote from FQA Page
    Then Capture the current URL for "Customer_Quote_Number"
    Then Navigate Browser Back

    #Step 6
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Capture the current URL for "Customer_Invoice_Number_Email"
    Then Set Key "Customer_Invoice_SFID_Email" page Record Id with "rtms__CustomerInvoice__c"
    Then Wait for "2" Seconds

    #Step 7
    Then Scroll into Section "General Information"
    Then Click on Edit icon on "Invoice Number"
    Then Update details
      | Invoice Number |
      | 741-EMAIL      |
    Then Click on "Save" button on Details Page
    Then Verify Details
      | Invoice Number |
      | 741-EMAIL      |

    #Step 8
    Then Click on "Generate" with Text
    Then Wait for "3" Seconds

    #Expected a
    Then Set "Customer_Invoice_Heading" with "SysData=>1L" and " - Customer Invoice.pdf"
    Then Verify Text displaying as "SysData=>Customer_Invoice_Heading" -

    Then Verify Preview "Customer Invoice.pdf" modal renders with a preview of PDF

    Then Get Pdf content from "Generate" with Subject "Customer Invoice.pdf"
    Then Verify Pdf contains "Invoice Number: 741-EMAIL"
    Then Close the Preview Modal

    #Step 9
    #Expected b
    Then Verify Details
      | Invoice Status |
      | Invoiced       |

    #Step 9.a
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected c  Ensure a PDF file and CSV file are displayed with the name 'Load Number noted in Step 3(f)(iii)' - - Customer Invoice'
    Then Set "Customer_Invoice_Heading_PDF" with "SysData=>1L" and " - Customer Invoice.pdf"
    Then Set "Customer_Invoice_Heading_CSV" with "SysData=>1L" and " - Customer Invoice.csv"
    Then Verify Text displaying as "SysData=>Customer_Invoice_Heading_PDF" -
    Then Verify Text displaying as "SysData=>Customer_Invoice_Heading_CSV" -

    #Step 9.b
    Then Navigate to stored URL for "Customer_Quote_Number"

    #Expected d
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 11
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

    #Step 13
    Then Click on "Clone" button
    Then Wait for "6" Seconds

    Then Update details
      | Invoice Number | Invoice Status |
      | 741-PRINT      | Pending        |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Invoice_Number_Print"
    Then Set Key "Customer_Invoice_SFID_Print" page Record Id with "rtms__CustomerInvoice__c"

    #Step 14
    Then Scroll into Section "General Information"
    Then Wait for "2" Seconds
    Then Verify Details
      | Invoice Number | Invoice Status |
      | 741-PRINT      | Pending        |
    Then Scroll into Section "Billing Contact Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | Print          |
    Then Click on "Save" button on Details Page

    #Step 15
    Then Click on "Generate" with Text
    Then Wait for "3" Seconds
    Then Get Pdf content from "Generate" with Subject "Customer Invoice.pdf"

    Then Wait for "5" Seconds

    #Expected e
    Then Verify Text displaying as "Customer Invoice.pdf" -
    Then Verify Preview "Customer Invoice.pdf" modal renders with a preview of PDF
    Then Verify Pdf contains "Invoice Number: 741-PRINT"
    Then Close the Preview Modal

    #Step 16
    #Expected f
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Verify Details
      | Date Sent |
      |           |

    #Step 16.a
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected g  Ensure a PDF file and CSV file are displayed, each with the name 'Load Number noted in Step 3(f)(iii)' - Customer Invoice'
    Then Verify Text displaying as "SysData=>Customer_Invoice_Heading_PDF" -
    Then Verify Text displaying as "SysData=>Customer_Invoice_Heading_CSV" -

    #Step 16.b
    Then Navigate to stored URL for "Customer_Quote_Number"

    #Step 17 and  #Expected h
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 18
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

    #Step 19
    Then Navigate to stored URL for "Customer_Invoice_Number_Print"
    Then Wait for "3" Seconds

    #Step 20
    Then Click on "Clone" button
    Then Wait for "6" Seconds

    Then Update details
      | Invoice Number | Invoice Status |
      | 741-EDI        | Pending        |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Invoice_Number_EDI"
    Then Set Key "Customer_Invoice_SFID_EDI" page Record Id with "rtms__CustomerInvoice__c"

    #Step 21
    Then Scroll into Section "General Information"
    Then Wait for "2" Seconds
    Then Verify Details
      | Invoice Number | Invoice Status |
      | 741-EDI        | Pending        |
    Then Scroll into Section "Billing Contact Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | EDI            |
    Then Click on "Save" button on Details Page

    #Step 22
    Then Click on "Generate" with Text
    Then Wait for "3" Seconds
    Then Get Pdf content from "Generate" with Subject "Customer Invoice.pdf"

    Then Wait for "5" Seconds

    #Expected i
    Then Verify Text displaying as "Customer Invoice.pdf" -
    Then Verify Preview "Customer Invoice.pdf" modal renders with a preview of PDF
    Then Verify Pdf contains "Invoice Number: 741-EDI"
    Then Close the Preview Modal

    #Step 23
    #Expected j
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Verify Details
      | Date Sent |
      |           |
    #Step 23.a
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected k  Ensure a PDF file and CSV file are displayed, each with the name 'Load Number noted in Step 3(f)(iii)' - Customer Invoice'
    Then Verify Text displaying as "SysData=>Customer_Invoice_Heading_PDF" -
    Then Verify Text displaying as "SysData=>Customer_Invoice_Heading_CSV" -

    #Step 23.b
    Then Navigate to stored URL for "Customer_Quote_Number"

    #Step 24 and  #Expected l
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 25
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

    #Step 26
    Then Navigate to stored URL for "TP_Boston_Beans"
    Then Wait for "3" Seconds

    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Information"
    Then Click on Edit icon on "Billing Email Attachment Format"
    Then Update details
      | Billing Email Attachment Format | Customer Invoice Export File |
      | PDF                             |                              |
    Then Click on "Save" button
    Then Verify Details
      | Billing Email Attachment Format |
      | PDF                             |

    #Step 27 a, b
    Then Navigate to stored URL for "Customer_Invoice_Number_Email"
    Then Wait for "3" Seconds

    Then Click on Edit icon on "Invoice Number"
    Then Update details
      | Invoice Status |
      | Pending        |
    Then Click on "Save" button on Details Page
    Then Verify Details
      | Invoice Status |
      | Pending        |

    #Step 28
    Then Click on "Generate" with Text
    Then Wait for "3" Seconds
    Then Get Pdf content from "Generate" with Subject "Customer Invoice.pdf"

    Then Wait for "5" Seconds

    #Expected m
    Then Verify Text displaying as "Customer Invoice.pdf" -
    Then Verify Preview "Customer Invoice.pdf" modal renders with a preview of PDF
    Then Verify Pdf contains "Invoice Number: 741-EMAIL"
    Then Close the Preview Modal

    #Step 29
    #Expected n
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Verify Details
      | Date Sent |
      |           |

    #Step 29.a
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected o  Ensure a PDF file is displayed, each with the name 'Load Number noted in Step 3(f)(iii)' - Customer Invoice'
    Then Verify File "SysData=>Customer_Invoice_Heading_PDF" displaying "2" Times

    #Step 29.b
    Then Navigate to stored URL for "Customer_Quote_Number"

    #Step 30 and  #Expected p
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 31
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

    #Step 32 a,b
    Then Navigate to stored URL for "Customer_Invoice_Number_Print"
    Then Wait for "3" Seconds

    Then Click on Edit icon on "Invoice Number"
    Then Update details
      | Invoice Status |
      | Pending        |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds
    Then Verify Details
      | Invoice Status |
      | Pending        |

    #Step 33
    Then Click on "Generate" with Text
    Then Wait for "3" Seconds
    Then Get Pdf content from "Generate" with Subject "Customer Invoice.pdf"

    Then Wait for "5" Seconds

    #Expected q
    Then Verify Text displaying as "Customer Invoice.pdf" -
    Then Verify Preview "Customer Invoice.pdf" modal renders with a preview of PDF
    Then Verify Pdf contains "Invoice Number: 741-PRINT"
    Then Close the Preview Modal

    #Step 34
    #Expected r
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Verify Details
      | Date Sent |
      |           |

    #Step 34.a
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected s  Ensure a PDF file is displayed with the name 'Load Number noted in Step 3(f)(iii)' - Customer Invoice'
    Then Verify File "SysData=>Customer_Invoice_Heading_PDF" displaying "2" Times

    #Step 34.b
    Then Navigate to stored URL for "Customer_Quote_Number"

    #Step 35 and  #Expected t
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 36
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

    #Step 37
    Then Navigate to stored URL for "Customer_Invoice_Number_EDI"
    Then Wait for "3" Seconds

    Then Click on Edit icon on "Invoice Number"
    Then Update details
      | Invoice Status |
      | Pending        |
    Then Click on "Save" button on Details Page
    Then Verify Details
      | Invoice Status |
      | Pending        |

    #Step 38
    Then Click on "Generate" with Text
    Then Wait for "3" Seconds
    Then Get Pdf content from "Generate" with Subject "Customer Invoice.pdf"

    Then Wait for "5" Seconds

    #Expected u
    Then Verify Text displaying as "Customer Invoice.pdf" -
    Then Verify Preview "Customer Invoice.pdf" modal renders with a preview of PDF
    Then Get Pdf content from "Generate" with Subject "Customer Invoice.pdf"
    Then Verify Pdf contains "Invoice Number: 741-EDI"
    Then Close the Preview Modal

    #Step 38.b
    #Expected v
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Verify Details
      | Date Sent |
      |           |

    #Step 38.c
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Wait for "2" Seconds

    #Expected w  Ensure PDF file is displayed with the name 'Load Number noted in Step 3(f)(iii)' - Customer Invoice'
    Then Verify File "SysData=>Customer_Invoice_Heading_PDF" displaying "2" Times

    #Step 38.d
    Then Navigate to stored URL for "Customer_Quote_Number"

    #Step 39 and  #Expected x
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Status |
      | Invoiced       |