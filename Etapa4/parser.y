// Bruna dos Santos Gonzaga - 00252743
// Gabriel Tamusiunas Schumacker - 00285648

%{
#include "stdio.h"
#include "stdlib.h"
#include <string.h>
#include "ast.h"

int yylex(void);
void yyerror (char const *s);

extern void *arvore;

int get_line_number();

%}

%define parse.lac full
%define parse.error verbose

%union {
   struct Node* node;
   struct ValorLexico valor_lexico;
   char* text;
}

%type<node> programstart
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
%type<node> commandList
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

programstart: program {arvore = $$;};

program: program globalVar {$$ =NULL;}
       | program function {
       		if($1 != NULL){
       			add_child($2,$1);
       		}
       		$$ = $2;
       		
       }
       | {$$= NULL;};

types: TK_PR_INT {$$ = create_node(yylval.valor_lexico,0,yylval.text);}
       | TK_PR_FLOAT {$$ = create_node(yylval.valor_lexico,0,yylval.text);} 
       | TK_PR_BOOL {$$ = create_node(yylval.valor_lexico,0,yylval.text);}
       | TK_PR_CHAR {$$ = create_node(yylval.valor_lexico,0,yylval.text);};
       
literalTypes: TK_LIT_INT {$$ = create_node(yylval.valor_lexico,0,yylval.text);}
 		| TK_LIT_FLOAT {$$ = create_node(yylval.valor_lexico,0,yylval.text);}
		| TK_LIT_FALSE {$$ = create_node(yylval.valor_lexico,0,yylval.text);}
		| TK_LIT_TRUE {$$ = create_node(yylval.valor_lexico,0,yylval.text);}
		| TK_LIT_CHAR {$$ = create_node(yylval.valor_lexico,0,yylval.text);};

identifier: TK_IDENTIFICADOR{$$ = create_node(yylval.valor_lexico,0,yylval.text);};

globalVar: types identifier multoArray varList ';' {$$ = NULL;};

multoArray: '[' expression multoArrayList ']' {
	Node *newNode = create_node(yylval.valor_lexico,3,yylval.text);
	add_child(newNode, $2);	
	if($3 != NULL){
        	add_child($2, $3);
        }
        $$ = newNode;
}
	| {$$ = NULL;};

multoArrayList: multoArrayList '^' expression {
        Node *newNode = create_node(yylval.valor_lexico,4,yylval.text);
        add_child(newNode, $3);
	if($1 != NULL){
        	add_child(newNode, $1);
	}
	$$ = newNode;
	
}	
	| {$$ = NULL;};

varList: varList ',' identifier multoArray {$$ = NULL;}		 
	| {$$ = NULL;};

function: functionHeader commandBlock
    {
       add_child($1, $2);
       $$ = $1;
    };

functionHeader: types identifier '(' parameter parameterList ')' { $$ = $2;};

parameter: types identifier {$$ =NULL;}| {$$ =NULL;};

parameterList: ',' types identifier parameterList {$$ =NULL;}| {$$ =NULL;};

command: 
	variableDeclaration ';' { $$ = $1;}
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
                if($1==NULL){
                        $$ = $2;
                }else{
                	if($2 != NULL)
                	    add_child($1,$2);
                	$$=$1;
                }	
                                
            }
             | { $$ = NULL; };

commandBlock: '{' commandList '}' { $$ = $2; } ;

localVariable:
      identifier {$$ =NULL;}
    | identifier '=' literalTypes {
   	Node *newNode = create_node(yylval.valor_lexico,1,yylval.text);	
	add_child(newNode,$1);
	add_child(newNode,$3);
	$$ = newNode;
    };

localVariableList: ','  localVariable localVariableList {
	if($3 != NULL){
		add_child($2,$3);	
	}
	$$ = $2;
}	
	| {$$ =NULL;};
	
variableDeclaration: types localVariable localVariableList {
	if($3 != NULL){
		if($2 == NULL){
			$$ = NULL;
		}else{
			$$ = $2;
		}
	}else{
		if($2 == NULL){
			$$ = $3;
		}else{
			add_child($2,$3);
			$$ = $2;
		}
	}
};

