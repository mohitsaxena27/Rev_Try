Feature:2939 - Pay Header - Statuses - Aggregate Calculation Criteria

  @API @Regression @PayIQ  @WEB @SingleCurrency @2939 @PayHeader
  Scenario: 2939 - Pay Header - Statuses - Aggregate Calculation Criteria

    When Login into Salesforce

   #Pre - Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Pay Header Aggregate" from List
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | NA            | NA                |

    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Kayaks      | 999    | NA           | NA       | NA             |
    Then Save Load With All details
    #Step 2
    Then Capture the current URL for "Load_1L"
    #Step 3
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)  |
      | Joe Chicago White Sox |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "40"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
   #Step 5
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 6
    Then Navigate to stored URL for "Load_1L"
    Then Scroll Until Related List for "Pay Details"

    #Step 7
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Chicago White Sox (Contact)"
    Then Wait for "2" Seconds
    Then Get Details
      | Pay Detail ID | Pay Header |
      |               |            |
    Then Set "Pay_Details_ID_1" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_1" with "SysData=>Pay Header"
    Then Capture the current URL for "Pay_Details_1"
  #Step 8
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Approved       |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Approved       |

    #Expected a
    Then Navigate to stored URL for "Pay_Details_1"
    Then Wait for "1" Seconds
    Then Verify Label Checkbox
      | Pay Approved |
      | True         |

    #Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Grand Rapids Kayaks | Truckload | NA             | NA            | NA                |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Kayaks      | 998    | NA           | NA       | NA             |
    Then Save Load With All details
    #Step 10
    Then Capture the current URL for "Load_2L"
    #Step 11
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)  |
      | Joe Chicago White Sox |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    #Step 12
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "45"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
   #Step 13
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
   #Step 14
    Then Navigate to stored URL for "Load_2L"
    Then Wait for "2" Seconds

   #Step 15
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Chicago White Sox (Contact)"
    Then Wait for "2" Seconds
    #Expected Result c.a and c.b
    Then Get Details
      | Pay Detail ID | Pay Header |
      |               |            |
    Then Set "Pay_Details_ID_2" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_2" with "SysData=>Pay Header"
    Then Capture the current URL for "Pay_Details_2"


  #Step 16
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Paid           |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Paid           |

    #Expected b
    Then Navigate to stored URL for "Pay_Details_2"
    Then Wait for "1" Seconds
    Then Verify Label Checkbox
      | Pay Approved |
      | True         |

  #Step 17
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Grand Rapids Kayaks | Truckload | NA             | NA            | NA                |

    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Kayaks      | 998    | NA           | NA       | NA             |
    Then Save Load With All details
    Then Wait for "5" Seconds
    #Step 18
    Then Capture the current URL for "Load_3L"
    #Step 19
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)  |
      | Joe Chicago White Sox |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    #Step 20
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "50"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
   #Step 21
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"
    #Step 22 & 23
    Then Navigate to stored URL for "PayIQ_Program_1"
    Then Wait for "1" Seconds
    #Step 24
    Then Go to "PayIQ Generated" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on link "Pay Details"
    Then Wait for "3" Seconds
    Then Capture the current URL for "Pay_Details_Page"

    #Expected c.1
    Then Click on "Pay Detail-" with "Paid From" as "SysData=>1L" and "Pay Amount" as "USD 4.00"
    Then Wait for "1" Seconds
    Then Verify Details
         |Pay Detail ID            |Pay Header|
         |SysData=>Pay_Details_ID_1|SysData=>Pay_Header_1|
   #Expected c.2
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Paid From" as "SysData=>2L" and "Pay Amount" as "USD 4.50"
    Then Wait for "1" Seconds
    Then Verify Details
      |Pay Detail ID            |Pay Header|
      |SysData=>Pay_Details_ID_2|SysData=>Pay_Header_2|

    #Expected c.3
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Paid From" as "SysData=>1L" and "Pay Amount" as "USD -4.00"
    Then Wait for "1" Seconds
    Then Get Details
      |Pay Detail ID            |Pay Header|
      |||
    Then Set "Pay_Details_ID_3" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_3" with "SysData=>Pay Header"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_1"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_2"
    Then Verify Assertion for "Pay Header" not contains "SysData=>Pay_Header_1"
    Then Verify Assertion for "Pay Header" not contains "SysData=>Pay_Header_2"

    #Expected c.4
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Paid From" as "SysData=>1L" and "Pay Amount" as "USD 8.00"
    Then Wait for "3" Seconds
    Then Get Details
      |Pay Detail ID            |Pay Header|
      |||
    Then Set "Pay_Details_ID_4" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_4" with "SysData=>Pay Header"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_1"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_2"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_3"
    Then Verify Assertion for "Pay Header" contains "SysData=>Pay_Header_3"

     #Expected c.5
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Paid From" as "SysData=>2L" and "Pay Amount" as "USD 9.00"
    Then Wait for "3" Seconds
    Then Get Details
      |Pay Detail ID            |Pay Header|
      |||
    Then Set "Pay_Details_ID_5" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_5" with "SysData=>Pay Header"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_1"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_2"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_3"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_4"
    Then Verify Assertion for "Pay Header" contains "SysData=>Pay_Header_3"

    #Expected c.6
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Paid From" as "SysData=>2L" and "Pay Amount" as "USD -4.50"
    Then Wait for "3" Seconds
    Then Get Details
      |Pay Detail ID            |Pay Header|
      |||
    Then Set "Pay_Details_ID_6" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_6" with "SysData=>Pay Header"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_1"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_2"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_3"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_4"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_5"
    Then Verify Assertion for "Pay Header" contains "SysData=>Pay_Header_3"

    #Expected c.6
    Then Navigate to stored URL for "Pay_Details_Page"
    Then Wait for "2" Seconds
    Then Click on "Pay Detail-" with "Paid From" as "SysData=>3L" and "Pay Amount" as "USD 10.00"
    Then Wait for "3" Seconds
    Then Get Details
      |Pay Detail ID            |Pay Header|
      |||
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_1"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_2"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_3"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_4"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_5"
    Then Verify Assertion for "Pay Detail ID" not contains "SysData=>Pay_Details_ID_6"
    Then Verify Assertion for "Pay Header" contains "SysData=>Pay_Header_3"
