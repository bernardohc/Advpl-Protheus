#include "protheus.ch"
#include "restful.ch"
#include "tbiconn.ch"

#define enter chr(13) + chr(10)

function u_Rest010()

WSRESTFUL PRODUTOS_SB1 DESCRIPTION "Executa rotina automática MATA010 | Inclusao de produtos"

WSDATA cRet		AS STRING
WSDATA cDesc 	AS STRING
WSDATA cTipo	AS STRING
WSDATA cCod	 	AS STRING


WSMETHOD GET        DESCRIPTION "GET PRODUTOS"      				WSSYNTAX ""
WSMETHOD POST       DESCRIPTION "POST / INCLUSÃO PRODUTOS "       	WSSYNTAX ""
WSMETHOD PUT        DESCRIPTION "PUT/ALTERACAO PRODUTOS"        	WSSYNTAX ""
WSMETHOD DELETE     DESCRIPTION "DELETE PRODUTOS"    				WSSYNTAX ""

END WSRESTFUL

//--------------------------------------------------------------------------------------//

// MÉTODO DE CONSULTA PRODUTO - SB1 
WSMETHOD GET WSRECEIVE cCod WSSERVICE PRODUTOS_SB1

local cJson         AS CHARACTER
local oParseJSON    AS OBJECT
local cCod			AS CHARACTER
local lRet			AS LOGICAL

cJson       := ::getContent()
oParseJSON	:= nil
lRet		:= .f.

::setContentType("application/json")

FWJsonDeserialize(cJson, @oParseJSON)

	
dbSelectArea("SB1")

SB1->(dbSetOrder(1))
SB1->(dbGoTop())

if SB1->(dbSeek(xFilial("SB1") + ::cCod))
    ::setResponse('{') 
    ::setResponse( '"Descricao ": "' + SB1->B1_DESC + '",')
    ::setResponse( '"Tipo ": "' + SB1->B1_TIPO + '"')
    ::setResponse('}')

else
    //::setResponse('{') 
    //::setResponse( '"Erro" : "Produto nao encontrado"')
    //::setResponse('}')

	setRestFault(002,"Produto nao encontrado")	
endIf

return .T.

// MÉTODO DE POST (INCLUSÃO)

WSMETHOD POST WSSERVICE PRODUTOS_SB1

local aCabec	    := {}
local aLog		    := {}
local i
local oParseJSON    := nil
local cJson         := ::getContent()

//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

private lMsErroAuto 	:= .f.
private lAutoErrNoFile 	:= .t.

::setContentType("application/json")

FWJsonDeserialize(cJson, @oParseJSON)

aCabec  := {    {"B1_COD"       ,oParseJSON:Cod						,nil},;                     
			    {"B1_DESC"      ,oParseJSON:Descr                   ,nil},;                     
			    {"B1_TIPO"    	,oParseJSON:Tipo   					,nil},;                   
			    {"B1_UM"      	,"UN"            					,nil},;                   
			    {"B1_LOCPAD"  	,"01"            					,nil},;                   
			    {"B1_LOCALIZ" 	,"N"             					,nil} }

			
msExecAuto({ |x, y| mata010(x, y)}, aCabec, 3) 

if !lMsErroAuto
	conOut(enter + oemToAnsi("Incluido com sucesso! ") + SB1->B1_COD + enter)
	
	::cRet := "Incluido com sucesso " + SB1->B1_COD	
else
	conOut(OemToAnsi("Erro na inclusao"))
	
	aLog := getAutoGRLog()
	
	::cRet := "ERRO" + enter
	
	for i := 1 to len(aLog)
		::cRet += aLog[i] + enter
	next i
		
	conout(enter + ::cRet + enter)
endIf

::setResponse('{') 
::setResponse( '"Retorno apos execucao": "' + ::cRet + '"')
::setResponse('}')

//RESET ENVIRONMENT

return .t.

//-------------------------------------------------------------------------------------//

//MÉTODO PUT (ALTERAR) PRODUTOS -SB1
WSMETHOD PUT WSSERVICE PRODUTOS_SB1

local cJson         := ::getContent()
local oParseJSON    := nil
local i

private lMsErroAuto 	:= .f.
private lAutoErrNoFile 	:= .t.

::setContentType("application/json")

FWJsonDeserialize(cJson, @oParseJSON)

aCabec  := {    {"B1_COD"       ,oParseJSON:Cod						,nil},;                     
			    {"B1_DESC"      ,oParseJSON:Descr                   ,nil},;                     
			    {"B1_TIPO"    	,oParseJSON:Tipo   					,nil},;                   
			    {"B1_UM"      	,"UN"            					,nil},;                   
			    {"B1_LOCPAD"  	,"01"            					,nil},;                   
			    {"B1_LOCALIZ" 	,"N"             					,nil} }

			
msExecAuto({ |x, y| mata010(x, y)}, aCabec, 4) 

if !lMsErroAuto
	conOut(enter + oemToAnsi("Alterado com sucesso! ") + SB1->B1_COD + enter)
	
	::cRet := "Alterado com sucesso " + SB1->B1_COD	
else
	conOut(OemToAnsi("Erro na Alteracao"))
	
	aLog := getAutoGRLog()
	
	::cRet := "ERRO" + enter
	
	for i := 1 to len(aLog)
		::cRet += aLog[i] + enter
	next i
		
	conout(enter + ::cRet + enter)
endIf

::setResponse('{') 
::setResponse( '"Retorno apos execucao": "' + ::cRet + '"')
::setResponse('}')

//RESET ENVIRONMENT

return .t.

//------------------------------------------------------------------------------------//

// MÉTODO DELETE PRODUTO - SB1 

WSMETHOD DELETE WSSERVICE PRODUTOS_SB1

local cJson         := ::getContent()
local oParseJSON    := nil
local i

private lMsErroAuto 	:= .f.
private lAutoErrNoFile 	:= .t.

::setContentType("application/json")

FWJsonDeserialize(cJson, @oParseJSON)

aCabec  := {    {"B1_COD"       ,oParseJSON:Cod						,nil},;                     
			    {"B1_DESC"      ,oParseJSON:Descr                   ,nil},;                     
			    {"B1_TIPO"    	,oParseJSON:Tipo   					,nil},;                   
			    {"B1_UM"      	,"UN"            					,nil},;                   
			    {"B1_LOCPAD"  	,"01"            					,nil},;                   
			    {"B1_LOCALIZ" 	,"N"             					,nil} }
			
msExecAuto({ |x, y| mata010(x, y)}, aCabec, 5) 

if !lMsErroAuto
	conOut(enter + oemToAnsi("Excluido com sucesso! ") + SB1->B1_COD + enter)
	
	::cRet := "Excluido com sucesso " + SB1->B1_COD	
else
	conOut(OemToAnsi("Erro na exclus"+chr(65533)+"o"))
	
	aLog := getAutoGRLog()
	
	::cRet := "ERRO" + enter
	
	for i := 1 to len(aLog)
		::cRet += aLog[i] + enter
	next i
		
	conout(enter + ::cRet + enter)
endIf

::setResponse('{') 
::setResponse( '"Retorno apos execucao": "' + ::cRet + '"')
::setResponse('}')

//RESET ENVIRONMENT

return .t.
