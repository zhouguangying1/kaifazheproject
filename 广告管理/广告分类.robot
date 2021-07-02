***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Library    DateTime
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建分类成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    
    &{data}=    Create Dictionary     dictType=ad_rotation   dictLabel=测试1    dictCode=3    dictValue=2    status=1       
    ${response}=    Post On Session    api    /basic/ad/type    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[code]    ok 
    
验证修改分类成功
   Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/basic/ad/types?&dictLabel=测试1    headers=${header}      
    &{data}=    Create Dictionary     dictType=ad_rotation   dictLabel=测试12    dictCode=${response.json()}[data][rows][0][dictCode]    dictValue=2    status=1                
    ${response1}=    Put On Session    api    /basic/ad/type    json=${data}    headers=${header} 
    Should Not Be Empty    ${response1.json()}[code]    ok 
    
验证不输入查询条件，显示全部记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/basic/ad/types       headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]    
    
验证按照分类名称搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/basic/ad/types?&dictLabel=测试1        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]
    
验证删除分类成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/basic/ad/types?&dictLabel=测试1    headers=${header}  
    ${response1}=    Delete On Session    api    /basic/ad/type/${response.json()}[data][rows][0][dictCode]     headers=${header} 
    Should Be Equal As Strings    ${response1.json()}[code]     ok
    


