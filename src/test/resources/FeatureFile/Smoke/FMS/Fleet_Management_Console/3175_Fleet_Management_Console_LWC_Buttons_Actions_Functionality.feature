Feature: 3175 - Fleet Management Console LWC - Buttons/Actions Functionality


  @Regression @Smoke  @WEB @FMS @SingleCurrency @Fleet_Management_Console @3175
  Scenario: 3175 - Fleet Management Console LWC - Buttons/Actions Functionality

    When Login into Salesforce
    #Step 1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "4" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "2" Seconds

    #Step 2
    Then Click on button with Title "Send Driver Message"
    #Expected a
    Then Verify LWC Heading displaying as "Send Driver Message"
    #Step 3
    Then Click button with Text "Cancel" on Modal

    #Step 4
    Then Click on button with Title "Driver Assignment"
    #Expected b
    Then Verify LWC Heading displaying as "Driver Assignment"
    #Step 5
    Then Click button with Text "Cancel" on Modal

    #Step 6
    Then Update details
      | Page                 |
      | Trip Planning        |
    Then Wait for "3" Seconds
    Then Zoom Current Screen by "60"
    Then Click on button with Title "Plan Freight"
    #Expected c
    Then Verify LWC Heading displaying as "Freight Plan Console"
    #Step 7
    Then Click on X to close LWC
    Then Zoom Current Screen by "100"

     #Step 8
    Then Click on button with Title "Plan Trip"
    #Expected d
    Then Verify LWC Heading displaying as "Plan Trip - New Trip Plan"
    #Step 9
    Then Click on button "Close" on Trip Plan
    Then Wait for "2" Seconds
    Then Click on button with Title "Trip Plan Templates"

    Then Verify LWC Heading displaying as "Trip Plan Templates"
    #Step 10
    Then Click button with Text "Close" on Modal
    Then Wait for "2" Seconds
   #Step 11
    Then Update details
      | Page                 |
      | Equipment Management |
    Then Wait for "3" Seconds
    Then Click on button with Title "Trip Plans"
    #Expected f
    Then Verify LWC Heading displaying as "Active Trip Plans"
    #Step 12
    Then Click button with Text "Close" on Modal
    Then Wait for "3" Seconds
    Then Click on button with Title "Spot Equipment"
    #Expected g
    Then Verify Message displaying with "Warning - Fleet Management Console"
    Then Verify Message displaying with "No record selected"

     #Step 13
    Then Select Records for "Illinois Terminal" on Fleet Equipment Page
    Then Wait for "2" Seconds
    Then Click on button with Title "Spot Equipment"
    Then Wait for "2" Seconds
    #Expected h
    Then Verify LWC Heading displaying as "Spot Equipment - Illinois Terminal - Illinois Terminal - Pool"
    #Step 14
    Then Click button with Text "Cancel" on Modal
    Then Wait for "2" Seconds
    #Step 15
    Then Click on button with Title "View Manager"
    Then Wait for "1" Seconds
    #Expected i
    Then Verify Text displaying as "View Manager"

    #Step 16
    Then Click on button with Title "Chatter Feed"
    Then Wait for "3" Seconds
    #Expected j
    Then Verify Text displaying as "Chatter Feed - Illinois Terminal - Pool"

    #Step 17
    Then Click on button with Title "Refresh"
    Then Wait for "3" Seconds
    #Expected k
    Then Fleet Equipment : Verify Records "Illinois Terminal" Radio button not Selected
      #Step 18 #Expected l
    Then Verify Button with Title "Chatter Feed" is disabled
    Then Verify Text not displaying as "Chatter Feed - Illinois Terminal - Pool"
