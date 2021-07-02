
***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建线上推荐的头条记录成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    titlePage=${titlePage}        title=标题1            content=内容1        status=${1}   top=${1}
    ${response}=    Post On Session    api    /cms/headline    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data]      


验证创建线上不推荐的头条记录成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    titlePage=${titlePage}        title=标题2            content=内容1        status=${1}   top=${0}
    ${response}=    Post On Session    api    /cms/headline    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 

验证创建线下推荐的头条记录成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    titlePage=${titlePage}        title=标题2            content=内容1        status=${0}   top=${1}
    ${response}=    Post On Session    api    /cms/headline    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证创建线下不推荐的头条记录成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    titlePage=${titlePage}        title=标题2            content=内容1        status=${0}   top=${0}
    ${response}=    Post On Session    api    /cms/headline    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证查看详情成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    titlePage=${titlePage}        title=标题2            content=内容1        status=${0}   top=${0}
    ${response}=    Post On Session    api    /cms/headline    json=${data}    headers=${header}  
    ${response1}=    Get On Session    api    /cms/headline/${response.json()}[data]     headers=${header} 
    Should Be Equal As Strings    ${response1.json()}[msg]    操作成功
    
验证删除成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    titlePage=${titlePage}        title=标题2            content=内容1        status=${0}   top=${0}
    ${response}=    Post On Session    api    /cms/headline    json=${data}    headers=${header}  
    ${response1}=    Delete On Session    api    /cms/headline/${response.json()}[data]     headers=${header} 
    Should Be Equal As Strings    ${response1.json()}[msg]    操作成功
    
验证修改成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    titlePage=${titlePage}        title=标题2            content=内容1        status=${0}   top=${0}
    ${response}=    Post On Session    api    /cms/headline    json=${data}    headers=${header}
    &{data1}=    Create Dictionary    id=${response.json()}[data]     content=内容2     status=${1}   top=${1}
    ${response1}=    Put On Session    api    /cms/headline     headers=${header}    json=${data1} 
    Should Be Equal As Strings    ${response1.json()}[msg]    操作成功
    
验证没有输入条件，查询全部成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/headlines        headers=${header}
    Should Not Be Equal  ${response.json()}[data][total]  0
    
验证按照标题查询成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/headlines?&title=标题2        headers=${header}
    Should Not Be Equal  ${response.json()}[data][total]  0
    
验证按照状态查询成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/headlines?&status=1        headers=${header}
    Should Not Be Equal  ${response.json()}[data][total]  0