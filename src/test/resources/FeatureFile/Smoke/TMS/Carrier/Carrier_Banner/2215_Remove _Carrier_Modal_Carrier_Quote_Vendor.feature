Feature: 2215 - Carrier Banner LWC- Remove Carrier Modal- Carrier Quote (Vendor)

  @Regression @TMS @Smoke @WEB @Carrier @SingleCurrency @Carrier_Banner @2215
  Scenario: 2215 - Carrier Banner LWC- Remove Carrier Modal- Carrier Quote (Vendor)

    When Login into Salesforce
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | LTL       | Dry Van 48     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed     |1234 |NA          |NA       |NA       |
     #Steps 2
    Then Save Load With All details

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1001"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Summary" Tab
    Then Click on Native "Remove Carrier" icon
    Then Verify Modal Heading Text displaying as "Email Carrier One" -
    Then Within the Legend select "Removal Charge" as "Yes" -
    Then Verify details for all Required Enabled fields -
      |Accessorial              |Charge           |Vendor Service|Quote Contact|
      |Vehicle Ordered Not Used |                 |              |              |
#    Then Verify "Currency" Attribute "data-value" displaying as "USD"
    Then Click on button "Remove Carrier" -
    Then "Charge" field highlights red as required -

    Then Update details -
      |Removal Reason   |Removal Comments|Charge   |Accessorial             |Vendor Service                        |Quote Contact|
      |Carrier Breakdown|Truck Broke     |123.45   |Vehicle Ordered Not Used|Email Carrier Two - Vendor - LTL|Tom Email Carrier Two|

     Then Click on button "Remove Carrier" -
    Then Verify Message displaying with "Carrier removed from load."
    Then Verify Message displaying with "Removal charge added."
    Then Go to "Details" Tab
    Then Verify Details "Load Status" displaying as "Unassigned"
    Then Go to "Freight Quote Assistant" Tab
    Then Go to "Vendor Quotes" Tab
    Then Verify "Vendor Service" Link value displaying as "Email Carrier Two - Vendor - LTL"
    Then Set Vendor Quote value on to "Vendor_Quote"
    Then Verify details for all Enabled fields
    |Quote Contact                    |
    |Tom Email Carrier Two            |
    Then Verify Vendor "Accessorial Charges" displaying as "123.45"
    Then Verify Vendor "Quote Total" displaying as "123.45"
    Then Verify "Vendor Quote Items" "Vehicle Ordered Not Used" with details "Fixed Cost,,1,,123.45,,123.45"
    Then Click on Vendor Quote from FQA Page
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section with Title "Pricing Summary"
    Then Verify details for
      |Removal Reason   |Removal Comments|Removal Charge Accessorial|Removal Charge|Accessorial Charges|Carrier Total|
      |Carrier Breakdown|Truck Broke     |Vehicle Ordered Not Used  |123.45        |123.45             |123.45       |
    Then Scroll into Section with Title "General Information"
    Then Go to "Related" Tab on Next to "Documents Status" Tab
    Then Scroll down with "4" Times
    Then Verify "Vendor Invoices" Table details with following Details
    |Invoice Number|Invoice Date|Load|Accessorial Charges|Invoice Total|
    |TONU           |0           |1L  |123.45             |123.45       |

