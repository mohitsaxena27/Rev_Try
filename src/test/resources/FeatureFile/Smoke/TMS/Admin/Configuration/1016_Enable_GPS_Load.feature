Feature:1016 - TMS Admin Configuration Enable GPS

  @API @DeleteFile @Regression @TMS @Smoke @Admin @Mail @WEB @SingleCurrency @1016
  Scenario: 1016 - TMS Admin Configuration Enable GPS Load Only

    When Login into Salesforce
# Step 3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Enable GPS-Only Loads |
      | true                  |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

# Step 4
  #1st Load
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type |Address_Type |  Value                   | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   |GeoLocation  | 42.361145,-71.057083     | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type |Address_Type | Value              | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   |GeoLocation  |41.505493,-81.681290  | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12000  | NA           | NA       | NA             |

# Step 5
    Then Save Load With All details

# Step 6
    Then Go to "Shipment" Tab
    #Expected Result d & e
    Then Verify Text displaying as "42.361145 -71.057083 Boston, MA 02109"
    Then Verify Text displaying as "41.505493 -81.68129 Cleveland, OH 44114"

# Step 7
    Then Go to "Freight Quote Assistant" Tab
    Then Update details
      | Status   |
      | Accepted |
    Then "Send" Customer Quotes
    Then Verify Message displaying as "Save was successful."
# Step 8
    Then To open the preview attachments -
    Then Wait for "4" Seconds
# f) Steps to verify the expected result
    # Shipper (Stop 1)
    Then Get Pdf content from "Preview Attachments" with Subject "Customer Quote Confirmation"
    Then Verify Pdf contains "Pickup Location"
    Then Verify Pdf contains "42.361145 -71.057083 Boston, MA US 02109"
    Then Verify Pdf contains "Expected Date: {Date=>0}"
    Then Verify Pdf contains "Shipping/Receiving Hours:"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Appointment Time:"
    Then Verify Pdf contains "Contact:"
    # Consignee (Stop 2)
    Then Verify Pdf contains "Delivery Location"
    Then Verify Pdf contains "41.505493 -81.68129 Cleveland, OH US 44114"
    Then Verify Pdf contains "Expected Date: {Date=>1}"
    Then Verify Pdf contains "Shipping/Receiving Hours:"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Appointment Time:"
    Then Verify Pdf contains "Contact:"
# Step 9
    Then Close the Preview Modal
# Step 10
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Wait for "1" Seconds
    Then Click on button with Title "Get Quote"

# Step 11
# g) Steps to verify expected result
    Then Wait for Email to Receive On Email
    Then Get Pdf content from "Email" with Subject "Quote Request for Load =>1L"
    # Shipper (Stop 1)
    Then Verify Pdf contains "Carrier Quotation Request"
    Then Verify Pdf contains "Pickup Location"
    Then Verify Pdf contains "42.361145 -71.057083 Boston, MA US 02109"
    Then Verify Pdf contains "Expected Date: {Date=>0}"
    Then Verify Pdf contains "Shipping/Receiving Hours:"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Appointment Time:"
  # Consignee (Stop 2)
    Then Verify Pdf contains "Delivery Location"
    Then Verify Pdf contains "41.505493 -81.68129 Cleveland, OH US 44114"
    Then Verify Pdf contains "Expected Date: {Date=>1}"
    Then Verify Pdf contains "Shipping/Receiving Hours:"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Appointment Time:"

# Step 12
    Then "Tender" Carrier
    Then Verify Text displaying as "Tender Email" -
# Step 13
    Then Scroll On Modal
    Then Scroll into Section "Preview Attachments"
    Then To open the preview attachments
    Then Wait for "4" Seconds

# h) Steps to verify expected result
  # Shipper (Stop 1)
    Then Get Pdf content from "Preview Attachments" with Subject "Tender Email"
    Then Verify Pdf contains "Carrier Rate and Load Confirmation"
    Then Verify Pdf contains "Pickup Location"
    Then Verify Pdf contains "42.361145 -71.057083 Boston, MA US 02109"
    Then Verify Pdf contains "Expected Date: {Date=>0}"
    Then Verify Pdf contains "Shipping/Receiving Hours:"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Appointment Time:"
    Then Verify Pdf contains "Contact:"
  # Consignee (Stop 2)
    Then Verify Pdf contains "Delivery Location"
    Then Verify Pdf contains "41.505493 -81.68129 Cleveland, OH US 44114"
    Then Verify Pdf contains "Expected Date: {Date=>1}"
    Then Verify Pdf contains "Shipping/Receiving Hours:"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Appointment Time:"
    Then Verify Pdf contains "Contact:"
# Step 14
    Then Close the Preview Modal
# Step 15
    Then Set Key "GetElementID" page Record Id with "rtms__Load__c"
    Then Click on button "Documents"
    Then Wait for "6" Seconds
    Then Update details
    |Select Document to Generate|
    |Bill of Lading             |
    Then Wait for "4" Seconds
    Then Click on button with Title "Save" on Modal
    Then Verify Text displaying as "Save was successful." -
    Then Wait for "4" Seconds
    Then Get Pdf content from "Document" with Subject "BOL.pdf"

# i) Steps to verify expected result
  # SHIP FROM
    Then Verify Pdf contains "Name:"
    Then Verify Pdf contains "Address: 42.361145 -71.057083"
    Then Verify Pdf contains "City/State/Zip: Boston MA 02109"
  # SHIP TO
    Then Verify Pdf contains "Name:"
    Then Verify Pdf contains "Address: 41.505493 -81.68129"
    Then Verify Pdf contains "City/State/Zip: Cleveland OH 44114"
# Step 16
    Then Close the Preview Modal
# Step 17
    Then Wait for "4" Seconds
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
# Step 18
    Then Update details
      | Billing Status|
      | Approved |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
# Step 19
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab

# Step 20
    Then Wait for "2" Seconds
    Then Click on "Generate" with Text
    Then Verify Text displaying as "Customer Invoice.pdf" -
    Then Close the Preview Modal
    Then Go to "Preview Customer Invoice" Tab
    Then Set Key "GetElementID" page Record Id with "rtms__CustomerInvoice__c"
    Then Wait for "2" Seconds
   # expected result j
    # Shipper (Stop 1)
    Then Get Pdf content from "Document" with Subject "Customer Invoice.pdf"
    Then Verify Pdf contains "Pickup Location"
    Then Verify Pdf contains "42.361145 -71.057083 Boston MA US 02109"
    # Consignee (Stop 2)
    Then Verify Pdf contains "Delivery Location"
    Then Verify Pdf contains "41.505493 -81.68129 Cleveland OH US 44114"