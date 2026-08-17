*** Settings ***
Library          SeleniumLibrary

*** Variables ***

${LOGIN_ERROR}                css=[data-test="error"]
${USERNAME_INPUT_FIELD}       id=user-name
${PASSWORD_INPUT_FIELD}       id=password
${LOGIN_BUTTON}               id=login-button

*** Keywords ***

Enter login data
    [Arguments]    ${username}    ${password}
    Input Text             ${USERNAME_INPUT_FIELD}    ${username}
    Input Text             ${PASSWORD_INPUT_FIELD}    ${password}

Click Login Button
    Click Button           ${LOGIN_BUTTON}

Verify login error
    Element Should Contain    ${LOGIN_ERROR}    Epic sadface: Username and password do not match any user in this service