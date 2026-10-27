Feature: 1112 - Carrier Banner LWC- Request Carrier Status Button

  @Regression @TMS @WEB @Carrier @MultiCurrency @Carrier_Banner @1112
  Scenario: 1112 - Carrier Banner LWC- Request Carrier Status Button

    When Login into Salesforce

    #Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53'    | Y             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value             | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats | 4             | NA                       | NA               | NA                   |

    Then Add Line Items - Detailed View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units | Length | Width | Height | Dimension_Unit | NMFC_Class |
      | 1         | Stop 1 | Stop 2   | Bananas     | 15000  | NA           | NA       | NA             | NA     | NA    | NA     | NA             | NA         |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 2
    Then Wait for "3" Seconds
    Then Verify Button with Title not displaying as "Request Carrier Status" -

    #Step 3
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "6" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 4
    Then Go to "Summary" Tab
    Then Wait for "3" Seconds
    Then Verify Button with Title displaying as "Request Carrier Status" -

    #Step 5
    Then Click on Native "Request Carrier Status" icon
    Then Verify Message displaying as "Status request successful"
    Then Wait for "3" Seconds
    Then Verify Button with Title displaying as "Request Carrier Status" -
    Then Wait for Email to Receive On Email

    #Step 6
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "Email Carrier One" from List
    Then Wait for "3" Seconds
    Then Capture the current URL for "TP_Email_Carrier_One"
    Then Click on "Carrier Service" Link Text "Email Carrier One - Truckload" on Page
    Then Wait for "3" Seconds
    Then Capture the current URL for "CS_Email_Carrier_One_Truckload"

    #Step 7
    Then Scroll into Section "Carrier Status Contact (Default)"
    Then Click on Edit icon on "Status Method"
    Then Wait for "2" Seconds
    Then Update details
      | Status Method |
      | Phone         |
    Then Click on "Save" button
    Then Wait for "3" Seconds
    Then Verify "Status Method" having value of "Phone"

    #Step 8
    Then Navigate to stored URL for "Load_1"
    Then Wait for "3" Seconds
    Then Click on Native "Request Carrier Status" icon
    Then Verify Message displaying as "Status request successful"
    Then Wait for "3" Seconds

    #Step 9
    Then Go to "Snapshot" Tab
    Then Wait for "5" Seconds
    Then Go to "Activity" Tab
    Then Wait for "3" Seconds
    Then Verify Text displaying as "Call"
    Then Verify Text displaying as "Email Carrier One"
