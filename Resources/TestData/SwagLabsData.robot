*** Variables ***
${BROWSER}             Chrome
${URL}                 https://www.saucedemo.com/
${PASSWORD}            secret_sauce
${INVALID_PASSWORD}    test123
${INVALID_USER}        test
${LOCKED_OUT_USER}     locked_out_user

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

${INVALID_LOGIN_ERROR}
...    Epic sadface: Username and password do not match any user in this service

${USERNAME_REQUIRED_ERROR}
...    Epic sadface: Username is required

${PASSWORD_REQUIRED_ERROR}
...    Epic sadface: Password is required

${LOCKED_OUT_ERROR}
...    Epic sadface: Sorry, this user has been locked out.