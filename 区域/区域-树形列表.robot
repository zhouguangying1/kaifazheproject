***Settings***
Library    RequestsLibrary
Resource    ../resources/public.robot    
*** Test Cases ***
验证depth传入1查省成功
    Create Session    api    ${url} 
    ${response}=    Get On Session    api    url=/basic/region/tree?&depth=1
    Log    ${response.json()}[data]
    ${length}=    Get Length    ${response.json()}[data]    
    Should not be equal    ${length}    0
    
验证depth传入2查市成功
    Create Session    api    ${url} 
    ${response}=    Get On Session    api    url=/basic/region/tree?&depth=2
    Log    ${response.json()}[data]
    ${length}=    Get Length    ${response.json()}[data]    
    Should not be equal    ${length}    0
    
验证depth传入3查县成功
    Create Session    api    ${url} 
    ${response}=    Get On Session    api    url=/basic/region/tree?&depth=3
    Log    ${response.json()}[data]
    ${length}=    Get Length    ${response.json()}[data]    
    Should not be equal    ${length}    0
    
