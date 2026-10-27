Feature:3146 - Fuel Surcharge LWC - Format and Functionality


  @Regression @TMS @Smoke @WEB @Admin @SingleCurrency @Fuel_Surcharge @3146
  Scenario: 3146 - Fuel Surcharge LWC - Format and Functionality

    When Login into Salesforce
    Then Delete All Records with name "Testing" for "rtms__FuelSurcharge__c"
  # Step 1
    Then Go to Home Page
    Then Run "FuelIndexUpdateJob" Job
    Then Wait for "6" Seconds

  # Step 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Fuel Surcharges" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    And Click on Button with Value "New Fuel Surcharge" -
    Then Switch to Parent Frame
    #Expected Result a.1
    Then Verify Icon "custom:custom109" is displaying with background color "Orange"
    Then Verify "White" Color with "SteelBlue" Text of "Cancel" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "Done" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Build Entry Table" Button is "Enabled"
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button is "Enabled"
    #Expected Result a.2
    Then Verify Layout "Fuel Surcharge Type and Range" Text with Background Color "LightGray" is displaying
    Then Verify Layout "Fuel Surcharge Entries" Text with Background Color "LightGray" is displaying
    Then Verify Layout "Fuel Index History" Text with Background Color "LightGray" is displaying
   #Expected Result a.3, 4 , 5
    Then Verify details for all Required Enabled fields
      |Name       |Fuel Surcharge Source  |Fuel Index        |Current Week Start Day     |Fuel Index Value|Fuel Index Start|Fuel Index End|Fuel Index Increment|Type|
      |           |TMS                    |                  |Monday                     |                |                |              |                    |Percent of Line Haul|
    Then Verify details for all Required Enabled fields
      |Percent Start|Percent Increment|Auto-Update Quotes/Invoices|
      |             |                 |Yes                           |
    Then Verify Text displaying as "Fuel Surcharge Entries" with "font-weight" as "bold"
    Then Verify Text displaying as "Entry" with "font-weight" as "bold"
    Then Verify Text displaying as "From Value (>=)" with "font-weight" as "bold"
    Then Verify Text displaying as "To Value (<)" with "font-weight" as "bold"
    Then Verify Text displaying as "Percent" with "font-weight" as "bold"
    Then Verify Text displaying as "Fuel Index History" with "font-weight" as "bold"
    Then Verify Text displaying as "Effective Date" with "font-weight" as "bold"
    Then Verify details for all Enabled fields
    |Ship Date|
    |         |
    Then Verify Text displaying as "Index Effective Value"
    Then Verify Text displaying as "Value" with "font-weight" as "bold"

   #Step 3
    Then Wait for "3" Seconds
    Then Move hover on Tooltip for "Fuel Index"
    #Expected b
    Then Verify Help Text displaying as "Select the fuel index used to calculate fuel surcharges"
    Then Move hover on Tooltip for "Current Week Start Day"
    #Expected c
    Then Verify Help Text displaying as "Select the starting day of the \"current week\".  For example:  Monday = (Monday through Sunday), Tuesday = (Tuesday through Monday).  This determines what index will be applied."
    Then Move hover on Tooltip for "Fuel Index Value"
    #Expected d
    Then Verify Help Text displaying as "Select what fuel index will be used in the calculation.  For example:  Current Week = the index value from the week of the ship date.  Prior Week = the index value from the week prior to the ship date"
    Then Move hover on Tooltip for "Type"
    #Expected e
    Then Verify Help Text displaying as "Type of fuel surcharge table.  Rate per mile, Rate per kilometer or Percent of Line Haul (Freight Charges)"
    Then Move hover on Tooltip for "Auto-Update Quotes/Invoices"
    #Expected f
    Then Verify Help Text displaying as "Auto-update fuel on pending quotes and invoices if the underlying fuel index changes"
    Then Update details
        |Type|
        |Rate per Kilometer|
    Then Wait for "2" Seconds
   #Expected g
    Then Verify details for all Required Enabled fields
         |Rate Start|Rate Increment|
         |          |              |
    Then Update details
      |Type|
      |Rate per Mile|
    Then Wait for "2" Seconds
    #Expected h
    Then Verify details for all Required Enabled fields
      |Rate Start|Rate Increment|
      |          |              |
    Then Verify Text displaying as "Rate" with "font-weight" as "bold"
    Then Update details
         |Fuel Surcharge Source|
         |Breakthrough Fuel    |
    Then Wait for "2" Seconds
     #Expected i
    Then Verify Text not displaying as "Build Entry Table"
    Then Verify Layout "Fuel Surcharge Type and Range" Text with Background Color "LightGray" is displaying
    Then Verify details for all Required Enabled fields
      |Name       |Fuel Surcharge Source  |
      |           |Breakthrough Fuel                   |
    Then Verify Label "Fuel Surcharge Entries" not displaying on Page
    Then Verify Label "Fuel Index History" not displaying on Page

    #Step 4
    Then Update details
      |Fuel Surcharge Source|
      |TMS   |
    Then Wait for "2" Seconds
    Then Click on button with Title "Build Entry Table"
    #Expected j
    Then Verify Text displaying as "Warning - Fuel Surcharge" -
    Then Verify Message displaying as "You are missing required fields. Please enter all required fields."

    Then Click on button with Title "Save"
    #Expected k
    Then Verify Text displaying as "Warning - Fuel Surcharge" -
    Then Verify Message displaying as "You are missing required fields. Please enter all required fields."

   #Step 5
    Then Update details
      | Name         | Fuel Index                             |
      | Testing      | U.S. No 2 Diesel Retail Prices, Weekly |
    Then Wait for "1" Seconds

    #Expected l
    Then Fuel Surcharge : Verify Fuel Index History column
    Then Update details
      | Current Week Start Day | Fuel Index Value | Fuel Index Start | Fuel Index End | Fuel Index Increment | Type                 |
      | Monday                 | Current Week     | 1                | 5             | 0.4                   | Rate per Mile |
   Then Wait for "2" Seconds
      Then Update details
       |Type|
       |Percent of Line Haul|
    Then Update details
      | Percent Start | Percent Increment |Auto-Update Quotes/Invoices| Ship Date |
      | 0.1        |  .205               |Yes                         | 0         |

    #Step 6
    Then Click on button with Title "Save"
    #Expected m
    Then Verify Error Message displaying as "The user does not have access to the following record Id:User User:null"
    Then Verify Message displaying as "Save was successful."
    #Step 7
    Then Click on button with Title "Done"
    #Expected n
    Then Verify url contains "rtms__TMS_Admin2"
    #Step 8
    Then Go to "Fuel Surcharges" Tab
    Then Wait for "3" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Testing" with Text -
    Then Wait for "2" Seconds
    Then Switch to Parent Frame
    #Step 9 & Expected O
    Then Verify details for all Disabled or Readonly fields
      | Fuel Surcharge Source         |Fuel Index|
      | TMS      |U.S. No 2 Diesel Retail Prices, Weekly|

    Then Verify details for all Required Enabled fields
      |Name   | Current Week Start Day | Fuel Index Value | Fuel Index Start | Fuel Index End | Fuel Index Increment | Type                 | Percent Start | Percent Increment |Auto-Update Quotes/Invoices|
      |Testing| Monday                 | Current Week     | 1                | 5             | 0.4                   | Percent of Line Haul | 0.1        |  .205               |Yes                         |

    Then Verify details for all Enabled fields
    |Ship Date|
    |         |
    Then Verify Text displaying as "Index Effective Value"
    Then Verify Text displaying as "Value" with "font-weight" as "bold"
    Then Fuel Surcharge : Verify Fuel Index History column
    Then Set Key "Fuel_Surcharge_Records" page Record Id with "rtms__FuelSurcharge__c"

    #Step 10
    Then Click on button with Title "Cancel"
     #Expected p
    Then Verify url contains "rtms__TMS_Admin2"

    #Step 11
    Then Go to "Fuel Surcharges" Tab
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Testing" with Text -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds
    # Expected q
    Then Verify details for all Disabled or Readonly fields
      | Fuel Surcharge Source         |Fuel Index|
      | TMS      |U.S. No 2 Diesel Retail Prices, Weekly|

    Then Verify details for all Required Enabled fields
      |Name   | Current Week Start Day | Fuel Index Value | Fuel Index Start | Fuel Index End | Fuel Index Increment | Type                 | Percent Start | Percent Increment |Auto-Update Quotes/Invoices|
      |Testing| Monday                 | Current Week     | 1                | 5             | 0.4                   | Percent of Line Haul | 0.1        |  .205               |Yes                         |

    Then Verify details for all Enabled fields
      |Ship Date|
      |         |
    Then Verify Text displaying as "Index Effective Value"

    #Step 12
    Then Click on button with Title "Build Entry Table"
    #Expected r
    Then Verify Message displaying as "Save was successful."
    Then verify fuel surcharge table
      | Entry    | From Value | To Value | Percent |
      | Entry 1  | USD 1.000  | USD 1.400 | 0.100% |
      | Entry 2  | USD 1.400  | USD 1.800 | 0.305% |
      | Entry 3  | USD 1.800  | USD 2.200 | 0.510% |
      | Entry 4  | USD 2.200  | USD 2.600 | 0.715% |
      | Entry 5  | USD 2.600  | USD 3.000 | 0.920% |
      | Entry 6  | USD 3.000  | USD 3.400 | 1.125% |
      | Entry 7  | USD 3.400  | USD 3.800 | 1.330% |
      | Entry 8  | USD 3.800  | USD 4.200 | 1.535% |
      | Entry 9  | USD 4.200  | USD 4.600 | 1.740% |
      | Entry 10 | USD 4.600  | USD 5.000 | 1.945% |

    #Step 13
    Then Update details
       | Fuel Index Start | Fuel Index End | Fuel Index Increment | Type                 |
       | 2                | 5             | 0.5                   | Rate per Mile        |
    Then Wait for "2" Seconds
      #Expected s
       Then Verify details for all Required Enabled fields
       |Rate Start|Rate Increment|
       |          |              |
      Then Verify Text displaying as "Rate" with "font-weight" as "bold"
    Then verify fuel surcharge table
      | Entry    | From Value | To Value | Rate |
      | Entry 1  | USD 1.000  | USD 1.400 |     |
      | Entry 2  | USD 1.400  | USD 1.800 |  |
      | Entry 3  | USD 1.800  | USD 2.200 |  |
      | Entry 4  | USD 2.200  | USD 2.600 |  |
      | Entry 5  | USD 2.600  | USD 3.000 |  |
      | Entry 6  | USD 3.000  | USD 3.400 |  |
      | Entry 7  | USD 3.400  | USD 3.800 |  |
      | Entry 8  | USD 3.800  | USD 4.200 | |
      | Entry 9  | USD 4.200  | USD 4.600 | |
      | Entry 10 | USD 4.600  | USD 5.000 |  |

    Then Update details
      | Rate Start  | Rate Increment |
      | 0.25        |  .75               |

    #Step 14
    Then Click on button with Title "Save"

    #Expected T
    Then Verify Message displaying as "Save was successful."
    Then verify fuel surcharge table
      | Entry    | From Value | To Value | Rate |
      | Entry 1  | USD 1.000  | USD 1.400 |     |
      | Entry 2  | USD 1.400  | USD 1.800 |  |
      | Entry 3  | USD 1.800  | USD 2.200 |  |
      | Entry 4  | USD 2.200  | USD 2.600 |  |
      | Entry 5  | USD 2.600  | USD 3.000 |  |
      | Entry 6  | USD 3.000  | USD 3.400 |  |
      | Entry 7  | USD 3.400  | USD 3.800 |  |
      | Entry 8  | USD 3.800  | USD 4.200 | |
      | Entry 9  | USD 4.200  | USD 4.600 | |
      | Entry 10 | USD 4.600  | USD 5.000 |  |

      #Step 15
    Then Click on button with Title "Build Entry Table"
    #Expected u
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
    Then verify fuel surcharge table
      | Entry    | From Value      | To Value     | Rate        |
      | Entry 1  | USD 2.000       | USD 2.500    | USD 0.2500  |
      | Entry 2  | USD 2.500       | USD 3.000    | USD 1.0000  |
      | Entry 3  | USD 3.000       | USD 3.500    | USD 1.7500  |
      | Entry 4  | USD 3.500       | USD 4.000    | USD 2.5000  |
      | Entry 5  | USD 4.000       | USD 4.500    | USD 3.2500  |
      | Entry 6  | USD 4.500       | USD 5.000    | USD 4.0000  |

    #Step 16
    Then Fuel Surcharge : Get Fuel Index Value from "2" Records and store on "Fuel_Index_Value"
    #Step 17
    Then Set "1WeekAgoDate" with "MMMdd,yyyy=>-7"
    Then Update details
      |Ship Date|
      |SysData=>1WeekAgoDate|
    Then Wait for "2" Seconds
    Then Get "Index Effective Value" value and store in "Index_Effective_Value"
    #Expected v
    Then Verify Assertion for "Fuel_Index_Value" contains "SysData=>Index_Effective_Value"
    #Step 18 & 19
    Then Set "1YearAgoDate" with "MMMdd,yyyy=>-365"
    Then Update details
      |Ship Date                 |
      |SysData=>1YearAgoDate     |

    Then Wait for "2" Seconds
    #Expected w
    Then Verify Error Message displaying as "Missing fuel index data prevents completion of this operation."

    #Step 20
    Then Click on button with Title "Edit"
    Then Wait for "2" Seconds

    #expected x
    Then Fuel Surcharge : Verify Entry Field is Readonly
    Then Fuel Surcharge : Verify "From_Value" Field is ediatble
    Then Fuel Surcharge : Verify "To_Value" Field is ediatble
    Then Fuel Surcharge : Verify "Rate" Field is ediatble

    #Step 21
    When Fuel Surcharge : Update Fuel Surcharge Entry
      | Entry | From Value | To Value | Rate   |
      | 1     | 11.11      | 22.22    | 33.33|
      | 2     | 40         | 50       | 60     |
      | 3     | 65         | 75       | 85     |

    #Step 22
    Then Click on button with Title "Edit"
    Then Wait for "2" Seconds
    #expected y
    Then verify fuel surcharge table
      | Entry    | From Value      | To Value     | Rate        |
      | Entry 1  | USD 11.110      | USD 22.220    | USD 33.3300  |
      | Entry 2  | USD 40.000       | USD 50.000    | USD 60.0000  |
      | Entry 3  | USD 65.000       | USD 75.000    | USD 85.0000  |
      | Entry 4  | USD 3.500       | USD 4.000    | USD 2.5000  |
      | Entry 5  | USD 4.000       | USD 4.500    | USD 3.2500  |
      | Entry 6  | USD 4.500       | USD 5.000    | USD 4.0000  |
    
    #Step 23
    Then Click on button with Title "Cancel"

    #STep 24
    Then Go to "Fuel Surcharges" Tab
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Testing" with Text -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #expected z
    Then verify fuel surcharge table
      | Entry    | From Value      | To Value     | Rate        |
      | Entry 1  | USD 2.000       | USD 2.500    | USD 0.2500  |
      | Entry 2  | USD 2.500       | USD 3.000    | USD 1.0000  |
      | Entry 3  | USD 3.000       | USD 3.500    | USD 1.7500  |
      | Entry 4  | USD 3.500       | USD 4.000    | USD 2.5000  |
      | Entry 5  | USD 4.000       | USD 4.500    | USD 3.2500  |
      | Entry 6  | USD 4.500       | USD 5.000    | USD 4.0000  |

   #Step 25
    Then Click on button with Title "Edit"
    Then Wait for "2" Seconds
    When Fuel Surcharge : Update Fuel Surcharge Entry
      | Entry | From Value | To Value | Rate   |
      | 1     | 11.11      | 22.22    | 33.33|
      | 2     | 40         | 50       | 60     |
      | 3     | 65         | 75       | 85     |
    #Step 26
    Then Click on button with Title "Edit"
    #Step 27
    Then Click on button with Title "Done"
    #STep 28
    Then Go to "Fuel Surcharges" Tab
    Then Wait for "1" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Click on "Testing" with Text -
    Then Switch to Parent Frame
    Then Wait for "2" Seconds

    #expected aa
    Then verify fuel surcharge table
      | Entry    | From Value      | To Value     | Rate        |
      | Entry 1  | USD 2.000       | USD 2.500    | USD 0.2500  |
      | Entry 2  | USD 2.500       | USD 3.000    | USD 1.0000  |
      | Entry 3  | USD 3.000       | USD 3.500    | USD 1.7500  |
      | Entry 4  | USD 3.500       | USD 4.000    | USD 2.5000  |
      | Entry 5  | USD 4.000       | USD 4.500    | USD 3.2500  |
      | Entry 6  | USD 4.500       | USD 5.000    | USD 4.0000  |

    #Step 29
    Then Click on button with Title "Edit"
    Then Wait for "2" Seconds
    When Fuel Surcharge : Update Fuel Surcharge Entry
      | Entry | From Value | To Value | Rate   |
      | 1     | 11.11      | 22.22    | 33.33|
      | 2     | 40         | 50       | 60     |
      | 3     | 65         | 75       | 85     |
    #Step 30
    Then Click on button with Title "Save"
    Then Verify Message displaying as "Save was successful."
    Then Wait for "2" Seconds
   #expected ab
    Then verify fuel surcharge table
      | Entry    | From Value      | To Value     | Rate        |
      | Entry 1  | USD 11.110      | USD 22.220    | USD 33.3300  |
      | Entry 2  | USD 40.000       | USD 50.000    | USD 60.0000  |
      | Entry 3  | USD 65.000       | USD 75.000    | USD 85.0000  |
      | Entry 4  | USD 3.500       | USD 4.000    | USD 2.5000  |
      | Entry 5  | USD 4.000       | USD 4.500    | USD 3.2500  |
      | Entry 6  | USD 4.500       | USD 5.000    | USD 4.0000  |

   #Step 31
    Then Click on button with Title "Build Entry Table"
    Then Verify Message displaying as "Save was successful."
        #expected aa
    Then verify fuel surcharge table
      | Entry    | From Value      | To Value     | Rate        |
      | Entry 1  | USD 2.000       | USD 2.500    | USD 0.2500  |
      | Entry 2  | USD 2.500       | USD 3.000    | USD 1.0000  |
      | Entry 3  | USD 3.000       | USD 3.500    | USD 1.7500  |
      | Entry 4  | USD 3.500       | USD 4.000    | USD 2.5000  |
      | Entry 5  | USD 4.000       | USD 4.500    | USD 3.2500  |
      | Entry 6  | USD 4.500       | USD 5.000    | USD 4.0000  |