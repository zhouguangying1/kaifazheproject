***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Library    DateTime
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建广告成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    &{data}=    Create Dictionary    content=dd    link=d    status=1    title=dd    titlePage=${titlePage}    type=123     
    ${response}=    Post On Session    api    /cms/ad    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[code]    ok 
    ${response1}=    Delete On Session    api    /cms/ad/${response.json()}[data]     headers=${header} 
    
验证修改广告成功
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    &{data}=    Create Dictionary    content=dd    link=d    status=1    title=dd    titlePage=${titlePage}    type=123     
    ${response1}=    Post On Session    api    /cms/ad    json=${data}    headers=${header}       
    &{data1}=    Create Dictionary     content=dd    link=d    status=1    title=dd    titlePage=${titlePage}    type=123     status=1    id=${response1.json()}[data]                
    ${response2}=    Put On Session    api    /cms/ad    json=${data1}    headers=${header} 
    Should Not Be Empty    ${response2.json()}[code]    ok
      
    
验证不输入查询条件，显示全部记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/ads     headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]    
    
验证按照名称搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/ads?&title=dd        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]
    
验证按照分类查询
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/ads?&type=123        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]
    
验证删除广告成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/ads?&type=123   headers=${header}  
    ${response1}=    Delete On Session    api    /cms/ad/${response.json()}[data][rows][0][id]     headers=${header} 
    Should Be Equal As Strings    ${response1.json()}[code]     ok
    


