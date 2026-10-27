Feature: 3354 - Customer Payment Trigger- Customer Invoice Rollup Fields: Insert/Update/Delete

  @Regression @Priority_1 @TMS @WEB @SingleCurrency @Customer @Customer_Invoice @Customer_Payment @3354
  Scenario: 3354 - Customer Payment Trigger- Customer Invoice Rollup Fields: Insert/Update/Delete

    When Login into Salesforce

    # Steps 1-2: Create and save the quick entry truckload shipment.
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Denver Deli Meats  | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Seattle Mariners | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Mixed       | 13000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Wait for "3" Seconds

    # Steps 3: Accept the customer quote and approve billing.
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "250"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    # Steps 4
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "4" Seconds
    Then Capture the current URL for "Customer_Invoice_Page"
    #step 5
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "3" Seconds
    Then Scroll down with "5" Times
    Then Click on link "Customer Payments"
    Then Wait for "3" Seconds
    Then Click on button "New"
    Then Wait for "3" Seconds
    Then Update details
      | Load       | Payment Amount | Description            |
      | SysData=>1L | 250            | Customer Payment 3354  |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Wait for "4" Seconds

    # Step 6
    Then Navigate to stored URL for "Customer_Invoice_Page"
    Then Wait for "4" Seconds
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Information"
    Then Wait for "2" Seconds
    Then Click on link for label "Load"
    Then Wait for "4" Seconds
    #Step 7
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Scroll into Section "Quote/Invoice Rollups"
    Then Wait for "5" Seconds
    Then Verify "Customer Payment Total" having value of "USD 250.00"
    Then Verify "Customer Invoice Total" having value of "USD 1,250.00"
    Then Verify "Customer Invoice Transportation Total" having value of "USD 1,250.00"
    Then Verify "Customer Invoice Freight Amount" having value of "USD 1,000.00"
    Then Verify "Customer Invoice Fuel Amount" having value of "USD 250.00"
    Then Verify "Customer Invoice Tax Amount" having value of "USD 0.00"

    # Steps 8
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "4" Seconds
    #step 9
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "3" Seconds
    Then Scroll down with "5" Times
    Then Click on link "Customer Payments"
    Then Wait for "3" Seconds
    Then Click on "Customer Payment: Description""Customer Payment 3354" on "Customer Payments"
    Then Wait for "3" Seconds
    Then Click on Edit icon on Label "Payment Amount"
    Then Wait for "2" Seconds
    Then Update details
      | Payment Amount |
      | 1000           |
    Then Click on "SaveEdit" button


    #Step 10
    Then Wait for "4" Seconds
    Then Navigate to stored URL for "Customer_Invoice_Page"
    Then Wait for "4" Seconds
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Information"
    Then Wait for "2" Seconds
    Then Click on link for label "Load"
    Then Wait for "4" Seconds

    #Step 11
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Scroll into Section "Quote/Invoice Rollups"
    Then Wait for "5" Seconds
    Then Verify "Customer Payment Total" having value of "USD 1,000.00"
    Then Verify "Customer Invoice Total" having value of "USD 1,250.00"
    Then Verify "Customer Invoice Transportation Total" having value of "USD 1,250.00"
    Then Verify "Customer Invoice Freight Amount" having value of "USD 1,000.00"
    Then Verify "Customer Invoice Fuel Amount" having value of "USD 250.00"
    Then Verify "Customer Invoice Tax Amount" having value of "USD 0.00"

    # Steps 12
    Then Go to "Quotes/Invoices" Tab
    Then Wait for "3" Seconds
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    #step 13
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "4" Seconds
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "3" Seconds
    Then Scroll down with "5" Times
    Then Click on link "Customer Payments"
    Then Wait for "3" Seconds
    #step 14
    Then Delete Records with Row having "Customer Payment 3354"
    Then Wait for "5" Seconds
    Then Navigate to stored URL for "Customer_Invoice_Page"
    Then Wait for "4" Seconds
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Information"
    Then Wait for "2" Seconds
    Then Click on link for label "Load"
    Then Wait for "4" Seconds
    #step 15
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Scroll into Section "Quote/Invoice Rollups"
    Then Wait for "5" Seconds
    Then Verify "Customer Payment Total" having not contains value of "USD"
    Then Verify "Customer Invoice Total" having value of "USD 1,250.00"
    Then Verify "Customer Invoice Transportation Total" having value of "USD 1,250.00"
    Then Verify "Customer Invoice Freight Amount" having value of "USD 1,000.00"
    Then Verify "Customer Invoice Fuel Amount" having value of "USD 250.00"
    Then Verify "Customer Invoice Tax Amount" having value of "USD 0.00"