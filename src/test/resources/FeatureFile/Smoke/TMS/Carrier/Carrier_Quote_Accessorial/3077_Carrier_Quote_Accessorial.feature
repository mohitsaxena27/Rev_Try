Feature: 3077 - Carrier Quote Accessorial- CQ Accessorial Charges Field: Insert/Update/Delete

  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Carrier_Service @3077 @CarrierQuoteAccessorial
  Scenario: 3077 - Carrier Quote Accessorial- CQ Accessorial Charges Field: Insert/Update/Delete

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

    #Step2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Verify Text displaying as "New Carrier Quote"
    Then Enter Carrier Service as "Email Carrier One - Truckload"

    Then Add "Stop 1" "Carrier Quote Items" "After Hours Pick Up" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "100"
    Then Add "Stop 2" "Carrier Quote Items" "After Hours Delivery" Accessorial with Unit as "Fixed Cost" Qty as "2" and Price "50"
    Then Add "Load" "Carrier Quote Items" "Blind Shipments" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "50"
    Then Click on button "Assign"
    Then Verify Message displaying as "Load was assigned to carrier"
    Then Set Carrier Quote value on to "Carrier_Quote"

    # Step3 & Step4
    Then Go to "Quotes/Invoices" Tab
    Then Open "Carrier Quotes" using value from "Carrier_Quote" on QuoteInvoice Tab
    Then Verify Details
      | Accessorial Charges |
      | USD 250.00          |

    #Step5
    Then Add "Load" "Carrier Quote Items" "Customs" Accessorial with Unit as "Fixed Cost" Qty as "1" and Price "50"
    Then Click on button "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "6" Seconds

    #Step6
    Then Verify Details
      | Accessorial Charges |
      | USD 300.00          |

    #Step7
    Then Go to "Related" Tab on Next to "Documents Status" Tab
   # Then Switch to Frame by Title "vfFrameId_1757180886328"
   Then Edit the "Blind Shipments" from grid
    Then Update the "Blind Shipments" accessorial data
      | Charge |
      | 100.00 |
#    Then Switch to Parent Frame

    #Step8
    Then Verify Details
      | Accessorial Charges |
      | USD 350.00          |

    #Step9
    Then Go to "Related" Tab on Next to "Documents Status" Tab
    Then Delete "Blind Shipments" record from grid
    Then Verify Message displaying as "was deleted."
    Then Refresh current Page
    #Step10
    Then Verify Details
      | Accessorial Charges |
      | USD 250.00          |