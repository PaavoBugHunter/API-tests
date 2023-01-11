*** Variables ***

${Global_api_url} =     http://127.0.0.1:5000
${Global_endpoint_users}    ${Global_api_url}/users
${Global_endpoint_login}    ${Global_api_url}/login

${Global_endpoint_UserID}   ${Global_endpoint_users}/1
${Global_endpoint_AllUserIDs}    ${Global_api_url}/users?filter=all