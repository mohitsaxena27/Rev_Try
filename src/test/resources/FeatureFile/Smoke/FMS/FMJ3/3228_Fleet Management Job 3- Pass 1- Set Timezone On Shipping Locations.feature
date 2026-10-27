Feature: 3228 - Fleet Management Job 3- Pass 1- Set Timezone On Shipping Locations

  @API @Regression @Smoke @WEB @FMS @Fleet_Management_Job @SingleCurrency  @3228
  Scenario: 3228 - Fleet Management Job 3- Pass 1- Set Timezone On Shipping Locations

    When Login into Salesforce

     #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    Then Update details -
       | Timezone Update Disabled |
       | true                     |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    
    #Step 2
    Then Search and Select "Port of Rotterdam" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on button "Save"
    Then Wait for "3" Seconds
    Then Verify Details
      | Timezone |
      | NA       |
    Then Search and Select "Timely Terminal" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on button "Save"
    Then Wait for "3" Seconds
    Then Verify Details
      | Timezone |
      | NA       |

    #Step 3
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Wait for "6" Seconds

    #Step 4
    Then Search and Select "Timely Terminal" Account from the Global search
    #Expected a
    Then Scroll into Section "Address Information"
    Then Verify Details
      | Timezone  |
      |           |

    #Step 5
    Then Delete "FleetManagementJob3" job
    
     #Step6
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    Then Update details -
       | Timezone Update Disabled |
       | False                     |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #Step 7
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    Then Wait for "40" Seconds
    #Step8
    Then Search and Select "Timely Terminal" Account from the Global search
    #Expected b
    Then Scroll into Section "Address Information"
    Then Verify Details
      | Timezone        |
      | America/Chicago |

    #Step 9
    Then Search and Select "Port of Rotterdam" Account from the Global search
    #Expected c
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |
