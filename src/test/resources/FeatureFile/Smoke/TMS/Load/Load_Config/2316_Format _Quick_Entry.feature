Feature: 2316 - Load Configuration LWC Format- Quick Entry

  @Regression @TMS @Smoke @WEB @SingleCurrency @Load @Load_Config @2316
  Scenario: 2316 - Load Configuration LWC Format- Quick Entry

    When Login into Salesforce

    # Step1
    Then Open "Loads" from App Launcher
    Then Click on button with Title "New"

    # Expected Result a
    Then Verify "Earth Yellow" icon and "White" "custom98_120.png" with Title "Loads" are displaying
    Then Verify "White" Color with "SteelBlue" Text of "Cancel" Button is "Enabled"
    Then Verify "LightGray" Color with "White" Text of "Save" Button is "Disabled"
    Then Verify "White" Color with "SteelBlue" Text of "Cancel_2" Button is "Enabled"
    Then Verify "LightGray" Color with "White" Text of "Save_2" Button is "Disabled"
    Then Verify details for all Required Enabled fields
      | Customer Search |
      |                 |
    Then Verify details for all Enabled fields
      | Street Address | City | State/Province | Postal Code | Country |
      |                |      |                |             |         |
    Then Verify details for all Required Enabled fields
      | Mode |
      |      |
    Then Verify details for all Enabled fields
      | Equipment Type |
      |                |
    Then Verify "add" button is displaying with Title "New Customer"

    #Step 1.a and Expected b
    Then Verify Title displaying as "Clear"

    # Step 1.b     # Expected c
    Then Verify Title displaying as "New Customer"

    # Step 2 & 3
    Then Navigate Browser Back
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | Truckload | NA             | N             | N                 |

    # Expected d.1
    Then Verify details for all Disabled or Readonly fields
      | Street Address    | City        | State/Province | Postal Code | Country |
      | 2333 Waukegan Rd. | Bannockburn | Illinois       | 60015       | US      |

    # Expected d.2
    Then Verify "Internal Notes" Text with "Teal" Color is displaying
    Then Verify "Customer/Shipper Internal Notes Customer/Shipper Internal Notes Customer/Shipper Internal Notes" Text with "Black" Color is displaying

    # Expected d.3
    Then Verify Text displaying as "Customer/Shipper Internal Notes Customer/Shipper Internal Notes Customer/Shipper Internal Notes"

    # Step 3, Expected e.1
    Then Verify details for all Enabled fields
      | Mode      |
      | Truckload |

    # Expected e.2
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button is "Enabled"

    # Expected e.3.a
    Then Verify "Green" color with "address" data key and Title "Stops" are displaying

    # Expected e.3.b
    Then Verify "White" Color with "SteelBlue" Text of "Detail Entry" Button is "Enabled"

    # Expected e.4.c
    Then Verify Text displaying as "1P"

    # Expected e.4.c
    Then Verify Text displaying as "2D"

    # Expected e.4.c
    Then Verify button is present with "Show street map"

    # Step 5.a and Expected f
    Then Move hover on Tooltip for "HU Count"
    Then Verify Help Text displaying as "Handling Unit Count"

    # Step 5.b and Expected result g
    Then Click on button with Title "Add Line Item"
    Then Verify "BrightBlue" color with "planogram" data key and Title "Line Items" are displaying

    Then Verify details for all Required Enabled fields
      | Pickup_2 | Delivery_2 | Name_2 | Description_2 | Weight_2 | Weight Units_2 |
      | P1       | D2         | Item 2 |               |          | lbs            |
    Then Verify details for all Enabled fields
      | HU Count_2 | Handling Units_2 |
      |            | --None--         |
    Then Move hover on Tooltip for Second "HU Count"
    Then Verify Help Text displaying as "Handling Unit Count"

    Then Verify Second "close" button is displaying with Title "Delete Line Item"
    Then Verify Second "add" button is displaying with Title "New Location"
    Then Verify "White" Color with "SteelBlue" Text of "Cancel_2" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Save_2" Button is "Enabled"