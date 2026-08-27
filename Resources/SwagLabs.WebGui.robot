*** Settings ***

Library          SeleniumLibrary
Resource         ../Resources/PO/ProductPage.robot
Resource         ../Resources/PO/LoginPage.robot
Resource         ../Resources/PO/CartPage.robot

*** Variables ***

${SHOPPING_CART_LINK}        css=[data-test="shopping-cart-link"]
${SHOPPING_CART_BADGE}       css=[data-test="shopping-cart-badge"]

*** Keywords ***

Log in
    [Arguments]    ${username}    ${password}

    LoginPage.Enter login data    ${username}    ${password}         
    LoginPage.Click Login Button
    ProductPage.Verify Products Loaded
    ProductPage.Verify Products Page Not Empty

View Product Details

    [Arguments]    ${product_name}
    ProductPage.Select Product    ${product_name}
    ProductPage.Verify Product Details Loaded    ${product_name}

Add Product To Cart
    [Arguments]    ${product}
    ProductPage.Add to Cart    ${product}

Remove Product From Cart
    [Arguments]    ${product}
    ProductPage.Remove from Cart    ${product}

Go To Cart
    
    Click Link    ${SHOPPING_CART_LINK}
    Page Should Contain    Your Cart

Get Number of Products in Cart
    ${count}=    CartPage.Get Number Of Products
    RETURN    ${count}

Verify Products in Cart
    [Arguments]    @{product_names}
    CartPage.Verify Product In Cart      @{product_names}  

Verify Number of Products in Cart
    [Arguments]    ${expected_count}

    ${cart_count}=    Get Text    ${SHOPPING_CART_BADGE}
    ${cart_count}=    Convert To Integer    ${cart_count}
    Should Be Equal As Integers    ${cart_count}    ${expected_count}
    
Verify Product Not In Cart
    [Arguments]    ${product_name}

    CartPage.Verify Product Not In Cart    ${product_name}