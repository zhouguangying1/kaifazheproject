
***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证未输入内容，查询全部内容
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trends    headers=${header}
    @{list1}=    列表内容抽取    ${response}    status
    List Should Contain Value    ${list1}    ${0}    ${1}

验证输入内容查询，查询出指定内容
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trends?&content=1    headers=${header}
    Should Not Be Equal    ${response.json()}[data][total]    0

验证输入话题查询，查询出指定话题内容内容
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trends?&topic=123    headers=${header}
    Should Not Be Equal    ${response.json()}[data][total]    0
    
验证按照推荐查询，查询出推荐的内容
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trends?&recommend=true    headers=${header}
    Should Not Be Equal    ${response.json()}[data][total]    0

验证按照待审核查询，查询出待审核的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trends?&status=0    headers=${header}
    Should Not Be Equal    ${response.json()}[data][total]    0