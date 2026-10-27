Feature: 600 - Carrier Exclusions- Carrier Parameter with Carrier Stored Rate

  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Carrier_Exclusion @600
  Scenario: 600 - Carrier Exclusions- Carrier Parameter with Carrier Stored Rate

    When Login into Salesforce

    #Steps1
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Denver Deli Meats | LTL      | Dry Van 53     | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Broncos     |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      |Line_Item|PickUp    |Delivery    |Description  |Weight|Weight_Units|HU_Count|Handling_Units|Length|Width|Height|Dimension_Unit|NMFC_Class|
      |1        |Stop 1    |Stop 2      |Mixed     |4000  |NA          |8       |Pallets       |24    |24   |24    |NA            |50        |

    #Steps2
    Then Save Load With All details
    Then Capture the current URL for "Load_1"
    #Step3
    Then Go to "Freight Quote Assistant" Tab
     Then Wait for "8" Seconds
    Then Verify Message displaying as "Stored Rate Quote(s) created."
    Then Verify "Carrier Service" Link value displaying as "Stored Rate Carrier Two - LTL"
    Then Verify "Contract Id" Attribute "value" displaying as "QM11223344"
    Then Verify "Carrier Quote Reference" Attribute "value" displaying as ""
    Then Verify "Estimated Transit Time" Attribute "value" displaying as "3"
    Then Verify "Interline" having value of "Unspecified"
    Then Verify "Service Class" Attribute "value" displaying as ""
    Then Verify "Rate Entry" Attribute "data-value" displaying as "Rate Entry"
    Then Verify Text displaying as "Contract"

    Then Verify Carrier "Freight Charges" displaying as "USD 500.00"
    Then Verify Carrier "Discount" displaying as "USD 0.00"
    Then Verify Carrier "Net Freight Charges" displaying as "USD 500.00"
    Then Verify Carrier "Fuel Surcharge" displaying as ""
    Then Verify Carrier "Accessorial Charges" displaying as ""
    Then Verify Carrier "Quote Total" displaying as "USD 500.00"
    Then Verify "Carrier Quote Items" "Net Freight Charges" with details "Fixed Cost,,1,,500,,500"
    Then Verify "Carrier Quote Items" "Fuel Surcharge" with details "NA"
    Then Verify Carrier Pricing Notes displaying as "Net Freight Charges"
    Then Verify Carrier Pricing Notes displaying as "Rate Entry"

    #Step 4
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Denver Deli Meats" from List
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Carrier Exclusions"
    Then Wait for "2" Seconds
    #Step 5
    Then Click on link "Carrier Exclusions"
    Then Click on button "New"
    Then Wait for "2" Seconds
    Then Update details
         |Carrier|Exclusion Type|
         |Stored Rate Carrier Two|Exclude Pickup and Delivery|

    #Step 6
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Click on "Exclusion-" with Contains Text
    Then Wait for "2" Seconds
    Then Set Key "Carrier_Exclusion" page Record Id with "rtms__CarrierExclusion__c"

    #Step 7
    Then Navigate to stored URL for "Load_1"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then Click on Native "Refresh Quotes" icon
    Then Wait for "2" Seconds
    Then Verify Text displaying as "New Carrier Quote"
    Then Verify "Carrier Service" having value of ""
    Then Verify "Contract Id" Attribute "value" displaying as ""
    Then Verify "Carrier Quote Reference" Attribute "value" displaying as ""
    Then Verify "Estimated Transit Time" Attribute "value" displaying as ""
    Then Verify "Service Class" Attribute "value" displaying as ""
    Then Verify "Rate Entry" Attribute "data-value" displaying as ""
    Then Verify Text displaying as "Contract"
    Then Verify Carrier "Net Freight Charges" displaying as "USD 0.00"
    Then Verify Carrier "Fuel Surcharge" displaying as ""
    Then Verify Carrier "Accessorial Charges" displaying as ""
    Then Verify Carrier "Quote Total" displaying as "USD 0.00"
    Then Verify Carrier Pricing Notes not displaying as "Rate Entry"














