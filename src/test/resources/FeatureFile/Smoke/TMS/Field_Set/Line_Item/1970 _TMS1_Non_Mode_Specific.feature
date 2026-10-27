Feature: 1970 - Field Set Line Item TMS1 - Non-Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1970 @Field_Set
  Scenario: 1970 - Field Set Line Item TMS1 - Non-Mode Specific

    When Login into Salesforce

    #Step1
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Open "Line Item" Object Manager
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Open Field Sets "TMS1" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Add the Individual Fields "NMFC Number" Set after "HazMat"
    Then Make below Field Set Required
    |NMFC Number|
    |NMFC Number|
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window
     #Step2
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  3             | NA                       | NA               | NA                   |
    Then Update details
      |Item Description  |
      |Bananas           |
     #Expected Result a
    Then Verify details for all Required Enabled fields
    |Weight|NMFC Number|Pickup Stop|Delivery Stop|
    |      |           |           |             |
    Then Verify details for all Enabled fields
         |Weight Units|HU Count|Handling Units|Length|Width|Height|Dimension Units|NMFC Class|HazMat|
         |            |        |--None--      |      |     |      |in             |--None--  |      |
    Then Verify details for all Disabled or Readonly fields
      |Linear Feet|Density|
      |           |       |
    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description       |Weight|Weight_Units|HU_Count |Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |NA                |15000  |NA          |NA       |NA       |NA    |NA   |NA    |NA            |NA        |

    Then Save Load
    #Expected Result b
    Then "NMFC Number" field highlights red as required -

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count |Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |NA           |NA    |NA          |2        |Pallets       |45    |45   |45.00    |NA            |NA        |

    Then Wait for "2" Seconds
    Then Update details
    |NMFC Class|NMFC Number|HazMat |
    |50        |22161      |True   |
    Then Wait for "4" Seconds
       #Expected Result c
    Then Verify details for all Disabled or Readonly fields
      |Linear Feet|Density|
      |3.75       |142.22 |
    #Expected Result d
    Then Verify details for all Enabled fields
    |HazMat Number Type|HazMat Number|HazMat Class/Division|HazMat Packaging Group|
    |--None--          |             |--None--             |--None--              |
    Then Save Load With All details
      #Steps 3
    Then Scroll into Section "Boston Beans"
    Then Expand "Items" for "1" Load
    Then Click on "Item 1" with Text
    Then Wait for "2" Seconds
    Then Switch Window by index "1"
    #Expected Result e
    Then Verify Details
    |HU Count|Weight|Handling Units|Weight Units|Length|Width|Height|Linear Feet|Density|
    |2       |15,000|Pallets       |lbs         |45.00    |45.00   |45.00    |3.75       |142.22 |
    Then Verify Details
    |NMFC Class|NMFC Number|
    |50        |22161      |

    Then Verify Label Checkbox
      |HazMat           |
      |True             |

    #Steps 4
    Then Close Current Tab
    Then Switch to Parent Window
    #Step 5
    Then Click on Native "Add Line Item" icon
    #Expected Result f
    Then Verify details for all Required Enabled fields
    |Item Number|Item Description|Weight|NMFC Number|Pickup Stop                                                            |Delivery Stop|
    |           |                |      |           |Stop 1 - Boston Beans 526 Beacon Street, Boston, Massachusetts 02215   |Stop 2 - Denver Deli Meats 1435 Fox St., Denver, Colorado 80204             |
    Then Verify details for all Enabled fields
         |Weight Units|HU Count|Handling Units|Length|Width|Height|Dimension Units|NMFC Class|HazMat|
         |            |        |--None--      |      |     |      |in             |--None--  |      |
    Then Verify details for all Disabled or Readonly fields
      |Linear Feet|Density|
      |           |       |

    #Steps 6
    Then Scroll Up with "3" Times
    Then Update details
      |Item Number|Item Description|Weight|
      |Item 2     |Material        |6500  |

    #Step 7
    Then Click on button "Save"
    #Expected Result g
    Then "NMFC Number" field highlights red as required -
   Then Scroll Up with "3" Times
    Then Update details
      |HU Count |Handling Units|
      |1        |Pallets       |
    Then Scroll Up with "3" Times
    Then Update details
     |Length|Width|Height|NMFC Class|
     |45    |45   |45.00    |55        |
    Then Wait for "4" Seconds
    Then Update details
      |NMFC Number|HazMat|
      |22211      |True  |

      #Expected Result h
    Then Verify details for all Disabled or Readonly fields
      |Linear Feet|Density|
      |3.75       |123.26 |

    #Expected Result i
    Then Verify details for all Enabled fields
    |HazMat Number Type|HazMat Number|HazMat Class/Division|HazMat Packaging Group|
    |--None--          |             |--None--             |--None--              |
    Then Click on button "Save"
    Then Verify Message displaying as "Line Item saved."
    Then Refresh current Page
     #Step8
    Then Scroll into Section "Boston Beans"
    Then Expand "Items" for "1" Load
    Then Click on "Item 2" with Text
    Then Wait for "2" Seconds
    Then Switch Window by index "1"
    #Expected Result j
    Then Verify Details
      |HU Count|Weight|Handling Units|Weight Units|Length|Width|Height|Linear Feet|Density|
      |1       |6,500|Pallets       |lbs         |45.00    |45.00   |45.00    |3.75       |123.26 |
    Then Scroll into Section "Commodity Information"
    Then Verify Details
      |NMFC Class|NMFC Number|Item Description|
      |55        |22211      |Material|
    Then Verify Label Checkbox
      |HazMat           |
      |True             |
    Then Close Current Tab
    Then Switch to Parent Window

  