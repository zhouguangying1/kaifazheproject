***Settings***
Library    RequestsLibrary
Resource    ../resources/public.robot    
*** Test Cases ***
验证获取天津市的区列表成功
    Create Session    api    ${url} 
    ${response}=    Get On Session    api    url=/basic/region/countys?&cityId=120100000000
    Log    ${response.json()}[data]
    ${length}=    Get Length    ${response.json()}[data]    
    Should not be equal    ${length}    0
    
