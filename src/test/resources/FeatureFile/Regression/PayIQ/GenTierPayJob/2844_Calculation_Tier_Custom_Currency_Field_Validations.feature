Feature: 2844 - Calculation Tier - Custom Currency Field Validations


  @API @Regression @PayIQ  @WEB @SingleCurrency @2844 @GenTierPayJob
  Scenario: 2844 - Calculation Tier - Custom Currency Field Validations

    When Login into Salesforce

    #step 1
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

    #Step 2
    Then Switch to Frame by Title "Global Value Set ~ Salesforce - Enterprise Edition" -
    Then Scroll into Section "Values" -
    Then Capture the current URL for "Custom_Currency_Page1"
    Then Click on button with Title "New Values" -
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "Add Picklist Values: Custom Currency Fields ~ Salesforce - Enterprise Edition" -
    Then Update details -
         |Add the new picklist values to all Record Types that use this Global Value Set.|
         |True                                                                           |
    Then Wait for "1" Seconds
    Then Enter "rtms__Cargo_Value__c" with Id "p1" -
    Then Click on button with Title "Save" -
    Then Wait for "3" Seconds

    Then Switch to Frame by Title "Global Value Set ~ Salesforce - Enterprise Edition" -
    Then Scroll into Section "Values" -
    Then Capture the current URL for "Custom_Currency_Page2"
    Then Click on button with Title "New Values" -
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "Add Picklist Values: Custom Currency Fields ~ Salesforce - Enterprise Edition" -
    Then Enter "rtms__Unit_Price__c" with Id "p1" -
    Then Click on button with Title "Save" -
    Then Wait for "3" Seconds

    Then Switch to Frame by Title "Global Value Set ~ Salesforce - Enterprise Edition" -
    Then Scroll into Section "Values" -
    Then Capture the current URL for "Custom_Currency_Page3"
    Then Click on button with Title "New Values" -
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "Add Picklist Values: Custom Currency Fields ~ Salesforce - Enterprise Edition" -
    Then Enter "rtms__Total_Weight__c" with Id "p1" -
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

    Then Switch to Frame by Title "Global Value Set ~ Salesforce - Enterprise Edition" -
    Then Click on button with Title Contains "rtms__Unit_Price__c" -
    Then Wait for "4" Seconds
    Then Switch to Frame by Title "Picklist Edit: Custom Currency Fields ~ Salesforce - Enterprise Edition" -
    Then Update details -
      |Label|
      |Unit Price|
    Then Click on button with Title "Save" -
    Then Wait for "4" Seconds

    Then Switch to Frame by Title "Global Value Set ~ Salesforce - Enterprise Edition" -
    Then Click on button with Title Contains "rtms__Total_Weight__c" -
    Then Wait for "4" Seconds
    Then Switch to Frame by Title "Picklist Edit: Custom Currency Fields ~ Salesforce - Enterprise Edition" -
    Then Update details -
      |Label|
      |Total Weight|
    Then Click on button with Title "Save" -
    Then Wait for "2" Seconds

    #Step 4
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Custom Currency Fields" from List

    #Step 5
    Then Scroll Until Related List for "Calculation Tiers"
    Then Wait for "2" Seconds
    Then Click on "New" button on "Calculation Tiers" section

    #Step 6 and expected result a&b
    Then Update details
      |Criteria  |
      |Load Custom Amount|
    Then Move hover on Tooltip for "Criteria Custom Currency Field"
    Then Verify Tooltip message are displaying as "Picklist of Load level currency fields that can be used for the \"Custom Pay Amount\" Criteria calculation.  The field must be a currency field."
    Then Update details
      |Criteria Custom Currency Field  |From (>)|Calculation Method           |
      |Unit Price                      |0       |Percent of Load Custom Amount|
    Then Move hover on Tooltip for "Calculation Custom Currency Field"
    Then Verify Tooltip message are displaying as "Picklist of Load level currency fields that can be used for the \"Percentage of Custom Pay Amount\" Calculation Method.  The field must be a currency field."
    Then Update details
    |Calculation Custom Currency Field|
    |Unit Price                       |
    Then Click on button with Title "Save"
    Then Wait for "4" Seconds


    #Step 7 and expected result c
   Then Verify Normalized Text displaying as "rtms__Unit_Price__c does not exist as a field on Load, please check your entry in the \"Custom Currency Fields\" Picklist Value Set in setup."

    #Step 8 and expected result d
    Then Verify Normalized Text displaying as "rtms__Unit_Price__c does not exist as a field on Load, please check your entry in the \"Custom Currency Fields\" Picklist Value Set in setup."

    #Step 9
    Then Update details
      |Criteria Custom Currency Field  |Calculation Custom Currency Field|
      |Total Weight                      | Total Weight                      |
    Then Click on button with Title "Save"
    Then Wait for "4" Seconds

     #Step 10 and expected result e
    Then Verify Normalized Text displaying as "rtms__Total_Weight__c is not a currency field on Load, please check your entry in the \"Custom Currency Fields\" Picklist Value Set in setup."

    #Step 11 and expected result f
    Then Verify Normalized Text displaying as "rtms__Total_Weight__c is not a currency field on Load, please check your entry in the \"Custom Currency Fields\" Picklist Value Set in setup."

    #Step 12 and expected result g
    Then Update details
      |Calculation Custom Currency Field|Criteria Custom Currency Field|Percent|
      |Cargo Value                       |Cargo Value                   |2     |
    Then Click on button with Title "Save"
    Then Wait for "4" Seconds
    Then Verify Message displaying as "Calculation Tier-"

    #Step 13 and expected result h
    Then Scroll Until Related List for "Calculation Tiers"
    Then Click on "Calculation Tier-" with "Criteria Description" as "Individual Load Custom Amount (Cargo Value)"
    Then Scroll into Section "Tier Range/Target"
    Then Verify Details
      | Criteria         | From (>)| Criteria Custom Currency Field|
      |Load Custom Amount| 0.00   | Cargo Value               |
    Then Scroll into Section "Tier Calculation Settings"
    Then Verify Details
      |Calculation Method            | Calculation Custom Currency Field|Percent|
      |Percent of Load Custom Amount | Cargo Value |2.00%|
    Then Set Key "Calculation_Tier_SFID_1" page Record Id with "rtms9__Calculation_Tier__c"
