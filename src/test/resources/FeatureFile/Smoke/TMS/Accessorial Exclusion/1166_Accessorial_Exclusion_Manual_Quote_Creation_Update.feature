Feature: 1166 - Accessorial Exclusion- Manual Quote Creation/Update

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Accessorial_Exclusion @1166
  Scenario: 1166 - Accessorial Exclusion- Manual Quote Creation/Update

    When Login into Salesforce

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Denver Deli Meats | Truckload | Dry Van 53     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |
    And Update details
      | Holiday Pick Up |
      | true            |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 3             | NA                       | NA               | NA                   |
    Then Wait for "1" Seconds
    And Update details
      | Lift Gate Delivery |
      | true               |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Save" Carrier
    Then Verify Message displaying as "Save was successful."

    #Step 3
    Then Open "Transportation Profiles" from App Launcher
    Then Recently Viewed to All
    Then Search And Select "Email Carrier One" from Search List
    Then Capture the current URL for "TP_Email_Carrier_One"

    Then Click on link "Accessorial Exclusions"
    Then Click on button "New"

    #Step 3.a, 3.b
    Then Update details
      | Accessorial     |
      | Holiday Pick Up |
    Then Click on "SaveEdit" button
    Then Click on "AE-" with Contains Text

    Then Capture the current URL for "Accessorial_Exclusion"

    #Step 4
    Then Navigate to stored URL for "Load_1"

    Then Go to "Freight Quote Assistant" Tab
    Then Click on button with Title "Get Quote"

    #Expected a
    Then Wait for "2" Seconds
    Then Verify Error Message displaying as "This action cannot be performed as Holiday Pick Up is an excluded accessorial for this Carrier."

    #Step 5
    Then Scroll down with "5" Times
    Then Select radio button for "Email Carrier One - Truckload"
    Then Click on "Accept" button at Carrier Quote List LWC

    #Expected b
    Then Verify Error Message displaying as "This action cannot be performed as Holiday Pick Up is an excluded accessorial for this Carrier."

    #Step 6
    Then Wait for "2" Seconds
    Then Click on "Tender" button at Carrier Quote List LWC

    #Expected c
    Then Verify Error Message displaying as "This action cannot be performed as Holiday Pick Up is an excluded accessorial for this Carrier."

    #Step 7
    Then Wait for "2" Seconds
    Then Click on "Assign" button at Carrier Quote List LWC

    #Expected d
    Then Verify Error Message displaying as "This action cannot be performed as Holiday Pick Up is an excluded accessorial for this Carrier."

    #Step 8
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Denver Deli Meats | Truckload | Dry Van 53     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |
    And Update details
      | Holiday Pick Up |
      | true            |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_2"

    #Step 9
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Update details
      | Carrier Service               |
      | Email Carrier One - Truckload |
    Then Wait for "2" Seconds

    #Expected e
    Then Verify Available Option Not displaying as "Email Carrier One - Truckload"

    #Step 10
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer          | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 3L       | Denver Deli Meats | Truckload | Dry Van 53     | Y             | Y                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_3"

    #Step 11
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Save" Carrier
    Then Verify Message displaying as "Save was successful."
    
    #Step 12
    Then Click on link "Load Accessorials"
#    Then Scroll Until Related List for "Load Accessorials"
    Then Click on button "New"

    Then Select "Holiday Pick Up" from "Accessorials" list and click on "Add to Pickup Stop 1 >>"
    Then Update the "Holiday Pick Up" accessorial data
      | Provider |
      | Carrier  |

    #Step 13
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then "Save" Carrier

    #Expected f
    Then Verify Error Message displaying as "This action cannot be performed as Holiday Pick Up is an excluded accessorial for this Carrier."