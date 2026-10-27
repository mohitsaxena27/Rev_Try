Feature: 2240 - HubTran API- Inbound Data- Carrier and Vendor Quote Matching Logic


  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @HubTran @2240
  Scenario: 2240 - HubTran API- Inbound Data- Carrier and Vendor Quote Matching Logic

    When Login into Salesforce
  # Steps 1
     #1st Load
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL       | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots  | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed     | 1234   | NA           | NA       | NA            |
    Then Save Load With All details

     # Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 3
    Then Store Carrier Quote value on "Carrier_Quote_1"
    Then Capture the current URL for "Load_1"
    #Step 4
    Then "New" Carrier
    Then Wait for "2" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "2000"
    Then "Assign" Carrier
    Then Wait for "2" Seconds
    #Step 5
    Then Verify Modal Heading Text displaying as "Email Carrier One" -
    Then Click on button "Remove Carrier" -
    Then Verify Message displaying as "Carrier removed from load."
    Then Wait for "6" Seconds
    #Step 6
    Then Store Carrier Quote value on "Carrier_Quote_2"

     # Step 7
    Then Go to "Vendor Quotes" Tab
    Then Wait for "3" Seconds
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Blind Shipments" with Unit as "Fixed Cost" Qty as "1" and Price "100"

    # Step 8
    Then "Accept" Vendor Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Set Vendor Quote value on to "Vendor_Quote_1"

     # Step 9
    Then "New" Vendor Quotes
    Then Enter Vendor Service as "Email Carrier One - Vendor - LTL"
    Then Wait for "1" Seconds
    Then Update details
      | Quote Contact         |
      | Tom Email Carrier One |
    Then Add "Load" "Vendor Quote Items" "Customs" with Unit as "Fixed Cost" Qty as "1" and Price "200"

   # Step 10
    Then "Accept" Vendor Quotes
    Then Verify Message displaying with Text "Save was successful."
    Then Wait for "1" Seconds
    Then Set Vendor Quote value on to "Vendor_Quote_2"

    #Step 11
    Then Store SFID for "Account" "Email Carrier One" on "Email_Carrier_One_SFID"
    Then Set Key "Load_SFID" page Record Id with "rtms__Load__c"

    #Step 12
    Then Get "Hubtran_Inbound_packet.txt" files and update below Attributes
      |{LoadExternalID}|{CarrierExternalID}|
      |SysData=>Load_SFID|SysData=>Email_Carrier_One_SFID|
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    #Step 13
    Then Update details -
      |Processor         |Direction|Content Type    |
      |HubTran           |Inbound  |application/json|
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 14
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
     Then Wait for "40" Seconds
    #Step 15
    Then Navigate to stored URL for "Load_1"
    Then Go to "Documents" Tab
    Then Go to "Files" Tab
    Then Wait for "9" Seconds
    Then Verify Text displaying as "Other-01.png"
    Then Verify Text displaying as "Carrier Invoice-01.png"
    Then Verify Text displaying as "Bill Of Lading-01-POD.png"
    Then Verify Text displaying as "Notice Of Assignment-01.png"

    #Step 16
    Then Wait for "20" Seconds
    Then Refresh current Page
    Then Go to "Details" Tab
    Then Scroll into Section "Assigned Carrier Information"
    #Expected b
    Then Verify Label Checkbox
         |POD Received|
         |True        |

    #Step 17
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Quotes" on QuoteInvoice Tab
    Then Open "Customer Quotes" using value from "Carrier_Quote_1" on QuoteInvoice Tab
    Then Wait for "2" Seconds

    #Expected c
    Then Go to "Settlement" Tab with More Menu
    Then Wait for "1" Seconds
    Then Verify Details
         |Vendor Invoice Number|Vendor Invoice Date|Vendor Settlement Total|Vendor Settlement Variance|
         |                     |                   |                       |                          |
    #Step 18
    Then Navigate to stored URL for "Load_1"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Quotes" on QuoteInvoice Tab
    Then Open "Customer Quotes" using value from "Carrier_Quote_2" on QuoteInvoice Tab
    Then Wait for "2" Seconds

    #Expected d
    Then Wait for "2" Seconds
    Then Go to "Settlement" Tab with More Menu
    Then Wait for "1" Seconds
    Then Verify Details
      |Vendor Invoice Number|Vendor Invoice Date|Vendor Settlement Total|Vendor Settlement Variance|
      |OTR-14729509         | 4/26/2024         |USD 2,500.00           |USD 500.00              |

    #Step 19
    Then Navigate to stored URL for "Load_1"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Quotes" on QuoteInvoice Tab
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_1" on "Carrier_Quote_3"
    Then Open "Customer Quotes" using value from "Carrier_Quote_3" on QuoteInvoice Tab
    Then Wait for "2" Seconds

    #Expected e
    Then Wait for "2" Seconds
    Then Go to "Settlement" Tab with More Menu
    Then Wait for "1" Seconds
    Then Verify Details
      |Vendor Invoice Number|Vendor Invoice Date|Vendor Settlement Total|Vendor Settlement Variance|
      |                     |                   |                       |                          |

    #Step 20
    Then Navigate to stored URL for "Load_1"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Quotes" on QuoteInvoice Tab
    Then Set Vendor Invoice Number with Carrier Quote and "Vendor_Quote_2" on "Carrier_Quote_4"
    Then Open "Customer Quotes" using value from "Carrier_Quote_4" on QuoteInvoice Tab
    Then Wait for "2" Seconds

    #Expected f
    Then Wait for "2" Seconds
    Then Go to "Settlement" Tab with More Menu
    Then Wait for "1" Seconds
    Then Verify Details
      |Vendor Invoice Number|Vendor Invoice Date|Vendor Settlement Total|Vendor Settlement Variance|
      |                     |                   |                       |                          |