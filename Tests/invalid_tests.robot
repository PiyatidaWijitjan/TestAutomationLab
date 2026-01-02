#663380508-7

*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${URL}          http://localhost:7272/Lab4/Registration.html

*** Keywords ***
Open Chrome For Testing
    # สร้าง ChromeOptions object
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    # ตั้งค่า binary_location ใช้ setattr
    Evaluate    setattr($options, "binary_location", r"${CHROME_BROWSER_PATH}")

    # สร้าง Chrome Service พร้อม chromedriver
    ${service}=    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")    sys

    # สร้าง WebDriver ใช้ options + service
    Create Webdriver    Chrome    options=${options}    service=${service}

    # เปิดเว็บ
    Go To    ${URL}



*** Test Cases ***
Open Workshop Registration Page
    [Documentation]    เปิดหน้า Workshop Registration
    Open Chrome For Testing
    Title Should Be    Registration
    Page Should Contain    Workshop Registration
    Capture Page Screenshot    openworkshop_reg_invalid.png
    Close Browser

Empty First Name
    [Documentation]    กรณีไม่กรอก First Name
    Open Chrome For Testing
    Input Text    name=lastname       Sodyod
    Input Text    name=organization   CS KKU
    Input Text    name=email          somyod@kkumail.com
    Input Text    name=phone          091-001-1234
    Click Button   Register
    Capture Page Screenshot    no_firstname.png
    Title Should Be     Registration 
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your first name!!
    Close Browser

Empty Last Name
    [Documentation]    กรณีไม่กรอก Last Name
    Open Chrome For Testing
    Input Text    name=firstname      Somyod
    Input Text    name=organization   CS KKU
    Input Text    name=email          somyod@kkumail.com
    Input Text    name=phone          091-001-1234
    Click Button   Register
    Capture Page Screenshot    no_lastname.png
    Title Should Be    Registration
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your last name!!
    Close Browser

Empty First Name And Last Name
    [Documentation]    กรณีไม่กรอก First Name และ Last Name
    Open Chrome For Testing
    Input Text    name=organization   CS KKU
    Input Text    name=email          somyod@kkumail.com
    Input Text    name=phone          091-001-1234
    Click Button   Register
    Capture Page Screenshot    no_name.png
    Title Should Be    Registration
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your name!!
    Close Browser

Empty Email
    [Documentation]    กรณีไม่กรอก Email
    Open Chrome For Testing
    Input Text    name=firstname      Somyod
    Input Text    name=lastname       Sodsai
    Input Text    name=organization   CS KKU
    Input Text    name=phone          091-001-1234
    Click Button   Register
    Capture Page Screenshot    no_email.png
    Title Should Be    Registration
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your email!!
    Close Browser

Empty Phone Number
    [Documentation]    กรณีไม่กรอก Phone No.
    Open Chrome For Testing
    Input Text    name=firstname      Somyod
    Input Text    name=lastname       Sodsai
    Input Text    name=organization   CS KKU
    Input Text    name=email          somyod@kkumail.com
    Click Button   Register
    Capture Page Screenshot    no_phonenum.png
    Title Should Be    Registration
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your phone number!!
    Close Browser

Invalid Phone Number
    [Documentation]    กรอกเบอร์โทรศัพท์ไม่ถูกต้อง
    Open Chrome For Testing
    Input Text    name=firstname      Somyod
    Input Text    name=lastname       Sodsai
    Input Text    name=organization   CS KKU
    Input Text    name=email          Somyod@kkumail.com
    Input Text    name=phone          1234
    Click Button   Register
    Capture Page Screenshot    invalid_phonenum.png
    Title Should Be    Registration
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)
    Close Browser