# UNITE framework
UNITE is a unified framework built using open source tools and Java platform. Below are some key features
# Type of test can be performed!
  - Web application test automation
  - API test Automation (SOAP and RESTful)
# Scripting approach supports by UNITE!
  - BDD scripting Approach
  - Hybrid test scripting approach which includes - Keyword Driven Test and Data Driven Test with Descriptive Programming
### Additional benefits:
  - Rich reporting in HTML
  - Easy to integrated with the any of the exiting Jobs/Pipeline
  - Email-able reports with screen shots and recorded Video links
## Current implementation
In the current implementation of the UNITE, we are using the BBD scripting approach.
Below are the guideline and standards to write the scripts
#### Where to write the feature files and nomenclature of the Feature file
- Write the feature file in **src/test/Resources/Featurefile**
- Manage the feature file into the different folder based on the functional module. For example- all the feature file related to SPQR should be placed into **src/test/Resources/Featurefile/spqr** which enables the proper management and maintenance
- Feature file name should be in the format **ParentUserStory_ChildUserStory.feature**
#### Data parameterization
Data parameterization can be done at the steps level using Cucumber Data Table as below
```sh
Scenario: Submit a SPQR Request and Validate the expected Response
Given I have submitted a SPQR request for "<EIRCODE>"
|EIRCODE  |
|EIRCODE  |
Then Response should contains the Survey Required as "<Expected Response>"
```
Data parameterization also can be done at the scenario level as below
```sh
Scenario Outline: Search a Keyword on Google
Given I am on the Homepage of Google
When I enter the "<SearchKey>" into Search box
When I select the "<SuggestionOption>" from the suggestion list
Then Search will display the "<Link>"

Examples:
 | SearchKey | SuggestionOption| Link          |
 | Testing1  | Testing1        |Testing 123    |
 | TesNg1    | TesNg1          |Testing 123    |
```
#### Tagging of the Features and Scenario
Tagging can be done at the features level using cucumber's @TagName option. 
#### Tagging of the Feature
To apply this, you need to write the tag just above the ***Feature:*** line in the feature file as shows in below example:
```sh
@spqr
Feature: US1059-Enabler Story Supplier Registry Service

  Scenario Outline: Enabler Story- Supplier Registry Service-41345041216
    Given The Supplier request raised by the Talos Wrapper and "<requesttype>" reaches Supplier Registry
    When The "<requesttype>" response received by the Talos Wrapper from Supplier Registry
    Then The "<requesttype>" response received by the Talos Wrapper should have details of all the available Supplier Adapters
 ```   
#### Tagging of Scenario
Tagging can be done at the scenario level using cucumber's @TagName option. To apply this, you need to write the tag just above the ***Scenario Outline: *** line in feature file as shows in below example:
```sh
Feature: US1059-Enabler Story Supplier Registry Service
@API @SIT @DIT @UserStoryID @TestCaseID
  Scenario Outline: Enabler Story- Supplier Registry Service-41345041216
    Given The Supplier request raised by the Talos Wrapper and "<requesttype>" reaches Supplier Registry
    When The "<requesttype>" response received by the Talos Wrapper from Supplier Registry
    Then The "<requesttype>" response received by the Talos Wrapper should have details of all the available Supplier Adapters
 ```  
#### Tags definitions
- ***@API*** -This tag explains that this scenario is to test the API's.
- ***@SIT*** -This tag needs to apply for the scenario's and can be picked during the SIT test execution cycle
- ***@DIT*** -This tag needs to apply for the scenario's and can be picked during the DIT test execution cycle. All the test tags with DIT should already passed into the SIT test execution cycle
- ***@UserStoryID*** -This is the Rally user story id to map the scenario with the Rally user story id which helps us to track each user stories as well as to run the test related to specific user stories
- ***@TestCaseID-*** This is the Rally user story id to map the scenario with the Rally test case id  which helps us to track each test case as well as to run the test related to specific test case

