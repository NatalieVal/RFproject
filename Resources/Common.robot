*** Settings ***

Library          SeleniumLibrary


*** Keywords ***

Begin Web Test
    [Arguments]    ${url}

    ${options}=    Evaluate    __import__("selenium.webdriver").webdriver.ChromeOptions()
    Call Method    ${options}    add_argument    --incognito

    Create Webdriver    Chrome    options=${options}

    Go To    ${url}
    Wait Until Element Is Visible    id=user-name    10s
    
End Web Test
    Sleep    3s
    Close All Browsers