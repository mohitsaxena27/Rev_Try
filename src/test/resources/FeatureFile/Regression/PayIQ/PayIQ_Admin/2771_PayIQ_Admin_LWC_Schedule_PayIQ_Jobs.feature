Feature:2771 - PayIQ Admin LWC - Schedule PayIQ Jobs
  
  @API @Regression @PayIQ  @WEB @SingleCurrency @2771
  Scenario: 2771 - PayIQ Admin LWC - Schedule PayIQ Jobs

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
    Then Wait for "2" Seconds

   #Step 5 and Expected result a
    Then Update details
     | Frequency  | Time     |
     | Once a Day | 12:00 AM |
    Then Click on "Schedule PayIQ Jobs" with Text
    Then Verify Message displaying as "Success PayIQ Jobs Scheduled Once a Day starting at 12:00 AM"

   #Step 6 and Expected result b
   Then Convert "1" "12:00 AM" into browser timezone and store on "Tomorrow12AM"
    Then Set "actualScheduleMessage" with "Next Scheduled PayIQ Jobs Run: " and "SysData=>Tomorrow12AM"
    Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"
    Then Capture the current URL for "PayIQAdmin"

    #Step 7
    Then Set Page url for "-setup.com/lightning/setup/ScheduledJobs/home" into "ScheduledJob"
    Then Navigate to stored URL for "ScheduledJob"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Click on "M" with Text -
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Set "TomorrowDate" with "Date(M/d/yyyy)=>1"
    Then Set "ActualScheduleDate" with "SysData=>TomorrowDate" and ", 12:00 AM"

    #Expected c
    Then Verify Scheduled Job for "Match Loads To PayIQ Participants" displaying as "SysData=>ActualScheduleDate"

    #Step 8
    Then Navigate to stored URL for "PayIQAdmin"
    Then Wait for "2" Seconds
    Then Store last 15 minute interval time on "Past15MinIntervalTime"

    # Step 9
    Then Update details
     | Frequency                    | Time                           |
     | Twice a Day (every 12 hours) | SysData=>Past15MinIntervalTime |
    Then Wait for "15" Seconds
    Then Set "Message" with "PayIQ Jobs Scheduled Twice a Day (every 12 hours) starting at " and "SysData=>Past15MinIntervalTime"
    Then Click on "Schedule PayIQ Jobs" with Text

    #Expected d
    Then Verify Message displaying as "SysData=>Message"

    #Step 10
    Then Add 12 hours to "SysData=>Past15MinIntervalTime" and convert into browser timezone and store on "Next12HoursTime"
    Then Set "actualScheduleMessage" with "Next Scheduled PayIQ Jobs Run: " and "SysData=>Next12HoursTime"
