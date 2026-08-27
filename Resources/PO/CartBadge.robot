*** Settings ***
Library          SeleniumLibrary
Library          String

*** Variables ***

${SHOPPING_CART_LINK}        css=[data-test="shopping-cart-link"]
${SHOPPING_CART_BADGE}       css=[data-test="shopping-cart-badge"]

*** Keywords ***

Verify Number Of Products
    [Arguments]    ${expected_count}
    Element Text Should Be    ${SHOPPING_CART_BADGE}    ${expected_count}

Get Number Of Products
    ${cart_count}=    Get Text    ${SHOPPING_CART_BADGE}
    ${cart_count}=    Convert To Integer    ${cart_count}
    RETURN    ${cart_count}

Verify Cart Is Empty
    Page Should Not Contain Element    ${SHOPPING_CART_BADGE}
    