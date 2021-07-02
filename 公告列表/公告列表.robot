
***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建公告成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary    title=33    content=33    noticeType=anquan    status=1
    ${response}=    Post On Session    api    /basic/system/notice    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证编辑公告成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary    title=33    content=33    noticeType=anquan    status=1
    ${response}=    Post On Session    api    /basic/system/notice    json=${data}    headers=${header} 
    &{data1}=    Create Dictionary    title=333    content=333    noticeType=anquan    status=1    id=${response.json()}[data]
    ${response}=    Put On Session    api    /basic/system/notice    json=${data1}    headers=${header} 
    Should Not Be Empty    ${response.json()}[data]  
    
验证查看公告详情成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary    title=33    content=33    noticeType=anquan    status=1
    ${response}=    Post On Session    api    /basic/system/notice    json=${data}    headers=${header}  
    ${response1}=    Get On Session    api    /basic/system/notice/${response.json()}[data]
    Should Not Be Empty    ${response1.json()}[data][id]

验证删除功能
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary    title=33    content=33    noticeType=anquan    status=1
    ${response}=    Post On Session    api    /basic/system/notice    json=${data}    headers=${header}
    ${response2}=    Delete On Session    api   /basic/system/notice/${response.json()}[data]    headers=${header}
    Should Be equal as strings    ${response2.json()}[code]    ok      
    
验证按照查询条件查询
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response1}=    Get On Session    api    url=/basic/system/notices?&title=测试&noticeType=&status=1    headers=${header}
    Should Not Be Equal As Strings    ${response1.json()}[data][total]    0
    
