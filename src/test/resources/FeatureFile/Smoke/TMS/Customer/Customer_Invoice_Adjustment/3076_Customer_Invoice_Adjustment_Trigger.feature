Feature: 3076 - Customer Invoice Adjustment Trigger- CI Adjustment Field: Insert/Update/Del

  @Regression @TMS @Smoke @WEB @SingleCurrency @Customer @Customer_Invoice @3076 @CustomerInvoiceAdjustment
  Scenario: 3076 - Customer Invoice Adjustment Trigger- CI Adjustment Field: Insert/Update/Del

    When Login into Salesforce
    #Steps1
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details

  #  Then Open Load Number "L-110"
    #Step2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    #Step3
    Then Update details
      | Billing Status   |
      | Approved |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "1" Seconds
    Then Refresh current Page
    #Step4
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    #Step5
    Then Verify details for
      | Adjustments |
      | NA          |

    #Step6
    Then Capture the current URL for "Customer Invoice"
    Then Wait for "1" Seconds
    Then Click on link "Customer Invoice Adjustments"

    Then Click on button "New"
    Then Update details -
      | Category | Description | Adjustment Amount |
      | Other    | testing       | 50.00             |
    Then Click on button "Save"
    Then Verify Message displaying with Text "Customer Invoice Adjustment"
    Then Wait for "2" Seconds
    Then Navigate to stored URL for "Customer Invoice"
    Then Wait for "2" Seconds

    #Step7
    Then Verify details for
      | Adjustments |
      | USD 50.00   |

    #Step8
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Click on link "Customer Invoice Adjustments"

    Then Edit the "testing" from grid
    Then Update details -
      | Adjustment Amount |
      | 100.00            |
    Then Click on button "Save"
    Then Verify Message displaying with Text "Customer Invoice Adjustment"
    Then Wait for "2" Seconds
    Then Navigate to stored URL for "Customer Invoice"
    Then Wait for "2" Seconds
    
    #Step9
    Then Verify details for
      | Adjustments |
      | USD 100.00  |

    #Step10
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Click on link "Customer Invoice Adjustments"
    Then Delete "testing" record from grid
    Then Verify Message displaying with Text "Customer Invoice Adjustment"
    Then Wait for "2" Seconds
    Then Navigate to stored URL for "Customer Invoice"

    #Step11
    Then Verify details for
      | Adjustments |
      | NA          |