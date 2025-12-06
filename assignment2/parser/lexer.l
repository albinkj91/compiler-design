%{
#include "lexer.h"
#include "parser.h"

int linenum = 0;
%}

D [0-9]
L [a-z]
W [ \t]

%option noyywrap

%%

"begin"  { return T_begin; }
"do"     { return T_do; }
"end"    { return T_end; }
"for"    { return T_for; }
"let"    { return T_let; }
"print"  { return T_print; }
"if"     { return T_if; }
"then"   { return T_then; }
"else"   { return T_else; }

{L}+     { return T_identifier; }
{D}+     { return T_integer; }
{W}+     { /* nothing */ }

'.*\n	 { linenum++; }

\n	 { linenum++; }

[\+\*\=] { return yytext[0]; }

.        { printf("Unrecognized character %c in line %d\n", yytext[0], linenum); }

%%

