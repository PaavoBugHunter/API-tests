*** Settings ***
Resource    ../../../../Resources/Test_data/Variables/Imports.resource
Resource    ../../../../Resources/Keywords/Imports.resource

Library    RequestsLibrary

Suite Setup    Authorization

*** Test Cases ***
Delete Created User
    Log To Console    \nDeleting created user\n
    ${ID_to_delete}    ${User_creation_json}    Create New User KW
    ${Deletion_response}    Delete User    ${ID_to_delete}
    Compare JSON-Schemas    ReferenceSchemaLocation=${Global_deletion_schema}    RequestJSONParse=${DeletionResponse.json()}