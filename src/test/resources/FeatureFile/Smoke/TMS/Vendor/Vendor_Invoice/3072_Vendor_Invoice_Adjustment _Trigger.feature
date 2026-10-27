Feature: 3072 - Vendor Invoice Adjustment Trigger-Adjustments Field: Insert/Update/Delete

  @Regression @TMS @Smoke @WEB @SingleCurrency @Vendor @3072 @VendorInvoice
  Scenario: 3072 - Vendor Invoice Adjustment Trigger-Adjustments Field: Insert/Update/Delete

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
    Then Refresh current Page

    #Step 4
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Open "Vendor Invoices" using value from "1L" on QuoteInvoice Tab
    #Step 5
    Then Verify details for
      | Adjustments |
      | NA   |
    #Step 6
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Capture the current URL for "Vendor Invoice"
    Then Wait for "1" Seconds
    Then Click on "New" Button on "CarrierInvoiceAdjustment"
    Then Switch to Frame by Title "accessibility title"
    Then Click on Button with Value "Add" -
    Then Update details with Table -
      | Category | Description | Adjustment Amount |
      | Other    | testing       | 50.00             |
    Then Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    #Step 7
    Then Navigate to stored URL for "Vendor Invoice"
    Then Wait for "2" Seconds
    #Expected Result B
    Then Verify details for
      | Adjustments |
      | USD 50.00   |

     #Step 8
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "1" Seconds
    Then Click on "testing" with Text
    Then Switch to Frame by Title "accessibility title"
    Then Update details with Table -
      | Adjustment Amount |
      | 100.00             |
    Then Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    #Step 9
    Then Navigate to stored URL for "Vendor Invoice"
    Then Wait for "2" Seconds
    #Expected Result c
    Then Verify details for
      | Adjustments |
      | USD 100.00   |

      #Step 10
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "1" Seconds
    Then Click on "testing" with Text
    Then Switch to Frame by Title "accessibility title"
    Then Click on Button with Value "Clear All Adjustments" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    #Step 11
    Then Navigate to stored URL for "Vendor Invoice"
    Then Wait for "2" Seconds
    #Expected Result d
    Then Verify details for
      | Adjustments |
      | USD 0.00    |

   #Step 12
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Capture the current URL for "Vendor Invoice"
    Then Wait for "1" Seconds
    Then Click on "New" Button on "CarrierInvoiceAdjustment"
    Then Switch to Frame by Title "accessibility title"
    Then Click on Button with Value "Add" -
    Then Update details with Table -
      | Category | Description | Adjustment Amount |
      | Other    | testing       | 50.00             |
    Then Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    #Step 13
    Then Navigate to stored URL for "Vendor Invoice"
    Then Wait for "2" Seconds
    #Expected Result e
    Then Verify details for
      | Adjustments |
      | USD 50.00   |

    #Step 14
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Adjustments"
    Then Delete "Vendor Invoice Adjustments" with data "testing"
    Then Verify Message displaying as "Vendor Invoice Adjustment \"testing\" was deleted."
    #Step 15
    Then Navigate to stored URL for "Vendor Invoice"
    Then Wait for "2" Seconds
    #Expected Result d
    Then Verify details for
      | Adjustments |
      | USD 0.00    |