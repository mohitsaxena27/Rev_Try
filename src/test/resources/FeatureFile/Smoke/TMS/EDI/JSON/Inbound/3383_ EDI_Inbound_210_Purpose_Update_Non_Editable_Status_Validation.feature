Feature: 3383 - EDI Inbound 210- Purpose: Update (Non Editable Status Validation) (JSON)

  Background: Pre- Test
    Then Set key "Load3383" for Object "rtms__Load__c" and Name "Load-3383"
    Then Delete All Records with name "Load3383" for "rtms__Load__c"

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @3383
  Scenario: 3383 - EDI Inbound 210- Purpose: Update (Non Editable Status Validation) (JSON)

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
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer |NA | 0             | NA                       | NA               | NA                   |

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
      | Load-3383   |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-3383"
    Then Verify Details
      | Load Number |
      | Load-3383   |

    # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"

    # Step 5
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status | PRO Number |
      | Delivered   | PRO3383    |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify "Load Status" having value of "Delivered"
    Then Verify "PRO Number" having value of "PRO3383"

    # Step 6
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Vendor Invoices"
    Then Click on button "New"
    Then Wait for "3" Seconds
    Then Update details
      | Vendor          |
      | EDI Carrier One |
    Then Wait for "2" Seconds
    Then Update details
      | Vendor          | Remit To        | Invoice Number | Payee Reference | Invoice Date | Invoice Status |
      | EDI Carrier One | EDI Carrier One | INV3383        | INV3383         | 0            | Approved       |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Vendor Invoice \"INV3383\" was created."
    Then Wait for "1" Seconds

  # Step 7,8
    Then Send Post Request for EDI with Json "Create_Invoice_3383.txt" with Access Token as "Access_Token"
    Then Wait for "60" Seconds

  # Step 9 Expected result a

    Then Navigate to stored URL for "Load_1"
    Then Go to "EDI" Tab
    Then Wait for "3" Seconds
    Then Select "EDI Transactions" with "Transaction Type" as "210" and "Direction" as "Inbound"
    Then Verify Details
      | Transaction Type | Purpose | Direction | Event Code |
      | 210              | Update  | Inbound   |            |

    Then Scroll into Section "EDI Provider Status"
    Then Verify Details
      | EDI Provider | Status  | Status Log                                                                                                                                                           |
      | Kleinschmidt | Failure | The existing invoice for this EDI 210/410 transaction is not editable and cannot be updated. Please follow up with accounting and the vendor. Load Number: Load-3383 |
    Then Scroll into Section "EDI Payload"
    Then Get Details
      | Transaction Payload |
      | Transaction Payload |

    Then Verify Json "Transaction Payload" with File "Transaction_Payload_A.json"
      |No Update Required|
      |                  |
