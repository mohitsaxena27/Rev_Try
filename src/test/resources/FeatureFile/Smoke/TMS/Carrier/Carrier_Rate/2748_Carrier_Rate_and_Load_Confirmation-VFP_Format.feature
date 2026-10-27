Feature: 2748 - Carrier Rate and Load Confirmation VFP- Format

  @Regression @TMS @WEB @SingleCurrency @Carrier @Carrier_Service @2748 @CarrierQuoteAccessorial
  Scenario: 2748 - Carrier Rate and Load Confirmation VFP- Format

    When Login into Salesforce
    Then Set "OrgEmail" with "EnvData=>EmailID"
    #Steps1
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | Y             | Y                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Update details
      | After Hours Pick Up |
      | True                |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 3             | NA                       | NA               | NA                   |
    Then Update details
      | Lift Gate Delivery |
      | True                |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 3P   | Account_Address | Chicago Pizza | 4             | NA                       | NA               | NA                   |

    Then Add More Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | Y       | 4D   | Same_as_Customer | NA    | 7             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 6500   | NA           | 2        | Pallets        | 45     | 45    | 45     | in             | 50         |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 3 | Stop 4   | Grapes      | 1500   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |

    Then Scroll into Section "Load Accessorials"
    And Update details
      | Protect From Freezing | Excess Value |
      | True                  | True         |
    Then Save Load With All details

    #Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then Wait for "2" Seconds
    Then Add "Load" "Carrier Quote Items" "Net Freight Charges" with Unit as "Per Handling Unit" Qty as "4" and Price "1000" with all details
    Then Wait for "2" Seconds
    Then Add Note for "Carrier Quote Items" "Net Freight Charges" as "More Testing 5678#$"
    Then Enter "Carrier Quote Items" "Fuel Surcharge" as "250"
    Then Wait for "2" Seconds
    Then Add Note for "Carrier Quote Items" "Fuel Surcharge" as "Testing 1234!@~"
    Then Enter "Carrier Quote Items" "After Hours Pick Up" as "100"
    Then Enter "Carrier Quote Items" "Lift Gate Delivery" as "100"
    Then Enter "Carrier Quote Items" "Excess Value" as "50"
    Then Enter "Carrier Quote Items" "Protect From Freezing" as "50"
    Then Wait for "2" Seconds
    Then Add Note for "Carrier Quote Items" "Protect From Freezing" as "More Testing 5678#$"
    Then Wait for "2" Seconds
    Then Scroll Up with "5" Times
    Then "Tender" Carrier
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Tender Email" -
    Then Scroll On Modal
    Then Scroll into Section "Preview Attachments"
    Then To open the preview attachments
    Then Wait for "4" Seconds

    #Expected a
    Then Get Pdf content from "Preview Attachments" with Subject "Tender Email"
    Then Verify Pdf contains "Carrier Rate and Load Confirmation"

    #Expected b
