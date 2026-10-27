Feature: 1971 - Field Set Line Item TMS1 - Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1971 @Field_Set
  Scenario: 1971 - Field Set Line Item TMS1 - Mode Specific

    When Login into Salesforce

#    #Step1
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Open "Line Item" Object Manager
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Click on Native "New" button
    Then Switch to Frame by Title "Line Item Field Set"
    Then Update details -
      |Field Set Label|Where is this used?|
      |TMS1 LTL      |testing            |
    Then Select "Save" from List -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds

     #Step 2
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Add the Following Fields in this Order
        |Extended Price|HazMat Contact|HazMat|NMFC Class|Width|Length|Handling Units|HU Count|Weight Units|Weight|
        |Extended Price|HazMat Contact|HazMat|NMFC Class  |Width|Length|Handling Units      |HU Count|Weight Units|Weight|
    Then Make below Field Set Required
        |NMFC Class|Handling Units|
        |NMFC Class|Handling Units|


    Then Click on button "Save" -
    Then Wait for "1" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

     #Step3
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | LTL | Dry Van 53     | Y             | N                 |
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
    |Weight|NMFC Class|Handling Units|Pickup Stop|Delivery Stop|
    |      |           |--None--      ||             |
    Then Verify details for all Enabled fields
         |Weight Units|HU Count|Length|Width|HazMat|HazMat Contact|Extended Price|
         |            |        |      |     |      |              |              |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description       |Weight|Weight_Units|HU_Count |Handling_Units|Length|Height|Width|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |NA                |15000  |NA          |NA     |NA       |NA    |NA          |NA|NA               |NA       |

    Then Save Load
    #Expected Result b
    Then "NMFC Class" field highlights red as required -
    Then "Handling Units" field highlights red as required -

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count |Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |NA           |NA    |NA          |2        |Pallets       |45    |45   |NA    |NA            |50        |

    Then Wait for "2" Seconds
    Then Update details
      |HazMat |
      |True   |
    Then Wait for "4" Seconds
       #Expected Result c
    Then Verify details for all Enabled fields
    |HazMat Number Type|HazMat Number|HazMat Class/Division|HazMat Packaging Group|HazMat Contact|
    |--None--          |             |--None--             |--None--              |              |

    Then Update details
    |HazMat Contact_2|
    |Joe Boston Beans|
    Then Save Load With All details
      #Steps 4
    Then Scroll into Section "Boston Beans"
    Then Expand "Items" for "1" Load
    Then Click on "Item 1" with Text
    Then Wait for "2" Seconds
    Then Switch Window by index "1"
    #Expected Result d
    Then Verify Details
    |HU Count|Weight|Handling Units|Weight Units|Length|Width|
    |2       |15,000|Pallets       |lbs         |45.00    |45.00   |
    Then Verify Details
    |NMFC Class|
    |50        |
     Then Scroll into Section "System Information"
    Then Verify Details
    |HazMat Contact|
    |Joe Boston Beans|
    Then Verify Label Checkbox
      |HazMat           |
      |True             |

    #Steps 5
    Then Close Current Tab
    Then Switch to Parent Window

    #Step 6
    Then Click on Native "Add Line Item" icon
    #Expected Result e
    Then Verify details for all Required Enabled fields
    |Item Number|Item Description|Weight|Handling Units|NMFC Class|Pickup Stop                                                            |Delivery Stop|
    |           |                |      |--None--      |--None--  |Stop 1 - Boston Beans 526 Beacon Street, Boston, Massachusetts 02215   |Stop 2 - Denver Deli Meats 1435 Fox St., Denver, Colorado 80204             |
    Then Verify details for all Enabled fields
         |Weight Units|HU Count|Length|Width|HazMat|HazMat Contact|Extended Price|
         |            |        |      |     |      |              |              |
    #Steps 7
    Then Scroll Up with "3" Times
    Then Update details
      |Item Number|Item Description|Weight|
      |Item 2     |Material        |6500  |
    #Step 7
    Then Click on button "Save"
    Then Wait for "3" Seconds
    #Expected Result f
    Then "NMFC Class" field highlights red as required -
    Then "Handling Units" field highlights red as required -
   Then Scroll Up with "3" Times
    Then Update details
      |HU Count |Handling Units|
      |1        |Pallets       |
    Then Update details
     |Length|Width|
     |45    |45   |
    Then Wait for "2" Seconds
    Then Update details
    |NMFC Class  |HazMat|HazMat Contact_2|
    |55          |True  |Joe Boston Beans|
    Then Wait for "1" Seconds
    Then Update details
    |HazMat|
    |True  |

    #Expected Result g
    Then Verify details for all Enabled fields
    |HazMat Number Type|HazMat Number|HazMat Class/Division|HazMat Packaging Group|HazMat Contact|
    |--None--          |             |--None--             |--None--              |              |
    Then Click on button "Save"
    Then Verify Message displaying as "Line Item saved."
    Then Refresh current Page
     #Step8
    Then Scroll into Section "Boston Beans"
    Then Expand "Items" for "1" Load
    Then Click on "Item 2" with Text
    Then Wait for "2" Seconds
    Then Switch Window by index "1"
    #Expected Result h
    Then Verify Details
      |HU Count|Weight|Handling Units|Weight Units|Length|Width|
      |1       |6,500|Pallets       |lbs         |45.00    |45.00   |
    Then Scroll into Section "Commodity Information"
    Then Verify Details
      |NMFC Class|Item Description|Item Number|HazMat Contact|
      |55        |Material|2                  |Joe Boston Beans|
    Then Verify Label Checkbox
      |HazMat           |
      |True             |
    Then Close Current Tab
    Then Switch to Parent Window

  