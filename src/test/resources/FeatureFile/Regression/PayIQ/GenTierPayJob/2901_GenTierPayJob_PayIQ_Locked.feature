Feature:2901 - GenTierPayJob - PayIQ Locked

  @API @Regression @PayIQ  @WEB @SingleCurrency @2901 @PayIQ_Logs
  Scenario: 2901 - GenTierPayJob - PayIQ Locked

    When Login into Salesforce

   #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program 2757" from List


#    Step 2
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
    Then Click on Partial Link Text "Calculation Tier-" on Page
    Then Wait for "2" Seconds
    Then Get Details
    |Calculation Tier ID|
    |                   |

    #Step 3 & 4
    Then Open "Loads" from App Launcher
#
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | N             | N                 |
    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then  Capture the current URL for "Load_1L"

    #Step 5
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)    | Customer Sales Rep |
      | Joe Philadelphia Eagles | Second User        |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact)    |
      | Joe Philadelphia Eagles |

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then Enter "Customer Quote Items" "Net Freight Charges" as "999"
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."

    #Step 7
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

    #Step 8
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 9
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds

    #Step 10
    Then Click on Edit icon on Label "PayIQ Locked"
    Then Update details
      | PayIQ Locked |
      | True         |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID" and "Participant Name" as "Second User (User)"
    Then Get Details
      | Pay Detail ID |
      |               |
    Then Set "Pay Detail ID1" with "SysData=>Pay Detail ID"
    Then Navigate to stored URL for "Load_1L"
    Then Click on "Pay Detail-" with "Calculation Tier" as "SysData=>Calculation Tier ID" and "Participant Name" as "Joe Philadelphia Eagles (Contact)"
    Then Get Details
      | Pay Detail ID |
      |               |
    Then Set "Pay Detail ID2" with "SysData=>Pay Detail ID"
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "2" Seconds
    Then Click on button with Title "Locked"
    Then Wait for "5" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1001"
    Then Click on button with Title "Update Invoice"
    Then Wait for "5" Seconds
    Then Verify Message displaying as "The invoice was successfully updated."
    Then "Save" Customer Quotes
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Save was successful."

#Step 11
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds

#Step 12
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

#Step 13 & expected a
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Verify table has "2" records with "Calculation Tier" as "SysData=>Calculation Tier ID"
    Then Verify Table With Header
      | Pay Detail ID           |
      | SysData=>Pay Detail ID1 |
    Then Verify Table With Header
      | Pay Detail ID           |
      | SysData=>Pay Detail ID2 |
