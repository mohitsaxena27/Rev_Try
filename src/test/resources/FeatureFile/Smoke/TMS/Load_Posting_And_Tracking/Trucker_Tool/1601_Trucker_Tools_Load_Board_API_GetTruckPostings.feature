Feature: 1601 - Trucker Tools Load Board API- GetTruckPostings

#  @Regression @TMS @Smoke @API @Load_Posting_And_Tracking @SingleCurrency @TruckerTool @1601
  Scenario: 1601 - Trucker Tools Load Board API- GetTruckPostings
    
    When Login into Salesforce
    #Steps1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | true            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Wait for "1" Seconds
    Then Switch to Parent Frame

    #Step 2
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Boston Beans | Truckload      | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1              | NA                       | NA              | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats     |  3            | NA                       | NA             | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas       | 15000   | NA           | NA       | NA             |

    Then Save Load With All details
    Then "Without Capture" and Close all the Toast messages from Bottom

    #Step3
    Then Select the + action next to the "Trucker Tools Load Board" integration listing
    Then Verify Message displaying with Text "Trucker Tools Load Board: This load was successfully posted."
    Then "Without Capture" and Close all the Toast messages from Bottom
    #Step 4
    Then Wait for "4" Seconds
    Then Go to "Find Carriers" Tab
    Then Wait for "2" Seconds
    Then "Capture" and Close all the Toast messages from Bottom
    Then Set "Load_Url" with "carrierCapacityForLoad?loadNumber=" and "SysData=1L"
    Then Set "Final_Url" with "SysData=>Load_Url" and "_Url"

    #Expected Result a
    Then Verify url displaying with "SysData=>Final_Url" as "http://scapi-staging.truckertools.com/api/carrierCapacityForLoad?loadNumber={SysData=>1L}"
#    Then Scroll into Section "Out of Network"
#    Then Click on "Out of Network" with Text
#    Then Verify "Trucker Tools" data is created with following details
#      |Source                   |Domicile	|MC Number         |DOT Number  |Contact   |Phone|Email|Postings|
#      |Trucker Tools Load Board	|           |MC986705          |3240959054  |Dave |(703) 955-3560| support@truckertools.com|1|
#
#    Then Scroll into Section "Truck Postings"
#    Then Verify "Reston, VA" data is created with following details
#      |Carrier      |Contact   |Phone|Email                        |Source                      |Equipment 	|Qty |Available|Range |Destination |Age (min)|
#      |Trucker Tools|Dave |(703) 955-3560| support@truckertools.com|Trucker Tools Load Board	|Van        |1   |-1           |       |               |480      |
#



    