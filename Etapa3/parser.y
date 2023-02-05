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

%union {
   node_t *no;
   valor_t *valor_lexico;
}

%type<no> program
%type<no> types
%type<no> literalTypes
%type<no> identifier
%type<no> globalVar
%type<no> multoArray
%type<no> multoArrayList
%type<no> varList
%type<no> functionHeader
%type<no> parameter
%type<no> parameterList
%type<no> command
%type<no> commandList
%type<no> commandBlock
%type<no> localVariable
%type<no> localVariableList
%type<no> variableDeclaration
%type<no> attribution
%type<no> functionCall
%type<no> returnCommand
%type<no> expressionList
%type<no> operador
%type<no> unary
%type<no> operando
%type<no> fluxControl
%type<no> else
%type<no> repetition

%token<valor_lexico> TK_PR_INT
%token<valor_lexico> TK_PR_FLOAT
%token<valor_lexico> TK_PR_BOOL
%token<valor_lexico> TK_PR_CHAR
%token<valor_lexico> TK_PR_IF
%token<valor_lexico> TK_PR_THEN
%token<valor_lexico> TK_PR_ELSE
%token<valor_lexico> TK_PR_WHILE
%token<valor_lexico> TK_PR_INPUT
%token<valor_lexico> TK_PR_OUTPUT
%token<valor_lexico> TK_PR_RETURN
%token<valor_lexico> TK_PR_FOR
%token<valor_lexico> TK_OC_LE
%token<valor_lexico> TK_OC_GE
%token<valor_lexico> TK_OC_EQ
%token<valor_lexico> TK_OC_NE
%token<valor_lexico> TK_OC_AND
%token<valor_lexico> TK_OC_OR
%token<valor_lexico> TK_LIT_INT
%token<valor_lexico> TK_LIT_FLOAT
%token<valor_lexico> TK_LIT_FALSE
%token<valor_lexico> TK_LIT_TRUE
%token<valor_lexico> TK_LIT_CHAR
%token<valor_lexico> TK_IDENTIFICADOR
%token<valor_lexico> TK_ERRO


%left '<' '>' TK_OC_LE TK_OC_GE TK_OC_EQ TK_OC_NE
%left TK_OC_OR
%left TK_OC_AND
%left '+' '-'
%left '*' '/' '%' 
%right '!'


%%

program: program globalVar  |
         program function 
         | ;

types: TK_PR_INT | TK_PR_FLOAT | TK_PR_BOOL | TK_PR_CHAR;
literalTypes: TK_LIT_INT | TK_LIT_FLOAT | TK_LIT_FALSE | TK_LIT_TRUE | TK_LIT_CHAR;

identifier: TK_IDENTIFICADOR { $$ = create_node_from_token(identifier, $1);};

globalVar: types identifier multoArray varList ';' ;
multoArray: '[' expression multoArrayList ']' | ; 
multoArrayList: multoArrayList '^' expression | ;
varList: varList ',' identifier multoArray | ;

function: functionHeader commandBlock;
functionHeader: types identifier '(' parameter parameterList ')';
parameter: types identifier | ;
parameterList: ',' types identifier parameterList | ;

command
	: variableDeclaration ';'
	| attribution ';'
	| functionCall ';'
	| returnCommand ';'
	| fluxControl ';'
	| commandBlock ';'
	| repetition ';'
	| returnCommand
	;

commandList: command commandList | ;
commandBlock: '{' commandList '}';

localVariable:
      identifier
    | identifier TK_OC_LE literalTypes;

localVariableList: ','  localVariable localVariableList | ;
variableDeclaration: types localVariable localVariableList;

attribution:
	  identifier multoArray '=' expression
	

functionCall
    : identifier '('expression expressionList')'
    | identifier '('')'

returnCommand: TK_PR_RETURN expression';'

expressionList: ',' expression expressionList | ;

expression: unary operando | mathExpression | '(' mathExpression ')';
mathExpression: expression operador operando;
operador: '+' | '-' | '/' | '*' | '%' | '<' | '>' | TK_OC_LE | TK_OC_GE | TK_OC_EQ | TK_OC_NE |
 TK_OC_AND | TK_OC_OR ;
unary: '-' | '!' | ;
operando: identifier multoArray | literalTypes | functionCall ;

fluxControl: TK_PR_IF '(' expression ')' TK_PR_THEN commandBlock else ;
else: TK_PR_ELSE commandBlock | ;

repetition: TK_PR_WHILE '(' expression ')' commandBlock;
%%

void yyerror (char const *s){
   printf ("line %d: %s\n", get_line_number(), s);
}