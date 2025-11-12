%{
#define T_eof       0
#define T_id        1
#define T_atom      2
#define T_integer   3
#define T_string    4
#define T_keyword   5
#define T_var       6

void ERROR (const char msg[]);


%}

KEYWORD case|of|end                                                     /* keywords   */
INTEGER ^(([2-9]|([12][0-9]?))|(3[0-6]))#[0-9a-zA-Z]+$|^(-?[0-9]+)$     /* integers   */
ATOM ^[a-z][a-zA-Z0-9_]*?$                                           /* atoms      */
STRING ^\"([^\"]|\\")*\"$                                              /* strings    */
VAR ^[A-Z_][a-zA-Z0-9]*$                                            /* variables  */
WHITESPACE [ \t\n]                                                         /* whitespace */

%option noyywrap

%%
(KEYWORD)     { return T_keyword; }
(INTEGER)     { return T_integer; }
(ATOM)        { return T_atom;    }
(STRING)      { return T_string;  }
(VAR)         { return T_var;     }
(WHITESPACE)+ { /* nothing */     }

.       { ERROR("illegal token"); }

%%

void ERROR(const char msg[])
{
    fprintf(stderr, "ERROR: %s\n", msg);
    exit(1);
}

int main()
{
    int token;

    do
    {
        token = yylex();
        printf("token=%d, lexeme=\"%s\"\n", token, yytext);
    }while(token != T_eof);
    
    return 0;
}
