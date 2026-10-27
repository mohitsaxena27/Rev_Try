Feature:2931 - Pay Header - Statuses - Individual Calculation Criteria

  @API @Regression @PayIQ  @WEB @SingleCurrency @2931 @PayHeader
  Scenario: 2931 - Pay Header - Statuses - Individual Calculation Criteria

    When Login into Salesforce

      #Pre - Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Pay Header Individual" from List
    Then Click on Edit icon on Label "Status"
    Then Update details
      | Status |
      | Open   |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Status |
      | Open   |
    Then Capture the current URL for "PayIQ_Program_1"
    Then Scroll Until Related List for "Calculation Tiers"
    Then Get "Calculation Tier-" Name with "Calculation Description" as "Percent of Load Margin (Quoted)" and "Percent" as "10.00%" and store in "Calculation_Tier_ID"
    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer            | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Grand Rapids Kayaks | Truckload | NA             | NA            | NA                |

    Then Wait for "1" Seconds
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Philadelphia Eagles | 2             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Kayaks      | 999    | NA           | NA       | NA             |
    Then Save Load With All details
    #Step 2
    Then Capture the current URL for "Load_1L"
    #Step 3
    Then Go to "PayIQ" Tab
    Then Click on Edit icon on Label "Sales Lead (Contact)"
    Then Update details
      | Sales Lead (Contact)  |
      | Joe Oakland Athletics |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "60"
    Then Update details
      | Status   |
      | Accepted |
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
   #Step 5
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 6
    Then Navigate to stored URL for "Load_1L"

    #Step 7
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "50"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 8
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Oakland Athletics (Contact)"
    Then Wait for "2" Seconds
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Set "Pay_Details_ID_1" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_1" with "SysData=>Pay Header"
    Then Set "Participant_Match_ID_1" with "SysData=>Participant Match"
    Then Capture the current URL for "Pay_Details_1"
    #Step 9
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Pending     |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Pending       |

    #Step 10
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 11
    Then Navigate to stored URL for "Load_1L"

    #Step 12 & Expected a
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Oakland Athletics (Contact)"
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Verify Assertion for "Pay_Details_ID_1" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Participant_Match_ID_1" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Pay_Header_1" contains "SysData=>Pay Header"
    Then Verify Details
      | Pay Amount |
      | USD 5.00  |

    #Step 13
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "70"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 14
    Then Go to "PayIQ" Tab
    Then Wait for "4" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Participant Name" as "Joe Oakland Athletics (Contact)"
    Then Wait for "2" Seconds
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |                    |              |            |
    Then Set "Pay_Details_ID_2" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_2" with "SysData=>Pay Header"
    Then Set "Participant_Match_ID_2" with "SysData=>Participant Match"
    Then Capture the current URL for "Pay_Details_2"

   #Step 15
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Approved    |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Approved    |

      #Step 16
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

     #Step 17
    Then Navigate to stored URL for "Load_1L"

    #Step 18 & Expected b.1
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 5.00"
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Verify Assertion for "Pay_Details_ID_2" contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Participant_Match_ID_2" contains "SysData=>Participant Match"
    Then Verify Assertion for "Pay_Header_2" contains "SysData=>Pay Header"
    Then Verify Details
      | Pay Amount |
      | USD 5.00  |

    #Expected b.2
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 2.00"
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Verify Assertion for "Pay_Details_ID_1" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Pay_Details_ID_2" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Participant_Match_ID_1" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Participant_Match_ID_2" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Pay_Header_1" not contains "SysData=>Pay Header"
    Then Verify Assertion for "Pay_Header_2" not contains "SysData=>Pay Header"
    Then Verify Details
      | Pay Amount |
      | USD 2.00  |

    #Step 19
    Then Navigate to stored URL for "Load_1L"
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "110"
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

    #Step 20
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 2.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Set "Pay_Details_ID_3" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_3" with "SysData=>Pay Header"
    Then Set "Participant_Match_ID_3" with "SysData=>Participant Match"
    Then Capture the current URL for "Pay_Details_3"

    #Step 21
    Then Click on Partial Link Text "Pay Header-" on Page
    Then Wait for "2" Seconds
    Then Scroll into Section "Payroll Status"
    Then Click on Edit icon on Label "Payment Status"
    Then Update details
      | Payment Status |
      | Paid     |
    Then Click on "SaveEdit" button
    Then Wait for "2" Seconds
    Then Verify Details
      | Payment Status |
      | Paid       |

    #Step 22
    Then Open "PayIQ Admin" from App Launcher
    Then Wait for "5" Seconds
    Then Click on "Execute PayIQ Jobs Now" with Text
    Then Verify Message displaying as "PayIQ Jobs Triggered"
    Then Wait till "Generate Adjustments" is "Completed"

    #Step 23
    Then Navigate to stored URL for "Load_1L"

    #Step 24 & Expected c
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "Pay Details"

    #  Expected c.1
    Then Wait for "5" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 5.00"
    Then Wait for "2" Seconds
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Verify Assertion for "Pay_Details_ID_2" contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Participant_Match_ID_2" contains "SysData=>Participant Match"
    Then Verify Assertion for "Pay_Header_2" contains "SysData=>Pay Header"
    Then Verify Details
      | Pay Amount |
      | USD 5.00  |

     #  Expected c.2
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 2.00"
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Verify Assertion for "Pay_Details_ID_3" contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Participant_Match_ID_3" contains "SysData=>Participant Match"
    Then Verify Assertion for "Pay_Header_3" contains "SysData=>Pay Header"
    Then Verify Details
      | Pay Amount |
      | USD 2.00  |

     #  Expected c.3
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD -7.00"
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Set "Pay_Details_ID_4" with "SysData=>Pay Detail ID"
    Then Set "Pay_Header_4" with "SysData=>Pay Header"
    Then Set "Participant_Match_ID_4" with "SysData=>Participant Match"
    Then Verify Assertion for "Pay_Details_ID_1" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Pay_Details_ID_2" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Pay_Details_ID_3" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Participant_Match_ID_1" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Participant_Match_ID_2" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Participant_Match_ID_3" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Pay_Header_1" not contains "SysData=>Pay Header"
    Then Verify Assertion for "Pay_Header_2" not contains "SysData=>Pay Header"
    Then Verify Assertion for "Pay_Header_3" not contains "SysData=>Pay Header"
    Then Verify Details
      | Pay Amount |
      | USD -7.00  |

     #  Expected c.4
    Then Navigate to stored URL for "Load_1L"
    Then Wait for "2" Seconds
    Then Scroll Until Related List for "Pay Details"
    Then Click on "Pay Detail-" with "Pay Amount" as "USD 22.00"
    Then Get Details
      | Pay Detail ID | Pay Header   |Participant Match|
      |               |              |               |
    Then Verify Assertion for "Pay_Details_ID_1" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Pay_Details_ID_2" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Pay_Details_ID_3" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Pay_Details_ID_4" not contains "SysData=>Pay Detail ID"
    Then Verify Assertion for "Participant_Match_ID_1" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Participant_Match_ID_2" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Participant_Match_ID_3" not contains "SysData=>Participant Match"
    Then Verify Assertion for "Participant_Match_ID_4" contains "SysData=>Participant Match"
    Then Verify Assertion for "Pay_Header_4" contains "SysData=>Pay Header"
    Then Verify Details
      | Pay Amount |
      | USD 22.00  |

    #Step 24.a & Expected d
    Then Navigate to stored URL for "Pay_Details_2"
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | Pay Approved |
      | True         |

     #Step 24.b & Expected e
    Then Navigate to stored URL for "Pay_Details_3"
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | Pay Approved |
      | True         |
    Then Navigate to stored URL for "Load_1L"

    #Step 25 & Expected f
    Then Go to "PayIQ" Tab
    Then Scroll Until Related List for "PayIQ Logs"
    Then Click on link "PayIQ Logs"
    Then Verify Logs displaying as "[Adjusted Pay] = [{Calculation_Tier_ID} Pay Amount] - [Amount Already Paid] = 7 - (5) = 2 USD"
    Then Verify Logs displaying as either "[Adjusted Pay (For No Longer In Tier)] = - [Amount Already Paid] = - (5 + 2) = -7 USD" or "[Adjusted Pay (For No Longer In Tier)] = - [Amount Already Paid] = - (2 + 5) = -7 USD"