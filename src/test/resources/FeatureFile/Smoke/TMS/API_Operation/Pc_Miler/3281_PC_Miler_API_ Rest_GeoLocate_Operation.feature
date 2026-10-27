Feature: 3281 - PC Miler API- Rest GeoLocate Operation

  @API @WEB @Regression @TMS @Smoke @API_Operation @SingleCurrency @3281 @PcMiler @Debugging
  Scenario: 3281 - PC Miler API- Rest GeoLocate Operation
    When Login into Salesforce
  # Step 1
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Verify Text displaying as "Save was successful." -
    Then Switch to Parent Frame

  # Step 2,3,4
    Then Go to Home Page
    Then Go to "Lane IQ" Tab
    Then Wait for "2" Seconds
    Then Update details
    |Country |City       |
    |MX      |San Agustin|
    And Close all the Toast messages
    Then Select "San Agustin, SL " value from Div Dropdown

#   Step 5
    Then "Capture" and Close all the Toast messages from Bottom

  # Expected a
    Then Update and verify payload for "batch" with "TC3281_RequestBody_Expected.json"
      | No Update Required |
      |                    |

  # Expected b
#    Then Update and verify Response payload for "batch" with "TC3281_Response_Body_Expected.json"
#      | No Update Required |
#      |                    |
    Then Get Attribute "[0].Address.City" store into "City" from "batch" "Response"
    Then Get Attribute "[0].Address.State" store into "State" from "batch" "Response"
    Then Get Attribute "[0].Address.Country" store into "Country" from "batch" "Response"
    Then Get Attribute "[0].Coords.Lat" store into "Latitude" from "batch" "Response"
    Then Get Attribute "[0].Coords.Lon" store into "Longitude" from "batch" "Response"
    Then Verify Assertion for "City" contains "San Agustin"
    Then Verify Assertion for "State" contains "SL"
    Then Verify Assertion for "Country" contains "Mexico"
    Then Verify Assertion for "Latitude" contains "23.66592"
    Then Verify Assertion for "Longitude" contains "-100.65407"

  # Step 6
  #Expected c
    Then Verify details for all Enabled fields
      |Search Type|Distance|
      |Radius     |50      |

#  # Step 7,8,9,10
    Then Refresh current Page
    Then Go to "Lane IQ" Tab
    Then Wait for "2" Seconds
    Then Update details
      | Country | City       |
      | MX      | Pedro Blas |
    Then Wait for "2" Seconds
    And Close all the Toast messages
    Then Select "Pedro Blas Carbajal Ortega, SO " value from Div Dropdown
    Then Wait for "2" Seconds

   # Step 11
   # Expected d
    Then Verify Error Message displaying with "Error - Lane IQ"
    Then Verify Error Message displaying as "PC Miler Error: No matching city found:"

   # Expected e
    Then "Capture" and Close all the Toast messages from Bottom
    Then Update and verify payload for "batch" with "TC3281_RequestBody_Expected2.json"
      | No Update Required |
      |                    |

  # Expected f
   Then Get Attribute "[0].Errors[0].Description" store into "Error_Description" from "batch" "Response"
    Then Verify Assertion for "Error_Description" contains "No matching city found"


   # Step 12,13
    Then Refresh current Page
    Then Go to "Lane IQ" Tab
    Then Wait for "2" Seconds
    Then Update details
      | Country |
      | MX      |
    And Close all the Toast messages

    Then Update details
       | City  |
       | Pedro |
    Then Select "Pedro Almada, SO " value from Div Dropdown
    And Close all the Toast messages
    Then Update details
      | Country_2 |
      | MX        |
    And Close all the Toast messages
    Then Update details
      |City_2      |
      |Pedro Blas  |
    Then Select "Pedro Blas Carbajal Ortega, SO " value from Div Dropdown

    #Step 14
    And Close all the Toast messages

    #Expected g
    Then Verify details for all Enabled fields
      |Search Type|Distance|
      |Radius     |50      |
    Then Verify details for all Enabled fields
      |Search Type_2|
      |City/State   |
    Then Verify details for all Enabled fields With data-field-name
         |destinationFilterValue|
         |Pedro Blas Carbajal Ortega, SO|

    #Step 15,16
    Then Open "Lane Preferences" from App Launcher
    Then Click on button with Title "New"
    Then Update details
      | Transportation Profile | Lane                 | Carrier Service               |
      | Revenova HQ            | US-CA-MX to US-CA-MX | Email Carrier One - Truckload |
    Then Click on button with Title "Add Preference"
    Then Click on Native "Save" button
    Then Verify Message displaying as "Save was successful."

    #Step 17
    Then Click on "Create Truck Posting(s)" with Text
    Then Wait for "5" Seconds
    Then Update details
    |Origin Country|Origin City               |Origin State|Pickup Range (Miles)|Destination Country|Destination City|Destination State|Delivery Range (Miles)|Initial Quantity|Select Item 1|
    |Mexico        |Pedro Blas Carbajal Ortega| SO         |50                  |Mexico              |San Agustin     | SL              |                      |2               |True        |
    Then Click on button with Title "Create Posting(s)"
    Then Wait for "3" Seconds

  #Step 18,19
  #Expected h
    Then "Capture" and Close all the Toast messages from Bottom
    Then Update and verify payload for "batch" with "TC3281_RequestBody_Expected_h.json"
      | No Update Required |
      |                    |

  # Expected i
    Then Get Attribute "[0].Errors[0].Description" store into "Description" from "batch" "Response"
    Then Get Attribute "[1].Address.City" store into "City" from "batch" "Response"
    Then Get Attribute "[1].Address.State" store into "State" from "batch" "Response"
    Then Get Attribute "[1].Address.Country" store into "Country" from "batch" "Response"
    Then Get Attribute "[1].Coords.Lat" store into "Latitude" from "batch" "Response"
    Then Get Attribute "[1].Coords.Lon" store into "Longitude" from "batch" "Response"
    Then Verify Assertion for "Description" contains "No matching city found"
    Then Verify Assertion for "City" contains "San Agustin"
    Then Verify Assertion for "State" contains "SL"
    Then Verify Assertion for "Country" contains "Mexico"
    Then Verify Assertion for "Latitude" contains "23.66592"
    Then Verify Assertion for "Longitude" contains "-100.65407"

  #Step 20,21
    Then Open "Truck Postings" from App Launcher
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
    |Carrier Service               |
    | Email Carrier Two - Truckload|
    Then Wait for "1" Seconds
    Then Click on Search lookup with Title "Carrier Service Lookup (New Window)" -
    Then Click on Link Text "Email Carrier Two - Truckload" on new Window with "resultsFrame" Frame
    Then Switch to Frame by Title "accessibility title"
    Then Update details -
    |Origin Country|Origin City               |Origin State|Pickup Range (Miles) |Destination Country|Destination City |Destination State |Initial Quantity |Date Available|
    |Mexico        |Pedro Blas Carbajal Ortega|SO          |50                   |Mexico             |San Agustin      |SL                |2                |0             |

    Then Click on Button with Value "Save" -
    Then Wait for "6" Seconds
    Then Switch to Parent Frame

    #Step 22
    #Expected j
    Then Scroll into Section "Location Information"
    Then Verify Details
    |Origin Country|Origin City               |Origin State|Origin Geolocation|Pickup Range (Miles)|Destination Country |Destination City|Destination State|Destination Geolocation|Delivery Range (Miles) |
    |Mexico        |Pedro Blas Carbajal Ortega| SO         |                  | 50                 |Mexico              |San Agustin     |SL               |23.665928, -100.654073 |                       |
