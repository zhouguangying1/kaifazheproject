*** Settings ***
Library    RequestsLibrary
Library    Collections


Resource    ./resources/public.robot
*** Variables ***
# ${url}    http://106.12.185.21

*** Test Cases ***
验证输入正确的用户名和密码登录成功
     [Tags]   3 
     ${data}    Create Dictionary    grant_type=client_account    account=${user_account}    password=${user_passwd}    scope=all 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=200
    Should Not Be Empty    ${response.json()}[data][access_token]    
    Status Should Be    200

验证输入错误的密码登录失败
     [Tags]   4 
     ${data}    Create Dictionary    grant_type=client_account    account=${user_account}    password=${user_passwd}3    scope=all 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=401
    Should Be Equal As Strings    ${response.json()}[msg]    用户名或密码错误
    Status Should Be    401
    
验证输入错误的账号登录失败
     [Tags]   25 
     ${data}    Create Dictionary    grant_type=client_account    account=admin1    password=${user_passwd}    scope=all 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=401
    Should Be Equal As Strings    ${response.json()}[desc]    用户名或密码错误
    Status Should Be    401
    

验证grant_type输入不正确登录失败
     [Tags]   26 
     ${data}    Create Dictionary    grant_type=client_account1    account=${user_account}    password=${user_passwd}    scope=all 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=401
    Should contain    ${response.json()}[msg]    Unsupported grant type
    Status Should Be    401
    
验证grant_type为空时登录失败
     [Tags]   27 
     ${data}    Create Dictionary    grant_type=    account=${user_account}    password=${user_passwd}    scope=all 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=401
    Should contain    ${response.json()}[msg]    Missing grant type
    Status Should Be    401
    
验证scope输入不正确登录失败
     [Tags]  30 
     ${data}    Create Dictionary    grant_type=client_account    account=${user_account}    password=${user_passwd}    scope=all1 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=401
    Should contain    ${response.json()}[msg]    Invalid scope
    Status Should Be    401 
    
验证scope输入为空登录成功
     [Tags]  32 
     ${data}    Create Dictionary    grant_type=client_account    account=${user_account}    password=${user_passwd}    scope= 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    
    Should Not Be Empty    ${response.json()}[data][access_token]    
    Status Should Be    200 
    
验证account为空时登录失败
     [Tags]   28 
     ${data}    Create Dictionary    grant_type=client_account    account=    password=${user_passwd}    scope=all 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=401
    Should contain    ${response.json()}[msg]    The account must be supplied
    Status Should Be    401
    
验证密码为空时登录失败
     [Tags]   29 
     ${data}    Create Dictionary    grant_type=client_account    account=${user_account}    password=    scope=all 
    登录前认证
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=401
    Should contain    ${response.json()}[msg]    The password must be supplied
    Status Should Be    401       
    
*** Keywords ***
登录前认证
    
    ${auth}=  Create List    ${auth_admin}    ${auth_passwd} 
    ${header}    Create Dictionary        Content-Type=application/x-www-form-urlencoded  
    Create Session   api     ${url}      ${header}     auth=${auth}