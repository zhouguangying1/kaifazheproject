
***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证未输入内容，查询全部记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/topics    headers=${header}
    Should not be empty    ${response.json()}[data][rows]
    
验证按照推荐为true查询记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/topics?&recommend=true    headers=${header}
    @{list1}=    列表内容抽取    ${response}    recommend
    List Should not contain value    ${list1}    ${False}
    
验证按照推荐为false查询记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/topics?&recommend=false    headers=${header}
    @{list2}=    列表内容抽取    ${response}    recommend
    List Should not contain value    ${list2}    ${True}
    
验证按照topic查询记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/topics?&topic=新年    headers=${header}
    Should not be empty    ${response.json()}[data][rows]
    
验证按照字段组合查询记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/topics?&topic=新年&recommend=false    headers=${header}
    Should not be empty    ${response.json()}[data][rows]