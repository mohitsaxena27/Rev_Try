Feature: 2513 - TransCore API- Get Truck Postings Operation

  @Regression @TMS @Smoke @API @WEB @Load_Posting_And_Tracking @SingleCurrency @TransCore @2513 @Debugging
  Scenario: 2513 - TransCore API- Get Truck Postings Operation

    When Login into Salesforce
    Then Delete Field with Title "TransCoreGetTruckPostingsOperation"
    #Steps1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    And Wait for "4" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |Enable Packet Replay|
      | true            |true                |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Wait for "1" Seconds
    Then Switch to Parent Frame
    #Step 2, 3, 4, 5, 6,7 &8
    Then Get "TransCoreGetTruckPostingsOperation-2513.txt" files and update below Attributes
      |{CurrentDate}                  |
      |0        |
    Then Save it with FileName "TransCoreGetTruckPostingsOperation.txt"
    Given Upload File "U_TransCoreGetTruckPostingsOperation.txt" with Title "TransCoreGetTruckPostingsOperation"

      #Step 9
    Then Open "Loads" from App Launcher
#    Then Open Load Number "L-232"
    Then Select Customer Details and Load Type
      |Load_Num | Customer     |     Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Hamilton Hockey Supplies | Truckload      | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA              | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                 | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza    |  3            | NA                       | NA             | NA                   |

    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas       | 15000   | NA           | NA       | NA             |

    Then Save Load With All details
    Then "Without Capture" and Close all the Toast messages from Bottom
    Then Capture the current URL for "Load_Details"

    #Step 10
    Then Select the + action next to the "TransCore" integration listing
    #Expected Result a
    Then Verify Message displaying with Text "TransCore: This load was successfully posted."
    Then "Capture" and Close all the Toast messages from Bottom
    Then Get Attribute "token" store into "Token" from "LLIB_DAT" "Response"
    Then Wait for "5" Seconds

    #Step 11
    Then Go to "Find Carriers" Tab
    Then "Capture" and Close all the Toast messages from Bottom
    #Expected Result b
    Then Verify url displaying with "LLIB_LdLeadsView" as "https://azuatfmintegration.loadlink.ca/api/LoadLead/INTREVO/ad828a6d-30c5-44d0-817d-0aa68b0faca0/qa@revenova.com/{SysData=>Token}/LLIB_DAT/LLIB_LdLeadsView"
    #Step 12
    Then Scroll into Section "Out of Network"
    Then Click on "Out of Network" with Text
    #Expected Result c
    Then Verify Table details with Reference of "Carrier" as "Deliveron Transport Ltd"
      |Source                   |Domicile	|MC Number         |DOT Number  |Contact                |Phone|Email|Postings|
      |TransCore              	|           |                  |            |Deliveron Transport Ltd |(289) 801-1326| deliverontransport.on@gmail.com|1|

    #Step 13
    Then Scroll into Section "Truck Postings"
    #Expected Result d
    Then Verify Table details with Reference of "Origin" as "Hamilton, ON"
      |Carrier                |Contact                 |Phone|Email                        |Source                      |Equipment 	|Qty |Available|Range |Destination |Range_2|Age (min)|
      |Deliveron Transport Ltd|Deliveron Transport Ltd |(289) 801-1326|  deliverontransport.on@gmail.com|TransCore	    |Van        |1   |-1       |23.1  |Chicago, IL |26.1 |Custom   |