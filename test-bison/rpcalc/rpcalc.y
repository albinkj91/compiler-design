%{
    #include <stdio.h>
    int yylex (void);
    void yyerror(char const*);
%}

%define api.value.type {double}
%token NUM

%%
input: %empty | input line
     ;

line: '\n' | exp '\n'   { printf("%.10g\n", $1); }
    ;

exp: NUM
   | exp exp '+'    { $$ = $1 + $2;     }
   | exp exp '-'    { $$ = $1 - $2;     }
   | exp exp '*'    { $$ = $1 * $2;     }
   | exp exp '/'    { $$ = $1 / $2;     }
   | exp 'n'        { $$ = -$1;         }
   ;

%%

#include <ctype.h>
#include <stdlib.h>

int yylex (void)
{
    int c = getchar ();
    /* Skip white space. */
    while (c == ' ' || c == '\t')
        c = getchar ();

    /* Process numbers. */
    if (c == '.' || isdigit (c))
    {
        ungetc (c, stdin);
        if (scanf ("%lf", &yylval) != 1)
            abort ();
        return NUM;
    }
    /* Return end-of-input. */
    else if (c == EOF)
        return YYEOF;
    /* Return a single char. */
    else
        return c;
}

/* Called by yyparse on error. */
void yyerror (char const *s)
{
    fprintf (stderr, "%s\n", s);
}

int main(void)
{
    return yyparse();
}
