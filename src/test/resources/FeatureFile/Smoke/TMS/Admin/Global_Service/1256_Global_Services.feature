Feature: 1256 - API Credentials List LWC - Global Services

  @API @Regression @TMS @Smoke @WEB @Admin @SingleCurrency @1256
  Scenario: 1256 - API Credentials List LWC - Global Services

    When Login into Salesforce
    #Step1  Expected Result a
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Ensure the "Global Services" is displayed with count "45"

    #Step2 Expected Result b
    Then Search text "Project" in the "Search Credentials..." search box
    Then verify the search result is correct for searched text "Project"

    #Step3 Expected Result c
    Then Select the "Project44" record from the lookup field results
    Then Verify "Search Credentials..." search box is ""

    #Step4 Expected Result d
    Then Select from List and Verify details for all Enabled fields for "Banyan" service
      | Enabled | Test Mode | Shipper Rates | Submit Pickup | User Id    | Password 1   | Service URL                                                 | Test Service URL                                              | Proxy URL                     | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True          | True          | RevenovaWS | ************ | https://ws.logistics.banyantechnology.com/services/api/rest | https://ws.integration.banyantechnology.com/services/api/rest |https://qa.revenova.com:         | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Banyan" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code             |
      |            |                 |        | BanyanAPI     | a0fO9000008xBhiIAE | 2FVs3EzdCn5WiSKK |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |

    #Step5
    And Update details for "Banyan" service
      | User Id     | Enabled |
      | RevenovaWS1 | False   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    #Expected Result e
    Then Verify Text not displaying as "https://ws.logistics.banyantechnology.com/services/api/res"

    #Step6 & Expected Result f
    Then Verify "Banyan" Row "Enabled" Column value as "false"
    Then Verify "Banyan" Row "Test Mode" Column value as "true"
    # Step7  Expected Result  g
    Then Select from List and Verify details for all Enabled fields for "Banyan" service
      | Enabled | Test Mode | Shipper Rates | Submit Pickup | User Id     | Password 1   | Service URL                                                 | Test Service URL                                              | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | False   | True      | True          | True          | RevenovaWS1 | ************ | https://ws.logistics.banyantechnology.com/services/api/rest | https://ws.integration.banyantechnology.com/services/api/rest |https://qa.revenova.com:8086           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Banyan" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code             |
      |            |                 |        | BanyanAPI     | a0fO9000008xBhiIAE | 2FVs3EzdCn5WiSKK |

    #Reset updated fields back
    And Update details for "Banyan" service
      | User Id    | Enabled |
      | RevenovaWS | True    |
    And Click on Native "Save" button
    Then Wait for "3" Seconds
