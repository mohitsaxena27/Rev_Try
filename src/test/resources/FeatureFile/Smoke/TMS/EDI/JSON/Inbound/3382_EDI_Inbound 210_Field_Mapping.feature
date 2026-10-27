Feature: 3382 - EDI Inbound 210- Field Mapping: Original (JSON)
  Background: Pre- Test
    Then Set key "Load3382A" for Object "rtms__Load__c" and Name "Load-3382A"
    Then Set key "Load3382B" for Object "rtms__Load__c" and Name "Load-3382B"
    Then Set key "Load3382C" for Object "rtms__Load__c" and Name "Load-3382C"
    Then Set key "Load3382D" for Object "rtms__Load__c" and Name "Load-3382D"
    Then Delete All Records with name "Load3382A" for "rtms__Load__c"
    Then Delete All Records with name "Load3382B" for "rtms__Load__c"
    Then Delete All Records with name "Load3382C" for "rtms__Load__c"
    Then Delete All Records with name "Load3382D" for "rtms__Load__c"
    
  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @3382
  Scenario: 3382 - EDI Inbound 210- Field Mapping: Original (JSON)

    When Login into Salesforce
   #Pre-conditions
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI|
      | True        |True                |
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "User User"

    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Freeze Load Number |
      | False              |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #  Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA           | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Verify Message displaying as "Save was successful."

   # Step 3
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3382A  |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3382A"
    Then Verify Details
      | Load Number |
      | Load-3382A  |
    Then Capture the current URL for "Load_1"

   # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Success Message displaying as "Load was assigned to carrier"

   # Step 5
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status | PRO Number |
      | Delivered   | PRO3382A   |
    Then Click on "Save" button on Details Page
    Then Verify "Load Status" having value of "Delivered"
    Then Verify "PRO Number" having value of "PRO3382A"

   # Step 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA           | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_2"

    # Step 7
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3382B  |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3382B"
    Then Verify Details
      | Load Number |
      | Load-3382B  |

   # Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Success Message displaying as "Load was assigned to carrier"

   # Step 9
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status | PRO Number |
      | Delivered   | PRO3382B   |
    Then Click on "Save" button on Details Page
    Then Verify "Load Status" having value of "Delivered"
    Then Verify "PRO Number" having value of "PRO3382B"

   # Step 10
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA            | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_3"


    # Step 11
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3382C  |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3382C"
    Then Verify Details
      | Load Number |
      | Load-3382C  |

   # Step 12
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "EDI Carrier Two - Truckload"
    Then "Assign" Carrier
    Then Verify Success Message displaying as "Load was assigned to carrier"

   # Step 13
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status | PRO Number |
      | Delivered   | PRO3382C   |
    Then Click on "Save" button on Details Page
    Then Verify "Load Status" having value of "Delivered"
    Then Verify "PRO Number" having value of "PRO3382C"

   # Step 14
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 4L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_4"


    # Step 15
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3382D  |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3382D"
    Then Verify Details
      | Load Number |
      | Load-3382D  |

   # Step 16
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "EDI Carrier Two - Truckload"
    Then "Assign" Carrier
    Then Verify Success Message displaying as "Load was assigned to carrier"

   # Step 17
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status | PRO Number |
      | Delivered   | PRO3382D   |
    Then Click on "Save" button on Details Page
    Then Verify "Load Status" having value of "Delivered"
    Then Verify "PRO Number" having value of "PRO3382D"

    #Step 18
    Then Send Post Request for EDI with Json "Create_Invoice_3382.txt" with Access Token as "Access_Token"
    Then Wait for "40" Seconds

    # Step 19 Expected result a
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions" -
    Then Verify "EDI Transactions" "Transaction Type" is displaying as "210"

    # Step 20
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Vendor Invoices"
    Then Wait for "2" Seconds
    Then Click on "INV3382A" with Text
    Then Wait for "3" Seconds
    Then Capture the current URL for "Vendor Invoice"

    # Step 21  Expected result b
    Then Go to "Details" Tab
    Then Verify Details
      | Invoice Number | Payee Reference | Invoice Date | Invoice Due Date | Invoice Status |
      | INV3382A       | INV3382A        | 10/1/2023    | 10/15/2023       | Pending        |
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Freight Charges | Freight Surcharge | Discount | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Adjustments | Invoice Total |
      | USD 1,200.00    |                   |          | USD 1,200.00        | USD 300.00     | USD 450.00          |             | USD 1,950.00  |
    Then Scroll into Section "Unit Information"
    Then Verify Details
      | Freight Charge Quantity | Freight Charge Unit | Freight Charge Unit Price | Fuel Surcharge Quantity | Fuel Surcharge Unit | Fuel Surcharge Unit Price |
      | 1,200.00                | Per Mile            | USD 1.00                  | 1,200.00                | Per Mile            | USD 0.25                  |
    Then Scroll into Section "EDI 210/410 Information"
    Then Verify Details
      | Origin Name | Origin Street     | Origin City | Origin State | Origin Postal Code | Origin Country |
      | XYZ Shipper | 2333 Waukegan Rd. | Bannockburn | IL           | 60045              | United States  |
    Then Verify Details
      | Destination Name | Destination Street | Destination City | Destination State | Destination Postal Code | Destination Country |
      | ABC Consignee    | 526 Beacon Street  | Boston           | MA                | 02215                   | United States       |

    # Step 22 #Expected results c
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Click on "After Hours Delivery" with Text
    Then Wait for "5" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Accessorial table should match:
      | Accessorial              | Qty  | Unit              | Unit price | Charge     | Stop   |
      | After Hours Delivery     | 1.00 | Fixed Cost        | 75.00      | USD 75.00  | Stop 2 |
      | Unknown Accessorial Name | 5.00 | Per Handling Unit | 75.00      | USD 375.00 |        |
    Then Switch to Parent Frame
    Then Navigate to stored URL for "Vendor Invoice"
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds

    # Step 23 Expected results.d
    Then Verify "Vendor Invoice Freight Charge Items" Table With Details
      | Item Description        | NMFC Class (Rated As) | Quantity | Rate     | Unit     | Freight Charge | Weight | Weight Units |
      | Commodity AAA           | 50                    | 10.00    | USD 0.25 | Per Mile | USD 100.00     | 100    | lbs          |
      | 60# Red Potato          | 55                    | 20.00    | USD 1.25 | Per Mile | USD 100.00     | 100    | lbs          |
      | 5/10 Poly Russet Potato | 60                    | 20.00    | USD 1.25 | Per Mile | USD 100.00     | 100    | lbs          |

  # Step 24
    Then Navigate to stored URL for "Load_2"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Click on link "Vendor Invoices"
    Then Click on "INV3382B" with Text
    Then Capture the current URL for "Vendor Invoice"

  # Step 25  Expected results e
    Then Verify Details
      | Invoice Number | Payee Reference | Invoice Date | Invoice Due Date | Invoice Status |
      | INV3382B       | INV3382B        | 11/1/2023    | 11/15/2023       | Pending        |
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Freight Charges | Freight Surcharge | Discount | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Adjustments | Invoice Total |
      | USD 1,300.00    |                   |          | USD 1,300.00        | USD 325.00     | USD 455.00          |             | USD 2,080.00  |
    Then Scroll into Section "Unit Information"
    Then Verify Details
      | Freight Charge Quantity | Freight Charge Unit | Freight Charge Unit Price | Fuel Surcharge Quantity | Fuel Surcharge Unit | Fuel Surcharge Unit Price |
      | 1,300.00                | Per Mile            | USD 1.00                  | 1,300.00                | Per Mile            | USD 0.25                  |
    Then Scroll into Section "EDI 210/410 Information"
    Then Verify Details
      | Origin Name | Origin Street     | Origin City | Origin State | Origin Postal Code | Origin Country |
      | 123 Shipper | 2333 Waukegan Rd. | Bannockburn | IL           | 60045              | United States  |
    Then Verify Details
      | Destination Name | Destination Street | Destination City | Destination State | Destination Postal Code | Destination Country |
      | 456 Shipper      | 526 Beacon Street  | Boston           | MA                | 02215                   | United States       |

    # Step 26 Expected result f
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Click on "After Hours Delivery" with Text
    Then Wait for "5" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Accessorial table should match:
      | Accessorial              | Qty  | Unit              | Unit price | Charge     | Stop   |
      | After Hours Delivery     | 1.00 | Fixed Cost        | 80.00      | USD 80.00  | Stop 2 |
      | Unknown Accessorial Name | 5.00 | Per Handling Unit | 75.00      | USD 375.00 |        |
    Then Switch to Parent Frame
    Then Navigate to stored URL for "Vendor Invoice"
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds

    # Step 27 Expected results g
    Then Verify "Vendor Invoice Freight Charge Items" Table With Details
      | Item Description | NMFC Class (Rated As) | Quantity | Rate     | Unit     | Freight Charge | Weight | Weight Units |
      | Grapes           | 50                    | 10.00    | USD 0.25 | Per Mile | USD 100.00     | 100    | lbs          |
      | Cucumbers        | 55                    | 20.00    | USD 1.25 | Per Mile | USD 100.00     | 100    | lbs          |
      | Oranges          | 60                    | 20.00    | USD 1.25 | Per Mile | USD 100.00     | 100    | lbs          |

   #Step 28
    Then Navigate to stored URL for "Load_3"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Vendor Invoices"
    Then Wait for "2" Seconds
    Then Click on "INV3382C" with Text
    Then Capture the current URL for "Vendor Invoice"

  # Step 29  Expected results h
    Then Go to "Details" Tab
    Then Verify Details
      | Invoice Number | Payee Reference | Invoice Date | Invoice Due Date | Invoice Status |
      | INV3382C       | INV3382C        | 10/3/2023    | 10/18/2023       | Pending        |
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Freight Charges | Freight Surcharge | Discount | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Adjustments | Invoice Total |
      | USD 1,100.00    |                   |          | USD 1,100.00        | USD 275.00     |                     |             | USD 1,375.00  |
    Then Scroll into Section "Unit Information"
    Then Verify Details
      | Freight Charge Quantity | Freight Charge Unit | Freight Charge Unit Price | Fuel Surcharge Quantity | Fuel Surcharge Unit | Fuel Surcharge Unit Price |
      | 1,100.00                | Per Mile            | USD 1.00                  | 1,100.00                | Per Mile            | USD 0.25                  |
    Then Scroll into Section "EDI 210/410 Information"
    Then Verify Details
      | Origin Name | Origin Street     | Origin City | Origin State | Origin Postal Code | Origin Country |
      | Shipper A   | 2333 Waukegan Rd. | Bannockburn | IL           | 60045              | United States  |
    Then Verify Details
      | Destination Name | Destination Street | Destination City | Destination State | Destination Postal Code | Destination Country |
      | Shipper B        | 526 Beacon Street  | Boston           | MA                | 02215                   | United States       |

   # Step 30 Expected results i
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Verify No Records Available with "Vendor Invoice Accessorials"

    # Step 31 Expected results j
    Then Verify "Vendor Invoice Freight Charge Items" Table With Details
      | Item Description | NMFC Class (Rated As) | Quantity | Rate     | Unit     | Freight Charge | Weight | Weight Units |
      | Kiwi             | 50                    | 10.00    | USD 0.25 | Per Mile | USD 120.00     | 100    | lbs          |
      | Strawberries     | 55                    | 20.00    | USD 1.25 | Per Mile | USD 100.00     | 100    | lbs          |
      | Lemons           | 60                    | 20.00    | USD 1.25 | Per Mile | USD 100.00     | 100    | lbs          |

   # Step 32
    Then Navigate to stored URL for "Load_4"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Vendor Invoices"
    Then Wait for "2" Seconds
    Then Click on "INV3382D" with Text
    Then Capture the current URL for "Vendor Invoice"

    # Step 33 Expected results k.
    Then Go to "Details" Tab
    Then Verify Details
      | Invoice Number | Payee Reference | Invoice Date | Invoice Due Date | Invoice Status |
      | INV3382D       | INV3382D        | 11/3/2023    | 11/18/2023       | Pending        |
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Freight Charges | Freight Surcharge | Discount | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Adjustments | Invoice Total |
      | USD 1,100.00    |                   |          | USD 1,100.00        | USD 275.00     |                     |             | USD 1,375.00  |
    Then Scroll into Section "Unit Information"
    Then Verify Details
      | Freight Charge Quantity | Freight Charge Unit | Freight Charge Unit Price | Fuel Surcharge Quantity | Fuel Surcharge Unit | Fuel Surcharge Unit Price |
      | 1,100.00                | Per Mile            | USD 1.00                  | 1,100.00                | Per Mile            | USD 0.25                  |
    Then Scroll into Section "EDI 210/410 Information"
    Then Verify Details
      | Origin Name | Origin Street | Origin City | Origin State | Origin Postal Code | Origin Country |
      |             |               |             |              |                    |                |
    Then Verify Details
      | Destination Name | Destination Street | Destination City | Destination State | Destination Postal Code | Destination Country |
      |                  |                    |                  |                   |                         |                     |

    # Step 34     Expected results l
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds

    # Step 35    Expected results m
    Then Verify No Records Available with "Vendor Invoice Accessorials"
    Then Verify No Records Available with "Vendor Invoice Freight Charge Items"





