Feature: 2089 - Job Monitor LWC- Run Now Action

  @Regression @TMS @Smoke @WEB @Admin @SingleCurrency  @Job_Run @2089
  Scenario: 2089 - Job Monitor LWC- Run Now Action

    When Login into Salesforce
    Then Wait for "2" Seconds
    Then Delete All Scheduled Job


    # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      |Enforce Customer Credit Limits |IFTA Mileage Reporting Enabled|
      |True                           |True                          |
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob"
    Then Update details -
      | Fleet Management Pass Counter |
      |                               |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    #Step 2
    Then Go to Home Page
    Then Run "ARCalculationJob" Job
    #Expected Result a
    Then Verify "ARCalculationJob" Details
         |Status                      |Previous Run Time|Total Batches|Batches Processed|Batch Errors|
         |Not Running or Scheduled!   |0                |Integer     |Integer         |Integer    |

    #Step 3#Expected Result b
    Then Click on dropdown chevron & Verify dropdown Action Option for "BanyanJob" - "Run Now" is greyed out and unactionable
    #Step 4
    Then Run "CarrierEngagementAutomationJob" Job
     #Expected Result c
    Then Verify "CarrierEngagementAutomationJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |15           |Integer     |Integer           |Integer    |
    #Step 5
    Then Run "CustomerInvoiceGenerationJob" Job
     #Expected Result d
    Then Verify "CustomerInvoiceGenerationJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |08:00        |Integer     |Integer           |Integer    |
    #Step 6
    Then Run "CarrierMonitorRMISJob" Job
     #Expected Result e
    Then Verify "CarrierMonitorRMISJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |15           |Integer     |Integer           |Integer    |

    #Step 7
    Then Run "DataCleanupJob" Job
    #Expected Result f
    Then Verify "DataCleanupJob" Details
         |Status                      |Previous Run Time|Total Batches|Batches Processed|Batch Errors|
         |Not Running or Scheduled!   |0                |Integer     |Integer         |Integer    |

    #Step 8#Expected Result g
    Then Click on dropdown chevron & Verify dropdown Action Option for "EDIJob" - "Run Now" is greyed out and unactionable

     #Step 9
    Then Run "EDIWatcherJob" Job
     #Expected Result h
    Then Verify "EDIWatcherJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |60           |Integer     |Integer           |Integer    |
    Then Verify "EDIJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |30           |Integer     |Integer           |Integer    |

      #Step 10
