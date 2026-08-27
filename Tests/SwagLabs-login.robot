*** Settings ***
Documentation    This is suite relating to saucedemo shop actions

Resource    ../Resources/Common/Common.robot
Resource    ../Resources/PO/LoginPage.robot
Resource    ../Resources/PO/ProductPage.robot

# Suite Setup       Insert Testing Data
Test Setup          Common.Begin Web Test    https://www.saucedemo.com/
Test Teardown       Common.End Web Test  
# Suite Teardown    Cleanup Testing Data

#Run the script:
# robot -d Results Tests/SwagLabs-login.robot
# OR
# robot -d Results -t 'User Should be able to log in with valid users' Tests/SwagLabs-login.robot

*** Variables ***

${BROWSER}            Chrome
${URL}                https://www.saucedemo.com/

${PASSWORD}            secret_sauce
${INVALID_PASSWORD}    test123

@{VALID_USERS}
...    standard_user
...    problem_user
...    performance_glitch_user
...    error_user
...    visual_user

${INVALID_USER}         test

*** Test Cases ***

User Should be able to log in with valid users
    [Documentation]    Verify that all valid users can log in
    [Tags]             login    positive

    FOR    ${username}    IN       @{VALID_USERS}
        Common.Begin Web Test      ${URL} 
        LoginPage.Enter login data     ${username}    ${PASSWORD}
        LoginPage.Click Login Button
        ProductPage.Verify Products Loaded
        ProductPage.Verify Products Page Not Empty
        Common.End Web Test
    END

User Should Not be able to log in with invalid username
    [Documentation]    Verify that login fails with invalid username
    [Tags]             login    negative

    Enter login data    ${INVALID_USER}    ${PASSWORD}  
    Click Login Button
    Verify login error for incorrect login data

User Should Not be able to log in with Invalid Password
    [Documentation]    Verify that login fails with invalid password
    [Tags]             login    negative

    Enter login data    ${VALID_USERS}[0]    ${INVALID_PASSWORD}  
    Click Login Button
    Verify login error for incorrect login data

Login With Blank Username Should Show Correct Error Message
    [Documentation]    Verify that login with empty username shows correct error
    [Tags]    login    negative

    Enter Username    ${EMPTY}
    Enter Password    ${PASSWORD}
    Click Login Button
    Verify Login Error For Empty Login Data    username

Login With Blank Password Should Show Correct Error Message
    [Documentation]    Verify that login with empty password shows correct error
    [Tags]    login    negative
    
    Enter Username    ${VALID_USERS}[0]
    Enter Password    ${EMPTY}
    Click Login Button
    Verify Login Error For Empty Login Data    password