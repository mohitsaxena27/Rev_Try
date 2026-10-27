Feature: 3156 - Fleet Management Console LWC- Column Header Actions- Format/Functionality

  @Regression @Smoke @WEB @FMS @SingleCurrency @Fleet_Management_Console @3156
  Scenario: 3156 - Fleet Management Console LWC- Column Header Actions- Format/Functionality

    When Login into Salesforce
    #Step 1
    Then Open "Fleet Management Console" from App Launcher
    Then Wait for "6" Seconds
    Then Fleet Management Console - Wait for Page Load
    Then Update details
      | Page                 |
      | Fleet Management |
    Then Wait for "2" Seconds
    Then Click on View Manager icon
    Then De-Select View Manager as "Division Two Tractors"
    Then Select View Manager as "Division One Tractors"
    Then Wait for "1" Seconds
    #Step 2
    Then Scroll into Section "View - Fleet Asset"
    Then Verify Title displaying as "Division One Tractors"
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    #Expected a
    Then Verify following Actions are displaying for "View - Fleet Asset"
         |Wrap text|Clip text|Logic Filters|Clear Logic Filters|Value Filter|Clear Value Filter|Reset Column Sizes|
         |Wrap text|Clip text|Logic Filters|Clear Logic Filters|Value Filter|Clear Value Filter|Reset Column Sizes|
    #Step 3
    Then Click on "Value Filter" Text under "View - Fleet Asset"
    Then Wait for "2" Seconds
    #Expexted b
    Then Verify Text "Fleet Asset" displaying on Modal
    Then Verify Text "Save" displaying on Modal
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button on modal
    Then Verify Fleet Assets renders Light aligned with One per Row and alphabetical-numeric order

    #Step 4
    Then Select "Tractor 1000" within the fleet asset list
    Then Select "Tractor 1001" within the fleet asset list
    Then Select "Tractor 1002" within the fleet asset list
    #Expexted c
    Then Verify "Tractor 1000" selected and bolded

    #Step 5
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds
    #Expected d
    Then Verify Modal close
    Then Verify "View - Fleet Asset" Table count is "3"
    Then Verify "Tractor 1000" Text under "View - Fleet Asset"
    Then Verify "Tractor 1001" Text under "View - Fleet Asset"
    Then Verify "Tractor 1002" Text under "View - Fleet Asset"
    Then Verify Fleet Asset column header has a "Purple" filter icon

     #Step 6
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Clear Value Filter" Text under "View - Fleet Asset"
    Then Wait for "4" Seconds
    #Expected e
    Then Verify "View - Fleet Asset" Table count is more than "3"
    Then Verify Fleet Asset column header has no filter icon

    #Step 7
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Logic Filters" Text under "View - Fleet Asset"
    #Expected f
    Then Verify Text "Fleet Asset" displaying on Modal
    Then Verify Text "Save" displaying on Modal
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button on modal
    Then Verify "View - Fleet Asset" details
         |Not  |Operator|Value|
         |True |Equals  |     |
    Then Verify title "Add" under "View - Fleet Asset" Section
    Then verify "utility:close" icon is displaying on modal

     #Step 8
    Then Update "View - Fleet Asset" details
      |Not   |
      |False |
    Then Wait for "2" Seconds
    #Expected g
    Then Verify "View - Fleet Asset" details
      |Not     |Operator|Value|
      |False   |Equals  |     |

    #Step 9 & Expected h
    Then Verify Select Label "Operator" having following values
         |Equals|Contains|Starts With|Ends With|Value In|
         |Equals|Contains|Starts With|Ends With|Value In|
    #Step 10
    Then Update "View - Fleet Asset" details
      |Operator   |Value|
      |Equals     |Tractor 1000|
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds
    #Expected i
    Then Verify Modal close
    Then Verify "View - Fleet Asset" Table count is "1"
    Then Verify "Tractor 1000" Text under "View - Fleet Asset"

      #Step 11
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Clear Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "4" Seconds
    #Expected j
    Then Verify "View - Fleet Asset" Table count is more than "1"
    Then Verify Fleet Asset column header has no filter icon

    #Step 12
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "2" Seconds
    Then Update "View - Fleet Asset" details
      |Not  |Operator|Value            |
      |True |Equals  |Tractor 1000     |
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds
    #Expected k
    Then Verify Modal close
    Then Verify "Tractor 1000" Text not displaying under "View - Fleet Asset"

    #Step 13
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "2" Seconds
    Then Update "View - Fleet Asset" details
      |Not  |Operator    |
      |False |Contains   |
     #Expected l
    Then Verify "View - Fleet Asset" details
      |Not     |Operator  |Value|
      |False   |Contains  |  |

    Then Update "View - Fleet Asset" details
         |Value|
         |100  |
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds
     #Expected m
    Then Verify Modal close
    Then Verify "View - Fleet Asset" Table count is "10"
    Then Verify "Tractor 1000" Text under "View - Fleet Asset"
    Then Verify "Tractor 1001" Text under "View - Fleet Asset"
    Then Verify "Tractor 1002" Text under "View - Fleet Asset"
    Then Verify "Tractor 1003" Text under "View - Fleet Asset"
    Then Verify "Tractor 1004" Text under "View - Fleet Asset"
    Then Verify "Tractor 1005" Text under "View - Fleet Asset"
    Then Verify "Tractor 1006" Text under "View - Fleet Asset"
    Then Verify "Tractor 1007" Text under "View - Fleet Asset"
    Then Verify "Tractor 1008" Text under "View - Fleet Asset"
    Then Verify "Tractor 1009" Text under "View - Fleet Asset"

      #Step 14
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Clear Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "4" Seconds

    #Step 15
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "2" Seconds
    Then Update "View - Fleet Asset" details
      |Not  |Operator    |Value|
      |False |Ends With   |09  |
    #Step 16
    Then Click on button with Title "Add" on Modal
    Then Wait for "2" Seconds
    #Expected n
    Then Verify "View - Fleet Asset" details
      |AND |OR   |Not_2     |Operator_2  |Value_2|
      |True|False|True      |Equals      |       |
    Then Verify title "Add" is disabled under "View - Fleet Asset" Section
    Then Verify title "Remove" under "View - Fleet Asset" Section

    #Step 17
    Then Update "View - Fleet Asset" details
      |Not_2  |Operator_2      |Value_2|
      |False  |Starts With   |Tract  |
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds
    Then Verify Modal close
    #Expected o
    Then Verify "View - Fleet Asset" Table count is "1"
    Then Verify "Tractor 1009" Text under "View - Fleet Asset"

    #sStep 18
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Clear Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "4" Seconds

    #Step 19
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "2" Seconds
    Then Update "View - Fleet Asset" details
      |Not  |Operator    |Value         |
      |False |Value In   |Tractor 1000  |
    Then Wait for "1" Seconds
    Then Click on button with Title "Input" on Modal
    Then Wait for "1" Seconds
    Then Update "View - Fleet Asset" details
      |Value         |
      |Tractor 1001  |
    Then Wait for "2" Seconds
    Then Click on button with Title "Input" on Modal
    Then Wait for "1" Seconds
    Then Update "View - Fleet Asset" details
      |Value         |
      |Tractor 1002  |
    Then Wait for "1" Seconds
    Then Click on button with Title "Input" on Modal
    Then Wait for "1" Seconds
    Then Update "View - Fleet Asset" details
      |Value         |
      |Tractor 1001  |
    Then Wait for "2" Seconds
    #STep 20
    Then Click on button with Title "Add" on Modal
    Then Wait for "2" Seconds
    Then Update "View - Fleet Asset" details
      |Not_2  |Operator_2       |Value      |OR|
      |False |Equals            |Tractor 1003  |True|
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds
    Then Verify Modal close
    #Expected P
    Then Verify "View - Fleet Asset" Table count is "4"
    Then Verify "Tractor 1000" Text under "View - Fleet Asset"
    Then Verify "Tractor 1001" Text under "View - Fleet Asset"
    Then Verify "Tractor 1002" Text under "View - Fleet Asset"
    Then Verify "Tractor 1003" Text under "View - Fleet Asset"

    #Step 21
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Clear Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "4" Seconds

     #Step 22
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "2" Seconds
    Then Update "View - Fleet Asset" details
      |Not  |Operator    |Value         |
      |False |Equals   |Tractor 1003  |
    Then Wait for "1" Seconds

    #Step 23
    Then Click on button with Title "Add" on Modal
    Then Wait for "2" Seconds
    Then Update "View - Fleet Asset" details
      |Not_2  |Operator_2       |Value_2|
      |False  |Value In   |Tractor 1000  |
    Then Wait for "1" Seconds
    Then Click on button with Title "Input" on Modal
    Then Wait for "1" Seconds
    Then Update "View - Fleet Asset" details
      |Value_2         |
      |Tractor 1001  |
    Then Wait for "1" Seconds
    Then Click on button with Title "Input" on Modal
    Then Wait for "1" Seconds
    Then Update "View - Fleet Asset" details
      |Value_2        |
      |Tractor 1002  |
    Then Wait for "1" Seconds
    Then Click on button with Title "Input" on Modal
    Then Wait for "1" Seconds
    Then Update "View - Fleet Asset" details
      |Value_2        |OR|
      |Tractor 1001  |True|
    Then Wait for "1" Seconds
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds
    Then Verify Modal close

    #Expected q
    Then Verify "View - Fleet Asset" Table count is "4"
    Then Verify "Tractor 1000" Text under "View - Fleet Asset"
    Then Verify "Tractor 1001" Text under "View - Fleet Asset"
    Then Verify "Tractor 1002" Text under "View - Fleet Asset"
    Then Verify "Tractor 1003" Text under "View - Fleet Asset"

    #Step 24
    Then "Company_Division" Column - drag the border to change the column size for "Company/Division column width" under "View - Fleet Asset"

    #Step 25
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Reset Column Sizes" Text under "View - Fleet Asset"
    Then Wait for "4" Seconds
    #Expected r
    Then Verify "Company/Division column width" size is "50" under "View - Fleet Asset"

    #Step 26
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Clear Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "4" Seconds

    #Step 27
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Value Filter" Text under "View - Fleet Asset"
    Then Wait for "2" Seconds
    Then Select "Tractor 1000" within the fleet asset list
    Then Select "Tractor 1001" within the fleet asset list
    Then Select "Tractor 1002" within the fleet asset list
    Then Select "Tractor 1003" within the fleet asset list
    Then Select "Tractor 1004" within the fleet asset list
    Then Select "Tractor 1005" within the fleet asset list
    Then Select "Tractor 1010" within the fleet asset list
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds

    #Step 28
    Then Click on "Show Fleet Asset column actions" under "View - Fleet Asset" Section
    Then Wait for "2" Seconds
    Then Click on "Logic Filters" Text under "View - Fleet Asset"
    Then Wait for "2" Seconds
    Then Update "View - Fleet Asset" details
      |Not  |Operator    |Value         |
      |False |Starts With   |Tractor 100  |
    Then Wait for "1" Seconds
    Then Click button with Text "Save" on Modal
    Then Wait for "2" Seconds
    Then Verify Modal close
     #Expected s
    Then Verify "View - Fleet Asset" Table count is "6"
    Then Verify "Tractor 1000" Text under "View - Fleet Asset"
    Then Verify "Tractor 1001" Text under "View - Fleet Asset"
    Then Verify "Tractor 1002" Text under "View - Fleet Asset"
    Then Verify "Tractor 1003" Text under "View - Fleet Asset"
    Then Verify "Tractor 1004" Text under "View - Fleet Asset"
    Then Verify "Tractor 1005" Text under "View - Fleet Asset"
    Then Verify "Tractor 1010" Text not displaying under "View - Fleet Asset"