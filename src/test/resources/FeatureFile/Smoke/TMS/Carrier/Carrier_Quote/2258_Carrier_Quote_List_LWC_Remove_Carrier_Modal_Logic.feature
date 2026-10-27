Feature: 2258 - Carrier Quote List LWC- Remove Carrier Modal Logic

  @Regression @TMS @WEB @SingleCurrency @Carrier @Headed @Carrier_Quotes @2258
  Scenario: 2258 - Carrier Quote List LWC- Remove Carrier Modal Logic

    When Login into Salesforce

   # Step 1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | LTL  | Dry Van 53'    | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | New England Patriots | 1             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Mixed       | 4000   | NA           | NA       | NA             |
    Then Save Load With All details

     #Step 2
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Capture the current URL for "FQA"
    Then Enter Carrier Service as "Email Carrier One - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1001"
    Then Wait for "1" Seconds
    Then "Save" Carrier
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 3
    Then "New" Carrier

    #Step 4
    Then Enter Carrier Service as "Email Carrier Two - LTL"
    Then Enter "Carrier Quote Items" "Net Freight Charges" as "1002"
    Then Wait for "1" Seconds
    Then "Save" Carrier
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds

    #Step 5
    Then Scroll into Section "Carrier Quotes"
    Then Select radio button for value "Email Carrier One - LTL" in Carrier Quote List
    Then Click on "Assign" button at Carrier Quote List LWC
    Then Verify Message displaying as "Load was assigned to carrier."
    Then Wait for "2" Seconds

    #Step 6
    Then Scroll into Section "Carrier Quotes"
    Then Select radio button for value "Email Carrier Two - LTL" in Carrier Quote List
    Then Click on "Tender" button at Carrier Quote List LWC
    Then Wait for "5" Seconds

    #Expected a
    Then Verify Text displaying as "Remove Carrier" -

    #Step 7
    Then Click on button "Remove Carrier" -
    Then Wait for "5" Seconds

    #Expected b
    Then Verify Message displaying as "Carrier removed from load."
    Then Wait for "5" Seconds
    Then Verify Text displaying as "Tender Email" -

    #Step 8
    Then Verify "Tender" Text with Background Color "SteelBlue" is displaying on Modal
    Then Verify Text displaying as "1,002.00" -

    #Step 9
    Then Click on "Send" Button on "Tender Email" -
    Then Wait for "4" Seconds

    #Expected c
    Then Verify Message displaying with Text "Email has been placed in the outgoing queue."
    Then Wait for "3" Seconds
    Then Click on Carrier Quote from FQA Page
    Then Wait for "2" Seconds
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Auto-Engagement"
    Then Verify Details
      | Tender Status |
      | Sent          |

    #Step 10
    Then Navigate Browser Back
    Then Scroll into Section "Carrier Quotes"
    Then Click on "Assign" button at Carrier Quote List LWC

    #Expected d
    Then Verify Message displaying with Text "Load was assigned to carrier."
    Then Refresh current Page
    Then Verify Banner Details
      | Load Status |
      | Assigned    |
    Then Go to "Freight Quote Assistant" Tab
    Then Click on Carrier Quote from FQA Page
    Then Wait for "2" Seconds
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Auto-Engagement"
    Then Verify Details
      | Tender Status |
      | Assigned      |
    Then Navigate Browser Back
    Then Refresh current Page
    Then Go to "Freight Quote Assistant" Tab
    Then Click on button with Title "Refresh Quotes"
    Then Click on View Quotes
    Then Select "Email Carrier One - LTL" With Carrier Total as "USD 1,001.00" from View Quotes
    Then Wait for "2" Seconds
    Then Click on Carrier Quote from FQA Page
    Then Wait for "2" Seconds
    Then Go to "Details" Tab on Next to "Pricing" Tab
    Then Scroll into Section "Auto-Engagement"
    Then Verify Details
      | Tender Status |
      | Removed       |

    #Step 11
    Then Navigate Browser Back
    Then Refresh current Page
    Then Go to "Freight Quote Assistant" Tab
    Then Click on View Quotes

    #Step 12
    Then Select "Email Carrier One - LTL" With Carrier Total as "USD 1,001.00" from View Quotes
    Then Wait for "2" Seconds
    Then "Assign" Carrier
    Then Wait for "3" Seconds

    #Expected e
    Then Verify Text displaying as "Remove Carrier" -

    #Step 13
    Then Click on button "Remove Carrier" -
    Then Wait for "5" Seconds
    Then Verify Message displaying as "Carrier removed from load."
    Then Wait for "4" Seconds
    Then Verify Message displaying as "Load was assigned to carrier."

    #Step 14
    Then Go to "Summary" Tab
    Then Click on Native "Remove Carrier" icon

    #Step 15
    Then Click on button "Remove Carrier" -
    Then Wait for "3" Seconds

    #Expected f
    Then Verify Message displaying as "Carrier removed from load."
    Then Verify Banner Details
      | Load Status |
      | Unassigned  |