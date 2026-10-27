Feature: 380 - Carrier Exclusions- Carrier Parameter with Global Stored Rate

  @Regression @Priority_1 @WEB @SingleCurrency @Carrier @Carrier_Exclusion @380
  Scenario: 380 - Carrier Exclusions- Carrier Parameter with Global Stored Rate

    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame

    #Step 2
    Then Update details
      | Transportation Profile | Mode | Lane     | Category | Rate Type                | Status   | Match Priority | Currency ISO Code |
      | Global Default         | LTL  | US to US | Carrier  | Freight+Fuel+Accessorial | Accepted | 280            | USD - U.S. Dollar |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service               | Rate Method  | Rate |
      | Stored Rate Carrier One - LTL | Fixed Amount | 2000 |

    #Step 3
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    #Step 4
    Then Verify and get Rate_Entry Number on kay "Rate_Entry_Name"
    Then Capture the current URL for "Rate_Entry_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

    #Step 5
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Boston Beans" from List
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Carrier Exclusions"
    Then Wait for "2" Seconds
    Then Click on link "Carrier Exclusions"
    Then Click on button "New"
    Then Wait for "2" Seconds

    #Step 6 & 7
    Then Update details
      | Transportation Profile | Carrier                 | Exclusion Type              |
      | Boston Beans           | Stored Rate Carrier One | Exclude Pickup and Delivery |
    Then Click on "SaveEdit" button
    Then Verify Message displaying as "was created."
    Then Wait for "2" Seconds
    Then Click on "Exclusion-" with Contains Text
    Then Wait for "3" Seconds
    Then Set Key "Carrier_Exclusion" page Record Id with "rtms__CarrierExclusion__c"

    #Step 8
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL  | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots     |  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed     | 1234   | NA           | NA       | NA             |


    #Step 9
    Then Save Load With All details
    Then Capture the current URL for "Load_1"
    Then Wait for "5" Seconds

    #Step 10 & expected a
    Then Go to "Freight Quote Assistant" Tab
     Then Wait for "8" Seconds
    Then Verify Text displaying as "New Carrier Quote"
    Then Verify "Carrier Service" having value of ""
    Then Verify "Rate Entry" Attribute "data-value" displaying as ""
    Then Verify Carrier "Net Freight Charges" displaying as "USD 0.00"
    Then Verify Carrier "Fuel Surcharge" displaying as ""
    Then Verify Carrier "Accessorial Charges" displaying as ""
    Then Verify Carrier "Quote Total" displaying as "USD 0.00"
    Then Verify Carrier Pricing Notes not displaying as "Rate Entry"

    #Step 11
    Then Open "Loads" from App Launcher

    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | Fargo Wood Chippers | LTL  | NA             | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Minnesota Vikings | 1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 1234   | NA           | NA       | NA             |


    #Step 12
    Then Save Load With All details
    Then Capture the current URL for "Load_2"
    Then Wait for "5" Seconds

    #Step 13 & expected b
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Verify "Carrier Service" Link value displaying as "Stored Rate Carrier One - LTL"
    Then Verify "Rate Entry" Attribute "data-value" displaying as "Rate Entry"
    Then Verify Carrier "Freight Charges" displaying as "USD 2,000.00"
    Then Verify Carrier "Discount" displaying as "USD 0.00"
    Then Verify Carrier "Net Freight Charges" displaying as "USD 2,000.00"
    Then Verify Carrier "Fuel Surcharge" displaying as ""
    Then Verify Carrier "Accessorial Charges" displaying as ""
    Then Verify Carrier "Quote Total" displaying as "USD 2,000.00"
    Then Verify Carrier Pricing Notes displaying as "Rate Entry"