#    Then Run "FleetManagementJob" Job
#     #Expected Result i
#    Then Verify "FleetManagementJob" Details
#      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
#      |Scheduled                  |0                |15           |Integer     |Integer           |Integer    |

    #Step 10
    Then Run "FreightPlanManagementJob" Job
    #Expected Result j
    Then Verify "FreightPlanManagementJob" Details
      |Status                      |Previous Run Time|Total Batches|Batches Processed|Batch Errors|
      |Not Running or Scheduled!   |0                |Integer     |Integer         |Integer    |

    #Step 11
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "EFS" in the "Search Credentials..." search box
    Then Select the "EFS" record from the lookup field results
    And Update details for "EFS" service
      | Fuel Cards |
      | True   |
    And Click on Native "Save" button
    Then Wait for "4" Seconds

    #Step 12
    Then Go to Home Page
    Then Click on Run Now for "FuelCardJob"
    Then Wait for "2" Seconds
    Then Verify Text displaying as "Fuel Card Transactions Settings"
    #Expected Result k
    Then Verify Legend details
         |Start Time, Date|Start Time, Time|End Time, Date|End Time, Time|
         |                |                 |              |                |
    Then Update Legend details
         |Start Time, Date|
         |0               |
    Then Store current Chicago Time in format of "h:mm a" on to "CurrentTime"
    Then Wait for "3" Seconds
    #Expected Result l
    Then Verify Legend details
         |Start Time, Time|
         |SysData=>CurrentTime|
    Then Update Legend details
      |Start Time, Time|End Time, Date|End Time, Time|
      |1:00 AM         |7             |1:00 AM       |
    Then Click button with Text "Start" on Modal
    #Expected m
    Then Verify Message displaying with Text "The time range cannot exceed 6 days."
    Then Update Legend details
     |End Time, Date|
     |4             |
    Then Verify Legend details
      |Start Time, Time|
      |1:00 AM         |
    Then Click button with Text "Start" on Modal

    Then Wait for "10" Seconds
    #Expected n
    Then Verify Text not displaying as "Fuel Card Transactions Settings"
    Then Wait for "20" Seconds
    Then Refresh current Page
    Then Verify "FuelCardJob" Details
      |Status                      |
      |Not Running or Scheduled!   |

    #Step 13
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "Cleo" in the "Search Credentials..." search box
    Then Select the "EFS" record from the lookup field results
    And Update details for "EFS" service
      | Fuel Cards |
      | False   |
    And Click on Native "Save" button
    Then Wait for "4" Seconds

    #Step 14
    Then Go to Home Page
    #Expected o
    Then Click on dropdown chevron & Verify dropdown Action Option for "FuelSurchargeUpdateJob" - "Run Now" is greyed out and unactionable

     #Step 15
    Then Run "FuelIndexUpdateJob" Job
     #Expected Result p
    Then Verify "FuelIndexUpdateJob" Details
      |Status                     |Previous Run Time|Total Batches|Batches Processed|Batch Errors|
      |Not Running or Scheduled!  |0                |Integer     |Integer           |Integer    |
    Then Verify "FuelSurchargeUpdateJob" Details
      |Status                     |Previous Run Time|Total Batches|Batches Processed|Batch Errors|
      |Not Running or Scheduled!  |0                |Integer     |Integer           |Integer    |

   #Step 16 & Expected Result Q
    Then Run "IFTAStateReportJob" Job
    #Step 17 & #Expected Result r
    Then Verify "IFTAStateReportJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |1>12:00 AM   |Integer      |Integer           |Integer    |

    #Step 18
    Then Run "LoadAndTruckPostingManagementJob" Job
     #Expected Result s
    Then Verify "LoadAndTruckPostingManagementJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |30           |Integer      |Integer           |Integer    |

    # Step 19
    Then Delete "LoadAndTruckPostingManagementJob" job
    Then Wait for "2" Seconds

    #Step 20
    Then Run "LoadAndTruckPostingManagementJob2" Job
    #Expected Result t
    Then Verify "LoadAndTruckPostingManagementJob2" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |15           |Integer      |Integer           |Integer    |

    #Step 21
    Then Run "LoadDexDataUploadJob" Job
    #Expected Result u
    Then Verify "LoadDexDataUploadJob" Details
      |Status                      |Previous Run Time|Total Batches|Batches Processed|Batch Errors|
      |Not Running or Scheduled!   |0                |Integer     |Integer         |Integer    |

    #Step 22
    Then Run "LoadStatusUpdateJob" Job
    #Expected Result v
    Then Verify "LoadStatusUpdateJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |60   |Integer      |Integer           |Integer    |
    #Expected Result w
    Then Wait for "30" Seconds
    Then Refresh current Page
    Then Wait for "5" Seconds
    Then Verify "BanyanJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |60   |Integer      |Integer           |Integer    |

    #Step 23
    Then Run "QueuedTransactionJob" Job
    #Expected Result x
    Then Verify "QueuedTransactionJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |1   |Integer      |Integer           |Integer    |

    #Step 24
    Then Run "SMC3EVAJob" Job
    #Expected Result y
    Then Verify "SMC3EVAJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |720   |Integer      |Integer           |Integer    |

    #Step 25
    Then Open "TMS Admin" from App Launcher
    Then Go to "Recurring Load Schedules" Tab
    Then Wait for "2" Seconds
    Then Click on button with Title "New"
    Then Verify Text displaying as "New Recurring Load Schedule"
    Then Update details
      |Name |Start Date|Load Creation Day|Load Creation Frequency|
      |2089 |-1        |Monday           |Every Week             |
    And Click on "SaveEdit" button
    Then Verify Message displaying as "Recurring Load Schedule \"2089\" was created."

    #Step 26
    Then Go to Home Page
    Then Wait for "4" Seconds
    Then Refresh current Page
    Then Click on button with Title "Refresh"
    Then Run "RecurringLoadScheduleJob" Job
    #Expected Result z
    Then Verify "RecurringLoadScheduleJob" Details
      |Status                      |Previous Run Time|Total Batches|Batches Processed|Batch Errors|
      |Not Running or Scheduled!   |0                |Integer     |Integer         |Integer    |

#     #Step 27
#    Then Open "TMS Admin" from App Launcher
#    Then Go to "Configuration" Tab
#    Then Switch to Frame by Title "accessibility title"
#    Then Scroll into Section "Fleet Management" -
#    Then Select Fleet Management Job as "FleetManagementJob2"
#    And Click on Button with Value "Save" -
#    Then Switch to Parent Frame
#
#     #Step 29
#    Then Go to Home Page
#    Then Run "FleetManagementJob2" Job
#    #Expected Result aa
#    Then Verify "FleetManagementJob2" Details
#      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
#      |Scheduled                  |0                |15   |Integer      |Integer           |Integer    |
##      |Status                     |Previous Run Time|Total Batches|Batches Processed|Batch Errors|
##      |Not Running or Scheduled!  |0                |Integer      |Integer           |Integer    |

     #Step 27
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Fleet Management" -
    Then Select Fleet Management Job as "FleetManagementJob3"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

     #Step 28
    Then Go to Home Page
    Then Run "FleetManagementJob3" Job
    #Expected Result ab
    Then Verify "FleetManagementJob3" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |15   |Integer      |Integer           |Integer    |

#     #Step 32
#    Then Open "TMS Admin" from App Launcher
#    Then Go to "Configuration" Tab
#    Then Switch to Frame by Title "accessibility title"
#    Then Scroll into Section "Fleet Management" -
#    Then Select Fleet Management Job as "FleetManagementJob4"
#    And Click on Button with Value "Save" -
#    Then Switch to Parent Frame
#
#     #Step 33
#    Then Go to Home Page
#    Then Run "FleetManagementJob4" Job
#    #Expected Result ac
#    Then Verify "FleetManagementJob4" Details
#      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
#      |Scheduled                  |0                |15   |Integer      |Integer           |Integer    |

    #Step 29
    Then Go to Home Page
    Then Run "AppointmentRequestJob" Job
    #Expected Result ad
    Then Verify "AppointmentRequestJob" Details
      |Status                     |Previous Run Time|Next Run Time|Total Batches|Batches Processed|Batch Errors|
      |Scheduled                  |0                |720   |Integer      |Integer           |Integer    |