Feature: 1554 - Transportation Profile- Tax Exempt Load Trigger

  @Regression @TMS @Smoke @API @WEB @Transportation_Profile @SingleCurrency @1554
  Scenario: 1554 - Transportation Profile- Tax Exempt Load Trigger

    When Login into Salesforce
# Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Sales Tax Exclusions" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Verify Text displaying as "No records to display." -
    Then Switch to Parent Frame
# Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Mexico Company Two" from List
 # Step 3
    Then Go to "Billing" Tab
    Then Scroll into Section "Tax Information"
    Then Click on Edit icon on "Tax Exempt"
    Then Update details
      | Tax Exempt |
      | False      |
    Then Click on "Save" button on Details Page

  # Load 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Mexico Company Two | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Boston Beans | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 7             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12345  | NA           | NA       | NA             |
    Then Save Load With All details
    Then Verify Message displaying as "Save was successful."
# Step 2
#  Expected result a
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Customer Order Information"
    Then Verify Label Checkbox
      |Tax Exempt|
      |False     |

   # Step 3
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Mexico Company Two" from List
   # Step 4
    Then Go to "Billing" Tab
    Then Scroll into Section "Tax Information"
    Then Click on Edit icon on "Tax Exempt"
    Then Update details
      | Tax Exempt |
      | true       |
    Then Click on "Save" button on Details Page

    # Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Mexico Company Two | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Account_Address | Boston Beans | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 7             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 12345  | NA           | NA       | NA             |
    Then Save Load With All details

    # Step 6
    # Expected result b
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "Customer Order Information"
    Then Verify Label Checkbox
      |Tax Exempt|
      |true     |
