*** Settings ***
Library          SeleniumLibrary
Library          String

*** Variables ***

${INVENTORY_ITEM_NAME}              css=[data-test="inventory-item-name"]


*** Keywords ***

Verify Products Loaded
    Wait Until Page Contains    Products
    Page Should Contain Element    ${INVENTORY_ITEM_NAME}

Verify Products Page Not Empty
    ${count}=    Get Element Count    ${INVENTORY_ITEM_NAME}
    Should Be True    ${count} > 0

Add to Cart
    [Arguments]    ${product_name}

    ${add_button}=    Set Variable
    ...    xpath=//div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space(.)="${product_name}"]]//button[contains(@data-test, "add-to-cart")]
    ${remove_button}=    Set Variable
    ...    xpath=//div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space(.)="${product_name}"]]//button[contains(@data-test, "remove")]
    
    Click Button    ${add_button}
    Element Should Be Visible    ${remove_button}

Remove from Cart
    [Arguments]    ${product_name}
    ${add_button}=    Set Variable
    ...    xpath=//div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space(.)="${product_name}"]]//button[contains(@data-test, "add-to-cart")]
    ${remove_button}=    Set Variable
    ...    xpath=//div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space(.)="${product_name}"]]//button[contains(@data-test, "remove")]
    Click Button    ${remove_button}
    Element Should Not Be Visible    ${remove_button}