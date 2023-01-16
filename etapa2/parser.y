// Bruna dos Santos Gonzaga - 00252743
// Gabriel Tamusiunas Schumacker - 00285648

%{
#include "stdio.h"
#include "stdlib.h"

int yylex(void);
void yyerror (char const *s);

int get_line_number();
%}

%define parse.lac full
%define parse.error verbose


%token TK_PR_INT
%token TK_PR_FLOAT
%token TK_PR_BOOL
%token TK_PR_CHAR
%token TK_PR_IF
%token TK_PR_THEN
%token TK_PR_ELSE
%token TK_PR_WHILE
%token TK_PR_INPUT
%token TK_PR_OUTPUT
%token TK_PR_RETURN
%token TK_PR_FOR
%token TK_OC_LE
%token TK_OC_GE
%token TK_OC_EQ
%token TK_OC_NE
%token TK_OC_AND
%token TK_OC_OR
%token TK_LIT_INT
%token TK_LIT_FLOAT
%token TK_LIT_FALSE
%token TK_LIT_TRUE
%token TK_LIT_CHAR
%token TK_IDENTIFICADOR
%token TK_ERRO

%%

program: globalVar program |
         function program
         | ;

types: TK_PR_INT | TK_PR_FLOAT | TK_PR_BOOL | TK_PR_CHAR;
literalTypes: TK_LIT_INT | TK_LIT_FLOAT | TK_LIT_FALSE | TK_LIT_TRUE | TK_LIT_CHAR;

identifier: TK_IDENTIFICADOR;

globalVar: types identifier multoArray varList ';' ;
multoArray: '[' TK_LIT_INT multoArrayList ']' | ; 
multoArrayList: multoArrayList '^' TK_LIT_INT | ;
varList: varList ',' identifier multoArray | ;

function: functionHeader commandBlock;
functionHeader: identifier '(' parameter parameterList ')';
parameter: types identifier | ;
parameterList: ',' types identifier parameterList | ;

command
	: variableDeclaration ';'
	| attribution ';'
	| functionCall ';'
	| returnCommand ';'
	| fluxControl ';'
	| repetition ';'
	;

commandList: command commandList | ;
commandBlock: '{' commandList '}';

localVariable:
      identifier
    | identifier TK_OC_LE literalTypes;

localVariableList: ','  localVariable localVariableList | ;
variableDeclaration: types localVariable localVariableList;

attribution:
	  identifier '=' expression
	| identifier '['expression']' '=' expression;

functionCall
    : identifier '('expression expressionList')'
    | identifier '('')'

returnCommand: TK_PR_RETURN expression';'

expressionList: ',' expression expressionList | ;

expression: unary operando | mathExpression;
mathExpression: expression operador operando | '(' expression operador operando ')';
operador:  '-' | '/' | '*' | '%' | '<' | '>' | TK_OC_LE | TK_OC_GE | TK_OC_EQ | TK_OC_NE |
 TK_OC_AND | TK_OC_OR | '+';  //problema com + e - seguidos de numeros
unary: '-' | '!' | ;
operando: identifier multoArray | literalTypes | functionCall ;

fluxControl: TK_PR_IF '(' expression ')' TK_PR_THEN commandBlock else ;
else: TK_PR_ELSE commandBlock | ;

repetition: TK_PR_WHILE '(' expression ')' commandBlock;
%%

void yyerror (char const *s){
   printf ("line %d: %s\n", get_line_number(), s);
}
