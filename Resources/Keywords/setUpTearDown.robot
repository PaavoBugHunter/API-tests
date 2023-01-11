*** Settings ***
Resource    ../Test_data/Variables/Imports.resource

Library    RequestsLibrary
Library    Collections

*** Keywords ***
Authorization
    IF    ${GLOBAL_AUTH_SET} == ${False}
        &{Login_specs}   Create Dictionary    username=admin    password=masterPass
        ${API_login_response} =    POST    url=${Global_endpoint_login}    json=${Login_specs}    expected_status=200
        ${API_login_response_JSONresponse}    Set Variable    ${API_login_response.json()}
        ${token}    Get From Dictionary    ${API_login_response_JSONresponse}    token
        &{headers}    Create Dictionary    Authorization=Bearer ${token}
        Set Global Variable    ${GLOBAL_AUTH_HEADER}    ${headers}
        Set Global Variable    ${GLOBAL_AUTH_SET}    ${True}
    END
    
Create New User KW
    [Arguments]    ${active}=${True}    ${city}=Testcity    ${contractcurrency}=EUR    ${contractid}=33    ${price}={9.99}    ${type}=basic
    ...    ${email}=tester@tester.com    ${name}=tester_name    ${street}=Test_street    ${surname}=tester_lastname
    ...    ${zip}=12345    ${numberofContracts}=${2}    ${expected_status_code}=201
    
    @{NewUserList}=    Create List
    IF    ${numberofContracts} > ${0}
        FOR    ${counter}    IN RANGE    ${numberofContracts}
            &{ContractDict}=    Create Dictionary    currency=${contractcurrency}    id=${contractid}    price=${price}    type=${type}
            Append To List    ${NewUserList}  ${ContractDict}
        END
    END
    
    &{BodyNewUSer}    Create Dictionary    active=${active}    city=${city}    contracts=${NewUserList}    email=${email}
    ...    name=${name}    street=${street}    surname=${surname}    zip=${zip}

    ${NewUserResponse}    POST    url=${Global_endpoint_users}    json=${BodyNewUSer}    expected_status=${expected_status_code}    headers=${GLOBAL_AUTH_HEADER}
    
    ${Cre_User_ID} =    Set Variable    ${EMPTY}
    IF    "${expected_status_code}" == "201"
        ${Cre_User_ID}    Get From Dictionary    ${NewUserResponse.json()}    ID
    END
    
    [Return]    ${Cre_User_ID}    ${NewUserResponse}

Delete User
    [Arguments]    ${User_id}
    
    ${DeletionResponse}    DELETE    url=${Global_endpoint_users}/${User_id}    expected_status=200    headers=${GLOBAL_AUTH_HEADER}
    [Return]    ${DeletionResponse}
