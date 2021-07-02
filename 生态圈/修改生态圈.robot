***Settings***
Library    RequestsLibrary
Library    Collections

Suite Setup    登录    ${user_account}    ${user_passwd}

Resource    ../resources/public.robot
***Variables***
# ${url}    http://106.12.185.21
# @{file_msg}    create list

*** Test Cases ***
验证修改用例成功
    ${id}=    创建圈子    ${access_token}
    &{data}=    Create Dictionary    id=${id}    companyDesc=adg
    Update Session   api
    &{header}    Create Dictionary    Authorization=${access_token}    Content-Type=application/json
    ${response}=    PUT On Session     api   /cms/agency/product   json=${data}     headers=${header}        
    Should Not Be Empty    ${response.json()}
    
验证将状态改为下线成功
    ${id}=    创建圈子    ${access_token}
    &{data}=    Create Dictionary    id=${id}    companyDesc=adg    status=0
    Update Session   api
    &{header}    Create Dictionary    Authorization=${access_token}    Content-Type=application/json
    ${response}=    PUT On Session     api   /cms/agency/product   json=${data}     headers=${header}        
    Should Not Be Empty    ${response.json()}
    
验证id不存在时修改提示
    
    &{data}=    Create Dictionary    id=1234    companyDesc=adg
    Update Session   api
    &{header}    Create Dictionary    Authorization=${access_token}    Content-Type=application/json
    ${response}=    PUT On Session     api   /cms/agency/product   json=${data}     headers=${header}     expected_status=404       
    Should Be Equal       ${response.json()}[msg]    The entity is not found
    
验证没有认证时修改提示
    
    &{data}=    Create Dictionary    id=1234    companyDesc=adg
    Update Session   api
    &{header}    Create Dictionary    Authorization=    Content-Type=application/json
    ${response}=    PUT On Session     api   /cms/agency/product   json=${data}     headers=${header}     expected_status=401       
    Should Be Equal       ${response.json()}[code]    ERROR_401
    
    


