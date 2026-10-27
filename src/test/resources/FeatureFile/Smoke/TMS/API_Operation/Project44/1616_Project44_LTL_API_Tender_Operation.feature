Feature: 1616 - Project44 LTL API- Tender Operation

  Background: Pre- Test
    Then Delete Field with Title "Project44QuoteOperation2"
    Then Delete Field with Title "Project44TenderOperation2"

  @API @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @1616 @Project44 @Debugging
  Scenario: 1616 - Project44 LTL API- Tender Operation

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
    Given Upload File "Project44QuoteOperation2-1616.txt" with Title "Project44QuoteOperation2"
    Given Upload File "Project44TenderOperation2- 1616.txt" with Title "Project44TenderOperation2"

  #Step5
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Project44 Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value        | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 6500   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |

    Then Save Load With All details

  #Step 6
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Wait for "2" Seconds
    Then Update details
      | Pickup/Delivery Number  | Instructions    |
      | 1616/*- QA Testing!@#$% | QA1616 ()++<>?" |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Collapse "Details" for "1" Load

  #Step 7
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Update details
      | Pickup/Delivery Number | Instructions |
      | 1616321                | QA1616delNUM |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."

  #Step8
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Verify Quotes returned
    Then Wait for "2" Seconds
    Then "Tender" Carrier
    And "Capture" and Close all the Toast messages from Bottom
    Then Set Key "companyName" with value "Company_Name" from Config File

    Then Get Attribute "shipmentIdentifiers[0].value" store into "BOLNum" from "dispatchedshipments" "Request"
    Then Get Attribute "shipmentIdentifiers[2].value" store into "ExternalID" from "dispatchedshipments" "Request"
  #Expected a
    And Update and verify payload for "dispatchedshipments" with "TC1616_RequestBody_Expected.json"
      | {pickupNote}                                   | {deliveryNote}               | {capacityProviderQuoteNumber} | BOL_Num         | External_ID         |
      | QA1616 ()++<>?\" - PU#:1616/*- QA Testing!@#$% | QA1616delNUM - Dlvy#:1616321 | CXHGDC2ED                     | SysData=>BOLNum | SysData=>ExternalID |

  #Step 9 & Expected b
    Then Verify Message "Load tendered successfully" displaying stored during enabled logging

    Then Refresh current Page

  #Step 10 & Expected c
    Then Go to "Details" Tab
    Then Scroll into Section "Team Assignments & Status"
    Then Verify Details
      | Load Status |
      | Assigned    |
    Then Scroll into Section "Shipment IDs"
    Then Verify Details
      | PRO Number |
      | 51222333   |
    Then Scroll into Section "Tracking IDs"
    Then Verify Details
      | Tracking Number |
      | 987654321       |
    Then Scroll into Section "Tracking Information"
    Then Verify Details
      | Carrier Tracking Status |
      | On                      |

  #Step 11 & Expected d
    Then Go to "Shipment" Tab
    Then Wait for "1" Seconds
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds

  #Expected Result e
    Then Verify details for
      | References                     |
      | Carrier Pickup Number: SAA9999 |

  #Step 12
    Then Click on Edit icon with Field Name "Instructions"
    Then Update details
      | Instructions |
      |              |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Collapse "Details" for "1" Load

  #Step 13
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Update details
      | Pickup/Delivery Number |
      |                        |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page

  #Step 14
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Update details
      | Carrier Quote Reference |
      | CXHGDC2ED               |

  #Step 15 & 16
    Then "Tender" Carrier
    And "Capture" and Close all the Toast messages from Bottom

  #Expected e
    And Update and verify payload for "dispatchedshipments" with "TC1616_RequestBody_Expected.json"
      | {companyName} | {pickupNote}                | {deliveryNote} | {capacityProviderQuoteNumber} | BOL_Num         | External_ID         |
      | Transactional | PU#:1616/*- QA Testing!@#$% | QA1616delNUM   | CXHGDC2ED                     | SysData=>BOLNum | SysData=>ExternalID |
    Then Refresh current Page

  #Step 17
    Then Go to "Shipment" Tab
    Then Wait for "1" Seconds
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Update details
      | Pickup/Delivery Number |
      |                        |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Collapse "Details" for "1" Load

  #Step 18
    Then Expand "Details" for "2" Load
    Then Wait for "1" Seconds
    Then Click on Edit icon with Field Name "Instructions"
    Then Update details
      | Instructions |
      |              |
    Then Click on "Save" Button with Type "submit"
    Then Verify Message displaying as "Save was successful."
    Then Refresh current Page

  #Step 19
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "5" Seconds
    Then "Tender" Carrier
    And "Capture" and Close all the Toast messages from Bottom

  #Expected f
    And Update and verify payload for "dispatchedshipments" with "TC1616_2_RequestBody_Expected.json"
      | BOL_Num         | External_ID         |
      | SysData=>BOLNum | SysData=>ExternalID |