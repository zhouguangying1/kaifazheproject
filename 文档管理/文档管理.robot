***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Library    DateTime
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建子目录成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary         name=33    parentId=0    type=0       
    ${response}=    Post On Session    api    /cms/wiki    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证创建子文档成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary         name=33    parentId=0    type=1    content=33      
    ${response}=    Post On Session    api    /cms/wiki    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证修改文档成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary         name=33    parentId=0    type=1    content=33      
    ${response}=    Post On Session    api    /cms/wiki    json=${data}    headers=${header}  
    &{data1}=        Create Dictionary         name=33    parentId=0    type=1    content=333333     id=${response.json()}[data]      
    ${response1}=    Put On Session    api    /cms/wiki    json=${data1}    headers=${header} 
    Should Not Be Empty    ${response1.json()}[data] 
    
验证查看文档成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary         name=33    parentId=0    type=1    content=33      
    ${response}=    Post On Session    api    /cms/wiki    json=${data}    headers=${header}  
    ${response1}=    Get On Session    api    /cms/wiki/${response.json()}[data]    headers=${header} 
    Should Not Be Empty    ${response1.json()}[data] 
    
验证删除文档成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary         name=33    parentId=0    type=1    content=33      
    ${response}=    Post On Session    api    /cms/wiki    json=${data}    headers=${header} 
    ${response1}=    Delete On Session    api    /cms/wiki/${response.json()}[data]    headers=${header} 
    Should Be Equal As Strings    ${response1.json()}[code]     ok
    
