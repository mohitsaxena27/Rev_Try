Feature: 259 - Customer Invoice- Payment Discount Taken

  @Regression @Smoke @WEB @SingleCurrency @Customer @Customer_Invoice @Customer_Payment @259
  Scenario: 259 - Customer Invoice- Payment Discount Taken

    When Login into Salesforce

    # Step 1
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

    # Step 2
    Then Save Load With All details
    Then Capture the current URL for "Load_Page"

    # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "5000"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    # Step 4
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Capture the current URL for "Customer_Invoice_Page"

    # Step 5
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "5" Times
    Then Click on link "Customer Payments"
    Then Click on button "New"
    Then Wait for "2" Seconds
    Then Update details
      | Load        | Payment Amount | Discount | Payment Type  | Description |
      | SysData=>1L | 200            | 100      | Company Check | testing 1   |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."

    # Step 6
    Then Navigate to stored URL for "Customer_Invoice_Page"
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "5" Times
    Then Click on link "Customer Payments"
    Then Click on button "New"
    Then Wait for "2" Seconds
    Then Update details
      | Load        | Payment Amount | Discount | Payment Type  | Description |
      | SysData=>1L | 200            | 100      | Company Check | testing 2   |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."

    # Step 7
    Then Navigate to stored URL for "Customer_Invoice_Page"
    Then Wait for "2" Seconds
    Then Scroll into Section "Invoice Summary"
    # Expected Result a
    Then Verify Details
      | Payment Discount Taken |
      | USD 200.00             |

    # Step 8
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "5" Times
    Then Click on link "Customer Payments"
    Then Delete Records with Row having "testing 1"
    Then Wait for "2" Seconds

    # Step 9
    Then Navigate to stored URL for "Customer_Invoice_Page"
    Then Wait for "2" Seconds
    Then Scroll into Section "Invoice Summary"
    # Expected Result b
    Then Verify Details
      | Payment Discount Taken |
      | USD 100.00             |
