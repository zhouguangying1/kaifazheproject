***Settings***
Library    RequestsLibrary
Library    Collections
Library    Reserved

Resource    ../resources/public.robot
Suite Setup    登录    ${user_account}    ${user_passwd}
***Variables***
${index}    0
@{sampleddata_list}
*** Test Cases ***
全部查询
    ${header}    Create Dictionary   Authorization=${access_token}
    Create Session    api    ${url}
     ${response}=    Get on Session    api    /cms/agency/certificates      headers=${header}
    Should Be Equal As Strings    ${response.json()}[msg]    操作成功 
    
按照生态圈分类查询
    ${header}    Create Dictionary   Authorization=${access_token}
    Create Session    api    ${url}
    &{data1}=    Create Dictionary    agencyType=SP
    ${response}=    Get on Session    api    url=/cms/agency/certificates?&agencyType=SP       headers=${header}
    @{list}=    列表内容抽取    ${response}    agencyType
    Should Not Contain    ${list}    CP,T1,T2 
     
 
按照生态圈审核状态查询
    Create Session    api    ${url}
    ${header}    Create Dictionary   Authorization=${access_token}
    ${response}=    Get on Session    api    url=/cms/agency/certificates?&status=1       headers=${header}
    @{list}=    列表内容抽取    ${response}    status    
    Should Not Contain     ${list}    0,2 
    
按照evaluationFormName查询
    Create Session    api    ${url}
    ${header}    Create Dictionary   Authorization=${access_token}
    ${response}=    Get on Session    api    url=/cms/agency/certificates?&evaluationFormName=新建 Microsoft Excel 工作表.xlsx      headers=${header}
    @{list}=    列表内容抽取    ${response}    evaluationFormName    
    Should Contain     ${list}    新建 Microsoft Excel 工作表.xlsx 
    
没有传入token查询
    Create Session    api    ${url}
    ${header}    Create Dictionary   Authorization=${access_token}
    ${response}=    Get on Session    api    url=/cms/agency/certificates?&evaluationFormName=新建 Microsoft Excel 工作表.xlsx     expected_status=401
    Should Be Equal As Strings    ERROR_401    ${response.json()}[code]
        
    
*** Keywords ***
列表内容抽取
    [Arguments]    ${response}    ${sampleddata}
    ${list}    set variable  ${response.json()}[data][rows]
    ${length}=    Get Length    ${list}
    FOR     ${index}    IN RANGE    ${length}
            ${json}    Get From List    ${list}    ${index}
            Append To List    ${sampleddata_list}    ${json}[${sampleddata}]
    END
    Log    ${sampleddata_list}    
    [Return]    ${sampleddata_list}
       
           
   
            
    
       