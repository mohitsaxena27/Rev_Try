Feature: 561 - AccuFrate API- Quote Operation

  Background: Pre- Test
    Then Delete Field with Title "AccuFrateQuoteOperation"
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to 1 Frame
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | false           | false                |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

  @API @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @561 @AccuFrate @Debugging
  Scenario: 561 - AccuFrate API- Quote Operation

    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | True            | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step2, Step3 & Step4
    Given Upload File "AccuFrateQuoteOperation - 561.txt" with Title "AccuFrateQuoteOperation"

    #Step5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | AccuFrate Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 6500   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |

    Then Save Load With All details

    #Step6 & Step7
    Then Go to "Freight Quote Assistant" Tab
    And "Capture" and Close all the Toast messages from Bottom
    #Expectec a
    Then Verify Quotes returned
    #Expected Result b
    And Verify "FreightService.svc" "Request_Payload" with "TC561_RequestBody_Expected.xml"
    #Step8
    Then Click on View Quotes
    Then Select "Holland Motor Express - AF" With Carrier Total as "USD 545.32" from View Quotes
    Then Wait for "2" Seconds
    Then Click on "Carrier Quote" header link under "Carrier Quotes" tab
    #Step 9
    Then Go to "Details" Tab on Next to "Pricing" Tab

    #Expected Result c
    Then Scroll into Section with Title "General Information"
    Then Verify details for
       | Disclaimer                             |
       | Holland - Note that when a shipment weighs less than 500 lbs, a single shipment fee of $40.00 will be charged - Liftgate one piece can't exceed 1700lbs -or 60*72*64 Inches - Correct dimensions and weight must be entered to have an accurate rate - Quote valid up to 95 inches - Up to 650 CBF - Up to 9999 lbs - 1 piece can't exceed 3500 lbs - GLT |
    Then Scroll into Section with Title "Pricing Summary"
    Then Verify details for
      | Freight Charges | Discount | Discount Percent | Net Freight Charges | Fuel Surcharge | Accessorial Charges | Carrier Total |
      | NA              | NA       | NA              | USD 545.32          | USD 0.00       | NA          | USD 545.32    |

    Then Scroll into Section with Title "Service Information"
    Then Verify details for
      | Service Class | Direct/Interline      | Estimated Transit Time (Days) |
      | NA            | Unspecified           | 2                             |
    Then Scroll into Section with Title "Contract Information"
    Then Verify details for
      | Carrier Quote Reference |
      | 859972055:168826989     |
