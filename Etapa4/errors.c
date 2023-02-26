#include "errors.h"
#include "tabela.h"

void errorUndleclared(int line, char *identificador){
    printf("linha %i - ERRO: ERR_UNDECLARED. variável %s não declarada.\n", line, identificador);
    exit(ERR_UNDECLARED);
}

void errorDeclared(int line, char *identificador, int declarationLine){
    printf("linha %i - ERRO: ERR_DECLARED.   variável %s já declarada na linha %i.\n", line, identificador, declarationLine);
    exit(ERR_DECLARED);
}

void errorVariable(int line, char *identificador, int declarationLine){
    printf("linha %i - ERRO: ERR_VARIABLE. forma invalida de uso do Identificador VARIAVEL %s declarado na linha %i .\n", line, identificador, declarationLine);
    exit(ERR_VARIABLE);
}

void errorArray(int line, char *identificador, int declarationLine){
    printf("linha %i - ERRO: ERR_ARRAY. forma invalida de uso do Identificador ARRAY  %s declarado na linha %i .\n", line, identificador, declarationLine);
    exit(ERR_ARRAY);
}

void errorFunction(int line, char *identificador, int declarationLine){
    printf("linha %i - ERRO: ERR_FUNCTION. forma invalida de uso do Identificador FUNCAO %s declarado na linha %i .\n", line, identificador, declarationLine);
    exit(ERR_FUNCTION);
}

void errorCharToInt(int line, char *identificador){
    printf("linha %i - ERRO: ERR_CHAR_TO_INT. conversao do identificador %s to tipo CHAR para o tipo INT nao e valida .\n", line, identificador);
    exit(ERR_CHAR_TO_INT);
}

void errorCharToFloat(int line, char *identificador){
    printf("linha %i - ERRO: ERR_CHAR_TO_FLOAT. conversao do identificador %s to tipo CHAR para o tipo FLOAT nao e valida .\n", line, identificador);
    exit(ERR_CHAR_TO_FLOAT);
}

void errorCharToBool(int line, char *identificador){
    printf("linha %i - ERRO: ERR_CHAR_TO_BOOL. conversao do identificador %s to tipo CHAR para o tipo BOOL nao e valida .\n", line, identificador);
    exit(ERR_CHAR_TO_BOOL);
}

void errorCharToVector(int line, char *identificador){
    printf("linha %i - ERRO: ERR_CHAR_VECTOR. conversao do identificador %s to tipo CHAR para o tipo ARRANJO nao e valida .\n", line, identificador);
    exit(ERR_CHAR_VECTOR);
}

void errorXtoChar(int line, char *identificador){
    printf("linha %i - ERRO: ERR_X_TO_CHAR. conversao do identificador %s para o tipo CHAR nao e valida .\n", line, identificador);
    exit(ERR_X_TO_CHAR);
}
