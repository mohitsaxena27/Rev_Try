Feature: 1992 - Field Set Load TMS1 - Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1992 @Field_Set
  Scenario: 1992 - Field Set Load TMS1 - Mode Specific

    When Login into Salesforce
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Edit Object" from Setup Icon
    Then Switch Window by index "1"

    # Step 1
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Click on Native "New" button
    Then Switch to Frame by Title "Load Field Set"
    Then Update details -
      | Field Set Label | Field Set Name | Where is this used? |
      | TMS1 LTL        | TMS1_LTL       | testing             |
    Then Select "Save" from List -
    Then Switch to Parent Frame
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"

    # Step 2
    Then Add the Following Fields in this Order
      | Tractor Number | Temperature Setting Minimum | Payment Terms | Other Instructions | Order Date | HazMat |Equipment Type| Driver Phone | Driver | Delivery Status | Cargo Value | Accounting Notes |
      | Tractor Number | Temperature Setting Minimum | Payment Terms | Other Instructions | Order Date | HazMat |Equipment Type| Driver Phone | Driver | Delivery Status | Cargo Value | Accounting Notes |
    Then Make below Field Set Required
      | Equipment Type |
      | Equipment Type |
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

    # Step 3
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL       | NA             | N             | N                 |
    Then Wait for "2" Seconds
    #Expected a
    Then Verify details for all Enabled fields
      | Accounting Notes | Cargo Value  | Driver | Driver Phone |Equipment Type| HazMat | Order Date | Other Instructions | Payment Terms | Temperature Setting Minimum | Tractor Number |
      |                  |              |        |              |              | False  |            |                    | --None--      |                             |                |
    Then Verify details for all Disabled or Readonly fields
      |Delivery Status|
      |               |
    #Continue with Step 3
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load
    #Expected Result b
    Then "Equipment Type" field highlights red as required -

    #Continue Step 3
    Then Select "Equipment Type" as "Dry Van 53"
    Then Update details
      | Cargo Value | Driver           | Driver Phone | Order Date | Other Instructions | Tractor Number |
      | 100         | Joe Boston Beans | 123-654-9510 |  90         | TESTING 1992       | 1992           |
    Then Save Load With All details

    #step 4
    Then Go to "Details" Tab

    #Expected c
    Then Scroll into Section "Customer Order Information"
    Then Verify Details
      | Order Date |
      | 90    |
    Then Scroll into Section "Carrier Requirements"
    Then Verify Details
      | Equipment Type | Other Instructions |
      | Dry Van 53'    | TESTING 1992       |
    Then Scroll into Section "Load Summary"
    Then Verify Details
      | Cargo Value |
      | USD 100.00  |
    Then Scroll into Section "Assigned Carrier Information"
    Then Verify Details
      | Driver           | Tractor Number | Driver Phone |
      | Joe Boston Beans | 1992           | 123-654-9510  |


