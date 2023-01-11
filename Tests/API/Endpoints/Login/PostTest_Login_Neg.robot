*** Settings ***
Resource    ../../../../Resources/Test_data/Variables/Imports.resource
Resource    ../../../../Resources/Keywords/Imports.resource

Library    RequestsLibrary

Test Template    Custom test template

*** Keywords ***
Custom test template
    [Arguments]    ${username}    ${password}
    Log To Console    \nSending request to login-endpoint ${Global_endpoint_login}\n
    &{Login_specs}   Create Dictionary    username=${username}    password=${password}
    ${API_login_response} =    POST    url=${Global_endpoint_login}    json=${Login_specs}    expected_status=401
    Compare JSON-Schemas    ReferenceSchemaLocation=${Global_login_schema_neg}    RequestJSONParse=${API_login_response.json()}


*** Test Cases ***                                            USERNAME        PASSWORD
Verify login with wrong username and password returns 401     guest           wrongPass

Verify login with wrong password returns 401                  admin           wrongPass

Verify login with wrong username returns 401                  guest           masterPass

Verify login without credentials returns 401                  ${EMPTY}        ${EMPTY}

#Learning 1: Test templates are created under Keywords-section. Test template's iterables must be specified in Arguments.
#they must also be added to the Test Cases -header row.
#The parameters of the iterables are given on same row with individual test cases.
#Learning 2: To create keywords, write program to python, import to keyword-file,
#use python-function in the keyword, and add function's arguments to keyword's
#arguments