*** Settings ***
Library          SeleniumLibrary
Library          String

*** Variables ***

${SHOPPING_CART_LINK}        css=[data-test="shopping-cart-link"]
${SHOPPING_CART_BADGE}       css=[data-test="shopping-cart-badge"]

*** Keywords ***

Go To Cart
    
    Click Link    ${SHOPPING_CART_LINK}
    Page Should Contain    Your Cart

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
    # click remove button for this product
    ${remove_button}=    Set Variable
    ...    xpath=//div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space(.)="${product_name}"]]//button[contains(@data-test, "remove")]
    Click Button    ${remove_button}