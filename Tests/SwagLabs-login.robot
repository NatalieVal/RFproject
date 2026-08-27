*** Settings ***
Documentation    This is suite relating to saucedemo shop actions

Resource    ../Resources/Common/Common.robot
Resource    ../Resources/PO/LoginPage.robot
Resource    ../Resources/PO/ProductPage.robot
Resource    ../Resources/TestData/SwagLabsData.robot

# Suite Setup       Insert Testing Data
Test Setup          Common.Begin Web Test    ${URL}
Test Teardown       Common.End Web Test  
# Suite Teardown    Cleanup Testing Data

#Run the script:
# robot -d Results Tests/SwagLabs-login.robot
# OR
# robot -d Results -t 'User Should be able to log in with valid users' Tests/SwagLabs-login.robot

*** Variables ***
# variables in TestData/SwagLabsData.robot

*** Test Cases ***

User Should be able to log in with valid users
    [Documentation]    Verify that all valid users can log in
    [Tags]             login    positive
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

User Should Not Be Able To Log In With Invalid Username
    Enter Login Data    ${INVALID_USER}    ${PASSWORD}
    Click Login Button
    Verify Login Error    ${INVALID_LOGIN_ERROR}

User Should Not Be Able To Log In With Invalid Password
    Enter Login Data    ${VALID_USERS}[0]    ${INVALID_PASSWORD}
    Click Login Button
    Verify Login Error    ${INVALID_LOGIN_ERROR}

Login With Blank Username Should Show Correct Error Message
    Enter Login Data    ${EMPTY}    ${PASSWORD}
    Click Login Button
    Verify Login Error    ${USERNAME_REQUIRED_ERROR}

Login With Blank Password Should Show Correct Error Message
    Enter Login Data    ${VALID_USERS}[0]    ${EMPTY}
    Click Login Button
    Verify Login Error    ${PASSWORD_REQUIRED_ERROR}

Locked-Out User Should Not Be Able To Log In
    Enter Login Data    locked_out_user    ${PASSWORD}
    Click Login Button
    Verify Login Error    ${LOCKED_OUT_ERROR}