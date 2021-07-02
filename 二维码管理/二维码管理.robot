
***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建二维码管理成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${avatar}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    ${qrcode}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    avatar= ${avatar}    qrcode=${qrcode}    content=d    nickname=d    title=dddd
    ${response}=    Post On Session    api    /cms/business/qrcode    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证编辑二维码管理成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}    Content-Type=application/json
    ${avatar}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    ${qrcode}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    
    &{data}=    Create Dictionary    avatar= ${avatar}    qrcode=${qrcode}    content=d    nickname=d    title=ddd
    ${response}=    Post On Session    api    /cms/business/qrcode    json=${data}    headers=${header}  
    &{data1}=    Create Dictionary    avatar= ${avatar}    qrcode=${qrcode}    content=d    nickname=d    title=ddd    id=${response.json()}[data]
    ${response}=    Put On Session    api    /cms/business/qrcode    json=${data1}    headers=${header} 
    Should Not Be Empty    ${response.json()}[data]  
    
验证查看二维码详情成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}    Content-Type=application/json
    ${avatar}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    ${qrcode}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    &{data}=    Create Dictionary    avatar= ${avatar}    qrcode=${qrcode}    content=d    nickname=d    title=ddd
    ${response}=    Post On Session    api    /cms/business/qrcode    json=${data}    headers=${header}  
    ${response1}=    Get On Session    api    /cms/business/qrcode/${response.json()}[data]
    Should Not Be Empty    ${response1.json()}[data][id]
      

验证不输入内容，查询全部内容
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response1}=    Get On Session    api    /cms/business/qrcodes    headers=${header}
    Should Not Be Empty    ${response1.json()}[data][total]
    
验证按照标题查询
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response1}=    Get On Session    api    url=/cms/business/qrcodes?&title=ddd    headers=${header}
    Should Not Be Empty    ${response1.json()}[data][total]
    
验证删除功能
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response1}=    Get On Session    api    url=/cms/business/qrcodes?&title=ddd    headers=${header}
    ${response2}=    Delete On Session    api   /cms/business/qrcode/${response1.json()}[data][rows][0][id]    headers=${header}
    Should Be equal as strings    ${response2.json()}[code]    ok