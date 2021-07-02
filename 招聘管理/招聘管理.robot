***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Library    DateTime
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***
验证创建招聘成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary     position=测试    department=市场部    provinceId=120000000000    provinceName=天津市    cityId=120100000000    cityName=市辖区    detail=测试    status=1       
    ${response}=    Post On Session    api    /cms/joinUs    json=${data}    headers=${header}  
    Should Not Be Empty    ${response.json()}[data] 
    
验证修改招聘成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary     position=测试    department=市场部    provinceId=120000000000    provinceName=天津市    cityId=120100000000    cityName=市辖区    detail=测试    status=1       
    ${response}=    Post On Session    api    /cms/joinUs    json=${data}    headers=${header}
    &{data1}=    Create Dictionary     position=测试    department=市场部    provinceId=120000000000    provinceName=天津市    cityId=120100000000    cityName=市辖区    detail=测试    status=1    id=${response.json()}[data]       
    ${response1}=    Put On Session    api    /cms/joinUs    json=${data1}    headers=${header} 
    Should Not Be Empty    ${response1.json()}[data] 
    
验证删除招聘记录成功
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    &{data}=    Create Dictionary     position=测试    department=市场部    provinceId=120000000000    provinceName=天津市    cityId=120100000000    cityName=市辖区    detail=测试    status=1       
    ${response}=    Post On Session    api    /cms/joinUs    json=${data}    headers=${header}
    ${response1}=    Delete On Session    api    /cms/joinUs/${response.json()}[data]    headers=${header} 
    Should Be Equal As Strings    ${response1.json()}[code]     ok
    
验证不输入查询条件，显示全部记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    /cms/joinUss        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]  
    
验证按照职位搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/joinUss?&position=测试        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total] 
    
验证按照市场部搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/joinUss?&department=市场部        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]     
    
验证按照工作地搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/cms/joinUss?&cityId=120100000000        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]   