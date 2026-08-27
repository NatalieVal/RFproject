*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_ERROR}            css=[data-test="error"]
${USERNAME_INPUT_FIELD}   id=user-name
${PASSWORD_INPUT_FIELD}   id=password
${LOGIN_BUTTON}           id=login-button

*** Keywords ***
Enter Login Data
    [Arguments]    ${username}    ${password}
    Input Text        ${USERNAME_INPUT_FIELD}    ${username}
    Input Password    ${PASSWORD_INPUT_FIELD}    ${password}

Click Login Button
    Click Button    ${LOGIN_BUTTON}

Verify Login Error
    [Arguments]    ${expected_error}
    Element Should Contain    ${LOGIN_ERROR}    ${expected_error}