#    Then Validate PDF logo matching with "RevenovaTMS_Logo.png"

    #Expected c
    Then Verify Pdf contains "Revenova HQ"
    Then Verify Pdf contains "2333 Waukegan Rd."
    Then Verify Pdf contains "Bannockburn, IL 60015"
    Then Verify Pdf contains "User User"
    Then Verify Pdf contains "SysData=>OrgEmail"

    #Expected d
    Then Verify Pdf contains "SysData=>1L"

    #Expected e
    Then Verify Pdf contains "Email Carrier One"

    #Expected f
    Then Verify Pdf contains "Date: {Date=>0}"

    #Expected g
    Then Verify Pdf contains "Contact: Tess Email Carrier One, (p) 312-999-8888 (f)"
    Then Verify Pdf contains "312-222-4444"

    #Expected h
    Then Verify Pdf contains "Dry Van 53'"

    #Expected i
    Then Verify Pdf contains "Shipper Pickup (Stop 1)"
    Then Verify Pdf contains "Note - this is a Round Trip Load"
    Then Verify Pdf contains "Boston Beans"
    Then Verify Pdf contains "526 Beacon Street"
    Then Verify Pdf contains "Boston, MA US 02215"
    Then Verify Pdf contains "Expected Date: {Date=>0}"
    Then Verify Pdf contains "Shipping/Receiving Hours: 09:00-22:00"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Appointment Time:"
    Then Verify Pdf contains "Contact: Joe Boston Beans 312-999-7777"
    Then Verify Pdf contains "SysData=>OrgEmail"
    Then Verify Pdf contains "Pickup Instructions: Pickup Instructions"
    Then Verify Pdf contains "Shipper References:"

    #Expected j
    Then Verify Pdf contains "Shipment Information"

    #Expected k
    Then Verify Pdf contains "Handling Unit Package LTL Only"
    Then Verify Pdf contains "Qty Type Qty Type Weight HM (X) Commodity Description NMFC # NMFC Class"
    Then Verify Pdf contains "2 Pallets 6500 lbs Bananas 50"

    #Expected l
    Then Verify Pdf contains "Consignee Delivery (Stop 2)"
    Then Verify Pdf contains "Note: this Location will be both a Delivery and Pickup"
    Then Verify Pdf contains "Chicago Pizza"
    Then Verify Pdf contains "181 W. Madison St."
    Then Verify Pdf contains "Chicago, IL US 60602"
    Then Verify Pdf contains "Expected Date: {Date=>3}"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Shipping/Receiving Hours: 09:00-22:00"
    Then Verify Pdf contains "Appointment Time:"
    Then Verify Pdf contains "Contact: Joe Chicago Pizza 312-999-7777"
    Then Verify Pdf contains "SysData=>OrgEmail"
    Then Verify Pdf contains "Delivery Instructions: Delivery Instructions"
    Then Verify Pdf contains "Consignee References:"

    #Expected m
    Then Verify Pdf contains "Shipment Information"

    #Expected n
    Then Verify Pdf contains "Handling Unit Package LTL Only"
    Then Verify Pdf contains "Qty Type Qty Type Weight HM (X) Commodity Description NMFC # NMFC Class"
    Then Verify Pdf contains "2 Pallets 6500 lbs Bananas 50"

    #Expected o
    Then Verify Pdf contains "Shipper Pickup (Stop 3)"
    Then Verify Pdf contains "Note: this Location will be both a Delivery and Pickup"
    Then Verify Pdf contains "Chicago Pizza"
    Then Verify Pdf contains "181 W. Madison St."
    Then Verify Pdf contains "Chicago, IL US 60602"
    Then Verify Pdf contains "Expected Date: {Date=>4}"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Shipping/Receiving Hours: 09:00-22:00"
    Then Verify Pdf contains "Appointment Time:"
    Then Verify Pdf contains "Contact: Joe Chicago Pizza 312-999-7777"
    Then Verify Pdf contains "SysData=>OrgEmail"
    Then Verify Pdf contains "Pickup Instructions: Pickup Instructions"
    Then Verify Pdf contains "Shipper References:"
    Then Verify Pdf contains "Shipper References:"

    #Expected p
    Then Verify Pdf contains "Shipment Information"

    #Expected q
    Then Verify Pdf contains "Handling Unit Package LTL Only"
    Then Verify Pdf contains "Qty Type Qty Type Weight HM (X) Commodity Description NMFC # NMFC Class"
    Then Verify Pdf contains "2 Pallets 1500 lbs Grapes 50"

    #Expected r
    Then Verify Pdf contains "Consignee Delivery (Stop 4)"
    Then Verify Pdf contains "Note - this is a Round Trip Load"
    Then Verify Pdf contains "Note - this is a Round Trip Load"
    Then Verify Pdf contains "Boston Beans"
    Then Verify Pdf contains "526 Beacon Street"
    Then Verify Pdf contains "Boston, MA US 02215"
    Then Verify Pdf contains "Expected Date: {Date=>7}"
    Then Verify Pdf contains "Shipping/Receiving Hours: 09:00-22:00"
    Then Verify Pdf contains "Appointment Required: No"
    Then Verify Pdf contains "Appointment Time:"
    Then Verify Pdf contains "Contact: Joe Boston Beans 312-999-7777"
    Then Verify Pdf contains "SysData=>OrgEmail"
    Then Verify Pdf contains "Delivery Instructions: Delivery Instructions"
    Then Verify Pdf contains "Consignee References:"

    #Expected s
    Then Verify Pdf contains "Additional Services"
    Then Verify Pdf contains "Stop 1 After Hours Pick Up Stop 2 Lift Gate Delivery Excess Value Protect From Freezing"

    #Expected u
    Then Verify Pdf contains "Carrier Fees"

    #Expected v
    Then Verify Pdf contains "Description Cost"
    Then Verify Pdf contains "Net Freight Charges USD 4,000.00"
    Then Verify Pdf contains "Fuel Surcharge USD 250.00"
    Then Verify Pdf contains "Accessorial Charges USD 300.00"
    Then Verify Pdf contains "Total Cost USD 4,550.00"

    #Expected w
    Then Verify Pdf contains "Fee Details"

    #Expected x
    Then Verify Pdf contains "Item Description Unit Quantity Unit Price Total"
    Then Verify Pdf contains "Net Freight Charges Per Handling Unit 4.00 USD 1,000.00 USD 4,000.00"
    Then Verify Pdf contains "Fuel Surcharge Fixed Cost 1.00 USD 250.00 USD 250.00"
    Then Verify Pdf contains "After Hours Pick Up Fixed Cost 1.00 USD 100.00 USD 100.00"
    Then Verify Pdf contains "Lift Gate Delivery Fixed Cost 1.00 USD 100.00 USD 100.00"
    Then Verify Pdf contains "Excess Value Fixed Cost 1.00 USD 50.00 USD 50.00"
    Then Verify Pdf contains "Protect From Freezing Fixed Cost 1.00 USD 50.00 USD 50.00"
    Then Verify Pdf contains "Protect From Freezing Fixed Cost 1.00 USD 50.00 USD 50.00"

    #Expected y
    Then Verify Pdf contains "Net Freight Charges Notes: More Testing 5678#$"
    Then Verify Pdf contains "Fuel Surcharge Notes: Testing 1234!@~"
    Then Verify Pdf contains "Protect From Freezing Notes: More Testing 5678#$"
