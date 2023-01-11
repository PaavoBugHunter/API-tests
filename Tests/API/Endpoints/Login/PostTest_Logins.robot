*** Settings ***
Resource    ../../../../Resources/Test_data/Variables/Imports.resource
Resource    ../../../../Resources/Keywords/Imports.resource

Library    RequestsLibrary

*** Test Cases ***
Verify Post returns 200
    Log To Console    \nSending request to login-endpoint ${Global_endpoint_login}\n
    &{Login_specs}   Create Dictionary    username=admin    password=masterPass
    ${API_login_response} =    POST    url=${Global_endpoint_login}    json=${Login_specs}    expected_status=200
    Compare JSON-Schemas    ReferenceSchemaLocation=${Global_login_schema_pos}    RequestJSONParse=${API_login_response.json()}

Verify Post returns 401
    Log To Console    \nSending request to login-endpoint ${Global_endpoint_login}\n
    &{Login_specs}   Create Dictionary    username=admin    password=wrongPass
    ${API_login_response} =    POST    url=${Global_endpoint_login}    json=${Login_specs}    expected_status=401
    Compare JSON-Schemas    ReferenceSchemaLocation=${Global_login_schema_neg}    RequestJSONParse=${API_login_response.json()}
#What are data and json parameters? They are specifications for the format in which request data must be sent to the api.
#In case of our api, it is dictated in the header that the request-data must come in json-format, "application/json; charset="UTF-8"".
#Therefore, if we specify the request to be sent in data-format, the request will fail.