Feature: 3353 - Carrier Payment Trigger- Carrier Invoice Rollup Fields: Insert/Update/Delete

  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier_Payment @3353 @Carrier
  Scenario: 3353 - Carrier Payment Trigger- Carrier Invoice Rollup Fields: Insert/Update/Delete

    When Login into Salesforce
    #Steps1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Denver Deli Meats | Truckload | Dry Van 53             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Mixed     | 13000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

     # Step 2
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

   # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier Three - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 4
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered   |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      |Load Status      |
      |Delivered   |

    #Step 5 & 6
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Open "Vendor Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Capture the current URL for "Vendor Invoice"

    #Step 7
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "1" Seconds
    Then Scroll down with "5" Times
    Then Click on link "Vendor Payments"
    Then Click on button "New"
    Then Wait for "2" Seconds

    #Step 8
    Then Verify details for all Enabled fields
         |Vendor Invoice|
         |SysData=>1L|

    Then Update details
        |Vendor             |Load       |Vendor Invoice|Payment Amount|Recipient              |Description             |Payment Type|
        |Email Carrier Three|SysData=>1L|SysData=>1L   |200           |Tom Email Carrier Three|Test Vendor Invoice 3353|Other       |
    Then Wait for "2" Seconds
    Then Update details
      |Status|Discount|
      |Issued|100     |

    #Step 9
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Vendor Payment \"Test Vendor Invoice 3353\" was created."

    #Step 10
    Then Navigate to stored URL for "Vendor Invoice"

    #Step 11
    Then Scroll into Section "Invoice Summary"
    #Expected Result a
    Then Verify Details
      |Payment Discount Taken|Paid Amount|Balance Due|
      |USD 100.00|    USD 200.00         |USD 800.00|
    
    #Step 12
     Then Go to "Related" Tab on Next to "Details" Tab
     Then Wait for "2" Seconds
     Then Scroll down with "3" Times 
     Then Click on link "Vendor Payments"
     Then Wait for "1" Seconds
     Then Click on "Test Vendor Invoice 3353" with Text
     #Step 13
     Then Click on Edit icon on Label "Payment Amount"
     Then Update details
     |Payment Amount|Discount|
     |400           |200     |
    #Step 14
     Then Click on "SaveEdit" button
    #Step 15
    Then Navigate to stored URL for "Vendor Invoice"
    Then Scroll into Section "Invoice Summary"
    #Expected Result b
    Then Verify Details
      |Payment Discount Taken|Paid Amount|Balance Due|
      |USD 200.00|    USD 400.00         |USD 600.00|

     #Step 16
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Vendor Payments"
    Then Wait for "1" Seconds
    Then Click on "Test Vendor Invoice 3353" with Text
     #Step 17
    Then Click on Edit icon on Label "Payment Amount"
    Then Update details
      |Discount|
      |     |
    #Step 18
    Then Click on "SaveEdit" button
    #Step 19
    Then Navigate to stored URL for "Vendor Invoice"
    Then Scroll into Section "Invoice Summary"
    #Expected Result b
    Then Verify Details
      |Payment Discount Taken|Paid Amount|Balance Due|
      |USD 0.00              |USD 400.00 |USD 600.00|


