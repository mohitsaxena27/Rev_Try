Feature:2743 - PayIQ Admin LWC- Format
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2743
  Scenario: 2743 - PayIQ Admin LWC- Format

    When Login into Salesforce

   # Step 1 & 2
   Then Open "PayIQ Programs" from App Launcher
   Then Search and Select "PayIQProgram Aggregated Load Count (Quoted Calculations)" from List
   Then Wait for "3" Seconds
    Then Capture the current URL for "PayIQ_Program_1"

  #Step 3
   Then Click on "New" button on "Roles" section
    Then Wait for "2" Seconds
   Then Update details
    | Parent Object | Lookup Type | Eligible Date Field |
    | Driver Log    | Driver      | Certified as of     |
   Then Click on "SaveEdit" button
   Then Wait for "2" Seconds
   Then Click on "Role-" with "Parent Object" as "Driver Log"
    Then Wait for "2" Seconds
   Then Set Key "Role_SFID_1" page Record Id with "rtms9__Load_Role__c"

   #Step 4
   Then Navigate to stored URL for "PayIQ_Program_1"
   Then Wait for "2" Seconds
   Then Click on "New" button on "Roles" section
   Then Update details
    | Parent Object | Lookup Type | Eligible Date Field |
    | Trip Plan Leg    | Fleet Asset      | Arrival Date     |
   Then Click on "SaveEdit" button
   Then Wait for "2" Seconds
   Then Click on "Role-" with "Parent Object" as "Trip Plan Leg"
   Then Set Key "Role_SFID_2" page Record Id with "rtms9__Load_Role__c"

    #Step 5
   Then Navigate to stored URL for "PayIQ_Program_1"
   Then Wait for "2" Seconds
   Then Click on Edit icon on Label "Status"
   Then Update details
    |Status|
    |Open|
   Then Click on "SaveEdit" button
   Then Wait for "2" Seconds
   Then Verify Details
    |Status|
    |Open|

   #Step 6
   Then Open "PayIQ Admin" from App Launcher
   Then Wait for "6" Seconds

   #Step 7 & expected a
   Then Verify Icon "standard:partner_fund_request" is displaying with background color "Teal"
   Then Verify Text displaying as "Home"
   Then Verify Text displaying as "PayIQ Admin"

   #Step 8
   Then Click on "Execute PayIQ Jobs Now" with Text
   Then Verify Message displaying as "PayIQ Jobs Triggered"
   Then Store current Time in format of "M/d/yyyy, h:mm a" on to "Current_Time"

  #Step 9
  #expected b(e)
    Then Wait till "Match Loads To PayIQ Participants" is "Completed"
    Then Wait till "Match Trip Plan Legs To PayIQ Participants" is "Completed"
    Then Wait till "Match Driver Logs To PayIQ Participants" is "Completed"
    Then Wait till "Clear Out Unapproved Pay" is "Completed"
    Then Wait till "Generate Tier Pay" is "Completed"
    Then Wait till "Generate Accessorial Pay" is "Completed"
    Then Wait till "Copy Over Pay Estimate Adjustments" is "Completed"
    Then Wait till "Generate Adjustments" is "Completed"

    #expected b(a)
   Then Verify "Job Monitor" tab is present
   Then Verify "Run History" tab is present
   Then Verify "Configuration" tab is present
   Then Verify "Logs" tab is present

    #expected b(b)
   Then Verify Text displaying as "Job Monitor" with "font-weight" as "bold"
   Then Verify Icon "standard:apex" is displaying with background color "SteelBlue"

    #expected b(c)
   Then Verify details for all Enabled fields
    | Frequency  | Time     | Frequency_2  | Time_2     |
    | Once a Day | 12:00 AM |  Once a Day | 12:00 AM |
   Then Verify "SteelBlue" Color with "White" Text of "Schedule PayIQ Jobs" Button is "Enabled"
   Then Verify "SteelBlue" Color with "White" Text of "Execute PayIQ Jobs Now" Button is "Enabled"
   Then Verify "SteelBlue" Color with "White" Text of "Schedule Delete PayIQ Logs" Button is "Enabled"
   Then Verify "SteelBlue" Color with "White" Text of "Execute Delete PayIQ Logs Now" Button is "Enabled"

     #expected b(d) & b(f)
    Then Verify "Job Name" column header is present
    Then Verify "Progress" column header is present
    Then Verify "Batches" column header is present
    Then Verify "Status" column header is present
    Then Verify "Job Name_2" column header is present
    Then Verify "Progress_2" column header is present
    Then Verify "Batches_2" column header is present
    Then Verify "Status_2" column header is present
    Then Wait till "Delete PayIQ Log" is "Not Running"

  #Step 10
  Then Go to "Run History" Tab
  #expected c(a)
    Then Verify "Job Monitor" tab is present
    Then Verify "Run History" tab is present
    Then Verify "Configuration" tab is present
    Then Verify "Logs" tab is present

  #expected c(c)
    Then Verify Icon "standard:record" is displaying with background color "Green"
    Then Verify Text displaying as "Run History" with "font-weight" as "bold"
    Then Verify "White" Color with "SteelBlue" Text of "Refresh" Button is "Enabled"

    #expected c(d)
    Then Verify Text displaying as "Match Loads To PayIQ Participants"
    Then Verify "Queued" column header is present
    Then Verify "Processed" column header is present
    Then Verify "Failures" column header is present
    Then Verify "Created" column header is present
    Then Verify "Completed" column header is present
    Then Verify "Status" column header is present
    Then Verify "Details" column header is present
    Then Click on button with Title Contains "Match Loads To PayIQ Participants"
    Then Verify Text displaying as "Match Trip Plan Legs To PayIQ Participants"
    Then Verify "Queued_2" column header is present
    Then Verify "Processed_2" column header is present
    Then Verify "Failures_2" column header is present
    Then Verify "Created_2" column header is present
    Then Verify "Completed_2" column header is present
    Then Verify "Status_2" column header is present
    Then Verify "Details_2" column header is present
    Then Click on button with Title Contains "Match Trip Plan Legs To PayIQ Participants"
    Then Verify Text displaying as "Match Driver Logs To PayIQ Participants"
    Then Verify "Queued_3" column header is present
    Then Verify "Processed_3" column header is present
    Then Verify "Failures_3" column header is present
    Then Verify "Created_3" column header is present
    Then Verify "Completed_3" column header is present
    Then Verify "Status_5" column header is present
    Then Verify "Details_3" column header is present
    Then Click on button with Title Contains "Match Driver Logs To PayIQ Participants"
    Then Verify Text displaying as "Clear Out Unapproved Pay"
    Then Verify "Queued_4" column header is present
    Then Verify "Processed_4" column header is present
    Then Verify "Failures_4" column header is present
    Then Verify "Created_4" column header is present
    Then Verify "Completed_4" column header is present
    Then Verify "Status_6" column header is present
    Then Verify "Details_4" column header is present
    Then Click on button with Title Contains "Clear Out Unapproved Pay"
    Then Verify Text displaying as "Generate Tier Pay"
    Then Verify "Queued_5" column header is present
    Then Verify "Processed_5" column header is present
    Then Verify "Failures_5" column header is present
    Then Verify "Created_5" column header is present
    Then Verify "Completed_5" column header is present
    Then Verify "Status_7" column header is present
    Then Verify "Details_5" column header is present
    Then Click on button with Title Contains "Generate Tier Pay"
    Then Verify Text displaying as "Generate Accessorial Pay"
    Then Verify "Queued_6" column header is present
    Then Verify "Processed_6" column header is present
    Then Verify "Failures_6" column header is present
    Then Verify "Created_6" column header is present
    Then Verify "Completed_6" column header is present
    Then Verify "Status_8" column header is present
    Then Verify "Details_6" column header is present
    Then Click on button with Title Contains "Generate Accessorial Pay"
    Then Verify Text displaying as "Copy Over Pay Estimate Adjustments"
    Then Verify "Queued_7" column header is present
    Then Verify "Processed_7" column header is present
    Then Verify "Failures_7" column header is present
    Then Verify "Created_7" column header is present
    Then Verify "Completed_7" column header is present
    Then Verify "Status_9" column header is present
    Then Verify "Details_7" column header is present
    Then Click on button with Title Contains "Copy Over Pay Estimate Adjustments"
    Then Verify Text displaying as "Generate Adjustments"
    Then Verify "Queued_8" column header is present
    Then Verify "Processed_8" column header is present
    Then Verify "Failures_8" column header is present
    Then Verify "Created_8" column header is present
    Then Verify "Completed_8" column header is present
    Then Verify "Status_10" column header is present
    Then Verify "Details_8" column header is present
    Then Click on button with Title Contains "Generate Adjustments"
    Then Verify Text displaying as "Delete PayIQ Log"
    Then Verify "Queued_9" column header is present
    Then Verify "Processed_9" column header is present
    Then Verify "Failures_9" column header is present
    Then Verify "Created_9" column header is present
    Then Verify "Completed_9" column header is present
    Then Verify "Status_11" column header is present
    Then Verify "Details_9" column header is present
    Then Click on button with Title Contains "Delete PayIQ Log"

    #Step 11
    Then Go to "Configuration" Tab

