*** Settings ***
Documentation     Automated tests for Todo List website
Library           SeleniumLibrary
Library           Collections

Test Setup        Open Browser    ${URL}    chrome
Test Teardown     Close Browser

*** Variables ***
${URL}            https://abhigyank.github.io/To-Do-List/
${Task1}          Buy groceries
${Task2}          Finish homework
${Task3}          Call mom
${Task4}          works out

*** Test Cases ***
Test Adding New Tasks
    [Tags]    @AddingTasks
    [Setup]   Open Todo List Page
    Add Task  ${Task1}

Test Marking Tasks as Completed
    [Tags]    @CompletingTasks
    [Setup]   Open Todo List Page
    Add Task  ${Task2}
    Mark Task as Completed  ${Task2}


Test Deleting Tasks
    [Tags]    @DeletingTasks
    [Setup]   Open Todo List Page
    Add Task  ${Task3}
    Delete Task  ${Task3}


Test Deleting completed task
    [Tags]     @DeletingCompleated 
    [Setup]    Open Todo List Page
    Add Task    ${Task4}
    Mark Task as Completed     ${Task4}
    Delete Completed Task      ${Task4}

    
*** Keywords ***
Open Todo List Page
    Open Browser    ${URL}    Chrome 
    Wait Until Page Contains Element    id=new-task

Add Task
    [Arguments]    ${task}
    Input Text    id=new-task    ${task}
    Press Keys    id=new-task    //3
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'mdl-button--colored') and .//i[contains(text(), 'add')]]    timeout=10s  
    Click Element    xpath=//button[contains(@class, 'mdl-button--colored') and .//i[contains(text(), 'add')]]

Mark Task as Completed
    [Arguments]    ${task}
    Wait Until Element Is Visible    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#todo"]    timeout=10s
    Click Element    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#todo"]
    Wait Until Element Is Visible    css=.mdl-checkbox__focus-helper    timeout=10s
    Execute JavaScript    document.querySelector('.mdl-checkbox__focus-helper').click();
    Wait Until Element Is Visible    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#completed"]    timeout=10s
    Click Element    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#completed"]


Delete Task
    [Arguments]    ${task}
    Wait Until Element Is Visible    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#todo"]    timeout=10s
    Click Element    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#todo"]
    Wait Until Element Is Visible    xpath=//button[@class='mdl-button mdl-js-button mdl-js-ripple-effect delete' and @id='1' and contains(text(), 'Delete')]    timeout=10s
    Click Element    xpath=//button[@class='mdl-button mdl-js-button mdl-js-ripple-effect delete' and @id='1' and contains(text(), 'Delete')]
    Wait Until Element Is Visible    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#completed"]    timeout=10s
    Click Element    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#completed"]


Delete Completed Task      
    [Arguments]    ${task}
    Wait Until Element Is Visible    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#completed"]    timeout=10s
    Click Element    css=.mdl-tabs__tab-bar .mdl-tabs__tab[href="#completed"]
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'mdl-button') and contains(@class, 'delete') and contains(text(), 'Delete')]    timeout=10s
    Click Element    xpath=//button[contains(@class, 'mdl-button') and contains(@class, 'delete') and contains(text(), 'Delete')]


