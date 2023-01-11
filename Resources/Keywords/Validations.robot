*** Settings ***
Library    ../Python_files/json_schema_comparison.py

*** Keywords ***
Compare JSON-Schemas
    [Arguments]    ${ReferenceSchemaLocation}    ${RequestJSONParse}
    Log To Console    Comparing if the JSON-schema files are the same
    Compare_Schemas    ${ReferenceSchemaLocation}    ${RequestJSONParse}