***Settings***
Library    RequestsLibrary
Library    Collections
Resource    ../resources/public.robot
Suite Setup    登录    ${user_account}    ${user_passwd}
*** Variables ***
*** Test Cases ***
验证获取全部生态圈列表
    &{header}=    Create Dictionary    Authorization=${access_token}
    Create Session     api    ${url} 
    ${response}=    Get on Session    api    /cms/agency/products      headers=${header}
    Should Not Be Empty    ${response.json()}[data][total]
    
 
验证按照有声类型查询列表
    &{header}=    Create Dictionary    Authorization=${access_token}
    Create Session     api    ${url} 
    &{data}=    Create Dictionary    productType=music
    ${response}=    Get on Session    api    /cms/agency/products    ${data}      headers=${header} 
    Should Not Be Empty    ${response.json()}[data][total] 
    
验证按照新闻类型查询列表
    &{header}=    Create Dictionary    Authorization=${access_token}
    Create Session     api    ${url} 
    &{data}=    Create Dictionary    productType=news
    ${response}=    Get on Session    api    /cms/agency/products    ${data}      headers=${header} 
    Should Not Be Empty    ${response.json()}[data][total] 
    
验证按照视频类型查询列表
    &{header}=    Create Dictionary    Authorization=${access_token}
    Create Session     api    ${url} 
    &{data}=    Create Dictionary    productType=video
    ${response}=    Get on Session    api    /cms/agency/products    ${data}      headers=${header} 
    Should Not Be Empty    ${response.json()}[data][total] 
    
验证按照生态圈类型查询列表
    &{header}=    Create Dictionary    Authorization=${access_token}
    Create Session     api    ${url} 
    &{data}=    Create Dictionary    agencyType=CP
    ${response}=    Get on Session    api    /cms/agency/products    ${data}      headers=${header} 
    Should Not Be Empty    ${response.json()}[data][total]
    
验证按照上线状态查询列表
    &{header}=    Create Dictionary    Authorization=${access_token}
    Create Session     api    ${url} 
    &{data}=    Create Dictionary    status=1
    ${response}=    Get on Session    api    /cms/agency/products    ${data}      headers=${header} 
    Should Not Be Empty    ${response.json()}[data][total]
    
    
验证按照下线状态查询列表
    &{header}=    Create Dictionary    Authorization=${access_token}
    Create Session     api    ${url} 
    &{data}=    Create Dictionary    status=0
    ${response}=    Get on Session    api    /cms/agency/products    ${data}      headers=${header} 
    Should Not Be Empty    ${response.json()}[data][total]
    
验证按照组合查询列表
    &{header}=    Create Dictionary    Authorization=${access_token}
    Create Session     api    ${url} 
    &{data}=    Create Dictionary    status=0    agencyType=CP    productType=video
    ${response}=    Get on Session    api    /cms/agency/products    ${data}      headers=${header} 
    Should Not Be Empty    ${response.json()}[data][total]