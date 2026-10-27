Feature: 736 - Customer Invoice Banner LWC- Apply Terms Action

  @Regression @TMS @Smoke @WEB @SingleCurrency @Customer @Customer_Invoice @736
  Scenario: 736 - Customer Invoice Banner LWC- Apply Terms Action

    When Login into Salesforce
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Document Options" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Link" Link Text "Global Defaults" on Page -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Last of Webpage
    Then Scroll into Section "Document-Specific Settings" -
    Then Update the Custom Select option "Document" as "Customer Invoice"
    Then Update details -
      | Customer Default Invoice Terms |
      | 9                              |
    Then Click on Button with Value "Save" -
    Then Verify Message displaying as "Save was successful."
    Then Switch to Parent Frame
    #Step2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Los Angeles Lighting" from List
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Information"
    Then Click on Edit icon on Label "Invoice Terms"
    Then Enter Label "Invoice Terms" Text as ""
    Then Click on "Save" button on Details Page
    Then Verify "Invoice Terms" having value of ""
    #Step3
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Chicago Pizza" from List
    Then Go to "Billing" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Billing Information"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Default Customer Bill To_2 |
      | Los Angeles Lighting       |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
     #Step4
     #Load1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Glue        | 4500   | NA           | NA       | NA             |
    Then Save Load With All details

     #Step5
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
     #Step6
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful"

    Then Wait for "3" Seconds
    Then Refresh current Page

     #Step7
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "2" Seconds

     #Step8
    Then Click on Edit icon on Label "Invoice Date"
    Then Update details
      | Invoice Date |
      | -5           |
    Then Click on "Save" button on Details Page
    Then Verify details for
      | Invoice Date |
      | -5           |

    #Step9
    Then Click on "Apply Terms" with Text
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page
    Then Wait for "1" Seconds
    #Expected Result a
    Then Verify details for
      | Invoice Date | Invoice Due Date |
      | 0            | 9                |
      #Step10
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Los Angeles Lighting" from List
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Information"
    Then Click on Edit icon on Label "Invoice Terms"
    Then Enter Label "Invoice Terms" Text as "12"
    Then Click on "Save" button on Details Page
    Then Verify "Invoice Terms" having value of "12"

      #Step11
        # Load2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Chicago Pizza | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Paper       | 8500   | NA           | NA       | NA             |
    Then Save Load With All details

     #Step12
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step13
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Refresh current Page

     #Step14
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Wait for "2" Seconds

     #Step15
    Then Click on Edit icon on Label "Invoice Date"
    Then Update details
      | Invoice Date |
      | -6           |
    Then Click on "Save" button on Details Page
    Then Verify Details
      | Invoice Date |
      | -6           |

     #Step16
    Then Click on "Apply Terms" with Text
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page
    Then Wait for "1" Seconds
     #Expected Result b
    Then Verify Details
      | Invoice Date | Invoice Due Date |
      | 0            | 12               |