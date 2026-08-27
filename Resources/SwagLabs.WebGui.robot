*** Settings ***

Library          SeleniumLibrary
Resource         ../Resources/PO/ProductPage.robot
Resource         ../Resources/PO/LoginPage.robot
Resource         ../Resources/PO/CartPage.robot
Resource         ../Resources/PO/ProductDetailsPage.robot
Resource         ../Resources/PO/CartBadge.robot

*** Variables ***


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
    ProductDetailsPage.Verify Product Details    ${product_name}

Add Product To Cart in Product Details Page
    ProductDetailsPage.Add Product to Cart

Remove Product From Cart in Product Details Page
    ProductDetailsPage.Remove Product From Cart

Add Product From Products Page
    [Arguments]    ${product}

    ProductPage.Add Product    ${product}

Remove Product From Products Page
    [Arguments]    ${product}

    ProductPage.Remove Product    ${product}

Go To Cart
    CartBadge.Click Cart Link
   

Remove Product From Cart
    [Arguments]    ${product_name}

    CartPage.Remove Product    ${product_name}

Get Number of Products in Cart
    ${count}=    CartBadge.Get Product Count
    RETURN    ${count}

Verify Products in Cart
    [Arguments]    @{product_names}

    CartPage.Verify Product In Cart      @{product_names}  

Verify Number of Products in Cart
    [Arguments]    ${expected_count}

    CartBadge.Verify Product Count    ${expected_count}
    
Verify Product Not in Cart
    [Arguments]    ${product_name}

    CartPage.Verify Product Not In Cart    ${product_name}

Verify Cart Is Empty 
    CartBadge.Verify Badge Is Hidden