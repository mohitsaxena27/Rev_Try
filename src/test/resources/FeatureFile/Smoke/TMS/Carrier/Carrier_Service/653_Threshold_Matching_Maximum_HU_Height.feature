Feature: 653 - Carrier Service- Threshold: Matching Maximum HU Height

  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Carrier_Service @653
  Scenario: 653 - Carrier Service- Threshold: Matching Maximum HU Height

    When Login into Salesforce
    #Steps1
    Then Open "Transportation Profiles" from App Launcher

    Then Search and Select "Stored Rate Carrier Two" from List

    Then Click on "Carrier Service" Link Text "Stored Rate Carrier Two - LTL" on Page

    Then Scroll into Section "Handling Unit Thresholds"

    Then Click on Edit icon on "Maximum HU Height"

    Then Enter Label "Maximum HU Height" Text as "100"

    Then Click on "Save" button

    Then Verify "Maximum HU Height" having value of "100"

     #Steps 2
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
     |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Denver Deli Meats | LTL      | Dry Van 53     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     |  NA             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Material     |8000  |NA          |2       |Pallets       |45    |45   |45    |NA            |50        |

    Then Save Load With All details

    #Step3
     Then Go to "Freight Quote Assistant" Tab

    Then Verify Message displaying as "Stored Rate Quote(s) created."
    Then Verify "Carrier Service" Link value displaying as "Stored Rate Carrier Two - LTL"
    Then Verify "Contract Id" Attribute "value" displaying as "QM11223344"
    Then Verify "Carrier Quote Reference" Attribute "value" displaying as ""
    # 0=Today , 1= Tomorrow , -1 = yesterday
    Then Verify "Effective Date" Attribute "value" displaying as "0"
    Then Verify "Estimated Transit Time" Attribute "value" displaying as "3"
    Then Verify "Interline" having value of "Unspecified"
    Then Verify "Service Class" Attribute "value" displaying as ""
    Then Verify "Rate Entry" Attribute "data-value" displaying as "Rate Entry"
    Then Verify Text displaying as "Contract"

    Then Verify Carrier "Freight Charges" displaying as "500"
    Then Verify Carrier "Discount" displaying as "0"
    Then Verify Carrier "Net Freight Charges" displaying as "500"
    Then Verify Carrier "Quote Total" displaying as "500"
    Then Verify "Carrier Quote Items" "Net Freight Charges" with details "Fixed Cost,,1,,500,,500"
    Then Verify "Carrier Quote Items" "Fuel Surcharge" with details "NA"
    Then Verify Carrier Pricing Notes displaying as "Net Freight Charges"
    Then Verify Carrier Pricing Notes displaying as "Rate Entry"












