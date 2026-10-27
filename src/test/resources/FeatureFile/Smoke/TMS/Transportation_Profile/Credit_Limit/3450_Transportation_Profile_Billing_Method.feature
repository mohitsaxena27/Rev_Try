Feature: 3450 - Transportation Profile- Billing Method

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Transportation_Profile @CreditLimit @3450
  Scenario: 3450 - Transportation Profile- Billing Method
    When Login into Salesforce

    # Step 1
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Los Angeles Lighting" from List
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Method"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | Email          |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page"

    #Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Chicago Pizza" from List
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Method"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | Print          |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page1"

    #Step 3
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Revenova HQ" from List
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Method"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | EDI            |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page2"

    #Step 4
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Go to "Billing" Tab
    Then Scroll into Section "Billing Method"
    Then Click on Edit icon on Label "Billing Method"
    Then Update details
      | Billing Method |
      | --None--       |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page3"

    #Step 5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer             | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Los Angeles Lighting | LTL  | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 6500   | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 7
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "4" Seconds
    Then Refresh current Page
    # Step 8,9 Expected result a
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Scroll into Section "Billing Contact Information"
    Then Verify details for
      | Billing Method |
      | Email          |

    #Step 10
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Chicago Pizza | LTL  | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Sauce       | 2550   | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 11
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 12
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "4" Seconds
    Then Refresh current Page

    # Step 13,
    Then Go to "Quotes/Invoices" Tab

    #Step 14  Expected result b
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Scroll into Section "Billing Contact Information"
    Then Verify details for
      | Billing Method |
      | Print          |


   #Step 15
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Revenova HQ | LTL  | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Materials   | 1550   | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 16
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 17
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "4" Seconds
    Then Refresh current Page

    # Step 18,
    Then Go to "Quotes/Invoices" Tab

    #Step 19  Expected result c
    Then Open "Customer Invoices" using value from "3L" on QuoteInvoice Tab
    Then Scroll into Section "Billing Contact Information"
    Then Verify details for
      | Billing Method |
      | EDI            |

    #Step 20
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 4L       | Boston Beans | LTL  | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Beans       | 1550   | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 21
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds

    # Step 22
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "4" Seconds
    Then Refresh current Page

    # Step 23,
    Then Go to "Quotes/Invoices" Tab

    #Step 24  Expected result d
    Then Open "Customer Invoices" using value from "4L" on QuoteInvoice Tab
    Then Scroll into Section "Billing Contact Information"
    Then Verify details for
      | Billing Method |
      | Email          |


