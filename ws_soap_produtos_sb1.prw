#include "protheus.ch"
#include "tbiconn.ch"
#include "apwebsrv.ch"
#include "tbiconn.ch"

#define enter chr(13) + chr(10)

WSSTRUCT STRUCTRET
	WSDATA INFO		AS STRING
ENDWSSTRUCT

// DEFINE A ESTRUTA DE COMUNICAÃ‡ÃƒO DO WEBSERVICE
WSSTRUCT STRUCTPROD
	WSDATA DESCRICAO		AS STRING
	WSDATA TIPO				AS STRING
ENDWSSTRUCT

WSSTRUCT STRUCTPRODALL
	WSDATA CODIGO			AS STRING
	WSDATA DESCRICAO		AS STRING
	WSDATA TIPO				AS STRING
ENDWSSTRUCT

// CONSTROI OS PARÃ‚METROS DO WEBSERVICE
WSSERVICE WS_PRODUTOS DESCRIPTION "REALIZA AS OPERAÃ‡Ã•ES DE CRUD NA TABELA DE PRODUTOS - SB1"
   	WSDATA	cCod       		 AS STRING
   	WSDATA	cDescr     		 AS STRING
   	WSDATA	cTipo      		 AS STRING
    WSDATA 	cSend      		 AS STRING
    WSDATA	RETORNOPROD		 AS ARRAY  OF	STRUCTPROD
    WSDATA 	INFORET			 AS ARRAY  OF 	STRUCTRET
    WSDATA  PRODUCTALL		 AS ARRAY  OF   STRUCTPRODALL
        
 // DECLARAÃ‡ÃƒO DOS MÃ‰TODOS CONTIDOS NO WEBSERVICE   
	WSMETHOD 	Inc_mata010 DESCRIPTION "INCLUIR PRODUTO"
    WSMETHOD 	Atu_mata010 DESCRIPTION "ATUALIZAR PRODUTO"
   	WSMETHOD 	Exc_mata010 DESCRIPTION "EXCLUIR PRODUTO"
    WSMETHOD 	Get_mata010 DESCRIPTION "CONSULTAR PRODUTO"
    WSMETHOD 	Get_all DESCRIPTION "CONSULTAR TODOS OS PRODUTO"
    
ENDWSSERVICE


// MÃ‰TODO DE INCLUSÃƒO - PRODUTOS SB1
WSMETHOD Inc_mata010 WSRECEIVE cCod, cDescr, cTipo WSSEND INFORET WSSERVICE WS_PRODUTOS 

private lMsErroAuto 	:= .f.
private lAutoErrNoFile 	:= .t.

// ARRAY - CABEÃ‡ALHO DE REQUISIÃ‡ÃƒO
aCabec  := {    {"B1_COD"       ,::cCod						,nil},;                     
			    {"B1_DESC"      ,::cDescr                   ,nil},;                     
			    {"B1_TIPO"    	,::cTipo   					,nil},;                   
			    {"B1_UM"      	,"UN"            			,nil},;                   
			    {"B1_LOCPAD"  	,"01"            			,nil},;                   
			    {"B1_LOCALIZ" 	,"N"             			,nil} }

/* FUNÃ‡ÃƒO QUE EXEXUTA A ROTINA MATA010 PASSANDO COM PARÃ‚METRO O ARRAY DE REQUISIÃ‡ÃƒO E O TIPO DE OPERAÃ‡ÃƒO A 
SER EXECUTADA (3 - CREATE)*/
msExecAuto({ |x, y| mata010(x, y)}, aCabec, 3) 

/*if lMsErroAuto
	aLog := GetAutoGRLog()
	::cSend := "ERRO" + enter
	for i := 1 to len(aLog)
		::cSend += aLog[i] + enter
	next i
	
	aAdd(::INFORET,WsClassNew("STRUCTRET"))
	::INFORET[Len(::INFORET)]:INFO	:= ::cSend

else */
	//::cSend := (enter + "OperaÃ§Ã£o realizada com sucesso " + enter + "Inclusao realizada com sucesso : " + SB1->B1_COD)
	
	aAdd(::INFORET,WsClassNew("STRUCTRET"))
		::INFORET[Len(::INFORET)]:INFO	:= "OK"

//Imprime no console do server o retorno do Json
//	conout(enter + "OperaÃ§Ã£o realizada com sucesso " + enter + "Inclusao realizada com sucesso : " + SB1->B1_COD)
//endIf

return .t.

// MÃ‰TODO DE ALTERAÃ‡ÃƒO PRODUTOS SB1
WSMETHOD Atu_mata010 WSRECEIVE cCod, cDescr, cTipo WSSEND INFORET WSSERVICE WS_PRODUTOS 

private lMsErroAuto 	:= .f.
private lAutoErrNoFile 	:= .t.

// ARRAY - CABEÃ‡ALHO DE REQUISIÃ‡ÃƒO
aCabec  := {    {"B1_COD"       ,::cCod						,nil},;                     
			    {"B1_DESC"      ,::cDescr                   ,nil},;                     
			    {"B1_TIPO"    	,::cTipo   					,nil},;                   
			    {"B1_UM"      	,"UN"            			,nil},;                   
			    {"B1_LOCPAD"  	,"01"            			,nil},;                   
			    {"B1_LOCALIZ" 	,"N"             			,nil} }