#    #Step8 Expected Result h
    Then Verify Text not displaying as "https://ws.logistics.banyantechnology.com/services/api/res"

    #Step9 Expected Result i
    Then Select from List and Verify details for all Enabled fields for "EFS" service
      | Enabled | Test Mode | Money Codes | Fuel Cards | EPayment Account Name | User Id   | Password 1 | Password 2 | Customer Number | Service URL                                           | Test Service URL                                              | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True        | False      | EFS                   | REN197937 | ********** | ******     | -1              | https://ws.efsllc.com/axis2/services/CardManagementWS | https://ws.partner.efsllc.com/axis2/services/CardManagementWS |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "EFS" service
      | Vendor | Service Class | Record Id          | Code             |
      |        | EFSAPI        | a0fO9000008xBhfIAE | 2Fm8hpWOnVhSNqwB |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |

    #Step10 Expected Result j
    And Update details for "EFS" service
      | User Id    | Enabled |
      | REN1979371 | False   |
    And Click on Native "Cancel" button

    Then Select from List and Verify details for all Enabled fields for "EFS" service
      | Enabled | Test Mode | Money Codes | Fuel Cards | EPayment Account Name | User Id   | Password 1 | Password 2 | Customer Number | Service URL                                           | Test Service URL                                              | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True        | False      | EFS                   | REN197937 | ********** | ******     | -1              | https://ws.efsllc.com/axis2/services/CardManagementWS | https://ws.partner.efsllc.com/axis2/services/CardManagementWS |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "EFS" service
      | Vendor | Service Class | Record Id          | Code             |
      |        | EFSAPI        | a0fO9000008xBhfIAE | 2Fm8hpWOnVhSNqwB |
    And Click on Native "Close" icon

    #Step11 Expected Result k
    Then Select from List and Verify details for all Enabled fields for "AccuFrate" service
      | Enabled | Test Mode | User Id            | Password 1               | Service URL                      | Test Service URL                    | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | apitest@ship1a.com | ************************ | https://webservice.accufrate.com | http://testwebservice.accufrate.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "AccuFrate" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | AccuFrateAPI  | a0fO9000008xBhgIAE | xTk5zWNCYnZIWtP |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step12 Expected Result l
    Then Select from List and Verify details for all Enabled fields for "Addrexx" service
      | Enabled | Test Mode | User Id  | Password 1         | Service URL                                | Test Service URL                           | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | Revenova | ****************** | https://secure.addrexx10.com/WS041713.asmx | https://secure.addrexx10.com/WS041713.asmx |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Addrexx" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | AddrexxAPI    | a0fO9000008xBhYIAU | EZuSzvxHVBauPAU |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step13 Expected Result m
    Then Select from List and Verify details for all Enabled fields for "Catena" service
      | Enabled | Test Mode | Link Status | Timeout (Seconds) |
      | True    | True      | False       | 45                |
    Then Verify details for all Disabled or Readonly fields for "Catena" service
      | User Id                   | Password 1 | Password 2  | Service URL                | Test Service URL           | Proxy URL | Inbound Packet IP Ranges | Service Class | Record Id          | Code            |
      | demo_revenova@axleapi.com | *********  |             | https://api.axleapi.com/v1 | https://api.axleapi.com/v1 |           |                          | AxleAPI       | a0fO9000008xBhEIAU | WHuNg2l63mh75V5 |
    Then Verify the button Colors
      | Save | Link a new ELD Account to Catena | Cancel | Close |
      | Blue | Blue                             | White  | White |
    And Click on Native "Close" icon

    #Step14 Expected Result n
    Then Select from List and Verify details for all Enabled fields for "Blue Yonder" service
      | Enabled | Test Mode | EDI Tenders | User Id                             | Password 1                       | Service URL                                 | Test Service URL                            | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | False       | revenovaNeIETltMpT-54d78ae75aed3951 | ******************************** | https://lctluminetprd01-api.jdadelivers.com | https://lctluminettst01-api.jdadelivers.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Blue Yonder" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | BlueYonderAPI | a0fO9000008xBhrIAE | CkFaGchWONcyiIL |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step15 Expected Result o
    Then Select from List and Verify details for all Enabled fields for "Border Connect" service
      | Enabled | User Id   | Timeout (Seconds) |
      | False   | REQUIRED   | 180               |
    Then Verify details for all Disabled or Readonly fields for "Border Connect" service
      | Password 2 | Customer Number | Service URL                                    | Test Service URL                                      | Vendor | Proxy URL | Inbound Packet IP Ranges | Service Class    | Record Id          | Code            |
      |            |                 | https://borderconnect.com/api/:action/Revenova | https://borderconnect.com/api/:action/RevenovaTesting |        |           |                          | BorderConnectAPI | a0fO9000008xBhuIAE | jhjuqEz81N2dtkT |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step16 Expected Result p
    Then Select from List and Verify details for all Enabled fields for "Breakthrough" service
      | Enabled | Test Mode | User Id      | Password 1       | Service URL              | Test Service URL          | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | revenova_fls | **************** | https://api.askfelix.com | https://api.testfelix.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Breakthrough" service
      | Password 2 | Customer Number | Vendor | Service Class   | Record Id          | Code            |
      |            |                 |        | BreakthroughAPI | a0fO9000008xBhlIAE | imkrIkgP1jJDabR |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step17 Expected Result q
    Then Select from List and Verify details for all Enabled fields for "Cleo" service
      | Enabled | Test Mode | Carrier Tender | User Id | Password 1 | Service URL                  | Test Service URL             | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True           | CLEO    | *********  | https://your.domain.com:8443 | https://your.domain.com:8443 |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Cleo" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | CleoAPI       | a0fO9000008xBhRIAU | wnCDT2kcKI3GrLS |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step18 : This has pair of grids Expected Result r
    Then Select from List and Verify details for all Enabled fields for "Comdata" service
      | Enabled | Test Mode | Comcheks | Fuel Cards | EPayment Account Name | User Id           | Password 1                         | Password 2       | Customer Number   | Service URL                   | Test Service URL             | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True      | False      | Comdata               | R-978;extr-978uat | ********************************** | **************** | R-978;97823;97824 | https://api.revenova.com:8084 | https://qa.revenova.com:8084 |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Comdata" service
      | Vendor | Service Class             | Record Id          | Code            |
      |        | ComdataAPI.ComdataAPI_1_0 | a0fO9000008xBhKIAU | kUzEIOwOQ5uSbyx |
    And Click on Native "Close" icon

    Then Select from List and Verify details for all Enabled fields for "Comdata" service
      | User Id-2                | Password 1-2          | Service URL-2                 | Test Service URL-2           | Proxy URL-2 | Timeout (Seconds)-2 | Inbound Packet IP Ranges-2 |
      | R-978;397542989603591015 | ********************** | https://api.revenova.com:8084 | https://qa.revenova.com:8084 |             | 45                  |                            |
    Then Verify details for all Disabled or Readonly fields for "Comdata" service
      | EPayment Account Name-2 | Password 2-2 | Customer Number-2 | Service Class-2           | Record Id-2        | Parent Record Id   | Code-2          |
      | See Parent Credential   |              |                   | ComdataAPI.ComdataAPI_2_1 | a0fO9000008xBhLIAU | a0fO9000008xBhKIAU | PqNGC31ZD7bSxng |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step19 Expected Result s
    Then Select from List and Verify details for all Enabled fields for "Custom EDI" service
      | Enabled | Test Mode | Carrier Tender | User Id  | Password 1 | Service URL              | Test Service URL         | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True           | REVENOVA | *********  | https://edi.revenova.com | https://edi.revenova.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Custom EDI" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | CustomEDIAPI  | a0fO9000008xBhSIAU | Nt3XooMgTqtgqmz |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step20 Expected Result t
    Then Select from List and Verify details for all Enabled fields for "DAT 2" service
      | Enabled | Test Mode | User Id                           | Password 1      | Service URL                     | Test Service URL                        | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | False   | True      | developersupport+revenova@dat.com | *************** | https://__appName__.api.dat.com | https://__appName__.api.staging.dat.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "DAT 2" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code              |
      |            |                 |        | DATRESTAPI    | a0fO9000008xBhvIAE | we2F82t2F33nmc17A |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step21 Expected Result u
    Then Select from List and Verify details for all Enabled fields for "EIA" service
      | Enabled | Test Mode | User Id  | Password 1                       | Service URL         | Test Service URL    | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | Revenova | ******************************** | https://api.eia.gov | https://api.eia.gov |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "EIA" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | EIAAPI        | a0fO9000008xBhaIAE | O43ADa3iaYwLceY |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step22 Expected Result v
    Then Select from List and Verify details for all Enabled fields for "Falvey" service
      | Enabled | Test Mode | User Id        | Password 1           | Password 2                           | Service URL                 | Test Service URL                | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | Synchrogistics | ******************** | ************************************ | https://www.falveycargo.com | https://sandbox.falveycargo.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Falvey" service
      | Customer Number | Vendor | Service Class | Record Id          | Code             |
      |                 |        | FalveyAPI     | a0fO9000008xBhkIAE | MEtR2BBadgwkPBQL |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step23 Expected Result w
    Then Select from List and Verify details for all Enabled fields for "FourKites" service
      | Enabled | Test Mode | Receive Updates | User Id                 | Password 1 | Service URL                        | Test Service URL                           | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges                                 |
      | True    | True      | True            | dcraigmile@revenova.com | ********** | https://tracking-api.fourkites.com | https://tracking-api-staging.fourkites.com |           | 45                | 54.82.239.68, 52.3.195.149, 54.83.176.23, 52.200.133.186 |
    Then Verify details for all Disabled or Readonly fields for "FourKites" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code             |
      |            |                 |        | FourKitesAPI  | a0fO9000008xBhPIAU | vr3jjmzZ7TN5d2B7 |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step24 Expected Result x
    Then Select from List and Verify details for all Enabled fields for "FreightWaves" service
      | Enabled | Test Mode | User Id      | Password 1      | Service URL                  | Test Service URL             | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | RevenovaUser | *************** | https://api.freightwaves.com | https://api.freightwaves.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "FreightWaves" service
      | Password 2 | Customer Number | Vendor | Service Class   | Record Id          | Code            |
      |            |                 |        | FreightWavesAPI | a0fO9000008xBhpIAE | mrTFfhrHhPVqQIV |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step25 Expected Result y
    Then Select from List and Verify details for all Enabled fields for "Highway" service
      | Enabled | Test Mode | Proxy URL                     | Timeout (Seconds) |
      | True    | True      | https://dev.revenova.com:8085 | 45                |
    Then Verify details for all Disabled or Readonly fields for "Highway" service
      | User Id | Password 1 | Password 2 | Service URL                                       | Test Service URL                                          | Customer Number | Vendor | Inbound Packet IP Ranges | Service Class | Record Id          | Code            |
      | unused  | ********   |            | https://highway.com/core/connect/external_api/v1/ | https://staging.highway.com/core/connect/external_api/v1/ |                 |        |                          | HighwayAPI    | a0fO9000008xBhDIAU | jhjuqEz81N2dtkT |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step26 Expected Result z
    Then Select from List and Verify details for all Enabled fields for "HubTran" service
      | Enabled | Test Mode | User Id  | Password 1 | Password 2                       | Service URL             | Test Service URL        | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges                                                   |
      | True    | True      | Revenova | ********   | ******************************** | https://api.audit.triumphpay.com | https://api.audit.triumphpay.com |           | 45                | 159.89.180.18, 159.89.191.208, 18.235.75.231, 34.198.144.109, 52.21.69.203 |
    Then Verify details for all Disabled or Readonly fields for "HubTran" service
      | Customer Number | Vendor | Service Class | Record Id          | Code             |
      |                 |        | HubTranAPI    | a0fO9000008xBheIAE | n2BBMYURSGAYvgGo |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step27 Expected Result aa
    Then Select from List and Verify details for all Enabled fields for "Kleinschmidt" service
      | Enabled | Test Mode | User Id  | Password 1 | Service URL                               | Test Service URL                               | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | REVENOVA | *********  | https://www.sub.kleinschmidt.com/revenova | https://www.sub.kleinschmidt.com/test/revenova |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Kleinschmidt" service
      | Password 2 | Customer Number | Vendor | Service Class   | Record Id          | Code            |
      |            |                 |        | KleinschmidtAPI | a0fO9000008xBhQIAU | Nt3XooMgTqtgqmz |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step28 Expected Result ab
    Then Select from List and Verify details for all Enabled fields for "LaneIQNetwork" service
      | Enabled | Test Mode |  Password 1 | Service URL                   | Test Service URL             | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      |  ********   | https://api.revenova.com:8081 | https://qa.revenova.com:8081 |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "LaneIQNetwork" service
      | Password 2 | Customer Number | Vendor | Service Class    | Record Id          | Code            |
      |            |                 |        | LaneIQNetworkAPI | a0fO9000008xBhsIAE | jhjuqEz81N2dtkT |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step29 Expected Result ac
    Then Select from List and Verify details for all Enabled fields for "LoadBoard Network" service
      | Enabled | Test Mode | Load Posting | User Id                  | Password 1               | Service URL                                          | Test Service URL                                     | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True         | 61d751a4987fb7c2512c290a | 61d751a4987fb7c2512c290a | https://post.loadboardnetwork.com/api/xml/post-loads | https://post.loadboardnetwork.com/api/xml/post-loads |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "LoadBoard Network" service
      | Password 2 | Customer Number | Vendor | Service Class     | Record Id          | Code            |
      |            |                 |        | PostEverywhereAPI | a0fO9000008xBhXIAU | tk0pEkkYNT0Y8XV |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step30 Expected Result ad
    Then Select from List and Verify details for all Enabled fields for "LoadDex" service
      | Enabled | Test Mode | User Id | Password 1      | Service URL                        | Test Service URL                   | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | admin   | *************** | https://company.logisticallabs.com | https://company.logisticallabs.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "LoadDex" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code             |
      |            |                 |        | LoadDexAPI    | a0fO9000008xBhZIAU | VcSAd2FHC1verWvS |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step31 Expected Result ae
    Then Select from List and Verify details for all Enabled fields for "MacroPoint" service
      | Enabled | Test Mode | Send Updates | Receive Updates | User Id | Password 1 | Customer Number | Service URL                         | Test Service URL                    | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges                      |
      | True    | True      | True         | True            | RFGC8Q2 | ********** | 5313778         | https://macropoint-lite.com/api/1.0 | https://macropoint-lite.com/api/1.0 |           | 45                | 66.181, 40.84, 52.162, 157.55, 52.141, 52.152 |
    Then Verify details for all Disabled or Readonly fields for "MacroPoint" service
      | Password 2 | Vendor | Service Class | Record Id          | Code            |
      |            |        | MacroPointAPI | a0fO9000008xBhMIAU | WRFkn1GhwxhFDEA |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step32 Expected Result af
    Then Select from List and Verify details for all Enabled fields for "MyCarrierPackets" service
      | Enabled | Test Mode | User Id       | Password 1      | Service URL                      | Test Service URL                 | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | Revenova_Test | *************** | https://api.mycarrierpackets.com | https://api.mycarrierpackets.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "MyCarrierPackets" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | MCPAPI        | a0fO9000008xBhoIAE | 1Xy8UU7zoDAljZk |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step33 Expected Result ag
    Then Select from List and Verify details for all Enabled fields for "PC Miler" service
      | Enabled | Test Mode | Use Rest API | User Id  | Password 1                       | Service URL             | Test Service URL        | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | Tue          | Revenova | ******************************** | https://pcmiler.alk.com | https://pcmiler.alk.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "PC Miler" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | PCMilerAPI    | a0fO9000008xBhFIAU | VxCJLIY0BjSGrWu |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step34 Expected Result ah
    Then Select from List and Verify details for all Enabled fields for "Project44" service
      | Enabled | Test Mode | Receive Updates | User Id               | Password 1 | Service URL                    | Test Service URL                  | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges                                                 |
      | True    | True      | True            | 1atrans.test@p-44.com | ********** | https://na12.api.project44.com | https://na12.api.sandbox.p-44.com |           | 45                | 54.191.68.235, 54.191.84.250, 52.33.218.14, 52.43.239.122, 52.39.132.206 |
    Then Verify details for all Disabled or Readonly fields for "Project44" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | Project44API  | a0fO9000008xBhVIAU | T2ypc7jFgxqugyY |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step35 Expected Result ai
    Then Select from List and Verify details for all Enabled fields for "Rand McNally" service
      | Enabled | Test Mode | User Id | Password 1 | Service URL                                                          | Test Service URL                                                     | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | 217526  | ********   | https://milemaker.randmcnally.com/Api/MileMakerService/MileMaker.svc | https://milemaker.randmcnally.com/Api/MileMakerService/MileMaker.svc |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Rand McNally" service
      | Password 2 | Customer Number | Vendor | Service Class  | Record Id          | Code            |
      |            |                 |        | RandMcNallyAPI | a0fO9000008xBhGIAU | 4hjdzs299v8sdDJ |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step36 Expected Result aj
    Then Select from List and Verify details for all Enabled fields for "RMIS" service
      | Enabled | Test Mode | User Id | Password 1 | Service URL                | Test Service URL           | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | 4727    | *********  | https://api.rmissecure.com | https://api.rmissecure.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "RMIS" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | RMISAPI       | a0fO9000008xBhJIAU | LsigDS3jJA7iS4O |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step37 Expected Result ak
    Then Select from List and Verify details for all Enabled fields for "SaferWatch" service
      | Enabled | Test Mode | User Id  | Password 1 | Password 2 | Customer Number | Service URL                                                 | Test Service URL                                            | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | revenova | ********   | ********** | FqvDbhw5Cf      | https://www.saferwatch.com/webservices/CarrierService32.php | https://www.saferwatch.com/webservices/CarrierService32.php |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "SaferWatch" service
      | Vendor | Service Class | Record Id          | Code             |
      |        | SaferWatchAPI | a0fO9000008xBhIIAU | n2BBMYURSGAYvgGo |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step38 Expected Result al
    Then Select from List and Verify details for all Enabled fields for "Samsara" service
      | Enabled | Test Mode | User Id  | Password 1                                 | Service URL             | Test Service URL        | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges                                    |
      | True    | True      | Revenova | ****************************************** | https://api.samsara.com | https://api.samsara.com |           | 45                | 35.166.166.111, 34.209.175.36, 52.32.199.170, 54.149.162.56 |
    Then Verify details for all Disabled or Readonly fields for "Samsara" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code             |
      |            |                 |        | SamsaraAPI    | a0fO9000008xBhjIAE | GADeKAPRMT8Qy02B |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step39 Expected Result am
    Then Select from List and Verify details for all Enabled fields for "SMC3 CarrierConnect" service
      | Enabled | Test Mode | User Id              | Password 1 | Password 2   | Service URL                            | Test Service URL                       | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | support@revenova.com | ********   | ************ | https://ccxl.smc3.com/CarrierConnectXL | https://ccxl.smc3.com/CarrierConnectXL |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "SMC3 CarrierConnect" service
      | Customer Number | Vendor | Service Class         | Record Id          | Code            |
      |                 |        | SMC3CarrierConnectAPI | a0fO9000008xBhbIAE | Gzcak15afDnt5cR |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step4 Expected Result an
    Then Select from List and Verify details for all Enabled fields for "SMC3 EVA" service
      | Enabled | Test Mode | Receive Updates | User Id           | Password 1      | Password 2      | Password 3           | Service URL                                 | Test Service URL                     | Proxy URL | Timeout (Seconds) |
      | True    | True      | True           | test@revenova.com | *************** | *************** | ********************               | https://smc3proxy.revenova.com:8083/proxyv1 | https://qa.revenova.com:8083/proxyv1 |           | 45                |
    Then Verify details for all Disabled or Readonly fields for "SMC3 EVA" service
      | Customer Number | Callback Endpoint Created | Vendor | Service Class | Record Id          | Code            |
      ||                           |        | SMC3EVAAPI    | a0fO9000008xBhdIAE | GXCtsz6OXx0gSi1 |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step41 Expected Result ao
    Then Select from List and Verify details for all Enabled fields for "SMC3 RateWare" service
      | Enabled | Test Mode | User Id              | Password 1 | Password 2   | Service URL                                               | Test Service URL                                          | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | support@revenova.com | ********   | ************ | https://applications.smc3.com/RateWareXL/services/soap/v2 | https://applications.smc3.com/RateWareXL/services/soap/v2 |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "SMC3 RateWare" service
      | Customer Number | Vendor | Service Class   | Record Id          | Code            |
      |                 |        | SMC3RateWareAPI | a0fO9000008xBhcIAE | Gzcak15afDnt5cR |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step42 Expected Result ap
    Then Select from List and Verify details for all Enabled fields for "TEC-IT" service
      | Enabled | Test Mode | User Id  | Password 1 | Service URL                 | Test Service URL            | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | Revenova | ****       | https://services.tec-it.com | https://services.tec-it.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "TEC-IT" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | TecITAPI      | a0fO9000008xBhqIAE | rFjCvt98HU41E28 |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step43 Expected Result aq
    Then Select from List and Verify details for all Enabled fields for "Trimble" service
      | Enabled | Test Mode | User Id  | Password 1                       | Service URL                    | Test Service URL               | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | revenova | ******************************** | https://tripmanagement.alk.com | https://tripmanagement.alk.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Trimble" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | TrimbleAPI    | a0fO9000008xBhtIAE | VxCJLIY0BjSGrWu |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step44 Expected Result ar
    Then Select from List and Verify details for all Enabled fields for "TriumphPay" service
      | Enabled | Test Mode | User Id                 | Password 1   | Password 2                           | Service URL                | Test Service URL                | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | dcraigmile@revenova.com | ************ | ************************************ | https://api.triumphpay.com | https://api.onb-triumphpay.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "TriumphPay" service
      | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |                 |        | TriumphPayAPI | a0fO9000008xBhhIAE | ItgnlXdCvMMDs9S |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step45 Expected Result as
    Then Select from List and Verify details for all Enabled fields for "Trucker Tools" service
      | Enabled | Test Mode | Receive Updates | User Id | Password 1               | Service URL                                   | Test Service URL                              | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges                                  |
      | True    | True      | True            | 101     | ************************ | https://api.truckertools.com/loadtrackservice | https://api.truckertools.com/loadtrackservice |           | 45                | 107.23.95.62, 54.90.234.171, 18.206.85.60, 35.173.174.193 |
    Then Verify details for all Disabled or Readonly fields for "Trucker Tools" service
      | Password 2 | Customer Number | Vendor | Service Class   | Record Id          | Code             |
      |            |                 |        | TruckerToolsAPI | a0fO9000008xBhNIAU | WEc1YSubAZ0Nb2F0 |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step46 Expected Result at
    Then Select from List and Verify details for all Enabled fields for "Trucker Tools Load Board" service
      | Enabled | Test Mode | Load Posting | Truck Posting Search | User Id | Password 1                       | Password 2                                                       | Customer Number | Service URL                    | Test Service URL                      | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True         | True                 | 187947  | ******************************** | **************************************************************** | revenova        | https://scapi.truckertools.com | http://scapi-staging.truckertools.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "TTrucker Tools Load Board" service
      | Vendor | Service Class            | Record Id          | Code            |
      |        | TruckerToolsLoadBoardAPI | a0fO9000008xBhOIAU | ivXVbc24MZs1SF5 |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step47 Expected Result au
    Then Select from List and Verify details for all Enabled fields for "Twilio" service
      | Enabled | Test Mode | User Id              | Password 1                                                            | Service URL              | Test Service URL         | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | support@revenova.com | ********************************************************************* | https://api.sendgrid.com | https://api.sendgrid.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "Twilio" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        | TwilioAPI     | a0fO9000008xBhnIAE | 0LwqXdSf3d0uEBb |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step48 Expected Result av
    Then Select from List and Verify details for all Enabled fields for "WWEX SpeedShip" service
      | Enabled | Test Mode | User Id                          | Password 1                                                       | Service URL               | Test Service URL                   | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | 8h94TCp0N6fg09ipP3yyJmfPPv5l1mCD | **************************************************************** | https://www.speedship.com | https://speedship.staging-wwex.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "WWEX SpeedShip" service
      | Password 2 | Customer Number | Vendor | Service Class    | Record Id          | Code             |
      |            |                 |        | WWEXSpeedShipAPI | a0fO9000008xBhUIAU | FT2FC7Mi0zZTP3ov |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step49: This is repeated in step 25 Expected Result aw
    Then Select from List and Verify details for all Enabled fields for "Highway" service
      | Enabled | Test Mode | Proxy URL                     | Timeout (Seconds) |
      | True    | True      | https://dev.revenova.com:8085 | 45                |
    Then Verify details for all Disabled or Readonly fields for "Highway" service
      | User Id | Password 1 | Password 2 | Service URL                                       | Test Service URL                                          | Customer Number | Vendor | Inbound Packet IP Ranges | Service Class | Record Id          | Code            |
      | unused  | ********   |            | https://highway.com/core/connect/external_api/v1/ | https://staging.highway.com/core/connect/external_api/v1/ |                 |        |                          | HighwayAPI    | a0fO9000008xBhDIAU | jhjuqEz81N2dtkT |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |
    And Click on Native "Close" icon

    #Step50 Expected Result ax
    Then Select from List and Verify details for all Enabled fields for "TextLocate" service
      | Enabled | Test Mode | Receive Updates | User Id                              | Password 1                           | Service URL                | Test Service URL           | Proxy URL | Timeout (Seconds) | Inbound Packet IP Ranges |
      | True    | True      | True            | 750cfeac-82a3-4f34-8729-78dfa6610998 | ************************************ | https://api.textlocate.com | https://api.textlocate.com |           | 45                |                          |
    Then Verify details for all Disabled or Readonly fields for "TextLocate" service
      | Callback Endpoint Created | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code             |
      | False                     |            |                 |        | TextLocateAPI | a0fO9000008xBhwIAE | I2GxpB2BwtVoau6Y |
    Then Verify the button Colors
      | Save | Cancel | Close |
      | Blue | White  | White |

     #Step51 Expected Result ay
    Then Select from List and Verify details for all Enabled fields for "OpenTrack" service
      | User Id   | Password 1                             |Service URL                |Test Service URL           |Proxy URL|
      | Revenova  |************************************    |https://api.opentrack.co/v1|https://api.opentrack.co/v1|         |
    Then Select from List and Verify details for all Enabled fields for "OpenTrack" service
      |Timeout (Seconds)|Inbound Packet IP Ranges|
      |45               |                        |

    Then Verify details for all Disabled or Readonly fields for "OpenTrack" service
      | Password 2 | Customer Number | Vendor | Service Class | Record Id          | Code            |
      |            |                 |        |OpenTrackAPI   | a0jcf000006POnQAAW | QH5RFXp5CFCEbpe |
    Then Verify the button Colors
      | Save | Cancel | Close |Register OpenTrack Webhook|
      | Blue | White  | White |Blue                      |
    And Click on Native "Close" icon

   #Step52 Expected Result az
    And Global Service : Close Credential
    Then Wait for "2" Seconds
    Then Verify url contains "rtms__TMS_Admin2"

