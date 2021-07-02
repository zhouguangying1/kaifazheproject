*** Settings ***
Library    Collections
Library    RequestsLibrary

Suite Setup    登录    ${user_account}    ${user_passwd}
Resource    ../resources/public.robot
*** Variables ***

*** Test Cases ***
    
生态圈-创建成功
    [documentation]    sdkLink存放上传文件后生成的内容，然后赋值给对应字段，
    ...    Authorization为调用登录接口生成的access_token并加Bearer
   
    
    上传文件    ${CURDIR}\\..\\file\\logo.jpg
    上传文件    ${CURDIR}\\..\\file\\titlePage.jpg
    上传文件    ${CURDIR}\\..\\file\\documentLink.pdf
    上传文件    ${CURDIR}\\..\\file\\sdkLink.rar
    
    ${data}=    Create Dictionary    agencyType=SP    companyContact=ff    companyContactMail=2ws@11.com
    ...    companyContactNumber=18512521860    companyDesc=ff    companyUrl=http://www.baidu.com
    ...    content=4    documentLink=${file_msg}[2]    documentRemark=444    introduction=44    logo=${file_msg}[0]
    ...    name=124    productNo=123    productType=news    sdkLink=${file_msg}[3]    status=1    subTitle=44    title=44
    ...    titlePage=${file_msg}[1]    versionNo=444    versionRemark=444
    Update Session   api     
    ${header}=    Create Dictionary        Authorization=${access_token}
    ${response}=    Post On Session    api    /cms/agency/product    headers=${header}    json=${data}
    Status Should Be    200
    Should Not Be Empty    ${response.json()}[data]
     
    

生态圈-Authorization为空时，接口提示
    [documentation]    sdkLink存放上传文件后生成的内容，然后赋值给对应字段，
    
    上传文件    ${CURDIR}\\..\\file\\logo.jpg
    上传文件    ${CURDIR}\\..\\file\\titlePage.jpg
    上传文件    ${CURDIR}\\..\\file\\documentLink.pdf
    上传文件    ${CURDIR}\\..\\file\\sdkLink.rar
    
    ${data}=    Create Dictionary    agencyType=SP    companyContact=ff    companyContactMail=2ws@11.com
    ...    companyContactNumber=18512521860    companyDesc=ff    companyUrl=http://www.baidu.com
    ...    content=4    documentLink=${file_msg}[2]    documentRemark=444    introduction=44    logo=${file_msg}[0]
    ...    name=124    productNo=123    productType=news    sdkLink=${file_msg}[3]    status=1    subTitle=44    title=44
    ...    titlePage=${file_msg}[1]    versionNo=444    versionRemark=444
    Update Session   api
    ${response}=    Post On Session    api    /cms/agency/product        json=${data}    expected_status=401
    
    Should Be Equal    ${response.json()}[code]     ERROR_401  
    

     
      
    

    