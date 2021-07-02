***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved
Library    DateTime
Resource    ../resources/public.robot

Suite Setup    登录    ${user_account}    ${user_passwd}
*** Test Cases ***

    
验证按照职位搜索，显示指定的记录
    Create Session     api    ${url}
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Get On Session    api    url=/basic/operLogs?&title=123&status=1&startTime=2021-07-01 00:00:00&endTime=2021-07-08 00:00:00        headers=${header}
    Should Not Be Empty    ${response.json()}[data][total] 
    
  
