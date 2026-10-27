Feature: 3094 - Vendor Invoice Trigger - Vendor Invoice Total Field: Insert/Update/Delete

  @Regression @TMS @Smoke @WEB @SingleCurrency @Customer_Invoice @3094 @Vendor
  Scenario: 3094 - Vendor Invoice Trigger - Vendor Invoice Total Field: Insert/Update/Delete

    When Login into Salesforce
    #Steps1
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details

   # Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "100"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "100"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 3
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Completed   |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Completed"
    Then Verify Details
      |Load Status      |
      |Completed   |

    #Step 4
    Then Scroll into Section "Quote/Invoice Rollups"
    #Expected a
    Then Verify Details
      |Carrier Invoice Total  |
      |USD 200.00          |
    Then Refresh current Page

    #Step 5
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Open "Vendor Invoices" using value from "1L" on QuoteInvoice Tab

    #Step 6
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Click on button "New"
    Then Wait for "2" Seconds

    #Step 7
    Then Select "Customs" from "Accessorials" list and click on "Add to Invoice >>"
    Then Update the "Customs" accessorial data
      | Qty  | Unit       | Unit Price |
      | 1.00 | Fixed Cost | 50.00      |
    Then Wait for "2" Seconds

    #Step 8
    Then Open Load with "1L_LoadURL"
    Then Go to "Details" Tab
    Then Scroll into Section "Quote/Invoice Rollups"
    #Expected a
    Then Verify Details
      |Carrier Invoice Total  |
      |USD 250.00          |
    Then Refresh current Page

    #Step 9
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Open "Vendor Invoices" using value from "1L" on QuoteInvoice Tab

    #Step 10
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Click the "Customs" from grid
    Then Update the "Customs" accessorial data
      | Unit Price |
      | 150.00 |

    #Step 11
    Then Open Load with "1L_LoadURL"
    Then Go to "Details" Tab
    Then Scroll into Section "Quote/Invoice Rollups"
    #Expected a
    Then Verify Details
      |Carrier Invoice Total  |
      |USD 350.00          |
    Then Refresh current Page

    #Step 12
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Open "Vendor Invoices" using value from "1L" on QuoteInvoice Tab

    #Step 13
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Delete "Vendor Invoice Accessorials" with data "Customs"
    Then Verify Message displaying as "Vendor Invoice Accessorial \"Customs\" was deleted."
    #Step 14
    Then Open Load with "1L_LoadURL"
    Then Go to "Details" Tab
    Then Scroll into Section "Quote/Invoice Rollups"
    #Expected a
    Then Verify Details
      |Carrier Invoice Total  |
      |USD 200.00          |
