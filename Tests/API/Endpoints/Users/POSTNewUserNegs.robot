#How to define how many times the contract is created in the create user keyword? Repeat Keyword in BuiltIn-library
#Learning point: what are differences between value, {value}, and ${value}
*** Settings ***
Resource    ../../../../Resources/Keywords/Imports.resource
Resource    ../../../../Resources/Test_data/Variables/Imports.resource

Library    RequestsLibrary

Suite Setup    Authorization

Test Template    Create New User TC

*** Keywords ***
Create New User TC
    [Arguments]    ${number_of_contracts}
    Log To Console    \n Sending POST-request to ${Global_endpoint_users} for negative 
    ...    user creation scenarios\n
    ${KW_ID}    ${KW_response}    Create New User KW    numberofContracts=${number_of_contracts}    expected_status_code=400
    #Set Suite Variable    ${SUITE_USER_ID}    ${KW_ID}
    Compare JSON-Schemas    ReferenceSchemaLocation=${Global_login_schema_NegCreateUser}    RequestJSONParse=${KW_response.json()}

*** Test Cases ***                    Number_of_contracts
Verify 0 contracts returns 400        ${0}

Verify 4 contracts returns 400        ${4}
