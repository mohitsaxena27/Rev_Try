Feature:2831 - GenerateAccessorialPayJob- Customer Invoice Accessorial- Accessorial Rules

  @API @Regression @PayIQ  @WEB @SingleCurrency @2831
  Scenario: 2831 - GenerateAccessorialPayJob- Customer Invoice Accessorial- Accessorial Rules

    When Login into Salesforce

#    Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "PayIQProgram Individual Load Revenue (Quoted)" from Search List

   # Step 2
    Then Click on Edit icon on Label "Status"
    Then Update details
          |Status|
          |Open|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Open|
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 3 & 4
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Accessorial Rules" section
    Then Update details
      | Type                         | Accessorial | Rule                     | Amount |
      | Customer Invoice Accessorial | Stop Off    | Amount Per Unit/Quantity | 14.75  |
    Then Click on "SaveEdit" button

    #Step 5
    Then Verify Message displaying as "Accessorial Rule-"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Customer Invoice Accessorial" and "Accessorial" as "Stop Off"
    Then Wait for "4" Seconds
    Then Get Details
    |Accessorial Rule ID|
    |                   |
    Then Set "Accessorial Rule ID1" with "SysData=>Accessorial Rule ID"
    Then Capture the current URL for "Accessorial_Rules_1"
    Then Set Key "Accessorial_Rules_SFID_1" page Record Id with "rtms9__Accessorial_Rule__c"

    #Step 6
    Then Open "PayIQ Programs" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "PayIQProgram Individual Load Revenue (Invoiced)" from Search List

    #Step 7
    Then Click on Edit icon on Label "Status"
    Then Update details
      |Status|
      |Open|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Status|
      |Open|
    Then Capture the current URL for "PayIQ_Program_2"

    #Step 8 & 9
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on link "Accessorial Rules"
    Then Click on button "New"
    Then Wait for "3" Seconds
    Then Update details
      | Type                         | Accessorial | Rule                   | Percent |
      | Customer Invoice Accessorial | Stop Off    | Percent of Accessorial | 10.1    |
    Then Click on "SaveEdit" button

    #Step 10
    Then Verify Message displaying as "Accessorial Rule-"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Scroll down with "3" Times
    Then Click on "Accessorial Rule-" with "Type" as "Customer Invoice Accessorial" and "Accessorial" as "Stop Off"
    Then Wait for "4" Seconds
    Then Get Details
      |Accessorial Rule ID|
      |                   |
    Then Set "Accessorial Rule ID2" with "SysData=>Accessorial Rule ID"
    Then Capture the current URL for "Accessorial_Rules_2"
    Then Set Key "Accessorial_Rules_SFID_2" page Record Id with "rtms9__Accessorial_Rule__c"

#    #Step 11
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer       | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova PayIQ | Truckload | Dry Van 53'    | N             | N                 |
    Then Update details
      |Fleet|
      |True |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Indianapolis Colts | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Feathers     | 400   | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 12 & 13
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact) | Custom PayIQ Eligible Date |Carrier Sales Rep|Customer Sales Rep|
      | Joe Revenova PayIQ   | 0                          |User User        |Test User0        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact) |
      | Joe Revenova PayIQ   |

    #Step 14
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Customer Invoices"
    Then Click on button "New"
    Then Wait for "3" Seconds

    #Step 15 & 16
    Then Update details
      | Invoice Number | Invoice Date | Invoice Status | Invoice Due Date |
      | 2831           | 0            | Approved       | 7                |
    Then Wait for "2" Seconds
    Then Scroll into Section "Invoice Summary"
    Then Update details
      | Invoice Total |
      | 10            |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Message displaying as "Customer Invoice \"2831\" was created."
    Then Wait for "1" Seconds

    #Step 17
    Then Click on Partial Link Text "2831" on Page
    Then Wait for "2" Seconds

    #Step 18
    Then Go to "Related" Tab
    Then Click on link "Customer Invoice Accessorials"
    Then Click on button "New"
    Then Wait for "3" Seconds

    #Step 19 & 20
    Then Select "Stop Off" from "Accessorials" list and click on "Add to Pickup Stop 1 >>"
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Invoice_Accessorial"

    #Step 21
    Then Update the "Stop Off" accessorial data for row 1
      | Qty  | Unit Price | Payable | Unit    |
      | 4.00 | 5          | True    | Per Cwt |
    Then Wait for "3" Seconds

    #Step 22 & 23
    Then Navigate to stored URL for "Customer_Invoice_Accessorial"
    Then Wait for "3" Seconds
    Then Select "Stop Off" from "Accessorials" list and click on "Add to Delivery Stop 2 >>"
    Then Wait for "2" Seconds
    Then Update the "Stop Off" accessorial data for row 2
      | Qty  | Unit Price | Unit    |
      | 4.00 | 7          | Per Cwt |
    Then Wait for "3" Seconds

    #Step 24
    Then Navigate to stored URL for "Customer_Invoice_Accessorial"
    Then Wait for "3" Seconds
    Then Select "Stop Off" from "Accessorials" list and click on "Add to Invoice >>"
    Then Wait for "2" Seconds

    #Step 25 & 26
    Then Update the "Stop Off" accessorial data for row 3
      | Qty  | Unit Price | Payable | Unit    |
      | 8.00 | 7.5        | True    | Per Cwt |
    Then Wait for "3" Seconds

    #Step 27
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    Then Wait for "10" Seconds
    #Step 28#Step 29
    Then Open "Pay Headers" from App Launcher
    Then Set Payroll "Current" Month Range on To "Current_Month_Range"
    Then Get "Name" from "rtms9__Pay_Header__c" using "rtms9__Participant_Name__c" with contains "Joe Revenova PayIQ (Contact)" & "rtms9__Payroll_Description__c" with contains "SysData=>Current_Month_Range" and Store into "PayHeaderID"
    Then Search and Select "SysData=>PayHeaderID" from List
    Then Wait for "2" Seconds
    Then Capture the current URL for "Pay_Header"

    #Step 30
    Then Scroll Until Related List for "Pay Details"

    #Expected result a
    Then Click on "Pay Detail-" with "Accessorial" as "Stop Off" and "Qty" as "4"
    Then Verify Details
      | Pay Amount | Accessorial | PayIQ Program                                 | Accessorial Rule              |
      | USD 59.00  | Stop Off    | PayIQProgram Individual Load Revenue (Quoted) | SysData=>Accessorial Rule ID1 |

    Then Navigate to stored URL for "Pay_Header"
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Accessorial" as "Stop Off" and "Qty" as "8"
    Then Verify Details
      | Pay Amount | Accessorial | PayIQ Program                                 | Accessorial Rule              |
      | USD 118.00 | Stop Off    | PayIQProgram Individual Load Revenue (Quoted) | SysData=>Accessorial Rule ID1 |

    Then Navigate to stored URL for "Pay_Header"
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Accessorial" as "Stop Off" and "Qty" as "$20.00"
    Then Verify Details
      | Pay Amount | Accessorial | PayIQ Program                                   | Accessorial Rule              |
      | USD 2.02   | Stop Off    | PayIQProgram Individual Load Revenue (Invoiced) | SysData=>Accessorial Rule ID2 |

    Then Navigate to stored URL for "Pay_Header"
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Accessorial" as "Stop Off" and "Qty" as "$60.00"
    Then Wait for "3" Seconds
    Then Verify Details
      | Pay Amount | Accessorial | PayIQ Program                                   | Accessorial Rule              |
      | USD 6.06   | Stop Off    | PayIQProgram Individual Load Revenue (Invoiced) | SysData=>Accessorial Rule ID2 |
