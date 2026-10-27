Feature: 2219 - SMC3 EVA API - Create Callback Endpoint and Get Token

  @API @Regression @TMS @Priority_1 @WEB @API_Operation @SingleCurrency @2219 @SMC3EVAAPI
  Scenario: 2219 - SMC3 EVA API - Create Callback Endpoint and Get Token

    When Login into Salesforce

    # Step 1: Retain the configured inbound API Community URL and enable debugging
    Then Open "TMS Admin" from App Launcher
    Then Go to "Configuration" Tab
    Then Switch to Frame by Title "accessibility title"
    Then Store iframe field "Inbound API Community URL" value into "Inbound_API_Community_URL" -
    Then Scroll into Section "Debugging" -
    Then Update details -
      | Logging Enabled |
      | True            |
    And Update the Custom Select option "Logging User" as "User User"
    And Click on Button with Value "Save" -
    Then Switch to Parent Frame

    # Step 2: Open the SMC3 EVA credential and retain Password 1 and Password 2
    Then Open "TMS Admin" from App Launcher
    Then Go to "Credentials" Tab
    Then Go to "Global Services" Tab
    Then Search text "SMC3 EVA" in the "Search Credentials..." search box
    Then Select the "SMC3 EVA" record from the lookup field results

    Then Verify "Callback Endpoint Created" is disabled or not

    # Expose Password 1 and Password 2 in the credential card before reading them.
    Then Set Field Value "Password 1" into "Password_1" Value
    Then Set Field Value "Password 2" into "Password_2" Value

    # Step 3: Save the credential and verify the success banner
    And Click on Native "Save" button
    Then Verify Message displaying as "Success - Credentials"

    # Step 4:
    And "Capture" and Close all messages from Bottom

    # Expected result b: request body
    Then Get Attribute "grant_type" store into "GrantType" from "TokenRetrieval" "Request"
    Then Get Attribute "client_id" store into "ClientId" from "TokenRetrieval" "Request"
    Then Get Attribute "client_secret" store into "ClientSecret" from "TokenRetrieval" "Request"
    Then Get Attribute "endpoint" store into "Endpoint" from "TokenRetrieval" "Request"
    Then Get Attribute "effectiveDate" store into "EffectiveDate" from "TokenRetrieval" "Request"

    Then Verify Key "GrantType" with value "client_credentials"
    Then Verify Key "ClientId" with value "SysData=>Password_1"
    Then Verify Key "ClientSecret" with value "SysData=>Password_2"
    Then Verify Assertion for "Endpoint" contains "SysData=>Inbound_API_Community_URL"
    Then Store current date in format "yyyyMMdd" into "CurrentDate"
    Then Verify Key "EffectiveDate" with value "SysData=>CurrentDate"

    # Expected result c: response body
    Then Get Attribute "access_token" store into "AccessToken" from "TokenRetrieval" "Response"
    Then Get Attribute "token_type" store into "TokenType" from "TokenRetrieval" "Response"
    Then Get Attribute "expires_in" store into "ExpiresIn" from "TokenRetrieval" "Response"

    Then Verify "AccessToken" value is not empty
    Then Verify Key "TokenType" with value "Bearer"
    Then Verify "ExpiresIn" has numeric value

    # Expected result d: callback endpoints are created successfully
    Then Get Attribute "messageStatus.message" store into "CallbackEndpointMessage" from "createEndpoints" "Response"
    Then Verify Key "CallbackEndpointMessage" with value "Callback Endpoints Created Successfully"
