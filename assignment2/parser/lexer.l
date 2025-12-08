%{
#include "lexer.h"
#include "parser.h"

int linenum = 0;
%}

DIGIT       [0-9]
LETTER      [a-z]
WHITESPACE  [ \t]
COMMENT     \%.*$

%option noyywrap

%%
[A-Z_][a-zA-Z0-9]*                                              { return T_var;     }
(([2-9]|([12][0-9]?))|(3[0-6]))#[0-9a-zA-Z]+$|(-?[0-9]+)        { return T_integer; }
[a-z][a-zA-Z0-9_]*                                              { return T_atom;    }
\"([^\"]|\\\")*\"                                               { return T_string;  }
[\(\)\,\;\=\+\.\*]|->|<<|>>|=<                                  { return yytext[0]; }


--"begin"     { return T_begin; }
--"case"      { return T_case;  }
--"do"        { return T_do;    }
--"end"       { return T_end;   }
--"for"       { return T_for;   }
--"let"       { return T_let;   }
--"print"     { return T_print; }
--"if"        { return T_if;    }
--"of"        { return T_of;    }
--"then"      { return T_then;  }
--"else"      { return T_else;  }
--
--{LETTER}+       { return T_identifier; }
--{DIGIT}+        { return T_integer;    }
--{COMMENT}       { /* nothing */        }
--{WHITESPACE}+   { /* nothing */        }

'.*\n	        { linenum++; }
\n	            { linenum++; }


.        { printf("Unrecognized character %c in line %d\n", yytext[0], linenum); }

%%
void ERROR(const char msg[])
{
    fprintf(stderr, "ERROR: %s\n", msg);
    exit(1);
}