#### Where to write the Steps Definition and Nomenclature of the Steps definition.
- All step definitions should be written in directory **src/test/java/pageHelper/api**
- We should manage the steps definition java classes based on the nature of the steps and application under test. For example: all the step definition classes related to the API test should be written in **src/test/java/pageHelper/api** and for web this should be **src/test/java/pageHelper/web**
- Manage the step definition file into the different folder based on the functional modules as well for example: All the steps definition related to API test in spqr module should be  **src/test/java/pageHelper/api/spqr*** 
- Named the file names as **ParentUserStory_ChildUserStory.java**
- To enforce the maximum re-usability none of the step definition should be duplicate and all the common step definition should be written into the directory:**src/test/java/pageHelper/api**

#### Environment Configuration
To make our scripts dynamic and to be capable to run on different environments we are maintaining configuration file which will help us to quickly update the configuration and run the test. Below are the steps to update the configurations 
- Go to the root folder and the project and open **config.properties** file.
- Update the require configuration and save the file.

### How to run
#### Step1- Update the Runner
##### Run All tests tagged with Same @tag
Add a new BDD runner class or update the exiting one as per below instructions. Update the tags attribute which needs to run in the below code segment
```sh
@CucumberOptions(
features = {"src/test/resources/FeatureFile"},glue = { "pageHelper" },
plugin = { "com.cucumber.listener.ExtentCucumberFormatter:target/cucumber-reports/DIT/report.html"},
tags= "@DIT",
dryRun=true
)
```
##### Run All tests tagged with multiple tags
Group of tags can be updated as below:
```sh
@CucumberOptions(
features = {"src/test/resources/FeatureFile"},glue = { "pageHelper" },
plugin = { "com.cucumber.listener.ExtentCucumberFormatter:target/cucumber-reports/DIT/report.html"},
tags= "@DIT,@SIT",
dryRun=true
)
```
##### Run a Specific test/scenario
All the scenario's also tagged with the rally test case id and if required we can run a specific test using the test case id as tag
```sh
@CucumberOptions(
features = {"src/test/resources/FeatureFile"},glue = { "pageHelper" },
plugin = { "com.cucumber.listener.ExtentCucumberFormatter:target/cucumber-reports/DIT/report.html"},
tags= "@TestCaseID",
dryRun=true
)
```
##### Run complete feature
All the feature files can be run through the feature name tags as below
```sh
@CucumberOptions(
features = {"src/test/resources/FeatureFile"},glue = { "pageHelper" },
plugin = { "com.cucumber.listener.ExtentCucumberFormatter:target/cucumber-reports/DIT/report.html"},
tags= "@spqr",
dryRun=true
)
```
#### Step 2- Run the test
##### From Development IDE.
##### 1. Eclipse
i. To run the test using maven commands - Go to the root directory and select the pom.xml file, right click and select the option run as **maven test**.
ii. We also have the capability to run the test using the runner class by right click on runner and select the option **Run->Run as TestNG Test**
##### 2. IntelliJ IDEA
i. Open Maven pane in the left side and double click on test under the maven life cycle.
ii. Right click on the runner and select run option
##### From Command line.
To run the test from command line tools like cmd/bash, first we have to create a test suite file.
- Go to directory: **src\test\testNGSuites**
- Create a xml file. For example: abc.xml with below details (path.runnerclassname is the path of runner class created into the above steps):
```sh
<!DOCTYPE suite SYSTEM "http://testng.org/testng-1.0.dtd">
<suite thread-count="1"   verbose="1" name="Unified Test" annotations="JDK">
    <test name="BDD- Web" junit="false" preserve-order="true">
        <classes>
    			<class name="path.runnerclassname">	
    			</class>
    	</classes>	
    </test>
</suite>
```
- Open CMD/bash and navigate to the root folder of the project and run the command- **mvn  test -DsuiteXMLFile=filename.xml**
#### Integration with CI tool.
- Create a Job/Pipeline
- Clone the repository using git from the CI tool.
- In the build step provide the command as below if the job is free style project or in the pipeline stage:
```sh
cd unified-framework
mvn test -DsuiteXMLFile=filename.xml
```
- Update the goal as **'test'** if the Job is maven project:

#### Extraction of report
After execution get completed html execution report will get generated in **target\cucumber-reports**
