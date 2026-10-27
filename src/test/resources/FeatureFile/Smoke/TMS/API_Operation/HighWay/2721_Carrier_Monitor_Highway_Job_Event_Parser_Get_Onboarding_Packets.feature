Feature: 2721 - Carrier Monitor Highway Job- Event Parser: Get Onboarding Packets

  @API @Regression @TMS @Smoke @WEB @API_Operation @MultiCurrency @2721 @HighWay_API
  Scenario: 2721 - Carrier Monitor Highway Job- Event Parser: Get Onboarding Packets

    When Login into Salesforce
    Then Delete All Records with name "Quality Assurance Trans LLC 2721" for "rtms__CarrierService__c"
    Then Delete All Records with name "Quality Assurance Trans LLC 2721" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "Quality Assurance Trans LLC 2721" for "Account"
    Then Delete All Records with name "Quality Assurance Service Inc 2721" for "rtms__CarrierService__c"
    Then Delete All Records with name "Quality Assurance Service Inc 2721" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "Quality Assurance Service Inc 2721" for "Account"
    Then Delete All Records with name "18 WHEEL FUNDING LLC" for "Account"
    Then Delete All Records with name "Quality Assurance Express 2721" for "rtms__CarrierService__c"
    Then Delete All Records with name "Quality Assurance Express 2721" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "Quality Assurance Express 2721" for "Account"

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab

    Then Search text "MyCarrierPackets" in the "Search Credentials..." search box
    Then Select the "MyCarrierPackets" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    Then Search text "SaferWatch" in the "Search Credentials..." search box
    Then Select the "SaferWatch" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    Then Search text "RMIS" in the "Search Credentials..." search box
    Then Select the "RMIS" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button
    Then Wait for "2" Seconds
    #Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Modes" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Mode" Link Text "Air Freight" on Page -
    Then Switch to Parent Frame
    Then Click on Edit icon on Label "Name"
    Then Update details
      |Enabled            |
      |False|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      |Enabled            |
      |False|

    #Step 3
    Then Open "TMS Admin" from App Launcher
    Then Go to "Modes" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Mode" Link Text "Parcel" on Page -
    Then Switch to Parent Frame
    Then Scroll into Section "Carrier Onboarding Settings"
    Then Click on Edit icon on Label "Highway Mode"
    Then Enter Label "Highway Mode" Text as "Truckload"
    Then Update details
      |Highway Mode            |
      |Truckload|
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Highway Mode|
      |Truckload|

    #Step 4
    Then Open "TMS Admin" from App Launcher
    Then Go to "Modes" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Mode" Link Text "Truckload" on Page -
    Then Switch to Parent Frame
    Then Scroll into Section "Carrier Onboarding Settings"
    Then Click on Edit icon on Label "Highway Mode"
    Then Enter Label "Highway Mode" Text as ""
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      |Highway Mode|
      ||

    #Step 5, 6 & 7
    Then Get "HighwayEventParser_OnboardingPacket_Quality_Assurance_Trans_LLC2721.txt" files and update below Attributes
         |No Update Required|
         |No Update Required|
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |
      |HighwayInbound    |Inbound  |Pending|application/json|
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    #Step 8
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 9, 10
    Then Get "HighwayEventParser_OnboardingPacket_Quality_Assurance_Service_Inc2721.txt" files and update below Attributes
      |No Update Required|
      |No Update Required|
    Then Wait for "2" Seconds
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Update details -
      |Processor         |
      |HighwayInbound    |
    Then Update details -
      |Direction|Status |Content Type    |
      |Inbound  |Pending|application/json|
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 11
    Then Get "HighwayEventParser_OnboardingPacket_Quality_Assurance_Express2721.txt" files and update below Attributes
      |No Update Required|
      |No Update Required|
    Then Wait for "2" Seconds
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Update details -
      |Processor         |
      |HighwayInbound    |
    Then Update details -
      |Direction|Status |Content Type    |
      |Inbound  |Pending|application/json|
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 12
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "2" Seconds
    #Step 13
    Then Search and Select "Quality Assurance Trans LLC 2721" Account from the Global search
    Then Wait for "2" Seconds
    #Expected Result a
    Then Verify Details
         |Account Name                    |DBA Name  |TMS Type        |Phone|Fax|Website|Default Payment Method|
         |Quality Assurance Trans LLC 2721|QA TRAN   |Carrier (Ground)|     |   |       |ACH (NACHA File)                   |

    Then Get Details
         |Shipping Address|Billing Address|
         |                |               |

    Then Wrap "Shipping Address" in one line
    Then Wrap "Billing Address" in one line
    Then Verify Assertion for "Shipping Address" contains "820 S MONACO PKWY 213 DENVER, Colorado 80224 United States"
    Then Verify Assertion for "Billing Address" contains "500 Main DENVER, Colorado 80224 United States"
    Then Capture the current URL for "Account_Page"
    Then Get "CurrencyIsoCode" from "Account" using "Name" with value "Quality Assurance Trans LLC 2721" and Store onto "Account_Currency"
    Then Verify Assertion for "Account_Currency" contains "USD"


      #Step 14
    Then Go to "Quotes, Invoices & Payments" Tab
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Bank Accounts"
    Then Scroll into Section "Bank Accounts"
    Then Wait for "2" Seconds
    #Step 15
    Then Click on Partial Link Text "BA-0" on Page -
    Then Wait for "2" Seconds
     #Expected Result b
    Then Verify Details
        |Bank Name            |Account                         |Account Type|Routing Number|Account Number|
        |BANK OF AMERICA, N.A.|Quality Assurance Trans LLC 2721|            |111000025     |3456          |

    Then Verify Label Checkbox
         |ACH Active|
         |False     |

    Then Verify Details
         |Confirm Account Number|ACH Remittance Document|ACH Payee Name|ACH Company Information|
         |3456                  |                       |              |                       |

    Then Verify Details
        |ACH Company Discretionary Data|ACH Immediate Origin Name|ACH Company Name|ACH Reference Code|
        |                              |                         |                |ACH               |

    #Step 16
     Then Navigate to stored URL for "Account_Page"
    #Step 17
    Then Go to "Contacts" Tab
    Then Wait for "1" Seconds
    Then Click on "Tony Soprano" with Text
    Then Wait for "1" Seconds
    #Step 18 & Expected c
    Then Verify Details
         |Name        |Transportation Role       |Account Name                    |Description|Phone|Title|Email               |Fax|
         |Tony Soprano|Carrier Application Signer|Quality Assurance Trans LLC 2721|           |     |     |bigtony@revenova.com|   |
   #Step 19
    Then Navigate Browser Back
   #Step 20
    Then Wait for "1" Seconds
    Then Click on "Beyonce Knowles" with Text
    Then Wait for "1" Seconds
   #Step 21 & Expected d
    Then Verify Details
      |Name            |Transportation Role           |Account Name                     |Description       |Phone              |Title|Email               |Fax|
      |Beyonce Knowles|Quoting;Tendering;Status;Billing|Quality Assurance Trans LLC 2721|dispatch, billing |(720) 469-0371     |     |queenbee@revenova.com|   |

     #Step 22
    Then Navigate Browser Back
   #Step 23
    Then Wait for "1" Seconds
    Then Click on "Dolly Parton" with Text
    Then Wait for "1" Seconds
   #Step 24 & Expected e
    Then Verify Details
      |Name            |Transportation Role |Account Name                     |Description       |Phone              |Title|Email               |Fax|
      |Dolly Parton    |                    |Quality Assurance Trans LLC 2721 |claims            |(555) 469-0371     |     |dolly@revenova.com|   |

    #STep 25
    Then Navigate to stored URL for "Account_Page"
    #Step 26
    Then Click on "Transportation Profile" Link Text "Quality Assurance Trans LLC 2721" on Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page"
    #Step 27 & Expected f
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Verify Details
      |Cargo Carried|SCAC  |Fleet Size|Number of Drivers|Total Power Units|MC/MX/FF Number|State DOT Number|US DOT Number|
      |General Freight|GOBN|550       |497              |442               |MC841412       |                |2439316      |
    Then Get "CurrencyIsoCode" from "rtms__TransportationProfile__c" using "Name" with value "Quality Assurance Trans LLC 2721" and Store onto "TP_Currency"
    Then Verify Assertion for "TP_Currency" contains "USD"


    #Step 28 & Expected Result g
      Then Scroll into Section "Carrier Services"
      Then Verify Table data
        | Name                                       | Service Type | Enabled | Mode    | Quote Contact  | Tender Contact | Status Contact | Quote Method | Tender Method | Status Method |
        | Quality Assurance Trans LLC 2721 - Drayage | Carrier     | True    | Drayage | Beyonce Knowles | Beyonce Knowles | Beyonce Knowles | Email        | Email         | Email         |
        | Quality Assurance Trans LLC 2721 - Parcel  | Carrier     | True    | Parcel  | Beyonce Knowles | Beyonce Knowles | Beyonce Knowles | Email        | Email         | Email         |
    #Step 29
    Then Click on "Carrier Service" Link Text "Quality Assurance Trans LLC 2721 - Drayage" on Page
    Then Wait for "2" Seconds
    #Step 30 & Expected Result H
   Then Scroll into Section "Load Weight & Volume Thresholds"
   Then Verify Details
        |Minimum Weight|Maximum Weight|Weight Units|
        |100           |45,000        | lbs        |
    Then Scroll into Section "System Information"
   Then Verify Details
        |Currency |
        |USD - U.S. Dollar      |
    #Step 31
    Then Navigate to stored URL for "TP_Page"
    Then Wait for "2" Seconds
    #Step 32
    Then Scroll Until Related List for "Carrier Equipment Types"
    Then Scroll into Section "Carrier Equipment Types"
    Then Wait for "2" Seconds
    #Expected Result i
    Then Verify Table "Carrier Equipment Types" row count is "6"
    Then Verify Carrier Equipment Types Table data
      | Number | Equipment_type           |
      | 73     | Dry Van 53'              |
      | 218    | Reefer 53'              |
      | 20     | Flatbed 3 Axle 53'       |
      | 1      | Double Drop / Low Boy    |
      | 37     | Straight Truck 26'       |
      | 2      | Double Drop / Low Boy    |


    #Step 33
    Then Go to "Compliance" Tab
    Then Wait for "2" Seconds
    #Expected J
    Then Verify Details
         |Carrier Review Status|Agreement Status |Agreement Date|Agreement Signed By|Highway ID|Overall Risk     |Authority Risk|Insurance Risk|
         |Approved             |Verified         |2/27/2023     |Tony Soprano       |23815     |Acceptable     |Acceptable    |Acceptable              |
    Then Verify Details
         |Safety Risk     |Operation Risk|Safety Rating|Safety Rating Date|Authority Granted Date|
         |Pending         |Acceptable      |Satisfactory|11/22/2021       |10/22/2013            |
    Then Verify Details
         |Common Authority Status|Contract Authority Status|Broker Authority Status|Common Authority Pending|Common Authority Revocation|
         |Active                 |None                     |None                   |No                     |No                        |
    Then Verify Details
         |Contract Authority Pending|Contract Authority Revocation|Broker Authority Pending|Broker Authority Revocation|
         |No                       |No                           |No                     |No                         |
     #Step 34
    Then Scroll Until Related List for "Insurance Policies"
    Then Scroll into Section "Insurance Policies"
    Then Wait for "2" Seconds

   #Step 35
    Then Click on Partial Link Text "78A69A0095D59B5817C1B8CD4DD497FD" on Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Policy Information"
    #Expected k
    Then Verify Details
         |Transportation Profile           |Insurance Company             |Type            |Source |Policy Number|
         |Quality Assurance Trans LLC 2721 |QA INSURANCE COMPANY           |Auto         |Highway|78A69A0095D59B5817C1B8CD4DD497FD|
    Then Verify Details
         |Description|Country      |Coverage Amount              |Effective Date|Expiry Date|
         |           |United States|MXN 0.00 (USD 0.00)          |2/25/2022    |1/1/2032   |
    Then Verify Label Checkbox
      |Cross Border Insurance Policy    |
      |false   |
    Then Verify Details
         |Cancel Date|Deductible |Reefer Breakdown Coverage|Reefer Breakdown Deductible|
         |           |           |                         |                           |
    Then Verify Details
         |Agent First Name|Agent Last Name|Agent Title|Agent Email|Agent Phone|Fax|
         |                |               |           |           |(952) 974-2265||
    Then Verify Details
         |Agent Company|Address                |City   |State/Province|Postal Code|Phone|
         |             |151 LAKE STREET WEST   |WAYZATA|MN       |55391         |(952) 974-2265|
    Then Scroll into Section "System Information"
    Then Verify Details
      |Currency|
      |MXN - Mexican Peso     |

    #Step 36
    Then Navigate Browser Back
    Then Wait for "1" Seconds
    #Step 37
    Then Click on Partial Link Text "03C750D327D07C792E7B732353D42004" on Page
    Then Scroll into Section "Policy Information"
    #Expected L
    Then Verify Details
      |Transportation Profile           |Insurance Company                   |Type            |Source |Policy Number|
      |Quality Assurance Trans LLC 2721 |QUALITY ASSURANCE GUARANTY COMPANY   |General         |Highway|03C750D327D07C792E7B732353D42004|
    Then Verify Details
      |Description|Country      |Coverage Amount              |Effective Date|Expiry Date|
      |           |United States|USD 1,000,000.00             |12/20/2022    |1/1/2032   |
    Then Verify Label Checkbox
      |Cross Border Insurance Policy    |
      |false   |
    Then Verify Details
      |Cancel Date|Deductible |Reefer Breakdown Coverage|Reefer Breakdown Deductible|
      |11/20/2025 |           |                         |                           |
    Then Verify Details
      |Agent First Name|Agent Last Name|Agent Title|Agent Email|Agent Phone|Fax|
      |                |               |           |           |(713) 625-8044||
    Then Verify Details
      |Agent Company|Address                |City   |State/Province|Postal Code|Phone|
      |             |1360 POST OAK BOULEVARD|HOUSTON|TX       |77056         |(713) 625-8044|
    Then Scroll into Section "System Information"
    Then Verify Details
      |Currency|
      |USD - U.S. Dollar     |

       #Step 38
    Then Navigate Browser Back
    Then Wait for "1" Seconds
    #Step 39
    Then Click on Partial Link Text "BFD6A2168057B227ADD4EAF59B1346B5" on Page
    Then Scroll into Section "Policy Information"
    #Expected M
    Then Verify Details
      |Transportation Profile           |Insurance Company                   |Type            |Source |Policy Number|
      |Quality Assurance Trans LLC 2721 |QA NORTHERN INSURANCE COMPANY   |Cargo         |Highway|BFD6A2168057B227ADD4EAF59B1346B5|
    Then Verify Details
      |Description|Country      |Coverage Amount              |Effective Date|Expiry Date|
      |           |United States|USD 100,000.00               |4/1/2022   |1/1/2032   |
    Then Verify Label Checkbox
      |Cross Border Insurance Policy    |
      |false   |
    Then Verify Details
      |Cancel Date|Deductible |Reefer Breakdown Coverage|Reefer Breakdown Deductible|
      |           |           |                         |                           |
    Then Verify Details
      |Agent First Name|Agent Last Name|Agent Title|Agent Email|Agent Phone|Fax|
      |                |               |           |           |(440) 461-5000||
    Then Verify Details
      |Agent Company|Address                |City   |State/Province|Postal Code|Phone|
      |             |6300 WILSON MILLS ROAD, W33|CLEVELAND|OH       |44143-2182         |(440) 461-5000|
    Then Scroll into Section "System Information"
    Then Verify Details
      |Currency|
      |USD - U.S. Dollar     |

       #Step 40
    Then Navigate Browser Back
    Then Wait for "1" Seconds
    #Step 41
    Then Click on Partial Link Text "77E056B925AF779A73DFF3255324C09D" on Page
    Then Scroll into Section "Policy Information"
    #Expected n
    Then Verify Details
      |Transportation Profile           |Insurance Company                   |Type            |Source |Policy Number|
      |Quality Assurance Trans LLC 2721 |QA INTERSTATE INSURANCE COMPANY   |Workers Compensation         |Highway|77E056B925AF779A73DFF3255324C09D|
    Then Verify Details
      |Description|Country      |Coverage Amount              |Effective Date|Expiry Date|
      |           |United States|USD 1,000,080.00               |9/1/2022   |1/1/2032   |
    Then Verify Label Checkbox
      |Cross Border Insurance Policy    |
      |false   |
    Then Verify Details
      |Cancel Date|Deductible |Reefer Breakdown Coverage|Reefer Breakdown Deductible|
      |           |           |                         |                           |
    Then Verify Details
      |Agent First Name|Agent Last Name|Agent Title|Agent Email|Agent Phone|Fax|
      |                |               |           |           |(330) 659-8900||
    Then Verify Details
      |Agent Company|Address                |City   |State/Province|Postal Code|Phone|
      |             |3250 INTERSTATE DRIVE|RICHFIELD|OH       |44286       |(330) 659-8900|
    Then Scroll into Section "System Information"
    Then Verify Details
      |Currency|
      |USD - U.S. Dollar     |

       #Step 42
    Then Navigate Browser Back
    Then Wait for "1" Seconds
    #Step 43
    Then Click on Partial Link Text "FC500C0CC10DC8C307261F617D53F050" on Page
    Then Scroll into Section "Policy Information"
    #Expected O
    Then Verify Details
      |Transportation Profile           |Insurance Company                   |Type            |Source |Policy Number|
      |Quality Assurance Trans LLC 2721 |QA NORTHERN INSURANCE COMPANY   |Contingent Cargo         |Highway|FC500C0CC10DC8C307261F617D53F050|
    Then Verify Details
      |Description|Country      |Coverage Amount              |Effective Date|Expiry Date|
      |           |United States|USD 40,000.00                |4/1/2022   |1/1/2032   |
    Then Verify Label Checkbox
      |Cross Border Insurance Policy    |
      |false   |
    Then Verify Details
      |Cancel Date|Deductible |Reefer Breakdown Coverage|Reefer Breakdown Deductible|
      |           |           |                         |                           |
    Then Verify Details
      |Agent First Name|Agent Last Name|Agent Title|Agent Email|Agent Phone|Fax|
      |                |               |           |           |(440) 461-5000||
    Then Verify Details
      |Agent Company|Address                |City   |State/Province|Postal Code|Phone|
      |             |6300 WILSON MILLS ROAD, W33|CLEVELAND|OH       |44143-2182       |(440) 461-5000|
    Then Scroll into Section "System Information"
    Then Verify Details
      |Currency|
      |USD - U.S. Dollar     |

  #Step 44
    Then Navigate to stored URL for "TP_Page"
    Then Wait for "2" Seconds
    Then Go to "Settlement" Tab
    Then Wait for "1" Seconds
    #Expected P
    Then Verify Details
         |Payment Processor|EPayment Authorized|
         |Accounting       |                   |
    Then Scroll into Section "Carrier Remittance Information"
    Then Verify Details
      |Carrier Remit To                |
      |Quality Assurance Trans LLC 2721|
    #Step 45
    Then Click on Partial Link Text "7-Day Quick Pay (ACH, Check issued on 7th Day)" on Page
    Then Wait for "1" Seconds
      #Step 46 #Expected q
    Then Verify Details
         |Name                                          |Type|Order|Payment Discount %|
         |7-Day Quick Pay (ACH, Check issued on 7th Day)|Vendor|1  |0.02%             |
    Then Verify Label Checkbox
         |Enabled|
         |True   |

    #Step 47
    Then Search and Select "Quality Assurance Service Inc 2721" Account from the Global search
    Then Wait for "2" Seconds
    #Expected r
    Then Verify Details
      |Default Payment Method|
      |                 |
    Then Get "CurrencyIsoCode" from "Account" using "Name" with value "Quality Assurance Service Inc 2721" and Store onto "Account_Currency2"
    Then Verify Assertion for "Account_Currency2" contains "MXN"

    Then Capture the current URL for "Account_Page_2"

    #Step 48
    Then Go to "Quotes, Invoices & Payments" Tab
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Bank Accounts"
    Then Scroll into Section "Bank Accounts"
    Then Wait for "2" Seconds
    #Expected s
    Then Verify "Bank Accounts" count displaying as "0"


    #Step 49
    Then Navigate to stored URL for "Account_Page_2"
    Then Wait for "1" Seconds
    Then Click on "Transportation Profile" Link Text "Quality Assurance Service Inc 2721" on Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page_2"
    #Step 50 & Expected t
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Get Details
      |Cargo Carried|
      |             |
    Then Verify Assertion for "Cargo Carried" contains "Farm Supplies"
    Then Verify Assertion for "Cargo Carried" contains "Utility"
    Then Verify Assertion for "Cargo Carried" contains "Liquids/Gases"
    Then Verify Assertion for "Cargo Carried" contains "Intermodal Container"

    Then Verify Details
      |SCAC  |Fleet Size|MC/MX/FF Number|State DOT Number|US DOT Number|
      |JJGA  |22,551    |MC841416       |                |11431443      |

    Then Get "CurrencyIsoCode" from "rtms__TransportationProfile__c" using "Name" with value "Quality Assurance Service Inc 2721" and Store onto "TP_Currency2"
    Then Verify Assertion for "TP_Currency2" contains "MXN"

    #Step 51 & Expected Result U
    Then Scroll into Section "Carrier Services"
    Then Verify Table data
        | Name                                       | Service Type | Enabled | Mode    | Quote Contact  | Tender Contact | Status Contact | Quote Method | Tender Method | Status Method |
        | Quality Assurance Service Inc 2721 - Intermodal | Carrier      | True    | Intermodal  | Bruce Wayne   | Bruce Wayne    | Bruce Wayne    | Email        | Email         | Email         |
        | Quality Assurance Service Inc 2721 - Ocean FCL  | Carrier      | True    | Ocean FCL  | Bruce Wayne   | Bruce Wayne    | Bruce Wayne    | Email        | Email         | Email         |
        | Quality Assurance Service Inc 2721 - LTL        | Carrier      | True    | LTL  | Bruce Wayne   | Bruce Wayne    | Bruce Wayne    | Email        | Email         | Email         |
        | Quality Assurance Service Inc 2721 - Ocean LCL  | Carrier      | True    | Ocean LCL       | Bruce Wayne   | Bruce Wayne    | Bruce Wayne    | Email        | Email         | Email         |

     #Step 52
    Then Click on "Carrier Service" Link Text "Quality Assurance Service Inc 2721 - Intermodal" on Page
    Then Wait for "2" Seconds
    #Step 53 & Expected Result V
    Then Scroll into Section "System Information"
    Then Verify Details
        |Currency |
        |MXN - Mexican Peso      |
    #Step 54
    Then Navigate to stored URL for "TP_Page_2"
    #Step 55
    Then Go to "Compliance" Tab
    Then Wait for "2" Seconds
    #Expected w
    Then Verify Details
         |Carrier Review Status   |Agreement Status |Agreement Date|Agreement Signed By|Highway ID|Overall Risk     |Authority Risk|Insurance Risk|
         |Incomplete Application  |Verified         |2/27/2023     |Tony Stark       |23811     |Pending     |Acceptable    |Acceptable              |
    Then Verify Details
         |Carrier Review Comments|
         |Authority History Gap: This carrier has four gaps in authority history of more than one year.|
    Then Verify Details
         |Safety Risk     |Operation Risk|Safety Rating|Safety Rating Date|Authority Granted Date|
         |Pending         |Acceptable      |Conditional|11/22/2021       |10/22/2013            |
    Then Verify Details
         |Common Authority Status|Contract Authority Status|Broker Authority Status|Common Authority Pending|Common Authority Revocation|
         |Active                 |None                     |None                   |No                     |No                        |
    Then Verify Details
         |Contract Authority Pending|Contract Authority Revocation|Broker Authority Pending|Broker Authority Revocation|
         |No                       |No                           |No                     |No                         |
     #Step 56
    Then Go to "Settlement" Tab
    Then Wait for "1" Seconds
    #Expected x
    Then Verify Details
         |Payment Processor|EPayment Authorized|
         |Accounting       |EFS Money Code     |
    Then Scroll into Section "Carrier Remittance Information"
    Then Verify Details
      |Remit To Option|Carrier Remit To                |Carrier Payment Terms|
      |Factor|18 WHEEL FUNDING LLC|                                          |

    #Step 57
    Then Click on Partial Link Text "18 WHEEL FUNDING LLC" on Page
    Then Wait for "1" Seconds
     #Step 58 #Expected y
    Then Verify Details
      |Account Name                    |DBA Name  |TMS Type         |Phone              |Fax|Website|
      |18 WHEEL FUNDING LLC            |          |Factoring Company|(704) 243-8351     |   |       |

    Then Get Details
      |Shipping Address|Billing Address|
      |                |               |

    Then Get "CurrencyIsoCode" from "Account" using "Name" with value "18 WHEEL FUNDING LLC" and Store onto "Account_Currency3"
    Then Verify Assertion for "Account_Currency3" contains "MXN"

    Then Wrap "Shipping Address" in one line
    Then Wrap "Billing Address" in one line
    Then Verify Assertion for "Shipping Address" contains "123 Main Street South San Antonio, Texas 78205 United States"
    Then Verify Assertion for "Billing Address" contains "Francia 471, Versalles Puerto Vallarta, Jalisco 48310 Mexico"
    #Step 59
    Then Search and Select "Quality Assurance Express 2721" Account from the Global search
    Then Wait for "2" Seconds
    #Expected z
    Then Verify Details
      |Default Payment Method|
      |                      |
    Then Capture the current URL for "Account_Page_3"
     #Step 60
    Then Go to "Quotes, Invoices & Payments" Tab
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Bank Accounts"
    Then Scroll into Section "Bank Accounts"
    Then Wait for "2" Seconds
    #Expected aa
    Then Verify "Bank Accounts" count displaying as "0"

     #Step 61
    Then Navigate to stored URL for "Account_Page_3"
    Then Wait for "1" Seconds
    Then Click on "Transportation Profile" Link Text "Quality Assurance Express 2721" on Page
    Then Wait for "2" Seconds
    Then Capture the current URL for "TP_Page_3"

    #Step 62
    Then Go to "Files" Tab
    Then Wait for "1" Seconds
    #Expected ab
    Then Verify Text displaying as "Executed Tax Form - Form W-9 - 02-27-2023 (5975-1036).pdf"
    Then Verify Text displaying as "Highway - Sprinter.pdf"
    #Step 63
    Then Scroll into Section "Lane Coverage and Preferences"
    Then Get Details
      |Other Carrier Capabilities|
      |             |
    #Expected ac
    Then Verify Assertion for "Other Carrier Capabilities" contains "CARB-Truck Compliant (California)"
    Then Verify Assertion for "Other Carrier Capabilities" contains "CARB-TRU Compliant (California)"
    Then Verify Assertion for "Other Carrier Capabilities" contains "SmartWay Certified (US)"
    Then Verify Assertion for "Other Carrier Capabilities" contains "TSA Certification"

    Then Verify Details
      |Cargo Carried  |SCAC  |
      |General Freight|GOAA  |
    Then Scroll into Section "US Registration"
    Then Verify Details
       |MC/MX/FF Number|US DOT Number|
       |MC841455       |2439355      |

    Then Get "CurrencyIsoCode" from "rtms__TransportationProfile__c" using "Name" with value "Quality Assurance Express 2721" and Store onto "TP_Currency3"
    Then Verify Assertion for "TP_Currency3" contains "USD"

       #Step 64
    Then Go to "Compliance" Tab
    Then Wait for "2" Seconds
    #Expected ad
    Then Verify Details
      |Carrier Review Status   |Agreement Status |Agreement Date|Agreement Signed By|Highway ID|Overall Risk     |Authority Risk|Insurance Risk|
      |Rejected                |                 |              |                   |23810     |Unacceptable     |Acceptable    |Acceptable              |
        Then Verify Details
      |Safety Risk     |Operation Risk|Safety Rating|Safety Rating Date|Authority Granted Date|
      |Pending         |Unacceptable      |Unsatisfactory|11/22/2021       |10/22/2013            |
    Then Verify Details
      |Common Authority Status|Contract Authority Status|Broker Authority Status|Common Authority Pending|Common Authority Revocation|
      |Inactive                 |Inactive               |None                   |Yes                     |Yes                        |
    Then Verify Details
      |Contract Authority Pending|Contract Authority Revocation|Broker Authority Pending|Broker Authority Revocation|
      |Yes                       |No                           |Yes                     |No                         |
     #Step 65
    Then Go to "Settlement" Tab
    Then Wait for "1" Seconds
    #Expected ae
    Then Verify Details
      |Payment Processor|EPayment Authorized|
      |TriumphPay       |     |
    Then Scroll into Section "Carrier Remittance Information"
    Then Verify Details
      |Carrier Remit To                |
      |Quality Assurance Express 2721  |
    Then Verify Text displaying as "7-Day Quick Pay (ACH, Check issued on 7th Day)"

