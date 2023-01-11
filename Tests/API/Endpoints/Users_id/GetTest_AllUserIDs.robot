*** Settings ***
Resource    ../../../../Resources/Keywords/Imports.resource
Resource    ../../../../Resources/Test_data/Variables/Imports.resource

Library    RequestsLibrary

Suite Setup    Authorization

*** Test Cases ***
Verify GET All users request returns 200
    Log To Console    \nSending GET-request to ${Global_endpoint_AllUserIDs}\n
    ${response}    GET    url=${Global_endpoint_AllUserIDs}    expected_status=200    headers=${GLOBAL_AUTH_HEADER}
    Compare JSON-Schemas    ReferenceSchemaLocation=${Global_login_schema_AllUsers}    RequestJSONParse=${response.json()}

#Learning 1: JSON-schema properties are needed only once in reference_schema file.
#Learning 2: Decimal-numbers are called "numbers" in JSON-schema files.
#Learning 3: Arrays must always be indicated with brackets in JSON-schema files
#Learning 4: Use a JSON to JSON-schema converter to generate the reference file.