Feature: 417 - Fuel Surcharge - Fuel Index Value: Current Week

  @Regression @TMS @Smoke @WEB @Admin @SingleCurrency  @Job_Run @Fuel_Surcharge @417
  Scenario: 417 - Fuel Surcharge - Fuel Index Value: Current Week

    When Login into Salesforce

  # Step 1
    Then Go to Home Page
    Then Run "FuelIndexUpdateJob" Job
    Then Wait for "6" Seconds

  # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Fuel Surcharges" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Fuel Surcharge" -
    Then Switch to Parent Frame

    Then Update details
      | Name         | Fuel Index                             | Current Week Start Day | Fuel Index Value | Fuel Index Start | Fuel Index End | Fuel Index Increment | Type                 | Percent Start | Percent Increment |
      | CW Surcharge | U.S. No 2 Diesel Retail Prices, Weekly | Monday                 | Current Week     | 1                | 10             | 1                    | Percent of Line Haul | 1.543         | .35               |
    Then Click on button with Title "Build Entry Table"
    Then Wait for "2" Seconds

  #Step 3
    Then Update details
      | Ship Date |
      | 0         |

    Then Wait for "1" Seconds
    Then Click on button with Title "Save" -
    Then Wait for "2" Seconds
    Then Set Key "Fuel_Surcharge" page Record Id with "rtms__FuelSurcharge__c"
    Then Get "Index Effective Value" value and store in "Index_Effective_Value"

  # Step 4
    Then Find Matching Percent value and store in "Final_Percentage"

  # Step 5
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode      | Lane     | Category | Rate Type    | Fuel Surcharge | Status   |
      | Indy Irrigation        | Truckload | US to US | Carrier  | Freight+Fuel | CW Surcharge   | Accepted |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service                     | Rate Method  | Rate |
      | Stored Rate Carrier Two - Truckload | Fixed Amount | 1000 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

  # Step 6
    Then Verify and get Rate_Entry Number on kay "Rate_Entry1_Name"
    Then Capture the current URL for "Rate_Entry1_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

  # Step 7
    Then Click on Native "Clone" button
    Then Wait for url Change from "Rate_Entry1_Link"
    Then Wait for "5" Seconds
    Then Scroll into Section "General Information"
    Then Update details
      | Category |
      | Customer |
    Then Scroll into Section "Base Rate Calculation"
    Then Update details
      | Rate |
      | 2000 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

  #Step 8
    Then Verify and get Rate_Entry Number on kay "Rate_Entry2_Name"
    Then Capture the current URL for "Rate_Entry2_Link"
    Then Set Key "Rate_Entry_2" page Record Id with "rtms__RateEntry__c"

  # Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer        | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Indy Irrigation | Truckload | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | San Francisco 49ers | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Water       | 10000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

  # Step 10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds

    Then Verify Quotes returned

  # Step 10.a
    Then Verify Text displaying as "SysData=>Rate_Entry1_Name"

  # Expected a & b
    Then Convert percentage "SysData=>Final_Percentage" value to decimal and store in "Unit_Price"
    Then "Multiply" "SysData=>Final_Percentage" value with "1000" and store in "Fuel_Surcharge_Total"
    Then Verify "Carrier Quote Items" "Fuel Surcharge" with details "Percent of Freight,,1,000,,SysData=>Unit_Price,,SysData=>Fuel_Surcharge_Total"

  # Step 10.b
    Then Verify Text displaying as "SysData=>Rate_Entry2_Name"

  # Expected result c & d
    Then "Multiply" "SysData=>Final_Percentage" value with "2000" and store in "Fuel_Surcharge_Total"
    Then Verify "Customer Quote Items" "Fuel Surcharge" with details "Percent of Freight,,2,000,,SysData=>Unit_Price,,SysData=>Fuel_Surcharge_Total"