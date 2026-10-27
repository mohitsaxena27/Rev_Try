Feature: 1579 - AR Calculation Job- Ignore Sharing Settings- TMS Accounting

  Background: Pre- Test
    Then Set key "Jedi_Order_Credit_Limit_Account" for Object "Account" and Name "The Jedi Order Credit Limit"
    Then Delete All Loads associated with "Jedi_Order_Credit_Limit_Account"

  @Regression @TMS @Smoke @API @WEB @Transportation_Profile @SingleCurrency @1579
  Scenario:1579 - AR Calculation Job- Ignore Sharing Settings- TMS Accounting
    When Login into Salesforce
    Then Capture the current URL for "App_Url"
   # Step 1

    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
      |Enforce Customer Credit Limits |
      |True                           |
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

   # Step 2

    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "The Jedi Order Credit Limit" from List
    Then Go to "Credit" Tab
    Then Scroll into Section "Credit Limit Information"
    Then Click on Edit icon on Label "Credit Limit Amount"
    Then Enter Label "Credit Limit Amount" Text as "10000"
    Then Click on "Save" button on Details Page
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"

   # Step 3
      #1st Load

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | The Jedi Order Credit Limit | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Testing    |1200  |NA          |NA       |NA       |
    Then Save Load With All details

   # Step 4

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "1000"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 5
    #2nd Load

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |2L       | The Jedi Order Credit Limit | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value            | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Denver Deli Meats|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Testing    |1200  |NA          |NA       |NA       |
    Then Save Load With All details

   # Step 6
      # Then Open Load Number "L-82"

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "2000"
    Then Update details
      |Status|
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 7

    Then Update details
      |Billing Status|
      |Approved|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 8

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "2L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date     |
      |1                    |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Due Date|
      |1               |

 # Step 9
    #3rd Load

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |3L       | The Jedi Order Credit Limit | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Testing    |1200  |NA          |NA       |NA       |
    Then Save Load With All details

   # Step 10
      # Then Open Load Number "L-82"

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "2000"
    Then Update details
      |Status|
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 11

    Then Update details
      |Billing Status|
      |Approved|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 12

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "3L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date     |Invoice Status|
      |0                    |Approved      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Approved      |


   # Step 13
      #4th Load

    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer                    | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |4L       | The Jedi Order Credit Limit | Truckload | Dry Van 53     | N             | N                 |

    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 1P   | Same_as_Customer | NA    | 0              | NA                       | NA               | NA                   |

    Then Add Location Details
      | Add_Loc | Type | Address_Type    | Value                | Expected_Date | Shipping_Receiving_Hours | Appointment_Time | Appointment_Required |
      | N       | 2D   | Account_Address | Los Angeles Lighting|  1             | NA                       | NA               | NA                   |

    Then Add Line Items - Quick View
      |Line_Item|PickUp|Delivery|Description|Weight|Weight_Units|HU_Count|Handling_Units|
      |1        |P1    |D2      |Testing    |1200  |NA          |NA       |NA       |
     #Steps 2
    Then Save Load With All details

   # Step 14
      #    Then Open Load Number "L-82"

    Then Go to "Freight Quote Assistant" Tab
    Then Wait for "4" Seconds
    Then Enter "Customer Quote Items" "Net Freight Charges" as "3000"
    Then Update details
      |Status  |
      |Accepted|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."

   # Step 15

    Then Update details
      |Billing Status|
      |Approved|
    Then "Save" Customer Quotes
    Then Verify Message displaying as "Save was successful."
    Then Wait for "3" Seconds
    Then Refresh current Page

   # Step 16

    Then Go to "Quotes/Invoices" Tab
    Then Open "Customer Invoices" using value from "4L" on QuoteInvoice Tab
    Then Wait for "2" Seconds
    Then Click on Edit icon on Label "Invoice Due Date"
    Then Update details
      |Invoice Due Date     |Invoice Status|
      |-1                   |Approved      |
    Then Click on "Save" button on Details Page
    Then Verify details for
      |Invoice Status|
      |Approved      |

    Then Wait for "2" Seconds

   # Step 17

    Then Open "Setup" from Setup Icon
    Then Switch Window by index "1"
    Then Wait for "1" Seconds
    Then Update details
      |Quick Find      |
      |Sharing Settings|
    Then Wait for "1" Seconds
    Then Click on "Sharing Settings" with Text
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Sharing Settings"
    Then Verify Text displaying as "Manage sharing settings for:" -
    Then Update details -
      |Manage sharing settings for:|
      |Accounts                    |
    Then Wait for "1" Seconds

     # Step 18
      # Step 18.1

    Then Switch to Frame by Title "Sharing Settings"
    Then Edit Organization-Wide Defaults
    Then Switch to Frame by Title "Organization-Wide Sharing"
    Then Select Text "Private" on Field Title "Account and Contract : Default Access" -
    Then Accept Alert If any
    Then Accept Alert If any
    Then Accept Alert If any
    And Click on Button with Value " Save " -
    Then Accept Alert If any
    Then Wait for "1" Seconds

     # { To complete the 18.1 There are three steps to perform which is mentioned below}
   # Step 18.1
      # 1)

    Then Switch to Frame by Title "Sharing Settings"
    Then Edit Organization-Wide Defaults
    Then Switch to Frame by Title "Organization-Wide Sharing"
    Then Select Text "Private" on Field Title "Load : Default Access" -
    And Click on Button with Value " Save " -
    Then Accept Alert If any
    Then Switch to Parent Frame

   # Step 18.1
       # 2)

    Then Update details -
      |Quick Find      |
      |Permission sets |

    Then Wait for "1" Seconds
    Then Click on "Permission Sets" with Text
    Then Switch to Frame by Title "Permission Sets"
    Then Verify Text displaying as "On this page you can create, view, and manage permission sets." -
    Then Click on "T" with Text -
    Then Click on "TMS Developer" "Clone" Action -
    Then Switch to Frame by Title "Permission Set: Clone:"
    Then Enter Label "Label" Text as "A/R Calc Testing TMS Developer 1579" -
    Then Enter Label "API Name" Text as "AR_Calc_Testing_TMS_Developer_1579" -

   # Step 18.1
      # 3)

    And Click on Button with Value "Save" -
    And Check if already Exist
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "Permission Sets"
    Then Click on "A" with Text -
    Then Click on Partial Link Text "A/R Calc Testing" on Page -

   # Step 18.2
      # 2)
    Then Switch to Frame by Title "Permission Set"
    Then Click on "Object Settings" with Text -
    Then Switch to Frame by Title "Permission Set"
    Then Click on "Loads" with Text -
    Then Switch to Frame by Title "Permission Set"
    Then Click on "Loads" "Edit" Action -
    Then Switch to Frame by Title "Permission Set"
    Then Set Permission "View All Fields" as "true"

   # Step 18.2
      # 3)

    And Click on Button with Value "Save" -
    Then Wait for "2" Seconds

   # Step 18.3
      # 1)

    Then Switch to Parent Frame
    Then Update details
      |Quick Find   |
      |User         |
    Then Wait for "1" Seconds
    Then Click on "ManageUsers" with href
    Then Switch to Frame by Title "All ~ Salesforce - Enterprise Edition"
    Then Click on "User, Second" with Contains Text -
    Then Switch to Frame by Title "User:"

   # Step 18.3
      # 2)

    Then Click on "Permission Set Assignments" with Contains Text -
    Then Click on "Edit Assignments" button on "Permission Set Assignments" Page -

   # Step 18.3
     # 3) 4) { Step number Both (3 , 4) are executed in following two steps are written below)

    Then Switch to Frame by Title "Permission Set Assignments:"
    Then Move "A/R Calc Testing TMS Developer 1579" to enable

   # Step 18.3
     # 5)

    And Click on Button with Value "Save" -
   # Step 18.3
     # 6)
    Then Switch to Frame by Title "User:"
    Then Login With User
    Then Switch to Parent Frame
    Then Wait for "7" Seconds
    Then Verify Text displaying as "Logged in as Second User" -
    Then Run "ARCalculationJob" Job
    Then Wait for "2" Seconds
    Then Click on "Log out as Second User" with Text -

   # Steps to verify expected results for TP values
    Then Navigate to stored URL for "App_Url"
    When Login into Salesforce
    Then Open "Transportation Profiles" from App Launcher
    Then Search and Select "The Jedi Order Credit Limit" from List
    Then Go to "Credit" Tab
    Then Scroll into Section "Credit Limit Information"
    Then Verify "Credit Limit Amount" having value of "USD 10,000.00"
    Then Verify "Credit Limit Utilized" having value of "80.00%"
    Then Verify "A/R Unbilled" having value of "USD 3,000.00"
    Then Verify "A/R Current" having value of "USD 2,000.00"
    Then Verify "A/R Past Due" having value of "USD 3,000.00"
    Then Verify "Credit Limit Available" having value of "USD 2,000.00"
    Then Verify "Unapplied Cash/Credit Memos" having value of "USD 0.00"
    Then Close Current Tab
    Then Switch to Parent Window
