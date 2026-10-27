Feature: 3473 - EDI REST Webservice-GET: 200 Invoice Status EDI Process Date & Date Sent

  @Regression @TMS @Smoke @WEB @API @SingleCurrency @EDI @3473
  Scenario: 3473 - EDI REST Webservice-GET: 200 Invoice Status EDI Process Date & Date Sent

    When Login into Salesforce
    #Pre-Condition
    Then Get "Access_Token" for EDI
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "EDI Setup" -
    Then Update details -
      | EDI Enabled | Use REST API for EDI|
      | True        |True                |
    And Update the Custom Select option "EDI Shipment Id Field" as "Load Number"
    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "User User"
#    And Update the Custom Select option "EDI Context User (Kleinschmidt)" as "API User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | LTL | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | NA             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mustard      | 5000  | NA           | NA       | NA             |
    #Step 2
    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Update details
      |Status       |
      |Accepted     |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then "Assign" Carrier
    Then Verify Message displaying with Text "Load was assigned to carrier."

    #Step 4
    Then Go to "EDI" Tab
    Then Click on Edit icon on Label "EDI Provider"
    Then Update details
       | EDI Provider |
       | Kleinschmidt |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Wait for "EDI Provider" Field Value Update with "Kleinschmidt"
    Then Verify Details
      | EDI Provider |
      | Kleinschmidt |

     #Step 5
    Then Go to "Summary" Tab
    Then Scroll into Section "Denver Deli Meats"
    Then Click on "2D" "Departed" chevron
    Then Wait for "2" Seconds
    Then Update details
      | Departure Date |
      | 3              |
    Then Click on "2D" "Save" button
    Then Verify Success Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Refresh current Page

    #Step 6
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Capture the current URL for "Customer_Invoice"

    #Step 7
    Then Go to "Details" Tab
    Then Scroll into Section "Billing Contact Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | EDI            |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds

      # Step8
    Then Click on "Send via EDI" with Text
    Then Note the current Date and Time
    Then Set "CurrentDateTime" with "MM/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Verify Success Message displaying as "Invoice was successfully sent via EDI."

    #Expected a
    Then Go to "Details" Tab
    Then Scroll into Section "Billing Contact Information"
    Then Get Details
      | Date Sent |
      |           |
    Then Verify "SysData=>Date Sent" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"

   #Step 9 & 10 & 11
    Then Send Get Request for EDI with Access Token as "Access_Token"
    Then Set "CurrentDateTime" with "MM/d/yyyy, h:mm a" Format and "America/Chicago" Timezone
    Then Wait for "10" Seconds

    #Step 12
    Then Refresh current Page
    Then Go to "Details" Tab
    #Expected b
    Then Verify Details
         |Invoice Status|
         |Invoiced      |
    Then Scroll into Section "Billing Contact Information"
    Then Get Details
      | EDI Processed Date |
      |                    |
    Then Verify "SysData=>EDI Processed Date" and "SysData=>CurrentDateTime" in format "M/d/yyyy, h:mm a"