/* FUNÃ‡ÃƒO QUE EXEXUTA A ROTINA MATA010 PASSANDO COM PARÃ‚METRO O ARRAY DE REQUISIÃ‡ÃƒO E O TIPO DE OPERAÃ‡ÃƒO A SER
 EXECUTADA (4 - UPDATE)*/
			
msExecAuto({ |x, y| mata010(x, y)}, aCabec, 4) 

/*if lMsErroAuto
	aLog := GetAutoGRLog()
	::cSend := "ERRO" + enter
	for i := 1 to len(aLog)
		::cSend += aLog[i] + enter
	next i

aAdd(::INFORET,WsClassNew("STRUCTRET"))
	::INFORET[Len(::INFORET)]:INFO	:= ::"OK"

else
*/
	aAdd(::INFORET,WsClassNew("STRUCTRET"))
		::INFORET[Len(::INFORET)]:INFO	:= "OK"
		
	
//	::cSend := (enter + "OperaÃ§Ã£o realizada com sucesso " + enter + "Alterado com sucesso : " + SB1->B1_COD)
//	conout(enter + "OperaÃ§Ã£o realizada com sucesso " + enter + "Alterado com sucesso : " + SB1->B1_COD)
//endIf

return .t.


// MÃ‰TODO DE EXCLUSAO - PRODUTOS SB1
WSMETHOD Exc_mata010 WSRECEIVE cCod, cDescr, cTipo WSSEND INFORET WSSERVICE WS_PRODUTOS 

private lMsErroAuto 	:= .f.
private lAutoErrNoFile 	:= .t.


// ARRAY - CABEÃ‡ALHO DE REQUISIÃ‡ÃƒO
aCabec  := {    {"B1_COD"       ,::cCod						,nil},;                     
			    {"B1_DESC"      ,::cDescr                   ,nil},;                     
			    {"B1_TIPO"    	,::cTipo   					,nil},;                   
			    {"B1_UM"      	,"UN"            			,nil},;                   
			    {"B1_LOCPAD"  	,"01"            			,nil},;                   
			    {"B1_LOCALIZ" 	,"N"             			,nil} }

/* FUNÃ‡ÃƒO QUE EXEXUTA A ROTINA MATA010 PASSANDO COM PARÃ‚METRO O ARRAY DE REQUISIÃ‡ÃƒO E O TIPO DE OPERAÃ‡ÃƒO A SER
 EXECUTADA (5 - DELETE)*/				
msExecAuto({ |x, y| mata010(x, y)}, aCabec, 5) 
/*
if lMsErroAuto
	aLog := GetAutoGRLog()
	::cSend := "ERRO" + enter
	for i := 1 to len(aLog)
		::cSend += aLog[i] + enter
	next i
	
	aAdd(::INFORET,WsClassNew("STRUCTRET"))
	::INFORET[Len(::INFORET)]:INFO	:= ::cSend
	
else*/
	//::cSend := (enter + "OperaÃ§Ã£o realizada com sucesso " + enter + "Inclusao realizada com sucesso : " + SB1->B1_COD)
	aAdd(::INFORET,WsClassNew("STRUCTRET"))
		::INFORET[Len(::INFORET)]:INFO	:= "OK"
	//conout(enter + "OperaÃ§Ã£o realizada com sucesso " + enter + "Inclusao realizada com sucesso : " + SB1->B1_COD)
//endIf

return .t.


// MÃ‰TODO DE GET (CONSULTA) - PRODUTOS SB1 
WSMETHOD Get_mata010 WSRECEIVE cCod WSSEND RETORNOPROD WSSERVICE WS_PRODUTOS 

private lMsErroAuto 	:= .f.
private lAutoErrNoFile 	:= .t.

// ACESSO A TABELA SB1 - PRODUTOS
dbSelectArea("SB1")

// CONTRUÃ‡ÃƒO DE PONTEIROS:  
SB1->(dbSetOrder(1)) // DEFINE INDEX DE CONSULTA (1)
SB1->(dbGoTop()) // DEFINE POSIÃ‡ÃƒO DO TOPO DA TABELA PARA A CONSULTA 

if SB1->(dbSeek(xFilial("SB1") + ::cCod))

	aAdd(::RETORNOPROD,WsClassNew("STRUCTPROD"))

		::RETORNOPROD[Len(::RETORNOPROD)]:DESCRICAO	:= SB1->B1_DESC
		::RETORNOPROD[Len(::RETORNOPROD)]:TIPO	:= SB1->B1_TIPO

else
		SetSoapFault ('ERROR','Produto nÃ£o localizado')

endIf

return .t.


WSMETHOD Get_all  WSSEND PRODUCTALL WSSERVICE WS_PRODUTOS 

private lMsErroAuto 	:= .f.
private lAutoErrNoFile 	:= .t.

dbSelectArea("SB1")

SB1->(dbSetOrder(1))
SB1->(dbGoTop())

While SB1->(!EOF())
	::cSend := (enter + "Operacao realizada com sucesso " + enter +; 
                        " Codigo : " + SB1->B1_COD +;
						" Produto : " + SB1->B1_DESCR +;
						" Tipo :" + SB1->B1_TIPO + enter)
	SB1->(dbSkip())
EndDo

return .t.
