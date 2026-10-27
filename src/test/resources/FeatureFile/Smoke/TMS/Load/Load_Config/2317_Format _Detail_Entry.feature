Feature: 2317 - Load Configuration LWC Format - Detail Entry

  @Regression @TMS @Smoke @WEB @SingleCurrency @Load @Load_Config @2317
  Scenario: 2317 - Load Configuration LWC Format - Detail Entry

    When Login into Salesforce

    #Step1
    Then Open "Loads" from App Launcher
    Then Click on button with Title "New"

    #Expected Result a
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

    #Step 2 & 3
    Then Navigate Browser Back
    Then Select Customer Details and Load Type
      | Load_Num | Customer    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Revenova HQ | Truckload | Dry Van 48     | Y             | N                 |

     # Expected d.1
    Then Verify details for all Disabled or Readonly fields
      | Street Address    | City        | State/Province | Postal Code | Country |
      | 2333 Waukegan Rd. | Bannockburn | Illinois       | 60015       | US      |

    # Expected d.2
    Then Verify "Internal Notes" Text with "Teal" Color is displaying
    Then Verify "Customer/Shipper Internal Notes Customer/Shipper Internal Notes Customer/Shipper Internal Notes" Text with "Black" Color is displaying

    # Expected d.3
    Then Verify Text displaying as "Customer/Shipper Internal Notes Customer/Shipper Internal Notes Customer/Shipper Internal Notes"

    # Expected e.1
    Then Verify details for all Enabled fields
      | Mode      |
      | Truckload |

    # Expected e.2
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button is "Enabled"

    # Expected e.3.a
    Then Verify "Green" color with "address" data key and Title "Stops" are displaying

    # Expected e.3.b
    Then Verify "White" Color with "SteelBlue" Text of "Show Accessorials" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "Quick Entry" Button is "Enabled"

    # Expected e.4.a
    Then Verify Text displaying as "1P"

    # Expected e.4.b
    Then Verify Text displaying as "2D"

    # Expected e.5.a
    Then Verify "BrightBlue" color with "planogram" data key and Title "Line Items" are displaying

    # Expected e.5.b
    Then Verify details for all Required Enabled fields
      | Item Number | Item Description | Weight |
      | Item 1      |                  |        |
    Then Verify details for all Enabled fields
      | Weight Units | HU Count | Handling Units | Length | Width | Height | Dimension Units | NMFC Class | HazMat |
      | lbs          |          | --None--       |        |       |        | in              | --None--   | False  |
    Then Verify details for all Disabled or Readonly fields
      | Linear Feet | Density | Pickup Stop | Delivery Stop |
      |             |         | Stop 1      | Stop 2        |
    Then Verify Title displaying as "Calculate NMFC Class"

    # Expected e.6.a
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button is "Enabled"

    # Expected e.6.b
    Then Verify "White" Color with "SteelBlue" Text of "Cancel" Button is "Enabled"

    # Step 5a
    Then Move hover on Tooltip for "HU Count"
    # Expected f
    Then Verify Help Text displaying as "Handling Unit Count"

     # Step 5b
    Then Move hover on Tooltip for "Length"
    # Expected g
    Then Verify Help Text displaying as "Length of Handling Unit"

    # Step 5c
    Then Move hover on Tooltip for "Width"
    # Expected h
    Then Verify Help Text displaying as "Width of Handling Unit"

    # Step 5d
    Then Move hover on Tooltip for "Height"
    # Expected i
    Then Verify Help Text displaying as "Height of Handling Unit"

    # Step 5e
    Then Move hover on Tooltip for "Dimension Units"
    # Expected j
    Then Verify Help Text displaying as "Of Handling Unit"

    # Step 5f
    Then Move hover on Tooltip for "Linear Feet"
    # Expected k
    Then Verify Help Text displaying as "Only auto-calculated when the Length, Width, and Height are defined for the line item and the selected Equipment Type."

    # Step 5g
    Then Move hover on Tooltip for "Density"
    # Expected l
    Then Verify Help Text displaying as "Pounds per Cubic Foot"

    # Step 5h & Expected m
    Then Verify Title displaying as "Calculate NMFC Class"

    # Step 5i
    Then Update details
      | HazMat |
      | True   |

    # Expected n
    Then Verify details for all Enabled fields
      | HazMat Number Type | HazMat Number | HazMat Class/Division | HazMat Packaging Group | HazMat Contact |
      | --None--           |               | --None--              | --None--               |                |
    Then Verify "BrightBlue" color with "planogram" data key and Title "HazMat Routing" are displaying
    Then Verify details for all Enabled fields
      | HazMat Routing |
      | --None--       |

    Then Move hover on Tooltip for "HazMat Number"
    # Expected o
    Then Verify Help Text displaying as "e.g., "

    # Step 5.j
    Then Click on button with Title "Add Line Item"

    # Expected p
    Then Verify details for all Required Enabled fields
      | Item Number_2 | Item Description_2 | Weight_2 |
      | Item 2        |                    |          |
    Then Verify details for all Enabled fields
      | Weight Units_2 | HU Count_2 | Handling Units_2 | Length_2 | Width_2 | Height_2 | Dimension Units_2 | NMFC Class_2 | HazMat_2 |
      | lbs            |            | --None--         |          |         |          | in                | --None--     | False    |
    Then Verify details for all Disabled or Readonly fields
      | Linear Feet_2 | Density_2 | Pickup Stop_2 | Delivery Stop_2 |
      |               |           | Stop 1        | Stop 2          |
    Then Verify Title displaying as "Calculate NMFC Class"
    Then Verify Second "close" button is displaying with Title "Delete Line Item"
    Then Verify Title displaying as "dd Line Item"