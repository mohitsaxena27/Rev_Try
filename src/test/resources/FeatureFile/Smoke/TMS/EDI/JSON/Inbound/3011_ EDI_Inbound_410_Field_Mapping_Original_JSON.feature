Feature: 3011_ EDI_Inbound_410_Field_Mapping_Original_JSON

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @3011
  Scenario:  3011 - EDI Inbound 410- Field Mapping: Original JSON

    When Login into Salesforce

   #Pre-conditions
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI |
      | True        | True                 |
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

    # Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode       | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Intermodal | NA             | N             | N                 |

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
    Then Capture the current URL for "Load_1"

    # Step 3
    Then Go to "Details" Tab
    Then Scroll into Section with Title "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3011B  |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3011B"
    Then Verify Details
      | Load Number |
      | Load-3011B  |

    # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"

    # Step 5
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status | Waybill Number |
      | Delivered   | WBN3011A       |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify "Load Status" having value of "Delivered"
    Then Verify "Waybill Number" having value of "WBN3011A"

    # Step 6
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode       | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Boston Beans | Intermodal | NA             | N             | N                 |

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
    Then Scroll into Section with Title "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-3011A  |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3011A"
    Then Verify Details
      | Load Number |
      | Load-3011A  |

    # Step 8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter Carrier Service as "Rail EDI Carrier One - Intermodal"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"

    # Step 9
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status | Waybill Number |
      | Delivered   | WBN3011A       |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify "Load Status" having value of "Delivered"
    Then Verify "Waybill Number" having value of "WBN3011A"

  #Step 10,
    Then Open "EDI Transactions" from App Launcher
    Then Wait for "1" Seconds

  # Step 11
    Then Click on button with Title "New"
    Then Get "Create_Invoice_3011.txt" files and update below Attributes
      | No Update Required |
      |                    |
    Then Wait for "3" Seconds
    Then Update details
      | Load       | Trading Partner      | EDI Location | Transaction Type | Purpose  | Direction | EDI Provider |
      | Load-3011A | Rail EDI Carrier One | REDIC1       | 410              | Original | Inbound   | Kleinschmidt |
    Then Click on "Transaction Payload" TextArea
    Then Enter Label "Transaction Payload" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Status  |
      | Failure |
    # Step 12
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."

    #Step 13,14
    Then Scroll into Section "EDI Provider Status"
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status  |
      | Pending |
    Then Click on "SaveEdit" button
    Then Wait for "60" Seconds

  # Step 15  Expected results a

    Then Navigate to stored URL for "Load_2"
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "410" and "Direction" as "Inbound"
    Then Verify Details
      | Transaction Type | Purpose | Direction | Event Code |
      | 410              |Original  | Inbound   |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log |
      | Kleinschmidt | Success |            |

    #Step 16
    Then Navigate to stored URL for "Load_2"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Vendor Invoices"
    Then Wait for "2" Seconds
    Then Click on "INV3011A" with Text
    Then Capture the current URL for "Vendor Invoice"

    #Step 17 Expected result b
    Then Verify Details
      | Vendor               | Invoice Number | Payee Reference | Invoice Date | Invoice Due Date | Invoice Status |
      | Rail EDI Carrier One | INV3011A       | INV3011A        | 10/1/2023    | 10/15/2023       | Pending        |
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
    Then Verify Details
      | Ultimate Shipper Name | Ultimate Shipper Street | Ultimate Shipper State | Ultimate Shipper Postal Code | Ultimate Shipper Country |
      | ABC Shipper           | 526 Beacon St           | MA                     | 02215                        | United States            |
    Then Verify Details
      | Ultimate Consignee Name | Ultimate Consignee Street | Ultimate Consignee City | Ultimate Consignee State | Ultimate Consignee Postal Code | Ultimate Consignee Country |
      | ABC Consignee           | 100 Main Ct               | Springfield             | IL                       | 62702                          | United States              |
    Then Verify Details
      | Carrier Bill To Name | Carrier Bill To Street  | Carrier Bill To City | Carrier Bill To State | Carrier Bill To Postal Code | Carrier Bill To Country |
      | ABC Biilee           | 700 Place Leigh-Capreol | Dorval               | QC                    | H4Y1G7                      | Canada                  |

    #Step 18 Expected result c
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    Then Click on link "Vendor Invoice Accessorials"
    Then Click on "After Hours Delivery" with Text
    Then Wait for "5" Seconds
    Then Switch to Frame by Title "accessibility title"
    #Expected c
    Then Accessorial table should match:
      | Accessorial              | Qty  | Unit              | Unit price | Charge     | Stop   |
      | After Hours Delivery     | 1.00 | Fixed Cost        | 75.00      | USD 75.00  | Stop 2 |
      | Unknown Accessorial Name | 5.00 | Per Handling Unit | 75.00      | USD 375.00 |        |
    Then Switch to Parent Frame

   #Step 18 Expected result d
    Then Navigate to stored URL for "Vendor Invoice"
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "2" Seconds
    #Expected d
    Then Verify "Vendor Invoice Freight Charge Items" Table With Details
      | Item Description        | NMFC Class (Rated As) | Quantity | Rate     | Unit     | Freight Charge | Weight | Weight Units |
      | Commodity AAA           | 50                    | 10.00    | USD 0.25 | Per Mile | USD 100.00     | 100    | lbs          |
      | 60# Red Potato          | 55                    | 20.00    | USD 1.25 | Per Mile | USD 100.00     | 100    | lbs          |
      | 5/10 Poly Russet Potato | 60                    | 20.00    | USD 1.25 | Per Mile | USD 100.00     | 100    | lbs          |

    # Step 20 Expected result e
    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Scroll into Section "EDI Transactions" -
    Then Verify No Records Available with "EDI Transactions"
    




