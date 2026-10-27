Feature: 3078 - Customer Invoice Accessorial Trigger- Acc Charges Field: Insert/Update/Del

  @Regression @TMS @Smoke @WEB @SingleCurrency @Customer @3078 @CustomerInvoiceAccessorial
  Scenario: 3078 - Customer Invoice Accessorial Trigger- Acc Charges Field: Insert/Update/Del

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

#   Then Open Load Number "L-112"
    #Step2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds

    Then Verify Text displaying as "New Customer Quote"

    Then Update details
      | Status   |
      | Accepted |

    Then Add "Stop 1" "Customer Quote Items" "After Hours Pick Up" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "100"
    Then Add "Stop 2" "Customer Quote Items" "After Hours Delivery" Accessorial with Unit as "Fixed Cost" Qty as "2" and Price "50"
    Then Add "Load" "Customer Quote Items" "Blind Shipments" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "50"

    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step4
    Then Update details
      | Billing Status |
      | Approved       |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    Then Wait for "3" Seconds
    Then Refresh current Page

    #Step5
    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "1L" on QuoteInvoice Tab
    Then Wait for "2" Seconds

    #Step5
    Then Verify Details
      | Accessorial Charges |
      | USD 250.00          |

    #Step6 & Step7
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab

#    Then Click on Native "Customer Invoice Accessorials" icon
    Then Wait for "2" Seconds
    Then Click on link "Customer Invoice Accessorials"
#    Then Click on "Customer Invoice Accessorials" header link under "Related" tab
    Then Click on button "New"
    Then Select "Customs" from "Accessorials" list and click on "Add to Invoice >>"
    Then Wait for "2" Seconds

    ## Steps from previous to update the deails
#    Then Click on button "Save"
#    Then Edit the "Customs" accessorial data
    Then Update the "Customs" accessorial data
      | Qty  | Unit Price | Unit       |
      | 1.00 | 50.00      | Fixed Cost |
    Then Wait for "5" Seconds
    Then Refresh current Page
    #Step8
    Then Verify Details
      | Accessorial Charges |
      | USD 300.00          |

    #Step9 & Step10
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Click on link "Customer Invoice Accessorials"
    Then Edit the "Customs" from grid
    Then Update the "Customs" accessorial data
      | Unit Price |
      | 100.00     |

    #Step11
    Then Verify Details
      | Accessorial Charges |
      | USD 350.00          |

    #Step12 & 13
    Then Go to "Related" Tab on Next to "Preview Customer Invoice" Tab
    Then Click on link "Customer Invoice Accessorials"

    Then Delete "Customs" record from grid

    Then Navigate Browser Back
    Then Navigate Back & Refresh
    #Step14
    Then Verify Details
      | Accessorial Charges |
      | USD 250.00          |