#    expected d(a)
    Then Verify "Job Monitor" tab is present
    Then Verify "Run History" tab is present
    Then Verify "Configuration" tab is present
    Then Verify "Logs" tab is present

  #expected d(b)
    Then Verify Icon "standard:calibration" is displaying with background color "Teal"
    Then Verify Text displaying as "Configuration" with "font-weight" as "bold"
    Then Verify "White" Color with "SteelBlue" Text of "Execute Release Update" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button is "Enabled"

    #expected d(c(i))
    Then Verify Text displaying as "Logs" with "font-weight" as "bold"
    Then Verify Text displaying as "Log Performance"
    Then Verify Text displaying as "Log Governor Limits"
    Then Verify Text displaying as "Log Qualification (met/did not meet criteria)"
    Then Verify Text displaying as "Log Math"
    Then Verify Text displaying as "Log Currency Conversions"
    Then Verify details for all Enabled fields
      | Log Performance | Log Governor Limits | Log Qualification (met/did not meet criteria) | Log Math | Log Currency Conversions |
      | False           | False               | True                                          | True     | True                     |

    #expected d(c(ii))
    Then Verify Label "Match Loads to PayIQ Participants Batch Size" is displaying with Value of "200"
    Then Verify Label "Match Trip Plan Legs to PayIQ Participants Batch Size" is displaying with Value of "200"
    Then Verify Label "Generate Tier Pay Batch Size" is displaying with Value of "200"
    Then Verify Label "Generate Accessorial Pay Batch Size" is displaying with Value of "200"
    Then Verify Label "Generate Adjustments Batch Size" is displaying with Value of "200"
    Then Verify Label "Error Email" is displaying with Value of "test@revenova.com"

    #expected d(c(iii))
    Then Verify Text displaying as "Delete Logs by Category" with "font-weight" as "bold"
    Then Verify details for all Enabled fields
      | Delete Performance Logs | Delete Governor Limits Logs | Delete Qualification Logs | Delete Math Logs | Delete Currency Conversion Logs |
      | True                    | True                        | True                      | True             | True                            |

    #expected d(c(iv))
    Then Verify Label "Delete PayIQ Logs Job Deletes Logs Older Than X Days" is displaying with Value of "0"

    #Step 12
    Then Refresh current Page
    Then Go to "Logs" Tab
    Then Click on button "Refresh"
    Then Wait for "2" Seconds

    #expected e(a)
    Then Verify "Job Monitor" tab is present
    Then Verify "Run History" tab is present
    Then Verify "Configuration" tab is present
    Then Verify "Logs" tab is present

    #expected e(b)
    Then Verify Icon "standard:display_text" is displaying with background color "Light Grey"
    Then Verify Text displaying as "Logs" with "font-weight" as "bold"
    Then Verify "White" Color with "SteelBlue" Text of "Refresh" Button is "Enabled"
    Then Verify details for all Enabled fields
      | Load | Driver Log | Trip Plan | Trip Plan Segment | Trip Plan Leg | Type     |
      |      |            |           |                   |               | --None-- |

    #expected e(c)
    Then Verify "Timestamp" column header is present
    Then Verify "Load" column header is present
    Then Verify "Driver Log" column header is present
    Then Verify "Trip Plan Leg" column header is present
    Then Verify "Detail" column header is present
    Then Verify "Type" column header is present
    Then Store the first Timestamp of PayIQ Admin log on "Timestamp"
    Then Verify if the time difference of stored "Current_Time" and "Timestamp" is within "2"
