Feature: 2524 - Fleet Trip Planner LWC - Driver Confirmation Button Visibility

  @Regression @WEB @FMS @SingleCurrency @Fleet_Trip_Planner @2524 @Priority_1
  Scenario: 2524 - Fleet Trip Planner LWC - Driver Confirmation Button Visibility

    When Login into Salesforce

    # Step 1,2
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page          |
      | Trip Planning |
    Then Wait for "4" Seconds

    # Step 3
    Then Click on button with Title "Plan Trip"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Plan Trip - New Trip Plan" -

    # Step 4
    Then Update "1" Segment details
      | Search       | Driver                  |
      | Tractor 1001 | Dave Fleet Carrier One 1 |
    Then Wait for "2" Seconds

    # Step 5
    Then Update "1" leg details
      | Start Type | Location             | Due Out Date | Due Out Time |
      | Location   | Arizona Diamondbacks | 1            | 5:00 AM      |
    Then Update "1" leg details
      | End Type | Location_2       | Appointment Date |
      | Location | Arizona Cardinals | 2                |

    # Step 6
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    # Expected Result a
    Then Verify Button with Title displaying as "Confirm Driver" -

    # Step 7
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Accepted                   |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    # Expected Result b
    Then Verify Button with Title not displaying as "Confirm Driver" -

    # Step 8,9
    Then Clear "Driver" field on "1" Segment
    Then Update "1" Segment details
      | Driver Confirmation Status |
      | Pending                    |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    # Expected Result c
    Then Verify Button with Title not displaying as "Confirm Driver" -

    # Step 10,11
    Then Update "1" Segment details
      | Driver                  |
      | Dave Fleet Carrier One 1 |
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds

    # Step 12
    Then Click on "Add Leg Below" on "1" Leg
    Then Wait for "2" Seconds
    # Expected Result d
    Then Verify Button with Title displaying as "Confirm Driver" -
    Then Verify Button with Title "Confirm Driver" is disabled