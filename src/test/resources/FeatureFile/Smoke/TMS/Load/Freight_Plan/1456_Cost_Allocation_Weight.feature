Feature: 1456 - Freight Plan Management Job- Cost Allocation: Weight

  @Regression @TMS @Smoke @WEB @SingleCurrency  @FreightPlan @1456
  Scenario: 1456 - Freight Plan Management Job- Cost Allocation: Weight

    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Freight Plan" -
    And Update the Custom Select option "Freight Plan Cost Allocation Method" as "Weight"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Steps2
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode    | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Chicago Pizza | Drayage | NA             | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | 0             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3P   | Account_Address | Los Angeles Lighting | 1             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 4D   | Same_as_Customer | NA    | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Banana      | 500    | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 3 | Stop 4   | Grapes      | 500    | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    #Step 3
    Then Save Load With All details

   # Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "3000"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful"

    #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode    | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Denver Deli Meats | Flatbed | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Chicago Pizza | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 1000   | NA           | NA       | NA             |

    #Step 6
    Then Save Load With All details
    Then Capture the current URL for "Load_2"

    # Step 7
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "3000"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful"

    #Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode    | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Denver Deli Meats | Flatbed | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 1000   | NA           | NA       | NA             |

    #Step 9
    Then Save Load With All details
    Then Capture the current URL for "Load_3"

    # Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "3000"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful"

    #Step 11
    Then Click on button with Title "Add Freight Plan"
    Then Wait for "5" Seconds

    #Step 12
    Then Freight Plan - "Add Load Number" "SysData=>1L"
    Then Freight Plan - "Add Load Number" "SysData=>2L"

    #Step 13
    Then Click on button with Title "Consolidate All"

    #Step 14
    Then Update details
      | Mode    |
      | Flatbed |
    Then Click on button with Title "Save"
    Then Wait for "5" Seconds

    #Step 15
    Then Freight Plan - Select the "1" Load hyperlink in the Carrier Loads Section
    Then Switch Window by index "1"
    Then Wait for "2" Seconds

     #Step 16
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - Flatbed"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "11000"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 17
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
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

#    Then Open "Loads" from App Launcher
#    Then Open Load Number "L-1588"
    #Step 18
    Then Go to "Shipment" Tab
    Then Click on button with Title "Go to Freight Plan"
    Then Select First Freight Plan from list
    Then Wait for "2" Seconds

    #Step 19
    Then Click on button with Title "Financial Summary"
    Then Wait for "5" Seconds
    Then Verify Financial Summary Modal is displaying with Details
    #Expected Result a
    Then the Freight Plan Financial Summary should display the following rows
      | Load Number | Customer          | Customer Quote Total | Carrier Quote Total | Quoted Margin | Customer Invoice Total | Carrier Invoice Total | Invoiced Margin |
      | 1L          | Chicago Pizza     | USD 3,000.00         | USD 3,666.67        | -USD 666.67   | USD 3,000.00           | USD 3,666.67          | -USD 666.67     |
      | 2L          | Denver Deli Meats | USD 3,000.00         | USD 3,666.67        | -USD 666.67   | USD 3,000.00           | USD 3,666.67          | -USD 666.67     |
      | 3L          | Denver Deli Meats | USD 3,000.00         | USD 3,666.67        | -USD 666.67   | USD 3,000.00           | USD 3,666.67          | -USD 666.67     |

    Then the Freight Plan Financial Summary totals should be displayed as
      | Customer Quote Total | Carrier Quote Total | Quoted Margin | Customer Invoice Total | Carrier Invoice Total | Invoiced Margin |
      | USD 9,000.00         | USD 11,000.00       | -USD 2,000.00 | USD 9,000.00           | USD 11,000.00         | -USD 2,000.00   |

    #Step 20
    Then Click on button with Title "Close"
    Then Wait for "2" Seconds
    Then Close Current Tab
    Then Switch to Parent Window
    Then Wait for "3" Seconds
    #Step 21
    Then Navigate to stored URL for "Load_2"
    #Step 22
    Then Expand "Items" for "1" Load
    Then Click on "Edit" on "1" item
    Then Update details
      | Weight |
      | 2000   |
    Then Click on "Save" with Text
    Then Wait for "1" Seconds
    Then Collapse "Items" for "1" Load

    #Step 23 & 24
    Then Navigate to stored URL for "Load_3"

    #Step 25
    Then Expand "Items" for "1" Load
    Then Click on "Edit" on "1" item
    Then Update details
      | Weight |
      | 3000   |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Collapse "Items" for "1" Load

    #Step 26
    Then Click on button with Title "Go to Freight Plan"
    Then Wait for "2" Seconds
    Then Select First Freight Plan from list
    Then Wait for "2" Seconds
    #Step 27
    Then Click on button with Title "Financial Summary"
    Then Wait for "2" Seconds
    Then Verify Financial Summary Modal is displaying with Details
    #Expected b
    Then the Freight Plan Financial Summary should display the following rows
      | Load Number | Customer          | Customer Quote Total | Carrier Quote Total | Quoted Margin | Customer Invoice Total | Carrier Invoice Total | Invoiced Margin |
      | 1L          | Chicago Pizza     | USD 3,000.00         | USD 1,833.33        | USD 1,166.67  | USD 3,000.00           | USD 1,833.33          | USD 1,166.67    |
      | 2L          | Denver Deli Meats | USD 3,000.00         | USD 3,666.67        | -USD 666.67   | USD 3,000.00           | USD 3,666.67          | -USD 666.67     |
      | 3L          | Denver Deli Meats | USD 3,000.00         | USD 5,500.00        | -USD 2,500.00 | USD 3,000.00           | USD 5,500.00          | -USD 2,500.00   |

    Then the Freight Plan Financial Summary totals should be displayed as
      | Customer Quote Total | Carrier Quote Total | Quoted Margin | Customer Invoice Total | Carrier Invoice Total | Invoiced Margin |
      | USD 9,000.00         | USD 11,000.00       | -USD 2,000.00 | USD 9,000.00           | USD 11,000.00         | -USD 2,000.00   |



