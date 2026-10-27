Feature: 814 - EDI Inbound 210- Purpose: Update (Non Editable Status Validation)

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @EDI @814
  Scenario: 814 - EDI Inbound 210- Purpose: Update (Non Editable Status Validation)

   #Pre-conditions
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Cleo" in the "Search Credentials..." search box
    Then Select the "Cleo" record from the lookup field results
    And Update details for "Cleo" service
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Search text "Custom EDI" in the "Search Credentials..." search box
    Then Select the "Custom EDI" record from the lookup field results
    And Update details for "Custom EDI" service
      | Enabled |
      | False   |
    And Click on Native "Save" button

     #Step1
    Then Go to Home Page
    Then Verify and Delete "EDIWatcherJob" from Scheduled Jobs
    #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Freeze Load Number |
      | False               |
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      |Use REST API for EDI|
      |False               |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      |EDI Enabled|Enable EDI Transaction Logging|
      |True       |True                          |
    And Update the Custom Select option "EDI Administrator" as "User User"
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    Then Update details -
      |Inbound 204|Inbound 990|Inbound 214|Inbound 210|Inbound 824|Inbound 322|Inbound 410|Outbound 990|Outbound 204|Outbound 210|Outbound 214|Outbound 404|Outbound 998|
      |True       |True       |True       |True       |True       |True       |True       |True        |True        |True        |True        |True        |True        |
    Then Update details -
      |Use REST API for EDI|
      |False               |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 3,4,5 - Upload EDI File
    Given Upload File "KleinschmidtGetLoadInvoicesOperation (Invalid Invoice Status-814).xml" with Title "KleinschmidtGetLoadInvoicesOperation"


    # Step 6 - Create Quick Entry Truckload Shipment
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | Boston Beans  | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details

    # Step 7 - Update Load Number
    Then Go to "Details" Tab
    Then Scroll into Section with Title "Load Summary"
    Then Click on Edit icon on Label "Load Number"
    Then Update details
      | Load Number |
      | Load-814    |
    Then Click on "Save" button on Details Page
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Wait for "Load Number" Field Value Update with "Load-814"
    Then Verify Details
      |Load Number      |
      |Load-814 |

    # Step 8 - Assign Carrier
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter Carrier Service as "EDI Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier"

    # Step 9 - Update Load Status and PRO
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status | PRO Number |
      | Delivered   | PRO814     |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify "Load Status" having value of "Delivered"
    Then Verify "PRO Number" having value of "PRO814"


    # Step 10 - Create Vendor Invoice (Approved - Non Editable)
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Vendor Invoices"
    Then Click on button "New"
    Then Wait for "3" Seconds
    Then Update details
      |Vendor              |
      | EDI Carrier One|
    Then Wait for "2" Seconds
    Then Update details
      | Vendor          | Remit To        | Invoice Number | Payee Reference | Invoice Date | Invoice Status |
      | EDI Carrier One | EDI Carrier One | INV814         | INV814          | 0        | Approved       |

    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Vendor Invoice \"INV814\" was created."
    Then Wait for "1" Seconds

    # Step 11 - Run EDI Watcher Job
    Then Go to Home Page
    Then Run "EDIWatcherJob" Job
    Then Wait for "10" Seconds
    Then Wait for Email to Receive On Email

    # Step 12
    Then Wait for Email to Receive On Email
    Then Set "Email_Content" with "Email=>FailedEmailMessage.txt"
    Then Verify Content "SysData=>Email_Content" in the email with Subject "Failed EDI Transaction"


