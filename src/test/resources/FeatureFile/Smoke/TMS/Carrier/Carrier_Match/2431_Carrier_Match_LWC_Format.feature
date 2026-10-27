Feature: 2431 - Carrier Match LWC- Format

  @Regression @TMS  @WEB @SingleCurrency @Carrier @Headed @Carrier_Guest @2431
  Scenario: 2431 - Carrier Match LWC- Format

    When Login into Salesforce

   # Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Revenova HQ |Truckload | Dry Van 53'     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Bananas    |15000  |NA          |NA       |NA       |
    Then Save Load With All details

     #Step2
    Then Go to "Find Carriers" Tab
    Then Wait for "10" Seconds
    Then Scroll Until Related List for "Carrier Matches"

    #step 3 and expected a
    Then Verify Icon "standard:buyer_group" is displaying with background color "Green"
    Then Verify Text displaying as "Carrier Quotes"
    Then Verify button is present with "Accept"
    Then Verify button is present with "Tender"
    Then Verify button is present with "Assign"
    Then Verify Title displaying as "Carrier Service"
    Then Verify Title displaying as "Vendor"
    Then Verify Title displaying as "Mode"
    Then Verify Title displaying as "Book It"
    Then Verify Title displaying as "Carrier Total"
    Then Verify Title displaying as "Priority"
    Then Verify Title displaying as "Auto"
    Then Verify Title displaying as "Tender Status"
    Then Verify Title displaying as "Tender Sent Date"

    #Step 4 and expected result b
    Then Verify Icon "standard:task" is displaying with background color "Green"
    Then Verify Text displaying as "Carrier Matches"
    Then Verify button is present with "Log Call"
    Then Verify button is present with "Get Quotes"
    Then Verify button is present with "Checked Rows Displayed"
    Then Verify button is present with "Capacity Filter is Off"
    Then Verify button is present with "Filter Panel is Visible"
    Then Verify button is present with "Refresh"
    Then Verify details for all Enabled fields
    |Domicile (Origin)|Domicile (Destination)|Delivering (Origin)|Posted (Origin)|Mi/Km|Posting Age|
    |100              |100                   |100                |100            |mi   |24 hr      |

  #Step 5 and expected result c
    Then Verify Text displaying as "In Network"
    Then Verify Text displaying as "Select Item 1"
    Then Verify Title displaying as "Review Status"
    Then Verify Title displaying as "Request Status"
    Then Verify Title displaying as "Carrier"
    Then Verify Title displaying as "MC Number"
    Then Verify Title displaying as "Domicile"
    Then Verify Title displaying as "Contact"
    Then Verify Title displaying as "Phone"
    Then Verify Title displaying as "Rating"
    Then Verify Title displaying as "Delivering"
    Then Verify Title displaying as "Postings"

  #Step 6 and expected result d
    Then Verify Text displaying as "Out of Network"
    Then Verify button is present with "Review"
    Then Verify Title displaying as "Source"
    Then Verify Title displaying as "Carrier"
    Then Verify Title displaying as "Domicile"
    Then Verify Title displaying as "MC Number"
#    Then Verify Title displaying as "DOT Number"
    Then Verify Title displaying as "Contact"
    Then Verify Title displaying as "Phone"
    Then Verify Title displaying as "Email"
    Then Verify Title displaying as "Postings"

  #Step 7 and expected result e
    Then Verify Text displaying as "Preferred Carrier Services"
    Then Verify Title displaying as "Carrier Service"
    Then Verify Title displaying as "Request Status"
    Then Verify Title displaying as "Contact"
    Then Verify Title displaying as "Source"
    Then Verify Title displaying as "Phone"

    #Step 8 and expected result f
    Then Verify Icon "custom:custom98" is displaying with background color "Earth Yellow"
    Then Verify Title displaying as "Capacity"

     #Step 9 and expected result g
    Then Verify Text displaying as "Loads Delivering"
    Then Verify Title displaying as "Load Number"
    Then Verify Title displaying as "Carrier"
    Then Verify Title displaying as "Customer"
    Then Verify Title displaying as "Contact"
    Then Verify Title displaying as "Phone"
    Then Verify Title displaying as "Email"
    Then Verify Title displaying as "Mode"
    Then Verify Title displaying as "Equipment"
    Then Verify Title displaying as "Origin"
    Then Verify Title displaying as "Expected Ship"
    Then Verify Title displaying as "Destination"
    Then Verify Title displaying as "Expected Delivery"

     #Step 10 and expected result h
    Then Verify Text displaying as "Truck Postings"
    Then Verify Title displaying as "Posting"
    Then Verify Title displaying as "Carrier"
    Then Verify Title displaying as "Contact"
    Then Verify Title displaying as "Phone"
    Then Verify Title displaying as "Email"
    Then Verify Title displaying as "Equipment"
    Then Verify Title displaying as "Qty"
    Then Verify Title displaying as "Available"
    Then Verify Title displaying as "Origin"
    Then Verify Title displaying as "Range"
    Then Verify Title displaying as "Destination"
    Then Verify Title displaying as "Range"
    Then Verify Title displaying as "Age (min)"

     #Step 11 and expected result i
    Then Click on button with Title "Filter Panel is Visible"
    Then Verify Title displaying as "Filters"
    Then Verify Title displaying as "Refresh"
    Then Verify Title displaying as "Hide Filters"
    Then Verify details for all Enabled fields
    |Mode     |Equipment Type|Cargo Insurance|Cargo Carried|Request Status|
    |Truckload             |Any                   |           |Any            |All  |
    Then Verify Text displaying as "Other Carrier Capabilities"


    Then Verify Banner details For Checkbox
      |Bonded (Canada)|Bonded (US)|CARB-Truck Compliant (California)|CARB-TRU Compliant (California)|C-TPAT Certified (US)|FAST Certified (US)|SmartWay Certified (US)|Tanker Endorsed|TDG Certified (Canada)|TSA Certification|TWIC Certification|
    |False               |False |False                            |False                          |False                |False              |False                  |False          |False                 |False            |False             |

    Then Verify Text displaying as "Rating"
    Then Verify Banner details For Checkbox
      |A                   |B     |C                                |D                                |F|
      |False               |False |False                            |False                          |False                |

    Then Verify Text displaying as "Carrier Review Status"
    Then Verify Banner details For Checkbox
      |Incomplete Application                   |Pending    |Approved                                |Rejected                              |Updated (FMCSA)|
      |False               |False |True                            |False                          |False                |

    Then Verify Text displaying as "Carrier Name"
    Then Verify Title displaying as "Filters"
    Then Verify Title displaying as "Refresh"
    Then Verify Title displaying as "Hide Filters"



















