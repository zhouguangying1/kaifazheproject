***Settings***
Library    RequestsLibrary
Resource    ../resources/public.robot    
*** Test Cases ***
验证获取江苏省的市列表成功
    Create Session    api    ${url} 
    ${response}=    Get On Session    api    url=/basic/region/citys?&provinceId=320000000000
    Log    ${response.json()}[data]
    ${length}=    Get Length    ${response.json()}[data]    
    Should not be equal    ${length}    0
    
