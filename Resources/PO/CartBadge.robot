*** Settings ***
Library          SeleniumLibrary
Library          String

*** Variables ***

${SHOPPING_CART_LINK}        css=[data-test="shopping-cart-link"]
${SHOPPING_CART_BADGE}       css=[data-test="shopping-cart-badge"]

*** Keywords ***

Click Cart Link
    Click Link    ${SHOPPING_CART_LINK}

Verify Product Count
    [Arguments]    ${expected_count}
    
    Element Text Should Be    ${SHOPPING_CART_BADGE}    ${expected_count}

Get Product Count
    ${cart_count}=    Get Text    ${SHOPPING_CART_BADGE}
    ${cart_count}=    Convert To Integer    ${cart_count}
    RETURN    ${cart_count}

Verify Badge Is Hidden
    Page Should Not Contain Element    ${SHOPPING_CART_BADGE}
    