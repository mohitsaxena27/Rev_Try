 Feature: 3175 - Fleet Management Console LWC - Buttons/Actions Functionality

  @API @Regression @Smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @3175 @Catena @Motive
  Scenario: 3175 - Fleet Management Console LWC - Buttons/Actions Functionality

    When Login into Salesforce

#    # Step1
    Then Open "Fleet Management Console" from App Launcher
    Then Update details
      |Page|
      |Fleet Management|
    Then Wait for "2" Seconds

    # Step 2 Expected result a
    Then Click on button with Title "Send Driver Message"
    Then Verify Text displaying as "Send Driver Message" -

    # Step 3
    Then Click on "Cancel" Button with Type "button"

    # Step 4  Expected result b
    Then Click on button with Title "Driver Assignment"
    Then Verify Text displaying as "Driver Assignment" -

    # Step 5
    Then Click on "Cancel" Button with Type "button"

    # Step 6 Expected result c
    Then Update details
      |Page|
      |Trip Planning|
    Then Wait for "2" Seconds
    Then Click on button with Title "Plan Freight"
    Then Verify Text displaying as "Freight Plan" -

    # step 7
    Then Click button with Text "Done" on Modal
#    Then Click on "Close" icon for close modal

    # Step 8 Expected result d
    Then Click on button with Title "Plan Trip"
    Then Verify Text displaying as "Plan Trip" -
    Then Click on button "Close" on Trip Plan

    # Step 9 Expected result e
    Then Click on button with Title "Trip Plan Templates"
    Then Verify Text displaying as "Trip Plan Templates" -

    # Step 10
    And Click on Native "Close" icon

    # Step 11 Expected result f
    Then Update details
      |Page|
      |Equipment Management|
    Then Wait for "2" Seconds
    Then Click on button with Title "Trip Plans"
    Then Verify Text displaying as "Active Trip Plans" -

    # Step 12 Expected result g
    And Click on Native "Close" icon
    Then Click on button with Title "Spot Equipment"
    Then Wait for "6" Seconds
    Then Verify Message displaying as "Warning - Fleet Management Console No record selected"

    # Step 13 Expected result h
    Then Wait for "3" Seconds
    Then Scroll into Section "Equipment Pool"
    Then Select radio button for "Illinois Terminal - Pool"
    Then Click on button with Title "Spot Equipment"
    Then Wait for "5" Seconds

    # Step 14
    Then Click on "Cancel" Button with Type "button"
    Then Wait for "5" Seconds

    # Step 15  Expected result i
    Then Verify button is present with "View Manager"

    # Step 16 Expected result j
    Then Wait for "5" Seconds
    Then Click on button with Title "Chatter Feed"
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Chatter Feed" -

#    #Step 17 Expected result k
#    Then Click on button with Title "Refresh"
#    Then Scroll into Section "Equipment Pool"
#    Then Verify "Illinois Terminal - Pool" is not selected
#
#    #Step 18 Expected result l
#    Then Verify button is not clickable with "Chatter Feed"
#    Then Verify Text not displaying as "Chatter Feed"
