Feature: 2447 - Banyan API- Tender Operation2 (ImportForBook)

  Background: Pre- Test
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled | Enable Packet Replay |
      | false           | false                |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2447 @BanyanAPI @Debugging
  Scenario: 2447 - Banyan API- Tender Operation2 (ImportForBook)
    #Step1
    Then Set "Org_id" with "EnvData=>Org_Id"
    #Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "SMC3 Customer" from List
    Then Go to "Rates" Tab
    Then Click on Edit icon on Label "Carrier API Login Group"
    Then Update details
      |Carrier API Login Group|
      |SMC32447test         |
    Then Click on "Save" button on Details Page
    Then Verify "Carrier API Login Group" having value of "SMC32447test"
    Then Capture the current URL for "TP_Link"

    #Step3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Project44" in the "Search Credentials..." search box
    Then Select the "Project44" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    Then Search text "SMC3 EVA" in the "Search Credentials..." search box
    Then Select the "SMC3 EVA" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds

    #Step4
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1200   | NA           | 2        | Pallets        | 45     | 42    | 48     | in             | 77.5       |

    Then Save Load With All details

    #Step5
    Then Go to "Freight Quote Assistant" Tab
    Then Click on View Quotes
    Then Select "Estes Express - SMC3" from View Quotes
    Then Wait for "3" Seconds
    Then Get "Carrier Service" and store in "Carrier_Service"
    Then Set Carrier Quote value on to "Carrier_Quote_Number"

    #Step6
    Then Scroll down with "2" Times
    Then Click on Rate Entry within "Pricing Notes"

    #Step7 & 8
    Then Wait for "6" Seconds
    Then Capture the current URL for "BeforeClone"
    Then Click on Native "Clone" button
    Then Wait for url Change from "BeforeClone"
    Then Wait for "5" Seconds
    Then Scroll into Section "General Information"
    Then Update details
      | Rate Type   | Accessorial                       | Auto-Apply |
      | Accessorial | Unspecified Limited Access Pickup | false      |
    Then Scroll into Section "Base Rate Calculation"
    Then Update details
      | Rate Method  | Rate |
      | Fixed Amount | 75   |
    Then Wait for "1" Seconds
    And Click on Native "Save" button
    Then Capture the current URL for "Cloned_Rate_Entry"
    Then Set Key "Rate_Entry_1" page Record Id with "rtms__RateEntry__c"
    #Step9
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    #Step10
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer      | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 2L       | SMC3 Customer | LTL  | Dry Van 53     | Y             | Y                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    And Update details
      | Unspecified Limited Access Pickup |
      | true                              |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 1200   | NA           | 2        | Pallets        | 45     | 42    | 48     | in             | 77.5       |

    Then Save Load With All details
    Then Capture the current URL for "Load_details"
    #Step11
    Then Go to "Details" Tab on Next to "Shipment" Tab
    Then Scroll into Section "Load Summary"
    Then Wait for "2" Seconds
    Then Get Details
      | Distance (Miles) |
      |                  |
    Then Wait for "2" Seconds

    #Step12
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom

    #Step13
    Then Click on View Quotes
    Then Wait for "1" Seconds
    Then Select "SysData=>Carrier_Service" from View Quotes
    Then Set Carrier Quote value on to "Carrier_Quote_Number"
    Then Wait for "2" Seconds
    #Step14
    
    Then Click on "SysData=>Carrier_Service" link
    Then Scroll into Section "Carrier Information"
    Then Click on link for label "Transportation Profile"
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Get Details
      | SCAC |
      |      |
    #Step15
    Then Open Load with "2L_LoadURL"
    Then Go to "Freight Quote Assistant" Tab
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Click on View Quotes
    Then Select "SysData=>Carrier_Service" from View Quotes
    Then Scroll into Section "Pricing Summary"
    Then Get Carrier "Net Freight Charges"
    Then Get Carrier "Quote Total"

    #Step16
    Then Update details
      | Carrier Quote Reference |
      | 12345                   |
    Then "Save" Carrier

    #Step17
    Then "Tender" Carrier
    #expected Result a
    And "Capture" and Close all the Toast messages from Bottom

    Then Get Attribute "AuthenticationData.ClientRefNum" store into "Client_Ref_Num" from "ImportForBook" "Request"
    Then Verify Assertion for "Client_Ref_Num" contains "SMC32447test"
    And Set "Carrier_Name" from stored value "Carrier_Service" with replace of " - SMC3" with ""
    And Set "Distance_Miles" from stored value "Distance (Miles)" with replace of "." with ""
    And Set "Net_Freight_Charges" from stored value "Net Freight Charges" with replace of "USD " with ""
    And Set "Quote_Total" from stored value "Quote Total" with replace of "USD " with ""
    And Update and verify payload for "ImportForBook" with "TC2447_RequestBody_Expected.json"
      | Carrier Name          | SCAC_value    | Net Freight Charges          | Quote Total          | Distance (Miles)        |
      | SysData=>Carrier_Name | SysData=>SCAC | SysData=>Net_Freight_Charges | SysData=>Quote_Total | SysData=>Distance_Miles |

    #step 18 & 19
   Then Navigate to stored URL for "TP_Link"
    Then Go to "Rates" Tab
    Then Click on Edit icon on Label "Carrier API Login Group"
    Then Wait for "1" Seconds
    Then Enter Label "Carrier API Login Group" Text as ""
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify "Carrier API Login Group" having value of ""

    #step 20
    Then Navigate to stored URL for "Load_details"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    #Step 21
    Then "Tender" Carrier
     #expected Result b
    And "Capture" and Close all the Toast messages from Bottom
    Then Get Attribute "AuthenticationData.ClientRefNum" store into "Client_Ref_Num" from "ImportForBook" "Request"
    Then Verify Assertion for "Client_Ref_Num" contains "SysData=>Org_id"

    #22 & 23
    Then Go to "Details" Tab
    Then Scroll into Section "Customer Order Information"
    Then Click on Edit icon on Label "Customer"
    Then Wait for "2" Seconds
    Then Update details
      | Customer |Customer Bill To|
      |          |                |
    Then Click on "Save" button
    Then Wait for "6" Seconds
    Then Scroll Up with "30" Times

    #24
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    #Step 25
    Then "Tender" Carrier
     #expected Result c
    And "Capture" and Close all the Toast messages from Bottom
    Then Get Attribute "AuthenticationData.ClientRefNum" store into "Client_Ref_Num" from "ImportForBook" "Request"
    Then Verify Assertion for "Client_Ref_Num" contains "SysData=>Org_id"