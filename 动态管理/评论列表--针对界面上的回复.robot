
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
    ${response}=    Get On Session    api    url=/cms/op/trend/comments    headers=${header}
    Should not be empty     ${response.json()}[data][total]   

验证输入内容查询，查询出指定内容
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/comments?&content=周广英    headers=${header}
    Should Not Be Equal    ${response.json()}[data][total]    0
    
验证按照status查询出审核通过的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/comments?&status=1    headers=${header}
    Should Not Be Equal    ${response.json()}[data][total]    0

验证删除评论记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/comments?&status=1    headers=${header}
    ${response1}=    Delete On Session    api  url=/cms/op/trend/comment/${response.json()}[data][rows][0][id]    headers=${header}
    Should be equal    ${response1.json()}[code]    ok
    
验证批量删除评论记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}    
    
    ${response}=    Get On Session    api    url=/cms/op/trend/comments?&status=1    headers=${header}
    ${header1}=    Create Dictionary        Authorization=${access_token}    content-type=application/json
    ${response1}=    Delete On Session    api  /cms/op/trend/comment    data={"ids":["${response.json()}[data][rows][0][id]"]}    headers=${header1}
    Should be equal    ${response1.json()}[code]    ok
    
验证按照status查询出待审核记录，进行审核通过
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/comments?&status=0    headers=${header}
    # ${response.json()}[data][rows][0][id]
    ${response1}=    Post On Session    api    url=/cms/op/trend/comment/${response.json()}[data][rows][0][id]/pass    headers=${header}
    Should be equal    ${response1.json()}[code]    ok
    
    
验证按照status查询出待审核记录，进行审核拒绝通过
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/op/trend/comments?&status=0    headers=${header}
    # ${response.json()}[data][rows][0][id]
    &{data}=    Create Dictionary    id=${response.json()}[data][rows][0][id]    mark=不通过
    ${response1}=    Post On Session    api    url=/cms/op/trend/comment/refuse    headers=${header}    json=${data}
    Should be equal    ${response1.json()}[code]    ok
    

   
