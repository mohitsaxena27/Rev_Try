Feature:2773 - PayIQ Admin LWC - Schedule Delete PayIQ Logs
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2773
  Scenario: 2773 - PayIQ Admin LWC - Schedule Delete PayIQ Logs

    When Login into Salesforce

   # Step1
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "2" Seconds

   # Step2 and Expected result a
    Then Update details
    |Frequency_2|Time_2|
    |Once a Day|12:00 AM|
    Then Click on "Schedule Delete PayIQ Logs" with Text
    Then Verify Message displaying as "Success Delete PayIQ Logs Scheduled Once a Day starting at 12:00 AM"

 #Step 3 and Expected result b
   Then Convert "1" "12:00 AM" into browser timezone and store on "Tomorrow12AM"
    Then Set "actualScheduleMessage" with "Next Scheduled Delete PayIQ Logs Run: " and "SysData=>Tomorrow12AM"
    Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"
    Then Capture the current URL for "PayIQAdmin"

    #Step 4
    Then Set Page url for "-setup.com/lightning/setup/ScheduledJobs/home" into "ScheduledJob"
    Then Navigate to stored URL for "ScheduledJob"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Click on "D" with Text -
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Set "TomorrowDate" with "Date(M/d/yyyy)=>1"
    Then Set "ActualScheduleDate" with "SysData=>TomorrowDate" and ", 12:00 AM"
    #Expected c
    Then Verify Scheduled Job for "Delete PayIQ Log" displaying as "SysData=>ActualScheduleDate"

   #Step 5
    Then Navigate to stored URL for "PayIQAdmin"
    Then Wait for "2" Seconds
    Then Store last 15 minute interval time on "Past15MinIntervalTime"
    # Step 6
    Then Update details
      |Frequency_2                 |Time_2|
      |Twice a Day (every 12 hours)|SysData=>Past15MinIntervalTime|
    Then Wait for "2" Seconds
    Then Click on "Schedule Delete PayIQ Logs" with Text
    Then Set "Message" with "Delete PayIQ Logs Scheduled Twice a Day (every 12 hours) starting at " and "SysData=>Past15MinIntervalTime"
    #Expected d
    Then Verify Message displaying as "SysData=>Message"

    #Step 7
    Then Add 12 hours to "SysData=>Past15MinIntervalTime" and convert into browser timezone and store on "Next12HoursTime"
    Then Set "actualScheduleMessage" with "Next Scheduled Delete PayIQ Logs Run: " and "SysData=>Next12HoursTime"
    #Expected e
    Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"

     #Step 8
    Then Set Page url for "-setup.com/lightning/setup/ScheduledJobs/home" into "ScheduledJob"
    Then Navigate to stored URL for "ScheduledJob"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Click on "D" with Text -
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Add 12 hours to "SysData=>Past15MinIntervalTime" and store on "Next12Hours"
    #Expected c
    Then Verify Scheduled Job for "Delete PayIQ Log" displaying as "SysData=>Next12Hours"

   #Step 9
    Then Navigate to stored URL for "PayIQAdmin"
    Then Wait for "2" Seconds
    Then Store next 15 minute interval time on "Next15MinIntervalTime"
    # Step 10
    Then Update details
      |Frequency_2                 |Time_2|
      |Thrice a Day (every 8 hours)|SysData=>Next15MinIntervalTime|
    Then Wait for "2" Seconds
    Then Click on "Schedule Delete PayIQ Logs" with Text
    Then Set "Message" with "Delete PayIQ Logs Scheduled Thrice a Day (every 8 hours) starting at " and "SysData=>Next15MinIntervalTime"
    #Expected g
    Then Verify Message displaying as "SysData=>Message"

    #Step 11
    Then Add 0 hours to "SysData=>Next15MinIntervalTime" and convert into browser timezone and store on "Next15MinTime"
    Then Set "actualScheduleMessage" with "Next Scheduled Delete PayIQ Logs Run: " and "SysData=>Next15MinTime"
    #Expected h
    Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"

     #Step 12
    Then Set Page url for "-setup.com/lightning/setup/ScheduledJobs/home" into "ScheduledJob"
    Then Navigate to stored URL for "ScheduledJob"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Click on "D" with Text -
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Add 0 hours to "SysData=>Next15MinIntervalTime" and store on "Next15Mins"
    #Expected i
    Then Verify Scheduled Job for "Delete PayIQ Log" displaying as "SysData=>Next15Mins"
     #Step 13
    Then Wait till time "SysData=>Next15MinIntervalTime" is over
    Then Wait for "60" Seconds
    #Step 14
    Then Navigate to stored URL for "PayIQAdmin"
    Then Wait for "2" Seconds
    #Step 15 & Expected Result j
    Then Add 8 hours to "SysData=>Next15MinIntervalTime" and convert into browser timezone and store on "Next8HoursTime"
    Then Set "actualScheduleMessage" with "Next Scheduled Delete PayIQ Logs Run: " and "SysData=>Next8HoursTime"
    #Expected j
    Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"
