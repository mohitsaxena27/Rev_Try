Feature: 398 - Carrier Quote List LWC- Functionality


  @Regression  @SingleCurrency @Carrier @Headed @Carrier_Quotes @398
  Scenario: 398 - Carrier Quote List LWC- Functionality

    When Login into Salesforce

   # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Rate Entries" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Rate Entry" -
    Then Switch to Parent Frame
    Then Update details
      | Transportation Profile | Mode | Lane     | Category | Rate Type | Expiration Date | Status   |
      | Boston Beans           | LTL  | US to US | Carrier  | Freight   | 1               | Accepted |
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service               | Priority | Auto-Tender |
      | Stored Rate Carrier One - LTL | 3        | False       |
    Then Scroll into Section "Base Rate Calculation"
    Then Update details
      | Rate Method  | Rate |
      | Fixed Amount | 1200 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    Then Verify and get Rate_Entry Number on kay "Rate_Entry1_Name"
    Then Capture the current URL for "Rate_Entry1_Link"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"

    Then Click on Native "Clone" button
    Then Wait for url Change from "Rate_Entry1_Link"
    Then Wait for "5" Seconds
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service                 | Priority | Auto-Tender |
      | Stored Rate Carrier One - LTL 2 | 2        | True       |
    Then Scroll into Section "Base Rate Calculation"
    Then Update details
      | Rate Method  | Rate |
      | Fixed Amount | 1200 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    Then Verify and get Rate_Entry Number on kay "Rate_Entry2_Name"
    Then Capture the current URL for "Rate_Entry2_Link"
    Then Set Key "Rate_Entry_2" page Record Id with "rtms__RateEntry__c"

    Then Click on Native "Clone" button
    Then Wait for url Change from "Rate_Entry2_Link"
    Then Wait for "5" Seconds
    Then Scroll into Section "Transportation Service Information"
    Then Update details
      | Carrier Service                 | Priority | Auto-Tender |
      | Stored Rate Carrier One - LTL 3 | 1       | False       |
    Then Scroll into Section "Base Rate Calculation"
    Then Update details
      | Rate Method  | Rate |
      | Fixed Amount | 1500 |
    Then Click on "Save" with Text
    Then Verify Message displaying as "Save was successful."

    Then Verify and get Rate_Entry Number on kay "Rate_Entry3_Name"
    Then Capture the current URL for "Rate_Entry3_Link"
    Then Set Key "Rate_Entry_3" page Record Id with "rtms__RateEntry__c"

    #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Carrier Liability Limits" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Carrier Liability Limit" -
    Then Switch to Parent Frame
    Then Update details
      | Carrier Service               |
      | Stored Rate Carrier One - LTL |
    Then Select "Country" as "US" from Dueling List -
    Then Scroll into Section "Covered Commodities"
    Then Update details
      | Commodity Condition |
      | New                 |
    Then Select "NMFC Class" as "50" from Dueling List -
    Then Scroll into Section "Coverage Amount"
    Then Update details
      | Rate | Maximum Liability |
      | 2    | 20,000            |
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds
    Then Get Details
    |Name|
    |    |
    Then Set "Liability_Name" with "SysData=>Name"
    Then Set Key "Liability" page Record Id with "rtms__CarrierLiabilityLimit__c"

    #Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_As_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 2            | NA                       | NA               | NA                   |
    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material       | 6500   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |
    Then Save Load With All details
    Then Capture the current URL for "Load_1"
    Then Wait for "5" Seconds

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Verify Message displaying as "3 Stored Rate Quote(s) created."
    Then Scroll into Section "Carrier Quotes (3)"
    #To locate and verify customer quote table correctly
    Then Click on button "Collapse Insurance Quote Section"

    #Expected a
    Then Verify "LightGray" Color with "White" Text of "Accept" Button is "Disabled"
    Then Verify "LightGray" Color with "White" Text of "Tender" Button is "Disabled"
    Then Verify "LightGray" Color with "White" Text of "Assign" Button is "Disabled"
    Then Verify "Carrier Quotes" Table Column "Markup/Margin" is "Not Present"
    Then Verify "Carrier Quotes" Table Column "Customer Quote Total" is "Not Present"
    Then Verify "Carrier Quotes" Table Column Order
      | Book It |
      | Carrier Liability Limit |
      | Carrier Total |

    Then Verify "Carrier Quotes" Table Details
      | Carrier Service                 | Carrier Liability Limit |
      | Stored Rate Carrier One - LTL   | New:USD 13000           |
      | Stored Rate Carrier One - LTL 2 |                         |
      | Stored Rate Carrier One - LTL 3 |                         |

    #Step 5
    Then Refresh current Page
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "3" Seconds
    Then Set Carrier Quote value on to "Carrier_Quote1"

    #Step 6
    Then Scroll into Section "Carrier Quotes (3)"
    Then Set "Icon1" with "Click to view " and "SysData=>Carrier_Quote1"

    #Expected b
    Then Hover over on "SysData=>Icon1" icon and verify icon text is "SysData=>Icon1"

    #Step 7
    Then Click on button with Title "SysData=>Icon1"
    Then Wait for "2" Seconds

    #Expected c
    Then Switch Window by index "1"
    Then Verify Text displaying as "SysData=>Carrier_Quote1"

    #Step 8