#    Expected e
    Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"

     #Step 11
    Then Set Page url for "-setup.com/lightning/setup/ScheduledJobs/home" into "ScheduledJob"
    Then Navigate to stored URL for "ScheduledJob"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Click on "M" with Text -
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -

    Then Add 12 hours to "SysData=>Past15MinIntervalTime" and store on "Next12Hours"
    #Expected f
    Then Verify Scheduled Job for "Match Loads To PayIQ Participants" displaying as "SysData=>Next12Hours"

   #Step 12
    Then Navigate to stored URL for "PayIQAdmin"
    Then Wait for "2" Seconds
    Then Store next 15 minute interval time on "Next15MinIntervalTime"

    # Step 13
    Then Update details
     | Frequency                    | Time                           |
     | Thrice a Day (every 8 hours) | SysData=>Next15MinIntervalTime |
    Then Wait for "2" Seconds
    Then Click on "Schedule PayIQ Jobs" with Text
    Then Set "Message" with "PayIQ Jobs Scheduled Thrice a Day (every 8 hours) starting at " and "SysData=>Next15MinIntervalTime"
    #Expected g
    Then Verify Message displaying as "SysData=>Message"

    #Step 14
    Then Add 0 hours to "SysData=>Next15MinIntervalTime" and convert into browser timezone and store on "Next15MinTime"
    Then Set "actualScheduleMessage" with "Next Scheduled PayIQ Jobs Run: " and "SysData=>Next15MinTime"
    #Expected h
    Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"

     #Step 15
    Then Set Page url for "-setup.com/lightning/setup/ScheduledJobs/home" into "ScheduledJob"
    Then Navigate to stored URL for "ScheduledJob"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Click on "M" with Text -
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
    Then Add 0 hours to "SysData=>Next15MinIntervalTime" and store on "Next15Mins"
    #Expected i
    Then Verify Scheduled Job for "Match Loads To PayIQ Participants" displaying as "SysData=>Next15Mins"

     #Step 16
    Then Wait till time "SysData=>Next15MinIntervalTime" is over
    Then Wait for "60" Seconds

    #Step 17
    Then Navigate to stored URL for "PayIQAdmin"
    Then Wait for "2" Seconds

    #Step 18
    Then Add 8 hours to "SysData=>Next15MinIntervalTime" and convert into browser timezone and store on "Next8HoursTime"
    Then Set "actualScheduleMessage" with "Next Scheduled PayIQ Jobs Run: " and "SysData=>Next8HoursTime"
    #Expected j
    Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"

    #Step 19 & 20
   Then Open "Setup" from Setup Icon
   Then Switch Window by index "1"
   Then Wait for "1" Seconds
   Then Set URL with "-setup.com/lightning/setup/ManageUsers/home" and store into "Manage User URL"
   Then Navigate to stored URL for "Manage User URL"
   Then Switch to Frame by Title "All"
   Then Click on "U" with Text -
   Then Switch to Parent Frame
   Then Wait for "5" Seconds
   Then Switch to Frame by Title "All"
   Then Wait for "5" Seconds
   Then Click on "User, User" with Text -
   Then Switch to Parent Frame
   Then Switch to Frame by Title "User: User User ~ Salesforce - Enterprise Edition"
   Then Capture the current URL for "User_setup"
   Then Click on "edit" button -
   Then Switch to Parent Frame
   Then Switch to Frame by Title "User Edit"
   Then Scroll down with "15" Times
   Then Select "(GMT-04:00) Eastern Daylight Time (America/New_York)" with Id "TimeZoneSidKey" -
   Then Click on button with Title "Save" -
   Then Switch to Parent Frame
   Then Wait for "3" Seconds
   Then Close Current Tab
   Then Switch to Parent Window

   #Step 21 & 22
   Then Navigate to stored URL for "PayIQAdmin"
   Then Wait for "2" Seconds
   Then Update details
    |Frequency|Time|
    |Once a Day|12:00 AM|
   Then Click on "Schedule PayIQ Jobs" with Text
   Then Verify Message displaying as "Success PayIQ Jobs Scheduled Once a Day starting at 12:00 AM"

    #Step 23 & expected k
   Then Convert "1" "12:00 AM" from timezone "America/New_York" into browser timezone and store on "Tomorrow12AM"
   Then Set "actualScheduleMessage" with "Next Scheduled PayIQ Jobs Run: " and "SysData=>Tomorrow12AM"
   Then Verify Normalized Text displaying as "SysData=>actualScheduleMessage"

    #Step 24 & expected i
   Then Set Page url for "-setup.com/lightning/setup/ScheduledJobs/home" into "ScheduledJob"
   Then Navigate to stored URL for "ScheduledJob"
   Then Wait for "2" Seconds
   Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
   Then Click on "M" with Text -
   Then Wait for "2" Seconds
   Then Switch to Frame by Title "All Scheduled Jobs ~ Salesforce - Enterprise Edition" -
   Then Set "TomorrowDate" with "Date(M/d/yyyy)=>1"
   Then Set "ActualScheduleDate" with "SysData=>TomorrowDate" and ", 12:00 AM"
    #Expected c
   Then Verify Scheduled Job for "Match Loads To PayIQ Participants" displaying as "SysData=>ActualScheduleDate"

   #Step 25 & 26
   Then Navigate to stored URL for "PayIQ_Program_1"
   Then Click on Edit icon on Label "Status"
   Then Update details
    |Status|
    |Pending|
   Then Click on "SaveEdit" button
   Then Wait for "2" Seconds
   Then Verify Details
    |Status|
    |Pending|

   #Step 27
   Then Open "PayIQ Admin" from App Launcher
   Then Wait for "6" Seconds

   #Step 28 & expected m
   Then Click on "Schedule PayIQ Jobs" with Text
   Then Verify Error Message displaying as "Could not schedule PayIQ Jobs!"