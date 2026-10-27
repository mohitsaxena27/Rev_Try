Feature: 3080 Accufrate API Tender Operation

  @API @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @3080 @AccuFrate @Debugging
  Scenario: 3080 - Accufrate API Tender Operation
    #Step1
    When Login into Salesforce
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #step2 -Create a detailed entry LTL shipment
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | AccuFrate Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA             | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 6500   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 50         |

    Then Save Load With All details

    #step3 - Navigate to Freight Quote Assistant
    Then Go to "Freight Quote Assistant" Tab

    # Clear quote-generation logging banners
    And "Without Capture" and Close all the Toast messages from Bottom
    Then Wait for "3" Seconds
    Then Capture the attribute "value" for "Carrier Quote Reference"

    # step4 Select Tender
    Then Click on Native "Tender" icon
     # Capture and remove all logging banners
    And "Capture" and Close all the Toast messages from Bottom

    # step5 Expected result a - validate request XML
  Then Verify XML request for "PickupService.svc" with File "TC3080_RequestBody_Expected.xml"
  | {QuoteDetailId}                              | {CurrentDate+1} |
  | SysData=>Shipment Product Transaction Id     | 1               |

   #step6 Expected result b - response validation
    Then Verify Assertion for "PickupService.svc_Response_Body" contains "<a:BolID>"
    Then Verify Assertion for "PickupService.svc_Response_Body" contains "<a:PickUpNumber>"

    Then Get XML Attribute "//*[local-name()='BolID']" from "PickupService.svc" "Response" and store onto "BolID"
    Then Get XML Attribute "//*[local-name()='PickUpNumber']" from "PickupService.svc" "Response" and store onto "PickUpNumber"

    #step7 Navigate to summary tab and validate the PickUpNumber
    Then Go to "Shipment" Tab
    Then Wait for "1" Seconds
    Then Expand "Details" for "1" Load
    Then Wait for "1" Seconds
    Then Verify details for
      | References |
      | Carrier Pickup Number: SysData=>PickUpNumber |

   #step8 Navigate to details tab and validate the BOL ID
    Then Go to "Details" Tab
    Then Scroll into Section "Shipment IDs"
    Then Verify Details
      | Bill of Lading Number |
      | SysData=>BolID        |



