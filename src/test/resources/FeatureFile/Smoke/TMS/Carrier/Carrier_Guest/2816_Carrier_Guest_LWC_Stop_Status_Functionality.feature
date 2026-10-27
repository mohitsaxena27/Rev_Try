Feature: 2816 - Carrier Guest LWC - Stop Status: Functionality

  @Regression @TMS @Priority_1 @WEB @SingleCurrency @Carrier @Headed @Carrier_Guest @2816
  Scenario: 2816 - Carrier Guest LWC - Stop Status: Functionality

    When Login into Salesforce
#    Then Delete All Records with name "L-" for "rtms__Load__c"
    #Step1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Customer Invoice Documents" Tab
    Then Switch to Frame by Title "accessibility title"
    Then "Bill Of Lading" : Select "Carrier Upload" as "True"
    Then Click on button with Title "Save"

    #Step 2
    Then Go to Home Page
    Then Run "QueuedTransactionJob" Job

    #Step 3
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      | Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      | 1L       | Boston Beans | Truckload | Dry Van 53     | N             | N                 |
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 1             | NA                       | NA               | NA                   |
    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value         | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Chicago Pizza | 4             | NA                       | NA               | NA                   |
    Then Add Line Items - Quick View
      | Line_Item | PickUp | Delivery | Description | Weight | Weight_Units | HU_Count | Handling_Units |
      | 1         | P1     | D2       | Bananas     | 15000  | NA           | NA       | NA             |

    Then Save Load With All details
    Then Capture the current URL for "Load_1"

    #Step 4
    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "8" Seconds
    Then Enter Carrier Service as "Email Carrier One - Truckload"
    Then "Assign" Carrier
    Then Wait for "2" Seconds

    #Step 5
    Then Go to "Summary" Tab
    Then Click on Native "Request Carrier Status" icon

    #Step 6
    Then Set "Email_Subject" with "Load Status Request for SysData=>1L"
    Then Wait for Email to Receive On Email

    Then Get "Update Status" link from Email for Subject "SysData=>Email_Subject"
    Then Launch browser and Navigate Link
    Then Guest - Move to Element "Search..."
    Then Wait for "2" Seconds

    #Step 7
    Then Guest - Click on button with Text "SysData=>1L"
    Then Wait for "2" Seconds

    #Step 8
    Then Guest - Click on button with Text "En Route"

    #Step 9 and expected result a
    Then Guest - Update details
      | ETA Date | Time |
      | 0        | 06   |
    Then Guest - Click on button with Text "Send Update"
    Then Guest - Verify Text displaying as "Please enter 24-hour time, such as \"0130\" or \"2230\""

    #Step 10 and expected result b
    Then Guest - Update details
      | Time | Where are you now? | .  | Carrier Status | Comments   |
      | 0600 | Boston             | MA | No Issues      | testing123 |
    Then Guest - Click on button with Text "On Schedule"
    Then Guest - Click on button with Text "Send Update"
    Then Guest - Click on button with Text "Success - Pickup/Delivery Status"
    Then Set "CurrentTime_1" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 11 and expected result c
    Then Guest - Update details
      | Driver Name | Driver Phone |
      | Ben Stiller | 914 123 4567 |
    Then Guest - Click on button with Text "Confirm/Update"
    Then Guest - Verify Text displaying as "Success - Pickup/Delivery Status"
    Then Set "CurrentTime_2" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 12 and expected result d
    Then Wait for "5" Seconds
    Then Refresh current Page
    Then Wait for "180" Seconds
    Then Refresh current Page
    Then Verify "Load Status" having value of "Dispatched"

  #Step 13 and expected result e
    Then Navigate to stored URL for "Load_1"
    Then Go to "Snapshot" Tab
    Then Verify Details
      | Driver Name | Driver Phone | Last Reported Location | Schedule Status |
      | Ben Stiller | 914 123 4567 | Boston, MA             | On Schedule     |

    #Step 14 and expected result f
    Then Go to "Shipment" Tab
    Then Verify details for
      | Carrier ETA Date | Carrier ETA Time | Stop Status | Carrier Status | Carrier Status Comments |
      | 0                | 06:00            | En Route    | No Issues      | testing123              |

 #Step 15 and expected result g
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking Information"
    Then Verify Details
      | Last Tracking Update   |
      | SysData=>CurrentTime_1 |


