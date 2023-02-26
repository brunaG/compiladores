#include <stdio.h>
#include <stdlib.h>
#include "tabela.h"

#define ERR_UNDECLARED           10
#define ERR_DECLARED             11
#define ERR_VARIABLE             20
#define ERR_ARRAY                21     //identificador deve ser utilizado como array
#define ERR_FUNCTION             22
#define ERR_CHAR_TO_INT          31
#define ERR_CHAR_TO_FLOAT        32
#define ERR_CHAR_TO_BOOL         33
#define ERR_CHAR_VECTOR          34
#define ERR_X_TO_CHAR            35

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