Feature: 2845 - GenTierPayJob - Custom Currency Fields - Tier Calculation


  @API @Regression @PayIQ  @WEB @SingleCurrency @2845 @GenTierPayJob
  Scenario: 2845 - GenTierPayJob - Custom Currency Fields - Tier Calculation

    When Login into Salesforce

    # Precondition
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Custom Currency Fields" from List
    Then Click on Edit icon on Label "Status"
    Then Update details
         |Status|
         |Open|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
         |Status|
         |Open|
    Then Capture the current URL for "PayIQ_Program_1"

    #step 1 & 2
    Then Set Page url for "-setup.com/lightning/setup/Picklists/home" into "Picklist"
    Then Navigate to stored URL for "Picklist"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Picklist Value Sets ~ Salesforce - Enterprise Edition"
    Then Click on "C" with Text -
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Picklist Value Sets ~ Salesforce - Enterprise Edition"
    Then Scroll into Section "Custom Currency Fields" -
    Then Click on "Custom Currency Fields" with Text -
    Then Wait for "7" Seconds
    Then Switch to Frame by Title "Global Value Set ~ Salesforce - Enterprise Edition" -
    Then Scroll into Section "Values" -
    Then Capture the current URL for "Custom_Currency_Page"
    Then Click on button with Title "New Values" -
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "Add Picklist Values: Custom Currency Fields ~ Salesforce - Enterprise Edition" -
    Then Update details -
         |Add the new picklist values to all Record Types that use this Global Value Set.|
         |True                                                                           |
    Then Wait for "1" Seconds
    Then Enter "rtms__Cargo_Value__c" with Id "p1" -
    Then Click on button with Title "Save" -
    Then Wait for "4" Seconds
      #Step 3
    Then Switch to Frame by Title "Global Value Set ~ Salesforce - Enterprise Edition" -
    Then Click on button with Title Contains "rtms__Cargo_Value__c" -
    Then Wait for "4" Seconds
    Then Switch to Frame by Title "Picklist Edit: Custom Currency Fields ~ Salesforce - Enterprise Edition" -
    Then Update details -
         |Label|
         |Cargo Value|
    Then Click on button with Title "Save" -
    Then Wait for "4" Seconds
    Then Switch to Parent Frame

    #Step 4
    Then Navigate to stored URL for "PayIQ_Program_1"

    #Step 5
    Then Scroll Until Related List for "Calculation Tiers"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Calculation Tiers" section
    Then Update details
    |Criteria  |From (>)|Calculation Method           |Calculation Custom Currency Field|Percent|
    |Load Count|0   |Percent of Load Custom Amount|  Cargo Value                  |10     |

    Then Click on button with Title "Save"
    Then Wait for "4" Seconds
    Then Scroll Until Related List for "Calculation Tiers"
    Then Scroll down with "4" Times

    #Step 6
    Then Get "Calculation Tier-" Name with "Calculation Description" as "Percent of Load Custom Amount (Cargo Value)" and store in "Calculation_Tier_ID"


    #Step 7
    Then Open "Loads" from App Launcher
      #Step 8
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans        | Truckload | NA             | NA            | NA                |

    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date             | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0                         | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date          | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Pittsburgh Pirates  | 1                      | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Gold        | 5000   | NA           | NA       | NA             |
    Then Save Load With All details

    #Step 9
    Then Capture the current URL for "Load_1L"

    #Step 9a)
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)     |
      | Joe Pittsburgh Pirates   |
    Then Click on "SaveEdit" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Sales Lead (Contact) |
      | Joe Pittsburgh Pirates   |

    #Step 9b)
    Then Go to "Details" Tab
    Then Scroll into Section "Load Summary"
    Then Click on Edit icon on "Cargo Value"
    Then Update details
      | Cargo Value   |
      | 9999          |
    Then Click on button with Title "Save"
    Then Wait for "4" Seconds


    #Step 10)
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 11)
    Then Go to "Logs" Tab
    Then Update details
      | Load        |Type|
      | SysData=>1L |Math|
    Then Click on button "Refresh"
    Then Wait for "4" Seconds

    #Step 12) Expected result a)
    Then Verify Logs Contains as "[{Calculation_Tier_ID} Pay Amount] = [Calculation Custom Currency Field(Cargo Value)] x [Percent] = 9,999 x 10% = 999.9 USD"

    #Step 13)
    Then Navigate to stored URL for "Load_1L"

    #Step 14)
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Pittsburgh Pirates (Contact)" and "Calculation Tier" as "SysData=>Calculation_Tier_ID"
    Then Wait for "2" Seconds
    Then Verify Details
    |Participant Name|Pay Amount|Calculation Tier|PayIQ Program|
    |Joe Pittsburgh Pirates (Contact)|USD 999.90|SysData=>Calculation_Tier_ID|PayIQ Program Custom Currency Fields|

