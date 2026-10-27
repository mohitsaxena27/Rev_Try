Feature: 502 - Customer Invoice- List View- Generate and Send

  @Regression @API @WEB @TMS @Smoke @SingleCurrency @Customer @Customer_Invoice @502
  Scenario: 502 - Customer Invoice- List View- Generate and Send

    When Login into Salesforce
    #Step1
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "Revenova HQ" from Search List
    Then Wait for "3" Seconds
    Then Capture the current URL for "TP_Revenova_HQ"
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Information"
    Then Click on Edit icon on "Billing Email Attachment Format"
    Then Update details
      | Billing Email Attachment Format | Customer Invoice Export File | Batch Invoicing Email Process          |
      | PDF with CSV                    | Valid FED - UC Group Sample  | One Email, Combined Invoice Attachment |
    Then Click on "Save" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Billing Email Attachment Format | Customer Invoice Export File | Batch Invoicing Email Process          |
      | PDF with CSV                    | Valid FED - UC Group Sample  | One Email, Combined Invoice Attachment |

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Water       | 15000  | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 4
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Click on Customer Quote from FQA Page
    Then Capture the current URL for "Customer_Quote_Load1"
    Then Wait for "2" Seconds
    Then Navigate Browser Back

    #Step 5
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "6" Seconds

    Then Scroll into Section "General Information"
    Then Wait for "10" Seconds
    Then Get Details
      | Master Invoice Number | Invoice Date |
      |                       |              |
    Then Set "MIN_1" with "SysData=>Master Invoice Number"
    Then Capture the current URL for "Invoice_1"
    Then Wait for "5" Seconds

    #Step 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Revenova HQ | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 2             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Coffee      | 15000  | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 7
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 8
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Click on Customer Quote from FQA Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "Cutomer_Quote_Load2"
    Then Navigate Browser Back

    #Step 9
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Wait for "2" Seconds

    Then Scroll into Section "General Information"
    Then Get Details
      | Master Invoice Number | Invoice Date |
      |                       |              |
    Then Set "MIN_2" with "SysData=>Master Invoice Number"
    Then Capture the current URL for "Invoice_2"
    Then Wait for "5" Seconds

    #Step 10
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Wait for "3" Seconds
    Then Manage "Created Date" in "descending" Order
    Then Wait for "2" Seconds
    Then Select Multiple Records from List
      | Data1       | Data2       |
      | SysData=>1L | SysData=>2L |

    #Step 10.a
    Then Click on "Generate & Send" with Text
    Then Wait for "5" Seconds

    #Expected a
    Then Switch to Frame by Title "accessibility title"
    Then Verify Heading Text "Generate and Send"

    #Step 10.b
    Then Note the current Date and Time
    Then Set "CurrentDateTime" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 10.c
    Then Wait for "10" Seconds
    Then Wait until "Completed" is visible -
    Then Wait for "2" Seconds
    Then Click on "Return to Previous Page" with Text -
    Then Switch to Parent Frame

    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Wait for "3" Seconds
    Then Manage "Created Date" in "descending" Order
    Then Wait for "2" Seconds
    #Step 11
    Then Select Multiple Records from List
      | Data1       | Data2       |
      | SysData=>1L | SysData=>2L |

    #Step 11.a
    Then Click on "Billing Contact" for value "Bingo Revenova HQ" within table
    Then Capture the current URL for "Bingo Revenova HQ"

    Then Go to "Related" Tab
    Then Scroll Until Related List for "Files"
    Then Click on link "Files"

    #Expected b
    Then Convert Date format "Invoice Date" from "M/d/yyyy" to "MM-dd-yyyy"

    Then Set "MasterInvoice_Number_1" with "SysData=>MIN_1" and "-"
    Then Set "Invoice_FileName_PDF_1" with "SysData=>MasterInvoice_Number_1" and "SysData=>Invoice Date"
    Then Set "FinalFilename_PDF_1" with "SysData=>Invoice_FileName_PDF_1" and ".pdf"
    Then Set "FinalFilename_CSV_1" with "SysData=>Invoice_FileName_PDF_1" and ".csv"

    Then Set "MasterInvoice_Number_2" with "SysData=>MIN_2" and "-"
    Then Set "Invoice_FileName_PDF_2" with "SysData=>MasterInvoice_Number_2" and "SysData=>Invoice Date"
    Then Set "FinalFilename_PDF_2" with "SysData=>Invoice_FileName_PDF_2" and ".pdf"
    Then Set "FinalFilename_CSV_2" with "SysData=>Invoice_FileName_PDF_2" and ".csv"

    Then Sort "Last Modified" column in "descending" Order
    Then Wait for "5" Seconds
    Then Verify Text displaying either "SysData=>FinalFilename_PDF_1" or "SysData=>FinalFilename_PDF_2"
    Then Verify Text displaying either "SysData=>FinalFilename_CSV_1" or "SysData=>FinalFilename_CSV_2"

    #Step 12
    Then Wait for Email to Receive On Email
    Then Verify Content "Please find the attached invoices for loads we moved for you" in the email with Subject "Sandbox: Transportation Invoices Due"
    Then Wait for "5" Seconds
    #Expected c
    Then Verify the email attachment has "Valid" "SysData=>Valid_FinalFilename_PDF" with subject "Sandbox: Transportation Invoices Due"
    Then Verify the email attachment has "Valid" "SysData=>Valid_FinalFilename_CSV" with subject "Sandbox: Transportation Invoices Due"

    #Step 13
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "SysData=>1L" from List

    #Step 13.a
    Then Go to "Related" Tab
    Then Wait for "1" Seconds

    #Expected d
    Then Verify No Records Available with "Files"

    #Step 13.b
    Then Go to "Details" Tab

    #Expected e
    Then Scroll into Section "General Information"
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Get Details
      | Date Sent |
      |           |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    Then Click on Edit icon on Label "Invoice Status"
    Then Update details
      | Invoice Status |
      | Approved       |

    Then Update Legend details
      | Date Sent, Date |
      |                 |

    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    Then Verify Details
      | Invoice Status | Date Sent |
      | Approved       |           |

    #STep 14
    Then Navigate to stored URL for "Customer_Quote_Load1"
    Then Wait for "2" Seconds

    #Expected f
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 15
    Then Click on Edit icon on Label "Billing Status"
    Then Update details
      | Billing Status |
      | Approved       |

    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 16
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "SysData=>2L" from List

    #Step 16.a
    Then Go to "Related" Tab

    #Expected g
    Then Verify No Records Available with "Files"

    #Step 16.b
    Then Go to "Details" Tab

    #Expected h
    Then Scroll into Section "General Information"
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Get Details
      | Date Sent |
      |           |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

    #Step 16.c
    Then Click on Edit icon on Label "Invoice Status"
    Then Update details
      | Invoice Status |
      | Approved       |

    Then Update Legend details
      | Date Sent, Date |
      |                 |

    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    Then Verify Details
      | Invoice Status | Date Sent |
      | Approved       |           |

    #STep 17
    Then Navigate to stored URL for "Cutomer_Quote_Load2"
    Then Wait for "2" Seconds

    #Expected i
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 18
    Then Click on Edit icon on Label "Billing Status"
    Then Update details
      | Billing Status |
      | Approved       |

    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    #Step 19
    Then Navigate to stored URL for "TP_Revenova_HQ"
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

    #Step 20
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Wait for "3" Seconds
    Then Manage "Created Date" in "descending" Order
    Then Wait for "2" Seconds
    Then Select Multiple Records from List
      | Data1       | Data2       |
      | SysData=>1L | SysData=>2L |

    #Step 20.a
    Then Click on "Generate & Send" with Text
    Then Wait for "5" Seconds

    #Expected j
    Then Switch to Frame by Title "accessibility title"
    Then Verify Heading Text "Generate and Send"

    #Step 20.b
    Then Note the current Date and Time
    Then Set "CurrentDateTime2" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 20.c
    Then Wait until "Completed" is visible -
    Then Wait for "2" Seconds
    Then Click on "Return to Previous Page" with Text -

    #Step 21
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Wait for "3" Seconds
    Then Manage "Created Date" in "descending" Order
    Then Wait for "2" Seconds
    Then Select Multiple Records from List
      | Data1       | Data2       |
      | SysData=>1L | SysData=>2L |

    #Step 21.a
    Then Click on "Billing Contact" for value "Bingo Revenova HQ" within table

    #Step 21.a.i
    Then Go to "Related" Tab
    Then Scroll down with "20" Times
    Then Scroll Until Related List for "Files"
    Then Click on link "Files"
    Then Wait for "2" Seconds
    Then Sort "Last Modified" column in "descending" Order

    #Expected k
    Then Verify File "SysData=>Valid_FinalFilename_PDF" displaying "2" Times

    #Step22
    Then Wait for Email to Receive On Email
    Then Verify Content "Please find the attached invoices for loads we moved for you" in the email with Subject "Sandbox: Transportation Invoices Due"
    Then Wait for "5" Seconds
    #Expected l
    Then Verify the email attachment has "Valid" "SysData=>Valid_FinalFilename_PDF" with subject "Sandbox: Transportation Invoices Due"
    Then Verify the email attachment has "No" "SysData=>Valid_FinalFilename_CSV" with subject "Sandbox: Transportation Invoices Due"

    #Step 23
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "SysData=>1L" from List

    #Step 23.a
    Then Go to "Related" Tab

    #Expected m
    Then Verify No Records Available with "Files"

    #Step 23.b
    Then Go to "Details" Tab

    #Expected n
    Then Scroll into Section "General Information"
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Get Details
      | Date Sent |
      |           |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime2" in format "M/d/yyyy, h:mm a"

    Then Click on Edit icon on Label "Invoice Status"
    Then Update details
      | Invoice Status |
      | Approved       |

    Then Update Legend details
      | Date Sent, Date |
      |                 |

    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds

    Then Verify Details
      | Invoice Status | Date Sent |
      | Approved       |           |

    #STep 23.c
    Then Navigate to stored URL for "Customer_Quote_Load1"
    Then Wait for "2" Seconds

    #Expected o
    Then Verify Details
      | Billing Status |
      | Invoiced       |

    #Step 24
    Then Open "Customer Invoices" from App Launcher
    Then Recently Viewed to All
    Then Search and Select "SysData=>2L" from List

    #Step 24.a
    Then Go to "Related" Tab

    #Expected p
    Then Verify No Records Available with "Files"

    #Step 24.b
    Then Go to "Details" Tab

    #Expected q
    Then Scroll into Section "General Information"
    Then Verify Details
      | Invoice Status |
      | Invoiced       |
    Then Scroll into Section "Billing Contact Information"
    Then Get Details
      | Date Sent |
      |           |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime2" in format "M/d/yyyy, h:mm a"

    Then Click on Edit icon on Label "Invoice Status"
    Then Update details
      | Invoice Status |
      | Approved       |

    Then Update Legend details
      | Date Sent, Date |
      |                 |

    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    Then Verify Details
      | Invoice Status | Date Sent |
      | Approved       |           |

    #STep 24.c
    Then Navigate to stored URL for "Customer_Quote_Load1"
    Then Wait for "2" Seconds

    #Expected r
    Then Verify Details
      | Billing Status |
      | Invoiced       |