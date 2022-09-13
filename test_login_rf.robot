*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description

*** Variables ***
${LOGIN URL}  https://scouts.futbolkolektyw.pl/en/
${BROWSER}  Chrome
${SIGNINBUTTON}  xpath=//*[text()= 'Sign in']
${EMAILINPUT}  xpath =//*[@id='login']
${PASSWORDINPUT}  xpath=//*[@id='password']
${PAGELOGO}  xpath=//*[contains(@class, 'MuiCardMedia')]
${LANGUAGEBUTTON}   xpath=//*[@role='button']
${SUBMITBUTTON}     xpath=//button[@type='submit']/span[1]
${PLAYERSCOUNTELEMENT}  xpath =//*[contains(@class, 'MuiGrid-grid-md')]
${PLAYERNAME}       xpath=//input[@name='name']
${PLAYERSURNAME}    xpath=//input[@name='surname']
${PLAYERAGE}        xpath=//input[@name='age']
${PLAYERLEG}        xpath=//*[@id='mui-component-select-leg']
${PLAYERRIGHTLEG}        xpath=//li[@data-value='right']
${PLAYERMAINPOSITION}       xpath=//input[@name='mainPosition']
${ADDPLAYER}   xpath=//*[2][name()='a']
${INCORRECTPASSWORDMESSAGE}  xpath=//*[contains(@class, "MuiTypography-colorError")]
${CLEARALL}   xpath=//button[contains(@class, 'MuiButton-containedSecondary')]

*** Test Cases ***
Valid Login
    Open login page
    Assert login page
    Type in login
    Type in password
    Click on the Sign in button
    Assert dashboard
    [Teardown]  Close Browser

Incorrect Password
    Open login page
    Assert login page
    Type in login
    Type incorrect password
    Click on the Sign in button
    Assert incorrect password message
    [Teardown]      Close Browser

Add New Player
    Open login page
    Assert login page
    Type in login
    Type in password
    Click on the Sign in button
    Assert Dashboard
    Click on Add Player
    Assert Add Player
    Type in name
    Type in surname
    Select age
    Select right leg
    Type in main position
    Click on the clear button
    [Teardown]      Close Browser

Switch Languages
    Open login page
    Assert login page
    Click on the language button
    [Teardown]      Close Browser

Displaing Information
    Open login page
    Assert login page
    Type in login
    Type in password
    Click on the Sign in button
    Assert Dashboard
    Click on the players count element
    [Teardown]      Close Browser

*** Keywords ***
Open login page
    Open Browser   ${LOGIN URL}  ${BROWSER}
    Title Should Be   Scouts panel - sign in
Assert login page
    wait until element is visible   ${PAGELOGO}
    title Should be     Scouts panel - sign in
    capture page screenshot     alert.png
Type in login
    Input Text       ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text    ${PASSWORDINPUT}    Test-1234
Type incorrect password
    Input Text   ${PASSWORDINPUT}    Test - 123
Assert incorrect password message
    wait until element is visible   ${INCORRECTPASSWORDMESSAGE}
    element text should be   ${INCORRECTPASSWORDMESSAGE}  Identifier or password invalid.
    Capture Page Screenshot  alert2.png
Assert Add Player
    wait until element is visible    ${PLAYERNAME}
    Capture Page Screenshot  alert3.png
Click on the Sign in button
    Click Element   ${SIGNINBUTTON}
Click on the Clear button
    Click Element    ${CLEARALL}
Click on the language button
    Click Element   ${LANGUAGEBUTTON}
Click on the players count element
    Click Element   ${PLAYERSCOUNTELEMENT}
Click on Add Player
    Click Element       ${ADDPLAYER}
Type in name
    Input Text      ${PLAYERNAME}       Zinedin
Type in surname
    Input Text      ${PLAYERSURNAME}       Zidan
Select age
    Input Text      ${PLAYERAGE}        23/06/1972
Select right leg
    Click Element       ${PLAYERLEG}
    Click Element       ${PLAYERRIGHTLEG}
Type in main position
    Input Text      ${PLAYERMAINPOSITION}       Midfielder
Click on the Submit button
    Click Element       ${SUBMITBUTTON}
Assert dashboard
    wait until element is visible  ${PAGELOGO}
    title should be  Scouts panel
    Capture Page Screenshot  alert4.png

