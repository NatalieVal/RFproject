*** Settings ***
Library          SeleniumLibrary
Library          String
Resource         ../Common/ProductLocators.robot

*** Variables ***

${INVENTORY_ITEM_NAME}              css=[data-test="inventory-item-name"]


*** Keywords ***

Verify Products Loaded
    Wait Until Page Contains    Products
    Page Should Contain Element    ${INVENTORY_ITEM_NAME}

Verify Products Page Not Empty
    ${count}=    Get Element Count    ${INVENTORY_ITEM_NAME}
    Should Be True    ${count} > 0

Select product
    [Arguments]    ${product_name}
    Click Link    partial link=${product_name}

Add Product
    [Arguments]    ${product_name}
    ${add_button}=    Get Product Button    ${product_name}    add-to-cart
    ${remove_button}=    Get Product Button    ${product_name}    remove

    Click Button    ${add_button}
    Element Should Be Visible    ${remove_button}

Remove Product
    [Arguments]    ${product_name}
    ${add_button}=    Get Product Button    ${product_name}    add-to-cart
    ${remove_button}=    Get Product Button    ${product_name}    remove

    Click Button    ${remove_button}
    Element Should Be Visible    ${add_button}
    Element Should Not Be Visible    ${remove_button}