Feature: 3744 - SMC3 EVA API Invoice Operation - Create Invoice Mapping

  @API  @TMS @Smoke @WEB @API_Operation @SingleCurrency @3744 @SMC3EVAAPI
  Scenario: 3744 - SMC3 EVA API Invoice Operation - Create Invoice Mapping

    When Login into Salesforce

    # Step1 & 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL  | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Kankakee Kayaks | 0             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Beans       | 10000  | NA           | NA       | NA             | NA     | NA    | NA             | NA             | NA         |
    Then Save Load With All details

    # step3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "EDI Carrier One - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    # Step 4
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Click on Edit icon on Label "PRO Number"
    Then Update details
      | PRO Number |
      | 523454     |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Wait for "PRO Number" Field Value Update with "523454"
    Then Verify Details
      | PRO Number |
      | 523454     |

    # step 5
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Get "Creating invoice.txt" files and update below Attributes
      | No Update Required |
      |                    |
    # Status defaults to Pending on the New Queued Transaction form.
    Then Update details -
      | Processor         | Direction | Content Type | Payload 1                   | Payload 2 |
      | SMC3 EVA INVOICE  | Inbound   | text/plain   | SysData=>{FinalUpdatedText} |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #step 6 Process the transaction.
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "10" Seconds

    # step 7 Open the invoice created against the retained load.
    Then Open Load with "1L_LoadURL"
    Then Refresh current Page
    Then Wait for "3" Seconds
    # step 8
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    #step 9
    Then Click on link "Vendor Invoices"
    Then Wait for "3" Seconds
    Then Click on "New Invoice 1" with Text
    Then Capture the current URL for "Vendor Invoice"

    # Expected result a and b.
    Then Go to "Details" Tab
    Then Wait for "3" Seconds
    Then Verify Details
      | Vendor             | Invoice Number | Payee Reference | Invoice Date | Invoice Status | Load              | Carrier          |
      | EDI Carrier One    | New Invoice 1  | New Invoice 1   | 4/14/2026    | Pending        | SysData=>1L       | EDI Carrier One  |
    Then Scroll into Section "Invoice Summary"
    Then Verify Details
      | Freight Charges | Discount     | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Invoice Total | Balance Due |
      | USD 1,752.92    | USD 1,609.18 | USD 143.74          | USD 73.59      | USD 41.50           | USD 258.83    | USD 258.83   |

    Then Scroll into Section "API Fields"
    Then Wait for "2" Seconds
    Then Verify Details
      | Transaction Id                              | Discount Percent | Incoming Net Freight Charge |
      | 210-WARD-781799411-159-001590002-6113232613 | 91.80%           | USD 143.74                   |
    Then Scroll into Section "EDI 210/410 Information"
    Then Wait for "3" Seconds
    Then Verify Details
      | Origin Name             | Origin Street        | Origin City    | Origin State | Origin Postal Code | Origin Country | Destination Name        | Destination Street | Destination City | Destination State | Destination Postal Code | Destination Country |
      | SOUTHERN MOTOR CARRIERS | 653 LEXINGTON CIRCLE | PEACHTREE CITY | GA           | 30269              | United States  | SOUTHERN MOTOR CARRIERS | 200 HIGH RISE DRIVE | LOUISVILLE       | KY                | 40213                   | United States       |
    Then Verify Details
      | Carrier Bill To Name                   | Carrier Bill To Street | Carrier Bill To City | Carrier Bill To State | Carrier Bill To Postal Code | Carrier Bill To Country |
      | SOUTHERN MOTOR CARRIERS GRP - 3PTY     | 653 LEXINGTON CIRCLE  | PEACHTREE CITY       | GA                    | 30269                       | United States            |

    #Step 10
    # Expected result c.
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Wait for "3" Seconds
    Then Verify "Vendor Invoice Accessorials" Table details with following Details
      | Name                    | Accessorial | Charge     |
      | NOTIFY FEE SP           | Other       | USD 15.00  |
    Then Verify "Vendor Invoice Accessorials" Table details with following Details
      | Name                    | Accessorial | Charge     |
      | REWEIGHT AND INSPECTION | Other       | USD 26.50  |

    # Expected result d.
    Then Verify "Vendor Invoice Freight Charge Items" Table With Details
      | Item Description                | NMFC Class (Rated As) | Quantity | Rate         | Unit       | Freight Charge  | Weight | Weight Units |
      | DURABLE BLUE & WHITE 5.76 PCF  | 175                    | 1.00     | USD 1,752.92 | Fixed Cost | USD 1,752.92     | 431    | lbs          |
