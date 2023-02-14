/* Bruna dos Santos Gonzaga - 00252743*/
/*Gabriel Tamusiunas Schumacker - 285648*/


%{
#include <stdio.h>
#include "math.h"
#include <stdbool.h>
#include "ast.h"
#include "parser.tab.h"

int num_lines = 1;

%}

%x COMMENT
%option noyywrap



white [ \t\r]+
digit [0-9]
integer {digit}+
float ({integer}"."{digit}+)((e|E){integer})?
letter [a-zA-Z]
identifier {letter}+


specialCharacter [,|;|:|\(|\)|\{|\}|\+|\-|\*||%|\^|<|>|=|!|\[|\]|/]

%%

{integer} {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
           yylval.valor_lexico.tipo_token = strdup("Literal");
 	   yylval.valor_lexico.tipo_token = strdup("Inteiro");
 	   yylval.valor_lexico.lit_int = atoi(yytext);
 	   yylval.text = strdup(yytext); 
	   return TK_LIT_INT; }
	    
{float} {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Literal");
 	 yylval.valor_lexico.tipo_token = strdup("Float");
 	 yylval.valor_lexico.lit_float = atof(yytext); 
 	 yylval.text = strdup(yytext);  
         return TK_LIT_FLOAT; }

"false" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Literal");
 	 yylval.valor_lexico.tipo_token = strdup("Boolean");
 	 yylval.valor_lexico.lit_bool = false;
 	 yylval.text = strdup(yytext);   
         return TK_LIT_FALSE;}
         
"true" { ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Literal");
 	 yylval.valor_lexico.tipo_token = strdup("Boolean");
 	 yylval.valor_lexico.lit_bool = true; 
 	 yylval.text = strdup(yytext);  
         return TK_LIT_TRUE;}

\'[^']\' {ValorLexico *temp = malloc(sizeof(ValorLexico));
         yylval.valor_lexico = *temp;
         yylval.valor_lexico.line_number = num_lines;
 	 yylval.valor_lexico.tipo_token = strdup("Literal");
 	 yylval.valor_lexico.tipo_token = strdup("Char");
 	 yylval.valor_lexico.lit_char = yytext[1]; 
 	 yylval.text = strdup(yytext);  
         return TK_LIT_CHAR;}


"int" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
      yylval.valor_lexico.valor_token = strdup(yytext);
      yylval.text = strdup(yytext);; 
      return TK_PR_INT;}
      
"float" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
         yylval.valor_lexico.valor_token = strdup(yytext);
         yylval.text = strdup(yytext); 
         return TK_PR_FLOAT;}

"bool" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
        yylval.valor_lexico.valor_token = strdup(yytext); 
        yylval.text = strdup(yytext); 
        return TK_PR_BOOL;}

"char" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
        yylval.valor_lexico.valor_token = strdup(yytext);
        yylval.text = strdup(yytext); 
        return TK_PR_CHAR;}


"if" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
      yylval.valor_lexico.valor_token = strdup(yytext);
      yylval.text = strdup(yytext); 
      return TK_PR_IF;}

"then" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
        yylval.valor_lexico.valor_token = strdup(yytext);
        yylval.text = strdup(yytext); 
        return TK_PR_THEN;}

"else" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
        yylval.valor_lexico.valor_token = strdup(yytext);
        yylval.text = strdup(yytext); 
        return TK_PR_ELSE;}

"while" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
         yylval.valor_lexico.valor_token = strdup(yytext);
         yylval.text = strdup(yytext); 
         return TK_PR_WHILE;}

"input" {yylval.valor_lexico.line_number = num_lines;
         yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
         yylval.valor_lexico.valor_token = strdup(yytext);
         yylval.text = strdup(yytext); 
         return TK_PR_INPUT;}

"output" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
          yylval.valor_lexico.valor_token = strdup(yytext);
          yylval.text = strdup(yytext); 
          return TK_PR_OUTPUT;}

"return" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Palavra reservada"); 
          yylval.valor_lexico.valor_token = strdup(yytext);
          yylval.text = strdup(yytext); 
          return TK_PR_RETURN;}

"for" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
       yylval.valor_lexico.tipo_token = strdup("Palavra reservada");
       yylval.valor_lexico.valor_token = strdup(yytext); 
       yylval.text = strdup(yytext); 
       return TK_PR_FOR;}


{white}	 {/* DO NOTHING */}    /* eats up whitespace */

{specialCharacter} {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
                    yylval.valor_lexico.tipo_token = strdup("Caractere Especial");
                    yylval.valor_lexico.valor_token = strdup(yytext);
                    yylval.text = strdup(yytext); 
                    return (int)*yytext;}

"<=" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Operador Composto");
      yylval.valor_lexico.valor_token = strdup(yytext);  
      yylval.text = strdup(yytext); 
      return TK_OC_LE;}
      
">=" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Operador Composto");
      yylval.valor_lexico.valor_token = strdup(yytext); 
      yylval.text = strdup(yytext); 
      return TK_OC_GE;}
      
"==" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Operador Composto");
      yylval.valor_lexico.valor_token = strdup(yytext); 
      yylval.text = strdup(yytext);   
      return TK_OC_EQ;}
      
"!=" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Operador Composto");
      yylval.valor_lexico.valor_token = strdup(yytext);
      yylval.text = strdup(yytext); 
      return TK_OC_NE;}
      
"&&" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Operador Composto");
      yylval.valor_lexico.valor_token = strdup(yytext); 
      yylval.text = strdup(yytext); 
      return TK_OC_AND;}
      
"||" {ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Operador Composto");
      yylval.valor_lexico.valor_token = strdup(yytext);
      yylval.text = strdup(yytext);  
      return TK_OC_OR;}

\n              { num_lines++;}

"//".*
"/*"			{ BEGIN(COMMENT); }
<COMMENT>\n		{ num_lines++; }
<COMMENT>.
<COMMENT>"*/"	{ BEGIN(INITIAL); }

{identifier} { 	ValorLexico *temp = malloc(sizeof(ValorLexico));
      yylval.valor_lexico = *temp;
      yylval.valor_lexico.line_number = num_lines;
      yylval.valor_lexico.tipo_token = strdup("Identificador");
		yylval.valor_lexico.valor_token = strdup(yytext);
		yylval.text = strdup(yytext); 
		return TK_IDENTIFICADOR;}

. {return TK_ERRO;}

%%

int get_line_number(){
  return num_lines;
}

