// Bruna dos Santos Gonzaga - 00252743
// Gabriel Tamusiunas Schumacker - 00285648

#include "tabela.h"

/*
    2.1: TABELA
        - Chave é o lexema: pode ser obtido pelo valor_lexico
        - tabela hash: ver especificação

    2.2: VERIF DECLARAÇÕES
        - pilha de tabelas: locais de push e pop
        - como verificar se ja declarou

    2.3: USO CORRETO
        - encontrar na tabela
            - descobre natureza
            - match com situações na gramática

    2.4: VERIFICACAO DE TIPO
        - Campo novo na estrutura da arvore de tipo (4 valores possiveis)
 */

//verifica no escopo - VETOR, VARIÁVEL, FUNÇÃO
    // ERR_DECLARED - errorDeclared
    // ERR_UNDECLARED - errorUndleclared

// verifica uso correto

//

void errorUndleclared(int line, char *identificador);
void errorDeclared(int line, char *identificador, int DeclarationLine);
void errorVariable(int line, char *identificador, int DeclarationLine);
void errorArray(int line, char *identificador, int DeclarationLine);
void errorFunction(int line, char *identificador, int DeclarationLine);
void errorCharToInt(int line, char *identificador);
void errorCharToFloat(int line, char *identificador);
void errorCharToBool(int line, char *identificador);
void errorCharToVector(int line, char *identificador);
void errorXtoChar(int line, char *identificador);
