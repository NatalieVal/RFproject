*** Settings ***
Documentation    This is suite relating to saucedemo shop actions

Resource    ../Resources/SwagLabs.WebGui.robot
Resource    ../Resources/Common/Common.robot
Resource    ../Resources/TestData/SwagLabsData.robot

# Suite Setup       Insert Testing Data
Test Setup          Common.Begin Web Test    ${URL}
Test Teardown       Common.End Web Test  
# Suite Teardown    Cleanup Testing Data

#Run the script:
# robot -d Results Tests/SwagLabs-shopping.robot
# OR
# robot -d Results -t 'User Should be able to add an item to a shopping cart' Tests/SwagLabs-shopping.robot

*** Variables ***
# variables in TestData/SwagLabsData.robot

*** Test Cases ***

User Should be able to view product details
    [Documentation]     Opening the details of the item
    [Tags]              viewItem     standardUser 

    Log                 Starting the test case!     level=INFO

    SwagLabs.WebGui.Log in    ${VALID_USERS}[0]     ${PASSWORD} 
    SwagLabs.WebGui.View Product Details    ${PRODUCT_NAMES}[3]

User Should be able to add an item to the shopping cart in product details page
    [Documentation]     Opening the details of the item
    [Tags]              viewItem     standardUser 

    Log                 Starting the test case!     level=INFO

    SwagLabs.WebGui.Log in    ${VALID_USERS}[0]     ${PASSWORD} 
    SwagLabs.WebGui.View Product Details    ${PRODUCT_NAMES}[1]
    SwagLabs.WebGui.Add Product To Cart in Product Details Page
    SwagLabs.WebGui.Verify Number of Products in Cart    1

User Should be able to remove the item from the shopping cart in the product detail page
    [Documentation]     Adding an item to a cart - happy path
    [Tags]              addToCart     standardUser 

    Log                 Starting the test case!     level=INFO

    SwagLabs.WebGui.Log in    ${VALID_USERS}[0]     ${PASSWORD}       
    SwagLabs.WebGui.View Product Details    ${PRODUCT_NAMES}[1]
    SwagLabs.WebGui.Add Product To Cart in Product Details Page
    SwagLabs.WebGui.Verify Number of Products in Cart    1
    SwagLabs.WebGui.Remove Product From Cart in Product Details Page
    SwagLabs.WebGui.Verify Cart Is Empty

User Should be able to add an item to the shopping cart from the "Products" page
    [Documentation]     Adding an item to a cart - happy path
    [Tags]              addToCart     standardUser 

    Log                 Starting the test case!     level=INFO

    SwagLabs.WebGui.Log in    ${VALID_USERS}[0]     ${PASSWORD}       
    SwagLabs.WebGui.Add Product From Products Page    ${PRODUCT_NAMES}[1]
    SwagLabs.WebGui.Go To Cart
    SwagLabs.WebGui.Verify Number of Products in Cart    1



User Should be able to add all products to the shopping cart
    [Documentation]    Verify that all products can be added to the cart
    [Tags]             addToCart    standardUser    positive

    SwagLabs.WebGui.Log In    ${VALID_USERS}[0]    ${PASSWORD}

    FOR    ${product_name}    IN    @{PRODUCT_NAMES}
        SwagLabs.WebGui.Add Product From Products Page    ${product_name}
    END

    ${expected_count}=    Get Length    ${PRODUCT_NAMES}
    SwagLabs.WebGui.Go To Cart
    SwagLabs.WebGui.Verify Number Of Products In Cart    ${expected_count}

User Should be able to remove an item from the shopping cart
    [Documentation]     Adding an item to a cart - unhappy path
    [Tags]              removeFromCart     standardUser     negative 

    Log                 Starting the test case!     level=INFO

    SwagLabs.WebGui.Log in                                 ${VALID_USERS}[0]     ${PASSWORD}       
    SwagLabs.WebGui.Add Product From Products Page                    ${PRODUCT_NAMES}[0]
    SwagLabs.WebGui.Add Product From Products Page                    ${PRODUCT_NAMES}[2]
    SwagLabs.WebGui.Go To Cart
    SwagLabs.WebGui.Verify Products in Cart                ${PRODUCT_NAMES}[0]    ${PRODUCT_NAMES}[2]
    ${count_before}=    SwagLabs.WebGui.Get Number of Products in Cart
    SwagLabs.WebGui.Remove Product From Cart            ${PRODUCT_NAMES}[2]
    ${count_after}=    SwagLabs.WebGui.Get Number of Products in Cart

    Should Be Equal As Integers    ${count_after}    ${count_before - 1}
    SwagLabs.WebGui.Verify Product Not In Cart             ${PRODUCT_NAMES}[2]
    SwagLabs.WebGui.Verify Products in Cart                ${PRODUCT_NAMES}[0] 
