Feature: 2892 - PayIQ Program - Carrier Load Allocation - Distance Contribution

  @Regression @API @PayIQ @WEB @SingleCurrency  @PayIQ_FreightPlan @2892
  Scenario: 2892 - PayIQ Program - Carrier Load Allocation - Distance Contribution

    When Login into Salesforce
    #Step 1,2,3,4,5
    Then Open "Freight Plans" from App Launcher
    Then Search and Select "Plan-7" from List
    Then Wait for "5" Seconds
    Then Click on "Clone" with Text
    Then Wait for "10" Seconds
    Then Freight Plan - Click on 1 Cloned Load Checkbox
    Then Freight Plan - Click on 2 Cloned Load Checkbox
    Then Click on "Save" with Text
    Then Wait for "6" Seconds
    Then Capture the current URL for "Plan_1"
    Then Wait for "5" Seconds
    Then Freight Plan - Verify and get the "1" Load hyperlink in the User Selected Loads - Load View Section on "FP_Customer_Load_1"
    Then Freight Plan - Verify and get the "2" Load hyperlink in the User Selected Loads - Load View Section on "FP_Customer_Load_2"
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"
    Then Freight Plan - Verify and get the "2" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_2"


    #Step 6,7
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Customer_Load_1" from List
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep |
      | Test User1         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Test User1         |
    Then  Capture the current URL for "Load_1L"

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "900"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then Update details
     |Status|
     |Accepted   |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Update details
   |Billing Status|
   | Approved  |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Go to "Summary" Tab
    Then Click on button with Title "Go to Freight Plan"
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan1"


    #Step 8
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Customer_Load_2" from List

    #Step 9,10
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Customer Sales Rep"
    Then Update details
      | Customer Sales Rep |
      | Test User1         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Customer Sales Rep |
      | Test User1         |
    Then  Capture the current URL for "Load_2L"

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "900"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then Update details
     |Status|
     |Accepted   |

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    Then Update details
      | Billing Status|
      | Approved |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then Capture the current URL for "Load"

    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Vendor Invoices" on QuoteInvoice Tab
    Then Click on link "Vendor Invoices"
    Then Click on button "New"
    Then Wait for "2" Seconds
    Then Update details
     |Vendor          | Remit To|Invoice Number|Invoice Date|Freight Charges|
     |Email Carrier One|Email Carrier One|2891 |0           |28.91          |

   Then Update details
    |Carrier Quote|
    | Add New    |
    Then Click on button with Title "New Carrier Quote"
    Then Update details
      |Load_2                     |Accepted|Carrier Service              |Vendor_2          |Carrier Total|
      |SysData=>FP_Customer_Load_2|True    |Email Carrier One - Truckload|Email Carrier One|57.82|
    Then Click on "Save" button on "New Carrier Quote" Modal
    Then Wait for "3" Seconds
    Then Click on "SaveEdit" button on Details Page
    Then Navigate to stored URL for "Load"
    Then Go to "Freight Quote Assistant" Tab
    Then Go to "Summary" Tab
    Then Click on button with Title "Go to Freight Plan"
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan2"

    #Step 11
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_1" from List
    Then Wait for "2" Seconds

    #Step 12
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Second User           |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Second User           |
    Then  Capture the current URL for "Load_1L"

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"

    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered        |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

    #Step 13,14
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_2" from List
    Then Wait for "2" Seconds

    #Step 15,16
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Second User           |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then  Capture the current URL for "Load_2L"

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "7" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"

    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered        |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds

    #Step 17
    Then Go to Home Page
    Then Run "FreightPlanManagementJob" Job

    #Step 18
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Freight Plan Settings" from List

    #Step 19
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Scroll into Section "Freight Plan Settings"
    Then Update details
    |Carrier Load Allocation|
    |Distance Contribution      |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 20
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Wait for "2" Seconds
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 21 and expected result a
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Load|Type|
      |SysData=>FP_Customer_Load_1|Math|
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Freight (Quoted)] = [Customer Load Freight] = 900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Revenue (Quoted)] = [Customer Load Revenue] = 1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Margin (Quoted)] = [Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation] = 1,000 - 0 - 210 = 790 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Fuel (Quoted)] = [Customer Load Fuel] = 100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Freight (Invoiced)] = [Customer Load Freight] = 900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Revenue (Invoiced)] = [Customer Load Revenue] = 1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Margin (Invoiced)] = [Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation] = 1,000 - 0 - 210 = 790 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Fuel (Invoiced)] = [Customer Load Fuel] = 100 USD"

    #expected result b
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Load|Type|
      |SysData=>FP_Customer_Load_2|Math|
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Quoted)] = [Customer Load Freight] = 900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Quoted)] = [Customer Load Revenue] = 1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Quoted)] = [Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation] = 1,000 - 57.82 - 630 = 312.18 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Quoted)] = [Customer Load Fuel] = 100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Invoiced)] = [Customer Load Freight] = 900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Invoiced)] = [Customer Load Revenue] = 1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Invoiced)] = [Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation] = 1,000 - 28.91 - 630 = 341.09 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Invoiced)] = [Customer Load Fuel] = 100 USD"

   #expected result c
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Load|Type|
      |SysData=>FP_Carrier_Load_1|Math|
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Quoted)] = [Customer Load Freight] x [Distance Contribution Ratio] =[Customer Load Freight] x ([Carrier Load Distance] / [Customer Load Distance]) = 900 x (1,018.111 / 447.896) = 2,045.787 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Quoted)] = [Customer Load Fuel] x [Distance Contribution Ratio] =[Customer Load Fuel] x ([Carrier Load Distance] / [Customer Load Distance]) = 100 x (1,018.111 / 447.896) = 227.31 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Quoted)] = [Customer Load Revenue] x [Distance Contribution Ratio] =[Customer Load Revenue] x ([Carrier Load Distance] / [Customer Load Distance]) = 1,000 x (1,018.111 / 447.896) = 2,273.097 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Quoted)] = [Customer Load Margin] x [Distance Contribution Ratio] = ([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x ([Carrier Load Distance] / [Customer Load Distance]) = (1,000 – 57.82 - 630) x (1,018.111 / 447.896) = 709.615 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Invoiced)] = [Customer Load Fuel] x [Distance Contribution Ratio] = [Customer Load Fuel] x ([Carrier Load Distance] / [Customer Load Distance]) = 100 x (1,018.111 / 447.896) = 227.31 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Invoiced)] = [Customer Load Freight] x [Distance Contribution Ratio] =[Customer Load Freight] x ([Carrier Load Distance] / [Customer Load Distance]) = 900 x (1,018.111 / 447.896) = 2,045.787 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Invoiced)] = [Customer Load Revenue] x [Distance Contribution Ratio] =[Customer Load Revenue] x ([Carrier Load Distance] / [Customer Load Distance]) = 1,000 x (1,018.111 / 447.896) = 2,273.097 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Invoiced)] = [Customer Load Margin] x [Distance Contribution Ratio] = ([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x ([Carrier Load Distance] / [Customer Load Distance]) = (1,000 – 28.91 - 630) x (1,018.111 / 447.896) = 775.331 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Fuel (Quoted)] = [Customer Load Fuel] x [Distance Contribution Ratio] = [Customer Load Fuel] x ([Carrier Load Distance] / [Customer Load Distance]) = 100 x (1,018.111 / 473.917) = 214.829 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Freight (Quoted)] = [Customer Load Freight] x [Distance Contribution Ratio] =[Customer Load Freight] x ([Carrier Load Distance] / [Customer Load Distance]) = 900 x (1,018.111 / 473.917) = 1,933.461 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Revenue (Quoted)] = [Customer Load Revenue] x [Distance Contribution Ratio] = [Customer Load Revenue] x ([Carrier Load Distance] / [Customer Load Distance]) = 1,000 x (1,018.111 / 473.917) = 2,148.29 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Margin (Quoted)] = [Customer Load Margin] x [Distance Contribution Ratio] = ([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x ([Carrier Load Distance] / [Customer Load Distance]) = (1,000 - 0 - 210) x (1,018.111 / 473.917) = 1,697.149 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Fuel (Invoiced)] = [Customer Load Fuel] x [Distance Contribution Ratio] = [Customer Load Fuel] x ([Carrier Load Distance] / [Customer Load Distance]) = 100 x (1,018.111 / 473.917) = 214.829 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Freight (Invoiced)] = [Customer Load Freight] x [Distance Contribution Ratio] = [Customer Load Freight] x ([Carrier Load Distance] / [Customer Load Distance]) = 900 x (1,018.111 / 473.917) = 1,933.461 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Revenue (Invoiced)] = [Customer Load Revenue] x [Distance Contribution Ratio] = [Customer Load Revenue] x ([Carrier Load Distance] / [Customer Load Distance]) = 1,000 x (1,018.111 / 473.917) = 2,148.29 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Margin (Invoiced)] = [Customer Load Margin] x [Distance Contribution Ratio] = ([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x ([Carrier Load Distance] / [Customer Load Distance]) = (1,000 - 0 - 210) x (1,018.111 / 473.917) = 1,697.149 USD"

    #expected d
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Load|Type|
      |SysData=>FP_Carrier_Load_2|Math|
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Quoted)] = [Customer Load Freight] x [Distance Contribution Ratio] =[Customer Load Freight] x ([Carrier Load Distance] / [Customer Load Distance]) = 900 x (468.327 / 447.896) = 941.054 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Quoted)] = [Customer Load Revenue] x [Distance Contribution Ratio] =[Customer Load Revenue] x ([Carrier Load Distance] / [Customer Load Distance]) = 1,000 x (468.327 / 447.896) = 1,045.616 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Quoted)] = [Customer Load Margin] x [Distance Contribution Ratio] = ([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x ([Carrier Load Distance] / [Customer Load Distance]) = (1,000 – 57.82 - 630) x (468.327 / 447.896) = 326.42 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Quoted)] = [Customer Load Fuel] x [Distance Contribution Ratio] = [Customer Load Fuel] x ([Carrier Load Distance] / [Customer Load Distance]) = 100 x (468.327 / 447.896) = 104.562 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Invoiced)] = [Customer Load Freight] x [Distance Contribution Ratio] = [Customer Load Freight] x ([Carrier Load Distance] / [Customer Load Distance]) = 900 x (468.327 / 447.896) = 941.054 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Invoiced)] = [Customer Load Revenue] x [Distance Contribution Ratio] = [Customer Load Revenue] x ([Carrier Load Distance] / [Customer Load Distance]) = 1,000 x (468.327 / 447.896) = 1,045.616 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Invoiced)] = [Customer Load Margin] x [Distance Contribution Ratio] = ([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x ([Carrier Load Distance] / [Customer Load Distance]) = (1,000 – 28.91 - 630) x (468.327 / 447.896) = 356.649 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Invoiced)] = [Customer Load Fuel] x [Distance Contribution Ratio] = [Customer Load Fuel] x ([Carrier Load Distance] / [Customer Load Distance]) = 100 x (468.327 / 447.896) = 104.562 USD"

