Feature: 3083 - Vendor Invoice Trigger- Remit To + Vendor Synchronization

  @Regression @TMS @Smoke @WEB @SingleCurrency @Vendor_Invoice @3083 @Vendor
  Scenario: 3083 - Vendor Invoice Trigger- Remit To + Vendor Synchronization

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
    Then Wait for "6" Seconds
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
    Then Capture the current URL for "Load_Details"
#    Then Open Load Number "L-51"
    #Step 4
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Open "Vendor Invoices" using value from "1L" on QuoteInvoice Tab
    Then Verify Text displaying as "Vendor Invoice Summary"
    Then Capture the current URL for "Vendor Invoice"

    #Step 5
    Then Open "Edit Page" from Setup Icon
    Then Wait for "5" Seconds
    #Step 6
    Then Edit LRP - Make "Remit To" Field as "none" Field under UI Behavior
    Then Edit LRP - "Save" Changes
    #Step 7
    Then Navigate to stored URL for "Vendor Invoice"
    Then Click on Edit icon on Label "Remit To"
    Then Update details
    |Remit To|
    |        |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    #Expected a
    Then Verify Details
      |Remit To|
      |Email Carrier One|

    #Step 8
    Then Navigate to stored URL for "Load_Details"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Vendor Invoices"
    Then Click on button "New"
    Then Wait for "3" Seconds
    Then Update details
      |Vendor           |
      |Email Carrier One|
    Then Wait for "1" Seconds
    Then Update details
      |Invoice Number|Invoice Date|Invoice Status|
      |testing       |0           |Pending|
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Vendor Invoice \"testing\" was created."
    Then Wait for "1" Seconds

    #Step 9
    Then Click on "testing" with Text
    Then Wait for "2" Seconds
 #Expected b
    Then Verify Details
      |Remit To|
      |Email Carrier One|



