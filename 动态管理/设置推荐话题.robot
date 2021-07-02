
***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证设置推荐成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/topics?&recommend=false    headers=${header}
    ${id}    Get from Dictionary    ${response.json()}[data][rows][0]    id
    ${response1}=    Get On Session    api    url=/cms/op/trend/topic/${id}/recommend    headers=${header}
    Should be equal    ${response1.json()}[code]    ok
    
验证取消推荐成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/topics?&recommend=true    headers=${header}
    ${id}    Get from Dictionary    ${response.json()}[data][rows][0]    id
    ${response1}=    Get On Session    api    url=/cms/op/trend/topic/${id}/unrecommend    headers=${header}
    Should be equal    ${response1.json()}[code]    ok