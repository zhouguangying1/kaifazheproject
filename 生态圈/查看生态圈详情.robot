***Settings***
Library    RequestsLibrary
Library    Collections

Resource    ../resources/public.robot
Suite Setup    登录    ${user_account}    ${user_passwd}

*** Test Cases ***
验证查看详情成功
    ${id}=    创建圈子    ${access_token}
    &{data}=    Create Dictionary    id=${id}
    ${header}=    Create Dictionary    Authorization=${access_token}
    ${response}=    Get on Session    api    /cms/agency/product/${id}      headers=${header}
    Should Not Be Empty    ${response.json()}[data]
    
验证未传入token查看详情失败
    ${id}=    创建圈子    ${access_token}
    &{data}=    Create Dictionary    id=${id}
    ${header}=    Create Dictionary    Authorization=${access_token}
    ${response}=    Get on Session    api    /cms/agency/product/${id}    expected_status=401     
    Should Be Equal    ${response.json()}[code]     ERROR_401
    
验证未传入id不存在接口提示
    # ${id}=    创建圈子    ${access_token}
    # &{data}=    Create Dictionary    id=${id}
    ${header}=    Create Dictionary    Authorization=${access_token}
    ${response}=    Get on Session    api    /cms/agency/product/12345    expected_status=404   headers=${header}      
    Should Be Equal    ${response.json()}[code]     BASE_ENTITY_0002    