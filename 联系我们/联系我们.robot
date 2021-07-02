***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Library    DateTime
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建联系我们成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${qrcode}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    &{data}=    Create Dictionary     qrcode=${qrcode}   status=1    title=联系我们       
    ${response}=    Post On Session    api    /cms/concactUs    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证修改联系我们成功
   Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${qrcode}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    &{data}=    Create Dictionary     qrcode=${qrcode}   status=1    title=联系我们       
    ${response}=    Post On Session    api    /cms/concactUs    json=${data}    headers=${header}
    &{data1}=    Create Dictionary     qrcode=${qrcode}   status=1    title=联系我们      id=${response.json()}[data]       
    ${response1}=    Put On Session    api    /cms/concactUs    json=${data1}    headers=${header} 
    Should Not Be Empty    ${response1.json()}[data] 
    
验证删除联系我们成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${qrcode}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    &{data}=    Create Dictionary     qrcode=${qrcode}   status=1    title=联系我们       
    ${response}=    Post On Session    api    /cms/concactUs    json=${data}    headers=${header}
    ${response1}=    Delete On Session    api    /cms/concactUs/${response.json()}[data]     headers=${header} 
    Should Be Equal As Strings    ${response1.json()}[code]     ok
    
验证不输入查询条件，显示全部记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    /cms/concactUss        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]  
    
验证按照标题搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/concactUss?&title=联系我们        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total] 
    
验证按照状态搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/concactUss?&status=1        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]     
    
