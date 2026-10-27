Feature: 3082 - Vendor Invoice Trigger- Invoice Status

  @Regression @TMS @Smoke @WEB @SingleCurrency @Vendor_Invoice @3082 @Vendor
  Scenario: 3082 - Vendor Invoice Trigger- Invoice Status

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
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "100"
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
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Open "Vendor Invoices" using value from "1L" on QuoteInvoice Tab

    #Step 5 & Expected Result A
    Then Verify Details
    |Invoice Status|
    |Pending|
    Then Capture the current URL for "Vendor Invoice"

    #Step 6
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "1" Seconds
    Then Scroll down with "5" Times
    Then Click on link "Vendor Payments"
    Then Click on button "New"
    Then Wait for "1" Seconds
    Then Update details
        |Vendor           |Load       |Payment Amount|Description|Payment Type|
        |Email Carrier One|SysData=>1L|100           |Go Sandhogs|Other       |
    Then Wait for "2" Seconds
    Then Update details
      |Status|
      |Issued|
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Vendor Payment \"Go Sandhogs\" was created."

      #Step 7
    Then Navigate to stored URL for "Vendor Invoice"
    #Expected Result b
    Then Verify Details
      |Invoice Status|
      |Paid|
    
    #Step 8
     Then Go to "Related" Tab on Next to "Details" Tab
     Then Wait for "2" Seconds
     Then Scroll down with "3" Times 
     Then Click on link "Vendor Payments"
     Then Wait for "1" Seconds
     Then Click on "Go Sandhogs" with Text
     Then Click on Edit icon on Label "Payment Amount"
     Then Update details
     |Payment Amount|
     |50            |
     Then Click on "SaveEdit" button
    Then Verify Details
      |Payment Amount|
      |USD 50.00|

     #Step 9
    Then Navigate to stored URL for "Vendor Invoice"
    #Expected Result b
    Then Verify Details
      |Invoice Status|
      |Short Paid|
