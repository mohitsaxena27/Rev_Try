Feature:2783 - PayIQ Admin LWC - Configuration - Delete Logs Older than X Days

#  @API @Regression  @SingleCurrency @2783
  Scenario: 2783 - PayIQ Admin LWC - Configuration - Delete Logs Older than X Days

    When Login into Salesforce
     #Step1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List

      #Step 2 & 3
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
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds

    #Step 5
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 6 & 7
    Then Go to "Logs" Tab
    Then Click on button "Refresh"
    Then Verify Timestamp date is "Current Date"
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "Current_Time"
    #Step 8 Expected a
    Then Go to "Configuration" Tab
    Then Wait for "2" Seconds
    Then Update details
      | Delete PayIQ Logs Job Deletes Logs Older Than X Days |
      |                                                      |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Verify Error Message displaying as "Could not save PayIQ Configuration!"
    Then Verify Text displaying as "Complete this field."
    Then Wait for "2" Seconds
    Then Close Error "Could not save PayIQ Configuration!" message
    Then Wait for "1" Seconds
    #Step 9 Expected b
    Then Update details
      | Delete PayIQ Logs Job Deletes Logs Older Than X Days |
      | -1                                                   |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Verify Error Message displaying as "Could not save PayIQ Configuration!"
    Then Verify Text displaying as "Complete this field."
    Then Wait for "2" Seconds
    Then Close Error "Could not save PayIQ Configuration!" message
    Then Wait for "1" Seconds

    #Step 10 Expected c
    Then Update details
      | Delete PayIQ Logs Job Deletes Logs Older Than X Days |
      | 1                                                    |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Verify Message displaying as "PayIQ Configuration Saved"
    Then Wait for "2" Seconds

    #Step 11
    Then Go to "Job Monitor" Tab
    Then Wait for "2" Seconds
    Then Click on "Execute Delete PayIQ Logs Now" with Text
    Then Verify Message displaying as "Delete PayIQ Logs Triggered"
    Then Wait till "Delete PayIQ Log" is "Completed"
    Then Wait for "2" Seconds

    #Step 12
    Then Go to "Logs" Tab
    Then Click on button "Refresh"
    Then Wait for "3" Seconds

    #Expected Result d - Logs still rendered in table (logs < 1 day old, not deleted)
    Then Verify Timestamp date is "Current Date"

    #Step 13 & 14
    Then Wait for "86500" Seconds
      #Leave the logs in the system and return in 24 hours after the time noted in Step 7(a)
  #query on 13 step
    Then Login into Salesforce
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "6" Seconds
  #Step 15
    Then Go to "Configuration" Tab
    Then Wait for "2" Seconds
    Then Update details
      | Delete PayIQ Logs Job Deletes Logs Older Than X Days |
      | 2                                                    |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Verify Message displaying as "PayIQ Configuration Saved"
    Then Wait for "2" Seconds

    # Step 16
    Then Go to "Job Monitor" Tab
    Then Wait for "2" Seconds
    Then Click on "Execute Delete PayIQ Logs Now" with Text
    Then Verify Message displaying as "Delete PayIQ Logs Triggered"
    Then Wait till "Delete PayIQ Log" is "Completed"
    Then Wait for "2" Seconds

    # Step 17 Expected e
    Then Go to "Logs" Tab
    Then Click on button "Refresh"
    Then Wait for "3" Seconds
    Then Verify Timestamp date is "Current Date"

    #Step 18
    Then Go to "Configuration" Tab
    Then Wait for "2" Seconds
    Then Update details
      | Delete PayIQ Logs Job Deletes Logs Older Than X Days |
      | 1                                                    |
    Then Click on "Save" with Text
    Then Wait for "2" Seconds
    Then Verify Message displaying as "PayIQ Configuration Saved"
    Then Wait for "2" Seconds


    #Step 19
    Then Go to "Job Monitor" Tab
    Then Wait for "2" Seconds
    Then Click on "Execute Delete PayIQ Logs Now" with Text
    Then Verify Message displaying as "Delete PayIQ Logs Triggered"
    Then Wait till "Delete PayIQ Log" is "Completed"
    Then Wait for "2" Seconds

    #Step 20 Expected f
    Then Go to "Logs" Tab
    Then Click on button "Refresh"
    Then Verify Text not displaying as "PayIQ Program not open"











































































































