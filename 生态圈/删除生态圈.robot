***Settings***
Library    RequestsLibrary
Library    Collections

Resource    ../resources/public.robot
Suite Setup    登录    ${user_account}    ${user_passwd}

*** Test Cases ***
验证删除生态圈成功
    ${id}=    创建圈子    ${access_token}
    &{data}=    Create Dictionary    id=${id}
    ${header}=    Create Dictionary    Authorization=${access_token}
    ${response}=    Delete on Session    api    /cms/agency/product/${id}      headers=${header}
    Should Be Equal As Strings    ${response.json()}[msg]    操作成功
    
验证删除不存在的生态圈提示
    # ${id}=    创建圈子    ${access_token}
    # &{data}=    Create Dictionary    id=${id}
    ${header}=    Create Dictionary    Authorization=${access_token}
    Create Session    api    ${url}
    ${response}=    Delete on Session    api    /cms/agency/product/123      headers=${header}    expected_status=404
    Should Be Equal As Strings    ${response.json()}[desc]    找不到对应实例
    
验证未获取token,删除生态圈失败
    ${id}=    创建圈子    ${access_token}
    &{data}=    Create Dictionary    id=${id}
    # ${header}=    Create Dictionary    Authorization=${access_token}
    Create Session    api    ${url}
    ${response}=    Delete on Session    api    /cms/agency/product/${id}     expected_status=401     
    Should Be Equal As Strings    ${response.json()}[code]    ERROR_401
    