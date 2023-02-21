#include "Protheus.ch"
#include "Totvs.ch"

User Function zGatilho()
Local cDesc

//Variavel recebe posicione na tabela SB1 cm indice 1, filial da SB1 + D1_COD e traz a SB1_DESC
cDesc := Posicione("SB1",1, xFilial("SB1")+D1_COD,"B1_DESC" )

return cDesc
