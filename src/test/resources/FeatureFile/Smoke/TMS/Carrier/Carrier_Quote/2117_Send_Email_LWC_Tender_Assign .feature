Feature: 2117 - Send Email LWC- Tender/Assign


  @Regression @TMS @Smoke @WEB @SingleCurrency @Carrier @Headed @Carrier_Quotes @2117
  Scenario: 2117 - Send Email LWC- Tender/Assign

    When Login into Salesforce

#   # Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
     |Load_Num | Customer      |Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
     |1L       | Boston Beans |Truckload | NA     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots|  1           | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight |Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Mixed    |12345  |NA          |NA       |NA       |
    Then Save Load With All details
    Then Capture the current URL for "Load_Details"

     #Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    #Step 3
    Then Verify Text displaying as "Tender Email" -
    #Expected Result a
    Then Verify "Legend" Link Text "Tender" on Page -
    Then Verify "Tender" Text with Background Color "SteelBlue" is displaying on Modal
    Then Verify "Legend" Link Text "Assign" on Page -
    #Step 4
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds
    #Expected b
    Then Verify Message displaying with Text "Email has been placed in the outgoing queue."
    Then Refresh current Page
    #Step 5 #Expected c
    Then Verify Banner Details
      | Load Status |
      | Tendered    |

    #Step 6
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    #Step 7
    Then Verify Text displaying as "Tender Email" -
    Then Verify details for all Enabled fields -
      |Email Template|
      |Load Tender - LEX2   |
    #Step 8
    Then Click on "Legend" Link Text "Assign" on Page -
    Then Wait for "5" Seconds
    #Expected Result d
    Then Verify "Assign" Text with Background Color "SteelBlue" is displaying on Modal
    Then Verify details for all Enabled fields -
      |Email Template|
      |Load Tender with Assignment - LEX2   |

    #Step 9
    Then Click on "Cancel" Button on "Tender Email" -
     #Step 10 #Expected e
    Then Verify Banner Details
      | Load Status |
      | Tendered    |

      #Step 11
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    #Step 12
    Then Verify Text displaying as "Tender Email" -
    Then Click on "Legend" Link Text "Assign" on Page -
    Then Wait for "5" Seconds
    Then Verify "Assign" Text with Background Color "SteelBlue" is displaying on Modal
    Then Verify details for all Enabled fields -
      |Email Template|
      |Load Tender with Assignment - LEX2   |
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "2" Seconds
    #Expected Result f
    Then Verify Message displaying with Text "Email has been placed in the outgoing queue."

     #Step 13 #Expected g
    Then Refresh current Page
    Then Wait for "2" Seconds
    Then Verify Banner Details
      | Load Status |
      | Assigned    |

    #Step 14
    Then Open "TMS Admin" from App Launcher
    Then Go to "Document Options" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Link" Link Text "Global Defaults" on Page -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Enable Assign Carrier On Tender Option |
      | False                              |
    Then Click on Button with Value "Save" -
    Then Verify Message displaying with "Save was successful."
    Then Switch to Parent Frame

    #Step 15
    Then Navigate to stored URL for "Load_Details"

    #Step 16
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    #Expected h
    Then Verify Text "Tender" not displaying on modal
    Then Verify Text "Assign" not displaying on modal

     #Step 17
    Then Close Modal
    Then Wait for "2" Seconds

    #Step 18
    Then Open "TMS Admin" from App Launcher
    Then Go to "Document Options" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Link" Link Text "Global Defaults" on Page -
    Then Switch to Parent Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      | Enable Assign Carrier On Tender Option |
      | True                              |
    Then Click on Button with Value "Save" -
    Then Verify Message displaying with "Save was successful."
    Then Switch to Parent Frame

    #Step 19
    Then Navigate to stored URL for "Load_Details"

    #Step 20
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then "Tender" Carrier
    Then Wait for "2" Seconds
    #Expected i
    Then Verify "Legend" Link Text "Tender" on Page -
    Then Verify "Tender" Text with Background Color "SteelBlue" is displaying on Modal
    Then Verify "Legend" Link Text "Assign" on Page -

