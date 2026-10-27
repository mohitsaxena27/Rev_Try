Feature: 554 - Addrexx API- Active

  @Regression @TMS @Smoke @WEB @SingleCurrency @Load @Load_Config @554
  Scenario: 554 - Addrexx API- Active

    When Login into Salesforce

    #Step1
    Then Open "Loads" from App Launcher
    Then Select Customer Details and Load Type
      |Load_Num | Customer     | Mode      | Equipment_Type | Details_Entry | Show_Accessorials |
      |1L       | Revenova HQ | Truckload  | NA      | N             | N                 |

    # Step 2
    Then Add Location Details
      | Add_Loc | Type | Address_Type     | Value               | Expected_Date | Shipping_Receiving_Hours | Appointment_Time   | Appointment_Required |
      | N       | 1P   | City_State_PC   | NA                  | NA             | NA               | NA               | NA                   |
    # Step 3 > a
    Then Update details
         |City_2|
         |Chicago|
    #Expected a
    Then Verify Available Option Not displaying as "Chicago"

     # Step 3 > b
    Then Update details
      |City_2|
      |Tel Aviv|
    #Expected b
    Then Verify Available Option Not displaying as "Tel Aviv"

    # Step 3 > c & d
    Then Update details
      |City_2|Postal Code_2|
      |      |60602          |
    #Expected c
    Then Verify Available Option Not displaying as "60602"

    # Step 3 > e
    Then Update details
      |Postal Code_2|
      |V5K 0A1          |
    #Expected d
    Then Verify Available Option Not displaying as "V5K 0A1"

    # Step 3 > f & g
    Then Update details
      |Postal Code_2|
      |             |
    Then Select "1P" Country as "US"
    Then Wait for "1" Seconds

    # Step 3 > h
    Then Update details
      |City_2|
      |Chicago|
    #Expected e
    Then Verify Available Option displaying as "Chicago, IL 60601"
    Then Verify Available Option displaying as "Chicago, IL 60602"
    Then Verify Available Option displaying as "Chicago, IL 60603"
    Then Verify Available Option displaying as "Chicago, IL 60604"
    Then Verify Available Option displaying as "Chicago, IL 60605"
    Then Verify Available Option displaying as "Chicago, IL 60610"

     # Step 3 >i
    Then Update details
      |City_2|
      |Tel Aviv|

    #Expected f
    Then Verify Available Option Not displaying as "Tel Aviv"

    # Step 3 > j & k
    Then Update details
      |City_2|Postal Code_2|
      |      |60602          |
    #Expected g
    Then Verify Available Option displaying as "Chicago, IL 60602"

    # Step 3 > l
    Then Update details
      |Postal Code_2|
      |V5K 0A1      |
    #Expected h
    Then Verify Available Option Not displaying as "V5K 0A1"

    # Step 3 > m & n
    Then Update details
      |Postal Code_2|
      |             |
    Then Select "1P" Country as "IL"
    Then Wait for "1" Seconds
   # Step 3 > o
    Then Update details
      |City_2|
      |Chicago|
    #Expected i
    Then Verify Available Option Not displaying as "Chicago"


     # Step 3 >p
    Then Update details
      |City_2|
      |Tel Aviv|

    #Expected j
    Then Verify Available Option displaying as "Tel Aviv - Jaffa"

    # Step 3 > q & r
    Then Update details
      |City_2|
      |      |
    Then Select "1P" Country as "CA"
    Then Wait for "2" Seconds
    # Step 3 > s
    Then Update details
      |Postal Code_2|
      |60602      |
    #Expected k
    Then Verify Available Option Not displaying as "60602"

    # Step 3 > t
    Then Update details
      |Postal Code_2|
      |V5K 0A1      |
    #Expected l
    Then Verify Available Option displaying as "Vancouver, BC V5K 0A1"











