***Settings***
Library    RequestsLibrary
Library    Collections
Library    md56.py
***Variables***
${url}    http://106.12.185.21  
${auth_admin}    lionaitech-admin
${auth_passwd}    920748160137f80a3b7e195147a6d973
${user_account}    admin
${user_passwd}    0f9b6e7ea974d9ed02e7b1eeb7346422
@{file_msg}    Create List
${access_token}    0



***Keywords***
登录
    [Arguments]    ${user}    ${passwd}
    ${passwd_md5}=    md56    ${passwd}
    ${auth}=  Create List    ${auth_admin}    ${auth_passwd} 
    ${header}    Create Dictionary        Content-Type=application/x-www-form-urlencoded  
    Create Session   api     ${url}      ${header}     auth=${auth}
    ${data}    Create Dictionary    grant_type=client_account    account=${user}    password=${passwd_md5}    scope=all 
    ${response}    Post on Session    api    /auth/oauth/token    data=${data}    expected_status=200
    ${access_token}    Catenate    Bearer    ${response.json()}[data][access_token]
    Set Suite Variable    ${access_token}    ${access_token}    
    
    
上传文件
    [Arguments]    ${file}
      ${filepath}    Get File For Streaming Upload    ${file}
      ${file_data}    Create dictionary    file=${filepath} 
      Create Session     api    ${url}       
      ${response}    Post On Session    api    /basic/file/upload    files=${file_data} 
      Append To List        ${file_msg}    ${response.json()}[msg]
    
创建圈子
    [Arguments]    ${token}
    [documentation]    sdkLink存放上传文件后生成的内容，然后赋值给对应字段，
    ...    Authorization为调用登录接口生成的access_token并加Bearer
    
    # @{file_msg}    create list
    # Set Suite Variable    @{file_msg}    @{file_msg}
    上传文件    ${CURDIR}\\..\\file\\logo.jpg
    上传文件    ${CURDIR}\\..\\file\\titlePage.jpg
    上传文件    ${CURDIR}\\..\\file\\documentLink.pdf
    上传文件    ${CURDIR}\\..\\file\\sdkLink.rar
    
    ${data}=    Create Dictionary    agencyType=SP    companyContact=ff    companyContactMail=2ws@11.com
    ...    companyContactNumber=18512521860    companyDesc=ff    companyUrl=http://www.baidu.com
    ...    content=4    documentLink=${file_msg}[2]    documentRemark=444    introduction=44    logo=${file_msg}[0]
    ...    name=124    productNo=123    productType=news    sdkLink=${file_msg}[3]    status=1    subTitle=44    title=44
    ...    titlePage=${file_msg}[1]    versionNo=444    versionRemark=444
    
    Update Session    api    headers
    ${header}=    Create Dictionary        Authorization=${token}
    ${response}=    Post On Session    api    /cms/agency/product    headers=${header}    json=${data}
    Return From Keyword    ${response.json()}[data]
    
列表内容抽取
    [Arguments]    ${response}    ${sampleddata}
        
    @{sampleddata_list}    Create List    
    ${list}    set variable  ${response.json()}[data][rows]
    ${length}=    Get Length    ${list}
    FOR     ${index}    IN RANGE    ${length}
            ${json}    Get From List    ${list}    ${index}
            Log    ${json}[${sampleddata}]    
            Append To List    ${sampleddata_list}    ${json}[${sampleddata}]
    END
       
    [Return]    ${sampleddata_list}
    
上传文件，返回内容地址
    [Arguments]    ${file}
      ${filepath}    Get File For Streaming Upload    ${file}
      ${file_data}    Create dictionary    file=${filepath} 
      Create Session     api    ${url}       
      ${response}    Post On Session    api    /basic/file/upload    files=${file_data} 
      [return]    ${response.json()}[msg]