Feature: 746 - Customer Invoice Banner LWC- Generate and Send-Customer Inv Docs Req Validation

  @Regression @smoke @API @WEB @SingleCurrency @Customer @Customer_Invoice @746
  Scenario: 746 - Customer Invoice Banner LWC- Generate and Send-Customer Inv Docs Req Validation

    When Login into Salesforce
      #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Customer Invoice Documents" Tab
    Then Switch to Frame by Title "accessibility title"
#    Then Search text "Denver Deli Meats" in the "Customer" search box
    Then Search text "Denver Deli Meats" in the "Customer" search box
    Then Select the "Denver Deli Meats" record from the lookup field results
    Then Wait for "2" Seconds
    Then "Delivery Receipt" : Select "Invoice Action" as "Always Include"
    Then Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

#Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer         | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Denver Deli Meats | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_Url"
    Then Wait for "3" Seconds

    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds

      #Step 4
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      | Load Status |
      | Delivered   |
    Then Click on "Save" button
    Then Scroll into Section "Team Assignments & Status"
    Then Wait for "2" Seconds
    Then Wait for "Load Status" Field Value Update with "Delivered"
    Then Verify Details
      | Load Status |
      | Delivered   |
    Then Refresh current Page

    #Step 5
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Set Key "Customer_Invoice_SFID" page Record Id with "rtms__CustomerInvoice__c"

    #Step 6
    Then Click on "Generate and Send" with Text
    Then Wait for "2" Seconds

    # Expected Result a
    Then Verify Error Message displaying as "Error - Customer Invoice Banner"


















































































