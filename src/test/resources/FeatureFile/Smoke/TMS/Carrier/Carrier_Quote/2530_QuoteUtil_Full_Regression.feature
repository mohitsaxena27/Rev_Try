Feature: 2530 - QuoteUtil- Full Regression

  @API @Regression @TMS @Smoke @API @WEB @MultiCurrency @2530 @Carrier_Quote @Carrier
  Scenario: 2530 - QuoteUtil- Full Regression

    When Login into Salesforce
    #Step1
    Then Run "FuelIndexUpdateJob" Job
    #Step2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Ajax Customer      | LTL  | Dry Van 53     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |
    Then Update details
         |After Hours Pick Up|
         |True               |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     | NA            | NA                       | NA               | NA                   |
    Then Update details
      |After Hours Delivery|
      |True               |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas    | 7400   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |
    Then Save Load With All details

    #Step3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "40" Seconds
    #Expected a
    Then Verify Quotes returned more than "10"

    #Step 4
    Then Click on Native "Refresh Quotes" icon
    Then Wait for "40" Seconds
    #Expected b
    Then Verify Quotes returned more than "10"



