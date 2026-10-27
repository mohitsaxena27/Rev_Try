Feature: 3067 - Vendor Invoice Accessorial Trigger - Acc Charges Field: Insert/Update/Delete

  @Regression @TMS @Smoke @WEB @SingleCurrency  @Vendor @3067 @VendorInvoice
  Scenario: 3067 - Vendor Invoice Accessorial Trigger - Acc Charges Field: Insert/Update/Delete


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
    Then Add "Stop 1" "Carrier Quote Items" "After Hours Pick Up" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "100"
    Then Add "Stop 2" "Carrier Quote Items" "After Hours Delivery" Accessorial with Unit as "Fixed Cost" Qty as "2" and Price "50"
    Then Add "Load" "Carrier Quote Items" "Blind Shipments" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "50"

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
    #Step 4 & 5
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Open "Vendor Invoices" using value from "1L" on QuoteInvoice Tab
    #Expected a
    Then Verify Details
      | Accessorial Charges |
      | USD 250.00          |
    Then Capture the current URL for "Vendor Invoice"

    #Step 6
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Click on button "New"
    Then Wait for "2" Seconds

    #Step 7
    Then Select "Customs" from "Accessorials" list and click on "Add to Invoice >>"
    Then Update the "Customs" accessorial data
      | Qty  | Unit Price |Unit|
      | 1.00 | 50.00      |Fixed Cost|
    Then Wait for "2" Seconds

    #Step 8
    Then Navigate to stored URL for "Vendor Invoice"

    #Expected b
    Then Verify Details
      | Accessorial Charges |
      | USD 300.00          |

    #Step 9
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Click the "Customs" from grid
     #Step 10
    Then Update the "Customs" accessorial data
      | Unit Price |
      | 100.00 |

    #Step 11
    Then Navigate to stored URL for "Vendor Invoice"
    Then Wait for "2" Seconds
    #Expected c
    Then Verify Details
      | Accessorial Charges |
      | USD 350.00          |

    #Step 12
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
     #Step 13
    Then Click the "Customs" from grid
    Then Click on Remove action for Accessorials "Customs"
    Then Wait for "3" Seconds
    #Step 16
    Then Navigate to stored URL for "Vendor Invoice"
    #Expected c
    Then Verify Details
      | Accessorial Charges |
      | USD 250.00          |

    #Step 15
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Delete Records with Row having "Blind Shipments"
    Then Verify Message displaying as "Vendor Invoice Accessorial \"Blind Shipments\" was deleted."
    #Step 16
    Then Navigate to stored URL for "Vendor Invoice"
    #Expected c
    Then Verify Details
      | Accessorial Charges |
      | USD 200.00          |
