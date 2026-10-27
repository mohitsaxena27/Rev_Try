Feature:2772 - PayIQ Admin LWC - Configuration - Logs
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2772
  Scenario: 2772 - PayIQ Admin LWC - Configuration - Logs

    When Login into Salesforce

   # Step1
   Then Open "PayIQ Programs" from App Launcher
   Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

#    #Step 2 & 3
   Then Click on Edit icon on Label "Status"
   Then Update details
    |Status|
    |Open|
   Then Click on "SaveEdit" button
   Then Wait for "2" Seconds
   Then Verify Details
    |Status|
    |Open|
   Then Capture the current URL for "PayIQ_Program_1"

    #Step 4
   Then Open "Fleet Management" from App Launcher
   Then Search and Select "Contact" "Joe Revenova PayIQ" from the Global search

    #Step 5
   Then Go to "Details" Tab
    Then Scroll into Section "System Information"
    Then Click on Edit icon on Label "Contact Currency"
   Then Update details
    | Contact Currency      |
    | CAD - Canadian Dollar |
   Then Click on "SaveEdit" button
   Then Wait for "2" Seconds
   Then Verify Details
    | Contact Currency      |
    | CAD - Canadian Dollar |

   #Step 6
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds

   #Step 7
   Then Go to "Configuration" Tab
    Then Capture the current URL for "Admin_Config"
   Then Update details
    | Log Performance | Log Governor Limits | Log Qualification (met/did not meet criteria) | Log Math | Log Currency Conversions |
    | False           | False               | True                                          | True     | True                     |
   Then Click on button "Save"
   Then Verify Message displaying with "PayIQ Configuration Saved"

   #Step 8
   Then Go to "Job Monitor" Tab
   Then Click on "Execute PayIQ Jobs Now" with Text
   Then Verify Message displaying as "PayIQ Jobs Triggered"
   Then Wait till "Generate Adjustments" is "Completed"

   #Step 9 & expected a
   Then Go to "Logs" Tab
   Then Update details
    | Type          |
    | Qualification |
   Then Click on button "Refresh"
   Then Wait for "2" Seconds
    Then Verify PayIQ Admin log Type column "has" "Qualification"

    #Step 10 & expected b
    Then Go to "Logs" Tab
    Then Update details
      | Type |
      | Math |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify PayIQ Admin log Type column "has" "Math"

    #Step 11 & expected c
    Then Go to "Logs" Tab
    Then Update details
      | Type                |
      | Currency Conversion |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify PayIQ Admin log Type column "has" "Currency Conversion"

    #Step 12
    Then Go to "Logs" Tab
    Then Update details
      | Type     |
      | --None-- |

    #Step 13
    Then Go to "Job Monitor" Tab
    Then Click on "Execute Delete PayIQ Logs Now" with Text
    Then Verify Message displaying as "Delete PayIQ Logs Triggered"

    #Step 14
    Then Go to "Configuration" Tab
    Then Update details
      | Log Performance | Log Governor Limits | Log Qualification (met/did not meet criteria) | Log Math | Log Currency Conversions |
      | False           | False               | True                                          | True     | False                     |
    Then Click on button "Save"
    Then Verify Message displaying with "PayIQ Configuration Saved"

    #Step 15
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

   #Step 16 & expected d
    Then Go to "Logs" Tab
    Then Update details
      | Type          |
      | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify PayIQ Admin log Type column "has" "Qualification"

    #Step 17 & expected e
    Then Go to "Logs" Tab
    Then Update details
      | Type |
      | Math |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify PayIQ Admin log Type column "has" "Math"

    #Step 18 & expected f
    Then Go to "Logs" Tab
    Then Update details
      | Type                |
      | Currency Conversion |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify PayIQ Admin log Type column "does not have" "Currency Conversion"

    #Step 19
    Then Go to "Logs" Tab
    Then Update details
      | Type     |
      | --None-- |

    #Step 20
    Then Go to "Job Monitor" Tab
    Then Click on "Execute Delete PayIQ Logs Now" with Text
    Then Verify Message displaying as "Delete PayIQ Logs Triggered"

    #Step 21
    Then Go to "Configuration" Tab
    Then Update details
      | Log Performance | Log Governor Limits | Log Qualification (met/did not meet criteria) | Log Math | Log Currency Conversions |
      | False           | False               | True                                          | False     | False                     |
    Then Click on button "Save"
    Then Verify Message displaying with "PayIQ Configuration Saved"

    #Step 22
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

   #Step 23 & expected g
    Then Go to "Logs" Tab
    Then Update details
      | Type          |
      | Qualification |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify PayIQ Admin log Type column "has" "Qualification"

    #Step 24 & expected h
    Then Go to "Logs" Tab
    Then Update details
      | Type |
      | Math |
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify PayIQ Admin log Type column "does not have" "Math"

    #Step 25
    Then Go to "Logs" Tab
    Then Update details
      | Type     |
      | --None-- |

    #Step 26
    Then Go to "Job Monitor" Tab
    Then Click on "Execute Delete PayIQ Logs Now" with Text
    Then Verify Message displaying as "Delete PayIQ Logs Triggered"

    #Step 27
    Then Go to "Configuration" Tab
    Then Update details
      | Log Performance | Log Governor Limits | Log Qualification (met/did not meet criteria) | Log Math | Log Currency Conversions |
      | False           | False               | False                                          | False     | False                     |
    Then Click on button "Save"
    Then Verify Message displaying with "PayIQ Configuration Saved"

    #Step 28
    Then Go to "Job Monitor" Tab
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 29
    Then Go to "Logs" Tab
    Then Update details
      | Type     |
      | --None-- |

    #Step 30 & expected i
    Then Click on button "Refresh"
    Then Wait for "2" Seconds
    Then Verify Text not displaying as "PayIQ Program not open"