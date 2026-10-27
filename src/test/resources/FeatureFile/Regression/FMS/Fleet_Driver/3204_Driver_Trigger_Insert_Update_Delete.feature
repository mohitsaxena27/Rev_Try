Feature: 3204-Driver Trigger Insert Update Delete

  @Regression @WEB @FMS @Fleet_Driver @3204 @Priority_1
  Scenario: 3204-Driver Trigger Insert Update Delete
    When Login into Salesforce

    #step 1 Configure Fleet Management Job 2.
    Then Open "TMS Admin" from App Launcher
    Then Wait for "2" Seconds
    Then Go to "Configuration" Tab
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob2"
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    # step 2 Create Contact 3204A on Fleet Carrier Two.
    Then Search and Select "Fleet Carrier Two" Account from the Global search
    Then Wait for "3" Seconds
    Then Go to "Contacts" Tab
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | First Name | Last Name       |
      | Test       | Contact 3204A   |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Contact \"Test Contact 3204A\" was created."

    # step 3 Create Driver 3204A.
    Then Open "Drivers" from App Launcher
    Then Wait for "3" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Driver Name       | Type     | Contact          | Confirmation Method | ELD Exempt | ELD Exempt Reason | Email              | Employment Status | Phone         |
      | Test Driver 3204A | Employee | Test Contact 3204A | None              | True       | Testing           | test3204@email.com | Terminated        | 123-789-6540 |
    Then Scroll into Section "ELD Configuration"
    Then Update details
      | Driver Ruleset Override | Cycle Override          | Restart Override | Rest Break Override                 | Jurisdiction Override |
      | True                    | USA Passenger (7/60)    | 24-Hour Restart  | Property (off-duty/sleeper)         | AL                    |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Verify Text displaying as "Test Driver 3204A"

    #step 4 Expected result a.
    Then Go to "Details" Tab
    Then Wait for "2" Seconds
    Then Scroll into Section "General Information"
    Then Verify Details
      | Status      | Confirmation Method |
      | Unavailable | Email               |
    Then Scroll into Section "ELD Configuration"
    Then Wait for "2" Seconds
    Then Verify Details
      | ELD Exempt Reason | Cycle Override       | Restart Override | Rest Break Override         | Jurisdiction Override |
      | Testing           | USA Passenger (7/60) | 24-Hour Restart  | Property (off-duty/sleeper) | AL                    |
    Then Verify Label Checkbox
      | ELD Exempt | Driver Ruleset Override |
      | true       | true                    |
    Then Get Details
      | Username | Password |
      |          |          |
    Then Verify "SysData=>Username" value is not empty
    Then Verify "SysData=>Password" value is not empty
    Then Scroll into Section "Employment / Personal Information"
    Then Wait for "2" Seconds
    Then Verify Details
      | Activation Status | Employment Status | Email              | Phone         |
      | Deactivated       | Terminated        | test3204@email.com | 123-789-6540 |

    # step 5Assign Bruce Fleet Carrier Two 2 as co-driver and verify ELD exemption clearing.
    Then Click on "Edit" button
    Then Update details
      | Co-Driver                 | ELD Exempt |
      | Bruce Fleet Carrier Two 2 | False      |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Search and Select "rtms__Driver__c" "Test Driver 3204A" from the Global search
    Then Wait for "3" Seconds
    Then Verify "ELD Exempt Reason" having not contains value of "Testing"
    #step 6
    Then Scroll into Section "ELD Configuration"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "ELD Exempt"
    Then Wait for "2" Seconds
    Then Update details
      | ELD Exempt |
      | True       |
    # Expected result b: enabling ELD Exempt does not restore the cleared reason.
    Then Verify "ELD Exempt Reason" having not contains value of "Testing"

    #step 7
    Then Click on button with Title "Cancel"
    Then Wait for "2" Seconds

    #step 8,9
    Then Click on link for label "Co-Driver"
    Then Wait for "3" Seconds
    Then Verify Text displaying as "Bruce Fleet Carrier Two 2"
    Then Go to "Details" Tab
    Then Verify Details
      | Co-Driver                 |
      | Test Driver 3204A         |
    #step 10
    Then Click on link for label "Co-Driver"
    Then Wait for "3" Seconds
    Then Verify Text displaying as "Test Driver 3204A"

    #step 11
    Then Click on "Edit" button
    Then Update details
      | Driver Ruleset Override |
      | False                    |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    # Expected result d:
    Then Verify "Cycle Override" having not contains value of "USA Passenger (7/60)"
    Then Verify "Restart Override" having not contains value of "24-Hour Restart"
    Then Verify "Rest Break Override" having not contains value of "Property (off-duty/sleeper)"
    Then Verify "Jurisdiction Override" having not contains value of "AL"
    #setp 12
    Then Click on "Edit" button
    Then Wait for "2" Seconds
    Then Update details
      | Driver Ruleset Override |
      | True                     |
    #step 13
    Then Click on button with Title "Cancel"

    #step 14
    # Create Contact 3204B.
    Then Search and Select "Fleet Carrier Two" Account from the Global search
    Then Wait for "3" Seconds
    Then Go to "Contacts" Tab
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | First Name | Last Name       | Phone         | Email               |
      | Test       | Contact 3204B   | 789-654-1230 | test3204-2@email.com |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Verify Message displaying as "Contact \"Test Contact 3204B\" was created."
    #step 15
    # Expected result e: duplicate contact association.
    Then Open "Drivers" from App Launcher
    Then Wait for "3" Seconds
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Driver Name       | Type     | Contact          |
      | Test Driver 3204A | Employee | Test Contact 3204A |
    Then Click on button with Title "Save"
    Then Wait for "2" Seconds
    Then Verify Error Message displaying as "This contact is already associated with a driver record: Test Driver 3204A"
   #step 16
    # Expected result f: duplicate driver name after selecting a new contact.
    Then Update details
      | Contact          |
      | Test Contact 3204B |
    Then Click on button with Title "Save"
    Then Wait for "2" Seconds
    Then Verify Error Message displaying as "Duplicate Driver Name is not Allowed while using Catena: Test Driver 3204A"
   #Step 17
    # Create Driver 3204B after changing the name.
    Then Update details
      | Driver Name       |
      | Test Driver 3204B |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds
    Then Verify Text displaying as "Test Driver 3204B"
   #step 18
    # Expected result g.
     Then Scroll into Section "Employment / Personal Information"
     Then Wait for "2" Seconds
     Then Verify Details
       | Email               | Phone         |
       | test3204-2@email.com | 789-654-1230 |
     #step 19
     # Update Driver 3204B and verify Contact 3204B.
    Then Click on Edit icon on Label "Email"
    Then Wait for "2" Seconds
    Then Update details
      | Email              | Phone         |
      | testupdate@email.com | 123-456-9870 |
    Then Click on button with Title "Save"
    Then Wait for "3" Seconds

    #step 20
    Then Click on link for label "Contact"
    Then Wait for "3" Seconds
    #step 21
    # Expected result h.
    Then Verify Details
      | Phone         | Email              |
      | 123-456-9870 | testupdate@email.com |