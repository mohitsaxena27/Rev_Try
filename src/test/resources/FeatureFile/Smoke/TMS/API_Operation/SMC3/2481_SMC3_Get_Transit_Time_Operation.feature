Feature: 2481 - SMC3 API- Get Transit Time Operation
  Background: Pre- Test
    Then Delete Field with Title "SMC3GetAvailableTariffsOperation"
    Then Delete Field with Title "SMC3GetTerminalsOperation"
    Then Delete Field with Title "SMC3GetTransitTimeOperation"
    Then Delete Field with Title "SMC3QuoteOperation"

  @API @Regression @TMS @Smoke @API_Operation @API @WEB @SingleCurrency @2481 @SMC3 @Debugging
  Scenario: 2481 - SMC3 API- Get Transit Time Operation

    When Login into Salesforce
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Enable Packet Replay |
      | True                 |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 2
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "AAA Cooper Transportation" from List
    Then Wait for "2" Seconds
    Then Click on "Carrier Service" Link Text "AAA Cooper Transportation - SMC3" on Page
    Then Wait for "2" Seconds
    #Step 3
    Then Set Key "{Carrier_Service}" page Record Id with "rtms__CarrierService__c"

    #Step 4 & 5
    Then Get "2482_SMC3QuoteOperation.txt" files and update below Attributes
      |{shipmentId}                  |
      |SysData=>{Carrier_Service}        |
    Then Save it with FileName "SMC3QuoteOperation.txt"

    #Step 6, 7 & 8
    Given Upload File "SMC3GetAvailableTariffsOperation.txt" with Title "SMC3GetAvailableTariffsOperation"
    Given Upload File "SMC3GetTerminalsOperation.txt" with Title "SMC3GetTerminalsOperation"
    Given Upload File "SMC3GetTransitTimeOperation- Origin DIRECT.Destination INTERLINE.txt" with Title "SMC3GetTransitTimeOperation"
    Given Upload File "U_SMC3QuoteOperation.txt" with Title "SMC3QuoteOperation"

    #Step 9
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer           | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | SMC3 Customer | LTL  | Dry Van 53     | Y             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA             | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Boston Beans     | NA            | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Material    | 2000   | NA           | 6        | Pallets        | 45     | 45    | 45     | NA             | 70         |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 2         | Stop 1 | Stop 2   | Material    | 1234   | NA           | 2        | Pallets        | 45     | 45    | 45     | NA             | 125         |

    Then Save Load With All details

    #Step10
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "10" Seconds
    ##Expected Result a
    And Verify Carrier Service displaying as "AAA Cooper Transportation - SMC3"

    #Step 11
    Then Click on "Carrier Quote" header link under "Carrier Quotes" tab

     #Step 12 & Expected Result b
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section with Title "Service Information"
    Then Verify Details
         |Estimated Transit Time (Days)|Estimated Pickup Date|Direct/Interline|Estimated Delivery Date|
         |3                            |11/14/2022           |Interline       |11/17/2022             |

    Then Scroll into Section with Title "Terminal Information"
    Then Verify Details
         |Origin Terminal Code|Origin Movement Type|Destination Terminal Code|Destination Movement Type|
         |DSP                 |Direct              |0043                     |Interline|


