Feature: 461 - Carrier Banner LWC- Remove Carrier Modal Format/Functionality

  @Regression @TMS @Smoke @WEB @SingleCurrency @Mail @Carrier @Carrier_Banner @461
  Scenario: 461 - Carrier Banner LWC- Remove Carrier Modal Format/Functionality

    When Login into Salesforce

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Boston Beans | Truckload | Dry Van 48     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats |  3             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Banana     |15000 |NA          |NA       |NA       |
     #Steps 2
    Then Save Load With All details

    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
     Then Enter Carrier Service as "Email Carrier Two - Truckload"
     Then Wait for "1" Seconds
     Then "Assign" Carrier
     Then Verify Message displaying as "Load was assigned to carrier."
     Then Go to "Summary" Tab
     #Step 4
     Then Go to "Details" Tab
    #Expected result a
    Then Verify Details "Carrier Sales Rep" displaying as "User User"

    #Step 5
    Then Click on Native "Remove Carrier" icon

        #   Step 6 &  Expected result b
    Then Verify Modal Heading Text displaying as "Email Carrier Two" -
    Then Verify details for all Enabled fields -
    |Removal Reason|Removal Comments|
    |--None--      |                |
    Then Verify "Removal Charge" having value of "Yes" -
    Then Verify "Removal Charge" having value of "No" -
    Then Verify Label "Accessorial" not displaying on Page -
    Then Verify "Send Email" having value of "Yes" -
    Then Verify "Send Email" having value of "No" -
    #Steps 7 and  Expected result c
    Then Within the Legend select "Send Email" as "Yes" -
    Then Verify details for all Enabled fields -
      |Tender Contact        |Email Template           |Email CC List|
      |Tom Email Carrier Two |Remove Carrier - LEX2    |             |
    Then Verify "Tender Contact" Clear Icon button is displaying -
    #Steps 8 and  Expected result d
    Then Within the Legend select "Removal Charge" as "Yes" -
    Then Verify details for all Required Enabled fields -
      |Accessorial              |Charge           |Vendor Service|Quote Contact|
      |Vehicle Ordered Not Used |                 |              |              |
    Then Verify details for all Enabled fields -
      |Attach Rate Confirmation |Tender Contact           |
      |false                    |Tom Email Carrier Two    |
    Then Verify details for all Disabled or Readonly fields -
    |Currency|
    |USD     |

    #Step 9
    Then Click on PickList "Removal Reason" -
    #Expected e
    Then Verify Text displaying as "Load Not Ready" -
    Then Verify Text displaying as "Carrier Breakdown" -
    Then Verify Text displaying as "Carrier Cancelled" -

    #Step 10
    Then Click on "Carrier Breakdown" with Text -
    Then Update details -
    |Removal Comments|Email Template|
    |ABC123/*-+^&()  |-None-        |
    #Step 11
    Then Click on button "Remove Carrier" -
    #Expected f
    Then "Charge" field highlights red as required -
    Then "Vendor Service" field highlights red as required -
    Then "Quote Contact" field highlights red as required -
    Then "Email Template" field highlights red as required -
    #Step 12
    Then Remove "Tom Email Carrier Two" from "Tender Contact" Field -
#    Then Click on "Tender Contact" Field info -
    Then Verify "Tender Contact" Attribute "data-value" displaying as "" -
    Then Scroll into Section "Email CC List" -
    Then Enter Label "Email CC List" Text as "Company Email" -
    Then Select on "Email Template" as value "Remove Carrier - LEX2" -
    Then Enter Label "Charge" Text as "5" -
    Then Click on button "Remove Carrier" -
    #Expected g
    Then Verify Label "Vendor Service" is Required and displaying on Page -
    Then Verify Picklist "Quote Contact" is Required and displaying on Page -
    Then Verify Label "Tender Contact" is Required and displaying on Page -

    #Step 13
    Then Within the Legend select "Send Email" as "No" -

    #Expected h
    Then Verify Text not displaying as "Send Notice of Removal" -

    #Step 14
    Then Within the Legend select "Removal Charge" as "No" -

    #Step 15
    Then Click on button "Remove Carrier" -
    #Expected i
    Then Verify Message displaying as "Carrier removed from load."
    #Step 16
    Then Go to "Details" Tab
    #Expected j
    Then Verify Details "Carrier Sales Rep" displaying as ""

    #Step 17
    Then Go to "Freight Quote Assistant" Tab
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1000"
    Then "Assign" Carrier
    Then Set Carrier Quote value on to "Carrier_Quote"
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 18
    Then Go to "Summary" Tab
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Potential Fraud"
    Then Update details
      |Potential Fraud|
      |True |
    Then Click on "Save" button
    Then Wait for "4" Seconds
    Then Scroll into Section "Tracking Information"
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
       |Potential Fraud|
       |true |
    Then Refresh current Page

    #Step 19
    Then Click on Native "Remove Carrier" icon
    Then Verify Modal Heading Text displaying as "Email Carrier Two" -
    Then Within the Legend select "Removal Charge" as "Yes" -
    Then Update details -
     |Removal Reason |Removal Comments|Charge|Accessorial     |Vendor Service                        |Quote Contact|
      |Load Not Ready|ABC123/*-+^&()  |120   |Holiday Delivery|Email Carrier Two - Vendor - Truckload|Tom Email Carrier Two|
    Then Wait for "2" Seconds
    Then Within the Legend select "Send Email" as "Yes" -
    Then Update details -
      |Email CC List |Attach Rate Confirmation|
      |Company Email |true                    |

    #Step 20
    Then Click on button "Remove Carrier" -
    #Expected k
    Then Verify Message displaying with "Carrier removed from load."
    Then Verify Message displaying with "Removal charge added."
    Then Verify Message displaying with "Email sent."
    #Step 21
    Then Go to "Details" Tab
    #Expected l
    Then Verify Details "Load Status" displaying as "Unassigned"
    #Step 22
    Then Scroll into Section "Assigned Carrier Information"
     #Expected m
    Then Verify Details "Carrier" displaying as ""
    #Step 23
    Then Scroll into Section "Tracking Information"
    Then Wait for "2" Seconds
    #Expected n
    Then Verify Label Checkbox
      |Potential Fraud|
      |false |
    Then Refresh current Page
    #Step 24
    Then Go to "Quotes/Invoices" Tab
    Then Open "Carrier Quotes" using value from "Carrier_Quote" on QuoteInvoice Tab
    Then Go to "Details" Tab on Next to "Pricing" Tab
    #Expected o
    Then Verify Label Checkbox
         |Accepted|
         |false   |
    Then Scroll into Section with Title "Pricing Summary"
    Then Verify details for
        |Removal Reason|Removal Comments|Removal Charge|
        |Load Not Ready|ABC123/*-+^&()  |120.00        |
    Then Scroll into Section with Title "General Information"
    Then Navigate Back & Refresh
    #Step 25
    Then Go to "Quotes/Invoices" Tab
    Then Open "Vendor Invoices" from QuoteInvoice Tab with Vendor Price "120.00"
    #Expected p
    Then Verify details for
      |Accessorial Charges|
      |USD 120.00|
    Then Go to "Related" Tab on Next to "Details" Tab
    Then Verify Text displaying as "Holiday Delivery"
    Then Navigate Back & Refresh
    #Step 26 & Expected Q
    Then Wait for "120" Seconds
    Then Verify Carrier Removal Notification Mail having "Valid" attached pdf
    Then Verify Carrier Removal Notification Mail having CC as "Company Email"
    Then Verify Carrier Removal Notification Email Template

    #Step 27 & 28
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds
    Then "New" Carrier
    Then Enter Carrier Service as "Email Carrier Two - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Go to "Summary" Tab
    #Step 29
    Then Click on Native "Remove Carrier" icon
    Then Verify Modal Heading Text displaying as "Email Carrier Two" -
    Then Within the Legend select "Removal Charge" as "Yes" -
    Then Update details -
      |Charge|Accessorial            |Vendor Service                        |Quote Contact|
      |100   |Vehicle Ordered Not Used|Email Carrier Two - Vendor - Truckload|Tom Email Carrier Two|
    Then Within the Legend select "Send Email" as "Yes" -
    #Step 30
    Then Click on button "Remove Carrier" -
    Then Verify Message displaying as "Carrier removed from load."
    #Step 31 & Expected r
    Then Wait for "150" Seconds
    Then Verify Carrier Removal Notification Mail having "No" attached pdf


