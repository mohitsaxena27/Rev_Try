Feature: 2191 - Account Trigger-Create Transportation Profile Records/Sync TMS Type Fields JMR

  @Regression @TMS @Smoke @API @WEB @SingleCurrency @Customer_Invoice @Account @2191
  Scenario: 2191 - Account Trigger-Create Transportation Profile Records/Sync TMS Type Fields JMR

    When Login into Salesforce
    #-----------------------------------------------------
    #Step1
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
    |Account Name|
    |Valuable Vendor Service|
    Then Select "TMS Type" as "Vendor" from Dueling List -
    #Step 2
    Then Click on "SaveEdit" button
    #Expected Result a
    Then Verify Message displaying as "Account \"Valuable Vendor Service\" was created."


    Then Verify details for
    |Transportation Profile|TMS Type|TMS Type for Sharing|
    |Valuable Vendor Service|Vendor|Vendor             |
    Then Set Key "AccRecord" page Record Id with "Account"

    #Step 3
    Then Click on "Transportation Profile" Link Text "Valuable Vendor Service" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result b
    Then Verify details for
      |Record Type|
      |Vendor     |

    #Step 4
    Then Click on "Delete" button
    Then Wait for "1" Seconds
    Then Click on Native "Delete" icon -
    Then Verify Message displaying as "Transportation Profile \"Valuable Vendor Service\" was deleted."

    #Step 5
    Then Click on "Edit" button
    Then Verify Heading Text "h2" with text "Edit Valuable Vendor Service"
    Then Select "TMS Type" as "Carrier (Ground)" from Dueling List -
    #Step 6
    Then Click on "SaveEdit" button
    #Expected Result c
    Then Verify Message displaying as "Account \"Valuable Vendor Service\" was saved."
    Then Verify details for
      |Transportation Profile  |TMS Type                |TMS Type for Sharing      |
      |Valuable Vendor Service|Carrier (Ground);Vendor |Carrier (Ground);Vendor   |
    #Step 7
    Then Click on "Transportation Profile" Link Text "Valuable Vendor Service" on Page
    Then Go to "System" Tab on Transportation Profile Page
  
    #Expected Result d
    Then Verify details for
      |Record Type          |
      |Carrier (Ground)     |
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"

    #-----------------------------------
    #Step8
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 1|
    Then Select "TMS Type" as "Agent" from Dueling List -
    #Step 9
    Then Click on "SaveEdit" button
    #Expected Result e
    Then Verify Message displaying as "Account \"TMS Type Testing Account 1\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 1|Agent|Agent             |
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step 10
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 1" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result f
    Then Verify details for
      |Record Type      |
      |Shipper/Consignee|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"

     #-----------------------------------------------------
    #Step11
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 2|
    Then Select "TMS Type" as "Airport" from Dueling List -
    #Step12
    Then Click on "SaveEdit" button
    #Expected Result g
    Then Verify Message displaying as "Account \"TMS Type Testing Account 2\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 2|Airport|Airport|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step13
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 2" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result h
    Then Verify details for
      |Record Type      |
      |Shipper/Consignee|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step14
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 3|
    Then Select "TMS Type" as "Border Crossing" from Dueling List -
    #Step15
    Then Click on "SaveEdit" button
    #Expected Result i
    Then Verify Message displaying as "Account \"TMS Type Testing Account 3\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 3|Border Crossing|Border Crossing|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step16
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 3" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result j
    Then Verify details for
      |Record Type      |
      |Shipper/Consignee|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step17
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 4|
    Then Select "TMS Type" as "Customs Port" from Dueling List -
    #Step18
    Then Click on "SaveEdit" button
    #Expected Result k
    Then Verify Message displaying as "Account \"TMS Type Testing Account 4\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 4|Customs Port|Customs Port|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step19
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 4" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result l
    Then Verify details for
      |Record Type|
      |Customs Port|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step20
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 5|
    Then Select "TMS Type" as "Carrier (Air)" from Dueling List -
    #Step21
    Then Click on "SaveEdit" button
    #Expected Result m
    Then Verify Message displaying as "Account \"TMS Type Testing Account 5\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 5|Carrier (Air)|Carrier (Air)|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step22
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 5" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result n
    Then Verify details for
      |Record Type|
      |Carrier (Air)|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step23
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 6|
    Then Select "TMS Type" as "Carrier (Ocean)" from Dueling List -
    #Step24
    Then Click on "SaveEdit" button
    #Expected Result o
    Then Verify Message displaying as "Account \"TMS Type Testing Account 6\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 6|Carrier (Ocean)|Carrier (Ocean)|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step25
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 6" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result p
    Then Verify details for
      |Record Type|
      |Carrier (Ocean)|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step26
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 7|
    Then Select "TMS Type" as "Carrier (Rail)" from Dueling List -
    #Step27
    Then Click on "SaveEdit" button
    #Expected Result q
    Then Verify Message displaying as "Account \"TMS Type Testing Account 7\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 7|Carrier (Rail)|Carrier (Rail)|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step28
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 7" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result r
    Then Verify details for
      |Record Type|
      |Carrier (Rail)|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step29
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 8|
    Then Select "TMS Type" as "Customer" from Dueling List -
    #Step30
    Then Click on "SaveEdit" button
    #Expected Result s
    Then Verify Message displaying as "Account \"TMS Type Testing Account 8\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 8|Customer|Customer|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step31
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 8" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result t
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step32
    Then Open "Accounts" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 9|
    Then Select "TMS Type" as "Customs Broker" from Dueling List -
    #Step33
    Then Click on "SaveEdit" button
    #Expected Result u
    Then Verify Message displaying as "Account \"TMS Type Testing Account 9\" was created."
    #Step34 and Expected Result v
    Then Verify details for
      |Transportation Profile  |TMS Type|TMS Type for Sharing|
      |NA                      |Customs Broker|Customs Broker|
    Then Set Key "AccRecord" page Record Id with "Account"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step35
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 10|
    Then Select "TMS Type" as "Distribution Center" from Dueling List -
    #Step36
    Then Click on "SaveEdit" button
    #Expected Result w
    Then Verify Message displaying as "Account \"TMS Type Testing Account 10\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 10|Distribution Center|Distribution Center|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step37
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 10" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result x
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step38
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 11|
    Then Select "TMS Type" as "Factoring Company" from Dueling List -
    #Step39
    Then Click on "SaveEdit" button
    #Expected Result y
    Then Verify Message displaying as "Account \"TMS Type Testing Account 11\" was created."
    #Step40 and Expected Result z
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |NA                      |Factoring Company|Factoring Company|
    Then Set Key "AccRecord" page Record Id with "Account"

    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step41
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 12|
    Then Select "TMS Type" as "Prospect" from Dueling List -
    #Step42
    Then Click on "SaveEdit" button
    #Expected Result aa
    Then Verify Message displaying as "Account \"TMS Type Testing Account 12\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 12|Prospect|Prospect|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step43
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 12" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result ab
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step44
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 13|
    Then Select "TMS Type" as "Rail Terminal" from Dueling List -
    #Step45
    Then Click on "SaveEdit" button
    #Expected Result ac
    Then Verify Message displaying as "Account \"TMS Type Testing Account 13\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 13|Rail Terminal|Rail Terminal|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step46
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 13" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result ad
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"

    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step47
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 14|
    Then Select "TMS Type" as "Seaport" from Dueling List -
    #Step48
    Then Click on "SaveEdit" button
    #Expected Result ae
    Then Verify Message displaying as "Account \"TMS Type Testing Account 14\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 14|Seaport|Seaport|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step49
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 14" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result af
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|

    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step50
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 15|
    Then Select "TMS Type" as "Seaport Terminal" from Dueling List -
    #Step51
    Then Click on "SaveEdit" button
    #Expected Result ag
    Then Verify Message displaying as "Account \"TMS Type Testing Account 15\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 15|Seaport Terminal|Seaport Terminal|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step52
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 15" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result ah
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|

    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step53
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 16|
    Then Select "TMS Type" as "Shipper/Consignee" from Dueling List -
    #Step54
    Then Click on "SaveEdit" button
    #Expected Result ai
    Then Verify Message displaying as "Account \"TMS Type Testing Account 16\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 16|Shipper/Consignee|Shipper/Consignee|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step55
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 16" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result aj
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|

    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step56
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 17|
    Then Select "TMS Type" as "Terminal" from Dueling List -
    #Step57
    Then Click on "SaveEdit" button
    #Expected Result ak
    Then Verify Message displaying as "Account \"TMS Type Testing Account 17\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 17|Terminal|Terminal|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step58
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 17" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result al
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|

    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step59
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 18|
    Then Select "TMS Type" as "Warehouse" from Dueling List -
    #Step60
    Then Click on "SaveEdit" button
    #Expected Result am
    Then Verify Message displaying as "Account \"TMS Type Testing Account 18\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 18|Warehouse|Warehouse|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step61
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 18" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result an
    Then Verify details for
      |Record Type|
      |Shipper/Consignee|

    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"

     #-----------------------------------------------------

   #Step62
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 19|
    Then Select "TMS Type" as "Waypoint" from Dueling List -
    #Step63
    Then Click on "SaveEdit" button
    #Expected Result ao
    Then Verify Message displaying as "Account \"TMS Type Testing Account 19\" was created."
    Then Verify details for
      |Transportation Profile|TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 19|Waypoint|Waypoint|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step64
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 19" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result ap
    Then Verify details for
      |Record Type|
      |Shipper/Consignee   |

    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"
     #-----------------------------------------------------

    #Step65
    Then Open "Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      |Account Name|
      |TMS Type Testing Account 20|
    Then Select "TMS Type" as "Carrier (Ground)" from Dueling List -
    #Step66
    Then Click on "SaveEdit" button
    #Expected Result aq
    Then Verify Message displaying as "Account \"TMS Type Testing Account 20\" was created."
    Then Verify details for
      |Transportation Profile     |TMS Type|TMS Type for Sharing|
      |TMS Type Testing Account 20|Carrier (Ground)|Carrier (Ground)|
    Then Set Key "AccRecord" page Record Id with "Account"
    #Step67
    Then Click on "Transportation Profile" Link Text "TMS Type Testing Account 20" on Page
    Then Go to "System" Tab on Transportation Profile Page
    #Expected Result ar
    Then Verify details for
      |Record Type|
      |Carrier (Ground)|
    Then Set Key "TPRecord" page Record Id with "rtms__TransportationProfile__c"
    Then Delete "rtms__TransportationProfile__c" with Id "TPRecord"
    Then Delete "Account" with Id "AccRecord"






