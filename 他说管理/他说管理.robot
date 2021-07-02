***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Library    DateTime
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建他说成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${date}=    Get Current Date    
    ${createtime}=    Add Time To Date    ${date}        1Days    
   &{data}=    Create Dictionary    title=ddd    content=ddd    nickname=ddd    qrcodeId=44    status=1    createTime=${createtime}    
    ${response}=    Post On Session    api    /cms/heSaid    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证编辑他说成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${date}=    Get Current Date    
    ${createtime}=    Add Time To Date    ${date}        1Days    
    &{data}=    Create Dictionary    title=ddd    content=ddd    nickname=ddd    qrcodeId=44    status=1    createTime=${createtime}    
    ${response}=    Post On Session    api    /cms/heSaid    json=${data}    headers=${header}
    &{data1}=    Create Dictionary    title=ddd    content=ddd    nickname=ddd    qrcodeId=44    status=1    createTime=${createtime}     id=${response.json()}[data]
    ${response1}=    Put On Session    api    /cms/heSaid    json=${data1}    headers=${header}
    Should Not Be Empty    ${response1.json()}[data] 
    
验证删除他说成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${date}=    Get Current Date    
    ${createtime}=    Add Time To Date    ${date}        1Days    
    &{data}=    Create Dictionary    title=ddd    content=ddd    nickname=ddd    qrcodeId=44    status=1    createTime=${createtime}    
    ${response}=    Post On Session    api    /cms/heSaid    json=${data}    headers=${header}
    ${response1}=    Delete On Session    api   url=/cms/heSaid/${response.json()}[data]    headers=${header}
    Should Be Equal As Strings   ${response1.json()}[code]    ok 
    
验证没有输入查询条件，查询全部
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api   url=/cms/heSaids    headers=${header}
    Should Not Be Empty   ${response.json()}[data][total]    
      
验证按照内容字段查询
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api   url=/cms/heSaids?&content=ddd    headers=${header}
    Should Not Be Empty   ${response.json()}[data][total] 
    
验证按照下线状态查询
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api   url=/cms/heSaids?&status=0    headers=${header}
    Should Not Be Empty   ${response.json()}[data][total] 

验证按照上线状态查询
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api   url=/cms/heSaids?&status=1    headers=${header}
    Should Not Be Empty   ${response.json()}[data][total] 