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

Enter username
    [Arguments]    ${username} 
    Input Text             ${USERNAME_INPUT_FIELD}    ${username}

Enter password
    [Arguments]    ${password}
    Input Text             ${PASSWORD_INPUT_FIELD}    ${password}

Click Login Button
    Click Button           ${LOGIN_BUTTON}

Verify login error for incorrect login data
    Element Should Contain    ${LOGIN_ERROR}    Epic sadface: Username and password do not match any user in this service

Verify Login Error For Empty Login Data
    [Arguments]    ${empty_field}

    IF    $empty_field == "username"
        ${expected_error}=    Set Variable
        ...    Epic sadface: Username is required
    ELSE IF    $empty_field == "password"
        ${expected_error}=    Set Variable
        ...    Epic sadface: Password is required
    ELSE
        Fail    Unsupported login field: ${empty_field}
    END

    Element Should Contain    ${LOGIN_ERROR}    ${expected_error}