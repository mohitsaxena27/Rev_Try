Feature: 2740 - Carrier Monitor Highway Job- Event Parser: Get Carrier Sync

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2740 @HighWay_API
  Scenario: 2740 - Carrier Monitor Highway Job- Event Parser: Get Carrier Sync

    When Login into Salesforce
    Then Delete All Records with name "QA Shipment LLC 2740" for "rtms__CarrierService__c"
    Then Delete All Records with name "QA Shipment LLC 2740" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "QA Shipment LLC 2740" for "Account"

  # Step1
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

    #Step 2, 3 & 4
    Then Get "HighwayEventParser_OnboardingPacket_QA_ShipmentLLC2740.txt" files and update below Attributes
         |No Update Required|
         |No Update Required|
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |
      |HighwayInbound    |Inbound  |Pending|application/json|
    Then Wait for "2" Seconds
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 5
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "2" Seconds

    #Step 6
    Then Delete "QueuedTransactionJob" job

    #Step 7, 8 & 9
    Then Get "HighwayEventParser_CarrierSync_QA_Shipment_LLC2740.txt" files and update below Attributes
      |No Update Required|
      |No Update Required|
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      |Processor         |Direction|Status |Content Type    |
      |HighwayInbound    |Inbound  |Pending|application/json|
    Then Wait for "2" Seconds
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

   #Step 10
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "2" Seconds

    #Step 11
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "QA Shipment LLC 2740" from List
    Then Scroll into Section "US Registration"
    #Expected a
    Then Verify Details
         |MC/MX/FF Number|US DOT Number|
         |MC841444      |2439344     |

    #Step 12
    Then Go to "Compliance" Tab
    Then Wait for "2" Seconds
    #Expected b
    Then Verify Details
         |Carrier Review Status |Highway ID|Overall Risk|Authority Risk|Insurance Risk|
         |Approved              |23840     |Pending     |Acceptable    |Acceptable              |
    Then Verify Details
         |Safety Risk|Operation Risk|Connection Status|FMCSA Insurance Cancellation Date|FMCSA Insurance Cancellation Type|
         |Pending    |Moderate      |Verified         |                                 |                                 |

   #Step 13
    Then Scroll Until Related List for "Insurance Policies"
    Then Scroll into Section "Insurance Policies"
    Then Wait for "2" Seconds
   #Expected c
     Then Verify No Records with "Type" equal to "Auto"
     Then Verify No Records with "Type" equal to "Cargo"
   #Step 14
     Then Click on "36AB2860AB8538A78D91C4D75B2D13A2" with Text
   #Step 15
    Then Scroll into Section "Policy Information"
    #Expected d
    Then Verify Details
         |Transportation Profile|Insurance Company             |Type            |Source |Policy Number|
         |QA Shipment LLC 2740  |STEWART TITLE GUARANTY COMPANY|Contingent Cargo|Highway|36AB2860AB8538A78D91C4D75B2D13A2|
    Then Verify Details
         |Description|Country      |Coverage Amount |Effective Date|Expiry Date|
         |           |United States|USD 1,000,000.00|12/20/2022    |1/1/2032   |
    Then Verify Label Checkbox
      |Cross Border Insurance Policy    |
      |false   |
    Then Verify Details
         |Cancel Date|Deductible |Reefer Breakdown Coverage|Reefer Breakdown Deductible|
         |1/1/2035   |           |                         |                           |
    Then Verify Details
         |Agent First Name|Agent Last Name|Agent Title|Agent Email|Agent Phone|Fax|
         |                |               |           |           |(713) 625-8044||
    Then Verify Details
         |Agent Company|Address                |City   |State/Province|Postal Code|Phone|
         |             |1360 POST OAK BOULEVARD|HOUSTON|TX       |77056         |(713) 625-8044|
  #Step 16
    Then Navigate Browser Back
    Then Wait for "1" Seconds
  #Step 17
    Then Click on "73D58002D2D76DD7C8E09E3AD73BAAF6" with Text
    Then Scroll into Section "Policy Information"
    #Expected e
    Then Verify Details
      |Transportation Profile|Insurance Company                    |Type                |Source |Policy Number|
      |QA Shipment LLC 2740  |NATIONAL INTERSTATE INSURANCE COMPANY|Workers Compensation|Highway|73D58002D2D76DD7C8E09E3AD73BAAF6|
    Then Verify Details
      |Description|Country      |Coverage Amount |Effective Date|Expiry Date|
      |           |United States|USD 1,000,000.00|9/1/2022    |1/1/2032   |
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
      |Agent Company|Address                |City     |State/Province|Postal Code|Phone|
      |             |3250 INTERSTATE DRIVE  |RICHFIELD|OH       |44286         |(330) 659-8900|