#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define CHARSIZE 1
#define INTSIZE 4
#define FLOATSIZE 8
#define BOOLSIZE 1

typedef enum symbolType
{

} TipoSimbolo;

typedef enum symbolNature
{
    NLITERAL,
    NVARIAVEL,
    NVETOR,
    NFUNCAO
} naturezaSimbolo;

typedef struct conteudo {
    int line;
    naturezaSimbolo nature;
    TipoSimbolo type;
    int tamanho;
    ValorLexico valor_lexico;
    //outros
} Conteudo;