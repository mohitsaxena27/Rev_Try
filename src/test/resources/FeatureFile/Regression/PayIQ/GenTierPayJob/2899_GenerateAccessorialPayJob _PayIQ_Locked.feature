Feature:2899 - GenerateAccessorialPayJob - PayIQ Locked

  @API @Regression @PayIQ  @WEB @SingleCurrency @2899 @PayIQ_Logs
  Scenario: 2899 - GenerateAccessorialPayJob - PayIQ Locked

    When Login into Salesforce
    Then Delete All Records with name "Pay Estimate-" for "rtms9__Pay_Estimate__c"
    Then Delete All Records with name "Trip Plan" for "rtms__TripPlan__c"
    Then Delete All Records with name "Segment" for "rtms__TripPlanSegment__c"
    Then Delete All Records with name "L-" for "rtms__Load__c"

   #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program 2762" from List

   #Step 2
    Then Click on Edit icon on Label "Status"
    Then Update details
         |Status|
         |Open|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
         |Status|
         |Open|
    Then Capture the current URL for "PayIQ_Program_1"

    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Accessorial Rules" section
    Then Update details
      | Type                     | Accessorial         | Rule     | Amount |
      | Customer Quote Accessorial| Inside Pick Up| Flat Rate|  15.15    |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Accessorial Rule-"
    Then Wait for "2" Seconds
    Then Click on "Accessorial Rule-" with "Accessorial" as "Inside Pick Up"
    Then Set Key "Accessorial_Rules_SFID_1" page Record Id with "rtms9__Accessorial_Rule__c"

    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Accessorial Rules"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Accessorial Rules" section
    Then Update details
      | Type                     | Accessorial         | Rule     | Percent  |
      | Customer Invoice Accessorial| Other| Percent of Accessorial| 17    |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "Accessorial Rule-"
    Then Wait for "2" Seconds
    Then Click on "Accessorial Rule-" with "Accessorial" as "Other"
    Then Set Key "Accessorial_Rules_SFID_2" page Record Id with "rtms9__Accessorial_Rule__c"

    #Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova PayIQ | Truckload | Dry Van 53'    | Y            | Y                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Update details
      |Inside Pick Up|
      |True |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address |Grand Rapids Kayaks| 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Toys    | 2000   | NA           | NA        | NA        | NA     | NA    | NA     | NA             | NA         |
    Then Save Load With All details

    #Step 4
    Then Capture the current URL for "Load_1L"

    #Step 5
    Then Click on Edit icon on Label "Custom PayIQ Eligible Date"
    Then Update details
      |Custom PayIQ Eligible Date|Customer Sales Rep|Sales Lead (Contact)|
      |          0               |Second User       |Joe Philadelphia Eagles|
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      |Custom PayIQ Eligible Date|
      |          0               |
    Then Capture the current URL for "Load_URL"

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "77"
    Then Enter "Customer Quote Items" "Fuel Surcharge" as "11"

    Then Add "Stop 1" "Customer Quote Items" "Inside Pick Up" Accessorial with Unit as "Per Mile" Qty as "1" and Price "0.06"
    Then Update details
    |Payable|
    |True   |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    #Step 7
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Customer Invoices" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Scroll down with "3" Times
    Then Click on link "Customer Invoices"
    Then Click on button "New"
    Then Wait for "3" Seconds
    Then Set "1WeekFromToday" with "MMMdd,yyyy=>7"
    Then Update details
      |Invoice Number|Invoice Date|Invoice Status|Invoice Due Date|Invoice Total|
      |2899       |0           |Approved|SysData=>1WeekFromToday  |15           |
    Then Click on "SaveEdit" button
    Then Wait for "4" Seconds

    #Step 8
    Then Click on Partial Link Text "2899" on Page
    Then Go to "Related" Tab
    Then Scroll Until Related List for "Customer Invoice Accessorials"
    Then Click on link "Customer Invoice Accessorials"
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "3" Seconds
    Then Select Multiple "Other" from "Accessorials" list and click on "Add to Invoice >>"
    Then Wait for "2" Seconds
    Then Update the "Other" accessorial data for row 1
      | Qty     | Unit Price     | Payable | Unit    |
      | 2000.00 |  0.01          | True    | Per Pound |
    Then Wait for "3" Seconds

    #Step 9
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 10
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 11
    Then Navigate to stored URL for "Load_1L"

    #Step 12
    Then Click on Edit icon on Label "PayIQ Locked"
    Then Update details
      |PayIQ Locked|
      |         True |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "3" Seconds
    Then Verify Details
      |PayIQ Locked|
      |         True |
    
    #Step 13
    Then Scroll Until Related List for "Pay Details"
    Then Wait for "3" Seconds
    Then Click on link "Pay Details"
    Then Scroll down with "3" Times
    Then Verify table has "2" records with "Participant Name" as "Second User (User)" and "Calculation Tier" as "" and "PayIQ Program" as "PayIQ Program 2762"
    Then Verify table has "2" records with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "Calculation Tier" as "" and "PayIQ Program" as "PayIQ Program 2762"
    Then Get "Pay Detail-" Name with "Participant Name" as "Second User (User)" and "Pay Amount" as "USD 3.40" and store in "PayDetail_1"
    Then Get "Pay Detail-" Name with "Participant Name" as "Second User (User)" and "Pay Amount" as "USD 15.15" and store in "PayDetail_2"
    Then Get "Pay Detail-" Name with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "Pay Amount" as "USD 15.15" and store in "PayDetail_3"
    Then Get "Pay Detail-" Name with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "Pay Amount" as "USD 3.40" and store in "PayDetail_4"


    #Step 14
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 15
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 16
    Then Navigate to stored URL for "Load_1L"

    #Step 17 and expected result a
    Then Scroll Until Related List for "Pay Details"
    Then Wait for "3" Seconds
    Then Click on link "Pay Details"
    Then Verify table has "1" records with "Pay Detail ID" as "SysData=>PayDetail_1" and "Calculation Tier" as "" and "Participant Name" as "Second User (User)"
    Then Verify table has "1" records with "Participant Name" as "Second User (User)" and "Calculation Tier" as "" and "Pay Detail ID" as "SysData=>PayDetail_2"
    Then Verify table has "1" records with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "Calculation Tier" as "" and "Pay Detail ID" as "SysData=>PayDetail_3"
    Then Verify table has "1" records with "Participant Name" as "Joe Philadelphia Eagles (Contact)" and "Calculation Tier" as "" and "Pay Detail ID" as "SysData=>PayDetail_4"

    


    
