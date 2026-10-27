Feature: 2737 - Carrier Monitor Highway Job- Event Parser: Get New Alerts

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2737 @HighWay_API
  Scenario: 2737 - Carrier Monitor Highway Job- Event Parser: Get New Alerts

    When Login into Salesforce
    Then Delete All Records with name "QA Trans LLC 2737" for "rtms__CarrierService__c"
    Then Delete All Records with name "QA Trans LLC 2737" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "QA Trans LLC 2737" for "Account"

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Allow Carrier Address Updates |
      | True                          |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

  # Step2
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

    #Step 3, 4 & 5
    Then Get "HighwayEventParser_OnboardingPacket_QA_Trans_LLC2737.txt" files and update below Attributes
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
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

    #Step 6
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "10" Seconds

    #Step 7
    Then Delete "QueuedTransactionJob" job

    #Step 8,9 & 10
    Then Get "HighwayEventParser_NewAlert_QA_Trans_LLC2737.txt" files and update below Attributes
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
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

   #Step 11
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "10" Seconds

    #Step 12
    Then Search and Select "QA Trans LLC 2737" Account from the Global search
    Then Wait for "2" Seconds
    #Expected Result a
    Then Verify Details
         |Account Name     |DBA Name             |TMS Type|
         |QA Trans LLC 2737|QA TRANNN-Updated DBA|Carrier (Ground)|
    #Step 13 & Expected Result b
    Then Verify Details
         |Transportation Profile|
         |QA Trans LLC 2737- Updated Name|

    #Step 14
    Then Click on "Transportation Profile" Link Text "QA Trans LLC 2737- Updated Name" on Page
    Then Wait for "2" Seconds
    #Step 15 & Expected Result c
     Then Scroll into Section "Lane Coverage and Preferences"
     Then Get Details
          |Cargo Carried|
          |             |
    Then Verify Assertion for "Cargo Carried" contains "Building Materials;Machinery"
    Then Verify Assertion for "Cargo Carried" contains "Building Materials;Machinery"
    Then Verify Assertion for "Cargo Carried" contains "Coils"
    Then Verify Assertion for "Cargo Carried" contains "Rolls;Water-Well"

    Then Verify Details
        |Fleet Size|Total Power Units|MC/MX/FF Number|State DOT Number|US DOT Number|
        |150       |12               |MC454669       |                |1136469      |

    #Step 16
    Then Go to "Compliance" Tab
    Then Wait for "2" Seconds
    #Expected d
    Then Verify Details
         |Carrier Review Status |Highway ID|Overall Risk     |Authority Risk|Insurance Risk|
         |Rejected              |23837     |Unacceptable     |Acceptable    |Acceptable              |
    Then Verify Details
         |Safety Risk     |Operation Risk|Safety Rating|Safety Rating Date|Authority Granted Date|
         |Unacceptable    |Moderate      |Unsatisfactory|                 |6/12/2025             |
    Then Verify Details
         |Common Authority Status|Contract Authority Status|Broker Authority Status|Common Authority Pending|Common Authority Revocation|
         |Inactive               |Inactive                 |None                   |Yes                     |Yes                        |
    Then Verify Details
         |Contract Authority Pending|Contract Authority Revocation|Broker Authority Pending|Broker Authority Revocation|
         |Yes                       |No                           |Yes                     |No                         |

     #Step 17
    Then Scroll Until Related List for "Insurance Policies"
    Then Scroll into Section "Insurance Policies"
    Then Wait for "2" Seconds
   #Expected e
     Then Verify No Records with "Type" equal to "Auto"
     Then Verify No Records with "Type" equal to "Cargo"
     Then Verify No Records with "Type" equal to "Contingent Cargo"

   #Step 18
#    Then Click on "337457CE36E1007D11A878D2A5BC705B" with Text
    Then Click on Partial Link Text "337457CE36E1007D11A878D2A5BC705B" on Page
    Then Wait for "5" Seconds
   #Step 19
    Then Scroll into Section "Policy Information"
    #Expected f
    Then Verify Details
         |Transportation Profile           |Insurance Company             |Type            |Source |Policy Number|
         |QA Trans LLC 2737- Updated Name |STEWART TITLE GUARANTY COMPANY|General         |Highway|337457CE36E1007D11A878D2A5BC705B|
    Then Verify Details
         |Description|Country      |Coverage Amount              |Effective Date|Expiry Date|
         |           |United States|1,000,000.00 (USD 746,268.66)|12/20/2022    |1/1/2032   |
    Then Verify Label Checkbox
      |Cross Border Insurance Policy    |
      |false   |
    Then Verify Details
         |Cancel Date|Deductible |Reefer Breakdown Coverage|Reefer Breakdown Deductible|
         |           |           |                         |                           |
    Then Verify Details
         |Agent First Name|Agent Last Name|Agent Title|Agent Email|Agent Phone|Fax|
         |                |               |           |           |(713) 625-8044||
    Then Verify Details
         |Agent Company|Address                |City   |State/Province|Postal Code|Phone|
         |             |1360 POST OAK BOULEVARD|HOUSTON|TX       |77056         |(713) 625-8044|
  #Step 20
    Then Navigate Browser Back
    Then Wait for "1" Seconds
  #Step 21
  #  Then Click on "CB83BB66830B66C67058C80BBEFB49A7" with Text
    Then Click on Partial Link Text "CB83BB66830B66C67058C80BBEFB49A7" on Page
    Then Scroll into Section "Policy Information"
    #Expected g
    Then Verify Details
      |Transportation Profile           |Insurance Company                    |Type                |Source |Policy Number|
      |QA Trans LLC 2737- Updated Name  |NATIONAL INTERSTATE INSURANCE COMPANY|Workers Compensation|Highway|CB83BB66830B66C67058C80BBEFB49A7|
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