Feature:2766 - Load Filter Editor LWC - Format/Functionality

  @API @Regression @PayIQ  @WEB @SingleCurrency @2766
  Scenario: 2766 - Load Filter Editor LWC - Format/Functionality

    When Login into Salesforce

   #Step 1
    Then Open "PayIQ Programs" from App Launcher
    Then Search and Select "PayIQ Program Custom Currency Fields" from List
    Then Capture the current URL for "PayIQ_Program_1"

    #Step 2
    Then Scroll Until Related List for "Filters"
    Then Click on link "Filters"
    Then Wait for "4" Seconds
    Then Click on button "New"

   #Expected a
    Then Verify Text displaying as "Filter" with "font-weight" as "bold"
    Then Verify details for all Enabled fields
      | * Table                 |
      | (Please select a table) |
    Then Verify "White" Color with "SteelBlue" Text of "Cancel" Button is "Enabled"
    Then Verify "LightGray" Color with "White" Text of "Save" Button is "Disabled"

    #Step 3 & Expected b
    Then Verify if "* Table" field has the following dropdown options
      | (Please select a table) |
      | Load                    |
      | Driver Log              |
      | Trip Plan Leg           |

    #Expected c
    Then Update details
      | * Table       |
      | Trip Plan Leg |
    Then Verify Text displaying as "* Field"
    Then Verify Text displaying as "* Operator"

    #Expected d
    Then Verify if "* Field" field has the following dropdown options
      | Appointment Date             |
      | Arrival Time                 |
      | Distance (Miles)             |
      | End City                     |
      | End Location                 |
      | Leg Summary                  |
      | Loaded                       |
      | Start Geolocation (Latitude) |
      | Trip Plan Segment            |

    #Expected e
    Then Update details
      | * Table    |
      | Driver Log |
    Then Verify Text displaying as "* Field"
    Then Verify Text displaying as "* Operator"

    #Expected f
    Then Wait for "2" Seconds
    Then Verify if "* Field" field has the following dropdown options
      | Available                   |
      | Certified as of             |
      | Driver                      |
      | Off Duty Duration           |
      | Short Haul Exemption Active |
      | Yard Move Duration          |

    #Expected g
    Then Update details
      | * Table |
      | Load    |
    Then Verify Text displaying as "* Field"
    Then Verify Text displaying as "* Operator"

    #Expected h
    Then Wait for "2" Seconds
    Then Verify if "* Field" field has the following dropdown options
      | AI Generated                          |
      | Carrier Load                          |
      | Customer                              |
      | Delivery Status                       |
      | Fleet Load Status                     |
      | Invoiced Margin $                     |
      | Last Reported Geolocation (Longitude) |
      | Load Status                           |
      | Next Check Call                       |
      | Paid Margin %                         |
      | Sales Lead (Contact)                  |
      | Tender Decline Link                   |
      | Tracking Provider                     |
      | Weight From Carrier                   |

    #Step 4
    Then Update details
      | * Field     |
      | Cargo Value |

    #Expected i
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Cargo Value"

    #Expected j
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |

    #Step 5
    Then Update details
      | * Field         |
      | Driver Comments |

    #Expected k
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Driver Comments"

    #Expected l
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |
      | Contains     |

    #Step 6
    Then Update details
      | * Field |
      | HazMat  |

    #Expected m
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "HazMat"

    #Expected n
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |

    #Step 7
    Then Update details
      | * Field           |
      | Invoiced Margin % |

    #Expected o
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Invoiced Margin %"

    #Expected p
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |

    #Step 8
    Then Update details
      | * Field     |
      | Load Status |

    #Expected q
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Load Status"

    #Expected r
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |
      | Equal to any |

    Then Update details
      | * Operator   |
      | Equal to any |

    #Expected s
    Then Verify "White" Color with "SteelBlue" Text of "Add" Button is "Enabled"
    Then Verify "White" Color with "LightGray" Text of "Remove" Button is "Disabled"

    #Expected t
    Then Click on button "Add"
    Then Verify details for all Enabled fields
      | Load Status | Load Status_2 |
      | --None--    | --None--      |
    Then Verify "White" Color with "SteelBlue" Text of "Add" Button is "Enabled"
    Then Verify "White" Color with "SteelBlue" Text of "Remove" Button is "Enabled"

    #Step 9
    Then Update details
      | * Field |
      | Mode    |

    #Expected u
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Mode"

    #Expected v
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |
      | Equal to any |

     #Step 10
    Then Update details
      | * Field    |
      | Order Date |

    #Expected w
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Order Date"

    #Expected x
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |

    #Step 11
    Then Update details
      | * Field                    |
      | Other Carrier Capabilities |

    #Expected y
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Other Carrier Capabilities"

    #Expected z
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |
      | Equal to any |
      | Contains     |

    #Step 12
    Then Update details
      | * Field            |
      | Other Instructions |

    #Expected aa
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Other Instructions"

    #Expected ab
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |
      | Contains     |

    #Step 13
    Then Update details
      | * Field       |
      | Paid Margin $ |

    #Expected ac
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Paid Margin $"

    #Expected ad
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |

    #Step 14
    Then Update details
      | * Field            |
      | Tender Accept Link |

    #Expected ae
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Tender Accept Link"

    #Expected af
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |

    #Step 15
    Then Update details
      | * Field     |
      | Tender Accepted Date |

    #Expected ag
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Tender Accepted Date"

    #Expected ah
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |

    #Step 16
    Then Update details
      | * Field      |
      | Total Weight |

    #Expected ai
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Total Weight"

    #Expected aj
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |

    #Step 17
    Then Update details
      | * Field           |
      | Tracking Provider |

    #Expected ak
    Then Verify Text displaying as "* Operator"
    Then Verify Text displaying as "Tracking Provider"

    #Expected al
    Then Verify if "* Operator" field has the following dropdown options
      | Equal to     |
      | Not equal to |
      | Contains     |