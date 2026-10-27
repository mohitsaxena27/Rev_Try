Feature:2891 - PayIQ Program - Carrier Load Allocation - Full

  @API @Regression @PayIQ  @WEB @SingleCurrency @2891 @PayIQ_Logs
  Scenario: 2891 - PayIQ Program - Carrier Load Allocation - Full

    When Login into Salesforce
     #Step 1
    Then Open "Freight Plans" from App Launcher
    Then Search and Select "Plan-7" from List
    Then Wait for "5" Seconds
    #Step 2
    Then Click on "Clone" with Text
    #Step 3
    Then Wait for "5" Seconds
    Then Freight Plan - Click on 1 Cloned Load Checkbox
    Then Freight Plan - Click on 2 Cloned Load Checkbox
    #Step 4
    Then Click on "Save" with Text
    Then Wait for "4" Seconds
    Then Capture the current URL for "Plan_1"
    #Step 5
    Then Wait for "5" Seconds
    Then Freight Plan - Verify and get the "1" Load hyperlink in the User Selected Loads - Load View Section on "FP_Customer_Load_1"
    Then Freight Plan - Verify and get the "2" Load hyperlink in the User Selected Loads - Load View Section on "FP_Customer_Load_2"
    Then Freight Plan - Verify and get the "1" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_1"
    Then Freight Plan - Verify and get the "2" Load hyperlink in the Carrier Loads Section on "FP_Carrier_Load_2"
    #Step 6
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

    #Step 6 b
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "900"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 6 c & d
    Then Update details
      | Billing Status   |
      | Approved |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 6 e
    Then Go to "Summary" Tab
    Then Click on button with Title "Go to Freight Plan"
    #Step 7
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan1"

    #Step 8 & 9
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Customer_Load_2" from List
    Then Wait for "2" Seconds
    #Step 9 a
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

    #Step 9 b
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "900"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "100"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 9 C & d
    Then Update details
      | Billing Status   |
      | Approved |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 9 e
    Then Go to "Quotes/Invoices" Tab
    Then Scroll Until Related List for "Vendor Invoices"
    Then Choose "New" button on "Vendor Invoices" section
    Then Wait for "2" Seconds
    Then Update details
    |Vendor             | Remit To          | Invoice Number | Invoice Date | Freight Charges |
    | Email Carrier One | Email Carrier One | 2891           | 0            | 28.91           |

    Then Wait for "2" Seconds

    Then Update details
      |Carrier Quote|
      | Add New    |
    Then Click on button with Title "New Carrier Quote"
    Then Update details
      | Load_2                      | Carrier Service_2               | Vendor_2          | Carrier Total | Accepted |
      | SysData=>FP_Customer_Load_2 | Email Carrier One - Truckload | Email Carrier One | 57.82         | True     |
    Then Click on "Save" button on "New Carrier Quote" Modal
    Then Wait for "3" Seconds
    Then Click on "SaveEdit" button on Details Page

    #Step 9 f
    Then Go to "Summary" Tab
    Then Click on button with Title "Go to Freight Plan"
    #Step 10
    Then Freight Plan - Get the Fright Plan Number and Store on "Freight_Plan2"

    #Step 11 & 12
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_1" from List

    #Step 12 a
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Second User       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Second User       |
    Then  Capture the current URL for "Load_3L"

    #Step 12 b
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"
      #Step 12 c
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Details" Tab
    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered        |
    Then Click on "Save" button on Details Page
    Then Wait for "6" Seconds


    #Step 13 &14
    Then Open "Loads" from App Launcher
    Then Search and Select "SysData=>FP_Carrier_Load_2" from List

    #Step 15
    Then Wait for "2" Seconds
    #Step -15 a
    Then Click on Edit icon on Label "Carrier Sales Rep"
    Then Update details
      | Carrier Sales Rep |
      | Second User       |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Carrier Sales Rep |
      | Second User       |

    Then  Capture the current URL for "Load_4L"
    #Step 15 b
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds

    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "400"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "20"

    Then Wait for "2" Seconds

    # Step 15 c & d
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Details" Tab

    Then Click on Edit icon on Label "Load Status"
    Then Update details
      |Load Status      |
      |Delivered        |
    Then Click on "Save" button on Details Page
    Then Wait for "5" Seconds

    # Step16 & 17
    Then Go to Home Page
    Then Run "FreightPlanManagementJob" Job
    Then Wait for "3" Seconds

    #Step 18
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Freight Plan Settings" from List
    Then Wait for "1" Seconds
    #Step19
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Scroll into Section "Freight Plan Settings"
    Then Update details
      |Carrier Load Allocation|
      |Full      |
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
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 21
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Load|Type|
      |SysData=>FP_Customer_Load_1|Math|
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #Expected a

    Then Verify Logs Contains as Details "[{Freight_Plan1} : Freight (Quoted)] = [Customer Load Freight] = 900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Revenue (Quoted)] = [Customer Load Revenue] = 1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Margin (Quoted)] = [Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation] = 1,000 - 0 - 210 = 790 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Fuel (Quoted)] = [Customer Load Fuel] = 100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Freight (Invoiced)] = [Customer Load Freight] = 900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Revenue (Invoiced)] = [Customer Load Revenue] = 1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Margin (Invoiced)] = [Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation] = 1,000 - 0 - 210 = 790 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Fuel (Invoiced)] = [Customer Load Fuel] = 100 USD"


    #Step 21 b -ii
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Load|Type|
      |SysData=>FP_Customer_Load_2|Math|
    Then Click on button "Refresh"
    Then Wait for "2" Seconds


    #Expected Result b - 8 logs for Plan noted in Step 10 (Freight_Plan2)
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Quoted)] = [Customer Load Freight] = 900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Quoted)] = [Customer Load Revenue] = 1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Quoted)] = [Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation] = 1,000 - 57.82 - 630 = 312.18 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Quoted)] = [Customer Load Fuel] = 100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Invoiced)] = [Customer Load Freight] = 900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Invoiced)] = [Customer Load Revenue] = 1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Invoiced)] = [Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation] = 1,000 - 28.91 - 630 = 341.09 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Invoiced)] = [Customer Load Fuel] = 100 USD"

    #Step 21 b iii
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Load|Type|
      |SysData=>FP_Carrier_Load_1|Math|
    Then Click on button "Refresh"
    Then Wait for "2" Seconds


    #Expected Result c - 16 logs for both Freight_Plan1 and Freight_Plan2
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Quoted)] = [Customer Load Freight] x [Full Ratio] =[Customer Load Freight] x 1.0 =900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Quoted)] = [Customer Load Fuel] x [Full Ratio] =[Customer Load Fuel] x 1.0 =100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : [Customer Load Revenue] x [Full Ratio] =[Customer Load Revenue] x 1.0 =1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Quoted)] = [Customer Load Margin] x [Full Ratio] =([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x 1.0 =1,000 - 57.82 - 630 =312.18 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Invoiced)] = [Customer Load Fuel] x [Full Ratio] =[Customer Load Fuel] x 1.0 =100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Invoiced)] = [Customer Load Fuel] x [Full Ratio] =[Customer Load Fuel] x 1.0 =100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Invoiced)] = [Customer Load Revenue] x [Full Ratio] =[Customer Load Revenue] x 1.0 =1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Invoiced)] = [Customer Load Margin] x [Full Ratio] =([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x 1.0 =1,000 - 28.91 - 630 =341.09 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Fuel (Quoted)] = [Customer Load Fuel] x [Full Ratio] =[Customer Load Fuel] x 1.0 =100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Freight (Quoted)] = [Customer Load Freight] x [Full Ratio] =[Customer Load Freight] x 1.0 =900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Revenue (Quoted)] = [Customer Load Revenue] x [Full Ratio] =[Customer Load Revenue] x 1.0 =1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Margin (Quoted)] = [Customer Load Margin] x [Full Ratio] =([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x 1.0 =1,000 - 0 - 210 =790 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Fuel (Invoiced)] = [Customer Load Fuel] x [Full Ratio] =[Customer Load Fuel] x 1.0 =100 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Freight (Invoiced)] = [Customer Load Freight] x [Full Ratio] =[Customer Load Freight] x 1.0 =900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Revenue (Invoiced)] = [Customer Load Revenue] x [Full Ratio] =[Customer Load Revenue] x 1.0 =1,000 USD "
    Then Verify Logs Contains as Details "[{Freight_Plan1} : Margin (Invoiced)] = [Customer Load Margin] x [Full Ratio] =([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x 1.0 =1,000 - 0 - 210 =790 USD"


    #Step 21 b iv
    Then Go to "Logs" Tab
    Then Wait for "2" Seconds
    Then Update details
      |Load|Type|
      |SysData=>FP_Carrier_Load_2|Math|
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    #Expected Result d - 8 logs for Plan noted in Step 10 (Freight_Plan2)
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Quoted)] = [Customer Load Freight] x [Full Ratio] =[Customer Load Freight] x 1.0 =900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Quoted)] = [Customer Load Revenue] x [Full Ratio] =[Customer Load Revenue] x 1.0 =1,000 USD "
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Quoted)] = [Customer Load Margin] x [Full Ratio] =([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x 1.0 =1,000 - 57.82 - 630 =312.18 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Freight (Invoiced)] = [Customer Load Freight] x [Full Ratio] =[Customer Load Freight] x 1.0 =900 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Revenue (Invoiced)] = [Customer Load Revenue] x [Full Ratio] =[Customer Load Revenue] x 1.0 =1,000 USD"
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Margin (Invoiced)] = [Customer Load Margin] x [Full Ratio] =([Customer Load Revenue] - [Customer Load Cost] - [Customer Load Cost Allocation]) x 1.0 =1,000 - 28.91 - 630 =341.09 USD "
    Then Verify Logs Contains as Details "[{Freight_Plan2} : Fuel (Invoiced)] = [Customer Load Fuel] x [Full Ratio] =[Customer Load Fuel] x 1.0 =100 USD "





























































































































































































