*** Settings ***
Library          SeleniumLibrary
Library          String
Resource         ../Common/ProductLocators.robot

*** Variables ***


*** Keywords ***

Verify Product In Cart
    [Arguments]    @{product_names}

    Wait Until Page Contains    Your Cart

    FOR    ${product_name}    IN    @{product_names}
        Page Should Contain    ${product_name}
    END

Verify Product Not In Cart
    [Arguments]    ${product_name}

    Page Should Not Contain    ${product_name}

Remove Product
    [Arguments]    ${product_name}
    ${remove_button}=    Get Product Button    ${product_name}    remove
    Click Button    ${remove_button}