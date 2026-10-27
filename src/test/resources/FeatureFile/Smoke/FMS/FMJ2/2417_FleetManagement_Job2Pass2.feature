Feature: 2417 - Fleet Management Job 2- Pass 2- Set Timezone On Shipping Locations

   #  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @Catena @Motive @2417
  Scenario: 2417 - Fleet Management Job 2- Pass 2- Set Timezone On Shipping Locations

    When Login into Salesforce

    #Step 1,2,3,4 & 5
    Then Search and Select "Canada Border Services Agency" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone | Shipping State/Province |
      | --None-- | --None--                |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "John Deere Parts Distribution Center" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone | Shipping City |
      | --None-- |               |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "Manzanillo Port" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "North Platte Union Pacific Rail Yard" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "Outta Time Warehouse" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "Port of Rotterdam" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "Timed Waypoint" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "Timely Terminal" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone |
      | --None-- |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "Timezone Trucking" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone | Shipping Street |
      | --None-- |                 |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    Then Search and Select "Wichita Eisenhower National Airport" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    Then Update details
      | Timezone | Shipping Country |
      | --None-- | --None--         |
    Then Click on button "Save"
    Then Verify details for
      | Timezone |
      | NA       |

    #Step6
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |

    #Step7
    And Click on Native "Save" button

    #Step8
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob2"
    Then Update details -
      | Fleet Management Pass Counter | Timezone Update Disabled |
      | 1                             | true                     |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step9 & 10
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step11
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Fleet Management Pass Counter |
      | 2                             |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step12 & 13
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    #Step 14
    Then Wait for Email to Receive On Email

    #Expected a)
    Then Verify Content "The job cannot update timezones until the Timezone Update Disabled field is unchecked.  You must also make sure ALL accounts can be updated by the batch process so the Timezone field can be set." in the email with Subject "Fleet Management Job 2"
    Then Reset Time to get New Email

    #Step15
    Then Search and Select "Timely Terminal" Account from the Global search
    Then Scroll into Section "Address Information"
    #Expected b)
    Then Verify details for
      | Timezone |
      | NA       |

    #Step16 & 17
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob2"
    Then Update details -
      | Fleet Management Pass Counter | Timezone Update Disabled |
      | 2                             | false                    |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step18
    Then Go to Home Page
    Then Run "FleetManagementJob2" Job
    Then Wait for "6" Seconds

    Then Wait for Email to Receive On Email

    #Expected c)
    Then Wait for Email to Receive On Email
    Then Verify Content "setTimezone() error for: Wichita Eisenhower National Airport" in the email with Subject "Fleet Management Job 2"
    Then Reset Time to get New Email

    #Step19
    Then Search and Select "Canada Border Services Agency" Account from the Global search
    #Expected d)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |

    #Step20
    Then Search and Select "John Deere Parts Distribution Center" Account from the Global search
    #Expected e)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |

    #Step21
    Then Search and Select "Manzanillo Port" Account from the Global search
    #Expected f)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone            |
      | America/Mexico_City |

    #Step22
    Then Search and Select "North Platte Union Pacific Rail Yard" Account from the Global search
    #Expected g)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Chicago |

    #Step23
    Then Search and Select "Outta Time Warehouse" Account from the Global search
    #Expected h)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Chicago |

    #Step24
    Then Search and Select "Port of Rotterdam" Account from the Global search
    #Expected i)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |

    #Step25
    Then Search and Select "Timed Waypoint" Account from the Global search
    #Expected j)
    Then Scroll into Section "Address Information"
        Then Verify details for
      | Timezone        |
      | America/Phoenix |

    #Step26
    Then Search and Select "Timely Terminal" Account from the Global search
    #Expected k)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Chicago |

    #Step27
    Then Search and Select "Timezone Trucking" Account from the Global search
    #Expected l)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Phoenix |

    #Step24
    Then Search and Select "Wichita Eisenhower National Airport" Account from the Global search
    #Expected m)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |