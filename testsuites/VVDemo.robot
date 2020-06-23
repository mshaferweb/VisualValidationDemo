*** Settings ***
Resource     ../resources/CommonWeb.robot
Test Setup  Begin Web Test
Test Teardown  End Web Test

*** Test Cases ***
Purchase Product on SauceDemo

    Login to SauceDemo

    Click Backpack and then add to Cart

    Click Shirt Add to Cart

    Click Cart and Check Out