#Step 16 and expected result h
    Then Go to "Shipment" Tab
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "1" Seconds
    Then Verify "" data is created with following details
      | Type            | Reported Location | Comments   | Status As Of           | Update Received At     | Source  |
      | Location Update | Boston, MA        | testing123 | SysData=>CurrentTime_1 | SysData=>CurrentTime_1 | Carrier |

    #Step 17
    Then Wait for "2" Seconds
    Then Guest - Click on button with Text "Arrived"
    Then Set "CurrentTime_3" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 18 and expected result i
    Then Guest - Update details
      | Arrival Date | In Time | Carrier Status | Comments   |
      | 0            | 12:35   | Checked In     | testing456 |
    Then Guest - Click on button with Text "Send Update"
    Then Guest - Verify Text displaying as "Success - Pickup/Delivery Status"
    Then Wait for "80" Seconds

    #Step 19  and expected result j
    Then Navigate to stored URL for "Load_1"
    Then Wait for "80" Seconds
    Then Scroll into Section "Boston Beans"
    Then Wait for "10" Seconds
    Then Verify details for
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments |
      | 0            | 12:35        | Arrived     | Checked In     | testing456              |

  #Step 20  and expected result k
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking Information"
    Then Verify Details
      | Last Tracking Update   |
      | SysData=>CurrentTime_3 |

    #Step 21 and expected result L
    Then Go to "Shipment" Tab
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "80" Seconds
    Then Verify "" data is created with following details
      | Type            | Reported Location | Comments                                   | Status As Of           | Update Received At     | Source  |
      | Location Update | Boston, MA US     | Arrived Boston Beans - Stop 1 - testing456 | SysData=>CurrentTime_3 | SysData=>CurrentTime_3 | Carrier |

    #Step 22
    Then Guest - Click on button with Text "2"
    Then Guest - Click on button with Text "Departed"
    Then Guest - Click on "2" "Departed" text

    #Step 23
    Then Guest - Update details
      | Arrival Date | In Time | Departure Date | Out Time | Carrier Status | Comments   | Have POD images/photos?  Upload them now. |
      | 4            | 0600    | 4              | 1200     | Loaded Clean   | testing789 | Bill Of Lading                            |
    Then Wait for "2" Seconds
    Then Guest - Update details
      | Upload Files      |
      | regularhogpng.png |
    Then Guest - Click on button with Text "Done"
    Then Wait for "2" Seconds
    Then Guest - Update details
      | Upload Files   |
      | regularhog.gif |
    Then Guest - Click on button with Text "Done"
    Then Wait for "5" Seconds
    Then Guest - Update details
      | Upload Files |
      | bighog.jpg   |
    Then Wait for "5" Seconds
    Then Guest - Click on button with Text "Done"
    Then Wait for "5" Seconds
    Then Guest - Click on button with Text "Send Update"

    #Step 24
    Then Set "CurrentTime_4" with "M/d/yyyy, h:mm a" Format and "America/Chicago" Timezone

    #Step 25 and expected result m
    Then Guest - Verify Text displaying as "regularhog.gif"
    Then Guest - Verify Text displaying as "regularhogpng.png"
    Then Guest - Verify Text displaying as "bighog.jpg"

    #Step 26 and expected result n
    Then Guest - Click on button with Text "Return to Load List"

  #Step 27 and expected result o
    Then Close Guest Browser
    Then Wait for "5" Seconds
    Then Refresh current Page
    Then Wait for "90" Seconds
    Then Refresh current Page
    Then Verify "Load Status" having value of "Delivered"


    #Step 28 and expected result p
    Then Wait for "80" Seconds
    Then Scroll into Section "Chicago Pizza"
    Then Wait for "5" Seconds
    Then Verify details for
      | Arrival Date | Arrival Time | Stop Status | Carrier Status | Carrier Status Comments | Departure Date | Departure Time |
      | 4            | 06:00        | Departed    | Loaded Clean   | testing789              | 4              | 12:00          |

    #Step 29 and expected result q
    Then Go to "Details" Tab
    Then Scroll into Section "Tracking Information"
    Then Verify Details
      | Last Tracking Update   |
      | SysData=>CurrentTime_4 |

    #Step 30 and expected result r
    Then Go to "Shipment" Tab
    Then Scroll into Section "Tracking Log"
    Then Click on "Tracking Log" with Text
    Then Wait for "1" Seconds
    Then Verify "" data is created with following details
      | Type            | Reported Location | Comments                                             | Status As Of           | Update Received At     | Source  |
      | Location Update | Chicago, IL US    | Arrived/Departed Chicago Pizza - Stop 2 - testing789 | SysData=>CurrentTime_4 | SysData=>CurrentTime_4 | Carrier |

#  Step 31 and expected reult s
    Then Go to "Documents" Tab
    Then Verify Text displaying as "regularhog.gif"
    Then Verify Text displaying as "regularhogpng.png"
    Then Verify Text displaying as "bighog.jpg"