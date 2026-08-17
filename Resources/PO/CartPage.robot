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


Verify Number Of Products
    [Arguments]    ${expected_count}
    Element Text Should Be    ${SHOPPING_CART_BADGE}    ${expected_count}

Get Number Of Products
    ${cart_count}=    Get Text    ${SHOPPING_CART_BADGE}
    ${cart_count}=    Convert To Integer    ${cart_count}
    RETURN    ${cart_count}

Verify Product Not In Cart
    [Arguments]    ${product_name}

    Page Should Not Contain    ${product_name}