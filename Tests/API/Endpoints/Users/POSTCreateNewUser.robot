*** Settings ***
Resource    ../../../../Resources/Keywords/Imports.resource
Resource    ../../../../Resources/Test_data/Variables/Imports.resource

Library    RequestsLibrary

Suite Setup    Authorization

Suite Teardown    Delete User    ${SUITE_USER_ID}

*** Test Cases ***
Create New User TC
    Log To Console    \n Sending POST-request to ${Global_endpoint_users} to create new user\n
    ${KW_ID}    ${KW_response}    Create New User KW
    Set Suite Variable    ${SUITE_USER_ID}    ${KW_ID}
    Compare JSON-Schemas    ReferenceSchemaLocation=${Global_login_schema_CreateUser}    RequestJSONParse=${KW_response.json()}