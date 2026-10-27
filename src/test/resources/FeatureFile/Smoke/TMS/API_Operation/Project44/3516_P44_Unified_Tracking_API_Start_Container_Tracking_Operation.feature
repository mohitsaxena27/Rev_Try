Feature: 3516 - P44 Unified Tracking API- EStart Container Tracking Operation

  @Regression @TMS @Smoke @API @WEB @API_Operation @SingleCurrency @Project44 @3516 @DeleteFile
  Scenario: 3516 - P44 Unified Tracking API- Start Container Tracking Operation

    When Login into Salesforce

    # Steps 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Wait for "2" Seconds
    Then Go to "Global Services" Tab
    Then Search text "OpenTrack" in the "Search Credentials..." search box
    Then Select the "OpenTrack" record from the lookup field results
    Then Update details
      | Enabled |
      | False   |
    And Click on Native "Save" button
    Then Wait for "3" Seconds

    # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Retain API Response Packets |
      | True                        |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Steps 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode    | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Drayage | NA             | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 3             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |
    Then Wait for "2" Seconds
    Then Update container details
      | Container Number | SCAC |
      | TRHU7493516      | TRHU |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    # Step 4
    Then Go to "Details" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Shipment IDs"
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Seal Number"
    Then Update details
      | Booking Number |
      | BN3516         |

    # Step 5
    Then Scroll into Section "Import/Export Information"
    Then Wait for "2" Seconds
    Then Update details
      | Master Bill of Lading Number |
      | MEDUI4733516                 |
    Then Click on "Save" button on Details Page

    # Step 6
    Then Go to "Shipment" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Containers"
    Then Click on "TRHU7493516" with Text
    Then Wait for "2" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      | Tracking |
      | On       |
    Then Click on "Save" button on Details Page
    Then Capture the current URL for "Container_1"

    # Step 7
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job
    Then Wait for "5" Seconds

    # Step 8
    Then Open "Containers" from App Launcher
    Then Search and Select "TRHU7493516" from List
    Then Wait for "2" Seconds

    #Step 9
    Then Go to "Files" Tab
    Then Wait for "3" Seconds
    #Expected a
    Then Get ContentDocument Id for "1" "Project44StartContainerTrackingOperation_Request" and store into "ContentDocument_1"
    Then Download Json with ContentDocumentId "ContentDocument_1" and store on to "Actual_Json_1"
    Then Update and verify Json for "Actual_Json_1" with "3516_Expected_a.json"
      | No Update Required |
      |                    |

    # Step 10
    Then Navigate to stored URL for "Container_1"

    Then Wait for "5" Seconds
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      | Tracking |
      | Off      |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds
    Then Verify Details
      | Tracking |
      | Off      |

    # Step 11
    Then Scroll into Section "Container Information"
    Then Click on Edit icon on Label "Container Number"
    Then Update details
      | Container Number |
      | CN3516           |
    Then Update details
      | Tracking |
      | On       |

    # Step 11.a
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds
    Then Verify Details
      | Container Number | Tracking |
      | CN3516           | On       |

    # Step 11.b
    Then Wait for "120" Seconds

    # Step 12 & Expected a
    Then Go to "Files" Tab
    Then Wait for "3" Seconds

    Then Get ContentDocument Id for "1" "Project44StartContainerTrackingOperation_Request" and store into "ContentDocument_2"
    Then Download Json with ContentDocumentId "ContentDocument_2" and store on to "Actual_Json_2"
    Then Update and verify Json for "Actual_Json_2" with "3516_Expected_b.json"
      | No Update Required |
      |                    |

    # Step 13
    Then Navigate to stored URL for "Container_1"
    Then Wait for "5" Seconds

    # Step 14
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      | Tracking |
      | Off      |
    Then Click on "Save" button on Details Page

    # Step 15
    Then Navigate to stored URL for "Load_1"

    # Step 16
    Then Go to "Details" Tab
    Then Wait for "8" Seconds
    Then Scroll into Section "Import/Export Information"
    Then Click on Edit icon on Label "Master Bill of Lading Number"
    Then Wait for "2" Seconds
    Then Update details
      | Master Bill of Lading Number |
      |                              |
    Then Click on "Save" button on Details Page
    Then Wait for "3" Seconds
    Then Verify Details
      | Master Bill of Lading Number |
      |                              |

    # Step 17
    Then Navigate to stored URL for "Container_1"
    Then Wait for "5" Seconds

    # Step 17.a
    Then Scroll into Section "Tracking Information"
    Then Click on Edit icon on Label "Tracking"
    Then Update details
      | Tracking |
      | On       |
    Then Click on "Save" button on Details Page
    Then Wait for "2" Seconds
    Then Verify Details
      | Tracking |
      | On       |

    # Step 17.b
    Then Wait for "120" Seconds

    # Step 18
    Then Go to "Files" Tab
    Then Wait for "3" Seconds
    Then Get ContentDocument Id for "1" "Project44StartContainerTrackingOperation_Request" and store into "ContentDocument_3"
    Then Download Json with ContentDocumentId "ContentDocument_3" and store on to "Actual_Json_3"
    Then Update and verify Json for "Actual_Json_3" with "3516_Expected_c.json"
      | No Update Required |
      |                    |

    # Step 19
    Then Get ContentDocument Id for "1" "Project44StartContainerTrackingOperation_Response" and store into "ContentDocument_4"
    Then Download Json with ContentDocumentId "ContentDocument_4" and store on to "Actual_Response_Json_4"
    Then Get Attribute "id" from Json "SysData=>Actual_Response_Json_4"

    # Step 20
    Then Navigate to stored URL for "Container_1"

    # Expected d
    Then Scroll into Section "Tracking Information"
    Then Verify Details
      | Tracking Provider  | Tracking Number |
      | Project44 Tracking | SysData=>id     |