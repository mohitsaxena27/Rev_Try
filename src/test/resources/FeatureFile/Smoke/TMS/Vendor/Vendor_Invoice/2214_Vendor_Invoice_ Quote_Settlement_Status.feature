Feature: 2214 - Vendor Invoice Creation via Vendor Quote Settlement - Status

  @Regression @TMS @Smoke @WEB @SingleCurrency @Vendor_Invoice @2214 @Vendor
  Scenario: 2214 - Vendor Invoice Trigger - Invoice Status

    When Login into Salesforce

   # Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL  | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Mixed       | 1234   | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

  # Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Go to "Vendor Quotes" Tab
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Vehicle Ordered Not Used" with Unit as "Fixed Cost" Qty as "1" and Price "50"

    # Step 3
    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "2" Seconds
    Then Set Vendor Quote value on to "Vendor_Quote_1"

    # Step 4
    Then Click on Vendor Quote from FQA Page
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Verify "Vendor Invoices" count displaying as "0"

  # Step 5 Expected Result A
    Then Click If button with Title "More Tabs" is enabled
    Then Go to "Settlement" Tab
    Then Click on Edit icon on Label "Settlement Status"
    Then Update details
      | Settlement Status    |
      | Approved for Payment |
    Then Click on "Save" button
    Then Wait for "10" Seconds
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Verify "Vendor Invoices" count displaying as "1"
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_1" on "Carrier_Quote_3"
    Then Open "Vendor Invoices" using value from "Carrier_Quote_3" on QuoteInvoice Tab
    Then Wait for "2" Seconds

 # Step 6 Expected result b
    Then Wait for "2" Seconds
    Then Go to "Summary" Tab
    Then Verify Details
      | Balance Due | Accessorial Charges |
      | USD 50.00   | USD 50.00           |
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "5" Seconds
    Then Verify "Vendor Invoice Accessorials" Table details with following Details
      | Name                     | Accessorial              | Charge    |
      | Vehicle Ordered Not Used | Vehicle Ordered Not Used | USD 50.00 |