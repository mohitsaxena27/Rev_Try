Feature: 1986 - Field Set Line Item TMS7 - Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1986 @Field_Set
  Scenario: 1986 - Field Set Line Item TMS7 - Mode Specific

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
      |TMS7 LTL      |testing            |
    Then Select "Save" from List -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds

     #Step 2
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Add the Following Fields in this Order
      |NMFC Class|HazMat Number|HazMat|Extended Price|Created Date|Created By|Cargo Summary|Area Units|Area|
      |NMFC Class|HazMat Number|HazMat|Extended Price|Created Date|Created By|Cargo Summary|Area Units|Area|
    Then Click on button "Save" -
    Then Wait for "1" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

     #Step3
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | LTL | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza |  3             | NA                       | NA               | NA                   |

     #Expected Result a
    Then Verify details for all Required Enabled fields
    |Pickup     |Delivery|Name      |Description|Weight|Weight Units|
    |P1         |   D2        |Item 1    |           |      |lbs         |
    Then Verify details for all Enabled fields
         |HU Count|Handling Units|Area|Area Units   |Cargo Summary|Extended Price|HazMat|HazMat Number|NMFC Class|
         |        |--None--      |    |Square Feet  |             |              |False |             |--None--  |

    Then Verify details for all Disabled or Readonly fields
         |Created By ID|Date|Time|
         |             |    |    |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000   | NA           | NA       | NA            |

    Then Update details
      |Area         |Area Units   |Extended Price|HazMat|HazMat Number|NMFC Class|
      |50           |Square Feet  |150            |True |Tst1         |100|

    Then Save Load With All details
     #Steps 4
    Then Scroll into Section "Boston Beans"
    Then Expand "Items" for "1" Load
    Then Click on "Item 1" with Text
    Then Wait for "2" Seconds
    Then Switch Window by index "1"
      #Step 5 #Expected Result b
    Then Verify Details
      |Cargo Summary|
      |Bananas, 15000 lbs|
    Then Verify Details
      |Weight  |Area|Area Units|Item Description|
      |15,000  |50  |Square Feet|Bananas        |
    Then Scroll into Section "Hazardous Material Details (if applicable)"
    Then Verify Details
      | NMFC Class|Extended Price|HazMat Number|
      |100         |150          |Tst1|
    Then Verify Label Checkbox
      |HazMat           |
      |True             |
    Then Close Current Tab
    Then Switch to Parent Window
