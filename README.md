# Visual Validation Demo

### RobotFramework with Python Visual Validation Library

RobotFramework UI test for SauceLabs demosite with Visual Validation checks.  
  
Library usage:
`VV Check  <Page Tag Name>  <Element Area to Ignore>(Optional)`

First time through will generate Gold file images.  Second time through will run comparison.  
Check RobotFramework logs for results.

Element Area to Ignore will find the element specified using selenium webdriver and skip comparing the image differences

Demo works with `headless chrome` and `chrome` browsers.  (See CommonWeb.robot ${BROWSER})

### Sample Passing report:
https://mshaferweb.github.io/VisualValidationDemo/results_sample/pass/report.html

### Sample Failing report:
https://mshaferweb.github.io/VisualValidationDemo/results_sample/fail/report.html

### Setup instructions for ubuntu 18.04

Install Python Requirements:
> sudo apt-get install python3-pip
>
> sudo apt-get install python3-pil.imagetk
>
> sudo pip3 install -r requirements.txt

Run Suite:

First time through generate Gold results with `standard_user`:
> robot -d results -L debug --variable username:standard_user testsuites

Second time through generate New results with `standard_user` and trigger validation.  Test will Pass:
> robot -d results -L debug --variable username:standard_user testsuites

Third time through run with `problem_user` and test will "Fail". Comparison will be against original Gold results.
> robot -d results -L debug --variable username:problem_user testsuites

