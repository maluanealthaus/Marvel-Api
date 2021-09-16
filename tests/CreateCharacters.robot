*** Settings ***
Documentation       Suite de testes do cadastro de personagens da Marvel

Resource            ${EXECDIR}/resources/base.robot

Library             ${EXECDIR}/resources/factories/thanos.py

Suite Setup         Set Client Key          maluanealthaus@yahoo.com

***Variables***
${API_URI}         http://marvel.qaninja.academy

*** Test Cases ***
Deve cadastrar um personagem

    ${personagem}           Factory Thanos
    ${response}             POST New Character              ${personagem}    

    Status Should Be        200                             ${response}

Não deve cadastrar personagem com nome duplicado

    [Tags]                  dup

    ${personagem}           Factory Thanos

    POST New Character      ${personagem}

    ${response}             POST New Character              ${personagem}

    Status Should Be        409                             ${response}
    Should Be Equal         ${response.json()}[error]       Character already exists :(