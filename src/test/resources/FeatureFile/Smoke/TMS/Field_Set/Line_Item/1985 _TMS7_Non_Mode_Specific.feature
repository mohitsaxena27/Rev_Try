Feature: 1985 - Field Set Line Item TMS7 - Non Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1985 @Field_Set
  Scenario: 1985 - Field Set Line Item TMS7 - Non Mode Specific

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
    Then Open Field Sets "TMS7" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Delete Fields if any available with Field Set
    Then Add the Following Fields in this Order
    |HazMat Contact|HazMat Class/Division|HazMat|NMFC Number|Length|NMFC Class|Extended Price|Cargo Summary|
    |HazMat Contact|HazMat Class/Division|HazMat|NMFC Number|Length|NMFC Class|Extended Price|Cargo Summary|
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window
     #Step2
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza    |  3             | NA                       | NA               | NA                   |

     #Expected Result a
    Then Verify details for all Enabled fields
      |Cargo Summary|Extended Price|NMFC Class|Length|NMFC Number|HazMat|HazMat Class/Division|HazMat Contact|
      |            |               |--None--  |      |           |False |--None--             |     |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000   | NA           | NA       | NA            |

    Then Update details
    |Extended Price|NMFC Class|Length|NMFC Number|HazMat|HazMat Class/Division|HazMat Contact|
    |100           |100       |45.00 |1985       |True  |1.1                  |Joe Boston Beans|

    Then Save Load With All details

    #Steps 3
    Then Scroll into Section "Boston Beans"
    Then Expand "Items" for "1" Load
    Then Click on "Item 1" with Text
    Then Wait for "2" Seconds
    #Step 4
    Then Switch Window by index "1"
    #Expected Result b
    Then Verify Details
       |Cargo Summary|
       |Bananas, 15000 lbs|
    #Step 5
    Then Verify Details
    |Length |
    |45.00  |
    Then Scroll into Section "Hazardous Material Details (if applicable)"
    Then Verify Details
      | NMFC Class|NMFC Number|Extended Price|HazMat Class/Division|HazMat Contact|
      |100         |1985       |100       |1.1 |Joe Boston Beans                          |
    Then Verify Label Checkbox
      |HazMat           |
      |True             |
    Then Close Current Tab
    Then Switch to Parent Window


