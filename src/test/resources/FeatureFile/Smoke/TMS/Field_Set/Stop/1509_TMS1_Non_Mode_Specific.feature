Feature: 1509- Field Set Stop TMS1- Non Mode Specific

  @Regression @TMS @Smoke @WEB @SingleCurrency @1509 @Field_Set
  Scenario: 1509- Field Set Stop TMS1- Non Mode Specific

    When Login into Salesforce

    #Step1
    Then Open "Loads" from App Launcher
    Then Wait for "2" Seconds
    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Open "Stop" Object Manager
    Then Click on "Field Sets" with Text
    Then Wait for "2" Seconds
    Then Capture the current URL for "Field_Set_Page"
    Then Open Field Sets "TMS1" from List
    Then Switch to Frame by Title "Salesforce - Enterprise Edition"
    Then Delete Fields if any available with Field Set
    Then Add the Following Fields in this Order
    |Shipping/Receiving Contact|Pickup/Delivery Number|Instructions|Appointment Required|Appointment Time|Shipping/Receiving Hours|
    |Shipping/Receiving Contact|Pickup/Delivery Number|Instructions|Appointment Required|Appointment Time|Shipping/Receiving Hours|
    Then Make below Field Set Required
    |Instructions|
    |Instructions|
    Then Click on button "Save" -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    Then Close Current Tab
    Then Switch to Parent Window

       #Step2 & 3
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload | Dry Van 53     | Y             | N                 |

    #Expected Result a
    Then Verify details for all Enabled fields
    |Shipping/Receiving Hours|Appointment Time|Appointment Required|Pickup/Delivery Number|Shipping/Receiving Contact|
    |                        |                |                    |                      |                          |
    Then Verify details for all Required Enabled fields
    |Instructions|
    |            |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | 0830            | True                   |

    Then Update details
    |Instructions          |Pickup/Delivery Number|
    |Test Instructions 1509|123                   |
#

    #Expected Result b
    Then Verify details for all Enabled fields
    |Shipping/Receiving Contact|
    |Joe Boston Beans|

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  3           |  08:10-22:35              | 1445             | NA                 |

    Then Enter "Pickup_Delivery_Number" as "987" on "2D" Stop

    Then Update details
      |Instructions_2          |Shipping/Receiving Contact_2|
      |                      |Joe Boston Beans            |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight   |Weight_Units|HU_Count |Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Bananas      |15000    |NA          |NA        |NA       |NA    |NA   |NA    |NA            |NA        |

    Then Save Load
    #Expected c
    Then "Instructions" field highlights red as required -

    Then Update details
      |Instructions_2          |
      |Delivery Instructions   |

    Then Save Load With All details

#    Then Open Load Number "L-78"
    #Step 4
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds

    #Expected Result d
    Then Verify details for
      | Location     | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | Pickup/Delivery Number | Instructions           |
      | Boston Beans | 08:30            | Joe Boston Beans           | 09:00-22:00             | 123                    | Test Instructions 1509 |
    Then Verify details For Checkbox
      |Appointment Required           |
      |True                           |
    Then Collapse "Details" for "1" Load

  #Step 5
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds

    #Expected Result e
    Then Verify details for
      | Location          | Appointment Time | Shipping/Receiving Contact | Shipping/Receiving Hour | Pickup/Delivery Number | Instructions          |
      | Denver Deli Meats | 14:45            | Joe Boston Beans           | 08:10-22:35             | 987                    | Delivery Instructions |
    Then Verify details For Checkbox
      |Appointment Required           |
      |False                           |




  