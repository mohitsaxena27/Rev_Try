Feature: 541 - Project44 LTL API- Quote Operation

  Background: Pre- Test
    Then Delete Field with Title "Project44QuoteOperation2"

  @API @Regression @TMS @Smoke @API @WEB @API_Operation @MultiCurrency @541 @Project44 @Debugging
  Scenario: 541 - Project44 LTL API- Quote Operation
    When Login into Salesforce
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | True            | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step2, Step3 & Step4
    Given Upload File "Project44QuoteOperation2-541-MultiCurrency.txt" with Title "Project44QuoteOperation2"

    #Step5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Project44 Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 6500   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |

    Then Save Load With All details

    #Step 6
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on Label "Carrier Quote Preferred Currency"
    Then Update details
      |Carrier Quote Preferred Currency|
      |CAD     |
    Then Click on "Save" button on Details Page
    Then Wait for "1" Seconds
    Then Scroll into Section "Load Summary"
    Then Verify Details
      |Carrier Quote Preferred Currency|
      |CAD     |

    #Step7
    Then Go to "Freight Quote Assistant" Tab
    And "Capture" and Close all the Toast messages from Bottom
    #Expected a
    Then Verify Quotes returned

   #Step8
    #Expected b
    And Update and verify payload for "query" with "TC541_RequestBody_Expected.json"
      |No Update Required|
      ||
    Then Wait for "2" Seconds

#     Step 9 & Expected c
    Then Click on View Quotes
    Then Verify View Quotes for
      | Carrier_Service            | Carrier Total              | Estimated_Transit_Time | Accepted | Tender_Hold |
      | Southeastern Freight - P44 | CAD 814.72 (USD 608.00)     | 5                      | false    | false       |
      | XPO Logistics - P44        | CAD 944.34 (USD 704.73)     | 1                      | false    | false       |
      | YRC - P44                  | CAD 1,738.48 (USD 1,297.37) | 2                      | false    | false       |
    #Step 10
    Then Select "Southeastern Freight - P44" With Carrier Total as "608.00" from View Quotes
    Then Wait for "2" Seconds
    Then Click on "Carrier Quote" header link under "Carrier Quotes" tab

    #Step 11 & Expected Result d
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section with Title "General Information"
    Then Verify details with Text
      | Messages                       |
      | LGPU: ACCEPTED                 |
    Then Verify details with Text
      | Messages                       |
      | LGDEL: ACCEPTED                |
    Then Scroll into Section with Title "Pricing Summary"
    Then Verify details for
      | Freight Charges            | Discount                     | Discount Percent | Net Freight Charges     | Fuel Surcharge        | Accessorial Charges    | Carrier Total |
      | CAD 2,030.40 (USD 1,515.22) | CAD 1,583.71 (USD 1,181.87) | 78.00%            | CAD 446.69 (USD 333.35)| CAD 94.03 (USD 70.17) | CAD 274.00 (USD 204.48)| CAD 814.72 (USD 608.00)    |

    Then Scroll into Section with Title "Service Information"
    Then Verify details for
      | Service Class | Direct/Interline | Estimated Transit Time (Days) |
      | Standard Rate | Interline           | 5                             |
    Then Scroll into Section with Title "Contract Information"
    Then Verify details for
      | Carrier Quote Reference |
      | SEFL:CXHGDC2ED      |

   #Step12
    Then Click on "LIFTGATE PICKUP" link under "Related" tab
    Then Scroll into Section with Title "General Information"

    #Expected e
    Then Verify details for
      | Accessorial                    | Charge                 | Code  | Unit       | Quantity | Name            |
      | Lift Gate Pick Up               | CAD 137.00 (USD 102.24)| LGPU | Fixed Cost | 1.00     | LIFTGATE PICKUP|
    Then Navigate Browser Back

    #Step13
    Then Click on "LIFTGATE DELIVERY" link under "Related" tab
    #Expected f
    Then Scroll into Section with Title "General Information"
    Then Verify details for
      | Accessorial                    | Charge                 | Code  | Unit       | Quantity | Name            |
      | Lift Gate Delivery             | CAD 137.00 (USD 102.24)| LGDEL | Fixed Cost | 1.00     | LIFTGATE DELIVERY|

     #Step14
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | False                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

     #Steps15
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Project44 Customer" from List
    Then Go to "Rates" Tab
    Then Scroll into Section "Customer Product and Pricing Information"
    Then Click on Edit icon on Label "Carrier API Login Group"
    Then Enter Label "Carrier API Login Group" Text as "HYBRID"
    Then Click on "Save" button
    Then Verify "Carrier API Login Group" having value of "HYBRID"
    
    #Steps16
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Global Default" from List
    Then Wait for "2" Seconds
    Then Go to "Rates" Tab
    Then Scroll into Section "Customer Product and Pricing Information"
    Then Click on Edit icon on Label "Carrier API Login Group"
    Then Enter Label "Carrier API Login Group" Text as "CustA"
    Then Click on "Save" button
    Then Verify "Carrier API Login Group" having value of "CustA"

    #Step17
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Project44 Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1500   | kg           | 2        | Kegs        | 1     | 3    | 3     | ft             | 50         |

    Then Save Load With All details

    #Step18
    Then Go to "Freight Quote Assistant" Tab
    #Exprected g
    And "Capture" and Close all the Toast messages from Bottom
    Then Verify Quotes returned
    And Update and verify payload for "CustA" with "TC541_2_RequestBody_Expected.json"
      |No Update Required|
      ||
    And Update and verify payload for "HYBRID" with "TC541_3_RequestBody_Expected.json"
      |No Update Required|
      ||
    #Step 20 and Expected Result h
    Then Verify Quotes returned




