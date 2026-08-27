*** Settings ***
Documentation    This suite contains SauceDemo login tests

Resource    ../Resources/Common/Common.robot
Resource    ../Resources/PO/LoginPage.robot
Resource    ../Resources/PO/ProductPage.robot
Resource    ../Resources/TestData/SwagLabsData.robot

# Suite Setup       Insert Testing Data
Test Setup          Common.Begin Web Test    ${URL}
Test Teardown       Common.End Web Test  
# Suite Teardown    Cleanup Testing Data

Test Template    Login Should Fail With Expected Error

#Run the script:
# robot -d Results Tests/SwagLabs-login.robot
# OR
# robot -d Results -t 'User Should be able to log in with valid users' Tests/SwagLabs-login.robot

*** Variables ***
# variables in TestData/SwagLabsData.robot

*** Keywords ***

Login Should Fail With Expected Error
    [Arguments]    ${username}    ${password}    ${expected_error}
    LoginPage.Enter Login Data    ${username}    ${password}
    LoginPage.Click Login Button
    LoginPage.Verify Login Error    ${expected_error}

*** Test Cases ***

User Should Be Able To Log In With Valid Users
    [Documentation]    Verify that all valid users can log in
    [Tags]    login    positive
    [Template]    NONE
    [Setup]    NONE
    [Teardown]    NONE

    FOR    ${username}    IN    @{VALID_USERS}
        Common.Begin Web Test    ${URL}
        TRY
            LoginPage.Enter Login Data    ${username}    ${PASSWORD}
            LoginPage.Click Login Button
            ProductPage.Verify Products Loaded
            ProductPage.Verify Products Page Not Empty
        FINALLY
            Common.End Web Test
        END
    END

Login With Invalid Username Should Fail
    [Tags]    login    negative
    ${INVALID_USER}    ${PASSWORD}    ${INVALID_LOGIN_ERROR}

Login With Invalid Password Should Fail
    [Tags]    login    negative
    ${VALID_USERS}[0]    ${INVALID_PASSWORD}    ${INVALID_LOGIN_ERROR}

Login With Blank Username Should Show Correct Error
    [Tags]    login    negative
    ${EMPTY}    ${PASSWORD}    ${USERNAME_REQUIRED_ERROR}

Login With Blank Password Should Show Correct Error
    [Tags]    login    negative
    ${VALID_USERS}[0]    ${EMPTY}    ${PASSWORD_REQUIRED_ERROR}

Locked-Out User Should Not Be Able To Log In
    [Tags]    login    negative
    locked_out_user    ${PASSWORD}    ${LOCKED_OUT_ERROR}