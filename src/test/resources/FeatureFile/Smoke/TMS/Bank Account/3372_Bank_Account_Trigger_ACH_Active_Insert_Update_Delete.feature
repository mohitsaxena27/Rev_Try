Feature: 3372 - Bank Account Trigger- ACH Active- Insert/Update/Delete

  @Regression @Priority_1 @API @WEB @SingleCurrency  @Account @3372
  Scenario: 3372 - Bank Account Trigger- ACH Active- Insert/Update/Delete


    When Login into Salesforce
    #Step1
    Then Delete All Records with name "BA-" for "rtms__BankAccount__c"
    Then Search and Select "Email Carrier Three" Account from the Global search
    Then Go to "Details" Tab
    Then Scroll into Section "General Information"
    Then Click on Edit icon on Label "Default Payment Method"
    Then Update details
      | Default Payment Method |
      | ACH (NACHA File)       |
    Then Click on button "Save"
    Then Wait for "4" Seconds
    Then Verify Details
      | Default Payment Method |
      | ACH (NACHA File)       |
    #Then Set URL with "payment" and store into "defaultpayment"

    #Step2
    Then Open "Bank Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Bank Name             | Account             | Account Type | ACH Active | Routing Number | Account Number | Confirm Account Number |
      | Revenova Bank & Trust | Email Carrier Three | Checking     | True       | 123456789      | 100001234      | 100001234              |

    #Step3
    Then Click on button "Save & New"
    Then Wait for "4" Seconds

    #Step4
    Then Update details
      | Bank Name            | Account             | Account Type | ACH Active | Routing Number | Account Number | Confirm Account Number |
      | Madison Credit Union | Email Carrier Three | Checking     | False      | 223456789      | 200001234      | 200001234              |
    #Step5
    Then Click on button "Save & New"
    Then Wait for "2" Seconds

    #Step6
    Then Update details
      | Bank Name            | Account             | Account Type | ACH Active | Routing Number | Account Number | Confirm Account Number |
      | Oak Street Financial | Email Carrier Three | Checking     | False      | 323456789      | 300001234      | 300001234              |

    #Step 7
    Then Click on button "Save"
    Then Wait for "4" Seconds

    #Step8
    Then Open "Bank Accounts" from App Launcher
    Then Recently Viewed to All

    #Step9
    Then Click on "BA-" with "Bank Name" as "Revenova Bank & Trust" and "Account" as "Email Carrier Three"
    Then Wait for "2" Seconds

    #Step10 &11
    Then Click on "Delete" button
    Then Wait for "1" Seconds
    Then Click on Native "Delete" icon -
     # Expected Result a
    Then Verify Message displaying as "Bank Account cannot be deleted - this is the ACH Active bank account for this account."

    #Step12
    Then Close Toast message

    #Step13
    Then Open "Bank Accounts" from App Launcher
    Then Click on button with Title "New"
    Then Wait for "2" Seconds
    Then Update details
      | Bank Name               | Account             | Account Type | ACH Active | Routing Number | Account Number | Confirm Account Number |
      | Millennium Bean Savings | Email Carrier Three | Checking     | True       | 423456789      | 400001234      | 400001234              |

    #Step 14
    Then Click on button "Save"
    Then Wait for "4" Seconds

    #Step15
    Then Open "Bank Accounts" from App Launcher
    Then Recently Viewed to All

    # Expected Result b
    Then Click on "BA-" with "Bank Name" as "Millennium Bean Savings" and "Account" as "Email Carrier Three"
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | ACH Active |
      | True       |
    Then Open "Bank Accounts" from App Launcher
    Then Recently Viewed to All
    Then Click on "BA-" with "Bank Name" as "Revenova Bank & Trust" and "Account" as "Email Carrier Three"
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | ACH Active |
      | False      |

    #Step16
    Then Open "Bank Accounts" from App Launcher
    Then Recently Viewed to All
    Then Click on "BA-" with "Bank Name" as "Madison Credit Union" and "Account" as "Email Carrier Three"
    Then Wait for "2" Seconds
    #Step17 &18
    Then Click on Edit icon on Label "ACH Active"
    Then Update details
      | ACH Active |
      | True       |
    Then Click on button "Save"
    Then Wait for "2" Seconds

    #Step19 &Expected Result c
    Then Open "Bank Accounts" from App Launcher
    Then Recently Viewed to All
    Then Click on "BA-" with "Bank Name" as "Madison Credit Union" and "Account" as "Email Carrier Three"
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | ACH Active |
      | True       |
    Then Wait for "2" Seconds
    Then Open "Bank Accounts" from App Launcher
    Then Recently Viewed to All
    Then Click on "BA-" with "Bank Name" as "Millennium Bean Savings" and "Account" as "Email Carrier Three"
    Then Wait for "2" Seconds
    Then Verify Label Checkbox
      | ACH Active |
      | False      |
    #Then Verify "Bank Name" "Madison Credit Union" "ACH Active" is "True"
    #Then Verify Inline Edit Value "Millennium Bean Savings" "ACH Active" is "False"

    #Step20
    Then Open "Bank Accounts" from App Launcher
    Then Recently Viewed to All
    Then Click on "BA-" with "Bank Name" as "Madison Credit Union" and "Account" as "Email Carrier Three"
    Then Wait for "2" Seconds
    #Step21 & Expected d
    Then Click on Edit icon on Label "ACH Active"
    Then Update details
      | ACH Active |
      | False      |
    Then Click on button "Save"
    Then Verify Text displaying as "The ACH Active field for this account cannot be set to false. Change the Default Payment Method on the account or set the ACH Active field to true for another Bank Account first."

    #Step22
    Then Click on button "Cancel"

    #Step23
    Then Open "Bank Accounts" from App Launcher
    Then Recently Viewed to All

    #Step24
    Then Search and Select "ACH Active" Checkbox for the Value "Revenova Bank & Trust"
    Then Search and Select "ACH Active" Checkbox for the Value "Oak Street Financial"
    Then Click on button "Save"
    Then Wait for "2" Seconds
    
    #Step25
    Then Search and Select "ACH Active" Checkbox for the Value "Revenova Bank & Trust"
    Then Search and Select "ACH Active" Checkbox for the Value "Madison Credit Union"
    Then Search and Select "ACH Active" Checkbox for the Value "Oak Street Financial"
    #Step26 & Expected e
    Then Click on button "Save"
     # Expected Result e
    Then Verify Error Message displaying as "Item 1 has errors in these fields: ACH Active."
    Then Verify Error Message displaying as "Item 3 has errors in these fields: ACH Active."
    Then Verify Class Contains "button_icon-error" is displaying with color "Red"
    Then Verify "White" Color with "SteelBlue" Text of "Cancel" Button
    Then Verify "SteelBlue" Color with "White" Text of "Save" Button
    Then Verify box-shadow color is "Red" for Column "ACH Active" and Row text "Revenova Bank & Trust"
    Then Verify box-shadow color is "Red" for Column "ACH Active" and Row text "Oak Street Financial"
    Then Verify Class Contains "button_icon-error" is displaying for Row text "Oak Street Financial"
    Then Verify Class Contains "button_icon-error" is displaying for Row text "Revenova Bank & Trust"

    Then Close Toast message
    Then Click on button "Cancel"