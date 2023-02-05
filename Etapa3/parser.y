// Bruna dos Santos Gonzaga - 00252743
// Gabriel Tamusiunas Schumacker - 00285648

%{
#include "stdio.h"
#include "stdlib.h"
#include<string.h>
#include "ast.h"

int yylex(void);
void yyerror (char const *s);

int get_line_number();
%}

%define parse.lac full
%define parse.error verbose

%union {
   Node *node;
   valorLexico valor_lexico;
}

%type<node> program
%type<node> types
%type<node> literalTypes
%type<node> identifier
%type<node> globalVar
%type<node> multoArray
%type<node> multoArrayList
%type<node> varList
%type<node> functionHeader
%type<node> function
%type<node> parameter
%type<node> parameterList
%type<node> command
%type<nnodeo> commandList
%type<node> commandBlock
%type<node> localVariable
%type<node> localVariableList
%type<node> variableDeclaration
%type<node> attribution
%type<node> functionCall
%type<node> returnCommand
%type<node> expression
%type<node> expressionList
%type<node> operador
%type<node> unary
%type<node> operando
%type<node> fluxControl
%type<node> else
%type<node> repetition
%type<node> mathExpression


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

program: program globalVar
       | program function
       | ;

types: TK_PR_INT | TK_PR_FLOAT | TK_PR_BOOL | TK_PR_CHAR;
literalTypes: TK_LIT_INT | TK_LIT_FLOAT | TK_LIT_FALSE | TK_LIT_TRUE | TK_LIT_CHAR;

identifier: TK_IDENTIFICADOR;

globalVar: types identifier multoArray varList ';' ;

multoArray: '[' expression multoArrayList ']' | ;

multoArrayList: multoArrayList '^' expression | ;
varList: varList ',' identifier multoArray | ;

function: functionHeader commandBlock
    {
       add_child $1, $2);
       $$ = $1;
    };

functionHeader: types identifier '(' parameter parameterList ')' { $$ = add_node($2); };

parameter: types identifier | ;

parameterList: ',' types identifier parameterList | ;

command
	: variableDeclaration ';' { $$ = $1;}
	| attribution ';'         { $$ = $1;}
	| functionCall ';'        { $$ = $1;}
	| returnCommand ';'       { $$ = $1;}
	| fluxControl ';'         { $$ = $1;}
	| commandBlock ';'        { $$ = $1;}
	| repetition ';'          { $$ = $1;}
	| returnCommand           { $$ = $1;}
	;

commandList: command commandList
            {
                if($1==NULL) $$ = $2;
                else { add_child($1, $2); $$ = $1; }
            }
             | { $$ = NULL; };

commandBlock: '{' commandList '}' { $$ = $2; } ;

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
                {
                     Node *newNode = addNodeLabel("return");
                     add_child(newNode, $2);
                     $$ = newNode;
                };


expressionList: ',' expression expressionList | ;

expression: unary operando          { $$ = $1; }
          | mathExpression          { $$ = $1; }
          | '(' mathExpression ')'  { $$ = $1; };

mathExpression: expression operador operando;

operador: '+'       { $$ = add_node($1); }
        | '-'       { $$ = add_node($1); }
        | '*'       { $$ = add_node($1); }
        | '%'       { $$ = add_node($1); }
        | '<'       { $$ = add_node($1); }
        | '>'       { $$ = add_node($1); }
        | TK_OC_LE  { $$ = add_node($1); }
        | TK_OC_GE  { $$ = add_node($1); }
        | TK_OC_EQ  { $$ = add_node($1); }
        | TK_OC_NE  { $$ = add_node($1); }
        | TK_OC_AND { $$ = add_node($1); }
        | TK_OC_OR  { $$ = add_node($1); }
        ;

unary: '-' { $$ = add_node($1); }
      |'!' { $$ = add_node($1); }
      |
        ;

operando: identifier multoArray | literalTypes | functionCall ;

fluxControl: TK_PR_IF '(' expression ')' TK_PR_THEN commandBlock else ;
else: TK_PR_ELSE commandBlock | ;

repetition: TK_PR_WHILE '(' expression ')' commandBlock;
%%

void yyerror (char const *s){
   printf ("line %d: %s\n", get_line_number(), s);
}
