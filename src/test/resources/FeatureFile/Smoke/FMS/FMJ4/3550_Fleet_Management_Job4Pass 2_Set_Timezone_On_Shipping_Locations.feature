Feature: 3550 - Fleet Management Job 4- Pass 2- Set Timezone On Shipping Locations

#  @API @Regression @smoke @WEB @FMS @SingleCurrency @Fleet_Management_Job @3550 @Catena @Motive
  Scenario: 3550 - Fleet Management Job 4- Pass 2- Set Timezone On Shipping Locations

    When Login into Salesforce

    #Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Samsara" in the "Search Credentials..." search box
    Then Select the "Samsara" record from the lookup field results
    Then Update details
      | Enabled |
      | false   |
    And Click on Native "Save" button

    #Step2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    #Step 2.a)
    Then Select Fleet Management Job as "FleetManagementJob4"
    #Step 2.b)
    Then Update details -
      | Timezone Update Disabled |
      | true                     |
    #Step 2.c)
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #Step 3
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "4" Seconds

    #Step 4
    Then Search and Select "Canada Border Services Agency" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    #Step 4.a) and #Step 6
    Then Update details
      | Timezone | Shipping State/Province |
      | --None-- | --None--                |
    Then Click on button "Save"
    Then Wait for "2" Seconds
    Then Verify details for
      | Timezone |
      | NA       |

    #Step 4.b) and #Step 7
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

    #Step 4.c)
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

    #Step 4.d)
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

    #Step 4.e)
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

    #Step 4.f)
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

    #Step 4.g)
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

    #Step 4.h)
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

    #Step 4.i) and #Step 8
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

    #Step 4.j) and #Step 5
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

    #Step 9 & 10
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "10" Seconds

    #Step 11
    Then Wait for Email to Receive On Email

    #Expected Result a
    Then Verify Content "The job cannot update timezones until the Timezone Update Disabled field is unchecked.  You must also make sure ALL accounts can be updated by the batch process so the Timezone field can be set." in the email body with Subject "Sandbox: Fleet Management Error"
    Then Reset Time to get New Email

    #Step 12
    Then Search and Select "Timely Terminal" Account from the Global search
    Then Scroll into Section "Address Information"
    Then Click on Edit icon on Label "Timezone"
    # Expected Result b
    Then Verify details for
      | Timezone |
      | NA       |

    #Step 13
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Update details -
      | Timezone Update Disabled |
      | false                    |
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

    #Step 14
    Then Refresh current Page
    Then Wait for "2" Seconds

    #Step 15 & 16
    Then Go to Home Page
    Then Run "FleetManagementJob4" Job
    Then Wait for "4" Seconds

    Then Run "FleetManagementJob4" Job
    Then Wait for "4" Seconds

    #Step 17
    Then Wait for Email to Receive On Email

    #Expected Result c
    Then Verify Content "setTimezone() for: Wichita Eisenhower National Airport" in the email with Subject "Fleet Management Error"
    Then Verify Content "FleetManagementEventHandler2.setTimezone() for: Wichita Eisenhower National Airport:" in the email with Subject "Fleet Management Error"
    Then Verify Content "Argument cannot be null." in the email with Subject "Fleet Management Error"

    #Step 18.a)
    Then Search and Select "Canada Border Services Agency" Account from the Global search

    #Expected d)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |

    #Step 18.b)
    Then Search and Select "John Deere Parts Distribution Center" Account from the Global search
    #Expected e)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |

    #Step 18.c)
    Then Search and Select "Manzanillo Port" Account from the Global search
    #Expected f)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone            |
      | America/Mexico_City |

    #Step 18.d)
    Then Search and Select "North Platte Union Pacific Rail Yard" Account from the Global search
    #Expected g)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Chicago |

    #Step 18.e)
    Then Search and Select "Outta Time Warehouse" Account from the Global search
    #Expected h)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Chicago |

    #Step 18.f)
    Then Search and Select "Port of Rotterdam" Account from the Global search
    #Expected i)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |

    #Step 18.g)
    Then Search and Select "Timed Waypoint" Account from the Global search
    #Expected j)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Phoenix |

    #Step 18.h)
    Then Search and Select "Timely Terminal" Account from the Global search
    #Expected k)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Chicago |

    #Step 18.i)
    Then Search and Select "Timezone Trucking" Account from the Global search
    #Expected l)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone        |
      | America/Phoenix |

    #Step 18.j)
    Then Search and Select "Wichita Eisenhower National Airport" Account from the Global search
    #Expected m)
    Then Scroll into Section "Address Information"
    Then Verify details for
      | Timezone |
      | Unknown  |