#    Then Go to "Details" Tab on Next to "Pricing" Tab
#    Then Click on Partial Link Text "L-" on Page
    Then Navigate to stored URL for "Load_1"
    Then Wait for "3" Seconds
#    Then Go to "Freight Quote Assistant" Tab
#    Then Click on View Quotes
#    Then Select "Stored Rate Carrier One - LTL 2" With Carrier Total as "USD 1,200.00" from View Quotes
#    Then Set Carrier Quote value on to "Carrier_Quote2"
#    Then Click on View Quotes
#    Then Select "Stored Rate Carrier One - LTL 3" With Carrier Total as "USD 1,500.00" from View Quotes
#    Then Set Carrier Quote value on to "Carrier_Quote3"
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Carrier Quotes" on QuoteInvoice Tab
    Then Click on link "Carrier Quotes"
    Then Set key "LTL" for Object "rtms__Carrier_Service__c" and Name "Stored Rate Carrier One - LTL"
    Then Set key "LTL2" for Object "rtms__Carrier_Service__c" and Name "Stored Rate Carrier One - LTL 2"
    Then Set key "LTL3" for Object "rtms__Carrier_Service__c" and Name "Stored Rate Carrier One - LTL 3"
    Then Get "Name" from "rtms__CarrierQuote__c" where "rtms__Carrier_Service__c" is "SysData=>LTL" and store into "Carrier_Quote1"
    Then Get "Name" from "rtms__CarrierQuote__c" where "rtms__Carrier_Service__c" is "SysData=>LTL2" and store into "Carrier_Quote2"
    Then Get "Name" from "rtms__CarrierQuote__c" where "rtms__Carrier_Service__c" is "SysData=>LTL3" and store into "Carrier_Quote3"
    Then Go to "Freight Quote Assistant" Tab
    Then Scroll into Section "Carrier Quotes (3)"
    Then Click on "Refresh Quotes" button at Carrier Quote List LWC
    Then Wait for "2" Seconds

    #Expected d & Step 9
    Then Verify Message displaying as "3 Stored Rate Quote(s) created."
    Then Refresh current Page
    Then Go to "Quotes/Invoices" Tab
    Then Scroll into "Carrier Quotes" on QuoteInvoice Tab
    Then Click on link "Carrier Quotes"
    Then Click on button with Title "Refresh"
    Then Wait for "3" Seconds
    Then Get "Name" from "rtms__CarrierQuote__c" where "rtms__Carrier_Service__c" is "SysData=>LTL" and store into "Carrier_New1"
    Then Get "Name" from "rtms__CarrierQuote__c" where "rtms__Carrier_Service__c" is "SysData=>LTL2" and store into "Carrier_New2"
    Then Get "Name" from "rtms__CarrierQuote__c" where "rtms__Carrier_Service__c" is "SysData=>LTL3" and store into "Carrier_New3"
#    Then Go to "Freight Quote Assistant" Tab
#    Then Click on View Quotes
#    Then Select "Stored Rate Carrier One - LTL" With Carrier Total as "USD 1,200.00" from View Quotes
#    Then Set Carrier Quote value on to "Carrier_New1"
    Then Verify "Carrier_New1" not equal to "SysData=>Carrier_Quote1"
#    Then Click on View Quotes
#    Then Select "Stored Rate Carrier One - LTL 2" With Carrier Total as "USD 1,200.00" from View Quotes
#    Then Set Carrier Quote value on to "Carrier_New2"
    Then Verify "Carrier_New2" not equal to "SysData=>Carrier_Quote2"
#    Then Click on View Quotes
#    Then Select "Stored Rate Carrier One - LTL 3" With Carrier Total as "USD 1,500.00" from View Quotes
#    Then Set Carrier Quote value on to "Carrier_New3"
    Then Verify "Carrier_New3" not equal to "SysData=>Carrier_Quote3"

    #Step 10
    Then Select radio button for value "Stored Rate Carrier One - LTL" in Carrier Quote List

    #Expected e
    Then Verify "SteelBlue" Color with "White" Text of "Accept" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Tender" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Assign" Button is "Enabled"

    #Step 11
    Then Click on "Accept" button at Carrier Quote List LWC

    #Expected f
    Then Set "Icon1" with "Accepted - Click to view " and "SysData=>Carrier_New1"
    Then Verify Message displaying as "Carrier Quote accepted."
    Then Verify Button with Title displaying as "SysData=>Icon1" -

    #Step 12 & Expected g
    Then Hover over on "SysData=>Icon1" icon and verify icon text is "SysData=>Icon1"

    #Step 13 & Expected h
    Then Click on "Tender" button at Carrier Quote List LWC
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Tender Email" -

    #Step 14 , 15  & Expected i
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds
    Then Scroll into Section "Carrier Quotes (3)"
    Then Store current date in format "MM/dd/yyyy" into "Date"
    Then Store current Time with timezone in format of "hh:mm a" on to "Current_Time"
    Then Set "DateTime" with "SysData=>Date" and ", " and "SysData=>Current_Time"
    Then Click on button "Collapse Insurance Quote Section"
    Then Verify "Carrier Quotes" Table Details
      | Carrier Service               | Tender Status|Tender Sent Date |
      | Stored Rate Carrier One - LTL | Sent         |SysData=>DateTime |

    #Step 16 & Expected j
    Then Click on "Assign" button at Carrier Quote List LWC
    Then Verify Message displaying with Text "Load was assigned to carrier."
    Then Verify "Carrier Quotes" Table Details
      | Carrier Service               | Tender Status |
      | Stored Rate Carrier One - LTL | Assigned      |

    #Step 17
    Then Click on button with Title "SysData=>Icon1"
    Then Wait for "2" Seconds
    Then Switch Window by index "2"
    Then Verify Text displaying as "SysData=>Carrier_New1"
    Then Go to "Details" Tab on Next to "Pricing" Tab

    #Expected k
    Then Verify Details
    |Tender Sent By|
    |User User     |
    Then Close Current Tab

    #Step 18
    #Switch to load page
    Then Switch to Parent Window

    #Step 19 & 20
    Then Execute Load "1L" Clone with count "1" and Customer Quote as "False" and Carrier Quote as "False"
    Then Open Last Load from Cloned Load
    Then Wait for "4" Seconds
    Then Capture the current URL for "Cloned_Load1"

    #Step 21
    Then Go to "Freight Quote Assistant" Tab

    #Step 22
    Then Scroll into Section "Carrier Quotes (3)"
    Then Click on button "Collapse Insurance Quote Section"
    Then Click on checkbox toggle "Auto-Tender Off"
    Then Wait for "3" Seconds

    #Expected l
    Then Verify "Carrier Quotes" Table Details In Order
      | Carrier Service                 |Carrier Total|
      | Stored Rate Carrier One - LTL 2 |USD 1,200.00|
      | Stored Rate Carrier One - LTL 3 |USD 1,500.00|
      | Stored Rate Carrier One - LTL   |USD 1,200.00|

    #Step 23
    Then Update details
      | Select Item 3 |
      | True          |
    Then Click on "Show menu" button at Carrier Quote List LWC and select "Add to Auto-Tender Queue" from Show More Dropdown

    #Expected m
    Then Verify "Carrier Quotes" Table Details In Order
      | Carrier Service                 | Carrier Total | Auto  | Tender Status |
      | Stored Rate Carrier One - LTL 2 | USD 1,200.00  | True  |               |
      | Stored Rate Carrier One - LTL   | USD 1,200.00  | True  | Queued        |
      | Stored Rate Carrier One - LTL 3 | USD 1,500.00  | False |               |

    #Step 24
    Then Update details
      | Select Item 2 |
      | True          |

    #Expected n
    Then Verify "LightGray" Color with "White" Text of "Accept" Button is "Disabled"
    Then Verify "LightGray" Color with "White" Text of "Tender" Button is "Disabled"
    Then Verify "LightGray" Color with "White" Text of "Assign" Button is "Disabled"

    #Step 25
    Then Click on "Show menu" button at Carrier Quote List LWC and select "Remove from Auto-Tender Queue" from Show More Dropdown
    Then Wait for "1" Seconds

    #Expected o
    Then Verify "Carrier Quotes" Table Details In Order
      | Carrier Service                 | Carrier Total | Auto  |
      | Stored Rate Carrier One - LTL 2 | USD 1,200.00  | True  |
      | Stored Rate Carrier One - LTL 3 | USD 1,500.00  | False |
      | Stored Rate Carrier One - LTL   | USD 1,200.00  | False |

    #Step 26
    Then Update details
      | Select Item 3 |
      | True          |

    #Expected p
    Then Verify "SteelBlue" Color with "White" Text of "Accept" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Tender" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Assign" Button is "Enabled"










