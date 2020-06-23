*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Library  ../library/VisualValidation.py


*** Variables ***
${BROWSER}   headless chrome
${SELSPEED}  0.0s
${user_name}  standard_user
${version}   v1

*** Keywords ***
Begin Web Test
    Run Keywords  Open Browser  https://www.saucedemo.com/index.html  ${BROWSER}
    ...              AND   Set Selenium Speed  ${SELSPEED}
    Set Window Size  1024  768
    Send Var To Python  outdir  ${outputdir}
    Send Var To Python  version  ${version}

End Web Test
    Close Browser

Login to SauceDemo
    type    id=user-name    ${user_name}
    click    id=password
    type    id=password    secret_sauce
    title_should_start_with  Swag Labs
    Run Keyword And Continue On Failure  VV Check  Login
    click    xpath=//input[@value='LOGIN']

Click Backpack and then add to Cart
    click    xpath=//a[@id='item_4_title_link']/div
    click    xpath=//div[@id='inventory_item_container']/div/div/div/button
    Run Keyword And Continue On Failure  VV Check  Product Page
    click    xpath=//div[@id='inventory_item_container']/div/button

Click Shirt Add to Cart
    click    xpath=//div[@id='inventory_container']/div/div[3]/div[3]/button
    Run Keyword And Continue On Failure  VV Check  Add To Cart

Click Cart and Check Out
    click    css=path
    click    link=CHECKOUT
    click    id=first-name
    type    id=first-name    John
    type    id=last-name    Doe
    type    id=postal-code    12345
    Run Keyword And Continue On Failure  VV Check  Checkout
    click    xpath=//input[@value='CONTINUE']
    click    link=FINISH
    assertText    xpath=//div[@id='checkout_complete_container']/h2    THANK YOU FOR YOUR ORDER
    Run Keyword And Continue On Failure  VV Check  Order Confirm

open
    [Arguments]    ${element}
    Go To          ${element}

clickAndWait
    [Arguments]    ${element}
    Click Element  ${element}

click
    [Arguments]    ${element}
    Click Element  ${element}

sendKeys
    [Arguments]    ${element}    ${value}
    Press Keys     ${element}    ${value}

submit
    [Arguments]    ${element}
    Submit Form    ${element}

type
    [Arguments]    ${element}    ${value}
    Input Text     ${element}    ${value}

selectAndWait
    [Arguments]        ${element}  ${value}
    Select From List   ${element}  ${value}

select
    [Arguments]        ${element}  ${value}
    Select From List   ${element}  ${value}

verifyValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

verifyText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

verifyElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

verifyVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

verifyTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

verifyTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertConfirmation
    [Arguments]                  ${value}
    Alert Should Be Present      ${value}

assertText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

assertVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

assertTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

assertTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

waitForVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

waitForTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

waitForTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

doubleClick
    [Arguments]           ${element}
    Double Click Element  ${element}

doubleClickAndWait
    [Arguments]           ${element}
    Double Click Element  ${element}

goBack
    Go Back

goBackAndWait
    Go Back

runScript
    [Arguments]         ${code}
    Execute Javascript  ${code}

runScriptAndWait
    [Arguments]         ${code}
    Execute Javascript  ${code}

setSpeed
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

setSpeedAndWait
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

verifyAlert
    [Arguments]              ${value}
    Alert Should Be Present  ${value}
