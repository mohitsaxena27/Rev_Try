Feature: 2739 - TMS Admin Configuration- Allow Carrier Address Updates (Highway API)

  @API @Regression @TMS @Smoke @WEB @API_Operation @SingleCurrency @2739 @HighWay_API
  Scenario: 2739 - TMS Admin Configuration- Allow Carrier Address Updates (Highway API)

    When Login into Salesforce
    Then Delete All Records with name "QA Trans LLC 2739" for "rtms__CarrierService__c"
    Then Delete All Records with name "QA Trans LLC 2739" for "rtms__TransportationProfile__c"
    Then Delete All Records with name "QA Trans LLC 2739" for "Account"

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Allow Carrier Address Updates |
      | False                         |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "5" Seconds

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

# Step 3,4,5
    Then Get "HighwayEventParser_OnboardingPacket_QA_Trans_LLC2739.txt" files and update below Attributes
      | No Update Required |
      | No Update Required |
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      | Processor      | Direction | Status  | Content Type     |
      | HighwayInbound | Inbound   | Pending | application/json |
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds


# Step 6
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "10" Seconds

# Step 7
    Then Delete "QueuedTransactionJob" job

# Step 8,9,10
    Then Get "HighwayEventParser_NewAlert_QA_Trans_LLC2739.txt" files and update below Attributes
      | No Update Required |
      | No Update Required |
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      | Processor      | Direction | Status  | Content Type     |
      | HighwayInbound | Inbound   | Pending | application/json |
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

# Step 11
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "10" Seconds

# Step 12 Expected Result A
    Then Search and Select "QA Trans LLC 2739" Account from the Global search
    Then Go to "Details" Tab
    Then Scroll into Section "Address Information"
    Then Verify Details
      | Shipping Address                                              | Billing Address                                 |
      | 820 S MONACO PKWY\n213\nDENVER, Colorado 80224\nUnited States | 500 Main\nDENVER, Colorado 80224\nUnited States |
# Step 13
    Then Delete "QueuedTransactionJob" job

# Step 14
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Allow Carrier Address Updates |
      | True                          |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "5" Seconds
# Step 15,16,17
    Then Get "HighwayEventParser_NewAlert_QA_Trans_LLC2739.txt" files and update below Attributes
      | No Update Required |
      | No Update Required |
    Then Open "Queued Transactions" from App Launcher
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details -
      | Processor      | Direction | Status  | Content Type     |
      | HighwayInbound | Inbound   | Pending | application/json |
    Then Click on "Payload 1" TextArea
    Then Enter Label "Payload 1" TextArea with "SysData=>{FinalUpdatedText}"
    Then Update details
      | Payload 2 |
      |           |
    Then Wait for "2" Seconds
    Then Click on "SaveEdit" button
    Then Wait for "3" Seconds

# Step 18
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "10" Seconds

# Step 19 Expected Result B
    Then Search and Select "QA Trans LLC 2739" Account from the Global search
    Then Go to "Details" Tab
    Then Scroll into Section "Address Information"
    Then Go to "Details" Tab
    Then Verify Details
      | Shipping Address                                        | Billing Address                                   |
      | 914 JILL MARIE LN\nFERNLEY, Nevada 89408\nUnited States | 1741 ART CT\nFERNLEY, Nevada 89408\nUnited States |
