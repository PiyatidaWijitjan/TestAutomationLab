#663380508-7

*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${URL}    http://localhost:7272/Lab4/Registration.html

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
    Capture Page Screenshot    openworkshop_reg_valid.png
    Close Browser


Register Success Lab4
    [Documentation]    ลงทะเบียนสำเร็จ มี Organization
    Open Chrome For Testing
    Input Text    name=firstname     Somyod
    Input Text    name=lastname      Sodsai
    Input Text    name=organization  CS KKU
    Input Text    name=email         somyod@kkumail.com
    Input Text    name=phone         091-001-1234
    Click Button   Register
    Capture Page Screenshot    have_org.png
    Title Should Be    Success
    Page Should Contain    Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.
    Close Browser

Register Success No Organization 
    [Documentation]    ลงทะเบียนสำเร็จ ไม่กรอก Organization
    Open Chrome For Testing
    Input Text    name=firstname     Somyod
    Input Text    name=lastname      Sodsai
    Input Text    name=email         somyod@kkumail.com
    Input Text    name=phone         091-001-1234
    Click Button   Register
    Capture Page Screenshot    no_org.png
    Title Should Be    Success
    Page Should Contain    Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.
    Close Browser
