*** Settings ***
Library    SeleniumLibrary

*** Keywords ***

Get Product Button
    [Arguments]    ${product_name}    ${button_type}
    ${button}=    Set Variable
    ...    xpath=//div[@data-test="inventory-item"]
    ...    [.//div[@data-test="inventory-item-name" and normalize-space(.)="${product_name}"]]
    ...    //button[contains(@data-test, "${button_type}")]
    RETURN    ${button}