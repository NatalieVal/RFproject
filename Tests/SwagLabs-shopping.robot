*** Settings ***
Documentation    This is suite relating to saucedemo shop actions

Resource    ../Resources/SwagLabs.WebGui.robot
Resource    ../Resources/Common.robot

# Suite Setup       Insert Testing Data
Test Setup          Common.Begin Web Test    https://www.saucedemo.com/
Test Teardown       Common.End Web Test  
# Suite Teardown    Cleanup Testing Data

#Run the script:
# robot -d Results Tests/SwagLabs-shop.robot
# OR
# robot -d Results -t 'User Should be able to add an item to a shopping cart' Tests/SwagLabs-shopping.robot

*** Variables ***

${PRODUCT_NAME}    Sauce Labs Bolt T-Shirt
${PASSWORD}    secret_sauce
@{VALID_USERS}
...    standard_user
...    problem_user
...    performance_glitch_user
...    error_user
...    visual_user

@{PRODUCT_NAMES}        
...    Sauce Labs Bolt T-Shirt
...    Sauce Labs Backpack
...    Sauce Labs Bike Light
...    Sauce Labs Fleece Jacket
...    Sauce Labs Onesie
...    Test.allTheThings() T-Shirt (Red)

*** Test Cases ***


User Should be able to add an item to the shopping cart
    [Documentation]     Adding an item to a cart - happy path
    [Tags]              addToCart     standardUser 

    Log                 Starting the test case!     level=INFO

    SwagLabs.WebGui.Log in    ${VALID_USERS}[0]     ${PASSWORD}       
    SwagLabs.WebGui.Add Product To Cart    ${PRODUCT_NAME}
    SwagLabs.WebGui.Go To Cart
    SwagLabs.WebGui.Verify Number of Products in Cart    1

User Should be able to add all products to the shopping cart
    [Documentation]    Verify that all products can be added to the cart
    [Tags]             addToCart    standardUser    positive

    SwagLabs.WebGui.Log In    ${VALID_USERS}[0]    ${PASSWORD}

    FOR    ${product_name}    IN    @{PRODUCT_NAMES}
        SwagLabs.WebGui.Add Product To Cart    ${product_name}
    END

    ${expected_count}=    Get Length    ${PRODUCT_NAMES}
    SwagLabs.WebGui.Go To Cart
    SwagLabs.WebGui.Verify Number Of Products In Cart    ${expected_count}

User Should be able to remove an item from the shopping cart
    [Documentation]     Adding an item to a cart - unhappy path
    [Tags]              removeFromCart     standardUser     negative 

    Log                 Starting the test case!     level=INFO

    SwagLabs.WebGui.Log in                                 ${VALID_USERS}[0]     ${PASSWORD}       
    SwagLabs.WebGui.Add Product To Cart                    ${PRODUCT_NAMES}[0]
    SwagLabs.WebGui.Add Product To Cart                    ${PRODUCT_NAMES}[2]
    SwagLabs.WebGui.Go To Cart
    SwagLabs.WebGui.Verify Products in Cart                ${PRODUCT_NAMES}[0]    ${PRODUCT_NAMES}[2]
    ${count_before}=    SwagLabs.WebGui.Get Number of Products in Cart
    SwagLabs.WebGui.Remove Product From Cart               ${PRODUCT_NAMES}[2]
    ${count_after}=    SwagLabs.WebGui.Get Number of Products in Cart

    Should Be Equal As Integers    ${count_after}    ${count_before - 1}
    SwagLabs.WebGui.Verify Product Not In Cart             ${PRODUCT_NAMES}[2]
    SwagLabs.WebGui.Verify Products in Cart                ${PRODUCT_NAMES}[0] 
