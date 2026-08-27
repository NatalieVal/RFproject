*** Settings ***
Library          SeleniumLibrary

*** Variables ***

${ADD_TO_CART_BUTTON}        id=add-to-cart
${REMOVE_BUTTON}             id=remove

*** Keywords ***

Add Product To Cart
    Click Button    ${ADD_TO_CART_BUTTON}

Remove Product From Cart
    Click Button    ${REMOVE_BUTTON}

Verify Product Details
     [Arguments]    ${product_name}
     Page Should Contain    ${product_name}
