Feature:2746 - TMS Admin Configuration- Enforce Customer Credit Limits

  @API @DeleteFile @Regression @TMS @Smoke @Admin @Mail @WEB @SingleCurrency @2746
  Scenario: 2746 - TMS Admin Configuration- Enforce Customer Credit Limits

    When Login into Salesforce

  # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Capture the current URL for "TMS_Admin"
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Enforce Customer Credit Limits |
      | True                           |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

  # Step 2 & 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | The Jedi Order Credit Limit | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Valuables   | 10000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

   # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000001"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes

  # Expected Result 5 a
    Then Verify Message displaying with Text "Save was successful."
    Then Verify Message displaying with Text "This customer quote is on credit hold."

  # Step 6
    Then Wait for "5" Seconds
    Then Store Customer Quote value on "Customer_Quote"
    Then Click on Customer Quote from FQA Page
    Then Wait for "5" Seconds

  #Expected Result 6 b
    Then Verify Label Checkbox
      | Credit Hold |
      | True        |

  # Step 7
    Then Wait for "1" Seconds
    Then Click on Edit icon on Label "Net Freight Charges"
    Then Enter Label "Net Freight Charges" Text as "999999"
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds

  #Expected Result 7 c
    Then Verify Label Checkbox
      | Credit Hold |
      | True        |

  #Step 8
    Then Delete All Records with name "SysData=>Customer_Quote" for "rtms__CustomerQuote__c"
    Then Wait for "5" Seconds

  #Step 9
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "The Jedi Order Credit Limit" from List
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Review Status"
    Then Update details
      |Credit Review Status|
      |Credit Hold         |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify "Credit Review Status" having value of "Credit Hold"
    Then Wait for "2" Seconds
    Then Capture the current URL for "JD_TP"
    Then Wait for "1" Seconds

  #Step 9 a
    Then Click on "Refresh Credit" with Text
    Then Wait for "3" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "3" Seconds
    Then Refresh current Page
    Then Wait for "3" Seconds
    Then Go to "Credit" Tab
    Then  Get Details
    |Credit Limit Utilized| Credit Limit Available|
    |                     |                       |
    Then Verify "Credit Limit Utilized" is under value of "100.00"
    Then Verify "Credit Limit Available" is positive value

    # Step 10 & 11
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "100"
    Then "Save" Customer Quotes
    Then Wait for "1" Seconds

  #Expected Result 12 d
    Then Verify Message displaying with Text "Save was successful."
    Then Verify Message displaying as "This customer quote is on credit hold."

  # Step 13
    Then Click on Customer Quote from FQA Page
    Then Wait for "1" Seconds

  #Expected Result 13 e
    Then Verify Label Checkbox
      | Credit Hold |
      | True        |

  # Step 14
    Then Delete All Records with name "SysData=>1L" for "rtms__Load__c"


  # Step 15
    Then Navigate to stored URL for "JD_TP"
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Review Status"
    Then Update details
      |Credit Review Status|
      |Approved            |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify "Credit Review Status" having value of "Approved"

  # Step 16
    Then Open "TMS Admin" from App Launcher
    Then Capture the current URL for "TMS_Admin"
    Then Go to "Configuration" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Wait for "2" Seconds
    Then Scroll into Section "Global Settings" -
    Then Update details -
      | Enforce Customer Credit Limits |
      | false                           |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

  # Step 17 & 18
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | The Jedi Order Credit Limit | Truckload | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Valuables   | 10000  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Capture the current URL for "Load_2L"

  # Step 19
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000001"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Wait for "1" Seconds

  #Expected Result 20 f
    Then Verify Message displaying as "Save was successful."

  # Step 21
    Then Wait for "5" Seconds
    Then Store Customer Quote value on "Customer_Quote"
    Then Click on Customer Quote from FQA Page
    Then Wait for "5" Seconds

  #Expected Result 21 g
    Then Verify Label Checkbox
      | Credit Hold |
      | False        |

  #Step 22
    Then Delete All Records with name "SysData=>Customer_Quote" for "rtms__CustomerQuote__c"
    Then Wait for "5" Seconds

  #Step 23
    Then Navigate to stored URL for "JD_TP"
    Then Go to "Credit" Tab
    Then Click on Edit icon on Label "Credit Review Status"
    Then Update details
      |Credit Review Status     |
      |Credit Hold              |
    Then Click on button "Save"
    Then Wait for "2" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "3" Seconds
    Then Click on "Refresh Credit" with Text
    Then Wait for "3" Seconds
    Then Refresh current Page
    Then Wait for "3" Seconds
    Then Go to "Credit" Tab
    Then  Get Details
      |Credit Limit Utilized| Credit Limit Available|
      |                      |                         |
    Then Verify "Credit Limit Utilized" is under value of "100.00"
    Then Verify "Credit Limit Available" is positive value

  # Step 24 & 25
    Then Navigate to stored URL for "Load_2L"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "100"
    Then "Save" Customer Quotes
    Then Wait for "1" Seconds

  #Expected Result 26 h
    Then Verify Message displaying as "Save was successful."

  # Step 27
    Then Click on Customer Quote from FQA Page
    Then Wait for "1" Seconds

  #Expected Result 27 i
    Then Verify Label Checkbox
      | Credit Hold |
      | False       |
