# Visual Validation Demo

### RobotFramework with Python Visual Validation Library

RobotFramework UI test for SauceLabs demosite with Visual Validation checks.
  
Library usage:
`VV Check  <Page Tag Name>`

First time through will generate Gold file images.  Second time through will run comparison.  
Check RobotFramework logs for results.

Demo works with `headless chrome` and `chrome` browsers.  (See CommonWeb.robot ${BROWSER})

### Sample Passing report:
https://mshaferweb.github.io/VisualValidationDemo/results_sample/pass/report.html

### Sample Failing report:
https://mshaferweb.github.io/VisualValidationDemo/results_sample/fail/report.html

### Setup instructions for ubuntu 18.04

Install Python Requirements:
> sudo apt-get install python3-pip
> sudo apt-get install python3-pil.imagetk
> sudo pip3 install -r requirements.txt

Run Suite:

> robot -d results -L debug --variable username:standard_user testsuites
> robot -d results -L debug --variable username:standard_user testsuites

Check RobotFramework logs for Success.  Run a third time with "problem_user" and then see failed test run with
image comparison.

> robot -d results -L debug --variable username:problem_user testsuites