attribution: identifier multoArray '=' expression {
	Node *newNode = create_node(yylval.valor_lexico,2,yylval.text);
	if($2 != NULL){
		add_child($2,$1);
		add_child(newNode,$2);	
		add_child(newNode,$4);
	}else{
		add_child(newNode,$1);
		add_child(newNode,$4);	
	}
	$$ = newNode;
	
};
	

functionCall: identifier '('expression expressionList')' 
{
	Node *newNode = create_node(yylval.valor_lexico,0,yylval.text);	
	add_child($3,$4);
	add_child(newNode,$3);
	$$ = newNode;
}
    | identifier '('')' {$$ = $1;};

returnCommand: TK_PR_RETURN expression';'
                {
                     Node *newNode = create_node(yylval.valor_lexico,6,yylval.text);
                     add_child(newNode, $2);
                     $$ = newNode;
                };


expressionList: ',' expression expressionList {add_child($2,$3);
					       $$ = $2;}
		    | {$$ = NULL;};

expression: unary operando {
			    if($1 != NULL){
				add_child($1, $2);
		                $$ = $1;
		            }else{
		            	$$ = $2;
		            }}
          | mathExpression          { $$ = $1; }
          | unary
          | '(' mathExpression ')'  { $$ = $2; };

mathExpression: expression operador operando {add_child($2, $1);
				              add_child($2, $3);
				              $$ = $2;};

operador: '+'       { $$ = create_node(yylval.valor_lexico,9,yylval.text); }
        | '-'       { $$ = create_node(yylval.valor_lexico,9,yylval.text); }
        | '/'       { $$ = create_node(yylval.valor_lexico,9,yylval.text); }
        | '*'       { $$ = create_node(yylval.valor_lexico,9,yylval.text); }
        | '%'       { $$ = create_node(yylval.valor_lexico,9,yylval.text); }
        | '<'       { $$ = create_node(yylval.valor_lexico,9,yylval.text); }
        | '>'       { $$ = create_node(yylval.valor_lexico,9,yylval.text); }
        | TK_OC_LE  { $$ = create_node(yylval.valor_lexico,0,yylval.text); }
        | TK_OC_GE  { $$ = create_node(yylval.valor_lexico,0,yylval.text); }
        | TK_OC_EQ  { $$ = create_node(yylval.valor_lexico,0,yylval.text); }
        | TK_OC_NE  { $$ = create_node(yylval.valor_lexico,0,yylval.text); }
        | TK_OC_AND { $$ = create_node(yylval.valor_lexico,11,yylval.text); }
        | TK_OC_OR  { $$ = create_node(yylval.valor_lexico,10,yylval.text); }
        ;

unary: '-' { $$ = create_node(yylval.valor_lexico,0,yylval.text); }
      |'!' { $$ = create_node(yylval.valor_lexico,0,yylval.text); }
      | {$$= NULL;};

operando: identifier multoArray 
{             	  if($2 !=NULL){   
                     add_child($2, $1);
                     $$ = $2;
                  }else{
                     $$ = $1;
                  	
                  }
}
	| literalTypes {$$ = $1;}
	| functionCall {$$ = $1;};

fluxControl: TK_PR_IF '(' expression ')' TK_PR_THEN commandBlock else 
{
	Node *newNode = create_node(yylval.valor_lexico,7,yylval.text);
	add_child(newNode, $3);
	if($6 != NULL){
		add_child(newNode, $6);
	}
	if($7 != NULL){
		add_child(newNode, $7);	
	}
	$$ = newNode;
};

else: TK_PR_ELSE commandBlock { $$ = $2;} 
			| {$$ = NULL;};

repetition: TK_PR_WHILE '(' expression ')' commandBlock 
{ 	
	Node *newNode = create_node(yylval.valor_lexico,8,yylval.text);
	add_child(newNode, $3);
	add_child(newNode, $5);
	$$ = newNode; };
%%

void yyerror (char const *s){
   printf ("line %d: %s\n", get_line_number(), s);
}
