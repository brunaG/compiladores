
%{
#include <stdio.h>
#include "parser.tab.h"
#include "math.h"
int num_lines = 1;
%}

%x COMMENT
%option noyywrap



white [ \t\r]+
digit [0-9]
integer [-+]?{digit}+
float ({integer}"."{digit}+)((e|E){integer})?
letter [a-z|A-Z]
identifier {letter}+


specialCharacter [,|;|:|\(|\)|\{|\}|\+|\-|\*||%|\^|<|>|=|!]

%%

{integer} { return TK_LIT_INT; }
{float} { return TK_LIT_FLOAT; }
"false" { return TK_LIT_FALSE;}
"true" { return TK_LIT_TRUE;}
\'[^']\' {return TK_LIT_CHAR;}


"int" {return TK_PR_INT;}
"float" { return TK_PR_FLOAT;}
"bool" { return TK_PR_BOOL;}
"char" {return TK_PR_CHAR;}


"if" { return TK_PR_IF;}
"then" { return TK_PR_THEN;}
"else" { return TK_PR_ELSE;}
"while" { return TK_PR_WHILE;}
"input" { return TK_PR_INPUT;}
"output" { return TK_PR_OUTPUT;}
"return" { return TK_PR_RETURN;}
"for" { return TK_PR_FOR;}

{white}	 {/* DO NOTHING */}    /* eats up whitespace */

{specialCharacter} {return (int)*yytext;}
"<=" { return TK_OC_LE;}
">=" { return TK_OC_GE;}
"==" { return TK_OC_EQ;}
"!=" { return TK_OC_NE;}
"&&" { return TK_OC_AND;}
"||" { return TK_OC_OR;}

\n              { num_lines++;}

"//".*
"/*"			{ BEGIN(COMMENT); }
<COMMENT>\n		{ num_lines++; }
<COMMENT>.
<COMMENT>"*/"	{ BEGIN(INITIAL); }

{identifier} {return TK_IDENTIFICADOR;}

. {return TK_ERRO;}

%%

int get_line_number(){
  return num_lines;
}

