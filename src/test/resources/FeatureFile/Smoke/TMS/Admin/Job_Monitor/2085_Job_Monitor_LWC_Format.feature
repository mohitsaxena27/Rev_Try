Feature:2085 - Job Monitor LWC- Format

  @Regression @TMS @Smoke @WEB @Admin @SingleCurrency  @Job_Run @2085
  Scenario: 2085 - Job Monitor LWC- Format

    When Login into Salesforce
  # Step 1 & Expected Result a
    Then Verify Text displaying as "Batch Processes"
    Then Verify Icon "standard:feed" is displaying with background color "SteelBlue"
    Then Verify Title button "Refresh" is displaying with Object "rtms-jobmonitor_jobmonitor"
    Then Verify Text displaying as "ARCalculationJob"
    Then Verify Text displaying as "BanyanJob"
    Then Verify Text displaying as "CarrierEngagementAutomationJob"
    Then Verify Text displaying as "CustomerInvoiceGenerationJob"
    Then Verify Text displaying as "CarrierMonitorRMISJob"
    Then Verify Text displaying as "DataCleanupJob"
    Then Verify Text displaying as "EDIWatcherJob"
    Then Verify Text displaying as "EDIJob"
    Then Verify Text displaying as "FleetManagementJob"
    Then Verify Text displaying as "FleetManagementJob2"
    Then Verify Text displaying as "FleetManagementJob3"
    Then Verify Text displaying as "FreightPlanManagementJob"
    Then Verify Text displaying as "FuelCardJob"
    Then Verify Text displaying as "FuelIndexUpdateJob"
    Then Verify Text displaying as "FuelSurchargeUpdateJob"
    Then Verify Text displaying as "IFTAStateReportJob"
    Then Verify Text displaying as "LoadAndTruckPostingManagementJob"
    Then Verify Text displaying as "LoadAndTruckPostingManagementJob2"
    Then Verify Text displaying as "LoadDexDataUploadJob"
    Then Verify Text displaying as "LoadStatusUpdateJob"
    Then Verify Text displaying as "QueuedTransactionJob"
    Then Verify Text displaying as "SMC3EVAJob"
    Then Verify Text displaying as "RecurringLoadScheduleJob"

    #Expected Result a.2
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "ARCalculationJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "BanyanJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "CarrierEngagementAutomationJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "CustomerInvoiceGenerationJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "CarrierMonitorRMISJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "DataCleanupJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "EDIWatcherJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "EDIJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "FleetManagementJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "FleetManagementJob2"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "FleetManagementJob3"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "FreightPlanManagementJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "FuelCardJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "FuelIndexUpdateJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "FuelSurchargeUpdateJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "IFTAStateReportJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "LoadAndTruckPostingManagementJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "LoadAndTruckPostingManagementJob2"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "LoadDexDataUploadJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "LoadStatusUpdateJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "QueuedTransactionJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "SMC3EVAJob"
    Then Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for "RecurringLoadScheduleJob"

    #Step 2
    Then Move hover on Tooltip for Text "Use the dropdown arrow in"
    #Expected b
    Then Verify Tooltip message are displaying as "Use the dropdown arrow in the first column to access the \"Run Now\" and \"Schedule\" actions for each job as applicable."

    #Step 3 & Expected Result c
    Then Click on dropdown chevron & Verify dropdown Action Option for "AppointmentRequestJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "ARCalculationJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "BanyanJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "CarrierEngagementAutomationJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "CustomerInvoiceGenerationJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "CarrierMonitorRMISJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "DataCleanupJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "EDIWatcherJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "EDIJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "FleetManagementJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "FleetManagementJob2"
    Then Click on dropdown chevron & Verify dropdown Action Option for "FleetManagementJob3"
    Then Click on dropdown chevron & Verify dropdown Action Option for "FreightPlanManagementJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "FuelCardJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "FuelIndexUpdateJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "FuelSurchargeUpdateJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "IFTAStateReportJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "LoadAndTruckPostingManagementJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "LoadAndTruckPostingManagementJob2"
    Then Click on dropdown chevron & Verify dropdown Action Option for "LoadDexDataUploadJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "LoadStatusUpdateJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "QueuedTransactionJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "SMC3EVAJob"
    Then Click on dropdown chevron & Verify dropdown Action Option for "RecurringLoadScheduleJob"

    #Step 4
    Then Store current Time in format of "MM/dd/yyyy, h:mm:ss a" on to "CurrentTime"
    Then Click on Title button "Refresh" is displaying with Object "rtms-jobmonitor_jobmonitor"
    Then Wait for "3" Seconds
     #Expected d
    Then Verify and get Updated On "SysData=>CurrentTime" is displaying with Object "rtms-jobmonitor_jobmonitor"

