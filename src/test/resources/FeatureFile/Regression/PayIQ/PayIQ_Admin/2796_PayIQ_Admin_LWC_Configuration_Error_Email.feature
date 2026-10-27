Feature:2796 - PayIQ Admin LWC - Configuration - Error Email
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2796
  Scenario: 2796 - PayIQ Admin LWC - Configuration - Error Email

    When Login into Salesforce

   # Step1
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds

  #Step2
   Then Go to "Configuration" Tab
   Then Update details
   |Error Email|
   |          |
   Then Wait for "2" Seconds
   Then Click on button "Save"
   Then Verify Error Message displaying as "Could not save PayIQ Configuration!"
    Then Scroll into Section "Error Email"
   Then Verify Message displaying with "Complete this field."
  #Extra added
    Then Go to "Configuration" Tab
    Then Update details
      |Error Email|
      |pavana.s@saksoft.com|
    Then Wait for "2" Seconds
    Then Click on button "Save"
    Then Verify Message displaying as "PayIQ Configuration Saved"
    Then Refresh current Page
    Then Wait for "2" Seconds
   #Step 3
    Then Go to "Configuration" Tab
    Then Update details
      |Error Email|
      |@email.com |
    Then Wait for "2" Seconds
    Then Click on button "Save"
   Then Verify Error Message displaying as "Could not save PayIQ Configuration!"
    Then Scroll into Section "Error Email"
    Then Click on Label "Error Email"
    Then Click on Label "Generate Adjustments Batch Size"
   Then Verify Message displaying with "Enter a valid email address, such as name@email.com."

   #Step 4
   Then Go to "Configuration" Tab
   Then Update details
    |Error Email|
    |pavana.s@saksoft.com|
    Then Wait for "2" Seconds
   Then Click on button "Save"
   Then Verify Message displaying as "PayIQ Configuration Saved"

   #Step 5,6
   Then Scroll down with "5" Times
   Then Verify Label "Error Email" is displaying with Value of "pavana.s@saksoft.com"

   #Step 7
   Then Update details
    |Error Email|
    |pavana.s@saksoft.com,test@revenova.com|
   Then Click on button "Save"
   Then Verify Error Message displaying as "Could not save PayIQ Configuration!"
    Then Click on Label "Error Email"
    Then Click on Label "Generate Adjustments Batch Size"
   Then Verify Message displaying with "Enter a valid email address, such as name@email.com."

