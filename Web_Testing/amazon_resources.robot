*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.amazon.com.br/
${MENU_ELETRONICOS}    //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}    //h1[contains(.,'Eletrônicos e Tecnologia')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=Chrome
    Maximize Browser Window    

Fechar o navegador
    Capture Page Screenshot
    Close Browser
     
Acessar a home page do site Amazon.com.br
    Go To    ${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletronicos"
    Click Element    locator=${MENU_ELETRONICOS}
    
Verificar se aparece a frase "${FRASE}"
#Procura se a page contem texto, timeout,error para validar
    Wait Until Page Contains    text=${FRASE}
#Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}

Verificar se o titulo da página fica "${TITLE}"
    Title Should Be    title=${TITLE}

Verificar se aparece a categoria "${NAME_CATEGORIA}"
    #Verifica se o elemento está visivel quando a page estiver carregada
    Element Should Be Visible    locator=//a[@aria-label='${NAME_CATEGORIA}']

#    CENÁRIO 02   
Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    twotabsearchtextbox    ${PRODUTO}

Clicar no botão de pesquisa    
    Click Element    locator=nav-search-submit-button

Verificar o resultado da pesquisa, listando o produto "${PRODUTO}"   
    #Verifica até que a page contenha o elemento proposto
    Wait Until Page Contains Element    locator=(//span[contains(.,'${PRODUTO}')])[2]

#    CENÁRIO 03   

Adicionar o produto "${PRODUTO}" no carrinho
    Click Image    locator=//img[@alt='${PRODUTO}']
    Wait Until Element Is Visible    locator=add-to-cart-button
    Click Element    locator=add-to-cart-button
    

Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=//span[contains(.,'Adicionado ao carrinho')]


#    CENÁRIO 04
Remover o produto "Console Xbox Series S" do carrinho
    Click Element    locator=//a[contains(.,'Ir para o carrinho')]
    Wait Until Element Is Visible    locator=//h1[contains(.,'Carrinho de compras')]
    Click Element    locator=//input[@value='Excluir']
    
Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//h1[contains(.,'Seu carrinho de compras da Amazon está vazio.')]

# TESTES EM GHERKIN
#    CENÁRIO 01
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o titulo da página fica "Amazon.com.br | Tudo pra você, de A a Z."
    
Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletronicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o titulo da página fica "Eletrônicos e Tecnologia"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

#    CENÁRIO 02
Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o titulo da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa, listando o produto "Console Xbox Series S"

#CENÁRIO 03
Quando adicionar o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa, listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

#CENÁRIO 04

E existe o produto "Console Xbox Series S" no carrinho
    Quando adicionar o produto "Console Xbox Series S" no carrinho
    Então o produto "Console Xbox Series S" deve ser mostrado no carrinho

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio