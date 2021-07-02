***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Library    DateTime
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建产品成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    &{data}=    Create Dictionary    content=eee    link=${titlePage}     status=0    subTitle=ee    title=ee    type=p1    
    ${response}=    Post On Session    api    /cms/product    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[code]     
    
验证修改产品成功
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${titlePage}=    上传文件，返回内容地址    ${CURDIR}\\..\\file\\logo.jpg
    &{data}=    Create Dictionary    content=eee    link=${titlePage}     status=0    subTitle=ee    title=ee    type=p1      
    ${response}=    Post On Session    api    /cms/product    json=${data}    headers=${header}       
    &{data}=    Create Dictionary    content=eee    link=${titlePage}     status=0    subTitle=ee    title=ee    type=p1     id=${response.json()}[data]                
    ${response1}=    Put On Session    api    /cms/product    json=${data}    headers=${header} 
    Should Not Be Empty    ${response1.json()}[code]     
    
验证不输入查询条件，显示全部记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/products     headers=${header}
    Should Not Be Equal As Strings    ${response.json()}[data][total]    0  
    
验证按照名称搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/products?&title=ee        headers=${header}
    Should Not Be Equal As Strings    ${response.json()}[data][total]    0
    
验证按照分类查询
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/products?&type=p1       headers=${header}
    Should Not Be Equal As Strings    ${response.json()}[data][total]    0
    
验证删除产品成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/products?&type=p1   headers=${header}  
    ${response1}=    Delete On Session    api    /cms/product/${response.json()}[data][rows][0][id]     headers=${header} 
    Should Be Equal As Strings    ${response1.json()}[code]     ok
    


